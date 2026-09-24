Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26F74756B1
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252604; cv=none; b=N4shxpMotOnt4psA+e3HMD9ayuxaKY6Fp1tg55e3p0Kgh3COftlCeH8vfhPZMZ8KRS9UY2lVB5lxv8fk7wTNWADOnkuHEtOq2gaygNPwd2imptEL3/BnuJ4TLHHBy4L6YGnXeqo2dT6jc728CgftIekgGlO8YVtNUgQVq5IfWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252604; c=relaxed/simple;
	bh=3etwp8LhGBdDyFbO8h6cUdhoPHHVfQCV4tUthXTc0go=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O76j1B1YL3jjDGQW5s6x0TT45/CSYIRmMj9OWg6G+nMwxK3X0eN1kccwjNka5m0st5fDZHLNjT7mZfbvbgN0gJHH6k4YNxTfckZxxsF+Vo/jXu8oBBGk8MWVVbrj4zDspCvLswgdrIgI7OnSNG4KaX6hwuU2zT14d9CZu0j6u6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZwe+ObA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZwe+ObA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB9B1F00893;
	Thu, 24 Sep 2026 12:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790252602;
	bh=8tqOg6Ar94DgO+X8XYzByM9ElE741cllnoWPGKC5Pwk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CZwe+ObAgCvqy1/P2xzzWImIzl4Tqb7yfTjaUv00cNh+rAMQCOFXFRp3ZF0si+0XT
	 583uCvJ4Bct8rpxyreq/dGL88zJ52wzRI3MSIZIii9/WA1EY0p+2hPNiIva8cSbpMp
	 JiOl22jdKWg1ems4gRXlciH7i7HjqGT/POPMgUmXf3lhvrbyvYFfWa45ePdpEVdSZz
	 LjyqGRxTSNy2fEQ9Fns6EDZdEsmh534B4Nk8u/38PpiQPgoYuU7KcJF9OYF/lljZDy
	 DXZvHAawo2QIWHXlPkBTwpdYkpGIeFW4lVVzXcKKjkZS9Fh8NhnWkjSZBTsC8qZI/r
	 P4KZJgQEZ9eRQ==
Subject: Re: [PATCH net v4 4/5] ice: rebuild ring stats arrays instead of
 reallocating them in place
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 mschmidt@redhat.com, przemyslaw.kitszel@intel.com, poros@redhat.com,
 aleksandr.loktionov@intel.com, horms@kernel.org
Date: Thu, 24 Sep 2026 12:23:20 +0000
Message-ID: <179025260097.2160803.6233570277298398890@kernel.org>
In-Reply-To: <20260921182106.1015019-5-anthony.l.nguyen@intel.com>
References: <20260921182106.1015019-5-anthony.l.nguyen@intel.com>
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

Critical: 0 · High: 0 · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Missing Fixes:/stable tag on a patch that fixes a heap out-of-
  bounds write.
- [Medium] A NULL-pointer-dereference fix is buried in a "while at it"
  sentence with no Fixes: tag.
- [Medium] The commit message's reproducer and its stated failure-path
  benefit are both inaccurate.
- [Medium] ice_vsi_resize_stat_arrays()
  (drivers/net/ethernet/intel/ice/ice_lib.c:3099) sizes and installs the…

--

ice: rebuild ring stats arrays instead of reallocating them in place

This replaces the in-place krealloc_array() resize in
ice_vsi_realloc_stat_arrays() with ice_vsi_resize_stat_arrays(), which
allocates a fresh struct ice_vsi_stats sized from ice_vsi_get_num_qs(),
copies the surviving entry pointers over and installs it before
ice_vsi_decfg() runs.  It also skips the stats handling entirely for
ICE_VSI_CHNL.

A few questions about the changelog and the new sizing contract below.

[Severity: Medium]

Should this patch carry a Fixes: tag?

The commit message describes a real out-of-bounds access:

>     after a rebuild the arrays could end up shorter than vsi->alloc_txq /
>     vsi->alloc_rxq, and ice_vsi_alloc_ring_stats() then walked past their
>     end.

