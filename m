Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD864F93BC;
	Thu,  1 Oct 2026 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846027; cv=none; b=TpQreE/NZHVd1DCM+Q9wJ/vA5NMm22BnOWuKaInTvBPff7XboOGcqvGGMCKOAdfexktcoKocF5z9VcO7gvC4bs/kOpnaqLxBAn55L1lvMLPKQaxznVChCwVSk5I6XJJ42g0cjQFYqQyreqmpTryaSGbA1M+OVqcI2JiEpnZnO90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846027; c=relaxed/simple;
	bh=iJb0/GiPx2fQ/V0xn3jYOvBuDj8m27Zl4idlr0BwzLo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WxQb/m29TpfBVV3/2PrrndJ/Bbpqzu3S3yDjTdXunDTOa6v11cr7/+zc/6f5eAN2UkCQXIQVlz6ErpYLEoHlu9XayEaUaadu+sn408ZgMRGf0zrHcvSNCKrHwqOJaorNPgpdgXnjeGp0uWI540yCg2pj9N3TAuyu/A9aDPpu4qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIZ8v3Gv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIZ8v3Gv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010F31F00899;
	Thu,  1 Oct 2026 09:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846023;
	bh=QiTD8jv05CYWp7iTpZxDECEVOMautat1mbtbrx6mmgg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HIZ8v3GvuqRT37gnKdEtCeEq5td0bdOqttDwZG9bSBWNtMmLCKBcKKtplwSnXKG48
	 dKHe0BtbweDwoY4++Avt4oSLMUhkiKzuO1vy1fysuE28ssTqVIFwhGDg+tHKm8uLH2
	 k9OIvNz9FOEi90BL3XJwBFmXXJ12CZMwIrHM4vEDtv2FHKtes9Ld+tu9LHKWkH9pZe
	 cb3abc366kHlG+P5qO1DUyQXCqaXv/af3/14/G2jlUcEo212PFewHuTW+8JQX1AGbL
	 4S+ZA1UXe1h0Wxt5hwdb77P0/+BFDG+sJX9u3cRJvobNv+hCBmEAhgZskGKrSpAQTo
	 vVVdmP0nvRSKA==
Subject: Re: [net-next, v4 09/10] bnge: add aRFS flow steering ndo support
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Thu, 01 Oct 2026 09:13:42 +0000
Message-ID: <179084602255.434549.2468256994128303043@kernel.org>
In-Reply-To: <20260928061307.1172344-10-vikas.gupta@broadcom.com>
References: <20260928061307.1172344-10-vikas.gupta@broadcom.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The expire loop in bnge_cfg_ntp_filters()
  (bnge_filter.c:680-681) ignores the return value of…
- [Low] Baseline decision: false.
- [Low] The ethtool rxnfc GET paths disagree about aRFS filters.
- [Low] In bnge_rx_flow_steer(), when an NTUPLE filter for the same tuple
  already exists, the callback returns its sw_id without updating…

--

bnge: add aRFS flow steering ndo support

