Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85408293C4E
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261893; cv=none; b=Y2xywg928xF6sMy4g9mV5K07pRGJ2qdRxxzYcvxXjAHQoARix6bs/bYj8C4mlm42hugzEhdGZ6C0HlfVYoFyDJMa7/zxmx6I51X7PX+ZmwOurHwl2QSpitQavx+tZIvzSM2E04YJrIM8ulESfm6VpTU2pS6e95Ki9jj3DLnb2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261893; c=relaxed/simple;
	bh=aYPPk2MSCThjvVtdhmTWelJpbGbi6xdJqElxswjMkU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOCaJwM6AoCW/tHw1MyZTfvimZssenhfTCXdJeE7dNzpr2LvAnmU5Y8TvUIN3KRIg7BNrJeH20OrN2g3n3MfDLoY4Edvgq8HC0Df+LiUkjkgVez3fdbcSMFdxJpNgDh9y8apQ1qh9dq68Tk0yQfS4beN0Tr5xav0x//vGJEJp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVyaXDwq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVyaXDwq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30471F000E9;
	Fri, 12 Jun 2026 10:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781261892;
	bh=h0xvL3Sj/8gibbE41ajWqX2gvL5U/maoaJkeOu32Ghk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bVyaXDwqaLqscmgx5y0KXHr8sUoZrkKYHau+S8zRzQaBA+TGA8e5P7mmeyWbIqHBC
	 dJeo0L+MPjk10rBC2bUz9iuq2az9Sh5Sc/NYAux7MH5NFrO8TUy4SDUrZ6WgyjQ2Cx
	 CM1q0+9bt9yP5sI+m84T41N6UX4pADMdk3Kvc3lHc4flAbH+2wp4gUpZIiGB66jOLb
	 WXN3n43ab6ZuhyapY5cb+B959niE83KaRK5VNFPCTedBvBU85n4NFyNXbgqxVqJeon
	 4crhYb8mfZGPqq0ex+YiJi2g7mYjwg0SEAAMDw0lnMWSEF4My1m22TnrGT/l0FeNyP
	 3zBImpEWkrkhQ==
Date: Fri, 12 Jun 2026 12:58:09 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "Wayen.Yan" <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] net: airoha: Fix debugfs new-tuple display for IPv4
 ROUTE entries
Message-ID: <aivmQX_f3AcPEARN@lore-desk>
References: <6a2be54b.ef98c1b2.3c3224.2ed8@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YwPDZJBwo+4sBM3J"
Content-Disposition: inline
In-Reply-To: <6a2be54b.ef98c1b2.3c3224.2ed8@mx.google.com>


--YwPDZJBwo+4sBM3J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In airoha_ppe_debugfs_foe_show(), the second switch statement falls
> through from PPE_PKT_TYPE_IPV4_HNAPT/DSLITE to PPE_PKT_TYPE_IPV4_ROUTE,
> accessing hwe->ipv4.new_tuple for all three types. However, IPv4 ROUTE
> (3-tuple) entries do not contain a valid new_tuple =E2=80=94 this field i=
s only
> meaningful for NATted flows (HNAPT/DSLITE). For ROUTE entries, the
> memory at the new_tuple offset holds routing information, not NAT data,
> so displaying "new=3D" produces garbage output.
>=20
> Display new_tuple only for HNAPT and DSLITE, and let IPV4_ROUTE fall
> through to the default case.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Fixes: 3fe15c640f38 ("net: airoha: Introduce PPE debugfs support")
> Link: https://lore.kernel.org/netdev/6a2b40ea.4dd82583.3a5c46.e5a2@mx.goo=
gle.com/
> Signed-off-by: Wayen.Yan <win847@gmail.com>
> - Drop redundant PPE_PKT_TYPE_IPV4_ROUTE case, let it fall to default
> Changes in v2:
>=20
> ---
>  drivers/net/ethernet/airoha/airoha_ppe_debugfs.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c b/drivers/n=
et/ethernet/airoha/airoha_ppe_debugfs.c
> index 0112c41..e46a985 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
> @@ -121,8 +121,6 @@ static int airoha_ppe_debugfs_foe_show(struct seq_fil=
e *m, void *private,
>  		case PPE_PKT_TYPE_IPV4_DSLITE:
>  			src_port =3D &hwe->ipv4.new_tuple.src_port;
>  			dest_port =3D &hwe->ipv4.new_tuple.dest_port;
> -			fallthrough;
> -		case PPE_PKT_TYPE_IPV4_ROUTE:
>  			src_addr =3D &hwe->ipv4.new_tuple.src_ip;
>  			dest_addr =3D &hwe->ipv4.new_tuple.dest_ip;
>  			seq_puts(m, " new=3D");
> --=20
> 2.51.0
>=20
>=20

--YwPDZJBwo+4sBM3J
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaivmQQAKCRA6cBh0uS2t
rNNdAQCQ/7Vjz3KMz+tY+DP5RN7NG/ZMq4VyS3WwE9J58vKl8QD/YZw8JSh2gXeT
kY8fTc1iqQyz/qbbK8hGsaleQXSGcwA=
=aYth
-----END PGP SIGNATURE-----

--YwPDZJBwo+4sBM3J--
