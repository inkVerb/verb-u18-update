$TTL    86400
hostdomain286.		IN  SOA		DNSID286.DNSDOMAIN286. root.hostdomain286. (
0000000001		; Serial No
10800			; Refresh
3600			; Retry
604800			; Expire
1800 )			; Minimum TTL

$ORIGIN hostdomain286.
; Nameserver Defaults
@		IN  NS		ns1.DNSDOMAIN286.
@		IN  NS		ns2.DNSDOMAIN286.
@		IN  NS		ns3.DNSDOMAIN286.

; Root Site Defaults
@		IN  A		hostip286
@		IN  AAAA	hostipv6286
*.hostdomain286.		IN  A		hostip286
*.hostdomain286.		IN  AAAA	hostipv6286
;; End Root Site Defaults

; Hostname Record Defaults
ink.hostdomain286.		IN  A		hostip286
ink.hostdomain286.		IN  AAAA	hostipv6286
ask.hostdomain286.		IN  A		hostip286
ask.hostdomain286.		IN  AAAA	hostipv6286
bb.hostdomain286.		IN  A		hostip286
bb.hostdomain286.		IN  AAAA	hostipv6286
blog.hostdomain286.		IN  A		hostip286
blog.hostdomain286.		IN  AAAA	hostipv6286
code.hostdomain286.		IN  A		hostip286
code.hostdomain286.		IN  AAAA	hostipv6286
home.hostdomain286.		IN  A		hostip286
home.hostdomain286.		IN  AAAA	hostipv6286
pen.hostdomain286.		IN  A		hostip286
pen.hostdomain286.		IN  AAAA	hostipv6286
shop.hostdomain286.		IN  A		hostip286
shop.hostdomain286.		IN  AAAA	hostipv6286
sn.hostdomain286.		IN  A		hostip286
sn.hostdomain286.		IN  AAAA	hostipv6286
wiki.hostdomain286.		IN  A		hostip286
wiki.hostdomain286.		IN  AAAA	hostipv6286

; Aliase Default
*.hostdomain286.		IN  CNAME	hostdomain286.
www.hostdomain286.		IN  CNAME	hostdomain286.

; Text Record Defaults
hostdomain286.		IN  TXT		"v=spf1 mx a ip4:hostip286 ip6:hostipv6286 include:mailURI286 include:_spf.google.com include:spf.protection.outlook.com include:_spf.mail.yahoo.com ~all"
_dmarc.hostdomain286.		IN  TXT		"v=DMARC1; p=none; sp=reject; fo=0s; aspf=r; adkim=s; ri=86400; rua=mailto:dmark@nameURI286,mailto:dmark-sitename286-sitetld286@inkisaverb.com; ruf=mailto:dmark@nameURI286,mailto:dmark-sitename286-sitetld286@inkisaverb.com"