Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA78F36A34E;
	Tue, 21 Jul 2026 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632377; cv=none; b=rw6vzjWnY33Jrwm4I8GytYDPVNPwly80N3Nsg1gAZDkXQM58WZJI8gC9GSSDEJjoNGfz12P0kbr1VSBj1e+Pig1S+2sfh5WZie5laZEm72gZ84D9UBFNXtxUyQ4tYyGsBB9vm59H66LCGoavVg6yTlVr8qVScT06B7Xd0EvgfjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632377; c=relaxed/simple;
	bh=mxwd2aB2/Sy3num+t0tGdUNpoMk21B3BKSEdMEtgiEQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=hCbLetiCDZZhU8L7bhY1qDB8r3zJqCOEcGeml0E8MoL3684J54Kt9SoiJGEfW9u76r24a2tIMLHlOZv5rfNXO/DMua9wfH1F738LG1xMwdICJWjgId1d17/584qTtsU4gwT7w+mJURRn9e7DmUPq+FbTA+oPG8GlfvwoxequKtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIBzKYva; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIBzKYva"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DC92D1F000E9;
	Tue, 21 Jul 2026 11:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784632376;
	bh=mxwd2aB2/Sy3num+t0tGdUNpoMk21B3BKSEdMEtgiEQ=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=fIBzKYvafM1Bc2GeXqNv33ETryQzd83nU4QUWWJ5JDjTU3X4mHztz9ApkHrxB+niE
	 HgbM7pOXBz219d/Pf+dTa5HCsJzefF5wxLKRAihdQcIT8jvlI59UuWYvu3rxNNS2w5
	 iJoHGz+iQnMdrN2UBACMBN7vwvg/x88wUCJ4ZDlGBv7iAqlBGGePrhA8NJN039yFkx
	 t2IZAovn4bz5aWhEjeBhsvIeZR5jAZU5YAxpUCWEBcE9poe3bzGGqvwMKkIJc84omn
	 Nxvh1Lhwdf6VCcWGeKIykDOWNEa5KNltwoHgqUCBWqKNrJ6M+te8eD/7/grkZq22R2
	 sRmsP+yUel/9A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=ab797b970cb1ccfb3d1ed84bb9c19a1fb24835b66e0e80a735c859388d87;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 21 Jul 2026 13:12:52 +0200
Message-Id: <DK47DLQCZVFI.2GL81VG910N1J@kernel.org>
Subject: Re: [PATCH v5 3/7] mtd: spi-nor: sfdp: expose the SFDP as a
 read-only NVMEM device
Cc: <pratyush@kernel.org>, <takahiro.kuwano@infineon.com>,
 <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <srini@kernel.org>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
 <linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
 <arnd@arndb.de>, <linux-mtd@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: <Manikandan.M@microchip.com>
X-Mailer: aerc 0.20.0
References: <20260721052859.171341-1-manikandan.m@microchip.com>
 <20260721052859.171341-4-manikandan.m@microchip.com>
 <DK42262TYFG1.NZKF4VGZGSRM@kernel.org>
 <c921d021-b6c3-4d91-89ca-0e3c41169e81@microchip.com>
In-Reply-To: <c921d021-b6c3-4d91-89ca-0e3c41169e81@microchip.com>

--ab797b970cb1ccfb3d1ed84bb9c19a1fb24835b66e0e80a735c859388d87
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue Jul 21, 2026 at 12:17 PM CEST, Manikandan.M wrote:
>> Or rather NVEMEM_DEVID_NONE? There will ever be just one SFDP nvmem
>> device.
>>=20
>> How does the sysfs path looks like?
> Currently the sysfs looks like:
>
> /sys/bus/nvmem/devices/sfdp0
>
> I kept AUTO so that the bare "sfdp" name would clash on a board(if any)=
=20
> with a second flash exposing a "jedec,sfdp" node.

Ah ok. I thought it would have something with spi0,0 in it's path.
So yeah, there could of course be multiple flashes with SFDP.

-michael

--ab797b970cb1ccfb3d1ed84bb9c19a1fb24835b66e0e80a735c859388d87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCal9UNBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hhTQF+KZoFG4/icFLa+LRtgnRP2iyB/1wM4IpR
ZTM2zKxAVZxOaUG+3GTVHda/yUa1WcR6AX4oRgKid0SEZGVzAaONi7xZxyo28lL1
zsopOz7ovlyRsOxy5atv1KquEEQCsyUY3Ug=
=rxYz
-----END PGP SIGNATURE-----

--ab797b970cb1ccfb3d1ed84bb9c19a1fb24835b66e0e80a735c859388d87--
