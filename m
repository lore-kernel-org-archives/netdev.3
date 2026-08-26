Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3923C09EE;
	Wed, 26 Aug 2026 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747447; cv=none; b=dUKhUBuDyyEbn8k5adbQ/AwH8Un6NJxl5EW1tt4RcZVi3w0B7wpHLtDP6YsVF848HsHjqhivLAIBW5AwGJwG8Jhm3MXJ9LWeT3inBXmke6GkWIWTc/4j/AJjERZ3ewhO3ULFYXM3MOJ9+RlSuLc+oCqZhdCYAH2dhdH5bqej6Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747447; c=relaxed/simple;
	bh=wvGhE+52Fql6i98sI1Gtbj/7nD33gWCEHoRGgVHUvy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMwAdF9XXvS4xjJtdTekrue+g+XXLfSGO5706zvAvH3dzeOWevO2lNlsclyisfsi7UCMrkJGTh34DMc3Kn9hXVB07zLdEl7JCteC2UYQrniRCQkLQsx6uq4RqsqQE8/ebPPiV8CxVZj4UTda/st9eD7EA89xa3oZ0Wsbf5Ea5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjaoQAB9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjaoQAB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424BF1F000E9;
	Wed, 26 Aug 2026 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787747445;
	bh=J95OHvb8T6GMaxZirBttOr2b123nqWN9/H4w2WykBjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TjaoQAB9T65MooQbhS8IufcTfowrnRayQVG8SNodQ9zzib2qRhQuXNp2VkmWSgvZ7
	 k72B2IpRX98QUx7V39OjZXfc5XJZ7rvI0sIg5KhFaWF5sYXeklaMACFggPOU3KE08d
	 cpbq5/uZXcD74R/ZBhijGfmsWrQkj6r5ltFBYDQTkOm7yV/RG11tIPYKpjMnkjAzQV
	 tkeCe6cE+S40lxF7+yN+5iirb2pcLvpVpU+d6YDZzECQTP9pDfANp7oklEDKKmsDPX
	 wyfT84cb7ipWH9+Etsy2HqlOcOnjujLJlrB3Ozsq/Syd9qjgQTIRZmCUSYXiIJAi9T
	 qVl5KbVu09amQ==
From: Simon Horman <horms@kernel.org>
To: vikas.gupta@broadcom.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com
Subject: Re: [PATCH net] bnge: add missing ndo_set_features
Date: Wed, 26 Aug 2026 13:30:20 +0100
Message-ID: <20260826123020.350008-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824085028.1174150-1-vikas.gupta@broadcom.com>
References: <20260824085028.1174150-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824085028.1174150-1-vikas.gupta@broadcom.com?part=1
---
bnge: add missing ndo_set_features

This adds a bnge_set_features() callback so that toggling LRO/GRO_HW via
ethtool -K actually reprograms the TPA engine. On a running interface it
recomputes bn->priv_flags, then tears down and re-opens the datapath with
bnge_close_core() followed by bnge_set_ring_params() and bnge_open_core().

