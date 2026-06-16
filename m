Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322AE18EB0
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613244; cv=none; b=Uvbia1uOEWh7cqtS/mXRZldYd8+UVIa4onXFpI/gk5P8Mu+85sQOfGVAo0Kf5RbkRfudWYw4wcdxbseSRmcwqwWVnKog5trx6HJaBv7k62S+ulGCDEzQWAZKlH5O1IZpSL9OwndLWAPejBHjlrFc4KJkgMcHJqEZ6BTKdiNe730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613244; c=relaxed/simple;
	bh=H3vvThjdPLSfMorsR4Wldt2rgh9pNoyFI14XsuAPdwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkDKPs3PcBGtCoE8P5C4/EWka8OIl8+UcqImRu1QxtEBo2DuroQq7UqFo3TJ1VKzTSQRsEO/Ko3ILxT9b1NC7GLb+Ra6/vJFdOaYcRG+szf75SUcekEP1aHd23zb0a2bxKWjvcwIS3idsf2o0IG48gAr6Qf58wSU8rQZVhr3vrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORbZDDXR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORbZDDXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513B81F000E9;
	Tue, 16 Jun 2026 12:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781613242;
	bh=AU0Gj7255AvQ5CwD1pZx8WKNH581mx4ihVIONMOZiTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ORbZDDXRXZDF5r27bqtCDyNWhYxW83M3PZV1M1XhHFzVDjuThzl/q2lyxnx6ZOHdB
	 W96WTV8hCRBbFpX/UEh0SJaYf05GYlJmmpmEHPbkGmD/nFqQSRVQzAvb4X90qrElQb
	 NFNztCewp7PGZ5DDafiMXFX9gmcDig48e5TK3fpvdD5B6DcVKK1L0jgDlr+HtfN0KI
	 rRl8vBqimk7bMiiOa29i5hVKTKfzz5VfZe0xzDxuQp1DA1cY3/WFZPeQCrlApOLQJj
	 9hqrRnv4pKQNGHQJZwjW7vBfET+jVp4gRwR5rUYAv74Tg6Z9sFCCgMd4tHJkMojTvZ
	 JRO000ngSqyRQ==
Date: Tue, 16 Jun 2026 14:34:00 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] [net] net: airoha: fix foe_check_time allocation size
Message-ID: <ajFCuOEGT0iJttOh@lore-desk>
References: <178161119471.2163752.14373384830691569758@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hWXa442R11LoZs39"
Content-Disposition: inline
In-Reply-To: <178161119471.2163752.14373384830691569758@gmail.com>


--hWXa442R11LoZs39
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> foe_check_time is declared as u16 pointer but was allocated with
> only ppe_num_entries bytes instead of ppe_num_entries * sizeof(u16).
>=20
> When airoha_ppe_foe_verify_entry() is called with hash >=3D ppe_num_entri=
es/2,
> it writes beyond the allocated buffer, causing heap buffer overflow and
> potential kernel crash.
>=20
> Fixes: 6d5b601d52a2 ("net: airoha: ppe: Dynamically allocate foe_check_ti=
me array in airoha_ppe struct")
> Signed-off-by: Wayen Yan <win847@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/airoha/airoha_ppe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index 5c9dff6bcc..8fb8ecf909 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -1578,7 +1578,8 @@ int airoha_ppe_init(struct airoha_eth *eth)
>  			return -ENOMEM;
>  	}
> =20
> -	ppe->foe_check_time =3D devm_kzalloc(eth->dev, ppe_num_entries,
> +	ppe->foe_check_time =3D devm_kzalloc(eth->dev,
> +					   ppe_num_entries * sizeof(*ppe->foe_check_time),
>  					   GFP_KERNEL);
>  	if (!ppe->foe_check_time)
>  		return -ENOMEM;
> --=20
> 2.51.0
>=20
>=20

--hWXa442R11LoZs39
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajFCuAAKCRA6cBh0uS2t
rJMyAP0XT8469xm0evPWy2tNpY3Hl1oAlHZBX0cU5FrHDnoG/QD+IdvSSfUcOGbL
7vS6dZq7Uv9cqvghkCSPUUQf1TxLUQE=
=AVaX
-----END PGP SIGNATURE-----

--hWXa442R11LoZs39--
