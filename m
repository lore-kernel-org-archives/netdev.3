Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39233AC0E9;
	Tue,  4 Aug 2026 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834530; cv=none; b=GZAJp7zTvvswix2Uw2d1FFFQcvG5oldDguyWz3T2vlZtgHMcqA5bWHrU8jnhsUM7Rfurr/Q7/wiSzQwuulSj6lU83jr/4PG2zAFNtFMPAUPGHDNBr1VgmSdTqLkU5M+5yF+9wavPV3KgXb+/FyKEZSBs8kbahAyD29jp7T2Y5W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834530; c=relaxed/simple;
	bh=GRY1Ds3A8MFWd4d0EtWx+pcGpVVdpswUeJqyoMzzfFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDW3SyhNpMcuzk7orBhbNOYgsDaDMD3bDqNfc623JP9FSRvB6OIiG4ufl6DgnHur1b2KvqXo3HXNHasTDuu36SLG3YWtIpvSPxup1K1G0XNvzkXB7TzB33OhTJ9/cuoVvPNva9DGgQdYCOATzjqf2L9+x5yGLBuPT/yz0+LKUVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO4M/Yzb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO4M/Yzb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC6E1F000E9;
	Tue,  4 Aug 2026 09:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785834528;
	bh=ghBwXEKKsascxtgo5NYN/flgQoV8CthULaYum+SUvio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hO4M/Yzbf533RydwxUx8sqbaepXbrR8okDyPy92W/TVXS9xMvVRbC+ly9wFja7anP
	 K2T3tfniAmzxaa+tbg7ZxlUDL8qXdtZGLDebX/s7kr3uteb3JIyDpcunNXI7H5cHP4
	 fCcYRy/XD9I+qotWvuRjPmzUR59Vs9DrDwzVWlB9q4EfjL1VbZimVieywq4dL78cJg
	 oZQgd8O9WSMhgXCrU/uh4qfzmVfUT1cIhfHzzGge2u7MsJO8UyyqbolULxKK3QnRKu
	 +oLza8u1+40F0zlINmHfLQaDnuWOf5sV6LYYOzhTsXSdFkbybgUVZSpdUC/tvrO8Zq
	 feUmg+UMcUSXg==
Date: Tue, 4 Aug 2026 10:08:29 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, david@redhat.com, willy@infradead.org, shakeel.butt@linux.dev, 
	vbabka@kernel.org, jannh@google.com, aliceryhl@google.com, arve@android.com, 
	cmllamas@google.com, christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/5] binder: Make shrinker rely solely on per-VMA lock
Message-ID: <anGpvW6XwgWH1t6D@lucifer>
References: <20260802215459.2769283-1-surenb@google.com>
 <20260802215459.2769283-3-surenb@google.com>
 <anByp6uVW77uofKx@lucifer>
 <CAJuCfpHPcE0=7825xiusBN0MmCp1hrnsDuYrfTKwGM43ozmmOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHPcE0=7825xiusBN0MmCp1hrnsDuYrfTKwGM43ozmmOQ@mail.gmail.com>

On Mon, Aug 03, 2026 at 11:31:14AM -0700, Suren Baghdasaryan wrote:
> On Mon, Aug 3, 2026 at 4:10 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >
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
> > >       struct vm_area_struct *vma;
> > >       struct page *page_to_free;
> > >       unsigned long page_addr;
> > > -     int mm_locked = 0;
> > >       size_t index;
> > >
> > >       if (!mmget_not_zero(mm))
> > > @@ -1151,14 +1150,20 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
> > >       index = mdata->page_index;
> > >       page_addr = alloc->vm_start + index * PAGE_SIZE;
> > >
> > > -     /* attempt per-vma lock first */
> > > +     /*
> > > +      * Attempt per-vma lock. This is essentially a
> > > +      * "trylock". It can fail even if the VMA exists
> > > +      * for 'page_addr'.
> > > +      */
> >
> > This makes me wonder whether lock_vma_under_rcu() should really become
> > vma_trylock() at some point in time? :)
> >
> > Or at least have 'trylock' in the name.
>
> Makes sense. I think I'll postpone renames until after the series are
> merged. Don't want to mix too many changes together.

Yeah absolutely :) this isn't for this series, just thinking out loud!

