Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6258386554
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381700; cv=pass; b=hMAb5/WMe6Lrja3IlS93sVdv4DvqiIam8y9kp8wrZOTVgP8e7C97Wi8JuayNiq8EWCcU4zc9wfMCMshwFVc8jkJ+c6wU3hObePN1laRHl7KJ/V7ruJ7tQcsilN/DI2GHAmRoAMXYn/OCwvFj1u6KbqGCyVwsdl2AC57nC1hu0uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381700; c=relaxed/simple;
	bh=nSa1zdHAN9eX0hJQLyF9WHoTA9wz+uX7/MIrdtLFXjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvZrVoA0na2+0uDK8UIZIyZlv61WL9VO4aQ7DtvaYFyFyooehluyEqjs7fpDIni7dQbyicgPBWrAMt578FsgbMvPBcaSyRiON1S1ejATz/tlu9H589N7aXe4Z+GH0AO2p2bLoVosFAL8BNHJWK2k7n9S4S4rIMLLL27rdsmYKFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hnoxpLfE; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnoxpLfE"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c15a5b265so6181cf.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 10:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786381697; cv=none;
        d=google.com; s=arc-20260327;
        b=SNnOUPjnhhcMmzHPxlyDoZVchr143MHcj/yl+pgEBpnnSdDnm7mLruHrZCG+Tw3oi6
         HX+hOjbgDAmSN/NaAkXpXHRRfbL9OviVBQQQtOHZ+XLX0mXs/YI5wlPW68KexZqhxSIq
         ZUlJfhv5JhtUenCFi9r7kHHARage77vWQ0FJf9szO3vac5rw6YXPF756P0IZffJjw3cM
         neQZCnFz6Tl3FRL9o8plFNw7eU+ZOi6tSBOIqjUJ45eWXPRF23WjbG4toXL3SanT0sVS
         DnO+Ha47b3PsXNt34FPd2Q0Gbyslb/zTm0cMWYDljK/+UtYUys0r0HjM6sQBFn+obsy9
         YIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hw4jS8x5lX9rXtu6I0WYliCdVUT3IJTa3LUDLOz24sc=;
        fh=BWY8aZypPW8eDePfmkU1tGBC2NddCgqMgXkxtZHKwSY=;
        b=UPJpcXl8t/EBh9eM1YWP04TdZJGc44aEojAaWFS2vOm5+JVd0kLrTKC4k/0uPb/Gc1
         FEBu8Yt0htJeT4ewcnca85QUjitqynzYQeQDkqzb/dNKx7beVkEAud5rfBtrV43b/eku
         ZZ8T3tgvxTUOPa8p+wI8BREh+6v9V3CRSOolYGIngLDDXp8CL2T6A95m+iK7CFiKOY3F
         Zy7z7UL7t3oanS5A8rFE5x56bHyKpItI3I/ht848eYiwEqvAQ4wtB53FXbyGBd6omdtW
         gC/ApTzZsr0dthBuzw2gkQAUKqjHegjRj2zXhebNS2hxX487qdWAAgEasKlAKgekpbeK
         ji0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786381697; x=1786986497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hw4jS8x5lX9rXtu6I0WYliCdVUT3IJTa3LUDLOz24sc=;
        b=hnoxpLfEdh/WdMjYcrjgbOhkkS1nvGjiexE/5s1gcLmtZVwnN2YLEIoHBw+i6Aomhi
         M+Jq2DnpZLdndG3MOx0S546ziXQFF4QgxwM6yuspt5aBlP1oreyR9uKYOHFzsb33yLpc
         6eiwKYiaTBqf1xnbKGbFMiLUP/ij92hwvXslVOf4DSnH/IvvAb0o9V20NhHx6bc+OtdP
         rkN3W96+DTDRdK2fLlGmJU7WG8lxneEwd4qCY9WHpQpayauYyLRidT4AiuD3YBAYTshm
         nsAWPgI4TwLMjRUZtvYAbnUHOLWC9S9o4utRrCLoqS3weQNqYJkiWpk95yg+Ixd7xz66
         MBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786381697; x=1786986497;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hw4jS8x5lX9rXtu6I0WYliCdVUT3IJTa3LUDLOz24sc=;
        b=mVfeA8/bQZ4ouaMUC7G5Nd6nOLbbVtaCCLGWSbt9Kt3hTKD5K+fPeb0pwl3R4O7AE6
         wqQll4JikInXNl/pjAQ9UufITtLfhJN41deCNwMo/RumEvMyD7Uh5UzXcVszh/DrmDgt
         hjDw9A1uWypyFw0t/wcVJ7COlqD4/qDtcwKTPvpZzKcOxGgIfGcKtNUSxOYERbEiI/Pk
         GWG0YmdLq1lm/TTeKA0K5jGgQvwOox2dCCWS4M8L4+fD9RyNv6U4ZD23U2cgHsv1o50o
         Ph486whxAy14MG5C3YLTV2qVyhKLHnEaKC98454u6BexyJ2yu4Z3pn0H6v9SbXYcQg7q
         421w==
