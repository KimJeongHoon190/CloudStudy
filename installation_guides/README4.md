## Kubernetes 설치 방법
### 준비물 : kube-controller, kube-worker-node1, kube-workwer-node2 총 3개 서버 

### 모든 3개 서버에서 진행 : 1~14 단계
#### 1. 업데이트 및 재부팅
```bash
sudo apt-get update && sudo apt-get -y full-upgrade
sudo reboot -f ## 이 명령어 누르고 엔터 쳐라(끝까지 기다릴 필요없다)
```

#### 2. 본격적인 설치 전에 필요한 패키지 설치
```bash
sudo apt-get -y install curl gnupg2 software-properties-common apt-transport-https ca-certificates
```

#### 3. 도커 리포지토리 등록
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

#### 4. 쿠버네티스 리포지토리 등록
```bash
curl -fsSL https://dl.k8s.io/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

#### 5. 리포지토리 업데이트 진행
```bash
sudo apt update -y
```

#### 6. 컨테이너 런타임 설치 
```bash
sudo apt install -y containerd.io
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml > /dev/null
```

#### 7. 쿠버네티스 설치
```bash
sudo apt -y install kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```

#### 8. 스왑 비활성화
```bash
sudo sed -i '/swap/s/^/#/' /etc/fstab
sudo swapoff -a
sudo mount -a
```

#### 9. 커널 기능 설정 변경
```bash
sudo su - -c "echo 'net.bridge.bridge-nf-call-ip6tables = 1' >> /etc/sysctl.d/kubernetes.conf"
sudo su - -c "echo 'net.bridge.bridge-nf-call-iptables = 1' >> /etc/sysctl.d/kubernetes.conf"
sudo su - -c "echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.d/kubernetes.conf"
```

#### 10. 커널 모듈 로드 설정
```bash
sudo su - -c "echo 'overlay' >> /etc/modules-load.d/containerd.conf"
sudo su - -c "echo 'br_netfilter' >> /etc/modules-load.d/containerd.conf"
```

#### 11. 커널 모듈 및 설정 활성화
```bash
sudo modprobe overlay
sudo modprobe br_netfilter
sudo sysctl --system
```

#### 12. 서비스 활성화
```bash
sudo systemctl restart containerd
sudo systemctl enable containerd
sudo systemctl restart kubelet
sudo systemctl enable kubelet
sudo ufw disable
```

#### 13. 모든 서버에서 /etc/hosts 파일 수정
```bash
모든 서버에서 kube-controller 및 worker-node 2개의 IP 주소와 Hostname 정보를 등록한다.

sudo vi /etc/hosts
cat /etc/hosts

-->

127.0.0.1       localhost
# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost   ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts
127.0.1.1       ubuntu-focal    ubuntu-focal

192.168.10.11 kube-controller # 여기
192.168.10.12 kube-worker-node1 # 여기
192.168.10.13 kube-worker-node2 # 여기
# 바로 위 세 줄을 넣으라는 뜻이다.
127.0.2.1 kube-controller kube-controller
```

#### 14. 통신확인
```bash
각각의 서버에서
ping kube-controller
ping kube-worker-node1
ping kube-worker-node2
해서 통신이 가능해야한다.
```
### kube-controller에서만 진행 : 15~20 단계

#### 15. kube-controller에 쿠버네티스 관련 이미지 설치
```bash
sudo kubeadm config images pull
```

#### 16. kubeadm으로 부트스트랩 진행
```bash
sudo kubeadm init --apiserver-advertise-address 192.168.10.11 \           
 --pod-network-cidr 172.30.0.0/16 --upload-certs \
 --control-plane-endpoint kube-controller
 # 클러스터 초기 설정 명령어라 계속 쓰면 큰일난다. 왜냐하면 이 명령어를 실행할 때마다
 # 토큰이 계속 새로 발급되기 때문이다.
```

#### 17. 부트스트랩 완료 후 현재 계정으로 kubectl 명령을 사용할 수 있도록 설정
```bash
#16번 단계를 실행할 때마다 이 17번 단계를 해야한다.
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

