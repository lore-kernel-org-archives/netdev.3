Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED17497B87
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456273; cv=none; b=nNxhtUid/OGS4HSwBWifxUC4ALaAkyyn8MO1MPedP9r2qdYi45sceR7txzcnS+ofVkwLgmwDg+X5d3nVDz1xdjOK/4wF91dnsaS9toJxzWdG3ibua/BF9E++1NJ+hsV0992tu9N0XSoWIH6T78AJbTFES0jM0UwZa0/CVM7TwDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456273; c=relaxed/simple;
	bh=pMgnqGcde/SwwPKJtvVswrako2l+SSNbRA1ku+oZGVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiQPFOc4dr3cba3W4CojgNiLPXmXnB9QhUShaHLTX3NpeibMOrXum5dWNsG1G7VForp3HR+mjUsgPH6HzpoYiQ2a+UtOLINeKjV3ty2pP4eG8M09Ol4g5jjzuS6ncbig7wXk0Z6D0O0Oz/3IhT3Rku9VomcXymgxmC0ViJsfP70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eETlY2kf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eETlY2kf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FD61F000FF;
	Thu,  8 Oct 2026 10:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791456271;
	bh=ppeChgaMvunB6XgC1qGnigzxCgeUt+TprCEG6p5AB3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eETlY2kfse6I2eGjGA24SQVia+0ytpI+iYCoTyt07EMIonZpZYRpIWHF0qg2xfgz9
	 6hJsFUHK+AIKpdbMDdO302AoQ8/iYGEAj6Ui7FlC/cz2DopM4xu5H7yCBQJLmKlm5S
	 Mh/KjmObXnBkehSoG+22wvg8kZ8+NDBv1+VvpMnuFODKJy+bHHpl8mLsXGU1vqLOC9
	 kAUMrOuiTW0zBnL8rhWTPzJHQv9mPhtjTYBo5RQOncSaL5sdGPS12mn3Afj3iGHvES
	 ECnIl7Pwt89D0ykj9E/h3OXzR26p2KwSUW/fyyPxS7pQp6sIbq5taqofBH4vJN7IVY
	 NnFG9PMTb6cHQ==
Date: Thu, 8 Oct 2026 12:44:29 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: SAYANTAN NANDY <sayantann11@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, bread.hsu@airoha.com,
	sayantan.nandy@airoha.com
Subject: Re: [PATCH net] net: airoha: keep PPE offload when NPU refuses flow
 stats
Message-ID: <asd0DfMSLLGu_vbK@lore-desk>
References: <20261008094828.15458-1-sayantann11@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L4dpZ7G5dt+qFFf/"
Content-Disposition: inline
In-Reply-To: <20261008094828.15458-1-sayantann11@gmail.com>

--L4dpZ7G5dt+qFFf/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 08, SAYANTAN NANDY wrote:
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
> refusal. A zero address does not provide a usable counter region and
> must not be passed to the address mapping path.
>=20
> When flow statistics are unavailable, PPE continues to operate
> without NPU flow counters while retaining normal offload functionality.
>=20
> This combines the original SmartRG/Airoha fixes for:
> - keeping PPE offload active when the NPU refuses flow statistics
> - treating a zero NPU statistics address as a flow-statistics refusal
>=20
> Based on the original SmartRG/Airoha work by Chad Monroe:
> 5ce96ab ("SDG-9458: keep PPE offload when NPU refuses flow stats")
> 0ad8528 ("SDG-9458: airoha: treat a zero NPU stats address as a refusal")
> Fixes: b81e0f2b58be ("net: airoha: Add FLOW_CLS_STATS callback support")
> Signed-off-by: Chad Monroe <chad@monroe.io>
> Signed-off-by: SAYANTAN NANDY <sayantann11@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.h  |  1 +
>  drivers/net/ethernet/airoha/airoha_npu.c  |  8 ++++++++
>  drivers/net/ethernet/airoha/airoha_ppe.c  | 20 +++++++++++++-------
>  drivers/net/ethernet/airoha/airoha_regs.h |  2 ++
>  4 files changed, 24 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 8277c1c87bb3..bd5a94fce843 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -617,6 +617,7 @@ struct airoha_ppe {
> =20
>  	void *foe;
>  	dma_addr_t foe_dma;
> +	bool flow_stats;

I agree naming is hard, but I guess we could a more meaningful name, like f=
low_stats_cap. What do you think?

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

can it really happen? I guess dmam_alloc_coherent() in airoha_ppe_init()
should fail in this case, right?

> +		err =3D -ENOSPC;
> +		goto out;
> +	}
> +
>  	npu->stats =3D devm_ioremap(npu->dev,
>  				  ppe_data->stats_info.npu_stats_addr,
>  				  size);
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index 92611802801e..fbc200614de3 100644
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
> +	if (!ppe->flow_stats)
>  		return -EOPNOTSUPP;
> =20
>  	return PPE_STATS_NUM_ENTRIES;
> @@ -144,6 +141,10 @@ static void airoha_ppe_hw_init(struct airoha_ppe *pp=
e)
>  	sram_ppe_num_data_entries =3D
>  		PPE_RAM_NUM_ENTRIES_SHIFT(sram_ppe_num_data_entries);
> =20
> +	if (ppe->flow_stats)
> +		airoha_fe_rmw(eth, PSE_FC_CFG, PSE_PORT6_SHARE_DIS,
> +			      FIELD_PREP(PSE_PORT6_SHARE_DIS, 0));

can you please provide more details about it, why is it needed?
Moreover, I guess you could use airoha_fe_clear() here.

> +
>  	for (i =3D 0; i < eth->soc->num_ppe; i++) {
>  		airoha_fe_wr(eth, REG_PPE_TB_BASE(i),
>  			     ppe->foe_dma + sram_tb_size);
> @@ -1456,10 +1457,13 @@ static int airoha_ppe_offload_setup(struct airoha=
_eth *eth)
>  	if (ppe_num_stats_entries > 0) {
>  		err =3D npu->ops.ppe_init_stats(npu, ppe->foe_stats_dma,
>  					      ppe_num_stats_entries);
> -		if (err)
> -			goto error_npu_put;
> +		if (err) {
> +			dev_warn(eth->dev,
> +				 "NPU firmware refused flow stats setup (%d), offload runs without f=
low counters\n",
> +				 err);

can you please try to respect the 79 column width? (I still have old habits=
 :))

> +			ppe->flow_stats =3D false;
> +		}
>  	}
> -
>  	airoha_ppe_hw_init(ppe);
>  	airoha_ppe_foe_flow_stats_reset(ppe, npu);
> =20
> @@ -1608,6 +1612,8 @@ int airoha_ppe_init(struct airoha_eth *eth)
>  	ppe->dev.priv =3D ppe;
>  	ppe->eth =3D eth;
>  	eth->ppe =3D ppe;
> +	ppe->flow_stats =3D IS_ENABLED(CONFIG_NET_AIROHA_FLOW_STATS) &&
> +			  !airoha_is_7583(eth);
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

--L4dpZ7G5dt+qFFf/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasd0DQAKCRA6cBh0uS2t
rI3DAQCJEYqwZbG09imlqcP8csRXcbM0x1oms2fJsLLPEpWlJgEAxlcAuv/T0Mt7
o5uxomI18N33uhxLEDUgzJWR/SMHfAs=
=MHTr
-----END PGP SIGNATURE-----

--L4dpZ7G5dt+qFFf/--