X-Forwarded-Encrypted: i=1; AHgh+RoAK6HB/DRxyz5hpmOL9jdm9E4yXFtnrcWf8XKWMh2stgjRQNOFKDz2k3CMSz+CIGPRlzg7SJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhZ5Pqr9YidqerAiKAwAIH5vcwp2v8E5FmnMmQzczRxp6DF/iJ
	JSMf6GYDiCIfFvS6JB9P2UsfZVhHFWZyiLgj9/pA/GKXz4JuXS9ub9+FJwoyCJ6K84FmCb7kMPa
	HvwWmdm5wQtTYwIeQ6Udn2AbFrSY8WNKccUupp2JF
X-Gm-Gg: AR+sD112IpXvpkaP8ZgTEJf4AR5wDgWEq6IdeFS8WxERhXyQuRQyGrYR4pt2S73e9Z9
	OGVFfRd1jmFP/G1q2yBBgGASe3PPNWHiAud3EIgxfwKFjpyWpn+kMMRDXcUYrLErZ+FtIF8yRGi
	i1nLD0d+eg8j9D6KA79x6ypKY2DL8L1VvXIdMXvuJnl1Fick1ScpJPSDiV/snhtW+PDbsXQ+bj3
	Qoy8fGgdIpd3R4LehkexirJBVen1XPukPL/1ekx5yL3poJOahYzQ/v9Z79KJmzbaFPVRVlAJdes
	oU+ELrmV+EFrnRdB20IAz2h6OVhujnBGptHvQnrQ0uqnJ4++YXfCmkh5AN9DvZS/NA==
X-Received: by 2002:a05:622a:e142:10b0:519:b655:235 with SMTP id
 d75a77b69052e-52d51249f79mr45641cf.3.1786381684618; Mon, 10 Aug 2026 10:08:04
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806200548.3124802-1-surenb@google.com> <20260806200548.3124802-4-surenb@google.com>
 <anmm18_pG4HXMZo_@lucifer>
In-Reply-To: <anmm18_pG4HXMZo_@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 10 Aug 2026 10:07:53 -0700
X-Gm-Features: AUfX_mzuGBlGghpOLfsrYokaQ8uXJHlSCTBj-M36Mn2c4Ekhhiai1f7pbLd7WRc
Message-ID: <CAJuCfpEQDCpTB5gv=x2A-K8_EvhFL84TbqmmyFFpszxomveV4A@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] mm: Add RCU-based VMA lookup helper that waits for writers
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, david@kernel.org, willy@infradead.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com, 
	aliceryhl@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 3:42=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Thu, Aug 06, 2026 at 01:05:46PM -0700, Suren Baghdasaryan wrote:
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> >
> > =3D=3D Background =3D=3D
> >
> > There are basically two parallel ways to look up a VMA: the
> > traditional way, which is protected by mmap_read_lock, and the RCU-base=
d
> > per-VMA lock way which is based on RCU and refcounts.
> >
> > =3D=3D Problem =3D=3D
> >
> > The mmap_lock one is more straightforward to use but it has a big
> > disadvantage in that it can not be mixed with page faults since those
> > can take mmap_lock for read, which can deadlock when mixed with nested
> > page faults and parallel writers.
> > For example:
> >
> >       mmap_read_lock(mm);
> >       // Another thread does mmap_write_lock().
> >       // New mmap_lock readers are blocked.
> >       vma =3D vma_lookup(mm, address);
> >       // This deadlocks on mmap_read_lock() if it faults:
> >       copy_from_user(address);
> >       mmap_read_unlock(mm);
> >
> > The per-VMA lock can be mixed with faults, but they can fail and need t=
o
> > be able to fall back to the traditional way.
>
> As discussed in reply to Matthew, this isn't so useful to have here I don=
't
> think.

