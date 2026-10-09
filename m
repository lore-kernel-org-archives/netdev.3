Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15695472F8C
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531887; cv=none; b=cCe6rfEat6UE/CdETxNVV2NxGdn8UA7Sb8MLj4J/H3RflY4o5cOz3e/vyqyhw4xxZqCR4maPRPxQoWGSShHa0aMxD3sDIntss4xr2npnjR7nLVQmyrIawBeKtWYMV6AvKwBQ8S7nOTqPQS3JH0AooLHV7UcALex+HVpn8WrlDnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531887; c=relaxed/simple;
	bh=2kHPMd3GoQb0XEVh+otV2yFvvOBNUJ1tqvMy8Z4qFgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aV4Uu/CZv84qZGzChj8MufwBdmMD2+QhYsrnT2QTUg2A0hhQWPtJsj/QRGS3Ea4GWdLalsZ+vYug74xCBQlwRGW5Q1EwrbyBED7QVBdwf034Dt4M+StVYOPXgpkjAxadWUuz+Sk6XwojQyvwePCvFDNLDWh8FcCMckn+NvbKzYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcW0L1sz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcW0L1sz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2711F1F00893;
	Fri,  9 Oct 2026 07:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791531885;
	bh=NpZ7XaceTucaY86C62zOlPu+VQmlzvfFU9YRREd4CxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IcW0L1szOmI+K95UFpUOxmCcHjnJ/pBfcccJqrW7jxT91VyW1LYAoh/NpoDt22f+g
	 n+jWOzIjD+F8l65MyLNfs0AxpindYSVONDRDZNjD/e9aI7Mi+l+MmfyJKPgSEcegjK
	 2tO/g1zVojMkYR7tAsQHApQS9YfwqNImgRyNOa3rgtqS4IJJuD+fV2jzCITHXCzij0
	 D+rN4JoP/hNwjzoH4+yfqy9MA/mHhYddOSeJRCw/SYa4I2Q3fxsQPyhBOV4l105JMC
	 MrkHUTOE72EeYz1S2zQLcihgZQfJxzlkuv4hLq98W2DFuEBnnCmWa/3CK+/ab/MBw7
	 g8VREvLkZ57PA==
Date: Fri, 9 Oct 2026 09:44:43 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: SAYANTAN NANDY <sayantann11@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, bread.hsu@airoha.com,
	sayantan.nandy@airoha.com
Subject: Re: [PATCH net v2] net: airoha: keep PPE offload when NPU refuses
 flow stats
Message-ID: <asiba_Sw-i2ht_S9@lore-desk>
References: <20261008094828.15458-1-sayantann11@gmail.com>
 <20261009050322.39060-1-sayantann11@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NOajDJ9cSUpeZ4E4"
Content-Disposition: inline
In-Reply-To: <20261009050322.39060-1-sayantann11@gmail.com>

