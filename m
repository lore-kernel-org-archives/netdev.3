Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE62286419
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984546; cv=none; b=AwBzD1tBOZ6O6yYZMIVojrLR9wFglQv4P+uCPMc7T5wfzQkyFwf0//t1G9H1+lT1DWTkW/MYmp14rR8b4P14BdlMJU7FsoYMY1cTFIOv3Py/qh0Ggd54w00tbVEHjvQeeWZRdopjBD+dH39lO38Pz3UULLLWaM6mjr28t3dD1kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984546; c=relaxed/simple;
	bh=L6EIme8h3H8IyyRj+yncSw84nDKD54Hbxdp+a/xFmGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPOVe4SLHM6bY+7OZwURHCc+gchurDd4flRCVEcOPYj/enBGxQeKXyNZGkYAv/PQI9+1qF6ndmlvYCHOwLl8WO/AfM6+6wCQ2G7Er9wfajMxUJ7AakmuN+b/oJn53+4OoU3J5OF0lVMnN3GiQkveAQavGEE+aQEmZ32usdjNzTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJmerr5Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJmerr5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A811F000E9;
	Thu, 28 May 2026 16:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779984544;
	bh=h9g24AMvHPC82wp8alB06zIO1bChAGUywmcXHfgLSzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aJmerr5Yu9DJXjrB1+R/OUCZIzguGkJ/2WMfRBhgFoxct9tb2XG91s3oB39rcM2m0
	 YtEKW/mkJqXUq4NRZeuTrt4+3AlJT+iG53E6oRjTiCkkQVDg/LT3NHtoJd77RTeu8K
	 8AMi1+Kffv391i74QGAdoDZ/h4imuM9BmBk8r4HYv7MIDAJV5A8EJ6QOmvRgUSh+YI
	 BowZSjMQZLGe2qx3zO74GvLfPJjQywX4Q/Rw16zMj0iJ86Ah6yT8O+u8jZnVymUC2m
	 jXt4EF4W5+Qhjo7xcjqaM9GJncHXHKaTFyo6sqZu8oz64/dVfKzNIiz9NhvbOmMDuv
	 18Pqv/t9U1tbg==
Date: Thu, 28 May 2026 18:09:02 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Xuegang Lu <xuegang.lu@airoha.com>
Subject: Re: [PATCH net-next 1/6] net: airoha: Introduce airoha_gdm_dev struct
Message-ID: <ahhonoI-oJ6gJqZ0@lore-desk>
References: <20260527-airoha-eth-multi-serdes-preliminary-v1-0-ec6ed73ef7fc@kernel.org>
 <20260527-airoha-eth-multi-serdes-preliminary-v1-1-ec6ed73ef7fc@kernel.org>
 <433b9d9a-bd7c-44ad-b387-a789b326488e@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nb9J8kMZwq4Zf3k2"
Content-Disposition: inline
In-Reply-To: <433b9d9a-bd7c-44ad-b387-a789b326488e@intel.com>


--Nb9J8kMZwq4Zf3k2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 28, Alexander Lobakin wrote:
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Wed, 27 May 2026 12:21:15 +0200
>=20
> > EN7581 and AN7583 SoCs support connecting multiple external SerDes to G=
DM3
> > or GDM4 ports via a hw arbiter that manages the traffic in a TDM manner.
> > As a result multiple net_devices can connect to the same GDM{3,4} port
> > and there is a theoretical "1:n" relation between GDM port and
> > net_devices.
> > Introduce airoha_gdm_dev struct to collect net_device related info (e.g.
> > net_device and external phy pointer). Please note this is just a
> > preliminary patch and we are still supporting a single net_device for
> > each GDM port. Subsequent patches will add support for multiple net_dev=
ices
> > connected to the same GDM port.
> >=20
> > Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> [...]
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/eth=
ernet/airoha/airoha_eth.h
> > index d3781103abb5..c78cabbec753 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > @@ -535,10 +535,15 @@ struct airoha_qdma {
> >  	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
> >  };
> > =20
> > +struct airoha_gdm_dev {
> > +	struct airoha_gdm_port *port;
> > +	struct net_device *dev;
>=20
> Nit: we now have priv_to_netdev() (I hope I remember its name
> correctly), so that we no longer need to store a netdev backpointer in
> netdev_priv structures.
> Just an option, up to you.

I think you mean netdev_from_priv(), right?
I guess I can fix if I need to repost, otherwise I will fix with with a
dedicated patch. Agree?

Regards,
Lorenzo

>=20
> > +	struct airoha_eth *eth;
> > +};
> > +
> >  struct airoha_gdm_port {
> >  	struct airoha_qdma *qdma;
> > -	struct airoha_eth *eth;
> > -	struct net_device *dev;
> > +	struct airoha_gdm_dev *dev;
> >  	int id;
> >  	int nbq;
> > =20
> Thanks,
> Olek

--Nb9J8kMZwq4Zf3k2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCahhongAKCRA6cBh0uS2t
rCn3AP9L3HrDZO+dHLvad0WYopiz4hGx0009SRdHy+w2Kx7BBAEAjqX2Bemdw09X
zNug8X2AKnTJnbKmtQJzquIA+MePbAw=
=Fj6G
-----END PGP SIGNATURE-----

--Nb9J8kMZwq4Zf3k2--
