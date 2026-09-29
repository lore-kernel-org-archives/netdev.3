Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F7D3644C5
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790690651; cv=none; b=R/H8NYI2mjVqI13YeNmLf0m2p3xtv9mF4GnXXj/4VSWtBIWBSOrQoBp8nVV1hiU3kuQeADvLsqoSVgN1g5/Gd22+t+9Q01OYXZqvvThokPTLjzDkEnI7xt710OVeCCJddW8ll1r3n7Jb2ySeZ6ph+Oy2EQ+JPz+zRqoHvBoNm0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790690651; c=relaxed/simple;
	bh=RLK+Tfe2gBAawGZPJf+1IBR0OzHR76t9OeRfv4okvJ0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TqwLPmOSKkJph/TVgXrWcl6Zrlf5fm8T0fJ99vhWfVDfL2v+xTodZYxNZSrZ9UojVL5eb8uSUQfzdiJkWl+xa/ctRp1orac5rYtl85Psh07McDv6ulvBbSSayZ4+dNdkgAMwDuW5G1dk+uCbPh9IEkaStT056VKBQOPokGEcVF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuBSky+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuBSky+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE91D1F00893;
	Tue, 29 Sep 2026 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790690649;
	bh=J0U2ZuPppH2NjwbCIrXn37RZhk/7ihyg4JkkDJeReJA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OuBSky+qok/H9Ha6B6ps/9C1pxy8XJmntR7w+IlGRHZ4JmdxXdQCs6OOaPoSLctCI
	 bLSe0JwAla99ICfXUNolYiRUj7qQNqbmb5+QETwA/HRRwo77pgpk9wwFaxgT0Ye5kK
	 gUj6M6PygOvOYaCK5PODVpQmr1SJPHwFiERuoxLLziEAb4mN5ZEoqFSTBlN3tDl1fc
	 5ohH7rsqEcXH/lrWYRwkfcwuLlWl2djQPLLPvaclZxBF+/9JXDUH4lFhlmA0ZRcPHm
	 tAkjs8Oa2DjlvSOpS9H5iniMytnNjBQqZ56hEaLUCO8r84E4irM5+ToKBsKCKKXMPu
	 y0buMK0gk20MA==
Subject: Re: [PATCH net v5 2/6] ice: extract __ice_vsi_free_stats()
From: netdev-bot+sashiko@kernel.org
To: przemyslaw.kitszel@intel.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com, mschmidt@redhat.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Date: Tue, 29 Sep 2026 14:04:08 +0000
Message-ID: <179069064842.434549.3321384376885392964@kernel.org>
In-Reply-To: <20260925132636.123300-3-przemyslaw.kitszel@intel.com>
References: <20260925132636.123300-3-przemyslaw.kitszel@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message understates what the change does and the patch
  has no Fixes: tag.

Pre-existing issues:
- [Critical] Heap out-of-bounds write in ice_vsi_alloc_ring_stats()
  (drivers/net/ethernet/intel/ice/ice_lib.c).
- [Medium] The shrink loops in ice_vsi_realloc_stat_arrays()
  (drivers/net/ethernet/intel/ice/ice_lib.c) still use…

--

ice: extract __ice_vsi_free_stats()