--NOajDJ9cSUpeZ4E4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Chad Monroe <chad@monroe.io>
>=20
> With flow stats enabled, PPE offload setup requests flow statistics
> from the NPU. If the running NPU firmware does not support flow
> counters, the request fails and the current setup path aborts PPE
> offload.
>=20
> Treat flow statistics as an optional capability so that a failure to
> set up the counters does not prevent normal PPE offload. Record
> whether flow statistics are available and continue PPE initialization
> when the NPU refuses the flow-statistics request.
>=20
> Also treat a zero NPU statistics address returned by the firmware as a
> refusal. The host-side DMA buffer (foe_stats_dma) is allocated by
> dmam_alloc_coherent() in airoha_ppe_init() from system memory. The NPU
> statistics address (npu_stats_addr) is a separate allocation from the
> NPU firmware's internal SRAM pool. When that pool is exhausted, the
> firmware replies with success and npu_stats_addr =3D 0. A zero address
> does not provide a usable counter region and must not be passed to
> devm_ioremap().
>=20
> When flow stats are available, clear PSE_PORT6_SHARE_DIS so that PSE
> port 6 (CDM3 path to the NPU) participates in shared-buffer flow
> control, which the counter traffic path needs.
>=20
> When flow statistics are unavailable, PPE continues to operate without
> NPU flow counters while retaining normal offload functionality.
>=20
> This combines the original SmartRG/Airoha fixes for:
> - keeping PPE offload active when the NPU refuses flow statistics
> - treating a zero NPU statistics address as a flow-statistics refusal
>=20
> Based on the original SmartRG/Airoha work by Chad Monroe:
> 5ce96ab ("SDG-9458: keep PPE offload when NPU refuses flow stats")
> 0ad8528 ("SDG-9458: airoha: treat a zero NPU stats address as a refusal")
> Fixes: b81e0f2b58be ("net: airoha: Add FLOW_CLS_STATS callback support")
> Tested-on: AN7581 with MT7992
> Signed-off-by: Chad Monroe <chad@monroe.io>
> Signed-off-by: SAYANTAN NANDY <sayantann11@gmail.com>
> ---
>=20
> Changes since v1:
> - Rename flow_stats to flow_stats_cap (Lorenzo).
> - Explain that npu_stats_addr is an NPU firmware SRAM allocation,
>   distinct from the host-side foe_stats_dma buffer (Lorenzo).
> - Explain why PSE_PORT6_SHARE_DIS is cleared for counter traffic
>   (Lorenzo).
> - Use airoha_fe_clear() and shorten the warning message (Lorenzo).
> - Add hardware testing information requested by netdev-bot.
>=20
>  drivers/net/ethernet/airoha/airoha_eth.h  |  1 +
>  drivers/net/ethernet/airoha/airoha_npu.c  |  8 ++++++++
>  drivers/net/ethernet/airoha/airoha_ppe.c  | 17 +++++++++++------
>  drivers/net/ethernet/airoha/airoha_regs.h |  2 ++
>  4 files changed, 22 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 8277c1c87bb3..da4a3ba69e3c 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -617,6 +617,7 @@ struct airoha_ppe {
> =20
>  	void *foe;
>  	dma_addr_t foe_dma;
> +	bool flow_stats_cap;
> =20
>  	struct rhashtable l2_flows;
> =20
> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ether=
net/airoha/airoha_npu.c
> index 4d3195eb00f7..b32a01dbe06b 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -450,6 +450,14 @@ static int airoha_npu_ppe_stats_setup(struct airoha_=
npu *npu,
>  	if (err)
>  		goto out;
> =20
> +	/* The firmware reports success with a zero address when its SRAM
> +	 * pool has no room left for the counters.
> +	 */
> +	if (!ppe_data->stats_info.npu_stats_addr) {
> +		err =3D -ENOSPC;
> +		goto out;
> +	}
> +
>  	npu->stats =3D devm_ioremap(npu->dev,
>  				  ppe_data->stats_info.npu_stats_addr,
>  				  size);
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index 92611802801e..0957f331478a 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -37,10 +37,7 @@ static const struct rhashtable_params airoha_l2_flow_t=
able_params =3D {
> =20
>  static int airoha_ppe_get_num_stats_entries(struct airoha_ppe *ppe)
>  {
> -	if (!IS_ENABLED(CONFIG_NET_AIROHA_FLOW_STATS))
> -		return -EOPNOTSUPP;
> -
> -	if (airoha_is_7583(ppe->eth))
> +	if (!ppe->flow_stats_cap)
>  		return -EOPNOTSUPP;

Looking again at the code flow_stats_cap is only used here. Why do we need =
it
in the first place? I guess you it is enough to just not return an error in
airoha_ppe_offload_setup() and log the error instead (as you did).

> =20
>  	return PPE_STATS_NUM_ENTRIES;
> @@ -144,6 +141,9 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
>  	sram_ppe_num_data_entries =3D
>  		PPE_RAM_NUM_ENTRIES_SHIFT(sram_ppe_num_data_entries);
> =20
> +	if (ppe->flow_stats_cap)
> +		airoha_fe_clear(eth, PSE_FC_CFG, PSE_PORT6_SHARE_DIS);

can you please explain what this configuration is doing? This register is n=
ot
documented.

> +
>  	for (i =3D 0; i < eth->soc->num_ppe; i++) {
>  		airoha_fe_wr(eth, REG_PPE_TB_BASE(i),
>  			     ppe->foe_dma + sram_tb_size);
> @@ -1456,8 +1456,11 @@ static int airoha_ppe_offload_setup(struct airoha_=
eth *eth)
>  	if (ppe_num_stats_entries > 0) {
>  		err =3D npu->ops.ppe_init_stats(npu, ppe->foe_stats_dma,
>  					      ppe_num_stats_entries);
> -		if (err)
> -			goto error_npu_put;
> +		if (err) {
> +			dev_warn(eth->dev, "NPU refused flow stats (%d)\n",
> +				 err);
> +			ppe->flow_stats_cap =3D false;

please see above.

> +		}
>  	}
> =20
>  	airoha_ppe_hw_init(ppe);
> @@ -1608,6 +1611,8 @@ int airoha_ppe_init(struct airoha_eth *eth)
>  	ppe->dev.priv =3D ppe;
>  	ppe->eth =3D eth;
>  	eth->ppe =3D ppe;
> +	ppe->flow_stats_cap =3D IS_ENABLED(CONFIG_NET_AIROHA_FLOW_STATS) &&
> +			  !airoha_is_7583(eth);

please see above.

Regards,
Lorenzo

> =20
>  	ppe_num_entries =3D airoha_ppe_get_total_num_entries(ppe);
>  	foe_size =3D ppe_num_entries * sizeof(struct airoha_foe_entry);
> diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethe=
rnet/airoha/airoha_regs.h
> index 442b48c9b991..aee06c058586 100644
> --- a/drivers/net/ethernet/airoha/airoha_regs.h
> +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> @@ -72,6 +72,8 @@
>  #define PSE_CFG_OQ_RSV_MASK		GENMASK(13, 0)
> =20
>  #define PSE_FQ_CFG			0x008c
> +#define PSE_FC_CFG			0x0098
> +#define PSE_PORT6_SHARE_DIS		BIT(22)
>  #define PSE_FQ_LIMIT_MASK		GENMASK(14, 0)
> =20
>  #define REG_FE_PSE_BUF_SET		0x0090
> --=20
> 2.43.0
>=20

--NOajDJ9cSUpeZ4E4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasibawAKCRA6cBh0uS2t
rK8sAQCcVwqGDaZNFDjbktsKV7mzp98FVx4rbcZGJlo+MhlRDwD/XXQapB/RcFIs
7ItldqyvtIw7uHMNN4sLeGtM0R01uw4=
=UgeO
-----END PGP SIGNATURE-----

--NOajDJ9cSUpeZ4E4--
