Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9EE340412
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783696; cv=pass; b=et/naNdPZhA+5eh0JEw/M7N9AhAE4jayzghsfKXv1Qe7nLdb02s+N3g4a6k3wi3v7XUtthWU0eLD19Dc4kkB0oV4cNQQXNy5UhpQtzCsbRgGUg/xAm5LzVGoRPJ7hJgqUIyc+G4YR3s+8TFqVNCdhGaJQlgYczBaKmLcT5aIuMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783696; c=relaxed/simple;
	bh=viUukJkni6fTZJm8muyMTuzPQuEgbH19d/lzolLX6KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gm78ti+r826C7JrDti1DtoOCp2k2Q8r9B02fuGgUmKEf6+ZH1BX5yfHQr0YMEoN753AdqWLfvzMNuwkcD2qBt3UW9K/hVNpqe3G7QQEfNABvuponzeM1GufbbtR9Jc9CAe4xKdLEEHkSp5Tox3S4a14wThxj7W7lcGV5xSGMdaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGjK73uf; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGjK73uf"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c10e86e52so47001cf.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 12:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785783694; cv=none;
        d=google.com; s=arc-20260327;
        b=VXmMoQhCcvKDUTFabscjoXHZNJmtX8UHxf3vhZk4b2uCOp+SxZvz4sBbmHr6w6yjLk
         thUJV3W5l45Kh10yvovKoFWjmpq4X1B5+/KfGAuQtsmGtzhcTAnH2g76LLcRuawgeoWZ
         atZ5rm0u1SBxrKy4cpQ/Y5T1fL3WRiRtWmVlYgQHIO6xBHiUAZH0p2c4rAPMlhynO8fK
         iATIknWHFiMqR6l63SFUKItprrhkiaMlV5WMMmbwAQHC5UsLJd3zZihForxcK3r+6WBL
         +cmON3RcQTvSdzV79HtGjaczp5aAcQARdsJynkOHLQlq4Ef3k3ewpFKD9gNVuYhwG24+
         Ke+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R1gryesswu7LOxT7pEMybT/gxexwAugdJcKLJ1fyGvQ=;
        fh=ERzdbh0dygylaJnG8MShIiP7emK9FxDGFF+QA8W57qc=;
        b=csD7icKspfK9auEXmrq/9Kk8ZqHWyPoCm8Vwdf5RyAbx33YrhGQmwT5IiQdjqmlS/s
         qigKnXdAwaZzAS0tbO2EwSSOB2uBncG4e7x2ItO7tURxDPKI+/Q7CW9tHTw4q743gZtE
         gI7kDboFpq7a0BEJNTXRwk+jgZBaflnUcCqbYzKjgWLTDTTtVUVEZ1oeorMPud0M8e35
         YB7+8COdAaGs8FhYBaTTqkLOdYuzwnOVuH/wBiyDFOYftVhy1VKpEyw4L9ZLyuExnID3
         IgB0859JYhdquNTxSTVGswG77IwaR2OPRT1eaxcIfx6NivK3PIwgJkKFsXxbBrMZwyxI
         wMhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785783694; x=1786388494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R1gryesswu7LOxT7pEMybT/gxexwAugdJcKLJ1fyGvQ=;
        b=HGjK73ufaVepvmwXC1Cx/E0xE13/OoYhXXeG26uNrI+ex3qT2q2oEZlnoAAq2sYq/X
         0Moo7cqi3sSZsnUDtdaLeSIy0fKdSeVQlhBgeJ62KJa3vTsSjl85DL/NaXM7xrRCazvm
         rKBelcp4HEwrJtv3P0HlwHxQ4ugaaceQGBK8lKKGGGrce3+7z+n0Z5j8TnhJwC+zA7Es
         SvXSohnOD/2Y/WGsELEWZ0pz36uI93ziV+mK33ZgLArGueauWo/8nLMpPX1kvTX/plsv
         HBNIkicosS8ufSUtTxfHtj2oXAbRXB4ekxVuYKohp/z96MbnhPvywGXZ026I6rUXv5ze
         Jlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785783694; x=1786388494;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R1gryesswu7LOxT7pEMybT/gxexwAugdJcKLJ1fyGvQ=;
        b=PlxzhGRCoKHsHLSY2JT/n0xtnNDPY8YuSzyFsKWa+jiWm3KJdE9WG1zaO2TFLdW4Pc
         PeiYePzjvgchydyxvan4xm1FoXMYCOnOTVEFaNlLawcJFWTCzAX/dCx5960X0zP0BhL/
         h6DaPa8w6itu+O1FNqjIKX1V9TuBBtkk7w2kSQ7iRihTO9EZqT50JvXlq9vdcaJ4N9v6
         IhGUcRSVIrfVcvRynBOKvFqW/Ruj3bieCBMq+CNJpIvJYDIqAr4b/SewKlqe58qskuKW
         SF2TX2d1OH2Lm4h+PULym16dhWRAA14ZxnwUm2fSoRC008L1OitV2cmZ89L5Ke1kDtFQ
         TV0A==
