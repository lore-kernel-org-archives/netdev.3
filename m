Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1204F0538;
	Thu,  1 Oct 2026 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846021; cv=none; b=HhRpQBax209XnkNZgDot32v2tpqHaceJeol2ouVF9St7BdHmrJbe25V09Xz6UMtd+L8uBL4BuIgK+4NGXNfOp+vAqPDU8zlRJvCeVOPhiPVdXzE4XCng7O4j8zHTv/cV/9Y7sbzn0hWIhNBPTxOYtsHZchR1hBUZV6tj2Vo0Hn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846021; c=relaxed/simple;
	bh=LUS1MqanMPwRDZPaUs1q7Y4qTGN4Jg8HUwIGVCJF4Ok=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zpa1SQJ/T/RnO+aICjILEcDtnddt1TZX+QhtRDBROx/gdD7WCHszrzjh+KyArS+iB0Qw6aBNlwUsvwn2Steu7rH8pQOfpErp2cEmwUZRfK3Q+8XNxxOlk10D/qh6c7lNlKUSr3nUuD3SLdTXlkYCFSzfHeKrLV4ZqeYuA9RObQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3Zc2nK6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3Zc2nK6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AA01F00899;
	Thu,  1 Oct 2026 09:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846015;
	bh=k96p3lu4PSO/loHaVjE2TR0yZO2Dp0AphTiytdENBx0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R3Zc2nK6e6Bh9sKbispEJ0QIa/OXbjVpYY+NqYK9UswiRFN9GfnSEAaDsDhaeuvge
	 CgzBZ3Yhe7abeobj0e0MuuBkpQSQH4A6ao2cTAVhvXhJvl1haLmAK1HPqqBt0Xoj/e
	 lPQhX+IoUQyw9DZlZyFP4RrJgy1pNtPYiAf3mAy3Uoj6WgwtGLVqjGYq9Ppicl5bG7
	 KQLFOYYLby8VDpMrwLnmyfKmni1o+my+9gvCRZUCcnEfLKa+9WUq4lvXFjceWtWVXq
	 rMcnnWr7WsFPfmQ1bLYiYky6feSOr/aRcJ6hj9qfmf4LDcHGcVQlMhom71hBxa2XTJ
	 IG3uvhW+Q+0jA==
Subject:
 Re: [net-next, v4 03/10] bnge: add helper functions for multi RSS contexts
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Thu, 01 Oct 2026 09:13:34 +0000
Message-ID: <179084601433.434549.5967913046506071040@kernel.org>
In-Reply-To: <20260928061307.1172344-4-vikas.gupta@broadcom.com>
References: <20260928061307.1172344-4-vikas.gupta@broadcom.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] bnge_get_total_vnics()
  (drivers/net/ethernet/broadcom/bnge/bnge_resc.c) adds bn->num_rss_ctx…
- [Medium] At this commit, bnge_modify_rss() writes a user context's
  indirection table into ethtool_rxfh_context_indir(ctx), but…
- [Medium] For a user context, bnge_modify_rss() copies tbl_size entries
  and then zero-pads up to bd->rss_indir_tbl_entries (512) into…

--

bnge: add helper functions for multi RSS contexts

