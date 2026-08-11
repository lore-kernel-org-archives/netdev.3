Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AFC41A90B
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437583; cv=none; b=C+eX9WTryIJCQ/8cRGFa6w+9VDLy3nfp7i4QreDjsDKK2sfhy5Q6fOMReVHHOq0CFexF/Z91LlGRpNcIeOAFvUMOChOcuaX91Ifv5jJqnWbYOFsqQPeKwKKz/ux12ltWWWJIh9y85HydecaLnmhyuL06FUaAG45X+fegD+H4ie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437583; c=relaxed/simple;
	bh=o5qU/pG1z5UF9wuc02h7YCOZrlfA9PKaDNZeORNuZJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rgcm6hPGFZRCgG/o8iKR1MrzQXeDkMfI2IBM+UPQmtNOHEE0Iu3K2B+klNQx9y+S19VEoc8dVKHbt4zlIW3K5X56pyjZ2SspX5hIlAOnk+ViEN4wKUeMbW+mVArr9gGek8b+wZmwa9I7rlm6Um1x0w/AGhRCQdI8AfEHuf+xFcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8XFnPcm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8XFnPcm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786437580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7OQ1BiraWrtesytuNF5zy/Gw3bTo5uPQ9O+gdqmNCTk=;
	b=f8XFnPcmxxlZ5s+R7VeIuqbRxeqANRgLRY+6GTkUuAEVcvv02hNjGEkRK9I/Zlo4SphN1l
	ic1nOIFdupf9rQmueOYK+AFYvQkkJYGThJeHa2X/Mvn8JgOFcf1CNvs55G2Y0eMPZ+GIzb
	bI7xDMNMuhKcryTlovP2lytr8+kEVU0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-37TjweB1M-6RZhGm2_DukQ-1; Tue,
 11 Aug 2026 04:39:36 -0400
X-MC-Unique: 37TjweB1M-6RZhGm2_DukQ-1
X-Mimecast-MFC-AGG-ID: 37TjweB1M-6RZhGm2_DukQ_1786437573
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E81F61800646;
	Tue, 11 Aug 2026 08:39:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.134])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3105718005BB;
	Tue, 11 Aug 2026 08:39:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: parvathi@couthit.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	afd@ti.com,
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
Subject: Re: [PATCH net-next v3 1/3] net: ti: icssm-prueth: Add HSR and PRP HW offload mode support for AM57xx, AM437x and AM335x
Date: Tue, 11 Aug 2026 10:39:14 +0200
Message-ID: <20260811083914.24414-1-pabeni@redhat.com>
In-Reply-To: <20260804121644.465118-2-parvathi@couthit.com>
References: <20260804121644.465118-2-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
--- Patch [1]: [PATCH net-next v3 1/3] net: ti: icssm-prueth: Add HSR and PRP HW offload mode support for AM57xx, AM437x and AM335x ---
commit f653927696e40849a8dce31458a3da04f6773137
Author: Roger Quadros <rogerq@ti.com>

net: ti: icssm-prueth: Add HSR and PRP HW offload mode support for AM57xx, AM437x and AM335x

This adds HSR and PRP offload modes to the ICSSM PRUETH driver, on top of
the existing dual-EMAC and RSTP switch modes. The two PRU ports become LRE
slave ports and dedicated PRU firmware handles duplicate discard and, for
HSR, L2 forwarding. Mode selection is driven by the HSR/PRP offload feature
bits plus the hsr upper device link notification.

A few questions on the new code below.

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> index b7e94244355a3..138248f4a1eed 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c

[ ... ]

