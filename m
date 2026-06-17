Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA553AFD1C
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680434; cv=none; b=K/u2t36pABBP0jbQIJ+x9xUSoyUhCw46EZ5R44EqdJbjmITaP+FR6NEVWMhEVXSQd4cfv9RduvndjOVnl9EXhkU8AxGbiiM2g2qHo5b9+y3yAy4qDXjhirN3iQkaAajPTVPgLS+TZpRZYmEWepzTsg/1itIbrSUYQ51lG5Tu9Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680434; c=relaxed/simple;
	bh=zyQ8itX7O/KNdNgCPi6XbSXH95QBQbF1QrUWxW9OXNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAgqTDZNyK+gCAIF6ZbAN6g+C/L1YtlcJwTeKcSifiUciPJO8c7OCI4tHtuIW5rKMQlmZZqKEXXYWWBFTkqh05EJtJsKJ4FmLtbMsPEkBe81qpIgY9bWy1m6Qgu/0WvD+CWm/xvjRyDYdswEh7BDV9muDrk93qf6DHsSzl3PNUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcFrbHfy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcFrbHfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E511F000E9;
	Wed, 17 Jun 2026 07:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781680433;
	bh=x1oewAmKIOweGpwkRj7/2QKkESSIVukJ2iPbPD417jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HcFrbHfyf+xRVfrLao6nlRPe/js6angNTvuPM5tKyuxdGQFVPAaXmxutbHqtwQlFg
	 5rw0fLb2BchNIffq038EJOvxETHgQ/ob9SVnoy6Wqo4e1+uJoqwpha9D6ukpZf7cg3
	 gtS4emT756CuPscYS3LiHPtw7Vn5XU+uAXCBT0o4bs8NwlBucyaiRPDugAeCTO62Vy
	 TKDWJVHwfC3f3JOc8qv2ZiLTh8CqbF6AkmR8z2M6NVl9MXu28yLFw5HZLJxr5DTrvx
	 K0Rhe+KnbEtEHqclTLMiLKeMqlJmnngZN9SOoFEymCrn74wmsLrxUByhhB0WCd/yG0
	 bQmYtug2OQHSg==
Date: Wed, 17 Jun 2026 09:13:51 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: airoha: Fix off-by-one error in HTB rate-limit
 channel removal
Message-ID: <ajJJL06Wes9vPuvW@lore-desk>
References: <178166483303.2209640.10761097847073356089@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XWx7r5PR0vbIn/gZ"
Content-Disposition: inline
In-Reply-To: <178166483303.2209640.10761097847073356089@gmail.com>


--XWx7r5PR0vbIn/gZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In airoha_tc_remove_htb_queue(), the rate-limit was being cleared
> using (queue + 1) instead of queue, causing:
> - The original channel rate-limit configuration to remain active
> - The next channel to be incorrectly disabled
> - Potential out-of-bounds access when queue =3D=3D 3 (channel 4)
>=20
> The alloc path (airoha_tc_htb_alloc_leaf_queue) correctly uses
> channel (0..3), but the remove path incorrectly added 1.
>=20
> Fix by using queue directly to match the alloc and rollback paths.
>=20
> Fixes: ef1ca9271313 ("net: airoha: Add sched HTB offload support")
> Signed-off-by: Wayen Yan <win847@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 31cdb11cd7..02807b3967 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2805,7 +2805,7 @@ static void airoha_tc_remove_htb_queue(struct net_d=
evice *dev, int queue)
>  	struct airoha_gdm_port *port =3D netdev_priv(dev);
> =20
>  	netif_set_real_num_tx_queues(dev, dev->real_num_tx_queues - 1);
> -	airoha_qdma_set_tx_rate_limit(dev, queue + 1, 0, 0);
> +	airoha_qdma_set_tx_rate_limit(dev, queue, 0, 0);
>  	clear_bit(queue, port->qos_sq_bmap);
>  }

Please hold on with this patch, I am aware of the bug and the fix is alread=
y in
my queue [0]. I am just waiting the net-next to be merged into net in order=
 to
avoid merge conflicts.

Regards,
Lorenzo

[0] https://github.com/LorenzoBianconi/net-next/commits/airoha-qos-fixes-fo=
r-net/

> =20
> --=20
> 2.51.0
>=20
>=20

--XWx7r5PR0vbIn/gZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajJJLwAKCRA6cBh0uS2t
rD7nAPoCb+zHRBgNK1OXNfE3oJB6ZsB3wGlp0uwMegk8VHZybAEAyc9hJ66vm9du
k+x4PfTwYQuMtWYGQ8SCRGCY7Ml3rAw=
=5sdU
-----END PGP SIGNATURE-----

--XWx7r5PR0vbIn/gZ--
