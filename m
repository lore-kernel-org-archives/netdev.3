Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCCE51357A
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790690652; cv=none; b=SD2uR8BwvKvgEOdgwn1DxM/NhDF/pgsz8OQ4bd2JF1qO/9FCpECD76+JTorhuJ0yabLLo3WZSCy5Oa64K8cvAvyNYviEeUghz03Bee7H9+1aQTpFkTWp/8YQDBe5ECMpwiIXCPN+nHFAe8f0eh4N9pqknBL4WeDxWjlm7tl/7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790690652; c=relaxed/simple;
	bh=7uZqIbxqLb+6EoZ/IT+x/qwFpXk7FI23lwYhQwXpWQ0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OVdekCRAP9FiiPOR5aYCidLpwOebCGFCjB6f5FKDDnyfMVWxLHMa1FjXAxQFu4FHEM2vV3uJhraeKcyQMQeLI3UuVekKLoCtMU6P4xbKazXwUr+riifPvKYWRlkOcd00Ya7Q2D8tdpB8ZjA7T8hhcaMFXLivewoWP0f8Azvv358=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8dTPjQd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8dTPjQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30281F000FF;
	Tue, 29 Sep 2026 14:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790690650;
	bh=35AAv+FkqITaLLADKCC5ArCsZyfbV2fgDUs0T5V4AGs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R8dTPjQdibza4SWPOAJBbFfK5YxaDa3mu474MWK7MKvnrMDttt99JVKwrIZtoBZrT
	 Qz9OBIVRJVFS2FKm7RFrBF0fzS8tZbCx0ABlBeZS84RBvxWUH9asy9R/pzZpRZDMxa
	 luMu6vkmClj+Ygr71Z36RN1+QI45gswLHLLJ0aUIcBNXRxoHtriWhZaDEOB8IaT+GW
	 LShDtdxISp0unfo66pWVZgFrD2ty4Ag/y7+7JRrT5pO+O51D9plif0yDvZxTtmGtFC
	 hJqALpE7Q8S1N56Oxqhlc9nmKvrVP6aCqLq7sbF1SBgnyc4oTwstEH9410RJ7NScZi
	 cqiWmszBVuV9g==
Subject: Re: [PATCH net v5 5/6] ice: rebuild ring stats arrays instead of
 reallocating them in place
From: netdev-bot+sashiko@kernel.org
To: przemyslaw.kitszel@intel.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com, mschmidt@redhat.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Date: Tue, 29 Sep 2026 14:04:09 +0000
Message-ID: <179069064954.434549.8538944205290269009@kernel.org>
In-Reply-To: <20260925132636.123300-6-przemyslaw.kitszel@intel.com>
References: <20260925132636.123300-6-przemyslaw.kitszel@intel.com>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 (1) · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] ice_vsi_resize_stat_arrays() sizes the arrays from a
  snapshot taken before ice_vsi_decfg(): the PF pool,…
- [Medium] ice_vsi_set_stat_arrays() publishes the new container with a
  plain store (`pf->vsi_stats[vsi->idx] = new_vsi_stat;`, ice_lib.c:592)…
- [Low] This patch fixes a real heap out-of-bounds access but has no
  Fixes: tag, and the Fixes-tagged fix later in the series cannot be…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but a fallback
  rebuild dereferences NULL queue maps.
- [Medium] ice_vsi_free_unused_stat_arrays() calls kfree_rcu() on surplus
  ice_ring_stats entries while vsi->tx_rings[i]->ring_stats and…

--

ice: rebuild ring stats arrays instead of reallocating them in place

This patch replaces ice_vsi_realloc_stat_arrays() with
ice_vsi_resize_stat_arrays(). The new function allocates a fresh struct
ice_vsi_stats before ice_vsi_decfg() runs, sized with
ice_vsi_get_num_qs(). Surviving ring stats entries are copied into the new
container, surplus entries go to kfree_rcu(), and the old container is
freed without its entries, using a new helper,
ice_vsi_install_stat_arrays().

> ice_vsi_realloc_stat_arrays() resized the ring stats arrays in place
> with krealloc_array(), sizing them from vsi->req_txq/req_rxq. That is
> not what ice_vsi_set_num_qs() computes later in ice_vsi_cfg_def(), so
> after a rebuild the arrays could end up shorter than vsi->alloc_txq /
> vsi->alloc_rxq, and ice_vsi_alloc_ring_stats() then walked past their
> end.

[ ... ]

> this removes some tech debt, but it is not independently backportable,
> as it sits on three preceding refactors; the NULL dereference and the
> sizing mismatch are fixed by their own patches, which carry Fixes: tags

[Severity: Low]
The commit message leads with a heap out-of-bounds access. An admin
reaches it by writing sriov_vf_msix_count after a guest has raised
vf->num_req_qs through VIRTCHNL_OP_REQUEST_QUEUES:

ice_sriov_set_msix_vec_count()
  vsi->req_txq = queues;
  ice_vsi_rebuild()