X-Forwarded-Encrypted: i=1; AHgh+RpFI+ag44Kr2JmF3CHjxn8xtZgEHZXJmw7uZDVptHiScV0t2JbMkb5Fgc0FL2FBQsXo7KL7aCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxN5YkoBEvCZ4qUdwVEIgwwehO4CnmsdIbrg/+H7c2DigetP/d
	lSBBEZlrW4UOqcl5dEiVp5r8L3uYkH+qAIrku6I3zgAfk6dgRDfnhmb0Hk0yS9uFFcF5WcwPrV4
	FxRNCmd+nSWX3ScjMQznjL09kSdgXvoCC/kW3U6mm
X-Gm-Gg: AR+sD11QkKq7q8HIJQ9sNNC31TXhaZIfjk51vQ0OzcN2JT3TdGCfZnvEU6Xesuqxnai
	KfKhg65Ex7/gWCLkvAiC4FnBwoLMF0l9tL3sZfSK7hCKmPxGzORgUXU0Im7RUI97EQtoqkaNMsa
	0PQUte/w1VJspErzjbtUxadgGV/gbeIs8s6TNiG6MkvsHfaUWpQ2U1lDtYvIb6yKzBxLpv3D9Rv
	nQoe9txDg6BUeTcsIzPaxAjUToDQHLQBc4VgbuNorOfIbrKKrR4PGqG1q3NfinreX9QLYhKsBZb
	aeAXjCtewiUQXb+EBE4PYy5zj3Pn+AYuoHiINzZoTN0=
X-Received: by 2002:a05:622a:4286:b0:4ff:c0e7:be9c with SMTP id
 d75a77b69052e-52cd47ab104mr2015581cf.0.1785783693096; Mon, 03 Aug 2026
 12:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-4-surenb@google.com>
 <anB4uxEbKsa1Re0w@lucifer>
In-Reply-To: <anB4uxEbKsa1Re0w@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 3 Aug 2026 12:01:21 -0700
X-Gm-Features: AUfX_mzfHS3ktZjmk8ss0wM7ebtRwE-uigW3jVZ31a5V5rk8fb2Tzs2Fewwyfls
Message-ID: <CAJuCfpGXk8jfRrJ=JwMLvpzxbNnzJUOYRHfWUX5e4vgP5j72Og@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm: Add RCU-based VMA lookup helper that waits for writers
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

