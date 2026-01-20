Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F22425CD3;
	Tue, 20 Jan 2026 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912245; cv=none; b=Qz4bk5ppeTkgBUN4ebRQzgMRLaGl/EmdPAMEK4djNFEEYApJ1Dk62Zm27ntNJrmlVYYpj8Qn9SZSYNF9DvELBuupmX+Avd2saLptLcidZU57xpLHyrBfsVNJsxm/k1QGRC4Ad6akb4PzdibUfOEq4f3CDX9AtP0Y+Y9xjnjCO9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912245; c=relaxed/simple;
	bh=VPawyCtBnlPdJNvPwCrKvYXnJe/QtysnK7EBgqz8RwI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=KlriWkDYLH/JvpT0vTmGU/9opJWYt1StO3y0OpuKQLnnS8p8zVEq860hGurO6of2SKaTpt4oSGmRFBy8rzd8GsOs09Hy3mJApVTVsfztatT13EmXL4b0DaseI9ECjiTszEeom5HNI7PJ2pYH9p1zGf/osn63m6mKEbAe8HLdhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=mk16.de; spf=none smtp.mailfrom=mk16.de; dkim=pass (2048-bit key) header.d=mk16.de header.i=@mk16.de header.b=NCNoj0wO; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=mk16.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mk16.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mk16.de header.i=@mk16.de header.b="NCNoj0wO"
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4dwRVf2srGz3x2x;
	Tue, 20 Jan 2026 13:30:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mk16.de; s=key2;
	t=1768912218; bh=VPawyCtBnlPdJNvPwCrKvYXnJe/QtysnK7EBgqz8RwI=;
	h=Date:From:To:Subject:From;
	b=NCNoj0wOfyd01qJ4RbQV5sn5ejpj3XyGdw1Cw7lp4EloJOWG3XpN1KGfrLEFcUTag
	 iF7BorHutO4TMW31wX8GjxyH31pUD0O0VIMSaeZXoZf3JWmQG2gWJtNj/eB0Jhkgu3
	 fPDre+SlOAWMLq3rt3IcS8GzRx78JnHWepCQ0L+fGHFun1/gKfRiV30rgxpnA17z+d
	 0XWhms8nCwE3UUgPQeADUAi35U27Cs6M/SVc2YkcELq8t2BeZkb01tx5PDm6R2Nm8f
	 m8ocST1Y/10qKN0e+KXn4YqFjNs/FwPbO/RtQxb1DVKT08lMePEoa5AumaYVRAU0dS
	 UgyRPALeq0Mug==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4dwRVf27lrz3x27;
	Tue, 20 Jan 2026 13:30:18 +0100 (CET)
Received: from mxe87b.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4dwRVd5wK2z8tJS;
	Tue, 20 Jan 2026 13:30:17 +0100 (CET)
Received: from ciel (dynamic-2a02-3100-88d8-f101-82fe-fb06-6958-7eef.310.pool.telefonica.de [IPv6:2a02:3100:88d8:f101:82fe:fb06:6958:7eef])
	by mxe87b.netcup.net (Postfix) with ESMTPSA id E4A941C0095;
	Tue, 20 Jan 2026 13:30:15 +0100 (CET)
Authentication-Results: mxe87b;
        spf=pass (sender IP is 2a02:3100:88d8:f101:82fe:fb06:6958:7eef) smtp.mailfrom=m.k@mk16.de smtp.helo=ciel
Received-SPF: pass (mxe87b: connection is authenticated)
Date: Tue, 20 Jan 2026 12:30:15 +0000
From: Marek =?UTF-8?B?S8O8dGhl?= <m.k@mk16.de>
To: netdev@vger.kernel.org, linux-newbie@vger.kernel.org
Subject: Tunneling GRE over GUE over IPv6
Message-ID: <20260120123015.0a5337d8@ciel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LqeA0fHD7vKWquT__iUGOMZ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-PPP-Message-ID: <176891221615.3049410.520883297199598418@mxe87b.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: E4A941C0095
X-NC-CID: w76TFKJ4qi5DlJ9jKx98zZ0QIzT9Ivf6VYp8

--Sig_/LqeA0fHD7vKWquT__iUGOMZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

I would like to set up a GRE tunnel using GUE or FOU, but it doesn't
seem to be working:
```
root@host1:~# ip link add ip6greguetunnel type ip6gre remote fd6c:ffa:eb7a:=
74e2::141 local fd6c:ffa:eb7a:74e2::171 encap gue encap-dport 6661
RTNETLINK answers: Invalid argument
root@host1:~# ip link add ip6greguetunnel type ip6gre remote fd6c:ffa:eb7a:=
74e2::141 local fd6c:ffa:eb7a:74e2::171 encap fou encap-dport 6661
RTNETLINK answers: Invalid argument
```

Does anyone know why? What am I doing wrong? What does "Invalid
argument" mean in this context?

If this isn't the right place to ask, I would appreciate being directed
to the right place :-)

Best regards,
Marek K=C3=BCthe

--=20
Marek K=C3=BCthe
m.k@mk16.de
er/ihm he/him

--Sig_/LqeA0fHD7vKWquT__iUGOMZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEmqKBWfzrPNg7whIBfoaRRmmRCMcFAmlvdVcACgkQfoaRRmmR
CMepsRAApeSJccvOSKrNtsV26uveJ5FbMcLavVG4XbMU6AhkZMhz4XdO14SgCc3b
62UzvKY6BzhOIgsE1oLQpzpubMYt6geElj3SRjhl4xkugmSEyvHSFOz11GxhDrkc
0huaY4rklR04PqqkI36qhwi2jPZhF7gDx/ycQyzYueL2IPBVdtVj6iVZxqUDVCBB
Zz6NkYmNhQrF2zfE6VUbeGh6hqEGTe79Sg4CG4KFflGz76e2DqQm4SoAQheQC1eP
pStPaqJ68b/+JXqVROzinh4QappnGW1W5gd18TV76lhuH0wWp5s/CK0EpZvctaKO
0+RM+VHh9p+pA4pExjUKfnVOBL0sd/UGgOql2i38gLz2hywTP6jEB5u4hInf7UQ0
Tv1tY4TPEqldZVgrYQNM45BJuoT4ih2uR5gce2hWMI090gXb1761+n+BhbTI1bLN
CnNDIU7YiwW5hwo1z5/dwuod5E8AIHdi3xq2U6wyVdWLRhxctZZdJTbsyuoACWye
/k5gkOWSZsSglCMAbz/6wrSwY/CunSPXhOrouW5vC6xOSdl+3GBR7w3dr6570dO/
ZuwmOCNe5WfNsCxdDnswGnJ+GbZTyQkjl5rj7Hjc0J5ruWYQSeB0SJQUMUGnx8p+
50jQnpuBYRA/mDLxFPA1LwB8Iucoa3iL7EtzeAUdNURwO4jRytM=
=CmBY
-----END PGP SIGNATURE-----

--Sig_/LqeA0fHD7vKWquT__iUGOMZ--
