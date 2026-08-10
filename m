Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093093AE187;
	Mon, 10 Aug 2026 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357345; cv=none; b=OfRETolu5oaB6g5BGpos1l9paKmnH3Fb6PBBLOePyWtVA3H4jp68bAx0jQsPgJEdWlpYX01Ia8Im/z+hDH2mlbFyl79vKDj/9nLxrMvowPrm7fzK0GDhk43CoV3F1IgGUpx3FAZs9E+ohO0GqOM1ZeAFxZwNd0R2Om/kJe3I7Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357345; c=relaxed/simple;
	bh=LA8Dh/Gj2sUrMslXm2SYntkDjnSThjjC5hpoojG2krw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJDbVrZ0NAoCDavcsPwUOrlfZpPTazdG0RJM921LjU6kwLbHbUI++NvDQtTd4CLRkoZL1KjsKZl8kfBMDo9h71griL5JmxpE3WvqVZJTCZ4gVbix6U6lj7SmUoTho8oJJwWKwSKkzSClLI05kjb0iaBGjKL9XMdk99uXT30AQK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4DFGiUo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4DFGiUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1941F00A3A;
	Mon, 10 Aug 2026 10:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786357343;
	bh=NwWyhFg/k6MrmsUSXMiKAMqnHT9uyrXn8kBQTew3w3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F4DFGiUogDGpvWOhBc03f9eNfgF1LMtt/2L2dIaYpep9XEijeB8ET1w/ArB1+ePzR
	 sG3dh/9uOGKG3SZNiQ3cyq/FW5WkVTVRJ5dRhEne3kLdDM1KRzsfPDrLX983W5lUxr
	 svMHHvpZas2a48IV4ul8miZCjHaPQvy3/bGy/tyqfLs5avvTAVjqPegCXm5n9JTnHl
	 1TND+v4Q4Y6zpU4DXq+ViR6FT+E4nhq85aFVbUr6qNar1iAVeOThgwsHF2SyVVV4si
	 mxqbvTpgY0N3ZgtCJeFqIrYIGw0KCFtlUH8+tbn3GDSfslxbw961odYqt4ajxzjXkE
	 Puk1uLltxxjJg==
Date: Mon, 10 Aug 2026 11:22:03 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, david@kernel.org, willy@infradead.org, shakeel.butt@linux.dev, 
	vbabka@kernel.org, jannh@google.com, aliceryhl@google.com, arve@android.com, 
	cmllamas@google.com, christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 2/5] binder: Make shrinker rely solely on per-VMA lock
Message-ID: <anmlTpwKW-c51wYB@lucifer>
References: <20260806200548.3124802-1-surenb@google.com>
 <20260806200548.3124802-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260806200548.3124802-3-surenb@google.com>

