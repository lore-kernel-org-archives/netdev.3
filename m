Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489696;
	b=yQT2HNf94wlwJJGP9MKxKaTr2wYf29O6zjXRA4Sonk3SSsJf7mx67AawnamrM7lRAta7
	 olIkYkPv4eymanulnIYrkemqHij3RTm9csPBVXEWYXRZ4W5RJQ5tEAriAc3IfBehGqkGi
	 /mlRbtMRXcJeofzQQTQtPIJyvmhmdkZSvihLKe1BhymNxgLs4m//7CsvAQhxYkLwbdmze
	 oL7K6wyqPAVuVT66MUBRbSHIe4So15qLv3GkGgriS/2hMBRsqNDvarwtfd5CCyJG9PX/A
	 YjSYZmr0P9KS2IjidySnDldtb46pIMltZ7ldQArKrrDKOY3pVTv3u9TrUtC+qsLL/lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489696;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:Content-Type:User-Agent:MIME-Version:X-SRS-Rewrite;
	bh=H/0sVOQTdLwthDyi4Z73PEhGEewcVsLInB2jN4pAzxI=;
	b=SuG8q3lQyqPFIoPjSQyiW5hHIHlBfcaTa40a0JpS3JFR6/99tpYlXpIlP8/bqKXaspPG
	 LBmLvCeNfUf/rP2BQ/ICQXxCBmVXKCAIrXudaouocJULndh0OaJWbMsdG580sV8GDr7/V
	 VivGyKXTL8Hgo3zsd0wKmQ+aMq9Qg/oLrv8Oj6mt05rTdTCJMS5HtW2eYup+IuVk3xaVH
	 LVpvjnJrCvbmQ7l7ymrR6T0fYmxkq4sIBlvnAeovfOtJ41sicijkHtWANN6AfFGRT9BdN
	 lWQ6CsviW+RQedrZdLr/oWjcNLYl/SfEtzVFcW/DQPu0zSSLyOtg5dXJzWPQH9XtDkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=qoVwMDdB;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4B606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BE4B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=qoVwMDdB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=H/0sVOQTdLwthDyi4Z73PEhGEewcVsLInB2jN4pAzxI=; b=qoVwMDdBmGK3PPrQdOJmf3CaQt
	TkjdN/GUf9XWR2b8Y8lnjdqfyXfeFLozSivMo2PW7CnAkbNxjbxTpL+0SE105mp9iRJiBK7pcZsqM
	LC2pQRqE/dzCH9ZfD/UvQ7wlD3uaQcqC2+Dq5HdO2kN2SKUVX5Bg6mHObYu+0u1DGUWeHEcMKFErs
	a+B7qE2UFHeZkc4UFJSdywGbD/VnNu8eldoZlAro4WDGJbK3MbDapbQeT0mtgX09a8blXi6JZDcAD
	6bR/3ScTcoSvXvz14opnN7yeMnhO6d+SaFZgpDriLRYEaFH/Rihk0vG5W8y3k8MmgpkytcM7VOLEr
	uMvUQVqg==;
