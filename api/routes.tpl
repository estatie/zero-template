// Code generated by goctl. DO NOT EDIT.
package web

import (
"net/http"{{if .hasTimeout}}
"time"{{end}}

{{.importPackages}}
)

func RegisterHandlers(server *rest.Server, serverCtx *svc.ServiceContext) {
{{.routesAdditions}}
}