This commit adds helpers to create, modify, restore and delete
user-defined RSS contexts in the bnge driver, with one VNIC per context.
It also adds a num_rss_ctx counter to struct bnge_net and includes it in
the VNIC count that bnge_get_total_vnics() returns.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> index c7024e75f9257..e0744e59c6aea 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> @@ -209,8 +209,16 @@ static u16 bnge_get_total_rss_ctxs(struct bnge_dev *bd,
>  
>  static u16 bnge_get_total_vnics(struct bnge_dev *bd)
>  {
> -	if (bnge_is_arfs_cap(bd))
> -		return 2;
> +	if (bnge_is_arfs_cap(bd)) {
> +		u16 vnics = 2;
> +
> +		if (bd->netdev) {
> +			struct bnge_net *bn = netdev_priv(bd->netdev);
> +
> +			vnics += bn->num_rss_ctx;
> +		}
> +		return vnics;
> +	}
>  
>  	return 1;
>  }

[Severity: Medium]
bn->num_rss_ctx is only counted while bnge_is_arfs_cap(bd) is true. Can
that flag be cleared while user RSS contexts still exist?

bnge_init_chip() clears it when the aRFS VNIC allocation fails, and it
does not check netdev->ethtool->rss_ctx first:

drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:bnge_init_chip() {
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

After this, bnge_get_total_vnics() returns 1. bnge_need_reserve_rings()
and bnge_reserve_rings() then ask firmware for one VNIC and one VNIC's
worth of RSS contexts. Each remaining user context still needs its own
VNIC.

On the next bnge_open_core(), bnge_reserve_rings() runs before
bnge_hwrm_realloc_rss_ctx_vnic(). Could the context VNIC allocations
fail at that point? Each context would then be torn down through
bnge_del_one_rss_ctx() and ethtool_rxfh_context_lost(). I haven't
confirmed that firmware enforces the lower reservation on later VNIC
allocs, so this step is partly speculative.

Also, bnge_init_chip() clears BNGE_NET_EN_NTUPLE directly. That bypasses
the -EBUSY check that later patches in the series add to
bnge_set_features(). That check stops NTUPLE from being disabled while
bn->num_rss_ctx is non-zero.

The capability is only set again in bnge_net_init_dflt_config(). While
it is clear, bnge_fix_features() strips NETIF_F_NTUPLE. So the remaining
contexts can't be modified, because bnge_rxfh_context_check() requires
BNGE_NET_EN_NTUPLE. Their VNICs also drop out of resource accounting.
This is still the case at the end of the series.

Should num_rss_ctx be counted whether or not aRFS is available? Or
should the aRFS fallback in bnge_init_chip() take existing contexts into
account?

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
> index d98a6196c859c..a44971a7c74d3 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
> @@ -129,3 +129,116 @@ int bnge_alloc_rfs_vnic(struct bnge_net *bn)
>  	vnic = &bn->vnic_info[BNGE_VNIC_NTUPLE];
>  	return bnge_alloc_and_setup_vnic(bn, vnic, bn->bd->rx_nr_rings);
>  }
> +
> +void bnge_modify_rss(struct bnge_net *bn, struct ethtool_rxfh_context *ctx,
> +		     struct bnge_rss_ctx *rss_ctx,
> +		     const struct ethtool_rxfh_param *rxfh)
> +{

[ ... ]

> +	if (rxfh->indir) {
> +		u32 i, pad, tbl_size = bnge_get_rxfh_indir_size(bd);
> +		u32 *indir_tbl = bd->rss_indir_tbl;
> +
> +		if (rss_ctx)
> +			indir_tbl = ethtool_rxfh_context_indir(ctx);

[Severity: Medium]
At this commit, is anything reading the per-context table written here?

For non-NTUPLE VNICs, bnge_fill_hw_rss_tbl() only reads the default
table:

    j = bd->rss_indir_tbl[i];

struct bnge_vnic_info also has no link back to the ctx. Used as they are
in this patch, wouldn't bnge_hwrm_realloc_rss_ctx_vnic()->bnge_setup_vnic()
program the default table into a context VNIC?

The helpers have no callers yet. The next patch, "bnge: add ethtool
support to manage RSS contexts", adds BNGE_VNIC_RSSCTX_FLAG and a
vnic->rss_ctx back-pointer. It also changes bnge_fill_hw_rss_tbl() to
read ethtool_rxfh_context_indir(vnic->rss_ctx). Could the reader side
move into this patch so these helpers are consistent on their own?

> +		for (i = 0; i < tbl_size; i++)
> +			indir_tbl[i] = rxfh->indir[i];
> +		pad = bd->rss_indir_tbl_entries - tbl_size;
> +		if (pad)
> +			memset(&indir_tbl[i], 0, pad * sizeof(*indir_tbl));

[Severity: Medium]
Can this memset() overflow the ctx indirection table when rss_ctx is
non-NULL?

The pad runs up to bd->rss_indir_tbl_entries, which
bnge_alloc_rss_indir_tbl() sets to BNGE_MAX_RSS_TABLE_ENTRIES. That is
the device-wide capacity, not the size of the ctx allocation.

ethtool_rxfh_ctx_alloc() sizes the ctx indirection area as
max(indir_size, ops->rxfh_indir_space). bnge doesn't set rxfh_indir_space
at this commit. The pad would then write past the indirection table,
into the key area and beyond the end of the kzalloc'd ctx.

This can't be reached yet because bnge_modify_rss() has no caller. Later
in the series the pad is guarded with "if (pad && !rss_ctx)", and
bnge_ethtool_ops sets .rxfh_indir_space = BNGE_MAX_RSS_TABLE_ENTRIES.
Could those changes be folded into this patch?

> +	}
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928061307.1172344-1-vikas.gupta%40broadcom.com