ice_vsi_alloc_ring_stats() iterates with ice_for_each_alloc_txq() /
ice_for_each_alloc_rxq() and never consults tx_ring_stats_len /
rx_ring_stats_len:

drivers/net/ethernet/intel/ice/ice_lib.c:ice_vsi_alloc_ring_stats() {
	ice_for_each_alloc_txq(vsi, i) {
		...
		ring_stats = tx_ring_stats[i];
		if (!ring_stats) {
			ring_stats = kzalloc_obj(*ring_stats);
			...
			WRITE_ONCE(tx_ring_stats[i], ring_stats);
}

so a short array means out-of-bounds reads and out-of-bounds pointer
stores into the kmalloc'ed pointer arrays.

One reachable divergence is the VF case: the old resizer used vsi->req_txq,
which ice_sriov_set_msix_vec_count() sets, while ice_vsi_get_num_qs()
returns vf->num_req_qs ?: vf->num_vf_qs and ignores vsi->req_txq
altogether.  If the guest then raises vf->num_req_qs via
VIRTCHNL_OP_REQUEST_QUEUES, a PF reset (ice_vf_rebuild_vsi() ->
ice_vsi_rebuild()) shrinks the arrays while alloc_txq / alloc_rxq grow.

The next patch in this series ("ice: fix stats array overflow when VF
requests more queues") documents the same corruption class with a KASAN
slab-out-of-bounds splat and does carry a Fixes: tag.  Without a tag here,
and with this change sitting on top of three preceding refactors in the
same series (__ice_vsi_free_stats(), ice_vsi_new_stat_arrays(),
ice_vsi_get_num_qs()), how is a stable maintainer expected to identify the
affected kernels?  If the fix is deliberately not backportable, could the
changelog say so?

[Severity: Medium]

Two statements in the changelog do not seem to match the code.

First:

>     Requesting fewer queues than the PF pool can hand out was enough
>     to trigger it.

When a request is present, the removed resizer used vsi->req_txq /
vsi->req_rxq, and ice_vsi_get_num_qs() uses exactly the same values for
ICE_VSI_PF:

drivers/net/ethernet/intel/ice/ice_lib.c:ice_vsi_get_num_qs() {
	case ICE_VSI_PF:
		qs.alloc_txq = vsi->req_txq ?: ice_get_txq_count(pf, held_txq);
		if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags))
			qs.alloc_rxq = 1;
		else
			qs.alloc_rxq = vsi->req_rxq ?:
				       ice_get_rxq_count(pf, held_rxq);
}

and ice_vsi_recfg_qs() stores the nonzero request before rebuilding:

drivers/net/ethernet/intel/ice/ice_main.c:ice_vsi_recfg_qs() {
	if (new_tx)
		vsi->req_txq = (u16)new_tx;
	if (new_rx)
		vsi->req_rxq = (u16)new_rx;
}

so the two sizes are identical on that path, and with RSS disabled the
recomputed alloc_rxq is 1, i.e. smaller rather than larger.  Could the
changelog use a trigger that the code can actually exhibit, such as the VF
case where vsi->req_txq disagrees with vf->num_req_qs ?: vf->num_vf_qs, or
a PF VSI with no request where the pool grew since the last
configuration?

Second:

>     Doing the allocation up front also means the failure path is a plain
>     unlock and return, with the VSI still fully configured, rather than a
>     half-torn-down VSI to unwind.

The old ice_vsi_realloc_stat_arrays() was already called before
ice_vsi_decfg() in ice_vsi_rebuild(), and its -ENOMEM already went straight
to the unlock label with the VSI fully configured.  Isn't the actual new
benefit that a failure no longer leaves a half-updated ice_vsi_stats, where
the Tx array was already reallocated and surplus Tx entries freed before
the Rx allocation failed?

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index c6023c11eed3c..c6166ff44fc91 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c

[ ... ]

> @@ -3042,63 +3087,38 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
>  }
>  
>  /**
> - * ice_vsi_realloc_stat_arrays - Frees unused stat structures or alloc new ones
> - * @vsi: VSI pointer
> + * ice_vsi_resize_stat_arrays - resize ring stats arrays for new queue count
> + * @vsi: VSI to swap the ring stats arrays of
> + *
> + * Call while @vsi still owns its queues and before ice_vsi_decfg() returns them
> + * to the PF pool, so that the new size is what ice_vsi_set_num_qs() will compute
> + * afterwards. Surviving entries are carried over, the rest is freed.
> + *
> + * Return: 0 on success and negative value on failure
>   */
> -static int
> -ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
> +static int ice_vsi_resize_stat_arrays(struct ice_vsi *vsi)
>  {
> -	u16 req_txq = vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
> -	u16 req_rxq = vsi->req_rxq ? vsi->req_rxq : vsi->alloc_rxq;
> -	struct ice_ring_stats **tx_ring_stats;
> -	struct ice_ring_stats **rx_ring_stats;
> -	struct ice_vsi_stats *vsi_stat;
> +	struct ice_vsi_alloc_queues_params qs;
> +	struct ice_vsi_stats *old_stat;
> +	struct ice_vsi_stats *new_stat;
>  	struct ice_pf *pf = vsi->back;
> -	u16 prev_txq = vsi->alloc_txq;
> -	u16 prev_rxq = vsi->alloc_rxq;
> -	int i;
>  
> -	vsi_stat = pf->vsi_stats[vsi->idx];
> +	if (vsi->type == ICE_VSI_CHNL)
> +		return 0;

[Severity: Medium]

Is this new guard really just a "while at it" cleanup?

>     While at it, skip the stats handling for ICE_VSI_CHNL, which has no
>     entry in pf->vsi_stats[] to begin with.

Before this patch the function did:

	vsi_stat = pf->vsi_stats[vsi->idx];
	...
	tx_ring_stats = vsi_stat->tx_ring_stats;

with no NULL check.  For a channel VSI pf->vsi_stats[vsi->idx] is always
NULL, since ice_vsi_alloc_stat_arrays() returns early:

drivers/net/ethernet/intel/ice/ice_lib.c:ice_vsi_alloc_stat_arrays() {
	if (vsi->type == ICE_VSI_CHNL)
		return 0;
}

and the preceding if (req_txq < prev_txq) loop is skipped because a CHNL
VSI has alloc_txq == alloc_rxq == 0, so the dereference happens
unconditionally.

The path looks live: ice_rebuild_channels() calls ice_vsi_rebuild() for
every vsi->type == ICE_VSI_CHNL, and it is reached from ice_rebuild() for
reset_type == ICE_RESET_PFR with ICE_FLAG_TC_MQPRIO set:

drivers/net/ethernet/intel/ice/ice_main.c:ice_rebuild() {
	if (reset_type == ICE_RESET_PFR) {
		err = ice_rebuild_channels(pf);
}

So doesn't a PF reset with ADQ/mqprio configured oops on the pre-patch
code?  If so, should this part be split out as its own patch with a Fixes:
tag, or at least described as a NULL-pointer dereference fix in the
changelog?

>  
> -	if (req_txq < prev_txq) {
> -		for (i = req_txq; i < prev_txq; i++) {
> -			if (vsi_stat->tx_ring_stats[i]) {
> -				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
> -				WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
> -			}
> -		}
> -	}
> +	qs = ice_vsi_get_num_qs(vsi, vsi->alloc_txq + vsi->num_xdp_txq,
> +				vsi->alloc_rxq);
>  
> -	tx_ring_stats = vsi_stat->tx_ring_stats;
> -	vsi_stat->tx_ring_stats =
> -		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
> -			       sizeof(*vsi_stat->tx_ring_stats),
> -			       GFP_KERNEL | __GFP_ZERO);
> -	if (!vsi_stat->tx_ring_stats) {
> -		vsi_stat->tx_ring_stats = tx_ring_stats;
> +	new_stat = ice_vsi_new_stat_arrays(qs.alloc_txq, qs.alloc_rxq);
> +	if (!new_stat)
>  		return -ENOMEM;

[Severity: Medium]

Can the size computed here still end up smaller than what
ice_vsi_set_num_qs() computes afterwards?

For an ICE_VSI_PF VSI with req_txq / req_rxq == 0, ice_vsi_get_num_qs()
derives the counts from the shared PF pool via ice_get_txq_count() /
ice_get_rxq_count() -> ice_get_avail_q_count().  ice_vsi_rebuild() then
runs ice_vsi_decfg() and ice_vsi_cfg_def() -> ice_vsi_set_num_qs(), which
re-reads the same pool independently:

drivers/net/ethernet/intel/ice/ice_lib.c:ice_vsi_set_num_qs() {
	vsi->alloc_txq_rxq = ice_vsi_get_num_qs(vsi, 0, 0);
}

Nothing appears to serialize the two evaluations.  ice_get_avail_q_count()
holds pf->avail_q_mutex only for the duration of the count:

drivers/net/ethernet/intel/ice/ice_main.c:ice_get_avail_q_count() {
	mutex_lock(lock);
	for_each_clear_bit(bit, pf_qmap, size)
		count++;
	mutex_unlock(lock);
}

and ice_vsi_put_qs() takes it only while releasing.  vsi->xdp_state_lock is
per-VSI, and the reset-driven rebuild (ice_reset_subtask() ->
ice_rebuild() -> ice_vsi_rebuild_by_type()) holds no rtnl.

If another context frees queues inside that window, for example
echo 0 > sriov_numvfs -> ice_sriov_configure() -> ice_free_vfs() ->
ice_vsi_release() -> ice_vsi_put_qs(), the recomputed alloc_txq /
alloc_rxq become larger than the already-installed tx_ring_stats_len /
rx_ring_stats_len.  Nothing reconciles them afterwards, because
ice_vsi_alloc_stat_arrays() returns 0 early once pf->vsi_stats[idx] is
populated:

drivers/net/ethernet/intel/ice/ice_lib.c:ice_vsi_alloc_stat_arrays() {
	if (pf->vsi_stats[vsi->idx])
	/* realloc will happen in rebuild path */
		return 0;
}

and ice_vsi_alloc_ring_stats() indexes by alloc_txq / alloc_rxq without
looking at the recorded lengths, so it would again store pointers past the
end of the arrays.

Would it be more robust to bound the loops in ice_vsi_alloc_ring_stats() by
tx_ring_stats_len / rx_ring_stats_len, which struct ice_vsi_stats now
carries, or to size the arrays after the final queue count is established,
rather than keeping the sizing expression duplicated in two places with no
cross-check?

> -	}
> -	vsi_stat->tx_ring_stats_len = req_txq;
> -
> -	if (req_rxq < prev_rxq) {
> -		for (i = req_rxq; i < prev_rxq; i++) {
> -			if (vsi_stat->rx_ring_stats[i]) {
> -				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
> -				WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
> -			}
> -		}
> -	}
>  
> -	rx_ring_stats = vsi_stat->rx_ring_stats;
> -	vsi_stat->rx_ring_stats =
> -		krealloc_array(vsi_stat->rx_ring_stats, req_rxq,
> -			       sizeof(*vsi_stat->rx_ring_stats),
> -			       GFP_KERNEL | __GFP_ZERO);
> -	if (!vsi_stat->rx_ring_stats) {
> -		vsi_stat->rx_ring_stats = rx_ring_stats;
> -		return -ENOMEM;
> +	old_stat = pf->vsi_stats[vsi->idx];
> +	ice_vsi_set_stat_arrays(vsi, new_stat);
> +	if (old_stat) {
> +		ice_vsi_free_unused_stat_arrays(old_stat, new_stat);
> +		__ice_vsi_free_stats(old_stat, false);
>  	}
> -	vsi_stat->rx_ring_stats_len = req_rxq;
>  
>  	return 0;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921182106.1015019-1-anthony.l.nguyen%40intel.com