On Thu, Aug 06, 2026 at 01:05:45PM -0700, Suren Baghdasaryan wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> tl;dr: lock_vma_under_rcu() is already a trylock. No need to do both
> it and mmap_read_trylock().
>
> Long Version:
>
> == Background ==
>
> Historically, binder used an mmap_read_trylock() in its shrinker code.
> This ensures that reclaim is not blocked on an mmap_lock. Commit
> 95bc2d4a9020 ("binder: use per-vma lock in page reclaiming") added
> support for the per-VMA lock, but left mmap_read_trylock() as a
> fallback.
>
> This was presumably because the per-VMA locking can fail for several
> reasons and most (all?) lock_vma_under_rcu() callers have a fallback
> to mmap_read_trylock().
>
> == Problem ==
>
> The fallback is not worth the complexity here. lock_vma_under_rcu() is
> essentially already a non-blocking trylock. The main reason it fails
> is also the reason mmap_read_trylock() fails: something is holding
> mmap_write_lock().
>
> The only remedy for a collision with mmap_write_lock() is to wait,
> which this code can not do. So the "fallback" after
> lock_vma_under_rcu() failure is not really a fallback: it is really
> likely to just be retrying in vain. That retry in an of itself isn't
> horrible. But it adds complexity.
>
> == Solution ==
>
> Now that per-VMA locks are universally available, lock_vma_under_rcu()
> will not persistently fail. Rely on it alone and simplify the code.
> The removal of the fallback does not affect NOMMU case because binder
> driver depends on CONFIG_MMU.
>
> Full disclosure: I originally tried to do this with
> lock_vma_under_rcu_wait(), but it did not fit well with the mmap_lock
> trylock semantics. Claude caught this in a review and suggested the
> approach in this path. It seemed sane to me. So, Suggesed-by: Claude,
> I guess.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Thanks, LGTM so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: linux-mm@kvack.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hjønnevåg <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: netdev@vger.kernel.org
> ---
>  drivers/android/binder_alloc.c | 45 ++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index e4488ad86a65..c13a588c37de 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -1142,7 +1142,6 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>  	struct vm_area_struct *vma;
>  	struct page *page_to_free;
>  	unsigned long page_addr;
> -	int mm_locked = 0;
>  	size_t index;
>
>  	if (!mmget_not_zero(mm))
> @@ -1151,27 +1150,25 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>  	index = mdata->page_index;
>  	page_addr = alloc->vm_start + index * PAGE_SIZE;
>
> -	/* attempt per-vma lock first */
> +	/*
> +	 * Attempt per-vma lock. This is essentially a
> +	 * "trylock". It can fail even if the VMA exists
> +	 * for 'page_addr'.
> +	 */
>  	vma = lock_vma_under_rcu(mm, page_addr);
>  	if (!vma) {
> -		/* fall back to mmap_lock */
> -		if (!mmap_read_trylock(mm))
> -			goto err_mmap_read_lock_failed;
> -		mm_locked = 1;
> -		vma = vma_lookup(mm, page_addr);
> +		/*
> +		 * If the vma exists, we can't continue because we cannot
> +		 * remove the page from the vma. However, if the vma was
> +		 * unmapped, it's okay to continue.
> +		 */
> +		if (binder_alloc_is_mapped(alloc))
> +			goto err_vma_lock_failed;
>  	}
>
>  	if (!mutex_trylock(&alloc->mutex))
>  		goto err_get_alloc_mutex_failed;
>
> -	/*
> -	 * Since a binder_alloc can only be mapped once, we ensure
> -	 * the vma corresponds to this mapping by checking whether
> -	 * the binder_alloc is still mapped.
> -	 */
> -	if (vma && !binder_alloc_is_mapped(alloc))
> -		goto err_invalid_vma;
> -
>  	trace_binder_unmap_kernel_start(alloc, index);
>
>  	page_to_free = alloc->pages[index];
> @@ -1182,7 +1179,12 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>  	list_lru_isolate(lru, item);
>  	spin_unlock(&lru->lock);
>
> -	if (vma) {
> +	/*
> +	 * Since a binder_alloc can only be mapped once, we ensure
> +	 * the vma corresponds to this mapping by checking whether
> +	 * the binder_alloc is still mapped.
> +	 */
> +	if (vma && binder_alloc_is_mapped(alloc)) {
>  		trace_binder_unmap_user_start(alloc, index);
>
>  		zap_vma_range(vma, page_addr, PAGE_SIZE);
> @@ -1191,23 +1193,18 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>  	}
>
>  	mutex_unlock(&alloc->mutex);
> -	if (mm_locked)
> -		mmap_read_unlock(mm);
> -	else
> +	if (vma)
>  		vma_end_read(vma);
>  	mmput_async(mm);
>  	binder_free_page(page_to_free);
>
>  	return LRU_REMOVED_RETRY;
>
> -err_invalid_vma:
>  	mutex_unlock(&alloc->mutex);
>  err_get_alloc_mutex_failed:
> -	if (mm_locked)
> -		mmap_read_unlock(mm);
> -	else
> +	if (vma)
>  		vma_end_read(vma);
> -err_mmap_read_lock_failed:
> +err_vma_lock_failed:
>  	mmput_async(mm);
>  err_mmget:
>  	return LRU_SKIP;
> --
> 2.55.0.654.g21b8a5bc05-goog
>

--
Cheers, Lorenzo
