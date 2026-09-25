Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D365D4E56CE;
	Fri, 25 Sep 2026 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354407; cv=none; b=CzmiqPat66Q10xXZF0IjL8InoagbXFOn5sN7CsYIWX0SHqq5p6AQq5QtOmR6YKHzDBC8IbCQyVzTbHbiCkBkRKnoob+9Vn4xAahrhNsLhVZz8Fgyjq4kBV4jZTYPxjnO30I4FwIFg0Qkg5JtorJtDrZs2pr/zB4a5p6S6T8mF7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354407; c=relaxed/simple;
	bh=IWFAxBSbCDhkfLRaj5usAle7N96AQB+ppfiIX2Jqivo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvF37eSi9mfKIc3VzCkIrRPUc1NB1/Z1OR6LX5m2j5cEGHRL8i50DuwbIkgSjTvoaj4PjoH5mw6wtjAWskhWRRGsZaU7kSHkjXfzP37ALqVA9HEh1Bmu8vsO/GW+LizoRGRazcTY9wF1UhzO8G3X8C72zRqNx2C8GXFWwlm7E/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+B2oGu+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+B2oGu+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9132A1F00898;
	Fri, 25 Sep 2026 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790354384;
	bh=cppdBQoCb8bN1cmIysHAU9UTT/fw4ZboMtHQ8fzju74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G+B2oGu+tkA3M+a0whMu6w4BjGSf7tYcTyar5mf5fxaInlCj5dVBNfp3Q+Rcm8R9x
	 n/mvz0d3+GvcmFH/o1+oKiLQdQSZTkfvcSVkdQVth0Y6IWAPBwWDP0M+bDQJMa08+W
	 2oZCqpmpZNH+w3dijvCEevMzMdk5wZ+XcJwRtujThHRS1nvBnu3DyePOiWnz8xUFBc
	 qKVj+/VvhpETOdE1wQUM0WaMhgb1c5ckIBgl/nxYU1zvcAn4e3b+9xp+ponjvDWsgU
	 W9lGKf41qmMkZq7uzbCUVO4oTroHYBWO2sCG5MciQ6VqGEVYwvRuN+VikvzxrzNG1q
	 JLEKckGvts/Bw==
From: Simon Horman <horms@kernel.org>
To: parvathi@couthit.com
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	afd@ti.com,
	vadim.fedorenko@linux.dev,
	haokexin@gmail.com,
	basharath@couthit.com,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	m-malladi@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: Re: [PATCH net-next v4 2/3] net: ti: icssm-prueth: Add priority based RX IRQ handlers
Date: Fri, 25 Sep 2026 17:39:33 +0100
Message-ID: <20260925163933.721156-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921134343.200426-3-parvathi@couthit.com>
References: <20260921134343.200426-3-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260921134343.200426-4-parvathi@couthit.com?part=2
---
Subject: net: ti: icssm-prueth: Add priority based RX IRQ handlers

This commit adds support for priority-based interrupt handling for the STP/RSTP
Switch, HSR, and PRP protocols to address port dominance. It records an IEP
hardware timestamp into the receive buffer to guarantee frames are delivered in
wire-arrival order. The patch also converts statistics counters to atomic64_t
and adds a firmware revision field to support different timestamp wraparound
behaviors.

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> index 6c8888d9d66a6..4a37935b8d352 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
[ ... ]
> @@ -1071,11 +1083,25 @@ static int icssm_emac_ndo_open(struct net_device *ndev)
>  			goto iep_exit;
>  	}
>  
> -	ret = icssm_emac_request_irqs(emac);
> -	if (ret)
> -		goto rproc_shutdown;
> +	if (PRUETH_IS_EMAC(prueth)) {
> +		napi_enable(&emac->napi);
> +	} else {
> +		if (!prueth->emac_configured &&
> +		    (PRUETH_IS_SWITCH(prueth) || prueth_is_lre(prueth))) {
> +			napi_enable(&prueth->napi_hpq);
> +			napi_enable(&prueth->napi_lpq);

[Severity: High]
Does this code risk a NULL pointer dereference?

If MII0 is missing (e.g., absent from the device tree), the shared NAPI
structures napi_hpq and napi_lpq are not initialized in
icssm_prueth_netdev_init(). If the MII1 interface is later placed into SWITCH
mode and brought up, it appears icssm_emac_ndo_open() will unconditionally call
napi_enable() on these zero-initialized structures, causing a NULL pointer
dereference on n->dev.

> +		}
> +	}
[ ... ]
> @@ -1780,9 +1820,25 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
>  
>  	netif_napi_add(ndev, &emac->napi, icssm_emac_napi_poll);
>  
> +	if ((prueth->support_lre || fw_data->support_switch) &&
> +	    emac->port_id == PRUETH_PORT_MII0) {
> +		netif_napi_add(ndev, &prueth->napi_hpq,
> +			       icssm_prueth_common_napi_poll_hpq);
> +		netif_napi_add(ndev, &prueth->napi_lpq,
> +			       icssm_prueth_common_napi_poll_lpq);
> +	}
> +
>  	hrtimer_setup(&emac->tx_hrtimer, &icssm_emac_tx_timer_callback,
>  		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
>  
> +	if ((prueth->support_lre || fw_data->support_switch) &&
> +	    emac->port_id == PRUETH_PORT_MII0) {
> +		prueth->hp->ndev = ndev;
> +		prueth->hp->priority = 0;
> +		prueth->lp->ndev = ndev;
> +		prueth->lp->priority = 1;
> +	}
> +
>  	return 0;
[ ... ]
> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
> new file mode 100644
> index 0000000000000..9b7b876240b5f
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
[ ... ]
> +static irqreturn_t icssm_prueth_common_emac_rx_hardirq(int irq, void *dev_id)
> +{
> +	struct prueth_ndev_priority *ndev_prio;
> +	struct prueth_emac *emac;
> +	struct net_device *ndev;
> +	struct prueth *prueth;
> +
> +	ndev_prio = (struct prueth_ndev_priority *)dev_id;
> +	ndev = ndev_prio->ndev;

[Severity: High]
Similarly, can this IRQ handler dereference an uninitialized pointer?

If MII0 is missing and these priority structures were skipped during
initialization, it looks like the registered IRQ handler will dereference the
zero-initialized ndev_prio->ndev here when an interrupt occurs.

> +	emac = netdev_priv(ndev);
> +	prueth = emac->prueth;

[Severity: Medium]
This is a pre-existing issue, but can the transmission path read out of bounds?

In drivers/net/ethernet/ti/icssm/icssm_prueth.c:icssm_prueth_get_tx_queue_id():

    err = vlan_get_tag(skb, &vlan_tci);

icssm_emac_ndo_start_xmit() calls icssm_prueth_get_tx_queue_id() before
validating the length of the transmitted skb or padding it. Because the device
lacks NETIF_F_HW_VLAN_CTAG_TX, vlan_get_tag() falls back to __vlan_get_tag(),
which reads the VLAN TCI at offset 14. If a raw socket transmits a packet
smaller than 18 bytes (e.g., exactly 14 bytes) with h_vlan_proto ==
ETH_P_8021Q, this reads unallocated memory past the buffer.
