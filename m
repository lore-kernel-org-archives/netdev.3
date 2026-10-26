Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000907;
	b=TXJnIoRMY47QQuVUJ7RfAyp7SCpOIKvMNYU2KoN+uPiZ5h+R6K2qylK5NTUkMiAgOrXw
	 sO5cfrm7exWQr/kgizbMo/Dulk2rCrmOZ3WNRGCUEyoTf91SjNxfS9LuNehhhXOss5JYX
	 AKzoUzUv4fF+sN36ol4pxp2MfX78zIgYJgLA5hhK6B5YnLVaJyXB+LcvpPldj5JWqPcdR
	 90js3d2rlilq+YLSVQ4wJUAYoADBDcjH+3a9Qoi20OFEAIR7uH/Ucc+n3PVOECgtaGcgL
	 ihn/9TBnLfnKc3fcVct4rKN8GuJgz/HK1/hJ4VaEQSK+EuO+H6C6IeZJQXBhHbU6QZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000907;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GzuOsw4Snvbh+eEMcnVr9iJjEbAdsRsKBYi5VdtwjLQ=;
	b=GMnhCNg/Eh3UCZMgIdCU+8GOevjKp3VGDMy7VbHWt2r7uPFjmQmLKQvPHRtNlqA7m/KQ
	 9yQVUPfU4Or8l+5TU9B7X9A1b/vprF977RK0iKx6YVOqN9LwYXFhq83tFsMSjQrcRF48f
	 PL4NSUMV3//zaneJ3+IxsMSKxbmsU2BhbmURUtMyGvAF5KyueL20ofZTaV8wKsVQY/Tge
	 3ZMi6/KDmO/4L3+2cO5aaZ4wDO0oaXkb6+4uX2/Osf83ZBzGymeeCfBq3pC3ffiwXT+S5
	 bHSNi3imTvG6W+bv00cYNYNUcRB+pKIMRiEngX6RvhI71ExYeeV6xF7xHuO2zcmUbng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2m+DVXm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44AB606A31B;
	Mon, 26 Oct 2026 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2m+DVXm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC631F01825;
	Mon, 26 Oct 2026 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793000907;
	bh=GzuOsw4Snvbh+eEMcnVr9iJjEbAdsRsKBYi5VdtwjLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I2m+DVXmL5Gv3nfNU/fb7mgDtrgNT54cGy11FezEf4gpsgiBmxi9/lrqb8MMm34Ma
	 T79ZROkG2cwpyLQQGA8JJfew/i+8LeLAl3+eGWlBZi8RKmeHO/3+9XmVCik2CMd6oJ
	 BZ5DY6VZyhKcSj5cRr3gp6zdU9Q4jawc0SN/jX/pGmJaOXRcRlhpp1ZyAUsfyyUQT4
	 n2gm7tcgMi887AUtZLmQKgpIdN9vr4nobt2yV+jYtG9i8rG3v1xMGLMDJWD9F+mTUq
	 R314cJFSSc8+yz9/nSgrMM4zmgDkgUTJGZkV/7du83bsTPtJED6LvPHOuZLuBkXR1F
	 2GnOdr36WwXZQ==
Date: Mon, 26 Oct 2026 08:48:24 +0100
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
Subject: Re: [RFC net-next 2/3] net: airoha: npu: attach a coherent pool in
 the NPU window
Message-ID: <at8FyOLeaMlpS7mR@lore-desk>
References: <20261024154150.45733-1-gilroyscott1970@gmail.com>
 <20261024154150.45733-3-gilroyscott1970@gmail.com>
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
	protocol="application/pgp-signature"; boundary="iVyAIniY1vyBr/dM"
Content-Disposition: inline
In-Reply-To: <20261024154150.45733-3-gilroyscott1970@gmail.com>

