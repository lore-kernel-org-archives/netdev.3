Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327557;
	b=GZfSyQAu1+ngE2OrWrbloVFtpYk9uo5XMOBMKR9L+rvgmqENDYKzeKKpfxlX0WNuA3EN
	 CWecJ4j4tEgCOfIimF/dRB3zAWC4Q1ngw9s336yN4bakAxleiA/5QIb7AN2mthy5El7K9
	 TfXK4ctFckdUi7LTl3+O2QK2P3gPlI007qJzz3o9Wq/Ai5K0G0MoP1xtlec7mOEEZDfYN
	 3YmvQcWud2meDqbm8fUWg5vS4SsBbAxisfvYCE1BvgApu0A7XTahKdzhS12tJ3o0KLbTN
	 tew53enJolzwrYi1OJvH2nh5Piva5MsLxtPnywq/FjPTfFldZdHZdMSZFYN1ddnIbNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327557;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=S/FNP2jA2lkmfFTh4ZT5fF7/B86/S/grLPiT9kWjYfM=;
	b=fdBs7+0NTKTf88JFZl51+9aMX0GRRGXBc5NAZEci+2AOcs81EuH7hKlVueR86I3Qc9hI
	 hZBr0s/DVXNjEOKV8QMGZYpUzT6Ls7EXLKI0ewT5inL0N0w2t9jxpNI4qEn3o3IP5lvPv
	 jqxjbIDkIABNqMsId6ZU06VrDTnc/Eqm1ZbfrDSCdVFLbSeFXI3vXRSgVdIWloeNhBHoF
	 2x78PcjJ3X3kj9TOyIuE8yx2WVXllMgj7V+k6azWcZ5iH0eZkHx0yT/z59U730gcr6rsy
	 qHkiXVJIY9X9ynVmerYYR1U5/ko3dT4lxqHdIDxOZ8vJAPfc1qBcoRbEEeRWyS6giOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JlVbI+yF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEBE606A323;
	Tue, 10 Nov 2026 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JlVbI+yF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9E11F0089F;
	Tue, 10 Nov 2026 16:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327556;
	bh=S/FNP2jA2lkmfFTh4ZT5fF7/B86/S/grLPiT9kWjYfM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JlVbI+yFIw2MsfBrp116OgYibXeiADZrIx8Xl02Sr3rVW879BYSadleiwHmvxPEvL
	 GkgmN+Xp7UR4OYM8ym8rmjBeYrbWXYoq3lJgOPIdXvd92Z9uXV81DoGtZNZVVqeDJp
	 xFXtFtMsUcKtSJOMpJMM3IxqTVDm0C3Ai+3q0dNDuAGQQtTLxoxJDm2Mp8s8IFdffg
	 szNdp3KALr9GgBzF3sK53MzPS7BQEZhbXUvcVfMTu5TQqlPCMb52a+1lCAwcO9MDZC
	 IPyoDttJnMe1RNs6gyu6hKb9Pv8wHyyC61APWRPrXXnW+cL3lLkpnlTJ+ZMm9rJ4cJ
	 fyz/AxwMhGJpQ==
Subject: Re: [PATCH net-next v6 05/10] bnge: add ethtool support to manage RSS
 contexts
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Tue, 10 Nov 2026 16:19:15 +0000
Message-ID: <179432755520.994134.14070204152645172298@kernel.org>
In-Reply-To: <20261106093524.838341-6-vikas.gupta@broadcom.com>
References: <20261106093524.838341-6-vikas.gupta@broadcom.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When the RX ring count shrinks so that bnge_cal_nr_rss_ctxs()
  changes, bnge_check_rss_ctxs_lost()…
- [Medium] bnge_refill_dflt_rss_ctxs() calls ethtool_rxfh_ctxs_resize()
  when any context's indir_size differs from the new table size.
- [Medium] In bnge_reserve_rings()
  (drivers/net/ethernet/broadcom/bnge/bnge_resc.c) the work is split by…
- [Low] bnge_init_vnic_mem() sets vnic->vnic_id = BNGE_VNIC_ID_INVALID
  (0xffffffff, a u32) for every RSS-context VNIC.

--

bnge: add ethtool support to manage RSS contexts

This adds ethtool create/modify/remove callbacks for RSS contexts. Each
context gets a dedicated VNIC with its own indirection table and hash key.
It also changes how bnge_reserve_rings() handles the default and
per-context indirection tables when the RX ring count changes.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> index 55ba58c7b9b05..651939a95b1d5 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c

[ ... ]

