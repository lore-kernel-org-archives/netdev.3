Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D151917CD;
	Sat,  9 May 2026 01:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291175; cv=none; b=T9gbf+jCiJVuNVAN4ahImRX7uM5FfSUNjZE2HQtSNCB/eTiBiNiwrObCEoKQPfUZGJ8Eew3NLilrvdFyJrHfPM7xdag7o6SL51ZZQ/npruwvfmfHuKLQFhS0Yrce6y6Ayad2+6czxOJ08KlOoNPOx1j2IK8uLe4CYIAwF4VKh0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291175; c=relaxed/simple;
	bh=nYr0hNgv18QNCyPqBuAJW/W6gk4EsbZrhqi6yKvcTvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Co4lTf9u/gXTVCkVftiiO58ePOV5dpEryGORcmCaRPHv4De0Ee68mj9j78wVA/fu3gby3Ws/kyms/dVS6O1nDYEUj6NqMzYjrVOVESYUJ6skCNUgRUVCaUw4Cd+bjm1EZQOLCawbQPzOmShUuH/krz+2xazbzfTJbpVtg5dv+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFkk1ehL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFkk1ehL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92860C2BCB0;
	Sat,  9 May 2026 01:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778291175;
	bh=nYr0hNgv18QNCyPqBuAJW/W6gk4EsbZrhqi6yKvcTvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFkk1ehLHN+3JVcpb2z/pdXYXYsT8jheE4V9U2T9NErQmAdNH4ebyOHJQsmVXQe7G
	 dCeQHg0cMGUnvlr+rP1l8VzO7vYe4ZiYhTwNWSx8EFsq4ESTY2E3dA2/3BiJH5pShq
	 iCptBudwxQbvHKbOFppgwGRdnu135eFRvQn0aZJ5aRBYSUBgIuAWHFq4caf1LL74Dx
	 2a87xYCfpKA75HFI01uyg6VbxExI76RaWHxc8Nli1v5axNA/AgYVXBeIpGv3ysZX63
	 R2MLXSCP2x8dTSvcqTsxpMrZFjftdbzAvGCDeeu7ar5xoVyRZKDltFsOPeq0JteTzo
	 i6FomOKMIuEtQ==
From: Jakub Kicinski <kuba@kernel.org>
To: lorenzo@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	madhur.agrawal@airoha.com
Subject: Re: [PATCH net-next v4 08/10] net: airoha: Do not stop GDM port if it is shared
Date: Fri,  8 May 2026 18:46:13 -0700
Message-ID: <20260509014613.3558087-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507-airoha-eth-multi-serdes-v4-8-af613b61ae02@kernel.org>
References: <20260507-airoha-eth-multi-serdes-v4-8-af613b61ae02@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: airoha: Do not stop GDM port if it is shared

This patch adds a per-port users refcount so the GDM forward configuration
is only reset to FE_PSE_PORT_DROP when the last netdev attached to the
shared GDM port stops, and it adjusts the MTU/length register updates to
cope with the shared case.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 0253919714e0..1c4927c1aeb0 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1714,8 +1714,8 @@ static int airoha_dev_open(struct net_device *netdev)
>  	int err, len = ETH_HLEN + netdev->mtu + ETH_FCS_LEN;
>  	struct airoha_gdm_dev *dev = netdev_priv(netdev);
>  	struct airoha_gdm_port *port = dev->port;
> +	u32 cur_len, pse_port = FE_PSE_PORT_PPE1;
>  	struct airoha_qdma *qdma = dev->qdma;
> -	u32 pse_port = FE_PSE_PORT_PPE1;
>  
>  	netif_tx_start_all_queues(netdev);
>  	err = airoha_set_vip_for_gdm_port(dev, true);
> @@ -1729,10 +1729,14 @@ static int airoha_dev_open(struct net_device *netdev)
>  		airoha_fe_clear(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
>  				GDM_STAG_EN_MASK);
>  
> -	airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
> -		      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
> -		      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
> -		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
> +	cur_len = airoha_fe_get(qdma->eth, REG_GDM_LEN_CFG(port->id),
> +				GDM_LONG_LEN_MASK);
> +	if (!atomic_read(&port->users) || len > cur_len)
> +		airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
> +			      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
> +			      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
> +			      FIELD_PREP(GDM_LONG_LEN_MASK, len));
> +	atomic_inc(&port->users);