A few questions about the reconfiguration sequence below.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index a4288f0258f87..0973cc25a3ec4 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> @@ -3267,6 +3267,33 @@ static const struct netdev_stat_ops bnge_stat_ops = {
>  	.get_base_stats		= bnge_get_base_stats,
>  };
>  
> +static int bnge_set_features(struct net_device *dev, netdev_features_t features)
> +{
> +	struct bnge_net *bn = netdev_priv(dev);
> +	struct bnge_dev *bd = bn->bd;
> +	u32 flags = bn->priv_flags;
> +
> +	flags &= ~BNGE_NET_EN_TPA;
> +	if (features & NETIF_F_GRO_HW)
> +		flags |= BNGE_NET_EN_GRO;
> +	else if (features & NETIF_F_LRO)
> +		flags |= BNGE_NET_EN_LRO;
> +
> +	if (flags == bn->priv_flags)
> +		return 0;
> +
> +	bn->priv_flags = flags;
        ^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Is it safe to publish the new TPA mode here, before the datapath has been
quiesced?  At this point NAPI is still running; bnge_disable_napi() is only
reached later, inside bnge_close_core().

The RX completion path reads the same word from softirq context with no
lock:

drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:bnge_tpa_end() {
	...
#ifdef CONFIG_INET
	if (bn->priv_flags & BNGE_NET_EN_GRO)
		skb = bnge_gro_skb(bn, tpa_info, tpa_end, tpa_end1, skb);
#endif
	...
}

So an aggregation that was started (TPA_START) while the VNIC was still
programmed for the old mode can be completed using the new flag value, and
bnge_gro_func() will then derive skb_set_network_header()/
skb_set_transport_header() offsets from TPA_START metadata that was produced
under the previous configuration.

bnxt_reinit_features() orders this the other way round - it closes first and
publishes afterwards:

drivers/net/ethernet/broadcom/bnxt/bnxt.c:bnxt_reinit_features() {
	bnxt_close_nic(bp, irq_re_init, link_re_init);
	bp->flags = flags;
	if (update_tpa)
		bnxt_set_ring_params(bp);
	return bnxt_open_nic(bp, irq_re_init, link_re_init);
}

Would moving the bn->priv_flags store below bnge_close_core() be preferable?

> +
> +	if (!netif_running(dev)) {
> +		bnge_set_ring_params(bd);
> +		return 0;
> +	}
> +
> +	bnge_close_core(bn);
> +	bnge_set_ring_params(bd);
> +	return bnge_open_core(bn);
          ^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Can a failing bnge_open_core() here leave the netdev running over a freed
datapath?

Every error exit in bnge_open_core() frees the core and tells firmware the
interface went down:

drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:bnge_open_core() {
	...
err_free_irq:
	bnge_free_irq(bn);
err_del_napi:
	bnge_del_napi(bn);
	bnge_free_core(bn);
err_if_change:
	bnge_hwrm_if_change(bd, false);
	return rc;
}

bnge_free_core() NULLs bn->vnic_info (via bnge_free_vnics()), bn->grp_info,
bn->tx_ring, bn->rx_ring and bn->bnapi.

The core does not close the device when ndo_set_features returns an error:

net/core/dev.c:__netdev_update_features() {
	...
	if (unlikely(err < 0)) {
		netdev_err(dev,
			"set_features() failed (%d); wanted %pNF, left %pNF\n",
			err, &features, &dev->features);
		return -1;
	}
	...
}

So netif_running() stays true, and the next teardown re-enters
bnge_close_core() on that freed state.  bnge_close_core() has no guard, and
bnge_shutdown_nic()->bnge_hwrm_resource_free()->bnge_clear_vnic()->
bnge_hwrm_clear_vnic_filter() starts with:

	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
	int i;

	for (i = 0; i < vnic->uc_filter_count; i++) {

which reads through a NULL bn->vnic_info.  bnge_save_ring_stats()
(bn->bnapi[i]), bnge_del_napi() (bn->bnapi[i]) and bnge_free_tx_skbs()
(&bn->tx_ring[i], then txr->tx_buf_ring, unlike
bnge_free_rx_ring_pair_bufs()/bnge_tx_disable() which do test for NULL) are
on the same path.

Two easy second-teardown triggers: ip link set ethX down -> bnge_close(),
which calls bnge_close_core() unconditionally, and simply repeating
ethtool -K, since bnge_set_features() only gates on netif_running().

bnxt_open_nic() forces the device closed in this situation:

drivers/net/ethernet/broadcom/bnxt/bnxt.c:bnxt_open_nic() {
	...
	if (rc) {
		netdev_err(bp->dev, "nic open fail (rc: %x)\n", rc);
		netif_close(bp->dev);
	}
	...
}

Should bnge_set_features() do the same on a failed re-open?

[Severity: Medium]
Related to the above: on that failure bn->priv_flags keeps the new value and
bnge_set_ring_params() has already recomputed rx_agg_ring_size /
rx_buf_size / cp_ring_size for it, while __netdev_update_features() leaves
dev->features at the old value.

If the user then repeats the same ethtool -K command, the recomputed flags
now equal bn->priv_flags, so:

	if (flags == bn->priv_flags)
		return 0;

returns success without touching hardware, and the core commits
dev->features.  Isn't that the same "dev->features no longer reflects the
actual hardware state" mismatch the commit message sets out to fix?

bnxt_set_features() restores the private flag word when the hardware step
fails:

drivers/net/ethernet/broadcom/bnxt/bnxt.c:bnxt_set_features() {
	...
			rc = bnxt_set_tpa(bp, (flags & BNXT_FLAG_TPA) ? true : false);
			if (rc)
				bp->flags = old_flags;
	...
}

[Severity: Medium]
Does this pairing produce an unbalanced FUNC_DRV_IF_CHANGE handshake?

bnge_open_core() starts with bnge_hwrm_if_change(bd, true), but the matching
DOWN notification lives only in ndo_stop:

drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:bnge_close() {
	bnge_close_core(bn);
	bnge_hwrm_shutdown_link(bn->bd);
	bnge_hwrm_if_change(bn->bd, false);
}

bnge_close_core() does not issue it, so every ethtool -K toggle on a running
interface sends a second UP with no intervening DOWN.

bnge_hwrm_if_change() also discards the response:

	if (up)
		req->flags = cpu_to_le32(FUNC_DRV_IF_CHANGE_REQ_FLAGS_UP);

	return bnge_hwrm_req_send(bd, req);

so any resource-change or hot-FW-reset indication firmware returns on that
extra UP is lost, and bnge_reserve_rings() runs immediately afterwards on
the driver's existing reservation bookkeeping.

bnxt keeps the handshake at the ndo_open/ndo_stop level only -
bnxt_reinit_features() calls bnxt_close_nic()/bnxt_open_nic() and never
bnxt_hwrm_if_change().  Would it make sense to keep bnge_hwrm_if_change()
out of the reinit path here as well?

> +}
> +
>  static const struct net_device_ops bnge_netdev_ops = {
>  	.ndo_open		= bnge_open,
>  	.ndo_stop		= bnge_close,

[ ... ]
