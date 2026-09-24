Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09D0475335
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252602; cv=none; b=JRUhlpmAwGNLskk8vyJ/DH/30Cvd9G5Q5lGYzWusr6lXfsDFBaGWBnb8Gw3v171kMfmCYnMaDxA0AoSHgP4hz9qkdn4wmqQhf9lJsqzatC69613klReuKO7BD6vr6SBeF4qMW8D4W8TsWlVBsA6tJo7zb+SrJJ14M6gXg0udgAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252602; c=relaxed/simple;
	bh=ajFu1ChRHFUs9eVwviAaTNhmrIwad/rIszm0uRAzlKU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gykOHbpYz5KU9Iv/XjWk6Z6A+LsbKLluJxVu3ATXrzPI/qiKz5RIZMMdToq4OKwsaePe/IlGYjC9AxidaQyKoN/fvi7oYQErcylw35Gp6raHNukHU4oAzyiBSx+taH3AUDkBnzFhi64FsxIXuhYZSUcxVRved17whRgy+i5dlv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6iaWxa0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6iaWxa0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A431F000FF;
	Thu, 24 Sep 2026 12:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790252600;
	bh=BwFaLa5+fdiJ48+tcIBu5gVngin67IEKPk4FzTaY6XQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m6iaWxa0xp1UdzXTqAKAA5q96fSLFjvsnrUtVTMIBQP/jF1ML2/TjcDrJKQGo7wLc
	 7OgWdSOIgbMebRyldol7i/XI2OiOC1NMv9INtscFHx8eZhC3rD25BGU1dH7rJItrmR
	 c+Hss/aQvOtJI7n54j74BBULLYAuZ3b31l3vHREGFyEbI94ItUQaO2jytMNPbmBZgk
	 WiOXsgSIaLzIp27y4Pb3gsdBSNUUYcrFSN2ewrYR1j3zeF6vksc9bmTGhFNLNqEh9a
	 MOtOwWlXnfXB3hEvFgMLz9c81tNq2K5uQ7KzRu7yvu4bKvuYjAQ0Y9XE+pOPhfsaLx
	 mf+yfkhLKeXPA==
Subject: Re: [PATCH net v4 1/5] ice: extract __ice_vsi_free_stats()
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 mschmidt@redhat.com, przemyslaw.kitszel@intel.com, poros@redhat.com,
 aleksandr.loktionov@intel.com, horms@kernel.org
Date: Thu, 24 Sep 2026 12:23:19 +0000
Message-ID: <179025259975.2160803.14245014900650590060@kernel.org>
In-Reply-To: <20260921182106.1015019-2-anthony.l.nguyen@intel.com>
References: <20260921182106.1015019-2-anthony.l.nguyen@intel.com>
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

- [Low] The commit message states "No functional change intended", but
  the patch changes the authority for the stats-free loop bound from the…

Pre-existing issues:
- [High] Two sources of truth for the ring-stats array length: the patch
  records `vsi_stat->tx_ring_stats_len`/`rx_ring_stats_len` and makes…
- [High] NULL pointer dereference when rebuilding an ICE_VSI_CHNL VSI.

--

ice: extract __ice_vsi_free_stats()

This records the length of each ring stats array in struct ice_vsi_stats
and uses those lengths to free the array entries, so the freeing code no
longer needs the owning VSI. The body of ice_vsi_free_stats() is then
split out as __ice_vsi_free_stats() with a @free_entries parameter.

> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index db3c7015c56c4..fadfe94bf1c8c 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -328,6 +328,8 @@ enum ice_vsi_state {
>  struct ice_vsi_stats {
>  	struct ice_ring_stats **tx_ring_stats;  /* Tx ring stats array */
>  	struct ice_ring_stats **rx_ring_stats;  /* Rx ring stats array */
> +	u16 tx_ring_stats_len;  /* Length of the Tx ring stats array */
> +	u16 rx_ring_stats_len;  /* Length of the Rx ring stats array */
>  };

[Severity: High]
This isn't a bug introduced by this patch, but after this change there are
two notions of the array length, and only the free path consults the new
one.

ice_vsi_alloc_ring_stats() still walks the same arrays with the VSI queue
counts:

	tx_ring_stats = vsi_stats->tx_ring_stats;
	...
	ice_for_each_alloc_txq(vsi, i) {
		...
		ring_stats = tx_ring_stats[i];
		if (!ring_stats) {
			...
			WRITE_ONCE(tx_ring_stats[i], ring_stats);
		}

and the shrink loops in ice_vsi_realloc_stat_arrays() use
prev_txq = vsi->alloc_txq / prev_rxq = vsi->alloc_rxq rather than the
recorded lengths.

When vsi->alloc_txq or vsi->alloc_rxq is larger than the recorded array
length (the VF VIRTCHNL_OP_REQUEST_QUEUES case that the last patch of this
series documents with a KASAN splat), those sites read and WRITE_ONCE()
past the end of the kmalloc'ed pointer arrays, and the shrink loops can
kfree_rcu() a pointer read out of bounds.

Would it be worth mentioning in the changelog that the new fields are
authoritative only for the free path at this point in the series, and that
the allocation and shrink paths keep using vsi->alloc_txq/alloc_rxq until
the later patches? The end state of the series removes
ice_vsi_realloc_stat_arrays() in favour of ice_vsi_resize_stat_arrays()
plus ice_vsi_free_unused_stat_arrays() (which bounds itself with
tx_ring_stats_len/rx_ring_stats_len), and adds the missing resize call to
ice_vf_reconfig_vsi() before ice_vsi_decfg(), so the divergence does not
survive the series.

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 9e08db376d3d0..cc66ae6f2edbf 100644
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
> +			if (vsi_stat->tx_ring_stats[i]) {
> +				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
> +				WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
> +			}
> +		}
> +		for (int i = 0; i < vsi_stat->rx_ring_stats_len; i++) {
> +			if (vsi_stat->rx_ring_stats[i]) {
> +				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
> +				WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
> +			}
> +		}
> +	}
> +
> +	kfree(vsi_stat->tx_ring_stats);
> +	kfree(vsi_stat->rx_ring_stats);
> +	kfree(vsi_stat);
> +}

