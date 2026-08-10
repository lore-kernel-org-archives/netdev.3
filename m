Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DA6407CD3
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389417; cv=none; b=lUB6rb2evFI+sriUAUCGRxg+uA/5pyb70V9zdk3xH6lSDAvU2Fe8D6BPgUW2cStnoVUWYnbxJu7tQzMymnKcLqBDEZF0F5PmPbFrf0YY6BzIK9C9pVfBjGJpvsAnI6xDhyDRxBHT+iH8BJr5RGbVr4DolXB7yc6O06WHHjMPZtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389417; c=relaxed/simple;
	bh=gfjn0y+2uuOs+uRxYSZFwPBs7Pdd4g9t5Y4t90BW9LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5dvwS9XIHwVtqHFf6K9/Dt0zkqrK607HtVjBW6aVAZctWqZbFyPDp5P9NHQJAH8fbyynD43wnaJF8RTviwGFBoU15tq8FlZpo6/yC7mxsn8J5PfGX2QuW/UK0QHTw3y2AxuPYEpEvTpgNdrUjjU+XxCrE0S2kLjsWAgm56eS04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qu4mOcHK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qu4mOcHK"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacef7d299so24545ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 12:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786389415; x=1786994215; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J2OElYLJIGARf5vioBp76ZtfppNwzknP+qKxG2O0wiw=;
        b=qu4mOcHKOm5KDjS0Cu3Gb7f1TODcUrj1553Io5m8qAmfZ8voh8f0CiKL4LK0MqIIMA
         DQSvMFkIPSvT/KdsL9+Ou/e+EEB/gHerLkkmnB7a1laANLp69LVDbXavCnRi7GdtzfPx
         sPNLb+ktl8W2hOhQ+DM+OpOzb3yPz7P+ERs5q4+qrfUqZfxsvSo5tsVNmGNFm8+afUjT
         gX9538OVjxMrbQCIkkTZIVhHYBN4rBWah2vJF1AVWqZyzsnD8J7LBuOmC2M3qBQtrgV4
         nG4RJjXDIfaahd/nNro+2BGKYtvbibXxi054FR+zPqIxs7lSaFwdu+HzQe/tYplqu6+D
         ejBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786389415; x=1786994215;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J2OElYLJIGARf5vioBp76ZtfppNwzknP+qKxG2O0wiw=;
        b=eb+r6oZRZ3yULTGJnIOCypsHootw1LnYRLTRzFD7zJAfTZravsXO/VkOSo2ZfWSscn
         JXu6cFJlskqRCaOum/4UGRe86PZVsOrfXuY6pN0Dy+hwddcrCUizZXVFz13pgREkPKI4
         /ID5YY/4dfEyaQLIprQzXVl1AIcE3uElBfj4k5vtLvzftclQZOf0K9sKV7y+5XZ41ksC
         NboBUOXwuIRdvwoIqYtw3D+HmpzwS9JFv8z68LTrF23YbKpZ/LLINFTsiwauEgYxCsXu
         EvIrW56a6zYxlEWos5YwJEd4LxjyGnBRFoxSYvOYLHYAS5oXQ897g0DBhzZu+mtLG/oC
         9I4Q==
X-Forwarded-Encrypted: i=1; AHgh+RrMJAX0tV6Tn7cedyuTpRterTBm1splLxPNJahkQSBYB/+gQBVM3e8VULTACYmyIxfkcu6kSuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrvK2XrT28bRgJTf9fGoIl5B5iwbRjoEFEagpv8318KN9sRkSq
	8k/mxZCU5dFA76U+yzLmz2QkpKR55n8NKGTO2waVy+fRfqHNdV4OWsQ8jF9ecQMb8A==
