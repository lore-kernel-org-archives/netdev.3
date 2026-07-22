Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F8846EF6D
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705627; cv=none; b=oD0oGf6XmgizL2/TQ/3ost+K5OnG1oxxP8kDVwBEHcO3NnO2961Rp+tMVP9R5sawohB3rAYd50dfqFrrBRNvNhoNndITWyKLrftIfs4out27t9UksEEgpwi6iDVANiaiIvHzciIoRB3expN1ERnyEWqNckiLpTO+9f5yyBrjg+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705627; c=relaxed/simple;
	bh=B4GaeW7vjgD1N5Fr6ncvo7PoGFY050NnvVB1+oZQX4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hr/mPtnh4qEBNyLWHXuvgAlIdJg/B9nJBoUhFkc+yjs+eRxFJukvAPtVLAQQtHLOmLW5qpS4hk/IA/Kf5KqTNAkNc+hpcJleXSJRj4VFNr4euJlHBdS/Z4iEe2dMscNLZvJwAvaiK9f9bmrNRQPAIbH544eRsxermZ683F6VC5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctqulXM+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctqulXM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CC01F000E9;
	Wed, 22 Jul 2026 07:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784705623;
	bh=cXRr0vMJv2NEmYtLVWvskxehewcxKuQFa+zT3/TfT3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ctqulXM+zEU87cc9+q+bk/CJSsTVSm27SbrgR2ocn6ckhVEIeLviYX4/su7ah3ZJd
	 nr9qOrNRWbTohPRKJkepB1Xovpz/ylJOO+DmxDb4zLqDWU7/cnve6XdTnnINdfEIk4
	 D1A5fjVFJoPTqwZMk14ylxpCtJJMvfhtGyWpu7drcozQBhUoPszIFXWGiJ051BzUVU
	 sl2Zyu47JYuGKLMhgO7Jx7H1vzmES3VWmN6U+fG2LMmX+kSX9sxl8I9S2apg2UqEWn
	 S3YYSTcZVrJ3L4J/2Paf6o2K7M5AIMH3g2KP3h67t4YY4+KATJI7sMt1ajHyaiAPsj
	 RqFfj9DwyEK7A==
Date: Wed, 22 Jul 2026 09:33:41 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v9 2/3] net: airoha: fix ETS QoS stats counter
 underflow and cross-channel corruption
Message-ID: <amByVU4m8YuCphO2@lore-desk>
References: <20260721-airoha-ethtool-priv_flags-v9-0-9c15d8b71a56@kernel.org>
 <20260721-airoha-ethtool-priv_flags-v9-2-9c15d8b71a56@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2rgjgGmCcATn9c72"
Content-Disposition: inline
In-Reply-To: <20260721-airoha-ethtool-priv_flags-v9-2-9c15d8b71a56@kernel.org>

--2rgjgGmCcATn9c72
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
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 18 +++++++++++-------
>  drivers/net/ethernet/airoha/airoha_eth.h |  7 ++++---
>  2 files changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 41c1a0ffbdd8..aaf2a4717d12 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2482,16 +2482,20 @@ static int airoha_qdma_get_tx_ets_stats(struct ne=
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
https://sashiko.dev/#/patchset/20260721-airoha-ethtool-priv_flags-v9-0-9c15=
d8b71a56%40kernel.org
- This is a pre-existing issue, but does calling _bstats_update() here from
  the netlink dump path (process context) without holding qdisc_lock() or
  disabling bottom-halves risk a seqcount deadlock?
  On 32-bit platforms, _bstats_update() uses a seqcount_t write lock via
  u64_stats_update_begin(). If this path is preempted by a softirq on the s=
ame
  CPU that updates the same shared opt->stats.bstats (e.g., during a softwa=
re
  packet dequeue), will the softirq spin forever attempting to acquire the
  same seqcount lock?
  - As pointed out by sashiko, this issue has not been introduced by this
    patch. Moreover, since airoha_eth is available just on 64bit system, I
    guess this is not a real issue.

Regards,
Lorenzo

> =20
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index bf1c249255bd..bf44be9f0954 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -553,9 +553,10 @@ struct airoha_gdm_dev {
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
>  	u32 flags;
>  	int nbq;
>=20
> --=20
> 2.55.0
>=20

--2rgjgGmCcATn9c72
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCamByVQAKCRA6cBh0uS2t
rEeCAP9oauJEsmnW2DxM567A3ateWe95l4O9RA67X8/ppn06vwEAhEQQijbawDmV
M+opV8dtSOGZsMLViinpM3cZiPy5sA0=
=d7yO
-----END PGP SIGNATURE-----

--2rgjgGmCcATn9c72--