> @@ -331,9 +364,17 @@ int bnge_reserve_rings(struct bnge_dev *bd)
>  	hwr.nq = sh ? max_t(u16, tx_cp, rx_rings) : tx_cp + rx_rings;
>  	bd->tx_nr_rings = hwr.tx;
>  
> -	if (rx_rings != bd->rx_nr_rings)
> +	rx_changed = rx_rings != bd->rx_nr_rings;
> +	if (rx_changed) {
>  		dev_warn(bd->dev, "RX rings resv reduced to %d than earlier %d requested\n",
>  			 rx_rings, bd->rx_nr_rings);
> +		indir_lost = bd->netdev &&
> +			     netif_is_rxfh_configured(bd->netdev) &&
> +			     (bnge_cal_nr_rss_ctxs(bd->rx_nr_rings) !=
> +			      bnge_cal_nr_rss_ctxs(rx_rings) ||
> +			      bnge_get_max_rss_ring(bd) >= rx_rings);
> +		bnge_check_rss_ctxs_lost(bd, rx_rings);
> +	}
>  
>  	bd->rx_nr_rings = rx_rings;
>  	bd->nq_nr_rings = hwr.nq;

[ ... ]

> @@ -345,8 +386,18 @@ int bnge_reserve_rings(struct bnge_dev *bd)
>  	if (!bnge_rings_ok(&hwr))
>  		return -ENOMEM;
>  
> -	if (old_rx_rings != bd->hw_resc.resv_rx_rings)
> -		bnge_set_dflt_rss_indir_tbl(bd);
> +	if (old_rx_rings != bd->hw_resc.resv_rx_rings || rx_changed) {
> +		if (!bd->netdev || indir_lost ||
> +		    !netif_is_rxfh_configured(bd->netdev))
> +			bnge_set_dflt_rss_indir_tbl(bd, NULL);
> +		bnge_refill_dflt_rss_ctxs(bd);
> +	}
> +
> +	/* Notify only now, so the notification reports the new ring count
> +	 * and the reset indirection table.
> +	 */
> +	if (indir_lost)
> +		ethtool_rxfh_indir_lost(bd->netdev);

[Severity: Medium]
What happens when bnge_rings_ok() fails after rx_changed was true?

By that point bnge_check_rss_ctxs_lost() has already deleted user
contexts and bd->rx_nr_rings has been lowered. The -ENOMEM return then
skips the default table reset, bnge_refill_dflt_rss_ctxs() and
ethtool_rxfh_indir_lost().

On a later open, the request uses the reduced bd->rx_nr_rings. If firmware
grants that same count, old_rx_rings == resv_rx_rings and rx_changed is
false, so this block never runs again.

Default contexts would keep their old ctx->indir_size and old entries.
bnge_modify_rxfh_context() would then reject every change:

	if (ctx->indir_size != tbl_size) {
		NL_SET_ERR_MSG_MOD(extack,
				   "RSS context indirection table size mismatch");
		return -EINVAL;
	}

ethtool would also report tables that don't match what
bnge_fill_hw_rss_tbl() programs after clamping. For context 0,
rss_indir_user_size stays set and the lost notification is never sent,
even if the user table points at rings that no longer exist.

Skipping the reset of the main default table on this path predates this
patch. What's new is that the context handling and the indir_lost
notification now rely on the same ordering.

Could the repair steps run before the bnge_rings_ok() check, or could the
state changes wait until after it?

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
> index a44971a7c74d3..dae6dc2f3302d 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c

[ ... ]

> @@ -201,6 +222,88 @@ void bnge_hwrm_realloc_rss_ctx_vnic(struct bnge_net *bn)

[ ... ]

