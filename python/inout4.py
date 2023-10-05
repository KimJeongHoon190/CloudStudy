f = open('/etc/passwd', mode = 'r')
data = f.readlines()

for line in data:
    print(line, end = '')
