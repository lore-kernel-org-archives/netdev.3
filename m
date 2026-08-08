Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478362E6CCD;
	Sat,  8 Aug 2026 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786153306; cv=none; b=rMGUuIl+o737UvjzzJEtrWUgntTWm4OkncSHcJcpx+DDtGat8QlukrlYjMYSZ4fzePipZ68k5o24/5QJiYIZ1wqn+kw+us2oFDyC2gCxKH3R2+M1JV3JIhYuEwJ+6kPc+lWz7/ewr7kv/1ubnK6kak/pM57sOzo9sBu0Ho06aNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786153306; c=relaxed/simple;
	bh=8cfggL2C7NfHpvFvhTFPgrlEcm7Oi2u2UESLglztmSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihQR+d5YFqEaO1rxNG2BoKGCIO1Ep7YUS1s6IYgOMFAT1cONCaVa2EvwcKS8uiQKkUn2JMzIIiBphxwmF0BqIx1+IJkC+AgCtQhSrBKPWNXKTbZQjOwSZZioaLBB+YNYoUaYcIuKFgf/VF7tf5GNJdoHvcMAR9h572E1rpZi458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yo8nL7sX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yo8nL7sX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zPdvXze8eJ+ip1RN4T5sK8ZVGUl8K7CRCIHKK0OEMsY=; b=Yo8nL7sXT8DRH38MZOCw9KMwkr
	FAGRqZvulhAtUjnuFQ/xUT7VCJP3ZAz6pmjW+4saebDg7NiH/RsA9+0Kpt/PWmkioG1+G35+7fCoS
	WxDFIETAP35cQ+2y3/Mi7493pxT5koC5/6xxcZJMI/Gc0ch+zQoaaHbikgQIzLBF5RmOoVYF4Ld1G
	EZApA0iQw3Ox2+EXHHsaLEdwbfC+tCEekT1PTPToUC3n6ZQaY5pBoQseiPCWf0LoGF4r42Xi5whKf
	5yH6lMKcuUhcIDYN9K4tRjP+3czgzJzw/I1lDa9qR8GKtcqdU6NGeWAY9a2d37wm7kbmtMK4OxqxX
	hm2Im+OQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsVcI-0000000189D-1P0D;
	Sat, 08 Aug 2026 01:13:14 +0000
Date: Sat, 8 Aug 2026 02:12:50 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com,
	Liam.Howlett@oracle.com, ljs@kernel.org, david@kernel.org,
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com,
	aliceryhl@google.com, arve@android.com, cmllamas@google.com,
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org,
	davem@davemloft.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/5] mm: Make per-VMA locks available universally
Message-ID: <anaCkrk55EQoE2aS@casper.infradead.org>
References: <20260806200548.3124802-1-surenb@google.com>
 <20260806200548.3124802-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806200548.3124802-2-surenb@google.com>

On Thu, Aug 06, 2026 at 01:05:44PM -0700, Suren Baghdasaryan wrote:
> +++ b/kernel/bpf/stackmap.c
> @@ -272,13 +272,8 @@ struct stack_map_vma_lock {
>  /*
>   * Acquire a stable read-side reference on the VMA covering @ip.
>   *
> - * With CONFIG_PER_VMA_LOCK=y this returns a VMA with its per-VMA read
> - * lock held and mmap_lock dropped, so the caller may sleep.
> - *
> - * With CONFIG_PER_VMA_LOCK=n it returns a VMA with mmap_lock still
> - * held; the caller must snapshot any fields it needs and pin vm_file
> - * with get_file() before stack_map_unlock_vma() drops mmap_lock, as
> - * the VMA may be split, merged, or freed after that.
> + * This returns a VMA with its per-VMA read lock held and mmap_lock
> + * dropped, so the caller may sleep.

I don't know if BPF is compatible with !MMU or not, but the comment
is inconsistent with the code.  How about:

 * On NOMMU configurations, returns with the mmap_lock held.  If the MMU
 * is enabled, the per-VMA lock will be held instead.  The lock
 * should be released with stack_map_unlock_vma() which will release the
 * appropriate lock.  Once the lock is released, the VMA may be freed.

>   * Returns NULL on failure, in which case no lock is held.
>   */
> @@ -288,7 +283,6 @@ stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
>  	struct mm_struct *mm = lock->mm;
>  	struct vm_area_struct *vma;
>  
> -	/* noop under !CONFIG_PER_VMA_LOCK */
>  	vma = lock_vma_under_rcu(mm, ip);
>  	if (vma) {
>  		lock->vma = vma;
> @@ -308,21 +302,20 @@ stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
>  		return NULL;
>  	}
>  
> -#ifdef CONFIG_PER_VMA_LOCK
> +#ifdef CONFIG_MMU
>  	if (!vma_start_read_locked(vma)) {
>  		mmap_read_unlock(mm);
>  		return NULL;
>  	}
>  	mmap_read_unlock(mm);
>  #endif
> -
>  	lock->vma = vma;
>  	return vma;
>  }
