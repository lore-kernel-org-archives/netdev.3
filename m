Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63CB346AC2
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 06:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785133656; cv=none; b=AK8SD/DvvlKld44gTSrsWHKnk4dG+m63baeC1qI1zd47iv52VdbXeGuMpyjWRFqcFUB9kbdFg2+32yYyCX/KkoDiTzJMAj0/uG/J3S8Np9nG20kvyns6S7pNkr3Xu3gDVdXoDw9n80qCsWSxvfIKJKZmX3R08xEidgW/r9J4R4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785133656; c=relaxed/simple;
	bh=MKT8B0X18u3yom+jNzeBOmX+U0Z9d9xSI+TKp8AnYho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDstb6P8P2tvWkBwtLKn4/dNmbW5lqzBxVEIdJwL9Lykyx2oQw5kVfQ3pa/ntWqE4z/6/50Q6YEgvpPefuCrCH33nWgbk/3Fn6IYhHpUI8arjUc54k7mMk/jrtHhJiCLYItdibepCHbgJcn/O5ItpbsE1PWwEb4rfwNkhhfoz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oycPVerc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oycPVerc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FAF1F000E9;
	Mon, 27 Jul 2026 06:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785133655;
	bh=Th96/GGdOH3cqJlq6mtvUWtPUD4W0EksOiaZew2t1UQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oycPVercDWHNAWLmDRMwyR+g7ZDZNwzYG4tDfLTSXPSwa65t9WcU7x6+PWf9ZuFTy
	 F9Po4+R7xJSaFNERf5/+bCDsJUvBxDFm4OJhu45+ZbLgQgvIkqv4FDB4a3gkBMz8ba
	 Y/2LjLpWNrWwb2l8N83GRbedyFdc2jYpkbxvfaeBAPcaVNzB7icBo4tNo016ZBxdCq
	 PYnnHMkWiB9QNkcTjA7D0bLnturfdIK6UypL/coK0UmjVMkjgELpV8a6MGGBRj3/Gf
	 UuNInzps54p26dZ1X9Gvu4HEoggUVpHbFlMhcPeF/4z2YD9Mw3Z91+V4QuQdZF18wj
	 JF0bd69+nApGA==
Date: Mon, 27 Jul 2026 08:27:32 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v12 2/3] net: airoha: fix ETS QoS stats counter
 underflow and cross-channel corruption
Message-ID: <amb6VD1kSVHqp0tX@lore-desk>
References: <20260725-airoha-ethtool-priv_flags-v12-0-5136a30b2157@kernel.org>
 <20260725-airoha-ethtool-priv_flags-v12-2-5136a30b2157@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zFUilOt3Gv8fzeud"
Content-Disposition: inline
In-Reply-To: <20260725-airoha-ethtool-priv_flags-v12-2-5136a30b2157@kernel.org>

