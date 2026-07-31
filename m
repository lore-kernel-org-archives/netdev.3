Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992EF44E67C
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516072; cv=pass; b=fzVZ2ajp0SVAPIJAtZ6fuTIGuso6hkRnO0XJwzBB+nzClGAJ4n3edYAmziVrVjx/qMiWe1TvlQsqXtjmKGBGj/dvOCxdNT28GZZ8oMqBDK3pP4hpNj8XuGXa3bLiF9GfhULBGSjh9sRda9U9648u3jii8beT5mBRC5MbVyziD/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516072; c=relaxed/simple;
	bh=LDAI12GDdNlOLQXaMcEoG9I4i7EH8flzOwY4MCI4u/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1TJHNXnUmdOTUKJzQV43r/hyjilqFTo/6w9TLTAle7H67w6Vfmo7rhBxKNrBMK1bJdQdt+mP87o0Gp9zF6m0Yqb/Rq0Rrj+hd51yWOVVAAfz80dEX7kpa4GPdvgjtAhPaCSdK9jrz0oP+aNdx/jvDai2bZI3DI2pUU0UVwGxO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q6UX2svQ; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q6UX2svQ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c15a5b265so371801cf.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785516069; cv=none;
        d=google.com; s=arc-20260327;
        b=N4xulgzb7kwr6ydJXYsO3/pzI7L/wM6ZpUdUWag6e7VFNVV87y69fK75oHLHpuQ9v6
         NlshZN4GFKrtP1FwDPT81/D190tO62Xz5PtqoVjtBIYcQxECtOD4XWFFnavZOkDEUWdw
         GwK8VEhNbudBt6CMiz2io9oW2T+RiDQXnSQ1yLHnZC4xB7RfdWRcHwOLExvgvzW+xrUD
         22cmU/FEIpYAhoOLxpb7C/oUHk20pGA5dCjNGysOpz+EQhNz1Z2wYbunYb7h4n5bI4Y8
         DHJeFFmWFpNA3Dv9LvttcrIh7iHBxol5fSS3HH6B5aWW1lB25lVvUBMiMgDuGb8SlaPo
         LWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i+S0di2X0YwWIaY6VQuq99O/SRiscLkhJLs10nTFRS8=;
        fh=wahV1Vq+8zM6cX7P6rV7iSUG9Kl5CKJfeKUfkJ6Ajmo=;
        b=ZE8v0TrpQeYJw3Jq32rqCgPHBL3V5EmCmBujyGuEqvlvfw+FdvRbFAAU8jCkm/rtp6
         50GrQMThp6jrgZrqO1oPqqe3wegbm1tYfQkuZemw1Ta3EZyjLPTwg0WtXExoxKWIKrxE
         P1ayX6L4ZseOLI076dYV6TJrPMgqUafcEnyYsYFdjG8+wJeNaWBAwuDGdsJYUZHUQOZn
         dB+lZT+aKVJ4BgBIecgdvBCfinHf+UungP3IkfESXstwx3zaIqytzqT1Aioddv7QVbn/
         Q8Q0fWNZzvGtewFUCtiuf0oOuFvh8vNdIFZxTQhVB2GoU0/HW9JRRCpzBFo3GCHHzCxy
         Z5XA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785516069; x=1786120869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i+S0di2X0YwWIaY6VQuq99O/SRiscLkhJLs10nTFRS8=;
        b=q6UX2svQyO8DVyeuezRCDiFqF6jo5+g8/6xReQW2NA8fhBp0X21KQlbws1oLFj9QwR
         R08S/AeERId2iYrBMF26742AKYg4ULFD9pM3rJC6dEt1k9raz2czx0N4LTHMxEX7PatF
         51jAuct7VriPdtKNOZkaJW6iRqgYAOc2xg35sJj+44LwVx7GvD6NCsbhw7cG5o9jxFCZ
         +DE8wB/1DsYWKdbQ1KkmdgxtqU3tw6tdL5doLsgX8M0uBWWW4oiNxJfZ+upBmNjg4kkR
         nTUDGbLhMHFHgg2jfosCaQcyxuwJdDqTIdHVpWLWeuCSXOelS9H1nxaJrPgKKVJNnXKj
         dswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516069; x=1786120869;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+S0di2X0YwWIaY6VQuq99O/SRiscLkhJLs10nTFRS8=;
        b=nB2UUiZbF9hi2nLzZqedIaQUXd9YRPd8XVArGAepKxvo4Z3OhPn6mf93xP3q8PVrRT
         nny+rsiHREgm7OrGWz8OHljfnFR4z3eQHaMyE2nkuI4VF6neDaquGgNQD8ysgJ9WGcWa
         ts/vvI7jWW4/7h87hSyFYy2x9jRQnP/HSx27Q8BH8hRh5aUJNUm3bocdgvpKxra0LJWw
         +Ar+6SSmNIQMq87MEHOrhpus78kwJ4albXnBI4AwIo0ODX2zqdnoUM3wvTiEHYP6zNPt
         8KfIVTiONJFOnFL41vTnFg9ERMsXuJoDb06PZqzn1Zlb+0h8wmSArmE9uSg7yyB+/JP8
         7G0A==
