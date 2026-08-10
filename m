Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB93314AE
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786395632; cv=pass; b=kVByxyaTgdMmpWC5vLnn3EhT0nHJAC5GRwssorGcoPV6x0RAvMZgZJ9WW676UsMmR291WUlVScEH6Az+i0T0RH1httaleknqTT3t+e73bdCu2aGC3YGoueJAGD+jHnCZIYUwA/q9+eyNGVQocelMEKKb76z5aUzLFdKxIhK9lQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786395632; c=relaxed/simple;
	bh=xDyhBIlFQ2M2YwfJkbeeNRFOFm9lLHN1aGofw78q3ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCPrAYEoRbgtTYqe46N0KCxXJd8eXXPf0BztorRPP17+WOxZebj7Yk5rszCdgDRxn7SmkBdat3kOp1HGhG95oy12OA7mh+G/GaR9RrtRHsm+TjEii0tHsybcOy8YVW5HQXnQsiOXmjcm3EtX+/PvMmWNqnOQDf3CfcYY8+YqmJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Un7zEnmk; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Un7zEnmk"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c01c79467so26611cf.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786395629; cv=none;
        d=google.com; s=arc-20260327;
        b=ruxd3cnKwFSlb4WL+p9PZy7Otv2GoikTG7qO3usscX5pa5jJbm+nxa602uzUQ+QrKK
         YBPUyHJkOb8Fhwy6F8KRRLrPUXAwsLP8eMXG0A9qeEFeh6WjDOb5fS9jItxcQzhay3wp
         8MZUv2A6ahbTi2pxXC/1y/psY5iuLYJ2XUZNPC8Q0W0uw8kEf86ca2q7jS+dFh/E6ESc
         YdoPceQJI8s5j476oRJOGhXRDGSQpouw5Xzsu+386tflfA9frzOhqfCgVN4Eqs4Lr4p0
         pzf+T2WYCJ+fTlpa8qXiYELybZroFEhQ0jRdAzSZM1NthTzUyPrcchjO5URIkvUcflL/
         MBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aeKlJo/C9IF2FWChtlIU4TSN9rzPXmzQ3Z7bbkbSSDc=;
        fh=nf8ux0i4Vo1tH1S1HEQjxcULSvEuVWNxEaXqmI/wHtw=;
        b=NkAGQhRI+wMGXzAh9+oNk0G/aIPrJKAzJU772zEIN4TxmsZanKUTSQaEzfBgLUdrTs
         iMwOclRCX6GQuBXpa22SIhPPdZXcbJTHAd+NqoF+GXCWNtskb8Z9JHtFs6ucDsCyKpQI
         tJnMCeUW+I/QOURaB7pontRGQ6K4AZb8MiJ3waRF3Jj8QioDxJew0ewNBGVPkgIYJRRH
         zJLjw2OY281T5RI2RqsaJBKdt66ZRhbB/++HURinlctQgWxjjnhYBPC9YTgucgvIqumR
         sGVPcqpdo3kk+evQskshJNrbGmO0BKQsAWyZt11KL9I7F4ND2gGM74j5Q0lKbRH1KV/4
         0Wpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786395629; x=1787000429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aeKlJo/C9IF2FWChtlIU4TSN9rzPXmzQ3Z7bbkbSSDc=;
        b=Un7zEnmk5YirYUGcHnEBxx4y8Z0SlcvvDFiRHsNFQOFzKKhvzJ++qWgvMymzkBdrxg
         eUUfH1TytywMYpgY2qcV/uAm2eArhatqqghrlvF9OsVigbhV8SU7vftaZElxWfKzeMjd
         Mpc6Ery+utsEJVdYgLBtTB76l6O96Q/xqB2jnXOuL9HoceWzj1an1g2gy6om0gyv/JmZ
         AXzeMljbNDF26QuheIHBMXuFrHnYCRovqJDp5RwLxMfopVrM5ui+n71Uf0gfm3OUIGM/
         0XrZQnu5eROWUwzzDgPtWiRWek0qLXM1oO+vHDIdXiQ259qbw6hPE6vWFJjdNzkGqWz+
         k60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786395629; x=1787000429;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aeKlJo/C9IF2FWChtlIU4TSN9rzPXmzQ3Z7bbkbSSDc=;
        b=tUoOn2E35hQyfz+xU7cK8fJt5FxaK7O6I6j/wm/m6O1T/nTJGkL+GrhSE2/zdP36rh
         qBWLwbeHa8r0kYNhuKhLKTPd6Kh0N934x8psS9ZCyHbdelVXmJlWSXhf5o6w23hE4e3R
         sxsb2NzdXjOuJK8sbefURyZqcJ1tHziio8HCXRjDmrdJv/X2LTXKPJ8JW29ku5/Fo8A/
         Hm9Qjv+nLDg36e97dU5J9wgkqB2nS2hG6AgH/LVChunlgBgbRy2RhR/b/7perlolOp2P
         4Hx1kGPCbaw8mZkkaCn5ryzeM0LYeUB8UdC71lx+cb811gu9mFUZT07rYh24weocS0Qt
         32dA==
