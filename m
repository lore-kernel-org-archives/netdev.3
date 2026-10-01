Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C26C4EE877;
	Thu,  1 Oct 2026 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846022; cv=none; b=m7CWmZsSasp17Lm9i/VhNCtlW/SZotDtkGNRoJhixaaKAr6waPtbsVyPrd/RO38QlcnbrkZENxuFdNAX6LU+HzME2wMLx6TcZ8TQvWkIVvwEYhn/g6GgROGMhjm9msIMnU8EygXjIfe5pyR1nOcL8ebhBK+mJvEIzLe9yHeoh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846022; c=relaxed/simple;
	bh=uu7zgoJX7qRQk8D9PCJmTRA6KlTAKv33xSNF5oKRgoM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LuLKSPQCcn8i5MMV3kGYsOC5UfAmjF7GFz0xQ+RprgZTMunhQw//ny7/xn2H2TR1CtLZRtn/fST+8lR9woWd4gt2Aix/xUIThOIiMJ11Y1j13iwQwuVW4aVCITdVQHZSrQfGlEf3LYKhTTkyswEYCBaZXldaZs/ayW1MqigVEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIjuy9BD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIjuy9BD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5911E1F0089A;
	Thu,  1 Oct 2026 09:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846018;
	bh=czgUX850NsmUzn+FwMs4LYpA8kmRhyL15bRDxtty1Yg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LIjuy9BDRdrRg2dIn1dumd/M3AlbuR+Odl0uW8g3okCgqhNPxJ+UN9S3MNhbdQqik
	 h7O6poCYljBNk5SAz1jLj10loszHkClWlTE/BNtJOTR9UOpAbYdvye+edYugmgGAOp
	 y/jIB3Q64FvG6Wq38hmzxmhXIG9CWiKHTQ+mRHJBIuI2EZrI4Kfze7XAgOe5ZtajAX
	 95poQgh0ravOfW1fyx4FvvZwxtwJZXoiuMyk7rp/OArhZYFgGBmuF3CYogxxsIARNe
	 tBdHhOKz0cYqM4IuZQ7rUgt0+T+sf+W4NFxckXioP1tg3y3POJ1jyp8uCNvAhPhhD3
	 dW6JHUu6vAIsw==
Subject:
 Re: [net-next, v4 05/10] bnge: add ethtool support to manage RSS contexts
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Thu, 01 Oct 2026 09:13:36 +0000
Message-ID: <179084601694.434549.444699842806684896@kernel.org>
In-Reply-To: <20260928061307.1172344-6-vikas.gupta@broadcom.com>
References: <20260928061307.1172344-6-vikas.gupta@broadcom.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When bnge_reserve_rings() gets fewer usable RX rings at open
  (it logs 'RX rings resv reduced to %d than earlier %d requested'), it…
- [Medium] RSS contexts survive a forced NTUPLE/aRFS disable in
  bnge_init_chip(), which breaks the rule this patch adds in…
- [Medium] In bnge_reserve_rings(), marking the default table lost and
  resetting it use different conditions.
- [Medium] When bnge_hwrm_vnic_rss_cfg() fails,
  bnge_modify_rxfh_context() restores only the software state: the old…
- [Low] The commit message says only that ethtool callbacks for RSS
  contexts are added.

--

bnge: add ethtool support to manage RSS contexts

This commit adds the create/modify/remove_rxfh_context ethtool callbacks
to bnge. Each RSS context gets its own VNIC with its own indirection
table and hash key. Contexts are torn down on close and rebuilt on open.

> Introduce ethtool callbacks to manage RSS contexts.

[Severity: Low]
The patch also makes several behaviour changes that the commit message
does not mention. Some of them affect the default (context 0) table:

- When resv_rx_rings changes, bnge_reserve_rings() used to always reset
  the default indirection table. It now keeps a user-configured table,
  or calls ethtool_rxfh_indir_lost(). That call logs "device error, RSS
  indirection table lost" and sends ETHTOOL_MSG_RSS_NTF.

- bnge_fill_hw_rss_tbl() now silently replaces any out-of-range ring
  index with ethtool_rxfh_indir_default(). This applies to every VNIC,
  including the default one.

- bnge_set_features() now returns -EBUSY if NTUPLE is cleared while RSS
  contexts exist.

- Contexts are torn down on close and rebuilt on open. If the rebuild
  fails, the context is destroyed.

Could these changes be described in the commit message, or split into
separate patches?

The changes to bnge_del_one_rss_ctx() (rsscos_nr_ctxs accounting) and
to bnge_hwrm_realloc_rss_ctx_vnic() (taking rss_lock) only touch helpers
that had no callers before this patch. So they don't fix reachable bugs
in the earlier patches.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> index 6fbda4fc1a0c4..85dbe64d4c129 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c

[ ... ]

