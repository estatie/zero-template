package svc

import {{.authImport}}
import "github.com/estatie/id/pkg/auth/jwt"
import "github.com/estatie/pet/pkg/entex"
import "github.com/estatie/pet/pkg/zero"

type Config struct {
rest.RestConf
Instance zero.Instance
Mysql entex.MysqlConf
Jwt jwt.Config
{{.auth}}
{{.jwtTrans}}
}