X-Forwarded-Encrypted: i=1; AHgh+Rp0/4px3aVJRlZZ4ZiZ+D5PGWDK922hryVLErwLUv/KjASUmdNWekN1dVlQkxjNdvdBDzpjYH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC2nu3zXtVU81SzsQGpBQYYNEJjQmuT/NOcuFe26TAJY8V/UF9
	BqcBpphgxBpyWiEwZVYgMXtFmfmugenZxDPfqcdi67WKpE+69Y73lm76uOPYsm6QlXBX//ydrYD
	lQY6WovPFdeW/DX5Ph+AF4f6wrw0QaAMIMDg4d0Tt
X-Gm-Gg: AR+sD12z9s7NMRzAtf9wcnt3/0tEWr1eEGNTqwAGkZEAbni4/W1Jq2N98v73jj15SDK
	XlsBnwM9h/GEmVzvidE5GYEHyKiAWm5HmnSl6rPHNBHDOiJ/urFAS0h+eS0SaW5xL1TCGw8TuI/
	653LU+/0AAa9l8xQf8oI33QnmUlFbU5mEZcLLf64WTT0Cvm7aDqamNvSrin2B8+iuuWtLBcCVxE
	cpOcKkfKUi91ditlg+3s66WWh1yoeQMV2mz9/+uvuJni5JpIpCgdqXbN+c69nfq9g/LNlKBkKZe
	wMcg60Kfu8yHXGArGgkVj3oovtBRrc6ocMxoEc+/zMxpFz4IetzZDw==
X-Received: by 2002:ac8:6104:0:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-52d511fb9ddmr2293481cf.10.1786395628636; Mon, 10 Aug 2026
 14:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806200548.3124802-1-surenb@google.com> <20260806200548.3124802-3-surenb@google.com>
 <anoZL76y3WGXMArB@google.com> <CAJuCfpFCK5ycO6s+dD35YtU6zgNdivfe6P3cVnd2VxPYfGXHDQ@mail.gmail.com>
 <anojoFPijbCloUXL@google.com>
In-Reply-To: <anojoFPijbCloUXL@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 10 Aug 2026 14:00:14 -0700
X-Gm-Features: AUfX_mwveKCjTyY76ZUcAzzSSNA4_OUdgAUMYP4JBZHh4wah9m0LDMZjkeG4kRk
Message-ID: <CAJuCfpGXBTRUUtCCpLPT9v1LZA6UHo0yM3y68Kwhxs7S03z+5A@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] binder: Make shrinker rely solely on per-VMA lock
To: Carlos Llamas <cmllamas@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, ljs@kernel.org, david@kernel.org, 
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org, 
	jannh@google.com, aliceryhl@google.com, arve@android.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 12:16=E2=80=AFPM Carlos Llamas <cmllamas@google.com=