> +static int bnge_modify_rxfh_context(struct net_device *dev,
> +				    struct ethtool_rxfh_context *ctx,
> +				    const struct ethtool_rxfh_param *rxfh,
> +				    struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	rss_ctx = ethtool_rxfh_context_priv(ctx);
> +	tbl_size = bnge_get_rxfh_indir_size(bn->bd);
> +
> +	/* Snapshot the software state so it can be restored if the hardware
> +	 * update fails, keeping the reported config consistent with the
> +	 * hardware.
> +	 */

[ ... ]

> +	bnge_modify_rss(bn, ctx, rss_ctx, rxfh);
> +
> +	rc = bnge_hwrm_vnic_rss_cfg(bn, &rss_ctx->vnic);
> +	if (rc) {
> +		if (rxfh->key)
> +			memcpy(rss_ctx->vnic.rss_hash_key, old_key,
> +			       HW_HASH_KEY_SIZE);
> +		if (rxfh->indir)
> +			memcpy(ethtool_rxfh_context_indir(ctx), old_indir,
> +			       tbl_size * sizeof(*old_indir));
> +	}

[Severity: Medium]
Does this rollback really keep the reported config consistent with the
hardware, as the comment above says?

bnge_hwrm_vnic_rss_cfg() is not atomic. First, bnge_hwrm_vnic_set_rss()
uses bnge_fill_hw_rss_tbl() to write the new ring IDs into
vnic->rss_table. It then sends one HWRM_VNIC_RSS_CFG per 64-entry
segment and stops at the first failure:

bnge_hwrm_vnic_set_rss() {
    ...
	for (i = 0; i < nr_ctxs; ring_tbl_map += BNGE_RSS_TABLE_SIZE, i++) {
		...
		rc = bnge_hwrm_req_send(bd, req);
		if (rc)
			goto exit;
	}
    ...
}

After that, bnge_hwrm_vnic_rss_cfg() sends a separate HWRM_VNIC_CFG.

A later segment can fail, or HWRM_VNIC_CFG can fail after all the
RSS_CFG commands succeeded. In either case the device is already using
the new (or partly new) key and table.

Only the software copies are restored here. So "ethtool -x ... context
N" would report the old config, while the DMA buffer vnic->rss_table
still holds the new ring IDs.

Should the error path program the restored state back into the
hardware?

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index ef5d13337e60b..ac77ba813f01c 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> @@ -2784,6 +2784,8 @@ static int bnge_open_core(struct bnge_net *bn)
>  	/* Poll link status and check for SFP+ module status */
>  	bnge_get_port_module_status(bn);
>  
> +	bnge_hwrm_realloc_rss_ctx_vnic(bn);
> +
>  	return 0;

[Severity: Medium]
What happens to existing RSS contexts if bnge_init_chip() force-disables
NTUPLE on reopen?

Contexts survive close, because bnge_clear_rss_ctxs() calls
bnge_del_one_rss_ctx(..., false), so num_rss_ctx stays non-zero.

On reopen, bnge_open_core()->bnge_init_nic()->bnge_init_chip() calls
bnge_alloc_rfs_vnic(). If that fails, the fallback clears the flags
without checking num_rss_ctx:

bnge_init_chip() {
    ...
	if ((bn->priv_flags & BNGE_NET_EN_NTUPLE) && bnge_is_arfs_cap(bd)) {
		rc = bnge_alloc_rfs_vnic(bn);
		if (rc) {
			...
			bd->flags &= ~BNGE_EN_ARFS_CAP;
			bn->priv_flags &= ~BNGE_NET_EN_NTUPLE;
			bn->netdev->features &= ~NETIF_F_NTUPLE;
		}
	}
    ...
}

bnge_hwrm_realloc_rss_ctx_vnic() is then called unconditionally here and
re-creates every context VNIC. This breaks the rule this patch adds to
bnge_set_features(): NTUPLE can't be turned off while num_rss_ctx is
non-zero.

After that:

- bnge_modify_rxfh_context() always fails in bnge_rxfh_context_check()
  with "Enable ntuple filtering before adding RSS contexts".

- bnge_fix_features() strips NETIF_F_NTUPLE whenever
  !bnge_is_arfs_cap(), so NTUPLE can't be turned back on.

- bnge_get_total_vnics() returns 1 and no longer counts num_rss_ctx.
  Later ring reservations therefore don't cover the VNIC and RSS COS
  resources of the live contexts. A later realloc can then fail and
  destroy the contexts via ethtool_rxfh_context_lost().

By the end of the series, bnge_srxclsrlins() also requires NTUPLE
(-EPERM), so no filter can target these contexts. Only
bnge_remove_rxfh_context() still works on them.

Should the contexts be dropped when this fallback runs, or should the
fallback be skipped when contexts exist?

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> index e0744e59c6aea..8f1b0f42773a2 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> @@ -229,6 +229,19 @@ u32 bnge_get_rxfh_indir_size(struct bnge_dev *bd)
>  	       BNGE_RSS_TABLE_ENTRIES;
>  }
>  
> +static u16 bnge_get_max_rss_ring(struct bnge_dev *bd)
> +{
> +	u32 i, tbl_size, max_ring = 0;
> +
> +	if (!bd->rss_indir_tbl)
> +		return 0;
> +
> +	tbl_size = bnge_get_rxfh_indir_size(bd);
> +	for (i = 0; i < tbl_size; i++)
> +		max_ring = max_t(u32, max_ring, bd->rss_indir_tbl[i]);
> +	return max_ring;
> +}

