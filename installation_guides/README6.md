### 1\. APT 업데이트

```
sudo apt update
# 먼저 시스템 패키지 목록을 업데이트한다.
```

### 2\. unzip 명령어 다운로드

```
sudo apt install unzip 
```

### 3\. Terraform 다운로드

```
TERRAFORM_VERSION="1.6.2"
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
# 테라폼 공식 웹사이트에서 최신 버전의 URL 얻을 수 있다. releases.hashicorp.com
```

### 4\. 압축 해제

```
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
```

### 5\. Terraform 실행 파일 이동

```
sudo mv terraform /usr/local/bin/
# 압축 해제한 Terraform 실행 파일을 실행 가능한 디렉토리로 이동시키기
```

### 6\. 버전 확인

```
terraform --version
# Terraform 설치가 완료되었는지 확인
```

---

### 1\. 새 디렉토리 만들기

```
mkdir my_terraform_project
cd my_terraform_project
```

### 2\. Terraform 초기화

```
terraform init
```