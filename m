Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3F7432BC3
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781893; cv=pass; b=m5DTe/tOB5ngVmECkSqwFf3O+1HBHjNyIEV0Y13lrSS4lwMqrbAeeSWVgSsPCYBPweK6ho7NhMw996j8tTFGZwcyUWy0bmvSlwIPhAbTAewAy+4mlvIZ/1dIlB3k2FGqUEmn7sB0nEdEouyoP/TuEedofah4lmWAdp4xQpfjq44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781893; c=relaxed/simple;
	bh=rhtfUlxscQyCpYGSqc6xoSQg6l7vdr1+JAW5gQ3HRtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dn5qfvy4KdgajYCQMH2MpHLp6vIZ0eVY9pub9y07kcaBm91bXI0qsgfkLGL4DA0Bv8luZH9gwOv7TesBjalLBY26aIXxqI+bz8iXNxfT2uboLiVub7nZI3i0Kz6J08DWM6AuyA9U/QyJID3GoxS8YYCsHtKJkFvqlalzx002QC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OvEAT80w; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OvEAT80w"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c15a5b265so32891cf.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 11:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785781890; cv=none;
        d=google.com; s=arc-20260327;
        b=NSFwXINtzaHDaEJz36fHDs1YjlGqy+W/SoL2pcypsCMrfq8svQEgICIXxPIYDMnKIB
         rF3jsdk2CuJAT2CHdEhQMaQPNbLmkuER4o48lVKj2F2pFeciCUR92nk5y45D219HyuEC
         Du1kyugDf0XkKTUQbybqmCaucMc8OeWIoG2IgRgTfjypWOdP3pyri/FsR0utzY5ql2PW
         HEjXAQxfEp7Zn9jlM3yfzJA0cVsJay0w5dWFUKGjni9uV5LDk5oPOqbLN+THOMBzp9yX
         ixClk50UGoRrG2MHYae+9653zOboCpnvzO5PLhcZaOYWmyWjW7Om5xgSd9v6brXNRHWt
         k/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2sh20aaLjGDr49LHpT4MIdFB8Gf/03Udd36UxUfpzRE=;
        fh=xd7ejye4zVn2MrWIgLbwI6X8hkLyGg/Qx+wihj+sNjw=;
        b=BcR1OUuE88yG6CKwtEfWRN4c98IIo51WGyVBxf0A9zqEKvNHU7YGTtYqt5ObVRIMrj
         CdIbclV3qIxJDFO/649ZYLkPD6dmkfhePYC4lXGsquflgkNVN7qsxK2o3/F2Ncf13VRB
         rKVrm1lFVQfrnuYPUtIgK82zT5FsHkxakYI0jCxGwUB9KVEz/E1OD65cLodY0uyNXt2K
         wx3Q0myXCn5B/5I3LXxtGcyM0eZQ0nyW5W400En3LuCuznxplBCdaAc+LpmEQL+6iubE
         B+dhSkfaEMuKBgPvnlAeLp3qg+IgTJM8GDLkezh0vVSTGwRwQn3qYsFlZN8Mf17zxQky
         gxgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785781890; x=1786386690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2sh20aaLjGDr49LHpT4MIdFB8Gf/03Udd36UxUfpzRE=;
        b=OvEAT80wuZ1Ys9LObhqEFs9Ipc1K1uzRjF0N2gx+dSnKVRSZSfqRFh4qoRr0ClrLij
         5FHcFKyumcMIwDDya5V0JrU+gvrgdls188824h0oRh9Z0xj02f8La70LdxWAM2p/oHfv
         FkCG+7k7nCpLxvvrKTv7qEM7ot+qmLhxyjdSswDhEHjaw4zyG7UEI4Szw3MeuyO5SQFY
         8p2LjAmrjX6t71rlvdzdZi/2iQEbsRuwoZ6efzXw1KGqSeP34AUNSn/OghD2fAmmY7Co
         e9bsHxOvg2FBJdVAMmgx0pCKJFYzJgdrKxnl+lqCC/beIhsBqEHa3brN5p/bEYrA7WVT
         d6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785781890; x=1786386690;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2sh20aaLjGDr49LHpT4MIdFB8Gf/03Udd36UxUfpzRE=;
        b=d2ydAJS+TqK3/XzsYpbCjHjTnMeb3swKcFhmyaNpGiZI4DnDG7BI+50E8RhvP2IoXW
         d5eFW4VyfL424TEud634Z0ULEU0C03ey1MYxCXcW2GxW7whir5zuFrm5eTXG5mu1j/BF
         fVPdGF60EbG08kkUYEqafTBcCRMq2QV65s7tDHGwHtBgV6olmjqKw0i/x58UYqhqi0nb
         +GKSPeSt7Tr9VTwHNIBMqzb3O/DUxRbGgIY/VgnurLubDE8P90s2TWhH4ltY2E5kYHty
         g7y3p2+Sr8TkGF+ptZugWLo69w5yfnTPZFdqSA6+4aRJc1O2Vqp8t5Rl9TcPF9qXhm0u
         irxQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHisRCGifMLRRL59/UMBN+pPi7Lu3Yr8KV0ZBrePKx650+NYmx1Epi4+imOMbZz/5c0qVViOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyL26oqd9aaEmnDq/gJzn9NulvDZD2v/3VcqQdS/BHqwUJo8W7
	IoH71TbZeUxhZNf69B03aNvUCR8ar67IA900j7KgiRfgSfMO2jgorbqNT+avVZjzYPexHzl4MNJ
	f3Zege3J1vnSjnTnLussnmnYy2m0KkKZ0UQv8uaKB