Ack.

>
> >
> > =3D=3D Solution =3D=3D
> >
> > Add vma_start_read_unlocked() - a variant of the RCU-based lookup that
> > waits for writers. This is basically the same as the existing RCU-based
> > lookup, but on a failure to lock it temporarily takes mmap_lock for rea=
d
> > and waits for writers to finish before locking the VMA, dropping the
> > mmap_lock and returning the locked VMA. This has some advantages:
>
> Nitty but maybe reads better as something like:
>
>         ..., on failing to acquire the VMA lock it waits for writers to
>         finish by temporarily acquiring the mmap read lock and taking the
>         VMA lock with it held via vma_start_read_locked() before dropping
>         it again.

Sounds good. Will adopt your version/

>
> >
> >  1. Callers do not need to have a fallback path for when they
> >     collide with writers.
> >  2. It can be used in contexts where page faults can happen because
> >     it can take the mmap_lock for read but never *holds* it.
> >  3. Its fast path does not require taking mmap_lock for read.
> >
> > Basically, when applied correctly, this approach results in faster
> > *and* simpler code.
>
> I think this suffices as justification for the function with the above
> deadlock scenario simply excised.

Ack.

>
> >
> > While at it, fix the comments for vma_start_read_locked(),
> > vma_start_read_locked_nested(), and uffd_lock_vma().
> >
> > Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> Thanks :>)
>
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> LGTM, so with the changes to commit message applied feel free to add:
>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Thanks!

