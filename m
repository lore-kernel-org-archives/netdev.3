Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879AF499F1F;
	Wed, 16 Sep 2026 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549709; cv=none; b=ZeSwpMIE4s+MB/vQJVyLrlPWaJmQW0a87N0FX1Y24CkfrfM02CqgaaIEpmzhRm6mn06O4zngaSHA+XcT7TpNKKlKEKNCcGN3a6ElpP/bK6AEJ3qVq54ie7sCR4yi9ePpn5b3y+ata2AymCjfv5IzxjkZS35EmSr5y3M7RyHvTKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549709; c=relaxed/simple;
	bh=DaTkmw6+/4vAj+jTnbLXSyLldCRkaqvKEd2gil+mVLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2gHnQoAOuOg9F3QjIFSGdQeMDhBQWZHyqugHFRaVBPtnEYnsNJweGADxCZzGiohLmhac6sizChBxgfdPDE63NlBEv2IK99qGvreQ7cxpms3/6roGK8/tQWHTSMGfZqLDH0vf0Fz0pOhM8Ev4ZDc/+0LC3fGQ5phabFCQjFoNjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DbjJMDJo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DbjJMDJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11701F000FF;
	Wed, 16 Sep 2026 09:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789549693;
	bh=1c5BkG1XwUGSYihHgqGld4BqIOfDyTeiCgVyGKTLkns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DbjJMDJogC8wmX9uIsrav3Iwtmpm7VdSW6iGJVYfuqGtqfOxKJyjAsJciaS7cCIJj
	 5MBV82FutMYTWXCkoB4pdHCAGx+1QxfOEXi6lnAJXJD4VbqptsKZlj/Xsr0nhtlOXb
	 +P586OykuvYqikYSGWTjMD332werjohzIpCI0jpI=
Date: Wed, 16 Sep 2026 10:06:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com,
	Liam.Howlett@oracle.com, ljs@kernel.org, david@redhat.com,
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org,
	jannh@google.com, aliceryhl@google.com, arve@android.com,
	cmllamas@google.com, christian@brauner.io, tkjos@android.com,
	dsahern@kernel.org, davem@davemloft.net,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v7 2/5] binder: Make shrinker rely solely on per-VMA lock
Message-ID: <2026091635-steadfast-widely-7753@gregkh>
References: <20260831203056.838265-1-surenb@google.com>
 <20260831203056.838265-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831203056.838265-3-surenb@google.com>

On Mon, Aug 31, 2026 at 01:30:53PM -0700, Suren Baghdasaryan wrote:
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
> While at it we also make the handling of the cases where the original
> binder VMA is gone consistent. There are two cases to consider when
> Binder VMA is gone:
> 1. there is no VMA at that location anymore.
> 2. there is now another unrelated VMA at that location.
> 
> Before this change we handle case 1 by having the shrinker proceed to
> free the page, and just skip the zap_vma_range() call. And we handle
> case 2 by having the shrinker return LRU_SKIP. While either behavior
> is acceptable, we need to handle them in a consistent way. Handle both
> cases by freeing the page without touching the VMA (skipping the
> zap_vma_range()).
> 
> Full disclosure: I originally tried to do this with
> lock_vma_under_rcu_wait(), but it did not fit well with the mmap_lock
> trylock semantics. Claude caught this in a review and suggested the
> approach in this path. It seemed sane to me. So, Suggesed-by: Claude,
> I guess.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: linux-mm@kvack.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hjønnevåg <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Acked-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder_alloc.c | 46 ++++++++++++++++------------------

This file will be going away (along with the other binder .c files) for
7.4-rc1, so I don't object to this getting into other trees now, just
note that it will not be needed if you wait a release cycle :)

thanks,

greg k-h
