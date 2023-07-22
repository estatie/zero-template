Name: {{.serviceName}}
Host: {{.host}}
Port: {{.port}}
Instance:
  Server: false
  Worker: true
Mysql:
  Driver: sqlite3 # use mysql or in-memory sqlite3
  User: root
  Passwd: your-password
  Addr: localhost:30004
  Dbname: iam
  MaxConnections: 100
Jwt:
  Secret: do-not-use-the-secret-in-production
Mail:
  Debug: true
  From: postmaster@yourdomain.com
  Pass: nopass
  Host: localhost
  Port: 31025
  Name: YourCompany
  Link: https://yourdomain.com
  Copyright: © 2023 YourCompany
  TroubleText: Trouble signing in? Just reply to this email and we'll help you out.