This commit records the length of each ring stats array in struct
ice_vsi_stats and moves the VSI-independent body of ice_vsi_free_stats()
into __ice_vsi_free_stats(). The loops that free the entries now stop at
the recorded length instead of vsi->alloc_txq/alloc_rxq.

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 31af378aa0e7a..1414127d32cd8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -330,6 +330,32 @@ static void ice_vsi_free_arrays(struct ice_vsi *vsi)
>  	vsi->rxq_map = NULL;
>  }
>  
> +/* free single stats memory */
> +static void __ice_vsi_free_stats(struct ice_vsi_stats *vsi_stat, bool free_entries)
> +{
> +	if (!vsi_stat)
> +		return;
> +
> +	if (free_entries) {
> +		for (int i = 0; i < vsi_stat->tx_ring_stats_len; i++) {

[Severity: Low]

The old loop in ice_vsi_free_stats() used ice_for_each_alloc_txq(), so it
stopped at vsi->alloc_txq. This one stops at the recorded array length.
Could the old mismatch actually happen?

It looks reachable through ethtool -L with fewer Tx and more Rx queues:

ice_vsi_recfg_qs()
  ice_vsi_rebuild()
    ice_vsi_realloc_stat_arrays()
      krealloc_array(tx_ring_stats, req_txq, ...)   /* shrink succeeds */
      krealloc_array(rx_ring_stats, req_rxq, ...)   /* grow fails */
      return -ENOMEM;
    goto unlock;                                    /* skips ice_vsi_cfg_def() */

After that, vsi->alloc_txq still has the old, larger value. Later,
ice_vsi_free()->ice_vsi_free_stats() walked tx_ring_stats[] past the end of
the shrunken kmalloc object. Any non-NULL word it found there, for example
SLUB redzone poison under slub_debug, was passed to kfree_rcu().

So this patch appears to fix a heap out-of-bounds read and an invalid
kfree_rcu(). The commit message only says:

  The free path now stops at the recorded length instead of the VSI queue
  count, so it follows the real allocation rather than a number that can
  disagree with it.

Could the message describe the memory-safety effect? Should the patch also
carry a Fixes: tag?

The last patch in the series, "ice: size ring stats arrays from the final
queue count", has Fixes: 288ecf491b16 for the same class of bug and depends
on this one. A stable backport would probably pull this patch in anyway.

> +			if (vsi_stat->tx_ring_stats[i]) {
> +				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
> +				WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
> +			}
> +		}

[ ... ]

> @@ -539,11 +545,13 @@ static int ice_vsi_alloc_stat_arrays(struct ice_vsi *vsi)
>  		kzalloc_objs(*vsi_stat->tx_ring_stats, vsi->alloc_txq);
>  	if (!vsi_stat->tx_ring_stats)
>  		goto err_alloc_tx;
> +	vsi_stat->tx_ring_stats_len = vsi->alloc_txq;

[Severity: Critical]

This is a pre-existing issue, not introduced by this patch. The length is
only set when the container is new. Earlier in ice_vsi_alloc_stat_arrays()
there is an early return:

	if (pf->vsi_stats[vsi->idx])
	/* realloc will happen in rebuild path */
		return 0;

ice_vsi_alloc_ring_stats() fills the arrays up to the queue count and never
checks the recorded length:

	ice_for_each_alloc_txq(vsi, i) {
		...
		ring_stats = tx_ring_stats[i];
		if (!ring_stats) {
			...
			WRITE_ONCE(tx_ring_stats[i], ring_stats);
		}
		...
	}

On the VF reset path a guest can raise the queue count while the arrays
keep their old length:

ice_vc_request_qs_msg()
  ice_reset_vf()
    ice_vf_reconfig_vsi()
      ice_vsi_decfg()
      ice_vsi_cfg()
        ice_vsi_cfg_def()
          ice_vsi_alloc_def()
            ice_vsi_set_num_qs()      /* raises alloc_txq/alloc_rxq */
          ice_vsi_alloc_stat_arrays() /* early return, arrays not resized */
          ice_vsi_alloc_ring_stats()  /* reads/writes past tx_ring_stats[] */

The PF rebuild path has the same mismatch. ice_vsi_realloc_stat_arrays()
sizes the arrays from req_txq or the old alloc_txq before the count is
recomputed.

Can this write kernel pointers past the kmalloc object? After this patch
those pointers would also leak, because __ice_vsi_free_stats() stops at
tx_ring_stats_len.

The commit message says sizing is not authoritative yet. The last patch in
the series, "ice: size ring stats arrays from the final queue count", fixes
this: ice_vsi_alloc_stat_arrays() compares the recorded lengths with
vsi->alloc_txq/alloc_rxq and grows the arrays before
ice_vsi_alloc_ring_stats() runs.

>  
>  	vsi_stat->rx_ring_stats =
>  		kzalloc_objs(*vsi_stat->rx_ring_stats, vsi->alloc_rxq);
>  	if (!vsi_stat->rx_ring_stats)
>  		goto err_alloc_rx;
> +	vsi_stat->rx_ring_stats_len = vsi->alloc_rxq;
>  
>  	pf->vsi_stats[vsi->idx] = vsi_stat;
>  
> @@ -3055,6 +3063,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
>  		vsi_stat->tx_ring_stats = tx_ring_stats;
>  		return -ENOMEM;
>  	}
> +	vsi_stat->tx_ring_stats_len = req_txq;

[Severity: Medium]

This isn't a bug introduced by this patch. The shrink loops earlier in
ice_vsi_realloc_stat_arrays() still take their upper bound from the queue
count, not from the new length:

	u16 prev_txq = vsi->alloc_txq;
	...
	if (req_txq < prev_txq) {
		for (i = req_txq; i < prev_txq; i++) {
			if (vsi_stat->tx_ring_stats[i]) {
				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);

Tx is committed here, before the Rx krealloc_array(). If that allocation
fails, ice_vsi_rebuild() exits through "goto unlock" before ice_vsi_cfg_def()
runs, so vsi->alloc_txq stays larger than tx_ring_stats_len.

On the next rebuild, does this loop read tx_ring_stats[] past the end of the
array? It would also call kfree_rcu() on whatever it finds there.

In the opposite case, len larger than alloc_txq, krealloc_array() seems to
drop the entries in [alloc_txq, len) without freeing them.

Later in the series, "ice: rebuild ring stats arrays instead of reallocating
them in place" removes ice_vsi_realloc_stat_arrays(). Its replacement,
ice_vsi_free_unused_stat_arrays(), frees surplus entries only up to
tx_ring_stats_len/rx_ring_stats_len. It also allocates a fresh container up
front, so the partial-failure state can no longer happen.

>  
>  	if (req_rxq < prev_rxq) {
>  		for (i = req_rxq; i < prev_rxq; i++) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925132636.123300-1-przemyslaw.kitszel%40intel.com