>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Lorenzo Stoakes <ljs@kernel.org>
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
> >  include/linux/mmap_lock.h | 19 +++++++++++++++----
> >  mm/mmap_lock.c            | 35 +++++++++++++++++++++++++++++++++++
> >  mm/userfaultfd.c          |  6 ++++--
> >  3 files changed, 54 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index 7b2bbb09a952..a23fe6cbe301 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -228,10 +228,14 @@ static inline void vma_refcount_put(struct vm_are=
a_struct *vma)
> >  }
> >
> >  /*
> > - * Use only while holding mmap read lock which guarantees that locking=
 will not
> > - * fail (nobody can concurrently write-lock the vma). vma_start_read()=
 should
> > + * Use only while holding mmap read lock which guarantees that vma loc=
k is not
> > + * contended (nobody can concurrently write-lock the vma). vma_start_r=
ead() should
> >   * not be used in such cases because it might fail due to mm_lock_seq =
overflow.
> >   * This functionality is used to obtain vma read lock and drop the mma=
p read lock.
> > + *
> > + * VMA can't be detached while we are holding mmap lock, therefore in =
practice this
> > + * function can fail only when there are so many readers that vm_refcn=
t overflows.
> > + * The failure case is very unlikely and is already annotated as such =
internally.
> >   */
> >  static inline bool vma_start_read_locked_nested(struct vm_area_struct =
*vma, int subclass)
> >  {
> > @@ -247,16 +251,23 @@ static inline bool vma_start_read_locked_nested(s=
truct vm_area_struct *vma, int
> >  }
> >
> >  /*
> > - * Use only while holding mmap read lock which guarantees that locking=
 will not
> > - * fail (nobody can concurrently write-lock the vma). vma_start_read()=
 should
> > + * Use only while holding mmap read lock which guarantees that vma loc=
k is not
> > + * contended (nobody can concurrently write-lock the vma). vma_start_r=
ead() should
> >   * not be used in such cases because it might fail due to mm_lock_seq =
overflow.
> >   * This functionality is used to obtain vma read lock and drop the mma=
p read lock.
> > + *
> > + * VMA can't be detached while we are holding mmap lock, therefore in =
practice this
> > + * function can fail only when there are so many readers that vm_refcn=
t overflows.
> > + * The failure case is very unlikely and is already annotated as such =
internally.
> >   */
> >  static inline bool vma_start_read_locked(struct vm_area_struct *vma)
> >  {
> >       return vma_start_read_locked_nested(vma, 0);
> >  }
> >
> > +struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
> > +                                            unsigned long address);
> > +
> >  static inline void vma_end_read(struct vm_area_struct *vma)
> >  {
> >       vma_refcount_put(vma);
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > index e20d01e8d38f..1c4902131e98 100644
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -338,6 +338,41 @@ struct vm_area_struct *lock_vma_under_rcu(struct m=
m_struct *mm,
> >       return NULL;
> >  }
> >
> > +/**
> > + * vma_start_read_unlocked() - Find the VMA covering 'address' and rea=
d-lock it.
> > + * @mm: the mm_struct of the address space to search
> > + * @address: address that the vma should contain
> > + *
> > + * The fast path does not take mmap_lock. Waits for writers to finish =
if the
> > + * VMA is being modified by taking mmap_lock.
> > + * Use when mmap_lock is not held, otherwise use vma_start_read_locked=
().
> > + * Nothing prevents VMAs being unmapped/mapped before or after the VMA=
 is
> > + * looked up, if a stronger guarantee is required, take an mmap_lock.
>
> Great thanks!
>
> > + *
> > + * Return: If a VMA exists which spans @address, return that VMA, read=
-locked.
> > + * If no VMA is mapped there or, very unlikely, a reference count over=
flow
> > + * occurred, return NULL.
> > + */
> > +struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
> > +                                            unsigned long address)
> > +{
> > +     struct vm_area_struct *vma;
> > +
> > +     /* Fast path: return stable VMA covering 'address': */
> > +     vma =3D lock_vma_under_rcu(mm, address);
> > +     if (vma)
> > +             return vma;
> > +
> > +     /* Slow path: preclude VMA writers by temporarily getting mmap re=
ad lock. */
> > +     mmap_read_lock(mm);
> > +     vma =3D vma_lookup(mm, address);
> > +     if (vma && !vma_start_read_locked(vma))
> > +             vma =3D NULL;
> > +     mmap_read_unlock(mm);
> > +
> > +     return vma;
> > +}
> > +
> >  static struct vm_area_struct *lock_next_vma_under_mmap_lock(struct mm_=
struct *mm,
> >                                                           struct vma_it=
erator *vmi,
> >                                                           unsigned long=
 from_addr)
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index edd90892f8cc..c3a0c38a3dc3 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -129,8 +129,10 @@ struct vm_area_struct *find_vma_and_prepare_anon(s=
truct mm_struct *mm,
> >   *
> >   * Should be called without holding mmap_lock.
> >   *
> > - * Return: A locked vma containing @address, -ENOENT if no vma is foun=
d, or
> > - * -ENOMEM if anon_vma couldn't be allocated.
> > + * Return: A locked vma containing @address, -ENOENT if no vma is foun=
d,
> > + * -ENOMEM if anon_vma couldn't be allocated, or -EAGAIN if vma refcou=
nt
> > + * overflow happened due to high number of readers and the caller shou=
ld
> > + * retry later.
> >   */
> >  static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
> >                                      unsigned long address)
> > --
> > 2.55.0.654.g21b8a5bc05-goog
> >
>
> --
> Cheers, Lorenzo