>
> >
> > >       vma = lock_vma_under_rcu(mm, page_addr);
> > >       if (!vma) {
> > > -             /* fall back to mmap_lock */
> > > -             if (!mmap_read_trylock(mm))
> > > -                     goto err_mmap_read_lock_failed;
> > > -             mm_locked = 1;
> > > -             vma = vma_lookup(mm, page_addr);
> > > +             /*
> > > +              * If the vma exists, we can't continue because we cannot
> > > +              * remove the page from the vma. However, if the vma was
> > > +              * unmapped, it's okay to continue.
> > > +              */
> > > +             if (binder_alloc_is_mapped(alloc))
> > > +                     goto err_vma_lock_failed;
> >
> > Hmm, it seems a bit odd to me that you also have:
> >
> >         if (vma && !binder_alloc_is_mapped(alloc))
> >                 goto err_invalid_vma;
> >
> > Below?
> >
> > So you have:
> >
> > Before:
> >
> >                                 |binder_alloc_is_mapped()?
> >                                 |yes    no
> >                         --------|-----------------
> >         vma is mapped?  yes     |OK     abort
> >                         no      |OK     OK
> >
> > Now:
> >
> >                                 |binder_alloc_is_mapped()?
> >                                 |yes    no
> >                         --------|-----------------
> >         vma is mapped? maybe    |abort  OK
> >                         yes     |OK     abort
> >                         no      |OK     OK
> >
> > The 'maybe' is because the VMA trylock failed.
>
> The case you are considering is lock_vma_under_rcu() failed for some
> reason other than lock contention (say seqno overflow). In that case

Well it could also be due to lock contention right?

> we get vma==NULL and binder_alloc_is_mapped() is called without any
> lock (VMA or mmap lock) being held. I'm not sure if this is a real
> problem since I see other places calling binder_alloc_is_mapped()
> without locking. Alice, Carlos, is this a problem?

There seems to be a contradiction here though in that - the
binder_alloc_is_mapped() call below is predicated on vma != NULL.

But here lock contention could mean the VMA is mapped, but then
binder_alloc_is_mapped() returns false but you still proceed.

Anyway I don't really understand the semantics here so will leave it to you guys
as to whether this is actually an issue :)

>
> >
> > So the issue is you might have a case where the VMA _is_ mapped but
> > !binder_alloc_is_mapped(), which previously aborted because of the vma &&
> > !binder_alloc_is_mapped() check.
> >
> > It seems like:
> >
> >         /*
> >          * Since a binder_alloc can only be mapped once, we ensure
> >          * the vma corresponds to this mapping by checking whether
> >          * the binder_alloc is still mapped.
> >          */
> >         if (vma && !binder_alloc_is_mapped(alloc))
> >                 goto err_invalid_vma;
> >
> > Is testing for a specific scenario 'we found a VMA but it turns out it's
> > invalid' and aborting if so.
> >
> > So either this check should be removed or you should uncondtionally abort if
> > !vma I think?
>
> I think this check is fine because it basically checks
> binder_alloc_is_mapped() after stabilizing the address range.
> Unconditionally aborting if !vma would prevent us from freeing the
> page if the VMA was already unmapped. The ultimate question is whether
> we can rely on binder_alloc_is_mapped() alone when freeing that page.
> IOW, VMA might still be in the VMA tree but
> binder_alloc_is_mapped()==false, can we free the page?
>

Yeah.

> >
> >
> > >       }
> > >
> > >       if (!mutex_trylock(&alloc->mutex))
> > > @@ -1191,9 +1196,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
> > >       }
> > >
> > >       mutex_unlock(&alloc->mutex);
> > > -     if (mm_locked)
> > > -             mmap_read_unlock(mm);
> > > -     else
> > > +     if (vma)
> > >               vma_end_read(vma);
> > >       mmput_async(mm);
> > >       binder_free_page(page_to_free);
> > > @@ -1203,11 +1206,9 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
> > >  err_invalid_vma:
> > >       mutex_unlock(&alloc->mutex);
> > >  err_get_alloc_mutex_failed:
> > > -     if (mm_locked)
> > > -             mmap_read_unlock(mm);
> > > -     else
> > > +     if (vma)
> > >               vma_end_read(vma);
> > > -err_mmap_read_lock_failed:
> > > +err_vma_lock_failed:
> > >       mmput_async(mm);
> > >  err_mmget:
> > >       return LRU_SKIP;
> > > --
> > > 2.55.0.508.g3f0d502094-goog
> > >
> >
> > --
> > Cheers, Lorenzo

--
Cheers, Lorenzo
