Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4843B6E7;
	Tue,  4 Aug 2026 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834735; cv=none; b=Qtj9Atwd6GEr/cNigGQ6GGRCkWl04C5h/FgbOPXM95NONoBJWZ9Axq6tWO/RU9qczo2pS9SvNEBbhYZLEy93/i5ustmVj6vg4Z0+24rxGbqdMaw9gLqcDUiKPs9ZvAjAHsFznbBLK5nX0lzTZPle4APWj1Qzw4W9zW7zFsgR3p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834735; c=relaxed/simple;
	bh=Nu9sSYuFmAidSl3yRrsA8Qj1FjFSrFAjuTGpoaOu9Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4nnH3IegWYrsA8YSHJ0KvLstMpqxXNYiagfykVRkJI1otI9kv1l8lzriI9uHT8m2tIaVOzwznUXqYmcaOTgkgyjdJS/r/eXm39eg4H5Mfad4QrIsVQ22uXdHqC/rbvNvVGTD6FzX45g2nHZx/H6+O40bAcVJe22xnImD8cyVnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGRzJukZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGRzJukZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD67C1F00A3A;
	Tue,  4 Aug 2026 09:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785834733;
	bh=7OS2FxJ2o8qEXyNFEZjAKJzxBK1YkBcPjjkEsV82CJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FGRzJukZAa2iNtq+ZsgKC6cELUnGQA9Mlzy+AHGhBnw1yrYkl3BBrRFDksfc0DUTc
	 pCIXsbrtk6mNfTkUMIsXOJ44gR5YmYr+Y332yc2wQs2VIR5WxQ/2s/aiwf1wRYDww7
	 yELz+tSjcLdK6NiVZHSF6K+MAjNzplfHDOU7VWOZt3YV1cDw0BRfNeRMvgN7fvxB/h
	 Il93aQqns88O12E1BxNGqFYS06eBMpPisctEy92AGY3xVcBJtSP+vptv7d2gnkXUd/
	 jX8ehmVFnRWOsqM4hcTgIPP+F28HINKQB5jgrh9Kf9s6kAQdLsphEI4eb4BXUXuoSJ
	 JnCcFYTCebl9g==
Date: Tue, 4 Aug 2026 10:11:53 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, david@redhat.com, willy@infradead.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com, arve@android.com, 
	cmllamas@google.com, christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/5] binder: Make shrinker rely solely on per-VMA lock
Message-ID: <anGsYeT0zfhxXgNI@lucifer>
References: <20260802215459.2769283-1-surenb@google.com>
 <20260802215459.2769283-3-surenb@google.com>
 <anByp6uVW77uofKx@lucifer>
 <anGrFIYiPhjxWSkD@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anGrFIYiPhjxWSkD@google.com>

