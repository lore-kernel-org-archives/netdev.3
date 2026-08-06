Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94EB235BE2
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786003347; cv=none; b=LuiMJDFFZX8XR1/wNkgphr1/hBDQGYCD1xehnnbtcsxaFCe3OZLkh5oesgkab1QshRutqz9TBpxySG15x8u8idjhQWOgz9KnS9aFmWggkfeGUoawDPluFMCIdlaZWRih64DsMydAG2zrLdPyC1t7lOht7WKhtWsEBUeO0LD98JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786003347; c=relaxed/simple;
	bh=nJtkqluur3G0up+EVhrevKqANhzQ9aabw7RDIDHZCUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyp8nESFuxAgaaabTYfaNTjxN6N/H3+kszc+hXJSDpuPBX87lbspNFlf49mJrT2WWeNRryLrTlsOeExxbh8p4CCzxpc4Tjt8EA9VNNpI8LCNl+AZ3ZrO4bASn2bsey+4Awuoedd+fStKvZMEfqBH4ctRbtjSYBtAkwGCdrOaL7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egYFd4uf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egYFd4uf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84481F000E9;
	Thu,  6 Aug 2026 08:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786003345;
	bh=G4mBrcplMMkvLk0VtoqgZz3oJibjvqjIg0cwoQjSO8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=egYFd4uftcou2OI3Py4pJ/G23qlqTVM4ey/w9Mi1+qLdnuY5sybr+2Yr5Habu9JP+
	 79UxBnx0Rbe3bkI7Ne+gw1/g2HAm4rKTnVL5Ud6qSqG0PMzUqF6fUGXtK4Yi8Q6g/L
	 wG7/QeFKeT3f99W1lT4EveCsdPILhDrMxXguOdftJ/2dpKPM1pId1tOvY0Z6453qpb
	 k+Derjlv5TM/omVIzJN+R2H/rAwdPRBxaCBhqKxo3CzU46TbrYFQtqSHUwlp0Wu35E
	 yR75vEMfLOCFMSYn0rNUfNL89WpSL2cZ4+3RFpyZjWkQMfX+blmgYD7O/UwDnklD5Y
	 LUWS4yBbBVGBA==
Date: Thu, 6 Aug 2026 10:02:23 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Daniel Pawlik <pawlik.dan@gmail.com>
Cc: netdev@vger.kernel.org, win847@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v2] net: airoha: npu: use coherent DMA for mailbox
 messages
Message-ID: <anQ_jxeuxFH4vf1i@lore-desk>
References: <20260805070851.2885888-1-pawlik.dan@gmail.com>
 <20260806072601.1815487-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9tofzTosBcZJpMvZ"
Content-Disposition: inline
In-Reply-To: <20260806072601.1815487-1-pawlik.dan@gmail.com>

--9tofzTosBcZJpMvZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 06, Daniel Pawlik wrote:
> Commit 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox
> buffer") switched airoha_npu_send_msg() to DMA_BIDIRECTIONAL so
> non-coherent CPUs invalidate caches before reading NPU GET responses.
>=20
> On EN7581 + MT7996 that change regresses probe: the mailbox completes
> successfully, but WLAN_FUNC_GET_WAIT_NPU_VERSION still reads as 0.0 and
> mt76 never binds NPU offload. Healthy boards report 0.1111.
>=20
> airoha_npu_send_msg() is also used from PPE foe_commit under
> spin_lock_bh(), so per-message dma_alloc_coherent(GFP_ATOMIC) is a poor
> fit. Allocate one device-managed coherent bounce buffer at probe and
> reuse it under the existing per-core mailbox lock. That also keeps the
> buffer valid if the NPU completes a write after a mailbox timeout.
>=20
> Verified on Quantum Fiber / Gemtek W1700K (EN7581 + MT7996).

Hi Daniel,

I tested the issue you reported on a very similar hw (reported below) and it
works fine for me
- EN7581-mmc
- MT7996 SoC

@Christian: Is the issue occurring for you? I guess we should debug it a bit
more.

>=20
> Fixes: 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox buff=
er")
> Link: https://patchwork.kernel.org/project/linux-mediatek/patch/202608050=
70851.2885888-1-pawlik.dan@gmail.com/
> Assisted-by: Cursor:composer-2
> Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
> ---
> v2:
> - allocate one coherent mailbox buffer at probe and reuse it under the
>   per-core lock instead of per-message dma_alloc_coherent(GFP_ATOMIC)
>=20
>  drivers/net/ethernet/airoha/airoha_npu.c  | 31 +++++++++++++++++------
>  include/linux/soc/airoha/airoha_offload.h |  4 +++
>  2 files changed, 27 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ether=
net/airoha/airoha_npu.c
> index b679bed952de..dfa09fed907e 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -23,6 +23,8 @@
>  #define NPU_EN7581_FIRMWARE_RV32_MAX_SIZE	0x200000
>  #define NPU_EN7581_FIRMWARE_DATA_MAX_SIZE	0x10000
>  #define NPU_DUMP_SIZE				512
> +/* Enough for struct ppe_mbox_data and small WLAN TLV payloads */
> +#define AIROHA_NPU_MBOX_SIZE			256

