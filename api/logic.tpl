package {{.pkgName}}

import (
{{.imports}}
)

var _ = logx.SevereLevel // cannot remove import for logx

func {{.function}}(service *svc.ServiceContext) func(ctx context.Context, {{.request}}) {{.responseType}} {
    return service.Deps.I{{.pkgName}}().{{.function}}
}