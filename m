Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19781A3029
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 01:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931799; cv=none; b=CwDvhSXKM2A9gcXjc+bXZquQ1GiN5/afiPn0q2bYAPaywtgFqunxr7vMOlsGwG8VThmK4PsTUGGS/ST7EAiD3xp8t9hJkaad/rwJlq/e5BxVFD3sfjd3YO5m5d1qT9ju7Jg+KIpXmHNiX2TKZ7zf6zMhml0NFJHCFFDYIqUm2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931799; c=relaxed/simple;
	bh=BK5ahbilS7G7tn/+lfXz6+ef5gvc1sS/jGT3Us2Csiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETR2SLw4KfCM2Rhz/W6Ffs5OFfn8tHEr9OTp8YCZzNwAHxLZtrhuyIPDyTz1+/57k7ER7Lbi3zChpP/Cj+CnPq4sfI6LiajBeDFN4/2T2NWalEVraxzkW+cHz3KNINgkZ9/c3KDXezJzT7ajRnNijzT0LwRRqDo3jIZwZNEMQCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOuCv99w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOuCv99w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D0B1F000E9;
	Mon, 17 Aug 2026 01:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786931797;
	bh=3jU4tOtpt0N2CNGog4ZXhtt5MKvEVYITAXmgNSw14DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QOuCv99wUAkezZJtwI61Fv1GJWp99WBNuQxWObmyDW3oEjctUCwwMOAxt+tt9e8gT
	 zO3aHyIagk/GYOEIH+YTrXO9oP+oeYfDNjJI8kI2GkfLp+jat5rErZkFWF7Lxr+rdS
	 Z8gxRXjgMPu8VetOmGzWR9E9QwuyuGiG26VHQr4jI1K0sGhIDbtSsDrcCQhgz67oPz
	 OZX2uC/9HVGAPaTAeUa8aIk8Qu07Mth4PY/Nm6Jtsln8w3ZjfPc3lwt4KtSVeHQPVm
	 2y8iEZ5vDY9AivHf/A5Nc2QcAcn5UjkxUcDfVAwp2jLx8EEXpApNcLc7GQVi5sJPpS
	 a7DWjemdHUsDw==
Date: Mon, 17 Aug 2026 03:56:36 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Daniel Pawlik <pawlik.dan@gmail.com>
Cc: netdev@vger.kernel.org, win847@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v7] net: airoha: npu: use aligned streaming DMA for
 mailbox messages
Message-ID: <aoJqU7G9xIoAQfXA@lore-qca>
References: <20260814110017.2795022-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k48ETKoVT/LBu6qS"
Content-Disposition: inline
In-Reply-To: <20260814110017.2795022-1-pawlik.dan@gmail.com>

--k48ETKoVT/LBu6qS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On EN7581 + MT7996 (Gemtek W1700K), mapping small caller buffers with
> DMA_BIDIRECTIONAL regresses NPU version probe: the mailbox completes
> successfully but WLAN_FUNC_GET_WAIT_NPU_VERSION reads as 0.0 instead of
> 0.1111.

IIUC you are suggesting the issue is if we allocate a small buffer it could=
 fit
in the same cacheline of a neighbour object so if the DMA reads/writes the =
same
cacheline, it could invalidate data, right? (I am not sure if this device is
DMA-coherent or not).
If so, in the airoha_npu_send_msg() callers, I guess it is enough to alloca=
te
something like:

	kzalloc(max(len, SMP_CACHE_BYTES))

and avoid the extra copy in __airoha_npu_send_msg(). What do you think?
IIRC kzalloc() aligns to SMP_CACHE_BYTES is len >=3D SMP_CACHE_BYTES.

Regards,
Lorenzo