--zFUilOt3Gv8fzeud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> airoha_qdma_get_tx_ets_stats() has two bugs:
> - The hardware counters read via airoha_qdma_rr() are 32-bit values
>   but are stored in u64 locals and subtracted from u64 baselines. When
>   a 32-bit hardware counter wraps around, the subtraction produces a
>   large underflow value passed to _bstats_update().
> - The baseline counters (cpu_tx_packets, fwd_tx_packets) are stored as
>   single per-device fields, but airoha_qdma_get_tx_ets_stats() is
>   called with different channel values (0-3). Each call reads a
>   different channel's hardware counter but overwrites the same
>   baseline, corrupting the delta computation for other channels.
>=20
> Fix both by:
> - Narrowing the counter locals and baselines to u32 so that 32-bit
>   unsigned subtraction handles wrap-around naturally.
> - Grouping the baselines into a per-channel qos_stats array so each
>   channel tracks its own previous counter value independently.
> - Splitting the delta addition into two statements so the first u32
>   delta is widened to u64 on assignment and the second is added in
>   u64 arithmetic, preventing overflow when both deltas are large.
>=20
> Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 18 +++++++++++-------
>  drivers/net/ethernet/airoha/airoha_eth.h |  7 ++++---
>  2 files changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index d9a44a11d8db..8165084daaf5 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2521,16 +2521,20 @@ static int airoha_qdma_get_tx_ets_stats(struct ne=
t_device *netdev, int channel,
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
>  	struct airoha_qdma *qdma =3D dev->qdma;
> +	u32 cpu_tx_packets, fwd_tx_packets;
> +	u64 tx_packets;
> =20
> -	u64 cpu_tx_packets =3D airoha_qdma_rr(qdma, REG_CNTR_VAL(channel << 1));
> -	u64 fwd_tx_packets =3D airoha_qdma_rr(qdma,
> -					    REG_CNTR_VAL((channel << 1) + 1));
> -	u64 tx_packets =3D (cpu_tx_packets - dev->cpu_tx_packets) +
> -			 (fwd_tx_packets - dev->fwd_tx_packets);
> +	cpu_tx_packets =3D airoha_qdma_rr(qdma, REG_CNTR_VAL(channel << 1));
> +	fwd_tx_packets =3D airoha_qdma_rr(qdma,
> +					REG_CNTR_VAL((channel << 1) + 1));
> +	tx_packets =3D (u32)(cpu_tx_packets -
> +			   dev->qos_stats[channel].cpu_tx_packets);
> +	tx_packets +=3D (u32)(fwd_tx_packets -
> +			    dev->qos_stats[channel].fwd_tx_packets);
> =20
>  	_bstats_update(opt->stats.bstats, 0, tx_packets);
> -	dev->cpu_tx_packets =3D cpu_tx_packets;
> -	dev->fwd_tx_packets =3D fwd_tx_packets;
> +	dev->qos_stats[channel].cpu_tx_packets =3D cpu_tx_packets;
> +	dev->qos_stats[channel].fwd_tx_packets =3D fwd_tx_packets;

commenting on sashiko's report:
https://sashiko.dev/#/patchset/20260725-airoha-ethtool-priv_flags-v12-0-513=
6a30b2157%40kernel.org

- This isn't a bug introduced by this patch, but I noticed _bstats_update()=
 is
  called here without mutual exclusion or BH-disabled context.
  Can a local user running 'tc -s qdisc show' invoke this dump path while t=
he
  software qdisc datapath is running concurrently in softirq?
  Since _bstats_update() requires strict mutual exclusion among writers, co=
uld
  the lack of qdisc_lock() in this process context allow the softirq datapa=
th
  to preempt or run concurrently?
  Would this concurrent access on 32-bit systems corrupt the seqcount_t ins=
ide
  struct gnet_stats_basic_sync and cause readers to spin infinitely?
  - As pointed out by sashiko, this issue has not been introduced by this
    patch. Moreover, airoha_eth driver runs just on arm64 architecture, so I
    guess this is not a real issue.

Regards,
Lorenzo

> =20
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 24dd16fc509a..447a5a9552bb 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -580,9 +580,10 @@ struct airoha_gdm_dev {
>  	struct airoha_eth *eth;
> =20
>  	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
> -	/* qos stats counters */
> -	u64 cpu_tx_packets;
> -	u64 fwd_tx_packets;
> +	struct {
> +		u32 cpu_tx_packets;
> +		u32 fwd_tx_packets;
> +	} qos_stats[AIROHA_NUM_QOS_CHANNELS];
> =20
>  	unsigned long flags;
>  	int nbq;
>=20
> --=20
> 2.55.0
>=20

--zFUilOt3Gv8fzeud
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCamb6VAAKCRA6cBh0uS2t
rA4BAP0akbTHHixeiNxRhj7i0oQUEQ/3swX/GZcss2GkmrDwhQEAiqIETFwQfurk
fcBPV7tvUV4oLhccOCxd2s90kInyLgs=
=0sIR
-----END PGP SIGNATURE-----

--zFUilOt3Gv8fzeud--
