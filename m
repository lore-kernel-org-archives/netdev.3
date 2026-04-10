Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0721D1F4181;
	Fri, 10 Apr 2026 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775825539; cv=none; b=nEmGsiuh3UXQMIVW6q80D0bHamM9iWdXC8y1DtWPisdXJxemtf+OfHhvEOVUnNLWIxZs+DjnDTez0n4w5ce/1KrThs4Ar/5gd1jtpCdaAK3h8G7fl0KFuLfgrSr8ae7mF4VMBVdTuVvsWW5ARa+mytA1aowte730OPdq/1YZu2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775825539; c=relaxed/simple;
	bh=zuuCDFpBIYwYCymvnfHsVnlCyTNDji9hQDQRq6t3Qvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEoFr973jB7Tlp9acfsaC8VXXlQWcSH7PSUpVZ5X+ypkV4rfSxsEfsiY4Jilnwb3nZ0KXMlVNOiNwk22uJmMsfnXvMvM+z3qpkbg/7pyahvA4v4+66AmxAiueHE7eUVMixbSYCZPHDGRbQQAMsZswrE6YpX7FYwtxexpLNoxf3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aggJ54El; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aggJ54El"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7EAC19421;
	Fri, 10 Apr 2026 12:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775825538;
	bh=zuuCDFpBIYwYCymvnfHsVnlCyTNDji9hQDQRq6t3Qvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aggJ54El2gifA4t0ODO4iu3a7rNJ7EPppvZAilEijwKJRJ74De2JT3xUkfdQJUv1g
	 gt802ZPmbRRt4g5zE7yUEBTWLryVsXlYdO6MtO9amEcS7aTU8fGl12ps85ZG2n6jiQ
	 SoCLAD1c+XvTTpHdZYsIfDmrbOrUcTfBRf6oUMo3paJbbm9vqm4D4RfW35SN72Am+L
	 G3vPRpbdFI9B36RlTNTRBKcqxXqLC+yqeqPP4QExF/cLE0LjyF5aRjLEB4Ce0Y/3wE
	 MPm8G0FPOvcd8hizllvb88zlG7rnsnEeM3I8BunjBJIMnla7cvBAjM4aRwIRChmNrd
	 SeE0RMAIc1TyA==
Date: Fri, 10 Apr 2026 14:52:16 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 02/12] net: airoha: Set PPE cpu port for GDM2
 if loopback is enabled
Message-ID: <adjygGm5fYHhoPza@lore-desk>
References: <20260406-airoha-eth-multi-serdes-v3-2-ab6ea49d59ff@kernel.org>
 <20260410025720.1809934-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jU4TpBQMci5bfaI7"
Content-Disposition: inline
In-Reply-To: <20260410025720.1809934-1-kuba@kernel.org>


--jU4TpBQMci5bfaI7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This is an AI-generated review of your patch. The human sending this
> email says "For your consideration."
> ---
> net: airoha: Move airoha_qdma pointer in airoha_gdm_dev struct
>=20
> This commit moves the airoha_qdma pointer from the airoha_gdm_port struct
> to the airoha_gdm_dev struct. This ensures the QDMA block used depends on
> the specific net_device WAN/LAN configuration.
>=20
> [ ... ]
>=20
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>=20
> [ ... ]
>=20
> > @@ -1497,9 +1498,10 @@ static void airoha_qdma_stop_napi(struct airoha_=
qdma *qdma)
> >  	}
> >  }
> > =20
> > -static void airoha_update_hw_stats(struct airoha_gdm_port *port)
> > +static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
> >  {
> > -	struct airoha_eth *eth =3D port->qdma->eth;
> > +	struct airoha_gdm_port *port =3D dev->port;
> > +	struct airoha_eth *eth =3D dev->eth;
> >  	u32 val, i =3D 0;
> > =20
> >  	spin_lock(&port->stats.lock);
>=20
> This isn't a bug introduced by this patch, but does this spin_lock()
> carry a deadlock risk?
>=20
> Because ndo_get_stats64() can be called from atomic context (e.g., from a
> softirq), if a process context caller holds port->stats.lock and is
> interrupted by a softirq on the same CPU that also triggers dev_get_stats=
(),
> the softirq could spin forever waiting for the lock.
>=20
> Should this be upgraded to spin_lock_bh() to ensure local softirqs are
> disabled during the critical section?

I was not able to spot any point in the networking stack where
ndo_get_stats64 callback is run from a softirq. Moreover,
airoha_update_hw_stats() is never executed in any napi in airoha_eth
driver. It seems to me spin_lock() is enough here. Am I missing something?

>=20
> [ ... ]
>=20
> > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > @@ -534,12 +534,12 @@ struct airoha_qdma {
> > =20
> >  struct airoha_gdm_dev {
> >  	struct airoha_gdm_port *port;
> > +	struct airoha_qdma *qdma;
> >  	struct net_device *dev;
> >  	struct airoha_eth *eth;
> >  };
> > =20
> >  struct airoha_gdm_port {
> > -	struct airoha_qdma *qdma;
> >  	struct airoha_gdm_dev *dev;
> >  	int id;
>=20
> This isn't a bug introduced by this patch, but since the qdma pointer
> is being moved to better align with the hardware structure, should=20
> qos_sq_bmap, cpu_tx_packets, and fwd_tx_packets be moved to=20
> struct airoha_qdma as well?
>=20
> Because QDMA1 is shared by all WAN ports (GDM 2, 3, 4) and qos_sq_bmap
> is currently tracked per-port instead of per-QDMA, each WAN port=20
> independently allocates QDMA1 channels starting from index 0. Does this=
=20
> cause different ports to overwrite each other's hardware QoS configuratio=
ns=20
> in the shared QDMA1 block?
>=20
> Furthermore, cpu_tx_packets and fwd_tx_packets cache per-channel ETS
> hardware counters but are single u64 scalar variables in the port structu=
re.
> When querying stats for multiple channels, do these scalar caches get
> overwritten with values from completely different channels, resulting in
> incorrect delta calculations?

ack, I will fix it in v4.

Regards,
Lorenzo

--jU4TpBQMci5bfaI7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCadjygAAKCRA6cBh0uS2t
rAmpAQCSpwTbuYHGGRmUj36P1TRUbM5XJ248xde7FVOJfAtYwAD+Pi6va2remwkz
5cZ1xinWhYE5QyISrzvQr4SzJzJYcAA=
=sr7/
-----END PGP SIGNATURE-----

--jU4TpBQMci5bfaI7--