> +void bnge_check_rss_ctxs_lost(struct bnge_dev *bd, u16 new_rx_rings)
> +{

[ ... ]

> +	xa_for_each(&bd->netdev->ethtool->rss_ctx, context, ctx) {
> +		struct bnge_rss_ctx *rss_ctx = ethtool_rxfh_context_priv(ctx);
> +		u32 *indir = ethtool_rxfh_context_indir(ctx);
> +		bool lost = false;
> +		u32 i;
> +
> +		if (!ctx->indir_user_size)
> +			continue;
> +
> +		if (bnge_cal_nr_rss_ctxs(bd->rx_nr_rings) !=
> +		    bnge_cal_nr_rss_ctxs(new_rx_rings)) {
> +			lost = true;
> +		} else {
> +			for (i = 0; i < ctx->indir_size; i++) {
> +				if (indir[i] >= new_rx_rings) {
> +					lost = true;
> +					break;
> +				}
> +			}
> +		}
> +
> +		if (lost) {
> +			bnge_del_one_rss_ctx(bn, rss_ctx, true);
> +			ethtool_rxfh_context_lost(bd->netdev, rss_ctx->index);
> +		}

[Severity: Medium]
If the ring change moves bnge_cal_nr_rss_ctxs() (for example 100 -> 60
rings, so the table drops from 128 to 64 entries), does this delete every
context that has a user-configured table, whatever the table contains?

The core can already fold such tables. From ethtool_rxfh_can_resize():

	if (new_size < old_size) {
		if (new_size < user_size)
			return false;
		if (old_size % new_size)
			return false;
		if (!ethtool_rxfh_is_periodic(tbl, old_size, new_size))
			return false;
		return true;
	}

The netlink path can also store an indir_user_size smaller than
indir_size when a short table is replicated.

bnge_refill_dflt_rss_ctxs() does call ethtool_rxfh_ctxs_can_resize() and
ethtool_rxfh_ctxs_resize(). It only does so after this loop has removed
every user context, so user tables never get the chance to fold.

Could ethtool_rxfh_ctxs_can_resize() be tried before contexts are
declared lost?

Context 0 is handled the same way in bnge_reserve_rings():

	indir_lost = bd->netdev &&
		     netif_is_rxfh_configured(bd->netdev) &&
		     (bnge_cal_nr_rss_ctxs(bd->rx_nr_rings) !=
		      bnge_cal_nr_rss_ctxs(rx_rings) ||
		      bnge_get_max_rss_ring(bd) >= rx_rings);

Should ethtool_rxfh_indir_can_resize() and ethtool_rxfh_indir_resize()
be tried there too, instead of treating any size change as lost?

In the final state of the series (after "bnge: add NTUPLE filter support
in ethtool"), bnge_del_one_rss_ctx(..., true) also frees every
BNGE_ACT_RSS_CTX ntuple rule that targets the context. Userspace only
gets RSS_DELETE_NTF for the context and a "device error, RSS context %d
lost" message. Nothing reports the removed rules, and the commit message
doesn't mention this for non-default contexts.

The comment in bnge_refill_dflt_rss_ctxs() also seems inaccurate:

	/* Contexts with a user table that no longer fits were already
	 * dropped by bnge_check_rss_ctxs_lost(); only default ones resize.
	 */

Tables that would fit after folding are dropped as well.

> +	}
> +	mutex_unlock(&bd->netdev->ethtool->rss_lock);
> +}
> +
> +void bnge_refill_dflt_rss_ctxs(struct bnge_dev *bd)
> +{

[ ... ]

> +	if (resize) {
> +		if (ethtool_rxfh_ctxs_can_resize(bd->netdev, tbl_size)) {
> +			dev_warn(bd->dev,
> +				 "RSS contexts cannot be resized to %u entries\n",
> +				 tbl_size);
> +			return;
> +		}
> +		ethtool_rxfh_ctxs_resize(bd->netdev, tbl_size);
> +	}
> +
> +	mutex_lock(&bd->netdev->ethtool->rss_lock);
> +	xa_for_each(&bd->netdev->ethtool->rss_ctx, context, ctx) {
> +		if (!ctx->indir_user_size)
> +			bnge_set_dflt_rss_indir_tbl(bd, ctx);
> +	}
> +	mutex_unlock(&bd->netdev->ethtool->rss_lock);
>  }

[Severity: Medium]
Can this send RSS_NTF for tables that are never programmed into hardware?

ethtool_rxfh_ctxs_resize() updates ctx->indir_size, leaves the data alone
when shrinking, and then notifies right away:

	xa_for_each(&dev->ethtool->rss_ctx, context, ctx)
		ethtool_rss_notify(dev, ETHTOOL_MSG_RSS_NTF, context);

The default contexts are rewritten by bnge_set_dflt_rss_indir_tbl(bd, ctx)
only afterwards, and no further notification is sent.

For example, going from 128 to 60 RX rings, the notified 64-entry table
is i % 128, i.e. 0..63. That includes rings 60..63, which don't exist.
The table that bnge_hwrm_realloc_rss_ctx_vnic() later programs is i % 60.

bnge_reserve_rings() deliberately delays the context 0 notification
until the final table is in place. Could the non-default contexts be
notified after the refill in the same way?

[ ... ]

> @@ -242,3 +345,14 @@ int bnge_alloc_vnic_rss_table(struct bnge_net *bn,
>  	vnic->rss_hash_key_dma_addr = vnic->rss_table_dma_addr + size;
>  	return 0;
>  }
> +
> +void bnge_init_vnic_mem(struct bnge_vnic_info *vnic)
> +{
> +	int i;
> +
> +	vnic->fw_vnic_id = INVALID_HW_RING_ID;
> +	vnic->vnic_id = BNGE_VNIC_ID_INVALID;

[Severity: Low]
vnic_id is a u32, and this sets it to 0xffffffff for every RSS context
VNIC. The error messages in bnge_hwrm_vnic_rss_cfg() and bnge_setup_vnic()
print it with %d:

	netdev_err(bn->netdev, "hwrm vnic %d set rss failure rc: %d\n",
		   vnic->vnic_id, rc);

So any firmware failure on a context VNIC logs "vnic -1", which doesn't
say which RSS context failed. Would it be better to print the RSS context
index (or fw_vnic_id) for these VNICs?

> +
> +	for (i = 0; i < BNGE_MAX_CTX_PER_VNIC; i++)
> +		vnic->fw_rss_cos_lb_ctx[i] = INVALID_HW_RING_ID;
> +}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106093524.838341-1-vikas.gupta%40broadcom.com
