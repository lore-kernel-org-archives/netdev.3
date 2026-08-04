Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB4545C6F5
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855305; cv=pass; b=nx9p0XP6sEwPCjY2JARLH/NiWm8D2VAH195EMp/C54D/VyRCPVnyJ4d3jWDphSqv0E+I15ydgOw9Uo2/sFeJ+0aZ2UqLfM2leX06xcLcYgh61zBJozsY14YdIsTOSFRAAvtNR+lGtdIy3noYug3dHm8iIBWz4iLraWeDPohpifI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855305; c=relaxed/simple;
	bh=cpxNQcwasAEAhYkIO7yKqk6Q9C2sQewJRhu95nEo6pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxskZB5pwlDijjJck7tQIlhvssxKmbWwjEbhKmVuTdZWZ1jY7hPhghBtMuczLzX/R6Bpv+e9E3S52+Rw041tL34zSdjeFWiNfX3mYpCR+0+SCJUYWYAT1QjgmbWrXaJA2I8Z31zBryvWxRSM4uRhyA9TDQJQo9rwKD6EYbyh4Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cPBdy4JV; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPBdy4JV"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c01c79467so351541cf.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 07:55:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785855300; cv=none;
        d=google.com; s=arc-20260327;
        b=CmNs0lNawQuG3RsIWIVyHsDCHP3XX7w+SA0HJhkRmCLafru8zAhaN02WwUNJ0DlM9C
         soS0ClhC3F2hbBA/CzJjinxawdzKMitgvf1sBG9uW4UqC0F6OJ11FRCi6ia0ZeqsSc+x
         iFVJ48IO+3sdgOqATfFs/sSpA6qUIjrPdLiRmYVT7HRkM8kcuXerU7RL7Ol5BhAwsn/4
         1dKr7VbisZnH4xJdnd8b9P53qWtdG+XsgQND+9BkKyRjZb2H1p6vR0IsULFw3y6JgQAX
         XhbpJihkd8Az5T07qTh43zLSxJIlbjme5/kBWoBj9EK+cae+oYYSiYj1Cf8T8uxn6mGy
         0mdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v05uFFs4hQG6LmTfuKA4XeVgXPR5RZeVv3+eUBjSWnk=;
        fh=5JnHiHHGH3hjmO3HhunJYu8Bi7YyqI2yZhK/a7+f61A=;
        b=MB4XdaXHvwBPlIF1k1qdBIEgujT/shh2kHVshyhJCad1UUPp2onJzH6NW9WiF3rX54
         H3jNmgdsMEi6tdRM9ajx0dw/fm6++wfr+RJBzoI5B3Vd0YefOfiMYLYUGWuslSq7rYBU
         KQXty0p7X972wiWos/D1Vmemo6f5XY+ilA4lfPSZqCmz10EcDPr1k3dm+Ci0t5FdYyUd
         tF6MovpcXaphdaVI4WsBme8sBI7P9K5t4rDAtk6scrFsOw2ssea292JYTgADR+30JN2c
         CEIE+QHkyTglT5syvKzCtens3SzydxVNglpZAvz3sU4pDIxfVKS4jPhlpQNkBBS+2KxV
         LELA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785855300; x=1786460100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v05uFFs4hQG6LmTfuKA4XeVgXPR5RZeVv3+eUBjSWnk=;
        b=cPBdy4JVlvd92iEBhmMK/wZNE0hALFWP0sdk7TUr7owHlLSeFMxcYK7NiwvxMm5E9H
         NEeHi2AK5zXAljtCBmYzfZrTZaSksPy/ZRKDy+WO1BEfV+6FTH8NoI2IbkJqHK42Z0cx
         Q9eo6JYhM2JzecHrZfGx4yCxbs7BvwVjT65uWKjz+/40TN+JLZH7/MGzl1gTpHtAQ7mQ
         fI3awxPA+PadcFey++lpg7hdGtNx9lgu+OJg0mBYc96OgKhmzgBX9IAexQ0aCTuh6xgu
         t5YZf/nAtEqmC62CE3dvOQhGr1OhMbnqzME8RnjNbkUWvr9vW4rjDTc0BcMinvmd3PMe
         jDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785855300; x=1786460100;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v05uFFs4hQG6LmTfuKA4XeVgXPR5RZeVv3+eUBjSWnk=;
        b=hRWbAHY3LHCO3NALupVCUY39C0PLjRzDaAlRFhUmestcADWCwHLwu6ICxdSxF4iSlf
         VfFp7oZ15wgM8H2MvwPpXlD5fzZlnNaQ/8QdmScrf+E2h19IzJbokiOTpFcZhE/5pxBg
         ElqCoKo7wMwbi55rm/LTWddjk9VCxq+w765qak8eVwVSgxXiizOjNrQWyoxBuX/lnUXR
         gQSgALb3cU7KYOxRhpnxpfAa+wLJSXYO4eOs50qFshh65Guxp8J4OLtYt57GBQpD488I
         2NG89gq4p4LWRsDMZMqU1g366glROIakvH4hZp2zoBBJLpEK1ojW/VXhPZnOWaiYr/Vt
         /DaA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/Je/Eynh26jSW7YxUxNLuakjo6/HvaTNkr/+pa/ifnHEa8WxTrW9fD62at8oyk6Ol0ZWTEwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IYWUeBITrDWox6dHLP2FJRP5kPIo08HjSLimjZe1dKNRHnT3
	RAZCsYvBzqW3se517KiH1X9kgAU2YIpzrSGxApvUMAnQs3NQnq2N8igtfe5jHyaJRGKCtHTw/iQ
	JmqalxOtlaxZpxIgTkHMhSqL9L3HOshtv7D4r1ATb
