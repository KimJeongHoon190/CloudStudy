
try:
    f = open('/vagrant/test.txt', mode='r', encoding='utf-8')
    data = f.read()
except UnicodeDecodeError:
    f = open('/vagrant/test.txt', mode='r', encoding='cp949')
    data = f.read()


print(data)