[Severity: Low]
The changelog says "No functional change intended", but the loop bound in
the free path changes owner: it was ice_for_each_alloc_txq()/
ice_for_each_alloc_rxq() (vsi->alloc_txq / vsi->alloc_rxq) and is now the
newly recorded tx_ring_stats_len / rx_ring_stats_len. Are these always
equal at the point ice_vsi_free_stats() runs?

One case where they are not is a partial resize in
ice_vsi_realloc_stat_arrays(): the Tx array is committed and its length
recorded, and then the Rx krealloc_array() can still fail:

	vsi_stat->tx_ring_stats_len = req_txq;
	...
	vsi_stat->rx_ring_stats =
		krealloc_array(vsi_stat->rx_ring_stats, req_rxq, ...);
	if (!vsi_stat->rx_ring_stats) {
		vsi_stat->rx_ring_stats = rx_ring_stats;
		return -ENOMEM;
	}

ice_vsi_rebuild() then does "goto unlock" without undoing the Tx resize,
so vsi->alloc_txq keeps the old (possibly larger) value while the array is
only req_txq entries long. The old free loop walked
tx_ring_stats[0 .. vsi->alloc_txq - 1] over that shortened array; the new
loop stops at tx_ring_stats_len. The same applies to the VF case described
by the last patch of this series.

Would it make sense to note in the changelog that the free bound now
follows the real allocation instead of the VSI queue count, rather than
describing it as a no-op?

> @@ -338,7 +364,6 @@ static void ice_vsi_free_stats(struct ice_vsi *vsi)
>  {
>  	struct ice_vsi_stats *vsi_stat;
>  	struct ice_pf *pf = vsi->back;
> -	int i;
>  
>  	if (vsi->type == ICE_VSI_CHNL)
>  		return;
> @@ -346,26 +371,7 @@ static void ice_vsi_free_stats(struct ice_vsi *vsi)
>  		return;
>  
>  	vsi_stat = pf->vsi_stats[vsi->idx];
> -	if (!vsi_stat)
> -		return;
> -
> -	ice_for_each_alloc_txq(vsi, i) {
> -		if (vsi_stat->tx_ring_stats[i]) {
> -			kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
> -			WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
> -		}
> -	}
> -
> -	ice_for_each_alloc_rxq(vsi, i) {
> -		if (vsi_stat->rx_ring_stats[i]) {
> -			kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
> -			WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
> -		}
> -	}
> -
> -	kfree(vsi_stat->tx_ring_stats);
> -	kfree(vsi_stat->rx_ring_stats);
> -	kfree(vsi_stat);
> +	__ice_vsi_free_stats(vsi_stat, true);
>  	pf->vsi_stats[vsi->idx] = NULL;
>  }

[ ... ]

> @@ -3051,6 +3059,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
>  		vsi_stat->tx_ring_stats = tx_ring_stats;
>  		return -ENOMEM;
>  	}
> +	vsi_stat->tx_ring_stats_len = req_txq;

[Severity: High]
This is a pre-existing issue, not something this patch introduces, but
since the new length bookkeeping lands in this function it may be worth
recording: can ice_vsi_realloc_stat_arrays() be entered with
pf->vsi_stats[vsi->idx] == NULL?

ice_vsi_alloc_stat_arrays() never publishes an entry for channel VSIs:

	if (vsi->type == ICE_VSI_CHNL)
		return 0;

while ice_vsi_rebuild() calls ice_vsi_realloc_stat_arrays()
unconditionally, and that function does:

	vsi_stat = pf->vsi_stats[vsi->idx];
	...
	tx_ring_stats = vsi_stat->tx_ring_stats;

The zero queue counts only make the shrink loop iterate zero times, they
do not stop the dereference. ice_rebuild_channels() explicitly selects
vsi->type == ICE_VSI_CHNL and calls ice_vsi_rebuild(vsi,
ICE_VSI_FLAG_INIT), so an ADQ setup followed by a reset appears to reach
it.

This one is addressed later in the series: the replacement
ice_vsi_resize_stat_arrays() starts with
"if (vsi->type == ICE_VSI_CHNL) return 0;".

>  
>  	if (req_rxq < prev_rxq) {
>  		for (i = req_rxq; i < prev_rxq; i++) {
> @@ -3070,6 +3079,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
>  		vsi_stat->rx_ring_stats = rx_ring_stats;
>  		return -ENOMEM;
>  	}
> +	vsi_stat->rx_ring_stats_len = req_rxq;
>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921182106.1015019-1-anthony.l.nguyen%40intel.com