Received: from 54-240-197-234.amazon.com ([54.240.197.234] helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ6S1-0000000FJXI-3qHk;
	Tue, 20 Oct 2026 09:48:10 +0000
Message-ID: <3c77f88acff5b3c2617b22d64faad15f6212619c.camel@infradead.org>
Subject: [PATCH v3] tun: Require CAP_NET_ADMIN to attach to an ownerless
 device
From: David Woodhouse <dwmw2@infradead.org>
To: netdev <netdev@vger.kernel.org>, Willem de Bruijn	
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, 
 Stas Sergeev <stsp2@yandex.ru>, Andrew Lutomirski <luto@kernel.org>
Date: Tue, 20 Oct 2026 10:48:10 +0100
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-IoM2PGExg8frbtEExhC2"
User-Agent: Evolution 3.62.0-0ubuntu1~ppa1~24.04 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-IoM2PGExg8frbtEExhC2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

Twenty years ago I made creating a tuntap device require CAP_NET_ADMIN
in commit ca6bb5d7ab22 ("[NET]: Require CAP_NET_ADMIN to create tuntap
devices.")

The idea was to allow the permissions on /dev/net/tun to be relaxed to
0666 and thus allow owners of tun devices assigned with TUNSETOWNER to
actually open it and get at their devices.

What we missed at the time was that persistent devices with *no* owner
were already essentially world-consumable, and anyone who could open
the device node could also attach to those.

Even then, using persistent devices with no explicitly set owner =E2=80=94 =
on
the (false) presumption that CAP_NET_ADMIN would be required to open
them =E2=80=94 wasn't an egregious userspace bug. There are cases where it =
does
make sense to separate the creation/configuration of the netdevice, from
the process which shovels packets into it.

Since then, TUNSETGROUP was added a year later in commit 8c644623fe7e
("[NET]: Allow group ownership of TUN/TAP devices."). Its commit message
noted that if both uid and gid are set, both have to match (in itself a
bizarre choice) =E2=80=94 but still not that with *neither* set, no permiss=
ion
at all was required.

Then in 2012 commit c8d68e6be1c3 ("tuntap: multiqueue support") allowed
new queues to be attached to a device from the moment of its creation,
with no way for userspace to close the race between creation and a
subsequent TUNSET{OWNER,GROUP}.

In 2024, commit 3ca459eaba1bf ("tun: fix group permission check") tried
to fix things to be saner: only require the user *or* the group to
match, in line with standard POSIX permissions, and require
CAP_NET_ADMIN if neither the user nor group authorised the access
(although it put the CAP_NET_ADMIN check first, and would wrongly have
reported the capability as having been used even when it was not).

That fix was reverted in commit a70c7b3cbc06 ("tun: revert fix group
permission check") due to allegedly causing a regression in an selinux
test suite which *expected* the attachment to succeed when authorised
by none of user, group, nor CAP_NET_ADMIN:
https://lore.kernel.org/netdev/CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6d=
akXncUg@mail.gmail.com/

We should not break UAPI. But we don't have to consider an selinux test
case which deliberately exercises a security flaw to be UAPI worth
preserving either. To which end, I have fixed it in selinux-testsuite
commit b2f894f0016b ("tests/tun_tap: set an owner on the device for the
relabel tests").

So: fix the lack of CAP_NET_ADMIN check on devices which *haven't* been
assigned an owner or group, while leaving the weird tun ownership model
as it was (user *and* group have to match, if both are set). If someone
still wants to fix the latter (which wasn't actually the reason the
previous attempt was reverted), they can do it under separate cover.

Permit attaching to an existing device only if an owner and/or group was
set and the caller matches all that were set, or if the caller has
CAP_NET_ADMIN. The only behavioural change is that a device with no
owner or group now requires CAP_NET_ADMIN to attach =E2=80=94 precisely the
loophole we want to close.

And put the CAP_NET_ADMIN check in the right place this time.

Fixes: ca6bb5d7ab22 ("[NET]: Require CAP_NET_ADMIN to create tuntap devices=
.")
Reported-by: Andrew Lutomirski <luto@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: stable@vger.kernel.org
---
 drivers/net/tun.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 5a302709a68a..0002e1598e69 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -513,14 +513,18 @@ static u16 tun_select_queue(struct net_device *dev, s=
truct sk_buff *skb,
 	return ret;
 }
=20
-static inline bool tun_not_capable(struct tun_struct *tun)
+static inline bool tun_permitted(struct tun_struct *tun)
 {
 	const struct cred *cred =3D current_cred();
 	struct net *net =3D dev_net(tun->dev);
=20
-	return ((uid_valid(tun->owner) && !uid_eq(cred->euid, tun->owner)) ||
-		(gid_valid(tun->group) && !in_egroup_p(tun->group))) &&
-		!ns_capable(net->user_ns, CAP_NET_ADMIN);
+	/* If both uid and gid are set, *both* must match */
+	if ((uid_valid(tun->owner) || gid_valid(tun->group)) &&
+	    (!uid_valid(tun->owner) || uid_eq(cred->euid, tun->owner)) &&
+	    (!gid_valid(tun->group) || in_egroup_p(tun->group)))
+		return true;
+
+	return ns_capable(net->user_ns, CAP_NET_ADMIN);
 }
=20
 static void tun_set_real_num_queues(struct tun_struct *tun)
@@ -2872,7 +2876,7 @@ static int tun_set_iff(struct net *net, struct file *=
file, struct ifreq *ifr)
 		    !!(tun->flags & IFF_MULTI_QUEUE))
 			return -EINVAL;
=20
-		if (tun_not_capable(tun))
+		if (!tun_permitted(tun))
 			return -EPERM;
 		err =3D security_tun_dev_open(tun->security);
 		if (err < 0)
--=20
2.43.0


--=-IoM2PGExg8frbtEExhC2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCE8Ew
ggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMwMDAwMDBaFw0zNDAz
MTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1xPQ+dgSxbIIrkaru6skAWJYaGFzmv
q4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XRmS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5Z
S64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1Cxy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTb
Z/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK
72a2GEpI8Wpl26G6I1/LMzz/98T+FqjTqxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZA
CcVdCtl4nAacFacmsiArZBfX7AQGL7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8W
mAESbUriIjyuTUf3fJ9oDNCurVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2cs
h2T79v7pC8aUtHBfwNrTR19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61a
CBevQGHNzrbZ3JAMneveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxI
GJiywe9qPhuJSDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtg
v6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMG
CCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURS
b290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdp
Q2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUA
A4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvCRS2pili3Hy67i8N4N5NU
vw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwEqOOwLLyH02ZQcsfq5p5LrOH9
0JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9YflujuNNvJztjBaHKYZsnNSg+J38o
jYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3x7Nel3A1bwAkalrDMspvTHvey6LfiBks
FIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVrYu8RMIIHAzCCBOugAwIBAgIQAzUotrsybJHx
HTjKOIVdIDANBgkqhkiG9w0BAQsFADBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQs
IEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTEwHhcNMjYwNzE4MDAwMDAwWhcNMjgwMTA0MjM1OTU5WjAeMRwwGgYDVQQDDBNkd213
MkBpbmZyYWRlYWQub3JnMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA2pYux73kdbYX
sWF8f1u6DJP91qcqaZetsyfPkZk0B+MmXmAEv0kVes5n15V2mbDThOnpoPFly0UugQO9JYqLfrtD
tKD5yL58fgrDB9Dw+LQikgrHafl6YSCds5AvUu/8hw2J6noKrcOLJpKlKn9Fl/4IB9Q3JIdLx5aa
EtTqMalIPqHFOlgrJ7s+aua8xbB8YQ9ahqYBXWRJNv3P/2b1DYtdrz1oqZPE3CcB8Pc6Gf2a1Tcm
6TAgtEx7Cf1BFcrsrMz7TWHmGQITieNb2r9UYWSc2Gp+GtYFNJCgT0JJXKUBIauPMKBLteYrL8Fo
ff/uY44dC/mDWjdCP/5x0qelPQjlBvWdHL5zvBTOj06rJ0m3HNI/hnIcDh0Qu2j9reb9rLVcdym6
bWmBM4uDEB8Zv9Ph0KTBFSy1IosyakuD1j1Os30EzjGfbi0EUXIvnOcYbTBAbM5UAzrxEHMhBvoX
Pvnx+OyvjJmc9tWxTX6AcSz+m40esbT17URBeZS18afgieiikm5TynlUYP1LciR3hSgGVzvGXnKO
02VDFR5itGWdRKZ2W5wIShNfWfhSa0D0K5UdIDt5Qc7sjzwK1Yb1sY5Tu0uA5mhIS82q1ov83uxB
sFkriNnhGv/M1NCDVLBiOMsHu73qUM+yKmgKLwF9Hfn9WI25glbAMI4S5r3hYzcCAwEAAaOCAfcw
ggHzMB8GA1UdIwQYMBaAFPebok7Tl8X0NA9DDoGFzpGTMq/5MB0GA1UdDgQWBBRcYhqbcGzn1jrT
JOZaB8O7qllDpzAwBgNVHREEKTAngRNkd213MkBpbmZyYWRlYWQub3JngRBkYXZpZEB3b29kaG91
LnNlMBQGA1UdIAQNMAswCQYHZ4EMAQUBAjAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYB
BQUHAwIGCCsGAQUFBwMEMIGpBgNVHR8EgaEwgZ4wTaBLoEmGR2h0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsME2gS6BJ
hkdodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZT
SEEzODQyMDI0Q0ExLmNybDCBjQYIKwYBBQUHAQEEgYAwfjAkBggrBgEFBQcwAYYYaHR0cDovL29j
c3AuZGlnaWNlcnQuY29tMFYGCCsGAQUFBzAChkpodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20v
RGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0ExLmNydDANBgkqhkiG9w0B
AQsFAAOCAgEAocabrh1cPd5s3vY5rnlBVQSTc7zs2ZWs67dAIltR+05WELrYClVzzUhMs/LOJPlr
EUo45UDDomXq38DxFepaPd9+iNLjXfn33EX/IG44j04lU/oF/Rg9VeQILkYLbCZ/x9wOjNHZc4SN
ydY7Dhvf/sT5aBz88u7D5+azZJ7Qf1U57wYseCH1Mt0nDrtr5y19IJ8D9xJJ33RFL6vfpHZBBAQ8
+3RqkKNxLoV2aFvQhxdhjNLDqTv3LjUIdicwPraN7JkxEu7CV2Lka7eRqJgkWL7SK0YmBjGpRafs
+icP/ON5RCCKTTb6VlX8eTG2sJJfsFhvJNCCt6xexbWzWtIrfP7NvPBvwBB737AyEGBZkS5aNizT
McURJGTv9UKvBh1LF/+tNhYtLvPCN7oecGzhCHht9jcwSkygTo3Y6YlK3QgOu+ncmiBbfeuwlLZ1
LxbYvG6hgNqXv7u6YyADbYajAQJXJ2OQen39pm3Q/AQSyLYG+B8lDglWsM8tYXPlEdrYJcksGK6F
nqIX6Bumn43rBooLJdiZp4WmfWdL2pxe+LxRDjprmqu1WprixDxULSTOKJZoqTlugs6y3Bc+if+s
gHnBBtz9WQ6MtPHkh7zONDAFIKcBmv8OqPQCx0F3Wv3OEybwMpXx0OsKgK8wLldaX1pXcMuyDgTL
Sqs0AV0OHUgwggcDMIIE66ADAgECAhADNSi2uzJskfEdOMo4hV0gMA0GCSqGSIb3DQEBCwUAMGIx
CzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQg
QXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTAeFw0yNjA3MTgwMDAwMDBa
Fw0yODAxMDQyMzU5NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqG
SIb3DQEBAQUAA4ICDwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZe
YAS/SRV6zmfXlXaZsNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2z
kC9S7/yHDYnqegqtw4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qG
pgFdZEk2/c//ZvUNi12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41va
v1RhZJzYan4a1gU0kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0c
vnO8FM6PTqsnSbcc0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PW
PU6zfQTOMZ9uLQRRci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXt
REF5lLXxp+CJ6KKSblPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQr
lR0gO3lBzuyPPArVhvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7Iq
aAovAX0d+f1YjbmCVsAwjhLmveFjNwIDAQABo4IB9zCCAfMwHwYDVR0jBBgwFoAU95uiTtOXxfQ0
D0MOgYXOkZMyr/kwHQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3
bXcyQGluZnJhZGVhZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEC
MA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwgakGA1UdHwSB
oTCBnjBNoEugSYZHaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01J
TUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwTaBLoEmGR2h0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNv
bS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsMIGNBggrBgEF
BQcBAQSBgDB+MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wVgYIKwYBBQUH
MAKGSmh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNB
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
nmeBHG7LJhlqN1AcY+1QSMUAAAAAAAA=


--=-IoM2PGExg8frbtEExhC2--