> @@ -40,6 +41,30 @@
>  #define TX_CLK_DELAY_100M	0x6
>  #define HR_TIMER_TX_DELAY_US	100
>  
> +#define NETIF_PRUETH_LRE_OFFLOAD_FEATURES       (NETIF_F_HW_HSR_FWD | \
> +						 NETIF_F_HW_HSR_TAG_RM)
> +
> +static const struct prueth_fw_offsets fw_offsets_v2_1;
> +static void icssm_prueth_set_fw_offsets(struct prueth *prueth)
> +{
> +	/* Set Multicast filter control and table offsets */
> +	if (PRUETH_IS_EMAC(prueth) || PRUETH_IS_SWITCH(prueth)) {
> +		prueth->fw_offsets.mc_ctrl_offset  =
> +			ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_OFFSET;
> +		prueth->fw_offsets.mc_filter_mask =
> +			ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OFFSET;
> +		prueth->fw_offsets.mc_filter_tbl =
> +			ICSS_EMAC_FW_MULTICAST_FILTER_TABLE;
> +	} else {
> +		prueth->fw_offsets.mc_ctrl_offset  =
> +			ICSS_LRE_FW_MULTICAST_TABLE_SEARCH_OP_CONTROL_BIT;
> +		prueth->fw_offsets.mc_filter_mask =
> +			ICSS_LRE_FW_MULTICAST_FILTER_MASK;
> +		prueth->fw_offsets.mc_filter_tbl =
> +			ICSS_LRE_FW_MULTICAST_FILTER_TABLE;
> +	}
> +}
> +
>  static void icssm_prueth_write_reg(struct prueth *prueth,
>  				   enum prueth_mem region,
>  				   unsigned int reg, u32 val)

> @@ -309,12 +334,15 @@ static void icssm_prueth_hostinit(struct prueth *prueth)
>  	icssm_prueth_mii_init(prueth);
>  }
>  
> -/* This function initialize the driver in EMAC mode
> +/* Initialize the driver in EMAC, HSR or PRP mode
>   * based on eth_type
>   */
>  static void icssm_prueth_init_ethernet_mode(struct prueth *prueth)
>  {
> +	icssm_prueth_set_fw_offsets(prueth);
>  	icssm_prueth_hostinit(prueth);
> +	if (prueth_is_lre(prueth))
> +		icssm_prueth_lre_config(prueth);
>  }

> @@ -564,7 +592,7 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
>  	}
>  
>  	pkt_block_size = DIV_ROUND_UP(pktlen, ICSS_BLOCK_SIZE);
> -	if (pkt_block_size > free_blocks) /* out of queue space */
> +	if (pkt_block_size >= free_blocks) /* out of queue space */
>  		return -ENOBUFS;

[Severity: Low]
[Finding: main-1-1]
[Sources: opus-5]
This changes the queue full test in icssm_prueth_tx_enqueue() for every
mode, including the existing dual-EMAC and RSTP switch paths, and it is not
mentioned in the commit message. Was this meant to be part of the HSR/PRP
work?

When pkt_block_size equals free_blocks, update_block wraps exactly onto
read_block, so the new wr_ptr equals rd_ptr, which both the driver and the
firmware read as "queue empty".

If that is the reason for the change, would it be better as its own patch
with a Fixes: tag pointing at the commit that added
icssm_prueth_tx_enqueue()?

[ ... ]