On Tue, Aug 04, 2026 at 09:04:20AM +0000, Alice Ryhl wrote:
> On Mon, Aug 03, 2026 at 12:10:21PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Sun, Aug 02, 2026 at 02:54:56PM -0700, Suren Baghdasaryan wrote:
> > > From: Dave Hansen <dave.hansen@linux.intel.com>
> > >
> > > tl;dr: lock_vma_under_rcu() is already a trylock. No need to do both
> > > it and mmap_read_trylock().
> > >
> > > Long Version:
> > >
> > > == Background ==
> > >
> > > Historically, binder used an mmap_read_trylock() in its shrinker code.
> > > This ensures that reclaim is not blocked on an mmap_lock. Commit
> > > 95bc2d4a9020 ("binder: use per-vma lock in page reclaiming") added
> > > support for the per-VMA lock, but left mmap_read_trylock() as a
> > > fallback.
> > >
> > > This was presumably because the per-VMA locking can fail for several
> > > reasons and most (all?) lock_vma_under_rcu() callers have a fallback
> > > to mmap_read_trylock().
> > >
> > > == Problem ==
> > >
> > > The fallback is not worth the complexity here. lock_vma_under_rcu() is
> > > essentially already a non-blocking trylock. The main reason it fails
> > > is also the reason mmap_read_trylock() fails: something is holding
> > > mmap_write_lock().
> > >
> > > The only remedy for a collision with mmap_write_lock() is to wait,
> > > which this code can not do. So the "fallback" after
> > > lock_vma_under_rcu() failure is not really a fallback: it is really
> > > likely to just be retrying in vain. That retry in an of itself isn't
> > > horrible. But it adds complexity.
> > >
> > > == Solution ==
> > >
> > > Now that per-VMA locks are universally available, lock_vma_under_rcu()
> > > will not persistently fail. Rely on it alone and simplify the code.
> > >
> > > Full disclosure: I originally tried to do this with
> > > lock_vma_under_rcu_wait(), but it did not fit well with the mmap_lock
> > > trylock semantics. Claude caught this in a review and suggested the
> > > approach in this path. It seemed sane to me. So, Suggesed-by: Claude,
> > > I guess.
> > >
> > > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > > Cc: Vlastimil Babka <vbabka@kernel.org>
> > > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > > Cc: linux-mm@kvack.org
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Arve Hjønnevåg <arve@android.com>
> > > Cc: Todd Kjos <tkjos@android.com>
> > > Cc: Christian Brauner <christian@brauner.io>
> > > Cc: Carlos Llamas <cmllamas@google.com>
> > > Cc: Alice Ryhl <aliceryhl@google.com>
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: David Ahern <dsahern@kernel.org>
> > > Cc: netdev@vger.kernel.org
> > > ---
> > >  drivers/android/binder_alloc.c | 29 +++++++++++++++--------------
> > >  1 file changed, 15 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> > > index e4488ad86a65..84104ba04e30 100644
> > > --- a/drivers/android/binder_alloc.c
> > > +++ b/drivers/android/binder_alloc.c
> > > @@ -1142,7 +1142,6 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
> > >  	struct vm_area_struct *vma;
> > >  	struct page *page_to_free;
> > >  	unsigned long page_addr;
> > > -	int mm_locked = 0;
> > >  	size_t index;
> > >
> > >  	if (!mmget_not_zero(mm))
> > > @@ -1151,14 +1150,20 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
> > >  	index = mdata->page_index;
> > >  	page_addr = alloc->vm_start + index * PAGE_SIZE;
> > >
> > > -	/* attempt per-vma lock first */
> > > +	/*
> > > +	 * Attempt per-vma lock. This is essentially a
> > > +	 * "trylock". It can fail even if the VMA exists
> > > +	 * for 'page_addr'.
> > > +	 */
> >
> > This makes me wonder whether lock_vma_under_rcu() should really become
> > vma_trylock() at some point in time? :)
> >
> > Or at least have 'trylock' in the name.
> >
> > >  	vma = lock_vma_under_rcu(mm, page_addr);
> > >  	if (!vma) {
> > > -		/* fall back to mmap_lock */
> > > -		if (!mmap_read_trylock(mm))
> > > -			goto err_mmap_read_lock_failed;
> > > -		mm_locked = 1;
> > > -		vma = vma_lookup(mm, page_addr);
> > > +		/*
> > > +		 * If the vma exists, we can't continue because we cannot
> > > +		 * remove the page from the vma. However, if the vma was
> > > +		 * unmapped, it's okay to continue.
> > > +		 */
> > > +		if (binder_alloc_is_mapped(alloc))
> > > +			goto err_vma_lock_failed;
> >
> > Hmm, it seems a bit odd to me that you also have:
> >
> > 	if (vma && !binder_alloc_is_mapped(alloc))
> > 		goto err_invalid_vma;
> >
> > Below?
> >
> > So you have:
> >
> > Before:
> >
> >                         	|binder_alloc_is_mapped()?
> > 				|yes   	no
> > 			--------|-----------------
> > 	vma is mapped?	yes	|OK	abort
> > 			no	|OK	OK
> >
> > Now:
> >
> >                         	|binder_alloc_is_mapped()?
> > 				|yes   	no
> > 			--------|-----------------
> > 	vma is mapped? maybe	|abort	OK
> > 			yes	|OK	abort
> > 			no	|OK	OK
> >
> > The 'maybe' is because the VMA trylock failed.
> >
> > So the issue is you might have a case where the VMA _is_ mapped but
> > !binder_alloc_is_mapped(), which previously aborted because of the vma &&
> > !binder_alloc_is_mapped() check.
> >
> > It seems like:
> >
> > 	/*
> > 	 * Since a binder_alloc can only be mapped once, we ensure
> > 	 * the vma corresponds to this mapping by checking whether
> > 	 * the binder_alloc is still mapped.
> > 	 */
> > 	if (vma && !binder_alloc_is_mapped(alloc))
> > 		goto err_invalid_vma;
> >
> > Is testing for a specific scenario 'we found a VMA but it turns out it's
> > invalid' and aborting if so.
> >
> > So either this check should be removed or you should uncondtionally abort if
> > !vma I think?
>
> This check is quite important and can't just be removed. If you remove
> it, there's no guarantee that the vma is one created by Binder. It might
> as well be a VMA from a completely different driver/subsystem, which we
> definitely should not be invoking zap_vma_range() on.
>
> In this case, Binder rules out that scenario by saying that the VMA
> can be mapped exactly once, and once you unmap it or remap it or
> anything like that, Binder sets the 'is_mapped' boolean to false and
> refuses to perform any further VMA operations for this binder fd.
>
> So really this function needs to deal with three scenarios:
>
> 1. The original Binder VMA is still there and we acquired its lock.
> 2. The original Binder VMA is still there, but we could not acquire its
>    lock.
> 3. The original Binder VMA is gone.
>    - Subcase one: there is no VMA at that location anymore.
>    - Subcase two: there is now another unrelated VMA at that location.
>
> In scenario one we can proceed with zapping the page. In scenario two we
> must return LRU_SKIP because we are unable to zap the page. As for
> scenario three, it's a scenario that is possible, but not something that
> needs to work well. It doesn't matter that much whether such pages can
> be reclaimed by the shrinker because userspace shouldn't create this
> scenario to begin with.
>
> But you are right that we currently handle scenario 3 inconsistently. We
> handle subcase one by having the shrinker proceed to free the page, and
> just skip the zap_vma_range() call. And we handle subcase two by having
> the shrinker return LRU_SKIP. Either behavior is acceptable to me, but I
> agree that being consistent would be better.
>
> So what we could do is to remove this check, but then later wrap
> zap_vma_range() in an 'is_mapped' check like this:
>
> 	if (vma && binder_alloc_is_mapped(alloc)) {
> 		zap_vma_range(vma, page_addr, PAGE_SIZE);
> 	}
>
> This way we only LRU_SKIP in case two, and always handle case 3 by
> removing the page from alloc->pages without touching the VMA.

Ah sorry I replied to Suren not noticing you'd responded :)

Thanks for the explanation, much appreciated! Makes sense.

I'm being OCD about it (occupational hazard in kernel development :) but the
inconsitency was concerning there. And agreed it's an edge case.

Suren - that good for the respin?

>
> Alice

--
Cheers, Lorenzo
