Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B323090D4
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388060; cv=pass; b=MocPFVdaNX+L0tqS3uAm7dF0ua/eIL2155giR1IUK6oVVjeC7Qe849n49vzKqC+TWeD88MHlwj1Wd+9x0QvukGNnoOHKxeN9UQyXvd8+Kasof/y2g+ZT80wsb1VEMmNduerZvw9tW71yam9+5oBscYnZeUQiNyKnyFWFI54FZSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388060; c=relaxed/simple;
	bh=NlSI2moNj9tT3cIujFDCl/gcfLG56WTsU23E2qkOvSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzdhW60h7Bj3G5IXgF5RoE+nUItEC/Pcc3weX/K0TRx/ywvvmOXtVdLuECYWswPI8EKFhaIqkFr33io2KBWbF3MA1WYVcspsJvSQOUBBjUUmIOfamcZhTys+T/yptnqrDp00EvUn4xU4ypq69zhaAJ+XHJQuG2x6uagbMAkcAHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=deqKIXEw; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="deqKIXEw"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c10ed63c0so33501cf.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:54:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786388057; cv=none;
        d=google.com; s=arc-20260327;
        b=jSc8O5IQnHd11QDPXkWVTUtMC0dV2AnBsQlcDKuHrZt/fGoAuYXMOonaksHa7GGG+C
         39M4gGHWs6n21d+W0kLNi4xen1ifm4e0EjkLPOmWuR12tlmkgSvjfZdVL0y8KGq1lQWi
         uP7kXAjU6k7lwA3HuA0bUjnDcKQvOthKyx+ii6C79ZwlZkbaQ4ab1/CdkQ2ewGPOgF6J
         Euw2cLYtYRNbiKQVIZG2ayfKpDHwSDIjJqQX2quS9gvECiyazEDd8gxnv+QiTljaWb+K
         WtdSGuYVNV4xl2Hf+nfRKivPuANZlSLHFJYaGZhYeRaA7fbtaZ7FZel6cqaFF73f3Qiv
         tC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BFLIcMV+TsQl8fF5Kcteeza9u+Vqp87MX/t5s46zNlY=;
        fh=QlUtdUyT9+x57ImxQab1n+s8kPOrbc92MabvCm2MsH4=;
        b=gLQ9SRIEEGCdRk3h0pNNtTGi/tuiNY1GP25M26jagaoszgYZjQTd84srhinuQ/fUnZ
         7xqACCNNDfjD0Hs0MW0ORSgVHt+zcjSyizi/dNPIevS+CYYqji1UcJGW5DEd+rR3ExWg
         TpymSyJMaEzeclInDNv68evFVqF0sz1RL4CRc4qazULIKLXHQ8fy08Iz21HnQ1DyEsl7
         YktnE1ZVR93QoBvMzTunzLSeaQPNbxkp3ERqLZDssSUImsZuhvI1CWncO7tfiZ7zmEAf
         PtsG0E67t+84oJt2Y3m/Z6QN4FYqAPq5b/i/ytepNqowdAPGJPzF+nEKk3FvMO85CrFY
         ES4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786388057; x=1786992857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BFLIcMV+TsQl8fF5Kcteeza9u+Vqp87MX/t5s46zNlY=;
        b=deqKIXEwygFjnXaxz7GzVx+oG5U9LW10QV78fahTSycxuX2frb4vgfn2ErLEzCeF4r
         6D8ZCIH2/FsrALJu1AywKxKcBbhQfCbdiOJt0mfBZfWSFCY7kLqRCzAhTvX6LfrXVTkc
         FdcEkvMGeB8+LuS4KifqnJ0e0bYL3HiwMsPwLirEJqU+TMLr6fch/4Ff5/SA7iYPBePH
         KMeO6t6ZdNqWrCYMwHbnSpl5FeTp2m0ZLtLw4As60j+lazUbnuvEX5cDaHzgmjWlTnOH
         5kLHA5dM7CgVxcHkTAToWNTEVLXXhpErB+MeQshxpZEIXWIZvuVICim2yrUEfGVIIz17
         sb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786388057; x=1786992857;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BFLIcMV+TsQl8fF5Kcteeza9u+Vqp87MX/t5s46zNlY=;
        b=rga5kHAE6eTQxHch0jIOQFILOLO21mNf5Y+pJYztSGQf/iqW3h0QP6NrZDoNUI94Zj
         M/FLAeb4EqRs6LlJFVMMbATzcRnkRXmHdRBdtKO+z2wgtJdSo2bDT30MKN9HCMbxyvTI
         fUVT21py3O7+cRXUnTab0p+++IZJVRHTKr91YhswfcxiahUBGCuoCA819pzkzwt/oE07
         HksFqL+L/olBk/gFGui+TXdfkukvos9XMN3qHNswEoW3lVlKvXqaM6O3ufYQslKtSAUf
         ciW4GdN2xkZwryAcSiw044FWGcE2x2YJkOJKeXzJU1BhRzx951ti2qiYPREowHrQ73gk
         uGew==
X-Forwarded-Encrypted: i=1; AHgh+RqokvXmRptt/O9AyQc51sTDZvY1cm5ICPEZtgE8KXtRJfn9Wq4xn3LUV1JNrUEuGPmJkwNLXhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwDYowAe7f14yQGzCCxLKP+Gd+PKlK51q+dODnHaW02vQFfiAK
	8WJygt7d2MXpJ0jLxk0rZNNobGbii6CGNYOFAg7LXdfFxv6BlZNUX6roPC2y4ZUbLRT+cOogzYz
	YySbS/II+VzTdekiiQYxwZBbY9TIkSYFfwVyZqDCh
