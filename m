Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BC3440A2F
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834265; cv=none; b=GX211yo9AymzhIzX72ZNqJT77VmMv8oMFqfxIpJPtcPjMVpLSmoFDW2HYG/FjOWu0iCzJi19P3/5DMXB9q0pZqFr3GRMnMM9qz7SPOJtcwFa0lfR7m47sNZIajNdgIPsx5SsxpwDXYmAaIOXPbZDrPIr5pymbWUiagLo6FG0nso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834265; c=relaxed/simple;
	bh=8XABnamO0cA+R3i6tSaTIlsjAArb3FCfcPW3JE3axiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xjyc1bJQC5Qka+/Y/EbtYm0Yfkf5z+68oQgnG5hoolXiGG4xputS3kJfIw01UPbFpjqzhC14ntjsb8MQemlyjy7W0p2PNxSaV9JEgPGFDH/p8bVim3B/PbbHuXR6Gak5g50i10yNtxM9JkvFTY/qpSXg0PVwImVSAfLIAyNOgl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PStdNIKN; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PStdNIKN"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4954a93c565so17423295e9.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 02:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785834261; x=1786439061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xiOCcGsrwYkM3hLltssS79+3DdkwzH7Eyceak+uReIg=;
        b=PStdNIKNFdiOkXkZCMpZxZs9M+qP8rtmKwEZJFKN57VuGm7pM7ZjNHZTPck44SYf4W
         bBVpRD2MZRkwslq0cPbihcbmRDVixqezzaPMKJhaeNnNfttLRMKt1KuO5pPiFxlpTk8d
         +IVrGqk8vimSTodKurmqhAjoq21j9h31bfp9Ph6DXIiHLjaYFg0OucWOvQGfTthlBknG
         pIWCuuceYLuaQETitQDaIJCmkw2Ehk203c2szszmeiE9ZBqfg7EmJfBwpaOsZ4BPzB+I
         i1X8tbgh8gUeGNPvOoqqxxHw9HoJBtNB5roy1nV8Rd7R0FW2ln8qDAFXVblRgRfP3mnP
         //Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785834261; x=1786439061;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xiOCcGsrwYkM3hLltssS79+3DdkwzH7Eyceak+uReIg=;
        b=R6BPAtENOjmS7QLoKMlICRM8XjhvZz1qKwFJ1c7DX6ahGdweCduz//qcCr9ty5HpWH
         GnD2to30AVkTB8d109YjzFKyqyBPvCfLel4AlENmdIH9yx8Du6gWVFyIHk2DgqG8FhZt
         eIg80tJ93aot6aaEtJjHb2+3BD1V+N9mL0vDBPph91qLQtnpgB5QzAaYTQeu/C9RkhHW
         ZvDy2yeZaCPldYKL1Nxg5xpNvfxVZl8a7pirq8IM/DCsWloQ3NHv7CQrbY1s/WJpRNeQ
         EzFcLCeOk+0VXSCqwwqRRrpzWToNsroQZ0GFY2m+gbklJea1rdg0jypW67e/IiI8TWFi
         pXIg==
X-Forwarded-Encrypted: i=1; AHgh+RoCTZXwNw80DEKpMczFyBjS7nhgSizke8Sf64Rq8cmA5kM502GEBE8tCsyymJL/6xy3WgpBLXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwwV0qzv9z1bLBGL+1w5kx+HiAHhp2Kp6KWu7zPZqQz9hpmGf6
	9EWVo8ILVM+7IDy+4Z0tPz7c4XanE/Q2DJzuT5bL0RRz+Ru9N+pRqrFhIp7/uPpoDLR9bA32mWY
	qfQwFrZJYyneS6QOkXA==
