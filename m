Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A432BEC3F
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869964; cv=none; b=Ys/PeVlLN4Uvbg2ZFiQhlyl6Xrt8ujXq28qAAfdjqVEohyFYW06Obp7fxlV4BjUD8AAb+N5EGO0z6YvG9k+IJSc3J7f8xiuoWpDmktyENIfkIlP9el089bpCIp6UUFHpJKVpu6JbqgNFWmiMXd1aOrydPEaYqVFF0BWgpQtYzvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869964; c=relaxed/simple;
	bh=+giG7RKoZksKXexKmtsslBsIAO/RPNABifR/IZR7+iI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To; b=uuKJ5qV2dV/7wiBSZ1m2lXJeK9jlsQD7fmry/JY7d4o3esqG/S5rSy4+uj+Z5VUQu8cMEkYOQDZynaqqOopG51azMW7A52r+TLzkfmUs45PM3vVWNjZli5iYPQ9g6wFdFldG8h97wCdJCSxZe5mYCsoXRalfOhGZoskitYrENgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODlbXsTw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODlbXsTw"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 91B6E1F000E9;
	Wed, 27 May 2026 08:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779869963;
	bh=+giG7RKoZksKXexKmtsslBsIAO/RPNABifR/IZR7+iI=;
	h=Date:Subject:Cc:From:To;
	b=ODlbXsTwIiUf+Nf3abCrwsXYIZHS9AhOLIBfbsCum11DGcTXF+6TA3kn1JYPvR0EW
	 zcV8oif512yTspUh/NXm+NogRUSClxlif2sSCcwqbnl7gpyWRKulFdft19+0wRc29l
	 nTpiMpVAyEKtQ4wAcvpZlW8iNfvBGFC0oqjBmEX/qKHuCp9OlDddBh2Gwgh6DH6Dox
	 BV0NJsnNvnD8vPtT6ekszOu6zSDCd3N4eJMvzc/lGdWhLBGmcFrqfuJIVxYYE/iI0M
	 2XfkJdSU883DVwXLzldUgBkHKSC2VpVVUzf3DLWTPxYHQZS9MQ08uL//hsUh841GUM
	 wpQfz8jzE++SA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=8211309eae880bde255c32ccbd15101254a2b82b6320eec0ebc9fad6e5af;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 27 May 2026 10:19:18 +0200
Message-Id: <DITB8QZ1OEQF.327XUI9E0SXQ3@kernel.org>
Subject: phylink and an unusual PHY/SFP setup
Cc: <netdev@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Andrew Lunn" <andrew@lunn.ch>, "Russell King" <linux@armlinux.org.uk>
X-Mailer: aerc 0.20.0

--8211309eae880bde255c32ccbd15101254a2b82b6320eec0ebc9fad6e5af
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

I have a board with a rather unusual network link setup:

 MAC/PCS (fman) <-SerDes-> PHY (M88E1112) <-SerDes-> SFP

or even

 MAC/PCS (fman) <-SerDes-> PHY (M88E1112) <-SerDes-> Copper SFP with PHY

Does phylink support such a configuration? I suspect adding
support for such a configuration isn't straight forward.

FWIW, the M88E1112 PHY driver seems to be completely broken in
upstream. It looks like it was assumed, that it's like the M88E1111.
But that one only has 1 SerDes and one parallel interface. The 1112
has two SerDes interfaces and thus a completely different register
map. I'm not sure it ever worked, except maybe by accident for the
SGMII-to-Copper case.

-michael

--8211309eae880bde255c32ccbd15101254a2b82b6320eec0ebc9fad6e5af
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCahapBhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gFtwGAhH9lj1c8yreLy9EQPOISziEyBw2S3vAm
o3vU9z+2NHabEX8ddIyTUFw99wzbRBieAYCKJdo58c0g5TSC46Hdy0PQvsII5GXk
91U09fiq3w/dr+rLpEOSefUAVmRLEyrnBcg=
=rvDG
-----END PGP SIGNATURE-----

--8211309eae880bde255c32ccbd15101254a2b82b6320eec0ebc9fad6e5af--
