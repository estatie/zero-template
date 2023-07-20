package svc

import {{.authImport}}
import "github.com/estatie/pet/pkg/entex"

type Config struct {
	rest.RestConf
	Mysql entex.MysqlConf
	JwtSecret string
	{{.auth}}
	{{.jwtTrans}}
}