On Mon, Aug 3, 2026 at 4:28=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> On Sun, Aug 02, 2026 at 02:54:57PM -0700, Suren Baghdasaryan wrote:
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
> >
> > =3D=3D Solution =3D=3D
> >
> > Add a variant of the RCU-based lookup that waits for writers. This is
> > basically the same as the existing RCU-based lookup, but on a failure t=
o
> > lock it temporarily takes mmap_lock for read and waits for writers
> > to finish before locking the VMA, dropping the mmap_lock and returning
> > the locked VMA. This has some advantages:
> >
> >  1. Callers do not need to have a fallback path for when they
> >     collide with writers.
> >  2. It can be used in contexts where page faults can happen because
> >     it can take the mmap_lock for read but never *holds* it.
> >  3. Its fast path does not require taking mmap_lock for read.
> >
> > Basically, when applied correctly, this approach results in faster
> > *and* simpler code.
> >
>
> Would be nice to have a:
>
> Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Ack.

>
> Here given https://lore.kernel.org/linux-mm/af4Zx0gJIWbdDeY2@lucifer/ :)
>
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
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
> >  include/linux/mmap_lock.h | 15 +++++++++++----
> >  mm/mmap_lock.c            | 29 +++++++++++++++++++++++++++++
> >  mm/userfaultfd.c          |  6 ++++--
> >  3 files changed, 44 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index eb32b482434e..fdd8f5cf5722 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -228,10 +228,12 @@ static inline void vma_refcount_put(struct vm_are=
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
> > + * VMA can't be detached while we are holding mmap lock, therefore in =
practice this
> > + * function can fail only when there are so many readers that vm_refcn=
t overflows.
> >   */
> >  static inline bool vma_start_read_locked_nested(struct vm_area_struct =
*vma, int subclass)
> >  {
> > @@ -247,16 +249,21 @@ static inline bool vma_start_read_locked_nested(s=
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
> > + * VMA can't be detached while we are holding mmap lock, therefore in =
practice this
> > + * function can fail only when there are so many readers that vm_refcn=
t overflows.
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
> > index e20d01e8d38f..6ff05e68e61b 100644
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -338,6 +338,35 @@ struct vm_area_struct *lock_vma_under_rcu(struct m=
m_struct *mm,
> >       return NULL;
> >  }
> >
> > +/*
>
> Why not a kdoc comment?

Indeed. Will change.

>
> > + * Find the VMA covering 'address' and lock it for reading. Waits for =
writers to
> > + * finish if the VMA is being modified. Returns NULL if there is no VM=
A covering
> > + * 'address'.
> > + *
> > + * Use only in code paths where no mmap_lock and no VMA lock is held.
>
> Well, a VMA read lock can be held which would make this a noop essentiall=
y.
>
> If a VMA write lock is held you're also ok as the mmap read lock will pre=
clude
> an mmap write lock, meaning vma_end_write_all() will have been called and=
 the
> write lock released.
>
> So I think you can just drop this line?

Maybe instead of this I should say: Use when mmap_lock is not held,
otherwise use vma_start_read_locked() ? I think that was the original
reason for this comment.

>
> > + *
> > + * The fast path does not take mmap_lock.
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
>
> This maybe warrants an unlikely() given it can only happen if refcount
> overflows? Also worth having a comment to that effect here?

vma_start_read_locked()
  vma_start_read_locked()
    vma_start_read_locked_nested()
      unlikely(!__refcount_inc_not_zero_limited_acquire())

already contains "unlikely" clause. Do we need to add it in all its users?
I can modify the comment for vma_start_read_locked() stating that
refcount overflow is very unlikely. Would that work or do you want
callers to have that too?

>
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
>
> I'm guessing you're fixing this up as part of the patch? But it feels a b=
it
> random, I mean fine but you should mention this change in the commit mess=
age +
> explain why.

I'm fixing that because Vlastimil asked about these inconsistencies in
his previous review :)
I can package these fixes as a separate patch or add a comment in the
changelog, smth like "While at it, fix the comments for related
functions". Would that work?

>
> >   */
> >  static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
> >                                      unsigned long address)
> > --
> > 2.55.0.508.g3f0d502094-goog
> >
>
> --
> Cheers, Lorenzo
