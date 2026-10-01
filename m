Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE0B3B530A;
	Thu,  1 Oct 2026 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790843567; cv=none; b=UZ8qybJHKy3j3YLH/VerKj5p4pzG9WIBBNAjVMQfe8zLjxO1GS+FvCeqGtDaWUGpFGlqvNoPE58s29RPUYVq+JJ21RQa1ObCUUxZ32rwtZJtw+e6K4Es11xsu3wXDPoeNVF4LKQsNfBBaTC6LaQWn6kXvQrnSheweE9QQnAB+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790843567; c=relaxed/simple;
	bh=vbieRc23U63bZU7FcyJmM7ykqI4f0wyKxATSQo/BI1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCyXH0prVF7JC4NlEcfcJSE0ToqvXlU4/lqJG9zDexUHmn/xqRqPySbFSPrviQmhBiuVwb1xsE76MmR+sS2KkQnCrb5bGpnqq6/usyv3tIkjH/fWavx2Eh1zIIvGVDsRw/UDJW3qwJdDj40u8jYfu5nkcxo4EGjiAdcO8oXK1LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqRA69vV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqRA69vV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F45D1F00898;
	Thu,  1 Oct 2026 08:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790843566;
	bh=zd4Rd9CRvxd2ybJD/+XeXGt4GToIyin27erBl4UTD4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lqRA69vVhP22r+xNMjuZDk6zVy0BlPDTwdr8miLQzuLn5bKlkEkfF/6lzBVtcnV45
	 noqAa7JlvMDWw6XSe5NoDH9/SGEXVzbIPRkw51e9quA6ZGoVkFYibTVnVTic/TBXKr
	 FniUuL8aU1vf2a8t1jztuYCMUQBUpPs4tqZolg0+MWbdRuWxilq0MOXgiira04Vejf
	 sWp+bCXIForjCTb7GXRREKeRYFUf8lbzpZdd4n+pbIsi2/CZ9J2egH9kmQ5EP3mreJ
	 KTKn0lEHFuHfyRRjZqHAqYZbJBdg+BO7W8d0DUAN6JKNtvFy5oxRQCgAqKRcAGuFOJ
	 2spgEVfEMRLVg==
Date: Thu, 1 Oct 2026 10:32:43 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: take ownership of saved RX state at
 poll entry
Message-ID: <ar4aq0i5lJLT7SGd@lore-desk>
References: <20260930-stmmac-rx-state-v1-1-c286c43813c1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tPlwEejj5iNQjWqT"
Content-Disposition: inline
In-Reply-To: <20260930-stmmac-rx-state-v1-1-c286c43813c1@gmail.com>

--tPlwEejj5iNQjWqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> When a saved partial packet completes with a poll budget of one, the
> old loop can leave state_saved and state.skb pointing at an skb that
> has already been delivered or freed. The next poll then reuses that
> pointer, causing a use-after-free or double free.
>=20
> Take the saved state at poll entry and clear the stored ownership
> immediately. Save it again only if the packet remains incomplete,
> including when the next descriptor is still DMA-owned. Release a
> saved partial skb when the RX ring is destroyed.
>=20
> Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Hi James,

I guess we have a similar issue for stmmac_rx_zc() path as well, can you pl=
ease
fix it as well?

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 25 ++++++++++++++++-=
------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index ec62fa7418f4..1a4d03aaaf78 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2149,6 +2149,11 @@ static void __free_dma_rx_desc_resources(struct st=
mmac_priv *priv,
>  	else
>  		dma_free_rx_skbufs(priv, dma_conf, queue);
> =20
> +	if (rx_q->state_saved)
> +		dev_kfree_skb_any(rx_q->state.skb);

nit: you can drop if (rx_q->state_saved) and just run dev_kfree_skb_any().

> +	rx_q->state.skb =3D NULL;
> +	rx_q->state_saved =3D 0;

nit: rx_q->state_saved =3D false;

> +
>  	rx_q->buf_alloc_num =3D 0;
>  	rx_q->xsk_pool =3D NULL;
> =20
> @@ -5726,6 +5731,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int =
limit, u32 queue)
>  	struct stmmac_xdp_buff ctx;
>  	bool fcs_stripped =3D false;
>  	int xdp_status =3D 0;
> +	bool in_progress =3D rx_q->state_saved;

can you please respect RCT here?

Regards,
Lorenzo

>  	int bufsz;
> =20
>  	dma_dir =3D page_pool_get_dma_dir(rx_q->page_pool);
> @@ -5740,6 +5746,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int=
 limit, u32 queue)
>  		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
>  				    rx_q->dma_rx_phy, desc_size);
>  	}
> +	if (in_progress) {
> +		skb =3D rx_q->state.skb;
> +		error =3D rx_q->state.error;
> +		len =3D rx_q->state.len;
> +		rx_q->state.skb =3D NULL;
> +		rx_q->state_saved =3D false;
> +	}
> +
>  	while (count < limit) {
>  		unsigned int buf1_len =3D 0, buf2_len =3D 0;
>  		enum pkt_hash_types hash_type;
> @@ -5748,12 +5762,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int=
 limit, u32 queue)
>  		int entry;
>  		u32 hash;
> =20
> -		if (!count && rx_q->state_saved) {
> -			skb =3D rx_q->state.skb;
> -			error =3D rx_q->state.error;
> -			len =3D rx_q->state.len;
> -		} else {
> -			rx_q->state_saved =3D false;
> +		if (!in_progress) {
>  			skb =3D NULL;
>  			error =3D 0;
>  			len =3D 0;
> @@ -5787,6 +5796,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int =
limit, u32 queue)
> =20
>  		prefetch(np);
> =20
> +		in_progress =3D status & rx_not_ls;
> +
>  		if (priv->extend_desc)
>  			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
>  		if (unlikely(status =3D=3D discard_frame)) {
> @@ -5971,7 +5982,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int =
limit, u32 queue)
>  		count++;
>  	}
> =20
> -	if (status & rx_not_ls || skb) {
> +	if (in_progress || skb) {
>  		rx_q->state_saved =3D true;
>  		rx_q->state.skb =3D skb;
>  		rx_q->state.error =3D error;
>=20
> ---
> base-commit: 7375d38364a9aa66fb31716bcefef38aecad75d8
> change-id: 20260930-stmmac-rx-state-041371e43e8c
>=20
> Best regards,
> -- =20
> James Hilliard <james.hilliard1@gmail.com>
>=20
>=20

--tPlwEejj5iNQjWqT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCar4aqwAKCRA6cBh0uS2t
rFuEAQDSLs28FZXtvlFLovCP1shWroHJcnR6//fdjyCKN0DS2AD/f6MbvrXfDTP6
NaSWZHYL7Stp2fYZCBntEBoUBKpiCAI=
=LpWX
-----END PGP SIGNATURE-----

--tPlwEejj5iNQjWqT--
