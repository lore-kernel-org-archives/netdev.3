Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049190;
	b=KySdRXE/Ffk55lVLy3TKgRwRz6/kh59B87EmcgSp69ddb1tet4GWPEXHFe0btsAXya/s
	 9qSdZ6nYh6jmQKZnz4rtQwNGpem3cATzZaHALpWAbC070S83//0FqJoy/abjcFSVQWGfd
	 v4qhPT0f8Jo2itmcvX7qORMQks7kPmKQCo/QtTZv2k2fTK9BeFWYTRlq5QWEgnGE/Xpy7
	 1KjPZjUBUVGD23p6IRwuKWYg/+/vQNEwuClqtp1ofNHdwwRDSB/o+662jWKrDJUeO6gYG
	 NEQedRDY1HKQJBiB3u9wMPcwS2by8K2nC5b5GN+DlNro9TrNhagayykW1EEdtRW0cNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049190;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=+3Xf0PE+LagmTc4tqKy4edOsojgcvPiX0DMuZnq5S3k=;
	b=TsGKts6VzD8fXnb/dffuEXIY/Vit3RTdnvcR8Lpq1HDpui8qAEbT5l31eidlJE3k1tmD
	 DEcVcivLs9+mnNARD5lPJsUk1Pe/GBcPskG7YWC2+HBzuybchMpRgGhgVyYFFJ/JppAwj
	 kOjUe+yFPgdmXIaLYLoGm3mt9saqKubiWd6ML1OZO0zen+ngijcJCrqXRcfeXBz1X7QNN
	 gGapoOhapMsNN7VA/AzF4NOriGEyFD/LMLVsRpCs71Ean3IJM1pqTr0nWOF87RZHDl3m+
	 qGOi7Ae69+ojiGRjZWb4apXSnmawbpwv9p0ySpXMI7wbVXrTqgHSGxSYCYS5nHa37yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N9WAtu/F";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33AC606A33A;
	Sat,  7 Nov 2026 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9WAtu/F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1ED1F0089F;
	Sat,  7 Nov 2026 10:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049189;
	bh=+3Xf0PE+LagmTc4tqKy4edOsojgcvPiX0DMuZnq5S3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N9WAtu/Fie4JSawBbWTucmridD3H+Ras9ViIcMJUXiO/NqRxEoZVYTVJS1Axowtcb
	 nycReq0Jp9FjPTbzD/sv2jw/dlWi9fDwIfqgjibz+3VVXan3Mu0WAi74xfwFLSIH5i
	 3ZibKHb8/Fm95Xl1JyHhK9MfCGld6IcI9Z/k0VudFZK0ndIU/43p3CRoui9aDR2xck
	 XkcPtwDk29izrMiVuXpwrhFVAL+KGDx7KgAHSXhzFN6/LOrv5T4dkBgg+vom3cruTs
	 2OZILCbM2z9SPGg86iv8xVzcKOE6t8Tl6C7wcGGy8WotPiM+W028Fg/DTCxTYi9J2S
	 qRlrGh1ONtuvw==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 81D3D28D2449; Sat, 07 Nov 2026 10:59:44 +0000 (GMT)
Date: Sat, 7 Nov 2026 10:59:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: Matt Porter <mporter@kernel.crashing.org>,
	Alexandre Bounine <alex.bou9@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org,
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 3/3] ASoC: sprd: use dmaengine_prep_slave_sg_context()
 instead of device_prep_slave_sg()
Message-ID: <6ca75bd5-f402-4757-b264-6720b03b0365@sirena.org.uk>
References: <20261106-rio_sg-v1-0-bc54b4bd8c95@nxp.com>
 <20261106-rio_sg-v1-3-bc54b4bd8c95@nxp.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aU+YWAD6yJFUUGmA"
Content-Disposition: inline
In-Reply-To: <20261106-rio_sg-v1-3-bc54b4bd8c95@nxp.com>
X-Cookie: Whoever dies with the most toys wins.


--aU+YWAD6yJFUUGmA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 05:43:10PM -0500, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
>=20
> Replace direct calls to chan->device->device_prep_slave_sg() with the
> dmaengine_prep_slave_sg_context() helper in both sprd-pcm-dma.c and
> sprd-pcm-compress.c.

Acked-by: Mark Brown <broonie@kernel.org>

--aU+YWAD6yJFUUGmA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCau8EmwAKCRAv73Ows9A4
iW+5AP9aetZoADx2kgpQxvUXbikjHna+8G8k3cywS9jVU4nvyQD/V5fyZbvLDm/v
sgHODthprx1rRSCge4KCShshtklVhQQ=
=X2k0
-----END PGP SIGNATURE-----

--aU+YWAD6yJFUUGmA--
