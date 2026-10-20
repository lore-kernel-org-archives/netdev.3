Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481136;
	b=cZnJo4LijYiVgMZ+05AdlhFeIlWqExJtCIidKm+TvLCOQ1A7P3zF4X/IqtPR9KNSFeS8
	 duraGxkeFa9kjYzH+vrhB6yLvZRtpsEGSSSYMLuf1tT9z3XHSrMNpsJupHhNSYEIHz6Yu
	 EGCSgfDT6MRs3Ypm6d1ECyCGt/Ypik4RnZnsgi/zb+r6STnIPs+csxAAYr7au8PzFdLBK
	 zaNmoLBw3RJ3LJVw5sxMwk9dCpso2U6ZKDD0t+1kg9W89oDy8cED4+74Vb3v5vS8OrA3Y
	 RD88xfupLCVz97hXuZs1Z+iC9IJyZc8kCNjxTF/XnBPEZKbXBk19sHeIgKHYFzgOfyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481136;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PPW/XTQAxsMVsOUVSjAA4Cf34VDwECwyRWXpKbl9Dcs=;
	b=vnLxiP9wvB5EgshwBy1lIf0rZxdnEsszXUX3ghjoMKsUQRWK43jPHjfrKcrIjLzT2m62
	 SSp30sugCN/ciaqvkvnXOXjp5vhFR7WoX3Tk943NDdie4KRE6dtQnrad8X7n9sPI8ohBL
	 eqCEkfqG8Ki2xPGGzcg7qTEw8jcEfL2HApZH/Tz+SGZpryjDsQ/TSglTVdjQEN6ASiUS7
	 o7N/Pck69vDtFFECup0mBGzSMUFv0a+2Agi3yujjJHzLCeOvlfkZwZDkMXpPlDhiiGir3
	 f2MHeTZ0XrDZXJcY8TK1KidNcr/gZoN+6dEYlRqsxuLtjZCRIOmTWPDtXtRCyilKTMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K79WblqD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF83606A324
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K79WblqD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF671F000CA;
	Tue, 20 Oct 2026 07:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792481136;
	bh=PPW/XTQAxsMVsOUVSjAA4Cf34VDwECwyRWXpKbl9Dcs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K79WblqDT7D6Rs93xNsWhIkNycZFp9Eaju1qnlg9XDdO0mMkVov5ZsC26/3ROjVbQ
	 eSkoH19ba26Y7N8sAObVY/ky8MEGPVFdGkTE5VvfzO57E004xWa7zB9R7+xPMTBfA+
	 yFhgDik6mxkXiPrUEtJlwf/pkLkkMNhXlBQXeMiKbly5awVecPFBdSpQmDi3jXiWW+
	 l9YvEctX8IhT7sN3/NTG1/XJt3LQgxg7JXiC88eHAODYnhHzukVEwIIhtpPP+FQfan
	 cSk1rD72Ja4znCQ/jtOQxZZbxvT702cd41Tv1rm28tQ6zdEPyxWnGt8pW7FYa6BL+z
	 HqJJAz2+I9neA==
Subject:
 Re: [PATCH net-next v4 5/8] bnxt_en: Reinit IRQ when configuring LRO/GRO/HDS
From: netdev-bot+sashiko@kernel.org
To: michael.chan@broadcom.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
Date: Tue, 20 Oct 2026 07:25:34 +0000
Message-ID: <179248113498.3135.2062167577992892555@kernel.org>
In-Reply-To: <20261016064427.496944-6-michael.chan@broadcom.com>
References: <20261016064427.496944-6-michael.chan@broadcom.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message understates the bug being fixed.

Pre-existing issues:
- [Medium] bnxt_set_ringparam() ignores BNXT_FLAG_NO_AGG_RINGS when tcp-
  data-split is enabled.
- [Medium] bnxt_set_ringparam() sets BNXT_FLAG_HDS in bp->flags before
  calling bnxt_open_nic() and does not roll it back when the open fails.

--

bnxt_en: Reinit IRQ when configuring LRO/GRO/HDS

When enabling LRO/GRO/HDS newly requires RX aggregation rings, this patch
sets irq_re_init in both bnxt_set_features() and bnxt_set_ringparam().
Firmware may grant fewer rings than requested. That shrinks the channel
count, and with it the number of IRQs and NAPIs.

> change and we must set irq_re_init to true to make that work.  Without
> this patch, when the driver is eventually shutdown, some memory for the
> unused NAPIs may never be freed properly if the rings have shrunk.

[Severity: Low]
Does "never be freed properly" cover the full impact here? The old
behavior looks like it can lead to a use-after-free and leftover IRQ
handlers, not only a leak.