X-Forwarded-Encrypted: i=1; AHgh+Rp0k5TmM7ucmTJhALqRpaGDxH8fwtEX6s6zTQnk2kNXK757DtMQjvCRyy49BX2S+pss/UTpphQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDrZHdswFkkK0lroTdt0c1YPbJx6nQp+gHDcaSfoxHfpKCljBf
	ItjaDn3WPYy27qGyCMZfaWq6NuAeFZXXx/FobWwiQVLGOLphvyQuO3OBKUF63Tm82c/uCCNJxnI
	alVZYegYvB4wYvo1TTQI1uh4EqyZpHJAcQobXrqtK
X-Gm-Gg: AR+sD13oOxIF9x4jNAky2aqjG74ahEicp6ahjffORXVdagsMsU9RjB4CriShhNSgM5b
	XDmM/kmR8apQDRLaDArPDaTX66avVvDORaS32rsg4yiNibkkzT/D9jFWZEUL7YojaASNkzmTNHU
	IkiQ/O5J1su+QBpPjFGxnHRXnDl/707gViNlkjngxi65IeFVcDL1C96a0epXfkeKn2+JxQa3NlS
	ihDVDb8HvnjU0qatBCHWZ7J9+BFyHoc6BA5LmwQhU0ASH720ldJpa8RWR5gBzaUiWbtANiP0hnZ
	fpHes2QW6SYsNJeVQGbXCvczdGDd58E4BuXFx0tL/F7i4rDD75BIEMzQFNOLGA0kaJjSJtLL
X-Received: by 2002:ac8:598e:0:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-52b4aeef4cbmr14633211cf.1.1785516068661; Fri, 31 Jul 2026
 09:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
 <20260610230415.C0521C88@davehans-spike.ostc.intel.com> <5b27d22d-a3fd-4267-b63b-5de9e6586d5e@kernel.org>
