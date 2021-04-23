# manage_users
manage user creation

this creates the user, and default group allows to manage home and .ssh
also, moves the .files in from skel
sets password and ssh keys.

also, pinned uid/gid as having those make sense across the infrastructure is a good thing.


include the class and add a hiera hash of users.
also, since this is deep merge, the hash can be built across the hierarchy.


###example hiera: ( in yaml )

`manage_users::user_hash:`
`  testuser1:`
`    ensure: 'present'`
`    uid: '1100'`
`    gid: '1100'`
`    group_array:`
`     - 'wheel'`
`    home: '/home/testuser1'`
`    shell: '/bin/bash'`
`    password: ' --------------------------- redacted ------------------------'`
`    ssh_id_rsa_pub: ' -------------------  redacted -------------------------'`
`    ssh_id_rsa: '-----BEGIN RSA PRIVATE KEY----   ---------------- redacted -----------------   -----END RSA PRIVATE KEY-----'`


I could still talk myself into moving the keys and password into the sensative data type.. 
Also, really would want to store them with eyaml in a real world setup.

With this, I can move the include into common and drop users anywhere in the hierarchy they would need to be made.

