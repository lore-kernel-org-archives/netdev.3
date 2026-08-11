Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4405390C8E
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786416623; cv=none; b=sr9EyPyiarkXXNezXQvTi7/2D3wef5rYNv8qzGK0NWANFGyMsGvBbEwX+4Db3jWnGLGvEt7bMz2CBjPJvONLy25IntvrTw3Yl62MM/yBlnTz4sESlBYsr5QrtbNPQIHvcy4RGfRzh3Snb7JGUav90qm3l61OjiV3JOPRxVfY20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786416623; c=relaxed/simple;
	bh=r+fvIYtmCMuMui24olttP45pW6pp5Dx7CCPVmn2XRcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6SyDqrFJeZG78hOGJq5FX/UJNXemiXH0RN8yZJhCJ/36519PVAx5sm19nbSJsuekOEgTnYjC7sO2M1XdhpVtiXyyA03WigPeeyuHFtEzA1IeUwQbqr3jGVEto92RUtGVaNh8O2mcsTEETOkTJxw1gwGAQsX0jWx7GI7y2+9KZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s1ZWSfSn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1ZWSfSn"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cacef7d299so34765ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786416621; x=1787021421; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=acdbH9fKwYoyiG7hBwz6wBMxKJBmLIf01OPkTkxGfP4=;
        b=s1ZWSfSnGoEURJQiSmWm76wutDdCIFXr0OUonLkCg79cmO3GOxHS7Twaq0/9k8Um3B
         v9sw6KITCdsIuyMLu5Jwj/IKRsOFunrEh9bAXe1bobsW8OL4GNsd2eZ67rwj82oblezS
         NZCLmRLYCF0Nk1LaGRz1FnPoE67/tkA0S/w0am3EW0Sll+HC/+aeiOXhDzNKVCQKp3JT
         /t2cdN7gsTMe1yqjSBzLmaoH4sTM8bm5Zbo3+SHARq1b82Wr/IJZMR6T4nLCitVHb4NT
         FHhdO9d8Kb9znZFuxQ2Yj43/svOJ0xM8zxWqrXDAUJUKHDoG5InwIXP4bAO4TeYjKsud
         6DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786416621; x=1787021421;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=acdbH9fKwYoyiG7hBwz6wBMxKJBmLIf01OPkTkxGfP4=;
        b=IvJfWW+Kgp1Q8uk0ZuhswNo2w7rDiSkeZePBMR1RH1FUgVQ6tgt7q1lfLuTYzC31m7
         YPQRLDdZpOm3UCcz0ETUEStZ40VQr0SqNr+cy31XZ8Ae7KZuzhFNZg2vQ7SVQo9Tnyre
         tvQQHLYEUw0znWtBc8TYGvu3dyeaBigC/Mk9WnnM3FNK2fKlAAT5fmW/hQ0qp4TE7scc
         uNZv1qgpuX3f2AQeLWz1OaGGxsWqb6EQ9j0Lnhyx8M0Yh22gdJnWD7mlzF+ecMoRb0aH
         M6mrdkjtI8SA2s/Y28A0PCWejlNr66pUPnfaXAe3XpM1cGzeariTTc4xP23ViLNKgaAP
         e9Aw==
X-Forwarded-Encrypted: i=1; AHgh+RrHY9BXbBW8SUCQwpzMysD2GiD1gyQicolQQKZqPaq6hZrXNnRX14nZ/9+RDjoqomidiHFGqMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOGxZ7WpeNkiRzibh7DRQ95B1Qzf9itLC1M8VRhI6a9sH16Icj
	GMWDQI5NihN1Z+OWvMMusc2t/QV+bItb4SYhR8X9Zw9mKQHdFQGQMxyKI85oRL7cXg==
X-Gm-Gg: AR+sD12oXDGyAp1jjfzME9hqr1aiKeR0tspDYGX913GIOO8F1J2JZ6XCeOJBMyrX/di
	QzYo7S6Nj2SrNXpY7oX96GFKuHtuOazNDvxxuWtitRh311686uIfK4JWffr8sQxS/jZabwtXXgO
	FSuUQzO2Ep6u7YBrpIlx/2rsyPwE1GKpGxO572ATFtPb1vuGmEjjQQXYepyseYwIYQGFC+Ulzh9
	l3cGVoaNMT+o3N5W+xtZbNQ/uzUEv17GXB1/E8kc8woLfImE15m400rfrB9XVSYonKrWwKBS/G/
	5282QCKWYv5CO1wBGcV0asBb9/uBCJQGP1TcBnYB5A1DsLLJgrPB0r51g+PP8+l/Rul6sYBF/rO
	5q/p56b94Lt6oQE2g8wR5LIVegOhkYCtOm8Lk4QgG48fB2spSPyoyd+d8mD+pTc2XBxpLD4KKkr
	N2fFo95TbBG/F9L+cNB5vulBf3/aW00w1l6LhuKqgBlKUQD1mNl91OFXxKfrN/RLXcV8YwCf+pK
	AwM01c2EvAxffseyrRIXaFbcjdYYffD0twal5U7oUCQThEVqv7Y6aSfHIIfxi0V7EPeNDwgZu9B
	ZA76EhD0dLbCxBV2IqeatgrjMrXwVw==