X-Received: from wmf3.prod.google.com ([2002:a05:600c:2283:b0:496:c1f3:e8f2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35c1:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-499484a820emr122469305e9.9.1785834260998;
 Tue, 04 Aug 2026 02:04:20 -0700 (PDT)
Date: Tue, 4 Aug 2026 09:04:20 +0000
In-Reply-To: <anByp6uVW77uofKx@lucifer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-3-surenb@google.com>
 <anByp6uVW77uofKx@lucifer>
Message-ID: <anGrFIYiPhjxWSkD@google.com>
Subject: Re: [PATCH v3 2/5] binder: Make shrinker rely solely on per-VMA lock
From: Alice Ryhl <aliceryhl@google.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, david@redhat.com, 
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org, 
	jannh@google.com, arve@android.com, cmllamas@google.com, christian@brauner.io, 
	tkjos@android.com, dsahern@kernel.org, davem@davemloft.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2026 at 12:10:21PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Sun, Aug 02, 2026 at 02:54:56PM -0700, Suren Baghdasaryan wrote:
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> >
> > tl;dr: lock_vma_under_rcu() is already a trylock. No need to do both
> > it and mmap_read_trylock().
> >
> > Long Version:
> >
> > =3D=3D Background =3D=3D
> >
> > Historically, binder used an mmap_read_trylock() in its shrinker code.
> > This ensures that reclaim is not blocked on an mmap_lock. Commit
> > 95bc2d4a9020 ("binder: use per-vma lock in page reclaiming") added
> > support for the per-VMA lock, but left mmap_read_trylock() as a
> > fallback.
> >
> > This was presumably because the per-VMA locking can fail for several
> > reasons and most (all?) lock_vma_under_rcu() callers have a fallback
> > to mmap_read_trylock().
> >
> > =3D=3D Problem =3D=3D
> >
> > The fallback is not worth the complexity here. lock_vma_under_rcu() is
> > essentially already a non-blocking trylock. The main reason it fails
> > is also the reason mmap_read_trylock() fails: something is holding
> > mmap_write_lock().
> >
> > The only remedy for a collision with mmap_write_lock() is to wait,
> > which this code can not do. So the "fallback" after
> > lock_vma_under_rcu() failure is not really a fallback: it is really
> > likely to just be retrying in vain. That retry in an of itself isn't
> > horrible. But it adds complexity.
> >
> > =3D=3D Solution =3D=3D
> >
> > Now that per-VMA locks are universally available, lock_vma_under_rcu()
> > will not persistently fail. Rely on it alone and simplify the code.
> >
> > Full disclosure: I originally tried to do this with
> > lock_vma_under_rcu_wait(), but it did not fit well with the mmap_lock
> > trylock semantics. Claude caught this in a review and suggested the
> > approach in this path. It seemed sane to me. So, Suggesed-by: Claude,
> > I guess.
> >
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Vlastimil Babka <vbabka@kernel.org>
> > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > Cc: linux-mm@kvack.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> > Cc: Todd Kjos <tkjos@android.com>
> > Cc: Christian Brauner <christian@brauner.io>
> > Cc: Carlos Llamas <cmllamas@google.com>
> > Cc: Alice Ryhl <aliceryhl@google.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: David Ahern <dsahern@kernel.org>
> > Cc: netdev@vger.kernel.org
> > ---
> >  drivers/android/binder_alloc.c | 29 +++++++++++++++--------------
> >  1 file changed, 15 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_al=
loc.c
> > index e4488ad86a65..84104ba04e30 100644
> > --- a/drivers/android/binder_alloc.c
> > +++ b/drivers/android/binder_alloc.c
> > @@ -1142,7 +1142,6 @@ enum lru_status binder_alloc_free_page(struct lis=
t_head *item,
> >  	struct vm_area_struct *vma;
> >  	struct page *page_to_free;
> >  	unsigned long page_addr;
> > -	int mm_locked =3D 0;
> >  	size_t index;
> >
> >  	if (!mmget_not_zero(mm))
> > @@ -1151,14 +1150,20 @@ enum lru_status binder_alloc_free_page(struct l=
ist_head *item,
> >  	index =3D mdata->page_index;
> >  	page_addr =3D alloc->vm_start + index * PAGE_SIZE;
> >
> > -	/* attempt per-vma lock first */
> > +	/*
> > +	 * Attempt per-vma lock. This is essentially a
> > +	 * "trylock". It can fail even if the VMA exists
> > +	 * for 'page_addr'.
> > +	 */
>=20
> This makes me wonder whether lock_vma_under_rcu() should really become
> vma_trylock() at some point in time? :)
>=20
> Or at least have 'trylock' in the name.
>=20
> >  	vma =3D lock_vma_under_rcu(mm, page_addr);
> >  	if (!vma) {
> > -		/* fall back to mmap_lock */
> > -		if (!mmap_read_trylock(mm))
> > -			goto err_mmap_read_lock_failed;
> > -		mm_locked =3D 1;
> > -		vma =3D vma_lookup(mm, page_addr);
> > +		/*
> > +		 * If the vma exists, we can't continue because we cannot
> > +		 * remove the page from the vma. However, if the vma was
> > +		 * unmapped, it's okay to continue.
> > +		 */
> > +		if (binder_alloc_is_mapped(alloc))
> > +			goto err_vma_lock_failed;
>=20
> Hmm, it seems a bit odd to me that you also have:
>=20
> 	if (vma && !binder_alloc_is_mapped(alloc))
> 		goto err_invalid_vma;
>=20
> Below?
>=20
> So you have:
>=20
> Before:
>=20
>                         	|binder_alloc_is_mapped()?
> 				|yes   	no
> 			--------|-----------------
> 	vma is mapped?	yes	|OK	abort
> 			no	|OK	OK
>=20
> Now:
>=20
>                         	|binder_alloc_is_mapped()?
> 				|yes   	no
> 			--------|-----------------
> 	vma is mapped? maybe	|abort	OK
> 			yes	|OK	abort
> 			no	|OK	OK
>=20
> The 'maybe' is because the VMA trylock failed.
>=20
> So the issue is you might have a case where the VMA _is_ mapped but
> !binder_alloc_is_mapped(), which previously aborted because of the vma &&
> !binder_alloc_is_mapped() check.
>=20
> It seems like:
>=20
> 	/*
> 	 * Since a binder_alloc can only be mapped once, we ensure
> 	 * the vma corresponds to this mapping by checking whether
> 	 * the binder_alloc is still mapped.
> 	 */
> 	if (vma && !binder_alloc_is_mapped(alloc))
> 		goto err_invalid_vma;
>=20
> Is testing for a specific scenario 'we found a VMA but it turns out it's
> invalid' and aborting if so.
>=20
> So either this check should be removed or you should uncondtionally abort=
 if
> !vma I think?

This check is quite important and can't just be removed. If you remove
it, there's no guarantee that the vma is one created by Binder. It might
as well be a VMA from a completely different driver/subsystem, which we
definitely should not be invoking zap_vma_range() on.

In this case, Binder rules out that scenario by saying that the VMA
can be mapped exactly once, and once you unmap it or remap it or
anything like that, Binder sets the 'is_mapped' boolean to false and
refuses to perform any further VMA operations for this binder fd.

So really this function needs to deal with three scenarios:

1. The original Binder VMA is still there and we acquired its lock.
2. The original Binder VMA is still there, but we could not acquire its
   lock.
3. The original Binder VMA is gone.
   - Subcase one: there is no VMA at that location anymore.
   - Subcase two: there is now another unrelated VMA at that location.

In scenario one we can proceed with zapping the page. In scenario two we
must return LRU_SKIP because we are unable to zap the page. As for
scenario three, it's a scenario that is possible, but not something that
needs to work well. It doesn't matter that much whether such pages can
be reclaimed by the shrinker because userspace shouldn't create this
scenario to begin with.

But you are right that we currently handle scenario 3 inconsistently. We
handle subcase one by having the shrinker proceed to free the page, and
just skip the zap_vma_range() call. And we handle subcase two by having
the shrinker return LRU_SKIP. Either behavior is acceptable to me, but I
agree that being consistent would be better.

So what we could do is to remove this check, but then later wrap
zap_vma_range() in an 'is_mapped' check like this:

	if (vma && binder_alloc_is_mapped(alloc)) {
		zap_vma_range(vma, page_addr, PAGE_SIZE);
	}

This way we only LRU_SKIP in case two, and always handle case 3 by
removing the page from alloc->pages without touching the VMA.

Alice