This adds bnge_rx_flow_steer() as the ndo_rx_flow_steer callback. It
builds an NTUPLE filter from the dissected flow keys and inserts it into
the NTUPLE hash table. Firmware programming and aging are deferred to
bnge_cfg_ntp_filters(), which runs from sp_task.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> index 8e9cfbad98e04..08db761e4ca60 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> @@ -1189,7 +1189,7 @@ static u32 bnge_get_all_fltr_ids_rcu(struct bnge_net *bn,
>  
>  		head = &tbl[i];
>  		hlist_for_each_entry_rcu(fltr, head, hlist) {
> -			if (!fltr->flags ||
> +			if (!bnge_is_usr_fltr(fltr) ||
>  			    test_bit(BNGE_FLTR_FW_DELETED, &fltr->state))
>  				continue;
>  			ids[j++] = fltr->sw_id + offset;

[Severity: Low]
With this change, GRXCLSRLALL uses bnge_is_usr_fltr() to skip aRFS
filters. Does bnge_get_one_fltr_rcu() need the same change? It still uses
the old test:

bnge_get_one_fltr_rcu() {
    ...
		hlist_for_each_entry_rcu(fltr, head, hlist) {
			if (fltr->flags && fltr->sw_id + offset == id)
				return fltr;
		}
    ...
}

bnge_insert_ntp_filter() always sets BNGE_ACT_RING_DST on aRFS filters,
so their flags are never zero. A GRXCLSRULE query for location
BNGE_MAX_L2_FLTRS + sw_id (for example ethtool -n <dev> rule <loc>) would
then report an aRFS filter as a configured classification rule, with its
5-tuple and ring_cookie.

That same filter is missing from GRXCLSRLALL and is not counted in
GRXCLSRLCNT (bn->user_fltr_count). bnge_srxclsrldel() also refuses to
delete it:

	if (!(fltr->base.flags & BNGE_ACT_NO_AGING)) {
		rcu_read_unlock();
		return -EINVAL;
	}

This still seems to be present at the end of the series.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> index 764c967c64572..17a837fea79d7 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c

[ ... ]

> @@ -637,3 +637,48 @@ void bnge_clear_usr_fltrs(struct bnge_net *bn)
>  		}
>  	}
>  }
> +
> +void bnge_cfg_ntp_filters(struct bnge_net *bn)
> +{

[ ... ]

> +	list_for_each_entry_safe(fltr, tmp, &expire_list, base.list_node) {
> +		list_del_init(&fltr->base.list_node);
> +		bnge_hwrm_cfa_ntuple_filter_free(bn->bd, fltr);
> +		bnge_del_ntp_filter_rcu(bn, fltr);

[Severity: Medium]
Should the return value of bnge_hwrm_cfa_ntuple_filter_free() be
checked here?

It can fail before anything reaches firmware. For example,
bnge_hwrm_req_init()->bnge_hwrm_req_create() returns -ENOMEM when
dma_pool_alloc() fails. bnge_hwrm_req_send() can also return a firmware
error or a timeout.

In either case the firmware keeps the CFA ntuple rule and keeps steering
the tuple to the old ring. Meanwhile bnge_del_ntp_filter_rcu() frees the
only copy of base.filter_id and releases the sw_id bit.

Does this leak the firmware CFA entry until the owning L2 filter or VNIC
is torn down? If the flow is steered again, a second firmware rule for
the same tuple would be allocated. bnxt has the same pattern in its
aging path.

> +	}
> +#endif
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index 19ec36b08765c..de7818d2c2af2 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c

[ ... ]

> @@ -3176,6 +3185,121 @@ static int bnge_set_features(struct net_device *dev, netdev_features_t features)

[ ... ]

> +static int bnge_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
> +			      u16 rxq_index, u32 flow_id)
> +{

[ ... ]

> +	idx = bnge_get_ntp_filter_idx(bn, fkeys, skb);
> +	rcu_read_lock();
> +	fltr = bnge_lookup_ntp_filter_from_idx(bn, new_fltr, idx);
> +	/* Filter already exists; return its id.  A stale filter (queue
> +	 * changed) is freed later via rps_may_expire_flow() and recreated.
> +	 */
> +	if (fltr) {
> +		rc = fltr->base.sw_id;
> +		rcu_read_unlock();
> +		goto err_free;
> +	}

[Severity: Low]
Is the "freed later via rps_may_expire_flow() and recreated" part of
this comment always true?

bnge_fltr_match() does not compare rxq. Suppose flow F is steered to
queue B and then moves to a CPU that maps to queue C. set_rps_cpu() calls
this function with rxq_index C and gets F's sw_id back. F's base.rxq and
flow_id are left unchanged, and nothing is reprogrammed.

The core then records F in C's rps_dev_flow entry and clears it from
B's entry, while the hardware still delivers the flow to B.

On a later pass, bnge_cfg_ntp_filters() calls rps_may_expire_flow() with
the stale rxq B. It sees that B's entry no longer holds F and frees the
rule. Packets then arrive on some RSS queue X.

When set_rps_cpu() runs for X, C's entry still holds F and can still
look active:

net/core/dev.c:set_rps_cpu() {
    ...
	if (rps_flow_is_active(tmp_rflow, rps_tag_to_log(q_tag_ptr), tmp_cpu)) {
		if (hash != READ_ONCE(tmp_rflow->hash) ||
		    next_cpu == tmp_cpu)
			goto out;
	}
    ...
}

In that case ndo_rx_flow_steer is not called and X's entry gets
cpu = next_cpu. After that, get_rps_cpu() stops calling set_rps_cpu()
because tcpu == next_cpu.

Can the flow then stay without a hardware aRFS rule until the application
moves CPU again? RPS still steers it in software, so the impact is on
performance. It also depends on timing, namely how far the target CPU's
input_queue_head has advanced. bnxt_rx_flow_steer() has the same
existing-filter branch.

Should this branch handle a changed rxq_index instead of returning the
old sw_id unchanged?

[ ... ]

> @@ -3185,6 +3309,9 @@ static const struct net_device_ops bnge_netdev_ops = {
>  	.ndo_features_check	= bnge_features_check,
>  	.ndo_fix_features	= bnge_fix_features,
>  	.ndo_set_features	= bnge_set_features,
> +#ifdef CONFIG_RFS_ACCEL
> +	.ndo_rx_flow_steer	= bnge_rx_flow_steer,
> +#endif
>  };

[Severity: Low]
Can bnge_rx_flow_steer() actually be called at this point in the
series? set_rps_cpu() in net/core/dev.c skips the callback when there is
no rx_cpu_rmap:

	if (!skb_rx_queue_recorded(skb) || !dev->rx_cpu_rmap ||
	    !(dev->features & NETIF_F_NTUPLE))
		goto out;

bnge does not set dev->rx_cpu_rmap yet, so the new aRFS code does not
run at this commit.

A later patch in this series, "bnge: add cpu_rmap support for IRQ
affinity", fixes this. It adds alloc_irq_cpu_rmap(bd->rx_nr_rings), calls
irq_cpu_rmap_add() in bnge_request_irq() for NAPIs that have an rx_ring,
and frees the map on teardown. So the callback is reachable by the end of
the series, and nothing breaks at this commit.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928061307.1172344-1-vikas.gupta%40broadcom.com