X-Received: by 2002:a17:903:37cd:b0:2b9:e831:5e5c with SMTP id d9443c01a7336-2d317208d60mr481185ad.4.1786416620399;
        Mon, 10 Aug 2026 19:50:20 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315ef11fesm540535ad.5.2026.08.10.19.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 19:50:19 -0700 (PDT)
Date: Tue, 11 Aug 2026 02:50:15 +0000
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
Message-ID: <anqN59pDZEEcz1vd@google.com>
References: <20260806200548.3124802-1-surenb@google.com>
 <20260806200548.3124802-3-surenb@google.com>
 <anoZL76y3WGXMArB@google.com>
 <CAJuCfpFCK5ycO6s+dD35YtU6zgNdivfe6P3cVnd2VxPYfGXHDQ@mail.gmail.com>
 <anojoFPijbCloUXL@google.com>
 <CAJuCfpGXBTRUUtCCpLPT9v1LZA6UHo0yM3y68Kwhxs7S03z+5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGXBTRUUtCCpLPT9v1LZA6UHo0yM3y68Kwhxs7S03z+5A@mail.gmail.com>

On Mon, Aug 10, 2026 at 02:00:14PM -0700, Suren Baghdasaryan wrote:
> On Mon, Aug 10, 2026 at 12:16 PM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > On Mon, Aug 10, 2026 at 11:54:04AM -0700, Suren Baghdasaryan wrote:
> > > On Mon, Aug 10, 2026 at 11:32 AM Carlos Llamas <cmllamas@google.com> wrote:
> > > >
> > > > On Thu, Aug 06, 2026 at 01:05:45PM -0700, Suren Baghdasaryan wrote:
> > > > > From: Dave Hansen <dave.hansen@linux.intel.com>
> > > > >
> > > > > tl;dr: lock_vma_under_rcu() is already a trylock. No need to do both
> > > > > it and mmap_read_trylock().
> > > > >
> > > > > Long Version:
> > > > >
> > > > > == Background ==
> > > > >
> > > > > Historically, binder used an mmap_read_trylock() in its shrinker code.
> > > > > This ensures that reclaim is not blocked on an mmap_lock. Commit
> > > > > 95bc2d4a9020 ("binder: use per-vma lock in page reclaiming") added
> > > > > support for the per-VMA lock, but left mmap_read_trylock() as a
> > > > > fallback.
> > > > >
> > > > > This was presumably because the per-VMA locking can fail for several
> > > > > reasons and most (all?) lock_vma_under_rcu() callers have a fallback
> > > > > to mmap_read_trylock().
> > > > >
> > > > > == Problem ==
> > > > >
> > > > > The fallback is not worth the complexity here. lock_vma_under_rcu() is
> > > > > essentially already a non-blocking trylock. The main reason it fails
> > > > > is also the reason mmap_read_trylock() fails: something is holding
> > > > > mmap_write_lock().
> > > > >
> > > > > The only remedy for a collision with mmap_write_lock() is to wait,
> > > > > which this code can not do. So the "fallback" after
> > > > > lock_vma_under_rcu() failure is not really a fallback: it is really
> > > > > likely to just be retrying in vain. That retry in an of itself isn't
> > > > > horrible. But it adds complexity.
> > > > >
> > > > > == Solution ==
> > > > >
> > > > > Now that per-VMA locks are universally available, lock_vma_under_rcu()
> > > > > will not persistently fail. Rely on it alone and simplify the code.
> > > > > The removal of the fallback does not affect NOMMU case because binder
> > > > > driver depends on CONFIG_MMU.
> > > > >
> > > > > Full disclosure: I originally tried to do this with
> > > > > lock_vma_under_rcu_wait(), but it did not fit well with the mmap_lock
> > > > > trylock semantics. Claude caught this in a review and suggested the
> > > > > approach in this path. It seemed sane to me. So, Suggesed-by: Claude,
> > > > > I guess.
> > > > >
> > > > > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > > > > Cc: Vlastimil Babka <vbabka@kernel.org>
> > > > > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > > > > Cc: linux-mm@kvack.org
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Cc: Arve Hjønnevåg <arve@android.com>
> > > > > Cc: Todd Kjos <tkjos@android.com>
> > > > > Cc: Christian Brauner <christian@brauner.io>
> > > > > Cc: Carlos Llamas <cmllamas@google.com>
> > > > > Cc: Alice Ryhl <aliceryhl@google.com>
> > > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > > Cc: David Ahern <dsahern@kernel.org>
> > > > > Cc: netdev@vger.kernel.org
> > > > > ---
> > > > >  drivers/android/binder_alloc.c | 45 ++++++++++++++++------------------
> > > > >  1 file changed, 21 insertions(+), 24 deletions(-)
> > > > >
> > > > > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> > > > > index e4488ad86a65..c13a588c37de 100644
> > > > > --- a/drivers/android/binder_alloc.c
> > > > > +++ b/drivers/android/binder_alloc.c
> > > > > @@ -1142,7 +1142,6 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
> > > > >       struct vm_area_struct *vma;
> > > > >       struct page *page_to_free;
> > > > >       unsigned long page_addr;
> > > > > -     int mm_locked = 0;
> > > > >       size_t index;
> > > > >
> > > > >       if (!mmget_not_zero(mm))
> > > > > @@ -1151,27 +1150,25 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
> > > > >       index = mdata->page_index;
> > > > >       page_addr = alloc->vm_start + index * PAGE_SIZE;
> > > > >
> > > > > -     /* attempt per-vma lock first */
> > > > > +     /*
> > > > > +      * Attempt per-vma lock. This is essentially a
> > > > > +      * "trylock". It can fail even if the VMA exists
> > > > > +      * for 'page_addr'.
> > > > > +      */
> > > >
> > > > Do we need to explain how lock_vma_under_rcu() works here?
> > > >
> > > > >       vma = lock_vma_under_rcu(mm, page_addr);
> > > > >       if (!vma) {
> > > > > -             /* fall back to mmap_lock */
> > > > > -             if (!mmap_read_trylock(mm))
> > > > > -                     goto err_mmap_read_lock_failed;
> > > > > -             mm_locked = 1;
> > > > > -             vma = vma_lookup(mm, page_addr);
> > > > > +             /*
> > > > > +              * If the vma exists, we can't continue because we cannot
> > > > > +              * remove the page from the vma. However, if the vma was
> > > > > +              * unmapped, it's okay to continue.
> > > > > +              */
> > > > > +             if (binder_alloc_is_mapped(alloc))
> > > > > +                     goto err_vma_lock_failed;
> > > >
> > > > The comments seem redundant, the label is enough. This works:
> > > >
> > > >         vma = lock_vma_under_rcu(mm, page_addr);
> > > >         if (!vma && binder_alloc_is_mapped(alloc))
> > > >                 goto err_vma_lock_failed;
> > >
> > > Yeah, for the binder maintainers what's happening here is probably
> > > obvious, but when Alice explained the logic to me, this comment really
> > > clarified what's going on, so I added it here. If you insist on
> > > removing it, I'll do that of course.
> > >
> > > >
> > > >
> > > > >       }
> > > > >
> > > > >       if (!mutex_trylock(&alloc->mutex))
> > > > >               goto err_get_alloc_mutex_failed;
> > > > >
> > > > > -     /*
> > > > > -      * Since a binder_alloc can only be mapped once, we ensure
> > > > > -      * the vma corresponds to this mapping by checking whether
> > > > > -      * the binder_alloc is still mapped.
> > > > > -      */
> > > > > -     if (vma && !binder_alloc_is_mapped(alloc))
> > > > > -             goto err_invalid_vma;
> > > > > -
> > > >
> > > > This introduces an "extra" change. We'll now release pages without a
> > > > valid vma (e.g. after munmap()). Before, these pages were expected to be
> > > > released via close() in binder_alloc_deferred_release() later.
> > > >
> > > > I don't see anything wrong with it. However, it does seem out of the
> > > > scope of this patch which just drops the mmap_read_lock() calls. Or at
> > > > least I don't see how this part is necessary.
> > >
> > > This check came from this discussion:
> > > https://lore.kernel.org/all/anGrFIYiPhjxWSkD@google.com/
> > > It's added for consistency when handling cases where the original
> > > Binder VMA is gone.
> >
> > Oh sorry I missed that thread. Yes, I agree we can reclaim these pages
> > earlier if really needed but my point is this is unrelated to the change
> > done here IMO. I couldn't figure out why that was needed.
> >
> > If you are keeping that in the same commit it's probably worth adding an
> > explanation to the commit log?
> 
> Ok, I'll amend the commit log with an explanation for this change.
> Are you ok with keeping the other comment, or do you want it removed?

Ok, let's keep the comment. You are right that it is not obvious what
the intend of the binder_alloc_is_mapped() check is.

Thanks,
Carlos Llamas
