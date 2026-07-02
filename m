Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6B44A33EF
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782999098; cv=none; b=eDtsmg73G51ElG6h8eTRMH3+GNbWRG/xFS85nn3v71Lq9OOz0SKXc3yph5KUcY+pcuFKKQprlKBhwE/u3Khz+KfyfE4Vwuoe57SHcLCVZT4oXxw9XuHoKkSHJ76kSmPLlnqhJLufVGGzAn476LcLNRHhCuKetZ+QsIM8RvQSVEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782999098; c=relaxed/simple;
	bh=9FEbvfbhEtCqUxThj+1GXN6nlwy3Wbwp10regKewxyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7NVTcGu1ccsrDvAUGOrRgyu6Mqf0Mxt3J0+f9ylzJY9n6WlnhFtyhLIrMFoYooCApLTlrBN6l1u4ebK/FAHXJmjDfFHLQuRQ459a1XoLkF4Gy4ZnAFJ+fbxGd+j58BqdZJ6J7hQ+OkvNK4q/kn7NhjJuAJhVS1CFJDyZ+v0uPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/RIu+ka; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/RIu+ka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5B61F000E9;
	Thu,  2 Jul 2026 13:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782999096;
	bh=0HPk8+YsOQqKlukslOqig0MS3VE3L+5Yg6OWF2ZMGn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c/RIu+kahcF183i9PsQbNfmJpGsLWoMRFzygjmp9ZBKn397N/v0SpKiLTMhwYFGep
	 d6mhTrCt6K0HZ0tbxVvt010eDIKRrI7PVL3ePaCQiYesURKzJyDsbGNGPjEGjjA41P
	 y68ko3+ChB/+vGEYX68SySMkI2H4XvFZl14m/jCO+quwpMMq0QiL6ovaF+TJAXGBIx
	 VDR4BLf5nfL1hERcGEOybAMxHH+oBzy5ckm9ktEc4AQOlnvujUJPhUBMermgEVwJRP
	 blOux97Y38AqiNh3xOgz4dHKFasyc29qsHmCHCaaoV9UiH4hQV1JVjPbPfgJzr0fyD
	 neNcPQZSD0Erw==
Date: Thu, 2 Jul 2026 15:31:34 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 2/3] net: airoha: fix ETS QoS stats counter
 underflow and cross-channel corruption
Message-ID: <akZoNu-5JGv0eoyl@lore-desk>
References: <20260701-airoha-ethtool-priv_flags-v7-0-b4153bd44428@kernel.org>
 <20260701-airoha-ethtool-priv_flags-v7-2-b4153bd44428@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aiGdtKHDVLsOXAYb"
Content-Disposition: inline
In-Reply-To: <20260701-airoha-ethtool-priv_flags-v7-2-b4153bd44428@kernel.org>


--aiGdtKHDVLsOXAYb
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
>=20
> Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

commenting on sashiko's report:
https://sashiko.dev/#/patchset/20260701-airoha-ethtool-priv_flags-v7-0-b415=
3bd44428%40kernel.org

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 18 +++++++++++-------
>  drivers/net/ethernet/airoha/airoha_eth.h |  7 ++++---
>  2 files changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 8bba54ebcf07..2c9ceb9f16f8 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2491,16 +2491,20 @@ static int airoha_qdma_get_tx_ets_stats(struct ne=
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
> +			   dev->qos_stats[channel].cpu_tx_packets) +
> +		     (u32)(fwd_tx_packets -
> +			   dev->qos_stats[channel].fwd_tx_packets);

- Will this addition overflow in 32-bit space before the result is assigned=
 to
  the 64-bit tx_packets?
  - I do not think this is a problem since we are just considering the delta
    betwen cpu_tx_packets/fwd_tx_packets and the previous value. Moreover, =
the
    u32 cast will take care of possible wrap-around.

> =20
>  	_bstats_update(opt->stats.bstats, 0, tx_packets);

- This isn't a bug introduced by this patch, but does calling _bstats_updat=
e()
  here directly from process context race with the software datapath?
  - Sashiko is right here. This is a pre-existing (theoretical) issue not
    introduced by this patch. However, since the Airoha EN7581/EN7583 is
    ARM64-only, u64_stats_update_begin/end are NOPs on this platform and
    there is no actual race. IIUC the seqcount corruption scenario only
    applies to 32-bit architectures. I guess we can=20

Regards,
Lorenzo

> -	dev->cpu_tx_packets =3D cpu_tx_packets;
> -	dev->fwd_tx_packets =3D fwd_tx_packets;
> +	dev->qos_stats[channel].cpu_tx_packets =3D cpu_tx_packets;
> +	dev->qos_stats[channel].fwd_tx_packets =3D fwd_tx_packets;
> =20
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 87ab3ea10664..ac5f571f3e53 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -545,9 +545,10 @@ struct airoha_gdm_dev {
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
> 2.54.0
>=20

--aiGdtKHDVLsOXAYb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCakZoNgAKCRA6cBh0uS2t
rNc/AP9d+2YOP1S1SNyBHjNiFhBfuR8jv/9MDmMjZxCpFo7S2gD7BatNzmZ6nP1/
RIQIliLks6/sHt9qcjkyHXxERoiP3Qs=
=uGrz
-----END PGP SIGNATURE-----

--aiGdtKHDVLsOXAYb--