X-Gm-Gg: AR+sD12qAqaePwzw6ITbZytKN/pD5KE/56+rBBqo20/Hhgnhc/EPPy4cuvajtTIS0Kb
	E80DDYRhI09JY9S+0dYmGJYQsnQCwhoTkW52PRivkwYhxsHDEm3sMXzHPyp3hTqB8fdhOLUeJ3f
	s993DRoSUIKbeIL6q5RjRQjlXFVApiSfetUEDIughar+dcJf5Et7fH0y601evHcfx9N5M8F9yoJ
	zCLvY0Xmg8OI+fraLTug7RvTeaEmlXT23mSnsx6C4nGhsx3kUWgNPbXZygXLEZRzj9nhPQ6a2kz
	21hgr0TXz8A4AwbNDamJg3SF7BwBqjI11CMnjJpPei4XTkFaL4qxLDFopzWOuh1tvAq23SqTi89
	SOq9JpgO3ckA7Xv88HI/kWqzekQh9BoDExpu1RmOAAK9KZN8pKhGxklle0ijTQpMceplm8VHNjB
	zOyLZbAg0kYsEG1PDiLuXmRDHyw7w785N1P926PZDKkRFOCeGMyb+k6RTEpB8xC+L1X/lMCICBD
	t8+i90dYHGDEbKV9ABumWqKg6HoDAPbr66euo0bGdBFdNEs7PuIl1KAxJUUEdR5jpUc3E+v7DS3
	wdipXA/gA9ActKSHIbU=
X-Received: by 2002:a17:902:c64a:b0:2ca:be81:b469 with SMTP id d9443c01a7336-2d3102ed978mr1352925ad.0.1786389414159;
        Mon, 10 Aug 2026 12:16:54 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f35b155sm4428211a12.16.2026.08.10.12.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:16:52 -0700 (PDT)
Date: Mon, 10 Aug 2026 19:16:48 +0000
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
Message-ID: <anojoFPijbCloUXL@google.com>
References: <20260806200548.3124802-1-surenb@google.com>
 <20260806200548.3124802-3-surenb@google.com>
 <anoZL76y3WGXMArB@google.com>
 <CAJuCfpFCK5ycO6s+dD35YtU6zgNdivfe6P3cVnd2VxPYfGXHDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFCK5ycO6s+dD35YtU6zgNdivfe6P3cVnd2VxPYfGXHDQ@mail.gmail.com>

On Mon, Aug 10, 2026 at 11:54:04AM -0700, Suren Baghdasaryan wrote:
> On Mon, Aug 10, 2026 at 11:32 AM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > On Thu, Aug 06, 2026 at 01:05:45PM -0700, Suren Baghdasaryan wrote:
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
> > > The removal of the fallback does not affect NOMMU case because binder
> > > driver depends on CONFIG_MMU.
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
> > >  drivers/android/binder_alloc.c | 45 ++++++++++++++++------------------
> > >  1 file changed, 21 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> > > index e4488ad86a65..c13a588c37de 100644
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
> > > @@ -1151,27 +1150,25 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
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
> > Do we need to explain how lock_vma_under_rcu() works here?
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
> > The comments seem redundant, the label is enough. This works:
> >
> >         vma = lock_vma_under_rcu(mm, page_addr);
> >         if (!vma && binder_alloc_is_mapped(alloc))
> >                 goto err_vma_lock_failed;
> 
> Yeah, for the binder maintainers what's happening here is probably
> obvious, but when Alice explained the logic to me, this comment really
> clarified what's going on, so I added it here. If you insist on
> removing it, I'll do that of course.
> 
> >
> >
> > >       }
> > >
> > >       if (!mutex_trylock(&alloc->mutex))
> > >               goto err_get_alloc_mutex_failed;
> > >
> > > -     /*
> > > -      * Since a binder_alloc can only be mapped once, we ensure
> > > -      * the vma corresponds to this mapping by checking whether
> > > -      * the binder_alloc is still mapped.
> > > -      */
> > > -     if (vma && !binder_alloc_is_mapped(alloc))
> > > -             goto err_invalid_vma;
> > > -
> >
> > This introduces an "extra" change. We'll now release pages without a
> > valid vma (e.g. after munmap()). Before, these pages were expected to be
> > released via close() in binder_alloc_deferred_release() later.
> >
> > I don't see anything wrong with it. However, it does seem out of the
> > scope of this patch which just drops the mmap_read_lock() calls. Or at
> > least I don't see how this part is necessary.
> 
> This check came from this discussion:
> https://lore.kernel.org/all/anGrFIYiPhjxWSkD@google.com/
> It's added for consistency when handling cases where the original
> Binder VMA is gone.

Oh sorry I missed that thread. Yes, I agree we can reclaim these pages
earlier if really needed but my point is this is unrelated to the change
done here IMO. I couldn't figure out why that was needed.

If you are keeping that in the same commit it's probably worth adding an
explanation to the commit log?

--
Carlos Llamas
