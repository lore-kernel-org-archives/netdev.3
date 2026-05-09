Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4310325F994;
	Sat,  9 May 2026 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778307476; cv=none; b=NcMkar+lr8zxIH7cRICGUjnW8llfFymEsAiAEGsgdEWNe+IVtSAt66U+xehYZluE5XFv8eVWgk1X9XLi9+hniF/52sjjHoCiDmFcTgeOlKlg9jNcOJv0NXZYvbErFFEN8gdMYOACjw7ALDtaIzPJwLNiHiVxSnoo+0vXXM4AHis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778307476; c=relaxed/simple;
	bh=Ha3F77ZzJvbbXJghzBav9RP08S2XsFPL0mAqPG3sWq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsolI1K2CfwDZlZRA1PwOlYOhsWzHNyKRrG+WXuCY/YS0GE2vuFxduibbP7L89S065BTSOGfR4BI9myeCHy/QVIMx1nMS+KqGHDW5ihyREY8V5C8tZ3zi3GrwLfdly0uB3SAiMpr5tuMBYlLN1yY63cHA01lv6xP4SxIJ5H5S0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKBSGwRp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKBSGwRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5F6C2BCC9;
	Sat,  9 May 2026 06:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778307475;
	bh=Ha3F77ZzJvbbXJghzBav9RP08S2XsFPL0mAqPG3sWq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKBSGwRpYqyD70zhjanuhZJpXWzniSsj3lj4xs9kAwAdNzvRphOehTmcqOPy6XqoM
	 8y2aY+nbxABHNT37pO5bABH4KMlDQalClOqrFXpJXe72croYHlC675k1O+duTX8Ci1
	 OrwRrGpu9nkfGlLhb5VYqeHqH+kPHR5JWoutoOQj8sk3jeVeeVlxnydqHv7ZG99xMI
	 DACWFQXov4WRp1oeuwdEy/u9oE0DBzD7PIYzH7JmrZNkoZ/IcjP4IVxwhTrthOwFvY
	 WbC5XdRr/R1SNjlrtrCvZ3EMo/ztqsvS/LLBToxtJigIcay6F1yjhsefLOKDXN1HI4
	 8qLsRGzsTC3bQ==
Date: Sat, 9 May 2026 08:17:53 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, madhur.agrawal@airoha.com
Subject: Re: [PATCH net-next v4 03/10] net: airoha: Move airoha_qdma pointer
 in airoha_gdm_dev struct
Message-ID: <af7Rkf5Awk1q6lQo@lore-desk>
References: <20260507-airoha-eth-multi-serdes-v4-3-af613b61ae02@kernel.org>
 <20260509014606.3558018-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CKkjltz6LSKR9NjK"
Content-Disposition: inline
In-Reply-To: <20260509014606.3558018-1-kuba@kernel.org>


--CKkjltz6LSKR9NjK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> Subject: net: airoha: Move airoha_qdma pointer in airoha_gdm_dev struct
>=20
> This patch moves the airoha_qdma pointer from struct airoha_gdm_port into
> struct airoha_gdm_dev, as a preparation for allowing multiple net_devices
> to share the same GDM{3,4} port via an external hw arbiter.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 4af64f182968..1798b4a6cf5d 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>=20
> [ ... ]
>=20
> > @@ -854,7 +855,8 @@ static void airoha_qdma_wake_netdev_txqs(struct air=
oha_queue *q)
> >  		if (!port)
> >  			continue;
> > =20
> > -		if (port->qdma !=3D qdma)
> > +		dev =3D port->dev;
> > +		if (dev->qdma !=3D qdma)
> >  			continue;
> > =20
> >  		dev =3D port->dev;
>=20
> [Low]
> The resulting loop body assigns dev =3D port->dev; twice with nothing in
> between that could change port->dev:
>=20
> 	dev =3D port->dev;
> 	if (dev->qdma !=3D qdma)
> 		continue;
>=20
> 	dev =3D port->dev;
> 	for (j =3D 0; j < dev->dev->num_tx_queues; j++) {

ack, I will fix it in v5.

>=20
> Is the second dev =3D port->dev; intentional, or leftover from the
> refactor that should be removed?
>=20
> [Medium]
> Can the new dev->qdma dereference run while port->dev is still NULL?
>=20
> Looking at airoha_alloc_gdm_port(), eth->ports[p] =3D port is stored befo=
re
> airoha_alloc_gdm_device() runs, and airoha_alloc_gdm_device() only sets
> port->dev =3D dev at its very end, after several failure points
> (devm_alloc_etherdev_mqs, netif_set_real_num_tx_queues,
> of_get_ethdev_address).
>=20
> The existing cleanup in airoha_probe's error_napi_stop path and in
> airoha_remove guards accesses with if (dev && ...) when reading
> port->dev, which suggests port->dev can legitimately be NULL while
> eth->ports[i] is non-NULL.
>=20
> Before the patch the equivalent check read port->qdma (an embedded field
> zeroed by devm_kzalloc), so the compare was NULL-tolerant. After the
> patch:
>=20
> 	struct airoha_gdm_port *port =3D eth->ports[i];
> 	struct airoha_gdm_dev *dev;
> 	...
> 	if (!port)
> 		continue;
>=20
> 	dev =3D port->dev;
> 	if (dev->qdma !=3D qdma)
> 		continue;
>=20
> would dereference a NULL dev if port->dev has not yet been assigned when
> airoha_qdma_wake_netdev_txqs() runs. Would a NULL check on port->dev (or
> reverting to the original port-field-based test) be appropriate here to
> preserve the prior robustness?

Even if this is not a real issue since it will be fixed by a following patc=
h=20
in the series ("Support multiple net_devices for a single FE GDM port "), I
will fix it in v5.

Regards,
Lorenzo

--CKkjltz6LSKR9NjK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaf7RkQAKCRA6cBh0uS2t
rEvZAPwNLCYo6gifsw7IBi5TUpI/fYB0BDXDjZOQY4h9opH7RQEAy70E8bmN0A9P
Q3BudcGBRukuFAKQ9nclWBOKAlm0hwo=
=plcV
-----END PGP SIGNATURE-----

--CKkjltz6LSKR9NjK--
