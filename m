Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793001059;
	b=Ohsb2Lg1ocTRMCbxjAN9zvPTba5aoshGOii98K7jvJn2mg3DsP1TerOGWZetxUa9U1n+
	 t9sYaF0Qq4XtOoWmBS2W511h1x0r4VxmFImUNgvBzjPWq2pGTazOvJcTq5R2Cr/YMIXwc
	 UB9GHUhEasu/t4p7TAeEEjCsPpbxl0v1R1VxoBezEtBrXKZiaR1/KJSbmCPhC3EH6S0Km
	 eluFco3+SpBIdqFQy2wmxKL4qHbXyOM2SJiUl1GyPBFab+OU3NbX3CATkGWQgVcnlJXwm
	 e1xszZWOt1HOpXpJfntHOkMlIeexxW93KWonkMRUyoebKvUyxb/aMW/UUqast1pKs5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793001059;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GSs4SC8xEvXxzc6tb3y0SEMQgJxrl8ZSN7tzilEn+Eo=;
	b=3pXrX6ErOwh2rDOvhAwD32i3nuAwXsSjWEDDYdSD+LPrvAGece+IF0/Pl6KvZg/0Wn2m
	 zXsoKaaw6fQIzoFHJ/C56Iz+iHN98g1iEgEJr74YoJvlWoeu2RReYc7rmXwEBfm3g81Vn
	 d5zqM8ipCsyBMKNZlbfPx3DkB4qnTpXw0EFGtnAWKGTaEVClWLWMBYyrRRvakNoIVvPrh
	 C2L1yIJGXFbib6q+Zrtd0IATmCcMwUp3tbdYUiuyOitqB0c9aB/+Bp4xx4kxpiR+Jnmpl
	 ttrPIy3+Xqt4Zo2B+UD+Vd6uWOvEHU5TaZ7dDW0Rmq3xlVEbMRQ1kAegErHVxPghcZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kw2YFF7S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E1C606A31B;
	Mon, 26 Oct 2026 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kw2YFF7S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5D21F01825;
	Mon, 26 Oct 2026 07:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793001058;
	bh=GSs4SC8xEvXxzc6tb3y0SEMQgJxrl8ZSN7tzilEn+Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kw2YFF7SxFhk61E+XcdH8MBJU5Uc/8h26oi7o7fo0V/QjOLivTNhOjXd4oxSKtWmo
	 TDOwAnHtn+tupqC3ENK/PzNjzAuLs/6boivj2cb44g4CWLeFmjFfe4qZZ5QyEZEE0U
	 Y7hFDO2UcS8rNGorC8gC8mujud2i42mt59/cPei12CLO0arqT/SyfnYC9ll8w1qdg4
	 hvXmMy/3rpwMEFAWg7D5yGkgdBIDIjew2h8Xr4b0wil4qqxrWe7q70RwTVZwBjrdlI
	 w/vqiZODz5TkQSdyrUG9sScI45GRiKP0qiV9SMNXUBS444al4GYVHiIPikMnoyIfhC
	 osaOufWgrm2zA==
Date: Mon, 26 Oct 2026 08:50:56 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Chris Scott <gilroyscott1970@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, pawlik.dan@gmail.com,
	zhengping.zhang@airoha.com
Subject: Re: [RFC net-next 3/3] net: airoha: npu: use coherent memory for
 mailbox messages
Message-ID: <at8GYPdqto4xoHBl@lore-desk>
References: <20261024154150.45733-1-gilroyscott1970@gmail.com>
 <20261024154150.45733-4-gilroyscott1970@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ks8RgjNESd8HpSsU"
Content-Disposition: inline
In-Reply-To: <20261024154150.45733-4-gilroyscott1970@gmail.com>