X-Gm-Gg: AR+sD116C/QzOmBwIOquQVi6edLNoHCy89q5n8rzf2iHCpQ0bhpOuaIBUy/lIucRZXv
	EDeQHJs0VreOP3UbaJYs72Zb86bAAiLE2SzZNr6ygqqSCfmeJP18D6G9KoAChyjZHlGJEeoazgg
	BZ5qJSZZDeU+OD1JtIpuuQvNQW+aEDB3YFpOE9hEH27xj4E4Nisu7HUkrOLApXupxYe/0aIk8Wd
	vI+3vyiv6UDzxvDuM3uGFmK9PzOfpHLnJvwIvIDA65L7ETP4YIO/8/sIZtvtqTAYREDVlrZpVOX
	GJnpUiZaVgEL7R28PdUSMf8FZCZa00jtxvbxwRMImkiZN9lJo9A8DC4=
X-Received: by 2002:a05:622a:9013:b0:527:f08f:56a2 with SMTP id
 d75a77b69052e-52cd4e7dbedmr1574331cf.8.1785781885821; Mon, 03 Aug 2026
 11:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-3-surenb@google.com>
 <anByp6uVW77uofKx@lucifer>
In-Reply-To: <anByp6uVW77uofKx@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 3 Aug 2026 11:31:14 -0700
X-Gm-Features: AUfX_myBOeiNVA0m1qVZE2GBbWEi5bWqHPnmKZfxbZ2vvxGu8qUxd_oIiqOluMk
Message-ID: <CAJuCfpHPcE0=7825xiusBN0MmCp1hrnsDuYrfTKwGM43ozmmOQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] binder: Make shrinker rely solely on per-VMA lock
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, david@redhat.com, willy@infradead.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com, 
	aliceryhl@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 4:10=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
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
> >       struct vm_area_struct *vma;
> >       struct page *page_to_free;
> >       unsigned long page_addr;
> > -     int mm_locked =3D 0;
> >       size_t index;
> >
> >       if (!mmget_not_zero(mm))
> > @@ -1151,14 +1150,20 @@ enum lru_status binder_alloc_free_page(struct l=
ist_head *item,
> >       index =3D mdata->page_index;
> >       page_addr =3D alloc->vm_start + index * PAGE_SIZE;
> >
> > -     /* attempt per-vma lock first */
> > +     /*
> > +      * Attempt per-vma lock. This is essentially a
> > +      * "trylock". It can fail even if the VMA exists
> > +      * for 'page_addr'.
> > +      */
>
> This makes me wonder whether lock_vma_under_rcu() should really become
> vma_trylock() at some point in time? :)
>
> Or at least have 'trylock' in the name.