The switch to ice_vsi_get_num_qs() in ice_vsi_resize_stat_arrays() is what
fixes that. Should this patch carry a Fixes: tag, instead of being
described below the cut as tech debt removal?

The later patch "ice: size ring stats arrays from the final queue count"
carries Fixes: 288ecf491b16 and calls ice_vsi_install_stat_arrays(),
which this patch adds. A stable backport of that fix would also need this
patch and the three refactors before it (__ice_vsi_free_stats(),
ice_vsi_new_stat_arrays(), ice_vsi_get_num_qs()).

Could these be marked as stable dependencies so a backporter knows?

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 134984077d5da..448d3c7780adf 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -557,6 +557,80 @@ static struct ice_vsi_stats *ice_vsi_new_stat_arrays(int txq, int rxq)
>  	return vsi_stat;
>  }
>  
> +static void ice_vsi_free_unused_stat_arrays(struct ice_vsi_stats *vsi_stat,
> +					    struct ice_vsi_stats *new_vsi_stat)
> +{
> +	int new_txq = new_vsi_stat->tx_ring_stats_len;
> +	int new_rxq = new_vsi_stat->rx_ring_stats_len;
> +	int prev_txq = vsi_stat->tx_ring_stats_len;
> +	int prev_rxq = vsi_stat->rx_ring_stats_len;
> +
> +	for (int i = new_txq; i < prev_txq; i++) {
> +		if (vsi_stat->tx_ring_stats[i]) {
> +			kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
> +			WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
> +		}
> +	}

[Severity: Medium]
This is a pre-existing issue, and the old krealloc_array() code used the
same order. Are these entries still reachable when kfree_rcu() is called?

At this point vsi->tx_rings[i]->ring_stats and vsi->rx_rings[i]->ring_stats
still point at the surplus entries. The rings are only unpublished later:

ice_vsi_rebuild()
  ice_vsi_resize_stat_arrays()
    ice_vsi_install_stat_arrays()
      ice_vsi_free_unused_stat_arrays()
        kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
  ice_vsi_decfg()
    ice_vsi_clear_rings(vsi);

That grace period does not cover an RCU reader that starts after the
kfree_rcu() and reaches the entry through a ring, such as
__ice_get_ethtool_stats():

	tx_ring = READ_ONCE(vsi->tx_rings[j]);
	if (!tx_ring || !tx_ring->ring_stats) {

The reader paths that were checked look serialized by rtnl,
ICE_VSI_DOWN/ICE_CFG_BUSY, or netif_device_detach(), so the remaining
window looks narrow.

Now that the free is in its own function, could the surplus entries be
freed after ice_vsi_decfg() instead?

> +	for (int i = new_rxq; i < prev_rxq; i++) {

[ ... ]

> +static void ice_vsi_set_stat_arrays(struct ice_vsi *vsi,
> +				    struct ice_vsi_stats *new_vsi_stat)
> +{
> +	u16 new_txq, new_rxq, prev_txq, prev_rxq;
> +	struct ice_vsi_stats *vsi_stat;
> +	struct ice_pf *pf = vsi->back;
> +
> +	new_txq = new_vsi_stat->tx_ring_stats_len;
> +	new_rxq = new_vsi_stat->rx_ring_stats_len;
> +	vsi_stat = pf->vsi_stats[vsi->idx];
> +	pf->vsi_stats[vsi->idx] = new_vsi_stat;
> +	if (!vsi_stat)
> +		return; /* don't copy if there is no source */
> +
> +	prev_txq = vsi_stat->tx_ring_stats_len;
> +	prev_rxq = vsi_stat->rx_ring_stats_len;
> +
> +	memcpy(new_vsi_stat->tx_ring_stats, vsi_stat->tx_ring_stats,
> +	       sizeof(*vsi_stat->tx_ring_stats) * min(prev_txq, new_txq));
> +	memcpy(new_vsi_stat->rx_ring_stats, vsi_stat->rx_ring_stats,
> +	       sizeof(*vsi_stat->rx_ring_stats) * min(prev_rxq, new_rxq));
> +}

[ ... ]

> +static int ice_vsi_install_stat_arrays(struct ice_vsi *vsi, u16 txq, u16 rxq)
> +{
> +	struct ice_vsi_stats *old_stat, *new_stat;
> +
> +	new_stat = ice_vsi_new_stat_arrays(txq, rxq);
> +	if (!new_stat)
> +		return -ENOMEM;
> +
> +	old_stat = vsi->back->vsi_stats[vsi->idx];
> +	ice_vsi_set_stat_arrays(vsi, new_stat);
> +	if (old_stat) {
> +		ice_vsi_free_unused_stat_arrays(old_stat, new_stat);
> +		__ice_vsi_free_stats(old_stat, false);
> +	}

[Severity: Medium]
Can a lockless reader see the new container before the entries are copied
into it? ice_vsi_set_stat_arrays() publishes pf->vsi_stats[vsi->idx] with
a plain store, and only then memcpy()s in the surviving entry pointers.

ice_qp_reset_stats() dereferences an entry without a NULL check:

	vsi_stat = pf->vsi_stats[vsi->idx];
	if (!vsi_stat)
		return;

	memset(&vsi_stat->rx_ring_stats[q_idx]->stats, 0,

It is reached through ice_cfg_txtime() -> ice_qp_dis(), which holds only
rtnl and the ICE_CFG_BUSY bit. The reset path ice_rebuild() ->
ice_vsi_rebuild_by_type(pf, ICE_VSI_PF) -> ice_vsi_rebuild() takes
neither.

A related question: __ice_vsi_free_stats(old_stat, false) kfree()s the
old container and its arrays straight away, with no grace period. Could
ice_qp_reset_stats() still hold the old vsi_stat pointer at that point?

The ETF-vs-reset concurrency itself predates this patch, and the old
krealloc_array() also freed the old arrays synchronously. What is new is
publishing before the copy and freeing the whole container synchronously.

Would doing the memcpy() before the store to pf->vsi_stats[vsi->idx] close
the first window?

[ ... ]

> @@ -3040,69 +3114,27 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,

[ ... ]

> -static int
> -ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
> +static int ice_vsi_resize_stat_arrays(struct ice_vsi *vsi)
>  {

[ ... ]

> +	struct ice_vsi_alloc_queues_params qs;
>  
>  	/* channel VSIs have no entry in pf->vsi_stats[] */
>  	if (vsi->type == ICE_VSI_CHNL)
>  		return 0;
>  

[ ... ]

> +	qs = ice_vsi_get_num_qs(vsi, vsi->alloc_txq + vsi->num_xdp_txq,
> +				vsi->alloc_rxq);

[Severity: Critical]
Can the count computed here differ from the one ice_vsi_set_num_qs()
computes after ice_vsi_decfg()?

This snapshot depends on the PF pool, netif_get_num_default_rss_queues()
and vf->num_req_qs. ice_vsi_set_num_qs() later recomputes from the current
state:

	vsi->alloc_txq_rxq = ice_vsi_get_num_qs(vsi, 0, 0);

Nothing serializes the two calls. At this revision
ice_vsi_alloc_stat_arrays() keeps the installed arrays without checking
their length:

	if (pf->vsi_stats[vsi->idx])
	/* realloc will happen in rebuild path */
		return 0;

ice_vsi_alloc_ring_stats() then walks ice_for_each_alloc_txq() over
tx_ring_stats[]. Could it write past the end of tx_ring_stats[] or
rx_ring_stats[] if the second count is larger? One example is a PF rebuild
with req_txq == 0 while pool queues are freed, or CPUs come online, in
between.

The commit message acknowledges this ("barring a concurrent change of the
PF pool; the next patch stops relying on that"), and the baseline had the
same class of problem.

The later patch "ice: size ring stats arrays from the final queue count"
closes it. There, ice_vsi_alloc_stat_arrays() grows the arrays whenever
the stored lengths are below the final alloc_txq/alloc_rxq. This
intermediate revision is still exposed.

>  
> -	if (req_rxq < prev_rxq) {

[ ... ]

> -	return 0;
> +	return ice_vsi_install_stat_arrays(vsi, qs.alloc_txq, qs.alloc_rxq);
>  }
>  
>  /**
> @@ -3132,7 +3164,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
>  
>  	mutex_lock(&vsi->xdp_state_lock);
>  
> -	ret = ice_vsi_realloc_stat_arrays(vsi);
> +	ret = ice_vsi_resize_stat_arrays(vsi);
>  	if (ret)
>  		goto unlock;
>  

[Severity: High]
This isn't a bug introduced by this patch, but what happens when
ice_vsi_rebuild() is retried after a failure that already ran
ice_vsi_decfg()?

Both ice_setup_tc_mqprio_qdisc() and ice_sriov_set_msix_vec_count() call
ice_vsi_rebuild() again as a fallback:

	if (ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT)) {
		dev_err(dev, "Rebuild of main VSI failed again\n");

The first attempt can fail late. One case is the coalesce allocation in
ice_vsi_rebuild():

	coalesce = kzalloc_objs(struct ice_coalesce_stored, vsi->num_q_vectors);
	if (!coalesce) {
		ret = -ENOMEM;
		goto decfg;
	}

The other is ice_vsi_cfg_def() unrolling. Either way,
ice_vsi_free_arrays() has set vsi->txq_map = NULL, but alloc_txq and
alloc_rxq keep their values.

The retry now gets past ice_vsi_resize_stat_arrays(), which handles a NULL
old container, and calls ice_vsi_decfg() unconditionally:

ice_vsi_rebuild()
  ice_vsi_decfg()
    ice_vsi_put_qs()
      clear_bit(vsi->txq_map[i], pf->avail_txqs);

Does this dereference the NULL txq_map? After a cfg_def unroll,
num_q_vectors is also still non-zero. Can ice_vsi_free_q_vectors() index
the NULL q_vectors before that?

In the baseline the retry crashed earlier, in
ice_vsi_realloc_stat_arrays(). This patch moves the crash point but does
not add a guard.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925132636.123300-1-przemyslaw.kitszel%40intel.com
