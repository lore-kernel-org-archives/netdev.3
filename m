Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0529284B29;
	Fri, 10 Apr 2026 02:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775789848; cv=none; b=l6TgStjWvKWabsE9PQaTfCAKgueBxlMMHdARdkYrxtthDKnHb60Dqme7Z2SUb5vZwM5dBBb+mV1/kN1jKmpLFeK6a2nM9dkoRjFAATYKXhy/Bgl4gZ5sdQWnmcoK2EHGnY4rvRGvohmnkdG6jPNwo3ZhiBu1y1jHfcHlm6MEG9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775789848; c=relaxed/simple;
	bh=b4xD/+mpr9o9kgl1UA62EmigJZ8lba96RZbJRwa3Yw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCp78+w4sxSadQT/1b0+YfAmFfaLtDYMjqtQjtZDKU/x/07ClhVGvDVH1EzuoxDl6Phx6mQSkU4hTMhSs9hlyVRiOxYrnWqybWcA5/vclyTTF59HlwdW3wIzi3ifcNY2aK3B4HTZc5RoEbRvC1wMX8jv0vAcZSuzeeqIbzri0Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIh0ty76; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIh0ty76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C95C2BCB0;
	Fri, 10 Apr 2026 02:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775789848;
	bh=b4xD/+mpr9o9kgl1UA62EmigJZ8lba96RZbJRwa3Yw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lIh0ty76j1L9vhQFe07Do7LogBIS1mmyz8o/oBtcPVH+jwoxWCOrNSMUG7cFFVmBu
	 jjmUV0gRqZZjGJvtjxIJymanqW7ml2hhf5MCDYxymnAq46SfIC5OaaldD1DU+1XwCc
	 SSvkP/60UCX9wwsbsbYXVIdPLIlk5SENmZMmQ5FPNrAuyaoQXQOykvdyBwTHUq7fbI
	 ZeFnFynL4+7XaIykZjyNK+FjRi0biLkJK0e6AIGG7e+BSrMeOz9s19gj/XL+aT1sMd
	 ZKMr0/4i1bblxK4FtnS30UsmhjJjtVGvBj7F8maBJTttiGkV2P+IyOhVyh8zIS2hYx
	 Ch3+98hjue5pA==
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
	Xuegang Lu <xuegang.lu@airoha.com>
Subject: Re: [PATCH net-next v3 10/12] net: airoha: Do not stop GDM port if it is shared
Date: Thu,  9 Apr 2026 19:57:26 -0700
Message-ID: <20260410025726.1810041-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406-airoha-eth-multi-serdes-v3-10-ab6ea49d59ff@kernel.org>
References: <20260406-airoha-eth-multi-serdes-v3-10-ab6ea49d59ff@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "For your consideration."
---
net: airoha: Do not stop GDM port if it is shared

Theoretically, in the current codebase, two independent net_devices can
be connected to the same GDM port so we need to check the GDM port is not
used by any other running net_device before setting the forward
configuration to FE_PSE_PORT_DROP.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index fd27ba13029bd..5b0cd37b155e4 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c

[ ... ]

> @@ -1688,18 +1693,18 @@ static int airoha_dev_stop(struct net_device *netdev)
>  	struct airoha_gdm_dev *dev = netdev_priv(netdev);
>  	struct airoha_gdm_port *port = dev->port;
>  	struct airoha_qdma *qdma = dev->qdma;
> -	int i, err;
> +	int i;
>  
>  	netif_tx_disable(netdev);
> -	err = airoha_set_vip_for_gdm_port(dev, false);
> -	if (err)
> -		return err;
> -
>  	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++)
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
>  
>  	if (atomic_dec_and_test(&qdma->users)) {
>  		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
> 				  GLOBAL_CFG_TX_DMA_EN_MASK |
> 				  GLOBAL_CFG_RX_DMA_EN_MASK);
> 
> 		for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
> 			if (!qdma->q_tx[i].ndesc)
> 				continue;
> 
> 			airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
> 		}
> 	}

This problem wasn't introduced by this patch, but does the QDMA teardown
path have a DMA corruption vulnerability here?

When GLOBAL_CFG_TX_DMA_EN_MASK is cleared, it fails to poll
GLOBAL_CFG_TX_DMA_BUSY_MASK, proceeding to unmap memory while the hardware
DMA engine may still be processing in-flight descriptors.

Furthermore, airoha_qdma_cleanup_tx_queue() unmaps the DMA addresses and
frees the SKBs, but it does not appear to clear the physical hardware
descriptors or reset the hardware ring pointers (REG_TX_CPU_IDX /
REG_TX_DMA_IDX).

When the device is later reopened in airoha_dev_open(),
GLOBAL_CFG_TX_DMA_EN_MASK is set again without re-initializing the rings.
Will the hardware DMA engine resume fetching from its previous index,
processing stale descriptors whose backing memory was already unmapped
and freed?

[ ... ]

> @@ -1851,10 +1856,22 @@ static void airoha_dev_get_stats64(struct net_device *netdev,
>  static int airoha_dev_change_mtu(struct net_device *netdev, int mtu)
>  {
>  	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> +	u32 cur_len, len = ETH_HLEN + mtu + ETH_FCS_LEN;
>  	struct airoha_gdm_port *port = dev->port;
> -	u32 len = ETH_HLEN + mtu + ETH_FCS_LEN;
>  	struct airoha_eth *eth = dev->eth;
>  
> +	cur_len = FIELD_GET(GDM_LONG_LEN_MASK,
> +			    airoha_fe_rr(eth, REG_GDM_LEN_CFG(port->id)));
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

Does this MTU decrease validation create a state trap on shared ports?

If both eth0 and eth1 (sharing a port) are up, and a user increases eth0 MTU
to 9000, the hardware MTU updates to 9000. If the user then tries to lower
eth0 MTU back to 1500, len < cur_len evaluates to true. Because eth1 is also
up (port_refcnt > 1), this returns -EBUSY.

This would prevent either interface from decreasing its MTU without fully
bringing down the sibling interface.

Should the software netdev->mtu be decoupled from the hardware validation,
allowing valid MTU changes in software while dynamically programming the
hardware MTU to the maximum of all currently up interfaces on the shared
port?
