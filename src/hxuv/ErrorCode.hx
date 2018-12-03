package hxuv;

import hxuv.Status;

@:enum
extern abstract ErrorCode(StatusCode) to StatusCode {
	#if cpp @:native('UV_E2BIG')           #end var E2BIG           #if lua = 'E2BIG'           #end ;
	#if cpp @:native('UV_EACCES')          #end var EACCES          #if lua = 'EACCES'          #end ;
	#if cpp @:native('UV_EADDRINUSE')      #end var EADDRINUSE      #if lua = 'EADDRINUSE'      #end ;
	#if cpp @:native('UV_EADDRNOTAVAIL')   #end var EADDRNOTAVAIL   #if lua = 'EADDRNOTAVAIL'   #end ;
	#if cpp @:native('UV_EAFNOSUPPORT')    #end var EAFNOSUPPORT    #if lua = 'EAFNOSUPPORT'    #end ;
	#if cpp @:native('UV_EAGAIN')          #end var EAGAIN          #if lua = 'EAGAIN'          #end ;
	#if cpp @:native('UV_EAI_ADDRFAMILY')  #end var EAI_ADDRFAMILY  #if lua = 'EAI_ADDRFAMILY'  #end ;
	#if cpp @:native('UV_EAI_AGAIN')       #end var EAI_AGAIN       #if lua = 'EAI_AGAIN'       #end ;
	#if cpp @:native('UV_EAI_BADFLAGS')    #end var EAI_BADFLAGS    #if lua = 'EAI_BADFLAGS'    #end ;
	#if cpp @:native('UV_EAI_BADHINTS')    #end var EAI_BADHINTS    #if lua = 'EAI_BADHINTS'    #end ;
	#if cpp @:native('UV_EAI_CANCELED')    #end var EAI_CANCELED    #if lua = 'EAI_CANCELED'    #end ;
	#if cpp @:native('UV_EAI_FAIL')        #end var EAI_FAIL        #if lua = 'EAI_FAIL'        #end ;
	#if cpp @:native('UV_EAI_FAMILY')      #end var EAI_FAMILY      #if lua = 'EAI_FAMILY'      #end ;
	#if cpp @:native('UV_EAI_MEMORY')      #end var EAI_MEMORY      #if lua = 'EAI_MEMORY'      #end ;
	#if cpp @:native('UV_EAI_NODATA')      #end var EAI_NODATA      #if lua = 'EAI_NODATA'      #end ;
	#if cpp @:native('UV_EAI_NONAME')      #end var EAI_NONAME      #if lua = 'EAI_NONAME'      #end ;
	#if cpp @:native('UV_EAI_OVERFLOW')    #end var EAI_OVERFLOW    #if lua = 'EAI_OVERFLOW'    #end ;
	#if cpp @:native('UV_EAI_PROTOCOL')    #end var EAI_PROTOCOL    #if lua = 'EAI_PROTOCOL'    #end ;
	#if cpp @:native('UV_EAI_SERVICE')     #end var EAI_SERVICE     #if lua = 'EAI_SERVICE'     #end ;
	#if cpp @:native('UV_EAI_SOCKTYPE')    #end var EAI_SOCKTYPE    #if lua = 'EAI_SOCKTYPE'    #end ;
	#if cpp @:native('UV_EALREADY')        #end var EALREADY        #if lua = 'EALREADY'        #end ;
	#if cpp @:native('UV_EBADF')           #end var EBADF           #if lua = 'EBADF'           #end ;
	#if cpp @:native('UV_EBUSY')           #end var EBUSY           #if lua = 'EBUSY'           #end ;
	#if cpp @:native('UV_ECANCELED')       #end var ECANCELED       #if lua = 'ECANCELED'       #end ;
	#if cpp @:native('UV_ECHARSET')        #end var ECHARSET        #if lua = 'ECHARSET'        #end ;
	#if cpp @:native('UV_ECONNABORTED')    #end var ECONNABORTED    #if lua = 'ECONNABORTED'    #end ;
	#if cpp @:native('UV_ECONNREFUSED')    #end var ECONNREFUSED    #if lua = 'ECONNREFUSED'    #end ;
	#if cpp @:native('UV_ECONNRESET')      #end var ECONNRESET      #if lua = 'ECONNRESET'      #end ;
	#if cpp @:native('UV_EDESTADDRREQ')    #end var EDESTADDRREQ    #if lua = 'EDESTADDRREQ'    #end ;
	#if cpp @:native('UV_EEXIST')          #end var EEXIST          #if lua = 'EEXIST'          #end ;
	#if cpp @:native('UV_EFAULT')          #end var EFAULT          #if lua = 'EFAULT'          #end ;
	#if cpp @:native('UV_EFBIG')           #end var EFBIG           #if lua = 'EFBIG'           #end ;
	#if cpp @:native('UV_EHOSTUNREACH')    #end var EHOSTUNREACH    #if lua = 'EHOSTUNREACH'    #end ;
	#if cpp @:native('UV_EINTR')           #end var EINTR           #if lua = 'EINTR'           #end ;
	#if cpp @:native('UV_EINVAL')          #end var EINVAL          #if lua = 'EINVAL'          #end ;
	#if cpp @:native('UV_EIO')             #end var EIO             #if lua = 'EIO'             #end ;
	#if cpp @:native('UV_EISCONN')         #end var EISCONN         #if lua = 'EISCONN'         #end ;
	#if cpp @:native('UV_EISDIR')          #end var EISDIR          #if lua = 'EISDIR'          #end ;
	#if cpp @:native('UV_ELOOP')           #end var ELOOP           #if lua = 'ELOOP'           #end ;
	#if cpp @:native('UV_EMFILE')          #end var EMFILE          #if lua = 'EMFILE'          #end ;
	#if cpp @:native('UV_EMSGSIZE')        #end var EMSGSIZE        #if lua = 'EMSGSIZE'        #end ;
	#if cpp @:native('UV_ENAMETOOLONG')    #end var ENAMETOOLONG    #if lua = 'ENAMETOOLONG'    #end ;
	#if cpp @:native('UV_ENETDOWN')        #end var ENETDOWN        #if lua = 'ENETDOWN'        #end ;
	#if cpp @:native('UV_ENETUNREACH')     #end var ENETUNREACH     #if lua = 'ENETUNREACH'     #end ;
	#if cpp @:native('UV_ENFILE')          #end var ENFILE          #if lua = 'ENFILE'          #end ;
	#if cpp @:native('UV_ENOBUFS')         #end var ENOBUFS         #if lua = 'ENOBUFS'         #end ;
	#if cpp @:native('UV_ENODEV')          #end var ENODEV          #if lua = 'ENODEV'          #end ;
	#if cpp @:native('UV_ENOENT')          #end var ENOENT          #if lua = 'ENOENT'          #end ;
	#if cpp @:native('UV_ENOMEM')          #end var ENOMEM          #if lua = 'ENOMEM'          #end ;
	#if cpp @:native('UV_ENONET')          #end var ENONET          #if lua = 'ENONET'          #end ;
	#if cpp @:native('UV_ENOPROTOOPT')     #end var ENOPROTOOPT     #if lua = 'ENOPROTOOPT'     #end ;
	#if cpp @:native('UV_ENOSPC')          #end var ENOSPC          #if lua = 'ENOSPC'          #end ;
	#if cpp @:native('UV_ENOSYS')          #end var ENOSYS          #if lua = 'ENOSYS'          #end ;
	#if cpp @:native('UV_ENOTCONN')        #end var ENOTCONN        #if lua = 'ENOTCONN'        #end ;
	#if cpp @:native('UV_ENOTDIR')         #end var ENOTDIR         #if lua = 'ENOTDIR'         #end ;
	#if cpp @:native('UV_ENOTEMPTY')       #end var ENOTEMPTY       #if lua = 'ENOTEMPTY'       #end ;
	#if cpp @:native('UV_ENOTSOCK')        #end var ENOTSOCK        #if lua = 'ENOTSOCK'        #end ;
	#if cpp @:native('UV_ENOTSUP')         #end var ENOTSUP         #if lua = 'ENOTSUP'         #end ;
	#if cpp @:native('UV_EPERM')           #end var EPERM           #if lua = 'EPERM'           #end ;
	#if cpp @:native('UV_EPIPE')           #end var EPIPE           #if lua = 'EPIPE'           #end ;
	#if cpp @:native('UV_EPROTO')          #end var EPROTO          #if lua = 'EPROTO'          #end ;
	#if cpp @:native('UV_EPROTONOSUPPORT') #end var EPROTONOSUPPORT #if lua = 'EPROTONOSUPPORT' #end ;
	#if cpp @:native('UV_EPROTOTYPE')      #end var EPROTOTYPE      #if lua = 'EPROTOTYPE'      #end ;
	#if cpp @:native('UV_ERANGE')          #end var ERANGE          #if lua = 'ERANGE'          #end ;
	#if cpp @:native('UV_EROFS')           #end var EROFS           #if lua = 'EROFS'           #end ;
	#if cpp @:native('UV_ESHUTDOWN')       #end var ESHUTDOWN       #if lua = 'ESHUTDOWN'       #end ;
	#if cpp @:native('UV_ESPIPE')          #end var ESPIPE          #if lua = 'ESPIPE'          #end ;
	#if cpp @:native('UV_ESRCH')           #end var ESRCH           #if lua = 'ESRCH'           #end ;
	#if cpp @:native('UV_ETIMEDOUT')       #end var ETIMEDOUT       #if lua = 'ETIMEDOUT'       #end ;
	#if cpp @:native('UV_ETXTBSY')         #end var ETXTBSY         #if lua = 'ETXTBSY'         #end ;
	#if cpp @:native('UV_EXDEV')           #end var EXDEV           #if lua = 'EXDEV'           #end ;
	#if cpp @:native('UV_UNKNOWN')         #end var UNKNOWN         #if lua = 'UNKNOWN'         #end ;
	#if cpp @:native('UV_EOF')             #end var EOF             #if lua = 'EOF'             #end ;
	#if cpp @:native('UV_ENXIO')           #end var ENXIO           #if lua = 'ENXIO'           #end ;
	#if cpp @:native('UV_EMLINK')          #end var EMLINK          #if lua = 'EMLINK'          #end ;
	
	#if linc_uv
	public static inline function getName(error:Int):String return uv.Uv.err_name(error);
	public static inline function toString(error:Int):String return uv.Uv.strerror(error);
	#end
}