Makes sense. I think I'll postpone renames until after the series are
merged. Don't want to mix too many changes together.

>
> >       vma =3D lock_vma_under_rcu(mm, page_addr);
> >       if (!vma) {
> > -             /* fall back to mmap_lock */
> > -             if (!mmap_read_trylock(mm))
> > -                     goto err_mmap_read_lock_failed;
> > -             mm_locked =3D 1;
> > -             vma =3D vma_lookup(mm, page_addr);
> > +             /*
> > +              * If the vma exists, we can't continue because we cannot
> > +              * remove the page from the vma. However, if the vma was
> > +              * unmapped, it's okay to continue.
> > +              */
> > +             if (binder_alloc_is_mapped(alloc))
> > +                     goto err_vma_lock_failed;
>
> Hmm, it seems a bit odd to me that you also have:
>
>         if (vma && !binder_alloc_is_mapped(alloc))
>                 goto err_invalid_vma;
>
> Below?
>
> So you have:
>
> Before:
>
>                                 |binder_alloc_is_mapped()?
>                                 |yes    no
>                         --------|-----------------
>         vma is mapped?  yes     |OK     abort
>                         no      |OK     OK
>
> Now:
>
>                                 |binder_alloc_is_mapped()?
>                                 |yes    no
>                         --------|-----------------
>         vma is mapped? maybe    |abort  OK
>                         yes     |OK     abort
>                         no      |OK     OK
>
> The 'maybe' is because the VMA trylock failed.

The case you are considering is lock_vma_under_rcu() failed for some
reason other than lock contention (say seqno overflow). In that case
we get vma=3D=3DNULL and binder_alloc_is_mapped() is called without any
lock (VMA or mmap lock) being held. I'm not sure if this is a real
problem since I see other places calling binder_alloc_is_mapped()
without locking. Alice, Carlos, is this a problem?

>
> So the issue is you might have a case where the VMA _is_ mapped but
> !binder_alloc_is_mapped(), which previously aborted because of the vma &&
> !binder_alloc_is_mapped() check.
>
> It seems like:
>
>         /*
>          * Since a binder_alloc can only be mapped once, we ensure
>          * the vma corresponds to this mapping by checking whether
>          * the binder_alloc is still mapped.
>          */
>         if (vma && !binder_alloc_is_mapped(alloc))
>                 goto err_invalid_vma;
>
> Is testing for a specific scenario 'we found a VMA but it turns out it's
> invalid' and aborting if so.
>
> So either this check should be removed or you should uncondtionally abort=
 if
> !vma I think?

I think this check is fine because it basically checks
binder_alloc_is_mapped() after stabilizing the address range.
Unconditionally aborting if !vma would prevent us from freeing the
page if the VMA was already unmapped. The ultimate question is whether
we can rely on binder_alloc_is_mapped() alone when freeing that page.
IOW, VMA might still be in the VMA tree but
binder_alloc_is_mapped()=3D=3Dfalse, can we free the page?

>
>
> >       }
> >
> >       if (!mutex_trylock(&alloc->mutex))
> > @@ -1191,9 +1196,7 @@ enum lru_status binder_alloc_free_page(struct lis=
t_head *item,
> >       }
> >
> >       mutex_unlock(&alloc->mutex);
> > -     if (mm_locked)
> > -             mmap_read_unlock(mm);
> > -     else
> > +     if (vma)
> >               vma_end_read(vma);
> >       mmput_async(mm);
> >       binder_free_page(page_to_free);
> > @@ -1203,11 +1206,9 @@ enum lru_status binder_alloc_free_page(struct li=
st_head *item,
> >  err_invalid_vma:
> >       mutex_unlock(&alloc->mutex);
> >  err_get_alloc_mutex_failed:
> > -     if (mm_locked)
> > -             mmap_read_unlock(mm);
> > -     else
> > +     if (vma)
> >               vma_end_read(vma);
> > -err_mmap_read_lock_failed:
> > +err_vma_lock_failed:
> >       mmput_async(mm);
> >  err_mmget:
> >       return LRU_SKIP;
> > --
> > 2.55.0.508.g3f0d502094-goog
> >
>
> --
> Cheers, Lorenzo