X-Gm-Gg: AR+sD12/YBnsIWGruWvi49P9daYV66R3UvyAflwxJ7fiHjfz56uVtxznnMJlNxHkyfU
	+0lptjvecNcyoS27Q/6ktlhUaQfcqo+BrpyJxg84V0uVseLLT/tytMddVTSdMSBzrIiQCrzK/FA
	eo7rRX5T4hXNVhPWZWioqxoFFV4Y+twwONOvUVDvVvZcET2wsv3VBs4/jgXYiVIFP3p7ymMzKAR
	YIZb1gEyMlVnizSTlFBaqvJfJrT4fJ4XcRAfQo9iVBh02QBUIpXu5VGAfTJk/FRj48201vvJbVn
	VHZ8Zlm4pU7JS81/oy6ktDs7DlHhjzR8owFloS3/j44=
X-Received: by 2002:a05:622a:9d3:10b0:517:64f6:3365 with SMTP id
 d75a77b69052e-52d51130743mr2428451cf.4.1786388056958; Mon, 10 Aug 2026
 11:54:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806200548.3124802-1-surenb@google.com> <20260806200548.3124802-3-surenb@google.com>
 <anoZL76y3WGXMArB@google.com>
In-Reply-To: <anoZL76y3WGXMArB@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 10 Aug 2026 11:54:04 -0700
X-Gm-Features: AUfX_mzCGUT1LBwKi19AfwqzrR1sfNDLiDeo-oSbRDVrC4hKEjbi43WPU9iVR8M
Message-ID: <CAJuCfpFCK5ycO6s+dD35YtU6zgNdivfe6P3cVnd2VxPYfGXHDQ@mail.gmail.com>
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

On Mon, Aug 10, 2026 at 11:32=E2=80=AFAM Carlos Llamas <cmllamas@google.com=
> wrote:
>
> On Thu, Aug 06, 2026 at 01:05:45PM -0700, Suren Baghdasaryan wrote:
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
> > The removal of the fallback does not affect NOMMU case because binder
> > driver depends on CONFIG_MMU.
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
> >  drivers/android/binder_alloc.c | 45 ++++++++++++++++------------------
> >  1 file changed, 21 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_al=
loc.c
> > index e4488ad86a65..c13a588c37de 100644
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
> > @@ -1151,27 +1150,25 @@ enum lru_status binder_alloc_free_page(struct l=
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
> Do we need to explain how lock_vma_under_rcu() works here?
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
> The comments seem redundant, the label is enough. This works:
>
>         vma =3D lock_vma_under_rcu(mm, page_addr);
>         if (!vma && binder_alloc_is_mapped(alloc))
>                 goto err_vma_lock_failed;

Yeah, for the binder maintainers what's happening here is probably
obvious, but when Alice explained the logic to me, this comment really
clarified what's going on, so I added it here. If you insist on
removing it, I'll do that of course.

>
>
> >       }
> >
> >       if (!mutex_trylock(&alloc->mutex))
> >               goto err_get_alloc_mutex_failed;
> >
> > -     /*
> > -      * Since a binder_alloc can only be mapped once, we ensure
> > -      * the vma corresponds to this mapping by checking whether
> > -      * the binder_alloc is still mapped.
> > -      */
> > -     if (vma && !binder_alloc_is_mapped(alloc))
> > -             goto err_invalid_vma;
> > -
>
> This introduces an "extra" change. We'll now release pages without a
> valid vma (e.g. after munmap()). Before, these pages were expected to be
> released via close() in binder_alloc_deferred_release() later.
>
> I don't see anything wrong with it. However, it does seem out of the
> scope of this patch which just drops the mmap_read_lock() calls. Or at
> least I don't see how this part is necessary.

This check came from this discussion:
https://lore.kernel.org/all/anGrFIYiPhjxWSkD@google.com/
It's added for consistency when handling cases where the original
Binder VMA is gone.

>
> >       trace_binder_unmap_kernel_start(alloc, index);
> >
> >       page_to_free =3D alloc->pages[index];
> > @@ -1182,7 +1179,12 @@ enum lru_status binder_alloc_free_page(struct li=
st_head *item,
> >       list_lru_isolate(lru, item);
> >       spin_unlock(&lru->lock);
> >
> > -     if (vma) {
> > +     /*
> > +      * Since a binder_alloc can only be mapped once, we ensure
> > +      * the vma corresponds to this mapping by checking whether
> > +      * the binder_alloc is still mapped.
> > +      */
> > +     if (vma && binder_alloc_is_mapped(alloc)) {
> >               trace_binder_unmap_user_start(alloc, index);
> >
> >               zap_vma_range(vma, page_addr, PAGE_SIZE);
> > @@ -1191,23 +1193,18 @@ enum lru_status binder_alloc_free_page(struct l=
ist_head *item,
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
> >
> >       return LRU_REMOVED_RETRY;
> >
> > -err_invalid_vma:
> >       mutex_unlock(&alloc->mutex);
>
> This mutex_unlock() is now dead-code.

Ack. Will remove.

>
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
> > 2.55.0.654.g21b8a5bc05-goog
> >
