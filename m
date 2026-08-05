Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E25E41A51C
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923958; cv=none; b=CDHwqNNZGHiluVkh/oac4S8+7JeAWG9JWRs3o67wUOFuGqSQc82Aln0gYg21VwmXXLBeGjOS1TYrCSLZwMXyaj2WlnT15Q5+eGaOA7Kl5BpCujtkdE7gU/6g7KS+enQVSI+mPcYWT/8PXv58UaNShLysBh2vRz5Rq03zy+HOVzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923958; c=relaxed/simple;
	bh=6z14D7RpE9yxiB+tVWfo1lCmJEVbFyAS6GrJFiDKLhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMQiHm13a84IOBbV9zQ5dW0CXdRlMYELARNPOh6YdLlVDPBiuPsnqgHbgDtnyksp5K5FlHezim8TQMFVhqxRnH1uTK3RvvC+n2qw9gBPyZTXfFke1OBYeCNn6aEzkJ2lyKLby6ojRYKrC3//sVnlCMQX2GEjsaC8K6jx7eA/LWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiBxFpzt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiBxFpzt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5F21F000E9;
	Wed,  5 Aug 2026 09:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785923957;
	bh=ghtUzlFRWUUGu8ZsJmgzWJeSIDOJKHfpz5iFtgTk1jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FiBxFpztljXX18c2a222ItNUCA7gRkrA5EdoZb+yMDPOeKqmYWaTHflTPRlfijc7x
	 pbm2E2PHyHSvIEbXqYJi0aBzIvXUDTP4lQVl2FaBFXKQLwx6t5rhwEdZ1tmJE8SFmk
	 IKa0rW5DJ0pP2fOTCQyuBSBgTYFIEqoR2oFbRvdduH2J4/dJ12Y8k+DpKw9Pn7Xr3P
	 P6B7kcHxJINZi1xj9FKO8i/eZPJipJKM36za3uDU2b0nMLX0EMdaNHpdAMa9ifY6EV
	 RCcseK/nDSTnqQltrbaQN2lW2afLgMzlI3IHXeE2xFeogBvsNfMVaZ3Gd4kLkGoy7h
	 aagIS05dIdgyQ==
Date: Wed, 5 Aug 2026 11:59:14 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Daniel Pawlik <pawlik.dan@gmail.com>
Cc: netdev@vger.kernel.org, win847@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: airoha: npu: use coherent DMA for mailbox messages
Message-ID: <anMJcp-R17Hx6DQL@lore-desk>
References: <20260805070851.2885888-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ex/oSxVbmvjUCGv9"
Content-Disposition: inline
In-Reply-To: <20260805070851.2885888-1-pawlik.dan@gmail.com>

--Ex/oSxVbmvjUCGv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Commit 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox
> buffer") switched airoha_npu_send_msg() to DMA_BIDIRECTIONAL so
> non-coherent CPUs invalidate caches before reading NPU GET responses.
>=20
> On EN7581 + MT7996 that change regresses probe: the mailbox completes
> successfully, but WLAN_FUNC_GET_WAIT_NPU_VERSION still reads as 0.0 and
> mt76 never binds NPU offload. Healthy boards report 0.1111.
>=20
> Mailbox messages are tiny and already copied by the caller. Bounce
> through dma_alloc_coherent() so the CPU observes the NPU-written
> response without relying on streaming DMA direction.
>=20
> Verified on Quantum Fiber W1700K (EN7581 + MT7996).
>=20
> Fixes: 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox buff=
er")
> Assisted-by: Cursor:composer-2
> Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_npu.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ether=
net/airoha/airoha_npu.c
> index b679bed952de..d2f6c9c084b8 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -166,12 +166,21 @@ static int airoha_npu_send_msg(struct airoha_npu *n=
pu, int func_id,
>  	u16 core =3D 0; /* FIXME */
>  	u32 val, offset =3D core << 4;
>  	dma_addr_t dma_addr;
> +	void *dma_buf;
>  	int ret;
> =20
> -	dma_addr =3D dma_map_single(npu->dev, p, size, DMA_BIDIRECTIONAL);
> -	ret =3D dma_mapping_error(npu->dev, dma_addr);
> -	if (ret)
> -		return ret;
> +	/*
> +	 * Mailbox payloads are small and bidirectional (CPU sets the
> +	 * request, NPU writes the response). Streaming DMA_BIDIRECTIONAL
> +	 * mapping regresses EN7581+MT7996: MBOX reports success but
> +	 * WLAN_FUNC_GET_WAIT_NPU_VERSION still reads as 0.0. Use a
> +	 * coherent bounce buffer so the CPU always sees the NPU response.
> +	 */
> +	dma_buf =3D dma_alloc_coherent(npu->dev, size, &dma_addr, GFP_ATOMIC);
> +	if (!dma_buf)
> +		return -ENOMEM;

I tried to reproduce the issue locally, but it does not occur for me.
Moreover, I guess dma_alloc_coherent() is not the right approach since it is
usually used for long-standing descriptors (e.g. tx/rx DMA descriptor rings=
).
Can you please provide more details about the hw you are running?

Regards,
Lorenzo

> +
> +	memcpy(dma_buf, p, size);
> =20
>  	spin_lock_bh(&npu->cores[core].lock);
> =20
> @@ -191,7 +200,9 @@ static int airoha_npu_send_msg(struct airoha_npu *npu=
, int func_id,
> =20
>  	spin_unlock_bh(&npu->cores[core].lock);
> =20
> -	dma_unmap_single(npu->dev, dma_addr, size, DMA_BIDIRECTIONAL);
> +	if (!ret)
> +		memcpy(p, dma_buf, size);
> +	dma_free_coherent(npu->dev, size, dma_buf, dma_addr);
> =20
>  	return ret;
>  }
> --=20
> 2.55.0
>=20

--Ex/oSxVbmvjUCGv9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCanMJcgAKCRA6cBh0uS2t
rKWZAQCujgPJTZmcbTNA0/ICmZK2kc73Mi+wEdDGBnP49Ka4iQD+ONR1+zHNLbXx
445U0plbBScvVOcAFOFBID5pan51xws=
=gjZ7
-----END PGP SIGNATURE-----

--Ex/oSxVbmvjUCGv9--
