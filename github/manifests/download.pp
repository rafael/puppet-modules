# This definitions assumes that the path where you are going to install the
# has been already created. 

define github::download($user, $path_to_install, $repo_name, $clone_adress) {

  Exec{
    path => [ "/bin"
            , "/usr/bin" ],
  }

  exec {"download-noomii-repo-for-$folder_name":
    cwd => $cwd,
    user => $user,
    logoutput => true,
    command => "git clone $clone_adress $folder_name --recursive",
    creates => "$path_to_install/$repo_name",
    timeout => 3600,
    require => Class["git::install"],
  }
}
