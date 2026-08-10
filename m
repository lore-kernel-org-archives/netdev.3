Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF003F8241
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386743; cv=none; b=lK2NEkZEP7fVhl+IQ7xBfN6a04Mb3hPtYYrCMnmMg/IkP5LAajpVhbAtnu1cexjWnKKR9SEBTBNlKWvv6GSsqVmvEYM0hR+8kO6YjISQzxT6uehXTBWBWSo46u5tW+tzpbTaypJ3UZi0m3xgmgMtogc3/GEjOy0Jvqd0sXoHVdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386743; c=relaxed/simple;
	bh=g5r0Z+QKET6O833wfHDt+mushR0pX3IyU7yTuBmU4o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkO3kXOOysZn4eLnGNQWdXcVaIplaTxYgtXgH+UkI5K3unBsr1M1r1Ee+7yTyFUqcqNexdJ2r/duSRo9SsFm9KenA6D97hwgPNU35YJ3xhcQmrkUKjzQUzBxErb7KRYVIt9iiDuSiYBC0WoZlSvazAtPaXg+Pv9Y/cfYGqt6uV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HLkR/UAP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HLkR/UAP"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ccdf36f63dso17065ad.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786386741; x=1786991541; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yc1i9jCZ38+WjTOLsbw1yfhU6KnLG4orWewt9NM2biU=;
        b=HLkR/UAPu3i/we4WqnwP2xH94vSXvBU5uK3naTDOBgWQuVgNVpaKbPIjbNfukzBHPN
         97oc4Rp/vXXScDoOAC9aJHEm+KGa1qwu/8dLj7FVj8ChZaisgOkFcK6cutnWYNihkH0V
         S3UH1HdsPjxTEESL/8dIItFE1jAuUOfOGjvDgtUcisQlr4wHPrudhnaaid/RHIWKvYX2
         D4/RtHWZKL0OA9hOS9SOOoGsc8+inKsmWZTjApnuLzMyMgalafZQ68zWxj1wmyRoq+Xw
         IIVyNZDl99ygWoxjFh1uT7aC9yHbITmJEZ3+KBDsJhXdHDj6AQQimrsXaVq4P0x96M2o
         1R1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786386741; x=1786991541;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Yc1i9jCZ38+WjTOLsbw1yfhU6KnLG4orWewt9NM2biU=;
        b=hJ7gX/BaTlVKddTx0V6yV+6RGOsZZ/3xgGvTrkz5XirAouzkGv16S7+hGEgMBiGfsX
         m9XP63VSJkw0A3uDDMWzpgqa6Dia/WA3O/mnK9I+2TB4tj0bpb0ObgNIBjnQYNH8ZocS
         Anoctwp7jhzyEGtfDnWw2aShxZzvupFCvlo4Xe1J4X3bDq46c3ZNF9m4ADQTj+tcjFRH
         BtisFQqlyz1pM7CiBWKg9GvSv3siT03CqPp39ePwNp9f5p5DQa0NIfr0cftJPP4CFcIV
         g9oRHMIp7FGV3KoiCq2LTNqCI7GHFgpi5VsAzpg0AoC+sm+mKng0H1qJH8Wnow3IiDyj
         eR3w==
X-Forwarded-Encrypted: i=1; AHgh+RrfeH/J/dARg5YzyC8EnNVho3xnMYuJc3fBmygfbhWNNn7IDIttAbx7Owv4N35QiVa39LFgVrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvnreRgHZ8rdozXkRPxY8mkKmHGigzi+kSr/m2//kOolmZp5Jc
	HsZg8FHtgxe+FRyudYqWrJ2VvMv0aG5VPiNKvMaOtbBvT4c0jDP5/LHwvj0lDVQ2sQ==
X-Gm-Gg: AR+sD13jNXlpQkaJRQMO2BDZyG7Q9pp9UgHidwvFrlnucv29RqeJ/WDbNat4AHsZAKs
	otGQ+Suh5+YArEZAwElFqKqtAPdnCNzO2ck4g9brY1KgUGsToAYTNWgmlICIJmZHYk00SbNNr8t
	kj3IAGU28ZNaNp5JTffHXYzQ3UL7jQpVLGmHJ+FvxrfdgLIrkJ98GAq+cZzqWP9bRz+4ojZM8xC
	j0scGqVBdrlZgLXCB9OMOUIyjA4stfSHF0DBGtPYTi9X0jHF7ksy+p8T6zx2GZPKL4xfNiHswxt
	Pd+fZvEQqFbpxyYccYIFaiuUN9IxELnvSn6aImoYKEaJWmF0OuHpRzFNKvSbyvNpWa8EERrS8ul
	pHwQoEpv11RpYWZf31f1vsec8bG7qdqm59POXAoIrgepL7Q71ne214mZKgyHoFZDPrsdZIwu9oz
	IV4U2k0FNFbMgV+klb9izLX0x8nr3qLS5GVc9SlqhbVfJAx6YXgEuv5vytyP/OK42BltJxTkshh
	2vsdhR8d/pvH5cxSuJHinp+daRo02z1VNWrmKwgTjGXT4lkX8bRYo/hp+7US+n5I3w49OAqA9wd
	vKBAT/A=
X-Received: by 2002:a17:903:2ce:b0:2ca:6bf:5bac with SMTP id d9443c01a7336-2d3105ceb62mr1449205ad.8.1786386740920;
        Mon, 10 Aug 2026 11:32:20 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f35b16bsm4507503a12.20.2026.08.10.11.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:32:19 -0700 (PDT)
Date: Mon, 10 Aug 2026 18:32:15 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com,
	Liam.Howlett@oracle.com, ljs@kernel.org, david@kernel.org,
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org,
	jannh@google.com, aliceryhl@google.com, arve@android.com,
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org,
	davem@davemloft.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 2/5] binder: Make shrinker rely solely on per-VMA lock
Message-ID: <anoZL76y3WGXMArB@google.com>
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

Do we need to explain how lock_vma_under_rcu() works here?

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

The comments seem redundant, the label is enough. This works:

	vma = lock_vma_under_rcu(mm, page_addr);
	if (!vma && binder_alloc_is_mapped(alloc))
		goto err_vma_lock_failed;


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

This introduces an "extra" change. We'll now release pages without a
valid vma (e.g. after munmap()). Before, these pages were expected to be
released via close() in binder_alloc_deferred_release() later.

I don't see anything wrong with it. However, it does seem out of the
scope of this patch which just drops the mmap_read_lock() calls. Or at
least I don't see how this part is necessary.

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

This mutex_unlock() is now dead-code.

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