--iVyAIniY1vyBr/dM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The EN7581 NPU can only address host DRAM at 0x80000000-0xbfffffff;
> higher addresses alias the lower 1 GiB. The coherent buffers allocated
> on the NPU device are all shared with the NPU: since mt76 uses the NPU
> device as dma_dev, these are the NPU TX/RX descriptor rings, the HW-RRO
> ba_bitmap/addr_elem/msdu_pg/session buffers and the NPU TXD buffers.
> On a 2 GiB board nothing keeps them below 0xc0000000; they normally
> land there only because of early-boot allocation order. With low DRAM
> reserved away on W1700K the SoC hangs right after mt7996 firmware load.
>=20
> If the NPU node has an optional "dma" reserved-memory region, attach it
> as the device coherent pool so all of these come from the window. The
> next patch moves the mailbox buffers to coherent memory as well.
>=20
> Unlike a restricted-dma-pool this leaves streaming mappings alone.
> Packet buffers are passed through to the WiFi DMA engine: on W1700K
> with 96% of TX skbs and ~20% of RX page_pool buffers above 0xc0000000,
> host-path traffic and sha256 file round-trips stay intact, at the same
> throughput as without a pool, whereas a restricted-dma-pool (swiotlb
> bouncing) costs ~22% of host-path TX.
>=20
> A device coherent pool has no fallback once full; mt76 and the mailbox
> use ~10.7 MiB with MT7996, so the DT region should be 16 MiB.
>=20
> This patch was written with the help of Claude (Anthropic, claude-
> opus-5-5).
>=20
> Link: https://lore.kernel.org/r/atCRsquzA1UxSpCc@mediatek.com
> Tested-by: Daniel Pawlik <pawlik.dan@gmail.com>
> Signed-off-by: Chris Scott <gilroyscott1970@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_npu.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ether=
net/airoha/airoha_npu.c
> index 4d3195eb00..069fd60680 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -693,6 +693,11 @@ static const struct regmap_config regmap_config =3D {
>  	.disable_locking	=3D true,
>  };
> =20
> +static void airoha_npu_rmem_release(void *data)
> +{
> +	of_reserved_mem_device_release(data);
> +}
> +
>  static int airoha_npu_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> @@ -776,6 +781,19 @@ static int airoha_npu_probe(struct platform_device *=
pdev)
>  	if (err)
>  		return err;
> =20
> +	if (of_property_match_string(dev->of_node, "memory-region-names",
> +				     "dma") >=3D 0) {
> +		err =3D of_reserved_mem_device_init_by_name(dev, dev->of_node,
> +							  "dma");
> +		if (err)
> +			return err;
> +
> +		err =3D devm_add_action_or_reset(dev, airoha_npu_rmem_release,
> +					       dev);
> +		if (err)
> +			return err;
> +	}

nit: what about creating a dedicated routine for both firmware and dma
memory regions. Something like:

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/etherne=
t/airoha/airoha_npu.c
index 4d3195eb00f7..9c9c754f82c7 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -693,6 +693,23 @@ static const struct regmap_config regmap_config =3D {
 	.disable_locking	=3D true,
 };
=20
+static int airoha_npu_reserve_mem_region(struct device *dev,
+					 struct resource *res)
+{
+	int err;
+
+	err =3D of_reserved_mem_region_to_resource(dev->of_node, 0, res);
+	if (err)
+		return err;
+
+	if (of_property_match_string(dev->of_node, "memory-region-names",
+				     "dma" >=3D 0)) {
+		...
+	}
+
+	return 0;
+}
+
 static int airoha_npu_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
@@ -729,7 +746,7 @@ static int airoha_npu_probe(struct platform_device *pde=
v)
 	if (IS_ERR(npu->regmap))
 		return PTR_ERR(npu->regmap);
=20
-	err =3D of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
+	err =3D airoha_npu_reserve_mem_region(dev, &res);
 	if (err)
 		return err;
=20

Regards,
Lorenzo

> +
>  	err =3D airoha_npu_run_firmware(dev, base, &res);
>  	if (err)
>  		return err;
> --=20
> 2.53.0
>=20

--iVyAIniY1vyBr/dM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCat8FyAAKCRA6cBh0uS2t
rFMLAQCYE9JZWHIX1d7DcMsUxNN7xuWi7j5iJa2g9JbmY1RtxgEAyosq5OPcK+vt
26iGn/wqVNypeFZFieGr4LBUSJkSDwE=
=L6P8
-----END PGP SIGNATURE-----

--iVyAIniY1vyBr/dM--