>=20
> Bounce mailbox traffic through a per-core cacheline-aligned buffer
> allocated at probe. Map ALIGN(len, SMP_CACHE_BYTES) with
> DMA_BIDIRECTIONAL while programming the original payload length into the
> mailbox length register. Copy the reply only after dma_unmap_single() so
> the CPU sees the NPU-written payload on non-coherent DMA.
>=20
> Introduce __airoha_npu_send_msg() with an optional reply pointer so GET
> callers can copy the trailing response payload once. Keep
> airoha_npu_send_msg() as a wrapper that copies the full response back
> into the caller buffer, matching the old bidirectional mapping.
>=20
> Tested on Quantum Fiber / Gemtek W1700K (EN7581 + MT7996), kernel
> 6.18.44, including two cold reboots and sustained WiFi use.
>=20
> Fixes: 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox buff=
er")
> Link: https://patchwork.kernel.org/project/linux-mediatek/patch/202608050=
70851.2885888-1-pawlik.dan@gmail.com/
> Assisted-by: Cursor:composer-2
> Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_npu.c  | 62 ++++++++++++++++++-----
>  include/linux/soc/airoha/airoha_offload.h |  1 +
>  2 files changed, 49 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ether=
net/airoha/airoha_npu.c
> index b679bed952de..2ba78bf0e97b 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -5,6 +5,7 @@
>   */
> =20
>  #include <linux/devcoredump.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/firmware.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_net.h>
> @@ -23,6 +24,8 @@
>  #define NPU_EN7581_FIRMWARE_RV32_MAX_SIZE	0x200000
>  #define NPU_EN7581_FIRMWARE_DATA_MAX_SIZE	0x10000
>  #define NPU_DUMP_SIZE				512
> +/* Maximum mailbox DMA payload (PPE ~28 bytes, WLAN TLV up to 24). */
> +#define AIROHA_NPU_MBOX_SIZE			256
> =20
>  #define REG_NPU_LOCAL_SRAM		0x0
> =20
> @@ -160,23 +163,33 @@ struct wlan_mbox_data {
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
> +	struct airoha_npu_core *core =3D &npu->cores[0]; /* FIXME: core */
>  	dma_addr_t dma_addr;
> +	unsigned int map_len =3D ALIGN(len, SMP_CACHE_BYTES);
> +	u32 val, offset =3D 0;
>  	int ret;
> =20
> -	dma_addr =3D dma_map_single(npu->dev, p, size, DMA_BIDIRECTIONAL);
> +	if (len <=3D 0 || len > AIROHA_NPU_MBOX_SIZE)
> +		return -EINVAL;
> +
> +	if (reply && reply_len > len)
> +		return -EINVAL;
> +
> +	spin_lock_bh(&core->lock);
> +
> +	memcpy(core->buf, data, len);
> +
> +	dma_addr =3D dma_map_single(npu->dev, core->buf, map_len, DMA_BIDIRECTI=
ONAL);
>  	ret =3D dma_mapping_error(npu->dev, dma_addr);
>  	if (ret)
> -		return ret;
> -
> -	spin_lock_bh(&npu->cores[core].lock);
> +		goto unlock;
> =20
>  	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(0) + offset, dma_addr);
> -	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(1) + offset, size);
> +	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(1) + offset, len);
>  	regmap_read(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, &val);
>  	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, val + 1);
>  	val =3D FIELD_PREP(MBOX_MSG_FUNC_ID, func_id) | MBOX_MSG_WAIT_RSP;
> @@ -189,13 +202,23 @@ static int airoha_npu_send_msg(struct airoha_npu *n=
pu, int func_id,
>  	if (!ret && FIELD_GET(MBOX_MSG_STATUS, val) !=3D NPU_MBOX_SUCCESS)
>  		ret =3D -EINVAL;
> =20
> -	spin_unlock_bh(&npu->cores[core].lock);
> +	dma_unmap_single(npu->dev, dma_addr, map_len, DMA_BIDIRECTIONAL);
> =20
> -	dma_unmap_single(npu->dev, dma_addr, size, DMA_BIDIRECTIONAL);
> +	/* Copy the trailing reply_len bytes of the response. */
> +	if (!ret && reply)
> +		memcpy(reply, core->buf + len - reply_len, reply_len);
> +unlock:
> +	spin_unlock_bh(&core->lock);
> =20
>  	return ret;
>  }
> =20
> +static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
> +			       void *data, int len)
> +{
> +	return __airoha_npu_send_msg(npu, func_id, data, len, data, len);
> +}
> +
>  static int airoha_npu_load_firmware(struct device *dev, void __iomem *ad=
dr,
>  				    const char *fw_name, int fw_max_size)
>  {
> @@ -497,9 +520,8 @@ static int airoha_npu_wlan_msg_get(struct airoha_npu =
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
> @@ -770,6 +792,18 @@ static int airoha_npu_probe(struct platform_device *=
pdev)
>  	if (err)
>  		return err;
> =20
> +	for (i =3D 0; i < ARRAY_SIZE(npu->cores); i++) {
> +		struct airoha_npu_core *core =3D &npu->cores[i];
> +		void *raw;
> +
> +		raw =3D devm_kmalloc(dev, AIROHA_NPU_MBOX_SIZE + SMP_CACHE_BYTES,
> +				   GFP_KERNEL);
> +		if (!raw)
> +			return -ENOMEM;
> +
> +		core->buf =3D PTR_ALIGN(raw, SMP_CACHE_BYTES);
> +	}
> +
>  	err =3D airoha_npu_run_firmware(dev, base, &res);
>  	if (err)
>  		return dev_err_probe(dev, err, "failed to run npu firmware\n");
> diff --git a/include/linux/soc/airoha/airoha_offload.h b/include/linux/so=
c/airoha/airoha_offload.h
> index 7589fccfeef6..f635766e3dba 100644
> --- a/include/linux/soc/airoha/airoha_offload.h
> +++ b/include/linux/soc/airoha/airoha_offload.h
> @@ -173,6 +173,7 @@ struct airoha_npu {
>  		/* protect concurrent npu memory accesses */
>  		spinlock_t lock;
>  		struct work_struct wdt_work;
> +		void *buf; /* mailbox DMA bounce buffer */
>  	} cores[NPU_NUM_CORES];
> =20
>  	int irqs[NPU_NUM_IRQ];
> --=20
> 2.55.0
>=20

--k48ETKoVT/LBu6qS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaoJqUwAKCRA6cBh0uS2t
rJKHAQCxbJO+swWF67vpy0YipmSukJEskcpf4E5FlW4+fsqZ7AEAkI8UQNvU/9WD
52cI/EuNY2zC2edZWZkbH7TmFi/ZFgs=
=SfV1
-----END PGP SIGNATURE-----

--k48ETKoVT/LBu6qS--
