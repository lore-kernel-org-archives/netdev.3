Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B433E202C46
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613312; cv=none; b=DpNqJZq6uYqvP/EWV0SZ6iI4JdTLsZfUHmnnTybp6YNloiahmFfcKoGxzXyYAL+ACRtuDRbWu8HFmLo7oQLxqanq9+sF5udVLjAllJN6iP51vy1TadokIOf3M3jM1zkNysYPCxY4nMUiSyZtkOEEQmUJxlkQrZOrMlIHnXYWHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613312; c=relaxed/simple;
	bh=KxImmXi/AoZGTcRhN3tMRRtZI9r3RsnC7Fnm8IzmuE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ysa+kDtrLHnwUjniq2j8bQcTBSbVQw6WlqEiCCII81W3QHTOi46Z4+Uorx7a8Vc7mP2Jp2XTzarUJ4svxzwthLgwxscdSx6fPmCpX7cy6wByge+1Bn6M2tmznPt0aGu6w0yKg4TFPTnkqoIDZ+5tShv53zcyEIUz8rW7/7VNU1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRZ60BWe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRZ60BWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64041F000E9;
	Tue, 16 Jun 2026 12:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781613311;
	bh=17RgpFCBH4m8pJlxhHaaqvMX7DlUgffBsaUwblhbOrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BRZ60BWeV+DWL3afFYfSit+P84pepfep1y0QrI79qYne7dzlGesvYs8bcCBcNBlCQ
	 XQ6tw0vCVxm25BFd9qdSagQCsVfeGEoyVFgczmuPelnLFRg+xk8bmKytUI3EOsJsSG
	 2LvYTL4xE1WTSRravroMwuy2mngWV7PHghZZySPHrpo1N0Os0dv/gUC5Qo3AJj0OO4
	 WwK7c30EW+wqXbdEyMPhKjHxeZv3zDH/xErVUBuHbxQpvLv2vDbyRgFRsL8dAKq/V6
	 qGZtFEEbqqxf64k0d0idku3qvQp6gIQkkKZ8xjln7g8VUpYTARr/QPB1bdWLz/4PqF
	 +H08D0KyfSa3Q==
Date: Tue, 16 Jun 2026 14:35:09 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] [net] net: airoha: Fix QoS counter configuration for
 Tx-fwd channels
Message-ID: <ajFC_W0RT3Nzlpjb@lore-desk>
References: <178161132384.2164449.18407700117859190327@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KXA7XktxuGW70IKZ"
Content-Disposition: inline
In-Reply-To: <178161132384.2164449.18407700117859190327@gmail.com>


--KXA7XktxuGW70IKZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In airoha_qdma_init_qos_stats(), the Tx-fwd counter was incorrectly
> using register index (i << 1) instead of ((i << 1) + 1). This caused
> the Tx-fwd configuration to overwrite the Tx-cpu configuration for
> each QoS channel, resulting in incorrect QoS statistics.
>=20
> Fix by using the correct register index ((i << 1) + 1) for Tx-fwd
> counter configuration.
>=20
> Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
> Signed-off-by: Wayen Yan <win847@gmail.com>

Is this a patch you already sent? IIRC I have acked it.

Regards,
Lorenzo

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 31cdb11cd7..329988a840 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1256,7 +1256,7 @@ static void airoha_qdma_init_qos_stats(struct airoh=
a_qdma *qdma)
>  			       FIELD_PREP(CNTR_CHAN_MASK, i));
>  		/* Tx-fwd transferred count */
>  		airoha_qdma_wr(qdma, REG_CNTR_VAL((i << 1) + 1), 0);
> -		airoha_qdma_wr(qdma, REG_CNTR_CFG(i << 1),
> +		airoha_qdma_wr(qdma, REG_CNTR_CFG((i << 1) + 1),
>  			       CNTR_EN_MASK | CNTR_ALL_QUEUE_EN_MASK |
>  			       CNTR_ALL_DSCP_RING_EN_MASK |
>  			       FIELD_PREP(CNTR_SRC_MASK, 1) |
> --=20
> 2.51.0
>=20
>=20

--KXA7XktxuGW70IKZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajFC/QAKCRA6cBh0uS2t
rP97AQDtEwdCs3IEnZIgHzLnaLEcSm4lg1hkzIvKxmjeodohIQEAtMfzpjcqFQ7O
vwSeteUqDl0KbX22ioTCherCWeKZPAA=
=1Wk4
-----END PGP SIGNATURE-----

--KXA7XktxuGW70IKZ--