> @@ -1122,7 +1185,8 @@ static int icssm_prueth_change_mode(struct prueth *prueth,
>  		}
>  	}
>  
> -	if (mode == PRUSS_ETHTYPE_EMAC || mode == PRUSS_ETHTYPE_SWITCH) {
> +	if (mode == PRUSS_ETHTYPE_EMAC || mode == PRUSS_ETHTYPE_SWITCH ||
> +	    mode == PRUSS_ETHTYPE_HSR || mode == PRUSS_ETHTYPE_PRP) {
>  		prueth->eth_type = mode;
>  	} else {
>  		dev_err(prueth->dev, "unknown mode\n");

[Severity: High]
[Finding: main-4-12]
[Sources: opus-5]
This isn't a bug introduced by this patch, but the patch adds two new entry
points into icssm_prueth_change_mode() (HSR and PRP) together with firmware
names that are usually absent from a stock /lib/firmware, so the existing
failure path becomes much easier to reach.

icssm_prueth_change_mode() calls ndo_stop()/ndo_open() directly, so
__LINK_STATE_START is never cleared. icssm_emac_ndo_open() boots the PRU
firmware before napi_enable() and the IRQ requests, so a missing
ti-pruss/am57xx-pru0-pruhsr-fw.elf returns an error with both interfaces
left netif_running(), their rx IRQ already freed, their NAPI disabled, and
prueth->eth_type already switched to the new mode.

A later "ip link set eth2 down" re-enters icssm_emac_ndo_stop(), which now
takes the non-EMAC branch:

	if (!prueth->emac_configured &&
	    (PRUETH_IS_SWITCH(prueth) || prueth_is_lre(prueth))) {
		napi_disable(&prueth->napi_lpq);
		napi_disable(&prueth->napi_hpq);
	}

on NAPI instances that were never enabled. netif_napi_add_weight_locked()
leaves NAPI_STATE_SCHED and NAPI_STATE_NPSVC set, and napi_disable_locked()
then spins:

		while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
			usleep_range(20, 200);
			val = READ_ONCE(n->state);
		}

with nothing left to clear those bits, while rtnl is held. In the same path
icssm_prueth_common_free_irqs() calls free_irq() on interrupts that were
never requested.

Should icssm_prueth_change_mode() restore eth_type and the interface state
when ndo_open() fails?

[ ... ]

> @@ -1316,11 +1393,16 @@ static void icssm_emac_mc_filter_bin_update(struct prueth_emac *emac, u8 hash,
>  {
>  	struct prueth *prueth = emac->prueth;
>  	void __iomem *mc_filter_tbl;
> +	u32 mc_filter_tbl_base;
>  	void __iomem *ram;
>  
>  	ram = prueth->mem[emac->dram].va;
> +	if (prueth_is_lre(prueth))
> +		ram = prueth->mem[PRUETH_MEM_DRAM1].va;
> +
> +	mc_filter_tbl_base = prueth->fw_offsets.mc_filter_tbl;
>  
> -	mc_filter_tbl = ram + ICSS_EMAC_FW_MULTICAST_FILTER_TABLE;
> +	mc_filter_tbl = ram + mc_filter_tbl_base;
>  	writeb(val, mc_filter_tbl + hash);
>  }

[Severity: Medium]
[Finding: main-2-7]
[Sources: opus-5]
Can prueth->fw_offsets.mc_filter_tbl still be zero here?

The offsets are only filled in by icssm_prueth_set_fw_offsets(), reached
from icssm_prueth_init_ethernet_mode(), which icssm_emac_ndo_open() calls
under "if (!prueth->emac_configured)". Until the first open,
icssm_prueth_probe() has only done:

	prueth->fw_offsets = fw_offsets_v2_1;

and that object initializes .iep_wrap only, so mc_ctrl_offset,
mc_filter_mask and mc_filter_tbl are all 0.

icssm_emac_mc_filter_bin_allow() is reachable in that window from the
switchdev blocking notifier, icssm_prueth_sw_blocking_event() ->
switchdev_handle_port_obj_add() -> icssm_prueth_switchdev_obj_add(), which
handles SWITCHDEV_OBJ_ID_HOST_MDB with no netif_running() or mode check:

		hash = icssm_emac_get_mc_hash(mdb->addr, emac->mc_filter_mask);
		icssm_emac_mc_filter_bin_allow(emac, hash);

With a zero base the writeb() lands at PRU DMEM offset 0 + hash rather than
the multicast filter table, and the MDB entry is lost, since
icssm_emac_ndo_set_rx_mode() only reprograms from the netdev and bridge mc
lists. Before this patch the base was the compile time constant
ICSS_EMAC_FW_MULTICAST_FILTER_TABLE, so the write always hit the real
table.

[ ... ]

> @@ -1429,15 +1518,95 @@ static void icssm_emac_ndo_set_rx_mode(struct net_device *ndev)

[ ... ]

> +/**
> + * icssm_emac_ndo_set_features - Configure HSR/PRP offload features
> + * @ndev: network device
> + * @features: Requested feature set
> + *
> + * Called by ethtool -K to configure HSR/PRP offload features. The request
> + * is rejected if this interface or its paired interface is running.
> + *
> + * Return: 0 on success, -EINVAL or -EBUSY on error.
> + */
> +static int icssm_emac_ndo_set_features(struct net_device *ndev,
> +				       netdev_features_t features)
> +{
> +	struct prueth_emac *emac, *other_emac;
> +	netdev_features_t have, wanted;
> +	struct prueth *prueth;
> +	bool change_request;
> +	int ret = -EBUSY;
> +
> +	emac = netdev_priv(ndev);
> +	prueth = emac->prueth;
> +	/* MAC instance index starts from 0. So index by port_id - 1 */
> +	other_emac = emac->prueth->emac[(emac->port_id == PRUETH_PORT_MII0) ?
> +				PRUETH_PORT_MII1 - 1 : PRUETH_PORT_MII0 - 1];
> +	wanted = features & NETIF_PRUETH_LRE_OFFLOAD_FEATURES;
> +	have = ndev->features & NETIF_PRUETH_LRE_OFFLOAD_FEATURES;
> +	change_request = ((wanted ^ have) != 0);
> +
> +	if (!prueth->fw_data->support_lre)
> +		return 0;
> +
> +	if (PRUETH_IS_SWITCH(prueth) && change_request) {
> +		/* LRE offload cannot be enabled in switch mode, remove the
> +		 * bridge first to revert to EMAC mode.
> +		 */
> +		netdev_err(ndev,
> +			   "Switch to HSR/PRP not allowed\n");
> +		return -EINVAL;
> +	}
> +
> +	if (netif_running(ndev) && change_request) {
> +		netdev_err(ndev,
> +			   "Can't change feature when device runs\n");
> +		return ret;
> +	}
> +
> +	if (other_emac && netif_running(other_emac->ndev) && change_request) {
> +		netdev_err(ndev,
> +			   "Can't change feature when other device runs\n");
> +		return ret;
> +	}
> +
> +	return 0;
>  }

[Severity: Medium]
[Finding: main-3-9]
[Sources: opus-5]
icssm_emac_ndo_set_features() only validates the request and never touches
the datapath. The firmware switch happens exclusively in
icssm_prueth_ndev_event(), and only if the LRE bits are already set when the
NETDEV_CHANGEUPPER linking event fires:

		if (is_hsr_master(info->upper_dev)) {
			if (info->linking) {
				if (ndev->features &
				    NETIF_PRUETH_LRE_OFFLOAD_FEATURES)
					ret = icssm_prueth_hsr_port_link
						(ndev, info->upper_dev);

What happens if the hsr device is created before the offload is enabled,
i.e. the reverse of the order in the commit message? With both ports down,
none of the three guards above fire, so set_features returns 0,
prueth->eth_type stays PRUSS_ETHTYPE_EMAC and "ip link set eth2 up" boots
the dual EMAC firmware, while both netdevs now advertise
NETIF_F_HW_HSR_FWD and NETIF_F_HW_HSR_TAG_RM.

The HSR core reads the slave features per frame, for example in
hsr_forward_do():

		if ((port->dev->features & NETIF_F_HW_HSR_DUP) && sent)
			continue;

so the stack stops duplicating and tag-handling while the EMAC firmware does
neither, with nothing reported to the user. Clearing the features while the
ports are down but still hsr slaves gives the opposite mismatch: LRE
firmware loaded with the offload bits cleared.

Should set_features reject the change while the port is an hsr slave, or
drive the mode switch itself?

> @@ -1741,6 +1913,105 @@ static int icssm_prueth_ndev_port_unlink(struct net_device *ndev)
>  	return ret;
>  }
>  
> +static int icssm_prueth_hsr_port_link(struct net_device *ndev,
> +				      struct net_device *hsr_ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth *prueth = emac->prueth;
> +	enum pruss_ethtype mode;
> +	enum hsr_version ver;
> +	unsigned long flags;
> +	u8 all_slaves;
> +	int ret = 0;
> +
> +	if (PRUETH_IS_SWITCH(prueth))
> +		return -EOPNOTSUPP;
> +
> +	hsr_get_version(hsr_ndev, &ver);
> +
> +	if (ver == HSR_V1)
> +		mode = PRUSS_ETHTYPE_HSR;
> +	else if (ver == PRP_V1)
> +		mode = PRUSS_ETHTYPE_PRP;
> +	else
> +		return -EOPNOTSUPP;
> +
> +	all_slaves = BIT(PRUETH_PORT_MII0) | BIT(PRUETH_PORT_MII1);
> +
> +	spin_lock_irqsave(&prueth->addr_lock, flags);
> +
> +	if (!prueth->hsr_members) {
> +		prueth->hsr_dev = hsr_ndev;
> +	} else {
> +		/* Adding the port to a second bridge is not supported */
> +		if (prueth->hsr_dev != hsr_ndev) {
> +			spin_unlock_irqrestore(&prueth->addr_lock, flags);
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	prueth->hsr_members |= BIT(emac->port_id);
> +
> +	spin_unlock_irqrestore(&prueth->addr_lock, flags);
> +
> +	if (!prueth_is_lre(prueth) && prueth->hsr_members == all_slaves) {
> +		ret = icssm_prueth_change_mode(prueth, mode);
> +		if (ret < 0) {
> +			dev_err(prueth->dev, "Failed to enable %s mode\n",
> +				(mode == PRUSS_ETHTYPE_HSR) ?
> +				"HSR" : "PRP");
> +			goto free_hsr;
> +		} else {
> +			dev_info(prueth->dev,
> +				 "TI PRU ethernet now in %s mode\n",
> +				 (mode == PRUSS_ETHTYPE_HSR) ?
> +				 "HSR" : "PRP");
> +		}
> +	}
> +
> +	return 0;
> +
> +free_hsr:
> +	spin_lock_irqsave(&prueth->addr_lock, flags);
> +
> +	prueth->hsr_dev = NULL;
> +	prueth->hsr_members &= ~all_slaves;
> +
> +	spin_unlock_irqrestore(&prueth->addr_lock, flags);
> +	return ret;
> +}

[Severity: Medium]
[Finding: main-3-10]
[Sources: opus-5]
icssm_prueth_change_mode() commits prueth->eth_type = mode before reopening
the ports and returns the ndo_open() error without restoring it. So when
this free_hsr path runs, hsr_dev and both port bits of hsr_members are
cleared, including the peer port that is still linked, while eth_type stays
PRUSS_ETHTYPE_HSR or PRUSS_ETHTYPE_PRP.

The driver then keeps taking the non-EMAC paths with no hsr device attached:
icssm_prueth_sw_emac_config(), icssm_prueth_lre_config_check_flags(), the
DRAM1 multicast filter offsets and the HSR bit in the TX buffer descriptor.

Because the switch is gated on

	if (!prueth_is_lre(prueth) && prueth->hsr_members == all_slaves) {

a later link request for the other protocol computes mode but skips
icssm_prueth_change_mode() entirely, so creating prp0 after a failed hsr0
attempt leaves the HSR firmware running while the PRUETH_IS_PRP() rx/tx
paths are active. Should eth_type be restored here?

> +
> +static int icssm_prueth_hsr_port_unlink(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth *prueth = emac->prueth;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&prueth->addr_lock, flags);
> +
> +	prueth->hsr_members &= ~BIT(emac->port_id);
> +
> +	spin_unlock_irqrestore(&prueth->addr_lock, flags);
> +
> +	if (prueth_is_lre(prueth) && !prueth->hsr_members) {
> +		ret = icssm_prueth_change_mode(prueth, PRUSS_ETHTYPE_EMAC);
> +		if (ret < 0) {
> +			dev_err(prueth->dev, "Failed to enable dual EMAC mode\n");
> +			return ret;
> +		}
> +	}
> +
> +	spin_lock_irqsave(&prueth->addr_lock, flags);
> +
> +	if (!prueth->hsr_members)
> +		prueth->hsr_dev = NULL;
> +
> +	spin_unlock_irqrestore(&prueth->addr_lock, flags);
> +
> +	return 0;
> +}

[Severity: Medium]
[Finding: main-3-10]
[Sources: opus-5]
On this early return, the trailing block that clears prueth->hsr_dev is
skipped, so the driver keeps a pointer to the hsr master that is being
unlinked and destroyed, stored without dev_hold(), and eth_type stays HSR or
PRP with no members left. Is the early return intended here?

> @@ -1754,6 +2025,17 @@ static int icssm_prueth_ndev_event(struct notifier_block *unused,
>  	switch (event) {
>  	case NETDEV_CHANGEUPPER:
>  		info = ptr;
> +		if (is_hsr_master(info->upper_dev)) {
> +			if (info->linking) {
> +				if (ndev->features &
> +				    NETIF_PRUETH_LRE_OFFLOAD_FEATURES)
> +					ret = icssm_prueth_hsr_port_link
> +						(ndev, info->upper_dev);
> +			} else {
> +				ret = icssm_prueth_hsr_port_unlink(ndev);
> +			}
> +		}
> +

[ ... ]

> @@ -1810,6 +2093,7 @@ static int icssm_prueth_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, prueth);
>  	prueth->dev = dev;
>  	prueth->fw_data = device_get_match_data(dev);
> +	prueth->fw_offsets = fw_offsets_v2_1;

[ ... ]

> @@ -1955,6 +2239,17 @@ static int icssm_prueth_probe(struct platform_device *pdev)
>  		prueth->mem[PRUETH_MEM_OCMC].va,
>  		prueth->mem[PRUETH_MEM_OCMC].size);
>  
> +	if (IS_ENABLED(CONFIG_HSR) && prueth->fw_data->support_lre)
> +		has_lre = true;

[Severity: Low]
[Finding: main-2-5]
[Sources: opus-5]
IS_ENABLED(CONFIG_HSR) is also true for CONFIG_HSR=m, and the driver now
calls is_hsr_master() and hsr_get_version() unconditionally from
icssm_prueth_ndev_event() and icssm_prueth_hsr_port_link().

include/linux/if_hsr.h only provides inline stubs for those two helpers when
CONFIG_HSR is disabled entirely:

	#if IS_ENABLED(CONFIG_HSR)
	extern bool is_hsr_master(struct net_device *dev);
	extern int hsr_get_version(struct net_device *dev, enum hsr_version *ver);

so CONFIG_TI_PRUETH=y with CONFIG_HSR=m compiles but fails to link vmlinux
with undefined references to is_hsr_master and hsr_get_version.

config TI_PRUETH in drivers/net/ethernet/ti/Kconfig has no HSR dependency,
while TI_ICSSG_PRUETH in the same file carries:

	depends on HSR || !HSR

Should TI_PRUETH get the same dependency?

[ ... ]

Cross-instance finding from sashiko-gemini (93d76c56ba422a009191856aaee1fc66bed8b1079668a5e6078c97f738cb4d2c):
[Severity: Medium]
[Finding: 93d76c56ba422a009191856aaee1fc66bed8b1079668a5e6078c97f738cb4d2c]
[Sources: sashiko-gemini]
The `NETIF_F_HW_HSR_DUP` flag is missing from `NETIF_PRUETH_LRE_OFFLOAD_FEATURES`, preventing hardware duplicate discard offloading.
-- 
This is an AI-generated review.