X-Gm-Gg: AR+sD11y0oCRCaIDflBNiuC+zjTWFMFRW4pVuXlnQvbMJOEPm8hv36OMeaEA2Wmn2EP
	q7sN1QON9zzyFG92sIc+qHZMjXIzuEVHB8z1QPcVx+ragf3a0BCkWxc758CCODe84Z3Hs/SNG3k
	mMgE8jfbN5tJGy+8Eju+Y9c+ZkXVvc/jXH3czJL5vn/SvReev9SA7a3GnPtSMbOI8YL8bBPNuMq
	mKwZCrXdo+moaMejyUoW/mO6nlRe2UX8walaP4Kfiraax2PsYd/KMIZlgZFiC4DHoRWj5Ylkew6
	eH8PuLRzoEMEbkEC/vhZDo37aIH/5qoYOdB7D0bMOrp8XPXlhZUsrQeux20SlnjigghwlI26cTQ
	=
X-Received: by 2002:a05:622a:2612:b0:52b:806e:2633 with SMTP id
 d75a77b69052e-52ce3f3aa80mr2415961cf.1.1785855299538; Tue, 04 Aug 2026
 07:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-3-surenb@google.com>
 <anByp6uVW77uofKx@lucifer> <anGrFIYiPhjxWSkD@google.com> <anGsYeT0zfhxXgNI@lucifer>
In-Reply-To: <anGsYeT0zfhxXgNI@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 4 Aug 2026 07:54:46 -0700
X-Gm-Features: AUfX_myVVWOmPQ2KcnkIumR8CXhkBduyP-MUCTNvy2LReepZgBop01C4DsWPzGg
Message-ID: <CAJuCfpFh+06V8yTLiD4kMHjp8uFV2C-9NMZGZuikhGp81sV6LQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] binder: Make shrinker rely solely on per-VMA lock
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, david@redhat.com, 
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org, 
	jannh@google.com, arve@android.com, cmllamas@google.com, christian@brauner.io, 
	tkjos@android.com, dsahern@kernel.org, davem@davemloft.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 2:12=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> On Tue, Aug 04, 2026 at 09:04:20AM +0000, Alice Ryhl wrote:
> > On Mon, Aug 03, 2026 at 12:10:21PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > On Sun, Aug 02, 2026 at 02:54:56PM -0700, Suren Baghdasaryan wrote:
> > > > From: Dave Hansen <dave.hansen@linux.intel.com>
> > > >
> > > > tl;dr: lock_vma_under_rcu() is already a trylock. No need to do bot=
h
> > > > it and mmap_read_trylock().
> > > >
> > > > Long Version:
> > > >
> > > > =3D=3D Background =3D=3D
> > > >
> > > > Historically, binder used an mmap_read_trylock() in its shrinker co=
de.
> > > > This ensures that reclaim is not blocked on an mmap_lock. Commit
> > > > 95bc2d4a9020 ("binder: use per-vma lock in page reclaiming") added
> > > > support for the per-VMA lock, but left mmap_read_trylock() as a
> > > > fallback.
> > > >
> > > > This was presumably because the per-VMA locking can fail for severa=
l
> > > > reasons and most (all?) lock_vma_under_rcu() callers have a fallbac=
k
> > > > to mmap_read_trylock().
> > > >
> > > > =3D=3D Problem =3D=3D
> > > >
> > > > The fallback is not worth the complexity here. lock_vma_under_rcu()=
 is
