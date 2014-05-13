class puppet-sshd {
        sshd_config{ puppet: 
                permitrootlogin => "no"
        }
}

define sshd_config($permitrootlogin) {
        file { "/etc/ssh/sshd_config":
                path    => "/etc/ssh/sshd_config",
                owner   => root,
                group   => root,
                mode    => 600,
                content => template("puppet-sshd/sshd_config.erb"),
                notify  => Service[sshd],
        }

        service { sshd:
                ensure    => running,
                enable    => true,
                restart   => "/sbin/service sshd restart",
                subscribe => File['/etc/ssh/sshd_config'],

        }
}