#### 18. 리부트
```bash
sudo reboot -f
```

#### 19. 쿠버네티스의 컨테이너 네트워크 인터페이스 설치 및 파일 다운로드(CNI)
```bash
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
wget https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml
```

#### 20. 네트워크 설정 변경 후 설치
```bash
sed -i 's/cidr: 192\.168\.0\.0\/16/cidr: 172\.30\.0\.0\/16/g' custom-resources.yaml
sudo vi custom-resources.yaml
# spec: 아래에 registry: quay.io/ 추가(띄어쓰기 두 칸 필요) --> 도커 말고 여기서 이미지 다운로드 받는다
```
```bash
vagrant@kube-controller:~$ cat custom-resources.yaml 
# This section includes base Calico installation configuration.
# For more information, see: https://projectcalico.docs.tigera.io/master/reference/installation/api#operator.tigera.io/v1.Installation
apiVersion: operator.tigera.io/v1
kind: Installation
metadata:
  name: default
spec:
  registry: quay.io/
  # Configures Calico networking.
  calicoNetwork:
    # Note: The ipPools section cannot be modified post-install.
    ipPools:
    - blockSize: 26
      cidr: 172.30.0.0/16
      encapsulation: VXLANCrossSubnet
      natOutgoing: Enabled
      nodeSelector: all()
```
```bash
vagrant@kube-controller:~$ kubectl create -f custom-resources.yaml
installation.operator.tigera.io/default created
apiserver.operator.tigera.io/default created


vagrant@kube-controller:~$ kubectl get nodes
NAME              STATUS     ROLES           AGE   VERSION
kube-controller   NotReady   control-plane   11m   v1.27.4 #아직 안됨


vagrant@kube-controller:~$ kubectl get nodes
NAME              STATUS   ROLES           AGE   VERSION
kube-controller   Ready    control-plane   14m   v1.27.4  #이렇게 Ready 상태가 뜨는데 시간 오래 걸린다.
```
### worker-node 1,2 두 서버에서만 각각 진행 : 21단계

#### 21. worker-node join 시키기
```bash
# 16단계의 sudo kubeadm init 명령을 칠 때마다 토큰이 생성되는데 총 두 개다.
# 첫번째는 클러스터에 새롭게 가입시킬 kube-controller용이고 두번째가
# 클러스터에 새롭게 가입시킬 worker-node용이다. 따라서 두 번째 토큰을 복사해서 다음 명령에 붙여라.
# 참고로 토큰은 sudo kubeadm init 명령을 쓸 때마다 랜덤으로 생성되는 것이기 떄문에
# 아래 명령어를 복붙해봐야 소용없다.
sudo kubeadm join kube-controller:6443 --token chvvj4.i84azx1lkm98gumm \
        --discovery-token-ca-cert-hash sha256:0d741e8df7357071ce0de7e39bfd5503ed0ea66bbb0d1baa6a6b0683f80b9075
```
#### 22. 다시 kube-controller로 돌아가서 실행
```bash
# 어느 정도 시간이 지나고
kubectl get nodes # 이 명령어를 실행하면

vagrant@kube-controller:~$ kubectl get nodes
NAME                STATUS   ROLES           AGE   VERSION
kube-controller     Ready    control-plane   27m   v1.27.4
kube-worker-node1   Ready    <none>          79s   v1.27.4
kube-worker-node2   Ready    <none>          61s   v1.27.4
# kube-controller 뿐만 아니라 다른 노드들도 Ready 상태가 뜬 것을 볼 수 있다.
```
```bash
#다른 파워셀을 띄우고 kube-controller로 접속
watch -n 1 "kubectl get nodes && kubectl get pods --all-namespaces" 
#모든 노드를 보여주고 모든 네임스페이스의 파드들을 보여달라
#잠시만 기다리면 모든 상태가 Running으로 바뀌는 걸 볼 수 있다.
```






