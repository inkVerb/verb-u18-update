Thanks: http://www.lorier.net/docs/ssh-ca

# Prepare the CA
## On the CA
CA
ssh-keygen -N "" -f /etc/ssh/ca
mkdir /etc/ssh/ca-clients

# Authenticate the Host to the Client via cert-authority
## On the CA

ssh-keygen -s /etc/ssh/ca \
     -I "$(hostname --fqdn) host key" \
     -n "$(hostname --fqdn)" \
     -V -5m:+3650d \
     -h \
     /etc/ssh/ssh_host_rsa_key.pub \
     /etc/ssh/ssh_host_dsa_key.pub \
     /etc/ssh/ssh_host_ecdsa_key.pub \
     /etc/ssh/ssh_host_ed25519_key.pub

echo "HostCertificate /etc/ssh/ssh_host_rsa_key-cert.pub" >> /etc/ssh/sshd_config
echo "HostCertificate /etc/ssh/ssh_host_dsa_key-cert.pub" >> /etc/ssh/sshd_config
echo "HostCertificate /etc/ssh/ssh_host_ecdsa_key-cert.pub" >> /etc/ssh/sshd_config
echo "HostCertificate /etc/ssh/ssh_host_ed25519_key-cert.pub" >> /etc/ssh/sshd_config

## On the CLIENT
#### NOTE: Copy ca.pub to from the CA to the CLIENT, still in /etc/ssh/
### System-Wide
echo "@cert-authority * $(cat /etc/ssh/ca.pub)" >> /etc/ssh/ssh_known_hosts
### Per-User
echo "@cert-authority * $(cat /etc/ssh/ca.pub)" >> ~/.ssh/known_hosts

# Authenticate the Client to the Host via cert-authority
## On the CA
#### NOTE: Copy the following files to the CA in /etc/ssh/ca-clients/
#####    ~/.ssh/id_rsa.pub
#####    ~/.ssh/id_dsa.pub
#####    ~/.ssh/id_ecdsa.pub
#####    ~/.ssh/id_ed25519.pub

ssh-keygen -s /etc/ssh/ca \
    -I "$(whoami)@$(hostname --fqdn) user key" \
    -n "$(whoami)" \
    -V -5m:+3650d \
    /etc/ssh/ca-clients/id_rsa.pub \
    /etc/ssh/ca-clients/id_dsa.pub \
    /etc/ssh/ca-clients/id_ecdsa.pub \
    /etc/ssh/ca-clients/id_ed25519.pub
#### NOTE: Copy the new *-cert.pub files back to the CLIENT: ~/.ssh/
#####    /etc/ssh/ca-clients/id_rsa-cert.pub \
#####    /etc/ssh/ca-clients/id_dsa-cert.pub \
#####    /etc/ssh/ca-clients/id_ecdsa-cert.pub \
#####    /etc/ssh/ca-clients/id_ed25519-cert.pub

### System-Wide
#### NOTE: The Principals settings are important, otherwise the principal must match the login user.
echo "AuthorizedPrincipalsFile %h/.ssh/authorized_principals" >>/etc/ssh/sshd_config
echo "TrustedUserCAKeys /etc/ssh/ca.pub" >>/etc/ssh/sshd_config
echo $(whoami) > ~/.ssh/authorized_principals
### Per-User
echo "cert-authority,principals=$(whoami) $(cat /etc/ssh/ca.pub)" >> ~/.ssh/authorized_keys
echo "cert-authority,principals=$(whoami) $(cat /etc/ssh/ca.pub)" >> /etc/ssh/authorized_keys/$USER


# Revoking Keys
## On CA
### System-Wide
echo "RevokedKeys /etc/ssh/revoked_keys" >>/etc/ssh/sshd_config
ssh-keygen -k -f /etc/ssh/revoked_keys $public_key_to_revoke
ssh-keygen -k -u -f /etc/ssh/revoked_keys $additional_public_keys_to_revoke
#### OR
echo "RevokedKeys /etc/ssh/revoked_keys" >>/etc/ssh/sshd_config
echo @revoked $(cat $public_key_to_revoke) >> /etc/ssh/revoked_keys
### Per-User
echo @revoked $(cat $public_key_to_revoke) >>~/.ssh/known_hosts


# SSH Identity Keys
## On CLIENT
### ssh_config:
Host *.example.com
   IdentifyFile ~/.ssh/id_dsa
### .ssh/config
Thanks: http://stackoverflow.com/questions/2419566/best-way-to-use-multiple-ssh-private-keys-on-one-client
Host friendly-name
	HostName long.and.cumbersome.server.name
	IdentityFile ~/.ssh/private_ssh_file
	User username-on-remote-machine

Host friendly-name-also
	HostName long.and.cumbersome.server.name.also
	IdentityFile ~/.ssh/private_ssh_file_also
	User username-on-remote-machine-also