> wrote:
>
> On Mon, Aug 10, 2026 at 11:54:04AM -0700, Suren Baghdasaryan wrote:
> > On Mon, Aug 10, 2026 at 11:32=E2=80=AFAM Carlos Llamas <cmllamas@google=
.com> wrote:
> > >
> > > On Thu, Aug 06, 2026 at 01:05:45PM -0700, Suren Baghdasaryan wrote:
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
> > > > The removal of the fallback does not affect NOMMU case because bind=
er
> > > > driver depends on CONFIG_MMU.
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
> > > >  drivers/android/binder_alloc.c | 45 ++++++++++++++++--------------=
----
> > > >  1 file changed, 21 insertions(+), 24 deletions(-)
> > > >
> > > > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binde=
r_alloc.c
> > > > index e4488ad86a65..c13a588c37de 100644
> > > > --- a/drivers/android/binder_alloc.c
> > > > +++ b/drivers/android/binder_alloc.c
> > > > @@ -1142,7 +1142,6 @@ enum lru_status binder_alloc_free_page(struct=
 list_head *item,
> > > >       struct vm_area_struct *vma;
> > > >       struct page *page_to_free;
> > > >       unsigned long page_addr;
> > > > -     int mm_locked =3D 0;
> > > >       size_t index;
> > > >
> > > >       if (!mmget_not_zero(mm))
> > > > @@ -1151,27 +1150,25 @@ enum lru_status binder_alloc_free_page(stru=
ct list_head *item,
> > > >       index =3D mdata->page_index;
> > > >       page_addr =3D alloc->vm_start + index * PAGE_SIZE;
> > > >
> > > > -     /* attempt per-vma lock first */
> > > > +     /*
> > > > +      * Attempt per-vma lock. This is essentially a
> > > > +      * "trylock". It can fail even if the VMA exists
> > > > +      * for 'page_addr'.
> > > > +      */
> > >
> > > Do we need to explain how lock_vma_under_rcu() works here?
> > >
> > > >       vma =3D lock_vma_under_rcu(mm, page_addr);
> > > >       if (!vma) {
> > > > -             /* fall back to mmap_lock */
> > > > -             if (!mmap_read_trylock(mm))
> > > > -                     goto err_mmap_read_lock_failed;
> > > > -             mm_locked =3D 1;
> > > > -             vma =3D vma_lookup(mm, page_addr);
> > > > +             /*
> > > > +              * If the vma exists, we can't continue because we ca=
nnot
> > > > +              * remove the page from the vma. However, if the vma =
was
> > > > +              * unmapped, it's okay to continue.
> > > > +              */
> > > > +             if (binder_alloc_is_mapped(alloc))
> > > > +                     goto err_vma_lock_failed;
> > >
> > > The comments seem redundant, the label is enough. This works:
> > >
> > >         vma =3D lock_vma_under_rcu(mm, page_addr);
> > >         if (!vma && binder_alloc_is_mapped(alloc))
> > >                 goto err_vma_lock_failed;
> >
> > Yeah, for the binder maintainers what's happening here is probably
> > obvious, but when Alice explained the logic to me, this comment really
> > clarified what's going on, so I added it here. If you insist on
> > removing it, I'll do that of course.
> >
> > >
> > >
> > > >       }
> > > >
> > > >       if (!mutex_trylock(&alloc->mutex))
> > > >               goto err_get_alloc_mutex_failed;
> > > >
> > > > -     /*
> > > > -      * Since a binder_alloc can only be mapped once, we ensure
> > > > -      * the vma corresponds to this mapping by checking whether
> > > > -      * the binder_alloc is still mapped.
> > > > -      */
> > > > -     if (vma && !binder_alloc_is_mapped(alloc))
> > > > -             goto err_invalid_vma;
> > > > -
> > >
> > > This introduces an "extra" change. We'll now release pages without a
> > > valid vma (e.g. after munmap()). Before, these pages were expected to=
 be
> > > released via close() in binder_alloc_deferred_release() later.
> > >
> > > I don't see anything wrong with it. However, it does seem out of the
> > > scope of this patch which just drops the mmap_read_lock() calls. Or a=
t
> > > least I don't see how this part is necessary.
> >
> > This check came from this discussion:
> > https://lore.kernel.org/all/anGrFIYiPhjxWSkD@google.com/
> > It's added for consistency when handling cases where the original
> > Binder VMA is gone.
>
> Oh sorry I missed that thread. Yes, I agree we can reclaim these pages
> earlier if really needed but my point is this is unrelated to the change
> done here IMO. I couldn't figure out why that was needed.
>
> If you are keeping that in the same commit it's probably worth adding an
> explanation to the commit log?

Ok, I'll amend the commit log with an explanation for this change.
Are you ok with keeping the other comment, or do you want it removed?

>
> --
> Carlos Llamas
