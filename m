Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D581EFF93
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515805; cv=none; b=TAPOmyak+P8IHSWzpYbeDtAAkxzNFJfAd0IxN/rG9vh3T/kfrdJpU+R9/pBYDkQx/2uDnYMcwhlJNJMFuLChQoh6bDjTQJyFUGWF0CDshHnwsyK1QBqN2ZOTCyDC4BreoEU4avn4kRii8bnFYnJLXs5aKDGwSpgCaSTHINiaMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515805; c=relaxed/simple;
	bh=PKHW0WcCeH4hbjwkHqZQZfJ391i/CVkS6YBEpZka+W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIiSnMCaZErtfj2fo5lVw93yuk1ZQdhbOIgsSrhvt4bGUumcCjwGxNk+FKLCkjK6wvmKg1F+T9R8vhhv7kAjUqWo6LfjJvvN1YXnsg9jlWDeWV1lIj17tEoRuH+a/ImMwWvJY+EAU03DOlV75v1OMRRRsXcsBxBagHoBQZUeG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyYAYbPx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyYAYbPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2469B1F000E9;
	Wed,  8 Jul 2026 13:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783515803;
	bh=3BmCoU/mJxpggR/8PGM1XrH38msRz7NT+nvS7+P+Qc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dyYAYbPxsIIELLH3Qz6lbSbauelb937sO2KTTNPuNZbeIxrTHzIP6FGLvW1KGkvoe
	 n4ajs4thOSB3QRsXi5WEK9Jun+If8h6v35ZAWNgDviRR29DJ+FBEm+fOsbtZ57WLiH
	 yqOlgtx6h3n02vpskNKi4CeNvW7LNNoz1xTuPpKqdewUwoO62QS80q1qRuk6lY7BYU
	 h3hSBYviXOq7hm7xjaEAEz+j7ERQbC/mE2NRunm9o7gRg8v5MfEBJvp11tOfS22XEf
	 6A3HTp1KF5aRofksx0irwvcT3KBTZy3tgMqX7XSvS5a4YUUdchaKRaC3rEdxs5N47l
	 NRZYwPOaE7XHw==
Date: Wed, 8 Jul 2026 15:03:21 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: airoha: Fix potential use-after-free in
 airoha_ppe_deinit()
Message-ID: <ak5KmSbAQJXcU3sW@lore-desk>
References: <178351022574.97989.6880403520276841703@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3aCkLgBstNRB5eAc"
Content-Disposition: inline
In-Reply-To: <178351022574.97989.6880403520276841703@gmail.com>


--3aCkLgBstNRB5eAc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> airoha_ppe_deinit() replaces the NPU pointer with NULL via
> rcu_replace_pointer() but does not wait for existing RCU readers
> to exit before calling ppe_deinit() and airoha_npu_put(). This can
> cause a use-after-free if a reader in an RCU read-side critical
> section still holds a reference to the NPU when it is freed.
>=20
> The init path (airoha_ppe_init) already calls synchronize_rcu()
> after rcu_assign_pointer(), but the deinit path introduced in
> commit 6abcf751bc08 ("net: airoha: Fix schedule while atomic in
> airoha_ppe_deinit()") omitted the matching barrier when switching
> from rcu_read_lock()/rcu_dereference() to rcu_replace_pointer().
>=20
> Add synchronize_rcu() before ppe_deinit() to ensure all existing
> RCU readers have completed before the NPU resources are released.
>=20
> Fixes: 6abcf751bc084804a9e5b3051442e8a2ce67f48a ("net: airoha: Fix schedu=
le while atomic in airoha_ppe_deinit()")
> Signed-off-by: Wayen Yan <win847@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/airoha/airoha_ppe.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index e7c78293002a..f6396925722d 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -1659,6 +1659,7 @@ void airoha_ppe_deinit(struct airoha_eth *eth)
>  	npu =3D rcu_replace_pointer(eth->npu, NULL,
>  				  lockdep_is_held(&flow_offload_mutex));
>  	if (npu) {
> +		synchronize_rcu();
>  		npu->ops.ppe_deinit(npu);
>  		airoha_npu_put(npu);
>  	}
> --=20
> 2.51.0
>=20
>=20

--3aCkLgBstNRB5eAc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCak5KmQAKCRA6cBh0uS2t
rO4SAQC9XjKbr4FL6USCpb+vk0nuGcS4kQNSPUegG0T8eqjCtQD7B3MdOSiy8IBZ
Vj4KmUaxBPWe3TLxHe1uwKv127c+lQA=
=ioCF
-----END PGP SIGNATURE-----

--3aCkLgBstNRB5eAc--
