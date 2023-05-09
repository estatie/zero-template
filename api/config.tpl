package svc

import {{.authImport}}
import "github.com/estatie/goctl-pet/pkg/enter"

type Config struct {
	rest.RestConf
	Mysql enter.MysqlConf
	{{.auth}}
	{{.jwtTrans}}
}