Are you sure this is enough for all possible messages?

> =20
>  #define REG_NPU_LOCAL_SRAM		0x0
> =20
> @@ -165,17 +167,24 @@ static int airoha_npu_send_msg(struct airoha_npu *n=
pu, int func_id,
>  {
>  	u16 core =3D 0; /* FIXME */
>  	u32 val, offset =3D core << 4;
> -	dma_addr_t dma_addr;
>  	int ret;
> =20
> -	dma_addr =3D dma_map_single(npu->dev, p, size, DMA_BIDIRECTIONAL);
> -	ret =3D dma_mapping_error(npu->dev, dma_addr);
> -	if (ret)
> -		return ret;
> +	if (size > AIROHA_NPU_MBOX_SIZE)
> +		return -EINVAL;
> =20
> +	/*
> +	 * Mailbox payloads are bidirectional (CPU request, NPU response).
> +	 * On EN7581+MT7996, streaming DMA_BIDIRECTIONAL against the
> +	 * caller kzalloc() buffer can leave WLAN_FUNC_GET_WAIT_NPU_VERSION
> +	 * reading as 0.0 despite MBOX success. Reuse a probe-time coherent
> +	 * bounce buffer under the per-core lock (also used from PPE
> +	 * foe_commit under atomic context).
> +	 */
>  	spin_lock_bh(&npu->cores[core].lock);
> =20
> -	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(0) + offset, dma_addr);
> +	memcpy(npu->mbox_buf, p, size);

Even if it is a just a theoretical issue (we just use core 0 at the moment)=
, we
should have a per-core buffer since we can theoretically have concurrent me=
ssages
on different cores.

> +
> +	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(0) + offset, npu->mbox_dma);
>  	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(1) + offset, size);
>  	regmap_read(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, &val);
>  	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, val + 1);
> @@ -189,9 +198,10 @@ static int airoha_npu_send_msg(struct airoha_npu *np=
u, int func_id,
>  	if (!ret && FIELD_GET(MBOX_MSG_STATUS, val) !=3D NPU_MBOX_SUCCESS)
>  		ret =3D -EINVAL;
> =20
> -	spin_unlock_bh(&npu->cores[core].lock);
> +	if (!ret)
> +		memcpy(p, npu->mbox_buf, size);

I do not like this double copy here. I guess we could pass a pointer for the
reply buffer to airoha_npu_send_msg() and avoid the copy in
airoha_npu_wlan_msg_get(). What do you think?

> =20
> -	dma_unmap_single(npu->dev, dma_addr, size, DMA_BIDIRECTIONAL);
> +	spin_unlock_bh(&npu->cores[core].lock);
> =20
>  	return ret;
>  }
> @@ -770,6 +780,11 @@ static int airoha_npu_probe(struct platform_device *=
pdev)
>  	if (err)
>  		return err;
> =20
> +	npu->mbox_buf =3D dmam_alloc_coherent(dev, AIROHA_NPU_MBOX_SIZE,
> +					    &npu->mbox_dma, GFP_KERNEL);
> +	if (!npu->mbox_buf)
> +		return -ENOMEM;
> +
>  	err =3D airoha_npu_run_firmware(dev, base, &res);
>  	if (err)
>  		return dev_err_probe(dev, err, "failed to run npu firmware\n");
> diff --git a/include/linux/soc/airoha/airoha_offload.h b/include/linux/so=
c/airoha/airoha_offload.h
> index 7589fccfeef6..afd481233489 100644
> --- a/include/linux/soc/airoha/airoha_offload.h
> +++ b/include/linux/soc/airoha/airoha_offload.h
> @@ -179,6 +179,10 @@ struct airoha_npu {
> =20
>  	struct airoha_foe_stats __iomem *stats;
> =20
> +	/* Coherent bounce buffer for mailbox cmd/rsp (airoha_npu_send_msg) */
> +	void *mbox_buf;
> +	dma_addr_t mbox_dma;

you need to move them in airoha_npu_core struct. Please rename them to:

	struct airoha_npu_core {
		...
		void *buf;
		dma_addr_t addr;
		...
	};

Regards,
Lorenzo

> +
>  	struct {
>  		int (*ppe_init)(struct airoha_npu *npu);
>  		int (*ppe_deinit)(struct airoha_npu *npu);
> --=20
> 2.55.0
>=20

--9tofzTosBcZJpMvZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCanQ/jwAKCRA6cBh0uS2t
rEesAP9YwI3B8KcL0t7IuGBi4EsnYjyf9b2tfEZ1b4GfKQTmuwEAvsXTkH8KLaTN
02bD6Xwo5rgejGryitnWS/humdqftwM=
=Fp5W
-----END PGP SIGNATURE-----

--9tofzTosBcZJpMvZ--