[ ... ]

> @@ -344,9 +357,15 @@ int bnge_reserve_rings(struct bnge_dev *bd)
>  	hwr.nq = sh ? max_t(u16, tx_cp, rx_rings) : tx_cp + rx_rings;
>  	bd->tx_nr_rings = hwr.tx;
>  
> -	if (rx_rings != bd->rx_nr_rings)
> +	if (rx_rings != bd->rx_nr_rings) {
>  		dev_warn(bd->dev, "RX rings resv reduced to %d than earlier %d requested\n",
>  			 rx_rings, bd->rx_nr_rings);
> +		if (bd->netdev && netif_is_rxfh_configured(bd->netdev) &&
> +		    (bnge_cal_nr_rss_ctxs(bd->rx_nr_rings) !=
> +		     bnge_cal_nr_rss_ctxs(rx_rings) ||
> +		     bnge_get_max_rss_ring(bd) >= rx_rings))
> +			ethtool_rxfh_indir_lost(bd->netdev);
> +	}

[Severity: Medium]
This only checks the default table. What about the non-default RSS
contexts?

bnge_get_max_rss_ring() scans only bd->rss_indir_tbl, and
ethtool_rxfh_indir_lost() only affects context 0.

The other contexts survive close/open and are programmed again through
this chain:

bnge_open_core()->bnge_hwrm_realloc_rss_ctx_vnic()->bnge_setup_vnic()->
bnge_hwrm_vnic_rss_cfg()->bnge_hwrm_vnic_set_rss()->bnge_fill_hw_rss_tbl()

At the end of that chain, bnge_fill_hw_rss_tbl() reads
ethtool_rxfh_context_indir(vnic->rss_ctx)[i].

The new clamp in bnge_fill_hw_rss_tbl() fixes stale entries only in the
hardware DMA table. Also, tbl_size there follows the new ring count, not
ctx->indir_size.

If the number of segments drops (for example 72 -> 60 rings, so 128 ->
64 entries), only the first part of the stored context table reaches the
hardware.

bnge_modify_rxfh_context() has the same issue: it snapshots and restores
bnge_get_rxfh_indir_size() entries, not ctx->indir_size entries.

Programming succeeds, so ethtool_rxfh_context_lost() is never called.
The driver also never uses ethtool_rxfh_ctxs_can_resize() or
ethtool_rxfh_ctxs_resize().

Wouldn't the hardware then send the context's flows to queues the user
never configured? Meanwhile ETHTOOL_MSG_RSS_GET would keep reporting the
old table and indir_size, and userspace would get no notification.

>  	bd->rx_nr_rings = rx_rings;
>  	bd->nq_nr_rings = hwr.nq;
> @@ -354,8 +373,9 @@ int bnge_reserve_rings(struct bnge_dev *bd)
>  	if (!bnge_rings_ok(&hwr))
>  		return -ENOMEM;
>  
> -	if (old_rx_rings != bd->hw_resc.resv_rx_rings)
> -		bnge_set_dflt_rss_indir_tbl(bd);
> +	if (old_rx_rings != bd->hw_resc.resv_rx_rings &&
> +	    (!bd->netdev || !netif_is_rxfh_configured(bd->netdev)))
> +		bnge_set_dflt_rss_indir_tbl(bd, NULL);

[Severity: Medium]
Can the default table end up marked lost but never reset?

The ethtool_rxfh_indir_lost() call above depends on the usable ring
count (rx_rings != bd->rx_nr_rings). This reset depends on the reserved
count (old_rx_rings != bd->hw_resc.resv_rx_rings).

The usable count can shrink while resv_rx_rings stays the same. One way
is these two steps earlier in bnge_reserve_rings():

	rx_rings = min_t(u16, rx_rings, hwr.grp);
	...
	rc = bnge_adjust_rings(bd, &rx_rings, &hwr.tx, hwr.nq, sh);

Another way is when aggregation doubles the requested hwr.rx and
firmware grants the same number of rings as before. For example: the
old reservation is 8 without agg, the new request is 16 with agg, and
firmware grants 8, leaving 4 usable.

In that case ethtool_rxfh_indir_lost() clears rss_indir_user_size. But
resv_rx_rings didn't change, so bd->rss_indir_tbl keeps the stale user
entries, which may point at queues >= the new rx_nr_rings.

get_rxfh would then report a non-default table with nonexistent queues,
while the core treats the table as unconfigured. At the same time,
bnge_fill_hw_rss_tbl() programs different, clamped values.

Should the default table also be reset whenever
ethtool_rxfh_indir_lost() is called here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928061307.1172344-1-vikas.gupta%40broadcom.com
