Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE5433C507
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781253618; cv=none; b=BlofjdtMUumSsxXE407OWr5UkuWUmqrPkRVodpswwApGgPMMX5Ku0T+STdBdaYBA3fZA3hfmXq0E4hGb2U5MMUNERdSt+5kuZac5YiMB94BO/DiF0VtLytLZoyIxK3Zv6wtTzbnD8kMh3dK0Gpmyi8ihenLYLSrl5yxuNOhNuo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781253618; c=relaxed/simple;
	bh=vghZqItw3HdNVTNK6kC02FoqYsvnm+1ybMRAyDkLBmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMAetLFC1ehZZtM06wHBTJFlnuFCXpdlaU7XlkPPm7oB4+lS2S9yTK4Pfx5U7KveTApShdhA7O+XOXa2A+uF9DSMrjAQPxjgLprn+boCdWhwwK016ctC0zgSl7uM8aJxzGJ5PKQF1JP45ARzwy9gL6ahSSths6vBagTKNghdeec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvCMVaes; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvCMVaes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BD71F000E9;
	Fri, 12 Jun 2026 08:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781253617;
	bh=IqyBluiRoUQtAELX3j26vahFC6LntA86G4+ojNuG26M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kvCMVaesKA1Y5Cz2dqaIPHFzz2MBlzpD77udgjrekZF7CuhZBDY6tL1Ws+mE5ijP5
	 sKZcqMGQ707lAx0o6dEBwEdjCHcQC/Ktcs4XryQ6MyVndGQ2UN3FCeM+rKgxeKOYbk
	 X3Nmliw9y9jWa7Eq5/VWAQmokdpBVeb7oBrnQBrfT5RgNj4+x2oHqykq3LVX1G20gk
	 KkWeYmBwc+8Gr6+rpM16ZOamK5PGZEy8JxXO0BrxKPscO0htzK9TDJkgaUFXCQFWNx
	 yCI4YHs57SRDu6vqfpuC6k/hQkznKW4itOwqkWHuIRHLP2b2N3fJINg540T3PWJlq7
	 KxTshZqr1gGmQ==
Date: Fri, 12 Jun 2026 10:40:14 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "Wayen.Yan" <win847@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: airoha: Fix variable shadowing in
 airoha_ppe_flush_sram_entries()
Message-ID: <aivF7p3KdCvyOjtf@lore-desk>
References: <6a2b40e4.4dd82583.3a5c46.e52f@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d0t5x//dz2MbmcOP"
Content-Disposition: inline
In-Reply-To: <6a2b40e4.4dd82583.3a5c46.e52f@mx.google.com>


--d0t5x//dz2MbmcOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In airoha_ppe_flush_sram_entries(), the inner "int err" declaration
> shadows the outer "err" variable. When airoha_ppe_foe_commit_sram_entry()
> fails and the loop breaks, the function returns the outer err which is
> always 0, silently swallowing the error.
>=20
> Remove the inner declaration so the assignment writes to the outer
> variable and errors are properly propagated.
>=20
> Fixes: 620d7b91aadb ("net: airoha: ppe: Flush PPE SRAM table during PPE s=
etup")
> Signed-off-by: Wayen.Yan <win847@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_ppe.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index 5c9dff6..2b849d4 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -1333,8 +1333,6 @@ static int airoha_ppe_flush_sram_entries(struct air=
oha_ppe *ppe)
>  	int i, err =3D 0;
> =20
>  	for (i =3D 0; i < sram_num_entries; i++) {
> -		int err;
> -
>  		memset(&hwe[i], 0, sizeof(*hwe));
>  		err =3D airoha_ppe_foe_commit_sram_entry(ppe, i);
>  		if (err)

I guess we can drop the outer err and just return here in case of error.
What do you think?

Regards,
Lorenzo

> --=20
> 2.51.0
>=20
>=20

--d0t5x//dz2MbmcOP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaivF7gAKCRA6cBh0uS2t
rIP+AQC/Wi/u5DcCTnudAHlBHNxkjod5I9HyuAD0KavETP4CfwEAgkSgJBvnADhY
cclhUUfL6oWf1d10T0OCN6Uu+GXLMQE=
=rHCo
-----END PGP SIGNATURE-----

--d0t5x//dz2MbmcOP--