> > > > essentially already a non-blocking trylock. The main reason it fail=
s
> > > > is also the reason mmap_read_trylock() fails: something is holding
> > > > mmap_write_lock().
> > > >
> > > > The only remedy for a collision with mmap_write_lock() is to wait,
> > > > which this code can not do. So the "fallback" after
> > > > lock_vma_under_rcu() failure is not really a fallback: it is really
> > > > likely to just be retrying in vain. That retry in an of itself isn'=
t
> > > > horrible. But it adds complexity.
> > > >
> > > > =3D=3D Solution =3D=3D
> > > >
> > > > Now that per-VMA locks are universally available, lock_vma_under_rc=
u()
> > > > will not persistently fail. Rely on it alone and simplify the code.
> > > >
> > > > Full disclosure: I originally tried to do this with
> > > > lock_vma_under_rcu_wait(), but it did not fit well with the mmap_lo=
ck
> > > > trylock semantics. Claude caught this in a review and suggested the
> > > > approach in this path. It seemed sane to me. So, Suggesed-by: Claud=
e,
> > > > I guess.
> > > >
> > > > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > > > Cc: Vlastimil Babka <vbabka@kernel.org>
> > > > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > > > Cc: linux-mm@kvack.org
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> > > > Cc: Todd Kjos <tkjos@android.com>
> > > > Cc: Christian Brauner <christian@brauner.io>
> > > > Cc: Carlos Llamas <cmllamas@google.com>
> > > > Cc: Alice Ryhl <aliceryhl@google.com>
> > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > Cc: David Ahern <dsahern@kernel.org>
> > > > Cc: netdev@vger.kernel.org
> > > > ---
> > > >  drivers/android/binder_alloc.c | 29 +++++++++++++++--------------
> > > >  1 file changed, 15 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binde=
r_alloc.c
> > > > index e4488ad86a65..84104ba04e30 100644
> > > > --- a/drivers/android/binder_alloc.c
> > > > +++ b/drivers/android/binder_alloc.c
> > > > @@ -1142,7 +1142,6 @@ enum lru_status binder_alloc_free_page(struct=
 list_head *item,
> > > >   struct vm_area_struct *vma;
> > > >   struct page *page_to_free;
> > > >   unsigned long page_addr;
> > > > - int mm_locked =3D 0;
> > > >   size_t index;
> > > >
> > > >   if (!mmget_not_zero(mm))
> > > > @@ -1151,14 +1150,20 @@ enum lru_status binder_alloc_free_page(stru=
ct list_head *item,
> > > >   index =3D mdata->page_index;
> > > >   page_addr =3D alloc->vm_start + index * PAGE_SIZE;
> > > >
> > > > - /* attempt per-vma lock first */
> > > > + /*
> > > > +  * Attempt per-vma lock. This is essentially a
> > > > +  * "trylock". It can fail even if the VMA exists
> > > > +  * for 'page_addr'.
> > > > +  */
> > >
> > > This makes me wonder whether lock_vma_under_rcu() should really becom=
e
> > > vma_trylock() at some point in time? :)
> > >
> > > Or at least have 'trylock' in the name.
> > >
> > > >   vma =3D lock_vma_under_rcu(mm, page_addr);
> > > >   if (!vma) {
> > > > -         /* fall back to mmap_lock */
> > > > -         if (!mmap_read_trylock(mm))
> > > > -                 goto err_mmap_read_lock_failed;
> > > > -         mm_locked =3D 1;
> > > > -         vma =3D vma_lookup(mm, page_addr);
> > > > +         /*
> > > > +          * If the vma exists, we can't continue because we cannot
> > > > +          * remove the page from the vma. However, if the vma was
> > > > +          * unmapped, it's okay to continue.
> > > > +          */
> > > > +         if (binder_alloc_is_mapped(alloc))
> > > > +                 goto err_vma_lock_failed;
> > >
> > > Hmm, it seems a bit odd to me that you also have:
> > >
> > >     if (vma && !binder_alloc_is_mapped(alloc))
> > >             goto err_invalid_vma;
> > >
> > > Below?
> > >
> > > So you have:
> > >
> > > Before:
> > >
> > >                             |binder_alloc_is_mapped()?
> > >                             |yes    no
> > >                     --------|-----------------
> > >     vma is mapped?  yes     |OK     abort
> > >                     no      |OK     OK
> > >
> > > Now:
> > >
> > >                             |binder_alloc_is_mapped()?
> > >                             |yes    no
> > >                     --------|-----------------
> > >     vma is mapped? maybe    |abort  OK
> > >                     yes     |OK     abort
> > >                     no      |OK     OK
> > >
> > > The 'maybe' is because the VMA trylock failed.
> > >
> > > So the issue is you might have a case where the VMA _is_ mapped but
> > > !binder_alloc_is_mapped(), which previously aborted because of the vm=
a &&
> > > !binder_alloc_is_mapped() check.
> > >
> > > It seems like:
> > >
> > >     /*
> > >      * Since a binder_alloc can only be mapped once, we ensure
> > >      * the vma corresponds to this mapping by checking whether
> > >      * the binder_alloc is still mapped.
> > >      */
> > >     if (vma && !binder_alloc_is_mapped(alloc))
> > >             goto err_invalid_vma;
> > >
> > > Is testing for a specific scenario 'we found a VMA but it turns out i=
t's
> > > invalid' and aborting if so.
> > >
> > > So either this check should be removed or you should uncondtionally a=
bort if
> > > !vma I think?
> >
> > This check is quite important and can't just be removed. If you remove
> > it, there's no guarantee that the vma is one created by Binder. It migh=
t
> > as well be a VMA from a completely different driver/subsystem, which we
> > definitely should not be invoking zap_vma_range() on.
> >
> > In this case, Binder rules out that scenario by saying that the VMA
> > can be mapped exactly once, and once you unmap it or remap it or
> > anything like that, Binder sets the 'is_mapped' boolean to false and
> > refuses to perform any further VMA operations for this binder fd.
> >
> > So really this function needs to deal with three scenarios:
> >
> > 1. The original Binder VMA is still there and we acquired its lock.
> > 2. The original Binder VMA is still there, but we could not acquire its
> >    lock.
> > 3. The original Binder VMA is gone.
> >    - Subcase one: there is no VMA at that location anymore.
> >    - Subcase two: there is now another unrelated VMA at that location.
> >
> > In scenario one we can proceed with zapping the page. In scenario two w=
e
> > must return LRU_SKIP because we are unable to zap the page. As for
> > scenario three, it's a scenario that is possible, but not something tha=
t
> > needs to work well. It doesn't matter that much whether such pages can
> > be reclaimed by the shrinker because userspace shouldn't create this
> > scenario to begin with.
> >
> > But you are right that we currently handle scenario 3 inconsistently. W=
e
> > handle subcase one by having the shrinker proceed to free the page, and
> > just skip the zap_vma_range() call. And we handle subcase two by having
> > the shrinker return LRU_SKIP. Either behavior is acceptable to me, but =
I
> > agree that being consistent would be better.
> >
> > So what we could do is to remove this check, but then later wrap
> > zap_vma_range() in an 'is_mapped' check like this:
> >
> >       if (vma && binder_alloc_is_mapped(alloc)) {
> >               zap_vma_range(vma, page_addr, PAGE_SIZE);
> >       }
> >
> > This way we only LRU_SKIP in case two, and always handle case 3 by
> > removing the page from alloc->pages without touching the VMA.
>
> Ah sorry I replied to Suren not noticing you'd responded :)
>
> Thanks for the explanation, much appreciated! Makes sense.
>
> I'm being OCD about it (occupational hazard in kernel development :) but =
the
> inconsitency was concerning there. And agreed it's an edge case.
>
> Suren - that good for the respin?

Yes, I'll incorporate Alice's suffestion into the next version. Thanks!
>
> >
> > Alice
>
> --
> Cheers, Lorenzo
