Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE1409E14
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191323; cv=none; b=LdSAQE/yE9ZsHnDM3V5L68tZ96XRWPISjkp4jdc5wFYcs9t5M/KbIB5OJMi6bfbF7JWZ+QkMdF03+xMLRfXR9bi5zPaiSt05S10Q6JzdOQTLwsMV6uGoTcI2YjxIFcHAtG4M9OCFtlgUwg+2Rg5iK/iSZEVPPBZvfJvtVC1Q7hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191323; c=relaxed/simple;
	bh=xcJovOR84HorUqAtV807KFXDtQiIn6C8593dyxAZomM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCo+FafTmZbnBst/6CmQPg0GaJFJcFBBKw5l//WXZHwa+yqgqIype9MRhu+klLGZMyudKJ5UxrH4Lk9sVtUPPKCz0wpQ/kG9J7pp69rBBwCbrc+wHMoDbSyplExv2Z4KLlD4Jm7v5rzbgC4Q0PFTmDJFc8UinspV6Su8bLrLa0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnTtkqfE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnTtkqfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8AB1F00893;
	Thu, 11 Jun 2026 15:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191320;
	bh=67zy/OO6GQWRBTDkMhIuirY1PwgjkWuKrq96K18/+fE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PnTtkqfEnRlAe9XW0BRr+WBX5P3w7ZUqQt3abKlffNJe2YiJL1KVRI04aV24lDwdz
	 C4HuHGlIGRjT/oWunnlUSxa1IJFIBwVrH6C9s3YofRcSGZ3lf8lfCDmMku6Fbsa5oU
	 LdVmDwYP50OAlUjXlvwKUjKMJqYn9wtPxUsviCUyfRtmWB9hTiVSAXC6LcJP9QFU1z
	 tCZNClSubswZhsJfG19qYVnR+7CRmtwZYS+K+MJb7ZYJXRkSR+mIz/riD7+9+bOH3j
	 gGRHAXcciQx+WE2/WUGJh2HCNvQaHaN7uOJ63eGAWuNEUc5NgESszEL2CtsfSoSXzF
	 99VyWTVdMyACw==
Date: Thu, 11 Jun 2026 17:21:58 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v4 1/2] net: airoha: refactor QDMA start/stop
 into reusable helpers
Message-ID: <airSlpMoBvcuRcK5@lore-desk>
References: <20260610-airoha-ethtool-priv_flags-v4-0-60e89cf28fea@kernel.org>
 <20260610-airoha-ethtool-priv_flags-v4-1-60e89cf28fea@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xTiMez6xNLZ7OD9M"
Content-Disposition: inline
In-Reply-To: <20260610-airoha-ethtool-priv_flags-v4-1-60e89cf28fea@kernel.org>


--xTiMez6xNLZ7OD9M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Factor out airoha_qdma_start() and airoha_qdma_stop() from
> airoha_dev_open() and airoha_dev_stop(). These helpers will be reused
> by the QDMA hot-migration logic introduced in the next patch to
> dynamically switch GDM3/GDM4 ports between LAN and WAN QDMA blocks.
> Add a DMA engine busy poll in airoha_qdma_stop() to wait for in-flight
> DMA transfers to complete before cleaning up TX queues.
>=20
> Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 53 ++++++++++++++++++++++----=
------
>  1 file changed, 36 insertions(+), 17 deletions(-)

Both of the issues reportd by sashiko here are not introduced by this patch
https://sashiko.dev/#/patchset/20260610-airoha-ethtool-priv_flags-v4-0-60e8=
9cf28fea%40kernel.org

Regards,
Lorenzo

>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 5a8e84fa9918..aeac66df5f3b 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1771,6 +1771,40 @@ static void airoha_update_hw_stats(struct airoha_g=
dm_dev *dev)
>  	spin_unlock(&port->stats.lock);
>  }
> =20
> +static void airoha_qdma_start(struct airoha_qdma *qdma)
> +{
> +	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
> +			GLOBAL_CFG_TX_DMA_EN_MASK |
> +			GLOBAL_CFG_RX_DMA_EN_MASK);
> +	atomic_inc(&qdma->users);
> +}
> +
> +static void airoha_qdma_stop(struct airoha_qdma *qdma)
> +{
> +	u32 status;
> +
> +	if (!atomic_dec_and_test(&qdma->users))
> +		return;
> +
> +	airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
> +			  GLOBAL_CFG_TX_DMA_EN_MASK |
> +			  GLOBAL_CFG_RX_DMA_EN_MASK);
> +
> +	if (read_poll_timeout(airoha_qdma_rr, status,
> +			      !(status & (GLOBAL_CFG_TX_DMA_BUSY_MASK |
> +					  GLOBAL_CFG_RX_DMA_BUSY_MASK)),
> +			      USEC_PER_MSEC, 50 * USEC_PER_MSEC, true,
> +			      qdma, REG_QDMA_GLOBAL_CFG))
> +		dev_warn(qdma->eth->dev, "QDMA DMA engine busy timeout\n");
> +
> +	for (int i =3D 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
> +		if (!qdma->q_tx[i].ndesc)
> +			continue;
> +
> +		airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
> +	}
> +}
> +
>  static int airoha_dev_open(struct net_device *netdev)
>  {
>  	int err, len =3D ETH_HLEN + netdev->mtu + ETH_FCS_LEN;
> @@ -1806,10 +1840,7 @@ static int airoha_dev_open(struct net_device *netd=
ev)
>  	}
>  	port->users++;
> =20
> -	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
> -			GLOBAL_CFG_TX_DMA_EN_MASK |
> -			GLOBAL_CFG_RX_DMA_EN_MASK);
> -	atomic_inc(&qdma->users);
> +	airoha_qdma_start(qdma);
> =20
>  	if (!airoha_is_lan_gdm_dev(dev) &&
>  	    airoha_ppe_is_enabled(qdma->eth, 1))
> @@ -1862,19 +1893,7 @@ static int airoha_dev_stop(struct net_device *netd=
ev)
>  		airoha_set_gdm_port_fwd_cfg(qdma->eth,
>  					    REG_GDM_FWD_CFG(port->id),
>  					    FE_PSE_PORT_DROP);
> -
> -	if (atomic_dec_and_test(&qdma->users)) {
> -		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
> -				  GLOBAL_CFG_TX_DMA_EN_MASK |
> -				  GLOBAL_CFG_RX_DMA_EN_MASK);
> -
> -		for (i =3D 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
> -			if (!qdma->q_tx[i].ndesc)
> -				continue;
> -
> -			airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
> -		}
> -	}
> +	airoha_qdma_stop(qdma);
> =20
>  	return 0;
>  }
>=20
> --=20
> 2.54.0
>=20

--xTiMez6xNLZ7OD9M
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCairSlgAKCRA6cBh0uS2t
rBpSAPsERGWK1pGGToiFzIeR/RD8joMzAOFuAtARjMUbn3z89AEAv5JGguQL7ZxO
DrBnleDOjUsudpd92AZkknnf0TunDQg=
=4QHw
-----END PGP SIGNATURE-----

--xTiMez6xNLZ7OD9M--
