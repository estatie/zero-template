package config

import {{.authImport}}
import "github.com/estatie/pet/pkg/enter"

type Config struct {
	rest.RestConf
	Mysql enter.MysqlConf
	{{.auth}}
	{{.jwtTrans}}
}