--ks8RgjNESd8HpSsU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Daniel Pawlik <pawlik.dan@gmail.com>
>=20
> airoha_npu_send_msg() maps the caller's kzalloc() buffer with
> DMA_BIDIRECTIONAL. These buffers are small and not cacheline aligned,
> so on arm64 the mapping bounces through swiotlb. On a 2 GiB EN7581
> board the default swiotlb pool sits above 0xc0000000 (0xff6cf000 on
> W1700K), outside the 0x80000000-0xbfffffff window the NPU can address;
> higher addresses alias the lower 1 GiB. On W1700K + MT7996 this makes
> WLAN_FUNC_GET_WAIT_NPU_VERSION read back 0.0 and mt76 does not bind
> NPU offload.
>=20
> Allocate one coherent buffer per NPU core at probe and reuse it under
> the per-core mailbox lock. With the previous patch it comes from the
> NPU DMA pool, inside the window. airoha_npu_send_msg() is also called
> from PPE foe_commit under spin_lock_bh(), which rules out a per-message
> GFP_ATOMIC coherent allocation.
>=20
> Add __airoha_npu_send_msg() with an optional reply buffer so GET
> callers copy only the trailing response payload; airoha_npu_send_msg()
> keeps copying the whole buffer back, like the bidirectional mapping.
>=20
> The original version of this patch was written with Cursor (composer-2);
> it was rebased onto net-next and its commit message rewritten with
> Claude (Anthropic).
>=20
> Link: https://lore.kernel.org/r/20260809152813.585797-1-pawlik.dan@gmail.=
com
> Link: https://lore.kernel.org/r/atCRsquzA1UxSpCc@mediatek.com
> Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
> Signed-off-by: Chris Scott <gilroyscott1970@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_npu.c  | 65 +++++++++++++++++------
>  include/linux/soc/airoha/airoha_offload.h |  3 ++
>  2 files changed, 51 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ether=
net/airoha/airoha_npu.c
> index 069fd60680..3d1aa63dd5 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -24,6 +24,12 @@
>  #define NPU_EN7581_FIRMWARE_RV32_MAX_SIZE	0x200000
>  #define NPU_EN7581_FIRMWARE_DATA_MAX_SIZE	0x10000
>  #define NPU_DUMP_SIZE				512
> +/*
> + * Mailbox DMA payload size. Covers sizeof(struct ppe_mbox_data) (28) and
> + * WLAN TLV messages (header + payload); largest in-tree WLAN payload to=
day
> + * is 16 bytes (INODE_TXRX_REG_ADDR). Keep headroom for future commands.
> + */
> +#define AIROHA_NPU_MBOX_SIZE			256
> =20
>  #define REG_NPU_LOCAL_SRAM		0x0
> =20
> @@ -161,23 +167,32 @@ struct wlan_mbox_data {
>  	DECLARE_FLEX_ARRAY(u8, d);
>  };
> =20
> -static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
> -			       void *p, int size)
> +static int __airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
> +				 const void *data, int len, void *reply,
> +				 u16 reply_len)
>  {
> -	u16 core =3D 0; /* FIXME */
> -	u32 val, offset =3D core << 4;
> -	dma_addr_t dma_addr;
> +	struct airoha_npu_core *core =3D &npu->cores[0]; /* FIXME: core */
> +	u32 val, offset =3D 0;
>  	int ret;
> =20
> -	dma_addr =3D dma_map_single(npu->dev, p, size, DMA_BIDIRECTIONAL);
> -	ret =3D dma_mapping_error(npu->dev, dma_addr);
> -	if (ret)
> -		return ret;
> +	if (len > AIROHA_NPU_MBOX_SIZE)
> +		return -EINVAL;
> +
> +	if (reply && reply_len > len)
> +		return -EINVAL;
> +
> +	/*
> +	 * The NPU only reaches DRAM at 0x80000000-0xbfffffff; a streaming
> +	 * mapping of the caller buffer may bounce through swiotlb outside
> +	 * that window. Use the probe-time coherent buffer, which comes from
> +	 * the NPU DMA pool when one is declared.
> +	 */
> +	spin_lock_bh(&core->lock);
> =20
> -	spin_lock_bh(&npu->cores[core].lock);
> +	memcpy(core->buf, data, len);
> =20
> -	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(0) + offset, dma_addr);
> -	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(1) + offset, size);
> +	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(0) + offset, core->addr);
> +	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(1) + offset, len);
>  	regmap_read(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, &val);
>  	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, val + 1);
>  	val =3D FIELD_PREP(MBOX_MSG_FUNC_ID, func_id) | MBOX_MSG_WAIT_RSP;
> @@ -190,13 +205,21 @@ static int airoha_npu_send_msg(struct airoha_npu *n=
pu, int func_id,
>  	if (!ret && FIELD_GET(MBOX_MSG_STATUS, val) !=3D NPU_MBOX_SUCCESS)
>  		ret =3D -EINVAL;
> =20
> -	spin_unlock_bh(&npu->cores[core].lock);
> +	/* Copy the trailing reply_len bytes of the response. */
> +	if (!ret && reply)
> +		memcpy(reply, core->buf + len - reply_len, reply_len);
> =20
> -	dma_unmap_single(npu->dev, dma_addr, size, DMA_BIDIRECTIONAL);
> +	spin_unlock_bh(&core->lock);
> =20
>  	return ret;
>  }
> =20
> +static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
> +			       void *data, int len)
> +{
> +	return __airoha_npu_send_msg(npu, func_id, data, len, data, len);

IIUC airoha_npu_send_msg() is used when we do not expect any reply, correct=
? In
this case we should have:

	return __airoha_npu_send_msg(npu, func_id, data, len, NULL, len);

Am I missing something?

Regards,
Lorenzo

> +}
> +
>  static int airoha_npu_load_firmware(struct device *dev, void __iomem *ad=
dr,
>  				    const char *fw_name, int fw_max_size)
>  {
> @@ -500,9 +523,8 @@ static int airoha_npu_wlan_msg_get(struct airoha_npu =
*npu, int ifindex,
>  	wlan_data->func_type =3D NPU_OP_GET;
>  	wlan_data->func_id =3D func_id;
> =20
> -	err =3D airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data, len);
> -	if (!err)
> -		memcpy(data, wlan_data->d, data_len);
> +	err =3D __airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data, len,
> +				    data, data_len);
>  	kfree(wlan_data);
> =20
>  	return err;
> @@ -794,6 +816,15 @@ static int airoha_npu_probe(struct platform_device *=
pdev)
>  			return err;
>  	}
> =20
> +	for (i =3D 0; i < ARRAY_SIZE(npu->cores); i++) {
> +		struct airoha_npu_core *core =3D &npu->cores[i];
> +
> +		core->buf =3D dmam_alloc_coherent(dev, AIROHA_NPU_MBOX_SIZE,
> +						&core->addr, GFP_KERNEL);
> +		if (!core->buf)
> +			return -ENOMEM;
> +	}
> +
>  	err =3D airoha_npu_run_firmware(dev, base, &res);
>  	if (err)
>  		return err;
> diff --git a/include/linux/soc/airoha/airoha_offload.h b/include/linux/so=
c/airoha/airoha_offload.h
> index 7589fccfee..16a988ad74 100644
> --- a/include/linux/soc/airoha/airoha_offload.h
> +++ b/include/linux/soc/airoha/airoha_offload.h
> @@ -173,6 +173,9 @@ struct airoha_npu {
>  		/* protect concurrent npu memory accesses */
>  		spinlock_t lock;
>  		struct work_struct wdt_work;
> +		/* Coherent bounce buffer for mailbox cmd/rsp */
> +		void *buf;
> +		dma_addr_t addr;
>  	} cores[NPU_NUM_CORES];
> =20
>  	int irqs[NPU_NUM_IRQ];
> --=20
> 2.53.0
>=20

--ks8RgjNESd8HpSsU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCat8GYAAKCRA6cBh0uS2t
rAyyAP4vQ0d/lxhDq7vgz5zZvFYc9PWyteGbdUndIq9yHNykLwD9HXcgZ822FdNP
cxub3lKtITSN9fGw+qxMyaBJbgcfXgQ=
=fVMR
-----END PGP SIGNATURE-----

--ks8RgjNESd8HpSsU--