In-Reply-To: <5b27d22d-a3fd-4267-b63b-5de9e6586d5e@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 31 Jul 2026 16:40:57 +0000
X-Gm-Features: AUfX_myd8WR-rKHyxTRYIqU4O90PcBqOHaAe_5w4HYy9Kvov8AvwQm8q27RX__E
Message-ID: <CAJuCfpEnzS7KxYsxU4kTTGFsdYrgpY2gQ46nHR1QacyqLBo9Nw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: Add RCU-based VMA lookup helper that waits for writers
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Carlos Llamas <cmllamas@google.com>, Christian Brauner <christian@brauner.io>, 
	David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org, 
	Shakeel Butt <shakeel.butt@linux.dev>, Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 6:00=E2=80=AFPM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> On 6/11/26 01:04, Dave Hansen wrote:
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> >
> > =3D=3D Background =3D=3D
> >
> > There are basically two parallel ways to look up a VMA: the
> > traditional way, which is protected by mmap_lock, and the RCU-based
> > per-VMA lock way which is based on RCU and refcounts.
> >
> > =3D=3D Problem =3D=3D
> >
> > The mmap_lock one is more straightforward to use but it has a big
> > disadvantage in that it can not be mixed with page faults since those
> > can take mmap_lock for read, which can deadlock when mixed with page
> > faults. For example:
>
> ... mixed with nested page faults and parallel writers, perhaps?
>
> >
> >       mmap_read_lock(mm);
> >       // Another thread does mmap_write_lock().
> >       // New mmap_lock readers are blocked.
> >       vma =3D vma_lookup(mm, address);
> >       // This deadlocks on mmap_read_lock() if it faults:
> >       copy_from_user(address);
> >       mmap_read_unlock(mm);
> >
> > The RCU one can be mixed with faults, but it is not available in all
>
> I'd stick to the per-VMA lock term than "RCU one"
>
> > configs, so all RCU users need to be able to fall back to the
> > traditional way.
>
> This is now an obsolete statement as patch 1 makes them available? But th=
e
> problem is that they can fail and using mmap read lock as a fallback in a
> simple way has the above issue?
>
> > =3D=3D Solution =3D=3D
> >
> > Add a variant of the RCU-based lookup that waits for writers. This is
> > basically the same as the existing RCU-based lookup, but it also takes
> > mmap_lock for read and waits for writers to finish before returning
> > the VMA. This has some advantages:
>
> I would stress the part that the mmap lock is taken *only temporarily* to
> wait for the writers and ensure we obtain a per-vma read lock, and then
> dropped again? As that's the main trick IIUC.
>
> >  1. Callers do not need to have a fallback path for when they
> >     collide with writers.
> >  2. It can be used in contexts where page faults can happen because
> >     it can take the mmap_lock for read but never *holds* it.
> >  3. Its fast path does not require taking mmap_lock for read.
> >
> > Basically, when applied correctly, this approach results in faster
> > *and* simpler code.
> >
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
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
> >
> > --
> >
> > Changes from v1:
> >  * Add a comment explaining that this can not be mixed with other
> >    per-VMA lock or mmap_lock users. It is prone to deadlocks if so.
> >  * Add a FIXME about making the mmap_read_lock() killable
>
> I don't see it anywhere?
>
> >  * Add more chaneglog bits about the possibility for an infinite goto
> >    loop.
> >  * Adopt vma_start_read_unlocked() implementation from Lorenzo
> > ---
> >
> >  b/include/linux/mmap_lock.h |    3 +++
> >  b/mm/mmap_lock.c            |   27 +++++++++++++++++++++++++++
> >  2 files changed, 30 insertions(+)
> >
> > diff -puN include/linux/mmap_lock.h~lock-vma-under-rcu-wait include/lin=
ux/mmap_lock.h
> > --- a/include/linux/mmap_lock.h~lock-vma-under-rcu-wait       2026-06-1=
0 15:57:55.828431712 -0700
> > +++ b/include/linux/mmap_lock.h       2026-06-10 15:57:55.834431925 -07=
00
> > @@ -257,6 +257,9 @@ static inline bool vma_start_read_locked
> >       return vma_start_read_locked_nested(vma, 0);
> >  }
> >
> > +struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
> > +                                            unsigned long address);
> > +
> >  static inline void vma_end_read(struct vm_area_struct *vma)
> >  {
> >       vma_refcount_put(vma);
> > diff -puN mm/mmap_lock.c~lock-vma-under-rcu-wait mm/mmap_lock.c
> > --- a/mm/mmap_lock.c~lock-vma-under-rcu-wait  2026-06-10 15:57:55.83143=
1819 -0700
> > +++ b/mm/mmap_lock.c  2026-06-10 16:02:50.723860779 -0700
> > @@ -338,6 +338,33 @@ inval:
> >       return NULL;
> >  }
> >
> > +/*
> > + * Find the VMA covering 'address' and lock it for reading. Waits for =
writers to
> > + * finish if the VMA is being modified. Returns NULL if there is no VM=
A covering
> > + * 'address'.
> > + *
> > + * Use only in code paths where no mmap_lock and no VMA lock is held.
>
> I think we have various asserts that could be used and are stronger than =
a
> comment ;)

I'm working on a resping for this patchset (per Dave's request) and
I'm not sure which asserts we can use to assert that locks are *not*
held. I think that would be a racy assertion anyway (the lock might be
taken right after that assert) but maybe I'm wrong?

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
> > +     /* Slow path: preclude VMA writers by getting mmap read lock. */
>
> Again I would say "temporarily".
>
> > +     guard(rwsem_read)(&mm->mmap_lock);
>
> Aside from the missing vma_lookup() I'm not sure we should also trust the
> result of the lookup blindly? Should we also verify we found a vma? Some
> callers might not fail the lookup because they will only lookup something
> that's sure to be present, but some might fail?
>
> > +     if (!vma_start_read_locked(vma))
> > +             return NULL;
>
> You can count me on the side that would rather see explicit operations th=
an
> the guard. Exactly because it's a subtle usage of the mmap sem, and yeah
> also the tracing that Suren pointed out.
>
> Seems to me uffd_lock_vma() mostly does all this right (but also does mor=
e
> stuff that we don't want to do). I'm just not sure right know when
> vma_start_read_locked() failures can happen in practice here (can it be o=
nly
> recfount overflow or also refcount being zero? hopefully not zero if we
> found the vma under mmap lock for read? comment in
> lock_next_vma_under_mmap_lock() seems to hint at that) and what to do abo=
ut
> them. We seem to have some unhelpfully stale comments around.
>
> - uffd_lock_vma() doesn't document that it can return -EAGAIN. (and shoul=
d
> the caller then retry or what?)
>
> - vma_start_read_locked() has a comment saying how it cannot fail, but it=
 in
> fact can.

I'll modify the comments for these functions to be clearer and more complet=
e.

>
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
> > _
>