[Medium]
When a second netdev opens with a larger MTU, this unconditionally
widens GDM_LONG_LEN_MASK for the already-running sibling that has a
smaller MTU:

	if (!atomic_read(&port->users) || len > cur_len)
		airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
			      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
			      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
			      FIELD_PREP(GDM_LONG_LEN_MASK, len));

Meanwhile airoha_dev_change_mtu() rejects shrinks (len < cur_len) with
-EBUSY when the port is shared. Is this asymmetry intentional?

With the new policy the hardware long-length ends up as the maximum of
the two MTUs, so the smaller-MTU sibling silently accepts frames larger
than its advertised MTU at the MAC level. Should opens that would
increase the shared length also be gated (symmetric policy), or should
the commit message and a comment document the chosen ceiling/floor
behaviour?

>  
>  	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
>  			GLOBAL_CFG_TX_DMA_EN_MASK |
> @@ -1762,8 +1766,12 @@ static int airoha_dev_stop(struct net_device *netdev)
>  	for (i = 0; i < netdev->num_tx_queues; i++)
>  		netdev_tx_reset_subqueue(netdev, i);
>  
> -	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
> -				    FE_PSE_PORT_DROP);
> +	if (atomic_dec_and_test(&port->users)) {
> +		airoha_set_vip_for_gdm_port(dev, false);
> +		airoha_set_gdm_port_fwd_cfg(qdma->eth,
> +					    REG_GDM_FWD_CFG(port->id),
> +					    FE_PSE_PORT_DROP);
> +	}

[Low]
Is the airoha_set_vip_for_gdm_port(dev, false) call inside the
atomic_dec_and_test() block intentional?

Looking at airoha_dev_stop() as a whole, the same call is already made
unconditionally a few lines above:

	netif_tx_disable(netdev);
	airoha_set_vip_for_gdm_port(dev, false);
	for (i = 0; i < netdev->num_tx_queues; i++)
		netdev_tx_reset_subqueue(netdev, i);

	if (atomic_dec_and_test(&port->users)) {
		airoha_set_vip_for_gdm_port(dev, false);
		...
	}

Since get_vip_port() derives the bit mask per-(port, dev->nbq) and
airoha_fe_clear() of already-cleared bits is a no-op, the second call
looks like dead code today. The commit log only mentions the
FE_PSE_PORT_DROP gating, not VIP handling. Should the duplicate be
dropped in v2?

>  
>  	if (atomic_dec_and_test(&qdma->users)) {
>  		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
> @@ -1915,10 +1923,22 @@ static void airoha_dev_get_stats64(struct net_device *netdev,
>  static int airoha_dev_change_mtu(struct net_device *netdev, int mtu)
>  {
>  	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> +	u32 cur_len, len = ETH_HLEN + mtu + ETH_FCS_LEN;
>  	struct airoha_gdm_port *port = dev->port;
> -	u32 len = ETH_HLEN + mtu + ETH_FCS_LEN;
>  	struct airoha_eth *eth = dev->eth;
>  
> +	cur_len = airoha_fe_get(eth, REG_GDM_LEN_CFG(port->id),
> +				GDM_LONG_LEN_MASK);
> +	if (len < cur_len) {
> +		u8 port_refcnt = atomic_read(&port->users);
> +
> +		/* We can decrease the device MTU just if the GDM port is
> +		 * not shared or if the other device is not running.
> +		 */
> +		if (port_refcnt > 1 || (port_refcnt && !netif_running(netdev)))
> +			return -EBUSY;
> +	}
> +

[Low]
Why is port_refcnt typed as u8 here when atomic_read() returns int?

	u8 port_refcnt = atomic_read(&port->users);

With AIROHA_MAX_NUM_GDM_DEVS currently 2 this cannot overflow, but a
future bump of AIROHA_MAX_NUM_GDM_DEVS, or a refcount leak, that pushed
port->users to 256 would wrap to 0 and quietly bypass both the
port_refcnt > 1 and port_refcnt && !netif_running(netdev) checks,
permitting MTU shrinks that are meant to be rejected. Would using int
here (the type atomic_read() returns) be preferable?

>  	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
>  		      GDM_LONG_LEN_MASK,
>  		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