When agg rings are newly required on a running device,
__bnxt_reserve_rings() can shrink the ring counts. The old, larger set of
NAPIs and IRQs stays in place:

    if (bp->flags & BNXT_FLAG_AGG_RINGS) {
        if (hwr.rx >= 2) {
            rx_rings = hwr.rx >> 1;
    ...
    bp->rx_nr_rings = rx_rings;
    bp->cp_nr_rings = hwr.cp;

On a later close with irq_re_init set, both teardown loops stop at the
new, smaller bp->cp_nr_rings:

bnxt_free_irq()
    for (i = 0; i < bp->cp_nr_rings; i++) {
        ...
            free_irq(irq->vector, bp->bnapi[i]);

bnxt_del_napi()
    for (i = 0; i < bp->cp_nr_rings; i++) {
        ...
        __netif_napi_del_locked(&bnapi->napi);

The higher-index IRQs stay requested, with dev_id pointing at
bp->bnapi[i]. The higher-index NAPIs stay linked on dev->napi_list.

bnxt_free_mem(bp, true) then calls kfree(bp->bnapi). That frees the single
allocation holding every bnxt_napi, including the ones still linked.

The next open goes through netif_napi_add()->netif_napi_dev_list_add().
That walks dev->napi_list and reads pos->napi_id from the freed entries.

Could the commit message describe this as a use-after-free of the stale
napi_struct entries plus leaked IRQs, rather than unfreed memory? The
code change itself looks correct for the LRO/GRO/HDS paths.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 622e89587e5db..5c9e770960e6d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c

[ ... ]

> @@ -876,8 +877,13 @@ static int bnxt_set_ringparam(struct net_device *dev,
>  		return -EINVAL;
>  	}
>  
> +	if (hds_config_mod &&
> +	    tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
> +	    !(bp->flags & BNXT_FLAG_AGG_RINGS))
> +		irq_re_init = true;
> +
>  	if (netif_running(dev))
> -		bnxt_close_nic(bp, false, false);
> +		bnxt_close_nic(bp, irq_re_init, false);
>  
>  	if (hds_config_mod) {
>  		if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED)

[Severity: Medium]
This is a pre-existing issue, but should bnxt_set_ringparam() also refuse
tcp-data-split when BNXT_FLAG_NO_AGG_RINGS is set?

The only check before BNXT_FLAG_HDS is set is BNXT_RX_PAGE_MODE. Every
other way of enabling an agg-ring feature honours NO_AGG_RINGS:
bnxt_set_features(), bnxt_fix_features(), bnxt_set_tpa_flags(), and the
jumbo branch of bnxt_set_ring_params().

Suppose bnxt_get_dflt_rings() set NO_AGG_RINGS at probe. Then
"tcp-data-split on" sets BNXT_FLAG_HDS while NO_AGG_RINGS stays set.

bnxt_set_ring_params() then computes agg_factor from HDS without checking
NO_AGG_RINGS:

    if (bp->flags & BNXT_FLAG_TPA || bp->flags & BNXT_FLAG_HDS)
        agg_factor = min_t(u32, 4, 65536 / BNXT_RX_PAGE_SIZE);

On reopen, if firmware grants fewer than 2 RX rings, __bnxt_reserve_rings()
hits:

        } else {
            if (netif_running(bp->dev))
                return -ENOMEM;

bnxt_open_nic() then calls netif_close(), and the interface goes down.

The new irq_re_init check keys only on
!(bp->flags & BNXT_FLAG_AGG_RINGS). The outcome is the same with or
without this patch.

> @@ -891,7 +897,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
>  	bnxt_set_ring_params(bp);
>  
>  	if (netif_running(dev)) {
> -		rc = bnxt_open_nic(bp, false, false);
> +		rc = bnxt_open_nic(bp, irq_re_init, false);
>  		if (rc)
>  			return rc;
>  	}

[Severity: Medium]
This isn't a bug introduced by this patch, but BNXT_FLAG_HDS stays set in
bp->flags when bnxt_open_nic() fails here. Should the error path restore
the previous flags?

ethnl_default_set_doit() only updates dev->cfg when the driver succeeds:

    ret = ops->set(req_info, info);
    if (ret < 0)
        goto out_ops;

    swap(dev->cfg, dev->cfg_pending);

After a failed "tcp-data-split on", dev->cfg->hds_config keeps its old
value (for example UNKNOWN), but the driver has HDS enabled.

A later "tcp-data-split auto" then sees hds_config_mod as false, so the
branch that clears BNXT_FLAG_HDS never runs. "tcp-data-split off" returns
-EINVAL.

Does this leave no normal way to turn HDS and its agg rings back off? The
only ways out seem to be setting "on" while the device is down and then
"auto", or reloading the driver.

Together with the NO_AGG_RINGS case above, the interface could stay unable
to open.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016064427.496944-1-michael.chan%40broadcom.com
