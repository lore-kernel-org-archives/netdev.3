Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C3E2D3733
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784422; cv=pass; b=KC0b26QVkmuIT0RyHoF7vMczFBhBQrnCm/I7KzGkhe8QvnjPf1rwRlWNTc0KqLF86WD18hb8KHvCEoBEwGiyOBDAHvfQIe2LIz9S0IS8hFpD+5EWziDpI15nXaxkxNfoSwCQE1OPwOEQa38P+WQgPOt65kK9Gtk9weGFxHftGuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784422; c=relaxed/simple;
	bh=qm4+wqLubojNToZusAEJEz3uQv5GMmUDzX3iDTdVO5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwQPF7xYlFzUiSy28l2KVcBhucPuelt3pwjGFL+u7w3Qqa3V+ZyFYC9gnTWf8xgHNrvkCPpCUodIWGZGO5pR4QlBhSVoBP7RPqKK/ruPPKDKlo+95ueJiVrfHkRhrSxW8FwJ5tb7koNvARNxpI8Fa1iYiyFI3tckNVpAvsonzC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bCODPOUa; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCODPOUa"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c01c79467so57491cf.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 12:13:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785784419; cv=none;
        d=google.com; s=arc-20260327;
        b=DvfHMLTYg3vDtLFr6USwljcXNu5k9Wa8mT8zGnOeVO8GRGpswzrWjKUMjWayH+VcZX
         ZQNLK1ismPMslr7+4ctlUeFy+M6NbWz3IdRS0JZe6ChOQgoTcRh7z0+XC//F+5Y6zL90
         /QzUNWbkZbNRiq6OsgJaT9zeAVD2KsjTeVtXXkDsqzy9XUA9gzDegCEKUdmpo3m3XF69
         Z835MKKJLGbL2QFOrJITpH/E/RDZAvtjPP8PhOX8ergL+QtG7KxI/kXNGQb9gJqT747J
         5UGUcXOdeNYxG92Na1XSiJLdovRve8FGXIc2BA6ZG3SS3QB1aIxa7DI05yLebiD106OI
         9bRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kVJfjo5glrhbtnsH0cPaVmUOmhUGiMwC66kCF9ApoHk=;
        fh=VlkVQraJuPeM8FQ4+cy53wKHoOwQbZEMH2THgUFZJPY=;
        b=dM+xgeuGwSWyOiGu1VUp8yiOnYtBLjIR+iDY7xKPwilLRT9KJaEbjPKSjaOmfJjbh4
         59LG3UB548oXQgoHEOSYUoKQtipZLCfys51leIU6LXFLRK6PkMTkJ4kNS7y9SjssDpEZ
         wa+LfwLwOr0EJDxN3OsqN2goA9NAISdXGoCKqAb7YhbGoV325LtPXDKxUS9tEALF3y1L
         XKwHoG4imWjUkJat3Y+taEfd3+USZKipma3efYe4rFrQ+/5MuqKbI4wUxIt+VaWcRr2v
         yetotrsg9hgeWCrIu0p0++SGz1A4cJkZtoBahF0tL5y6+8cPGxSWWf+bGEIRTTN+4Fgq
         MTgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785784419; x=1786389219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kVJfjo5glrhbtnsH0cPaVmUOmhUGiMwC66kCF9ApoHk=;
        b=bCODPOUaLFzx7ufD2zzURz/KqrP9DbXgY0nKL1fR7c4tJbVGRqhG11DweCTJOzNTj0
         ZZU3hvEEJbUGNHLyOaKueMA5VPlu/cPnxmgQaIlPQtoQF2tGGMkTu7bcm/8j+ZdhkkgE
         AWKTv7Kt6uqORSJ9HDT6pEm16WFE0v32ltlslQfoI4VisqaRTRPyYWmGz5AACHqcU7JQ
         kb2YYMME5N+X2PGGG5T8OIIyj388iYIeTcF8EDbcvupUKrAwKlh1INPL0QOLyseogCad
         hqbNxlZY3ZVquLiIB6H8OfLo2gpX5KFTKzUJBBLXoCSPtdGLDryRDQ0KzzusdWKxogCp
         /ivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785784419; x=1786389219;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kVJfjo5glrhbtnsH0cPaVmUOmhUGiMwC66kCF9ApoHk=;
        b=LVegu+/5UJsw8mltp6MJU2ASpKhD/RCzIx5K1CzQiQufpczai9SH4Imf9DdwUkizTl
         d61xIX1hP+iuFfY3IWzxJqbLax7jpEUSBFYeoFfkl/GNYYGymBb4nQrA8M7ohIKjH/2W
         igneTtKNns3XtM1WxOdd6KRiN6ltV3Rn+0ZTparVOvXuivXCJUI9kxfOK8pedpEV7EV3
         i7hPOYa+hQvO0r/6fjndrR8MNyO8hWgtB2WsQ0O2w3o+QgekdxgWNv2dQyutiWJQH/Ly
         MrSxaAbuZsyftkvwv1ZRU5BIV2J+bA8LaE66HBcLSwHkkev8Jh9v3d3022jA8dDTj2ff
         j/zw==
X-Forwarded-Encrypted: i=1; AHgh+RogwEp1MtjeFr9gVQYbagHJ8LB+ERMg7JNsUzHcJcSvz5zPs30Z2V6FmLgXfERHjhkttcjlyUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEtfo7jI55Qt8XcLg4pHXR2w0sv/1yzMXnd+xoVqFpKgcrus7U
	zH/TrK5BuPeW8WkZpZ4RglcooYPstYBtL8/I2iAXKCPLMDUbL6Nan+xIX+C42eSiTdNeSQg9uqz
	rjxeSSvj9Zs8UXP4WxOLk3c610eenbfK4crfyN8OH
X-Gm-Gg: AR+sD11+VvitlMstGL9LugED+rD1T4U3iHu4PRLUXJSQwrTTD+v3yf0OkDhvE84Ef7q
	2SJt52Xljamyy3qC7lxZWVFwdSEwBwFNExr3TO3asvW4bIolvsrJlMmEZlPaqm5mRzwO1gcoLGI
	LQIl0m5RIEluRd9mVSboSSu0yV4qw/UXWt1ROlzDRxH0wDzZx957ZgIezjYTY46RIy3CicITXh1
	TIrfTwDK10jUdB1PnvdZZT4/m7cJs87mYyrvbXpeL+f47yPJV8EhA65nw+XgkPdsL/UJ1wdDV/s
	ycEFrDrmy/374FaDvscIH4EIfgesY3HRY1RmAeQ5BBQ=
X-Received: by 2002:a05:622a:1245:b0:52c:d3a1:358c with SMTP id
 d75a77b69052e-52cd4fc8ae1mr1989871cf.16.1785784418356; Mon, 03 Aug 2026
 12:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-4-surenb@google.com>
 <152ee467-b5e4-470c-ad95-c638aa9986bc@kernel.org> <anCst8u7ybHf39n8@lucifer>
 <9c301dd5-76cc-40dc-bbab-a79559d6db1a@kernel.org> <anDBVu0PIzy7dks-@lucifer>
In-Reply-To: <anDBVu0PIzy7dks-@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 3 Aug 2026 12:13:25 -0700
X-Gm-Features: AUfX_mwQxdWzx1zQARcqH0kWX7mHq63TE2aOrOqiGijIcM6ixMYrduESoAttqUM
Message-ID: <CAJuCfpEYFs94heKZn3hikYuCJU3CEHr2u1SSxXMyFQwHHAcjDg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm: Add RCU-based VMA lookup helper that waits for writers
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, david@redhat.com, 
	willy@infradead.org, shakeel.butt@linux.dev, jannh@google.com, 
	aliceryhl@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 9:44=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> On Mon, Aug 03, 2026 at 06:24:34PM +0200, Vlastimil Babka (SUSE) wrote:
> > On 8/3/26 17:00, Lorenzo Stoakes (ARM) wrote:
> > > On Mon, Aug 03, 2026 at 04:55:19PM +0200, Vlastimil Babka (SUSE) wrot=
e:
> > >> On 8/2/26 23:54, Suren Baghdasaryan wrote:
> > >> > From: Dave Hansen <dave.hansen@linux.intel.com>
> > >> >
> > >> > =3D=3D Background =3D=3D
> > >> >
> > >> > There are basically two parallel ways to look up a VMA: the
> > >> > traditional way, which is protected by mmap_read_lock, and the RCU=
-based
> > >> > per-VMA lock way which is based on RCU and refcounts.
> > >> >
> > >> > =3D=3D Problem =3D=3D
> > >> >
> > >> > The mmap_lock one is more straightforward to use but it has a big
> > >> > disadvantage in that it can not be mixed with page faults since th=
ose
> > >> > can take mmap_lock for read, which can deadlock when mixed with ne=
sted
> > >> > page faults and parallel writers.
> > >> > For example:
> > >> >
> > >> >  mmap_read_lock(mm);
> > >> >  // Another thread does mmap_write_lock().
> > >> >  // New mmap_lock readers are blocked.
> > >> >  vma =3D vma_lookup(mm, address);
> > >> >  // This deadlocks on mmap_read_lock() if it faults:
> > >> >  copy_from_user(address);
> > >> >  mmap_read_unlock(mm);
> > >> >
> > >> > The per-VMA lock can be mixed with faults, but they can fail and n=
eed to
> > >> > be able to fall back to the traditional way.
> > >> >
> > >> > =3D=3D Solution =3D=3D
> > >> >
> > >> > Add a variant of the RCU-based lookup that waits for writers. This=
 is
> > >> > basically the same as the existing RCU-based lookup, but on a fail=
ure to
> > >> > lock it temporarily takes mmap_lock for read and waits for writers
> > >> > to finish before locking the VMA, dropping the mmap_lock and retur=
ning
> > >> > the locked VMA. This has some advantages:
> > >>
> > >> Maybe mention that the helper is called vma_start_read_unlocked()?

Ack.

> > >>
> > >> >
> > >> >  1. Callers do not need to have a fallback path for when they
> > >> >     collide with writers.
> > >> >  2. It can be used in contexts where page faults can happen becaus=
e
> > >> >     it can take the mmap_lock for read but never *holds* it.
> > >> >  3. Its fast path does not require taking mmap_lock for read.
> > >> >
> > >> > Basically, when applied correctly, this approach results in faster
> > >> > *and* simpler code.
> > >> >
> > >> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > >> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >> > Cc: Suren Baghdasaryan <surenb@google.com>
> > >> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > >> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > >> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > >> > Cc: Vlastimil Babka <vbabka@kernel.org>
> > >> > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > >> > Cc: linux-mm@kvack.org
> > >> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >> > Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> > >> > Cc: Todd Kjos <tkjos@android.com>
> > >> > Cc: Christian Brauner <christian@brauner.io>
> > >> > Cc: Carlos Llamas <cmllamas@google.com>
> > >> > Cc: Alice Ryhl <aliceryhl@google.com>
> > >> > Cc: "David S. Miller" <davem@davemloft.net>
> > >> > Cc: David Ahern <dsahern@kernel.org>
> > >> > Cc: netdev@vger.kernel.org
> > >> > ---
> > >> >  include/linux/mmap_lock.h | 15 +++++++++++----
> > >> >  mm/mmap_lock.c            | 29 +++++++++++++++++++++++++++++
> > >> >  mm/userfaultfd.c          |  6 ++++--
> > >> >  3 files changed, 44 insertions(+), 6 deletions(-)
> > >> >
> > >> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > >> > index eb32b482434e..fdd8f5cf5722 100644
> > >> > --- a/include/linux/mmap_lock.h
> > >> > +++ b/include/linux/mmap_lock.h
> > >> > @@ -228,10 +228,12 @@ static inline void vma_refcount_put(struct v=
m_area_struct *vma)
> > >> >  }
> > >> >
> > >> >  /*
> > >> > - * Use only while holding mmap read lock which guarantees that lo=
cking will not
> > >> > - * fail (nobody can concurrently write-lock the vma). vma_start_r=
ead() should
> > >> > + * Use only while holding mmap read lock which guarantees that vm=
a lock is not
> > >> > + * contended (nobody can concurrently write-lock the vma). vma_st=
art_read() should
> > >> >   * not be used in such cases because it might fail due to mm_lock=
_seq overflow.
> > >> >   * This functionality is used to obtain vma read lock and drop th=
e mmap read lock.
> > >> > + * VMA can't be detached while we are holding mmap lock, therefor=
e in practice this
> > >> > + * function can fail only when there are so many readers that vm_=
refcnt overflows.
> > >> >   */
> > >> >  static inline bool vma_start_read_locked_nested(struct vm_area_st=
ruct *vma, int subclass)
> > >> >  {
> > >> > @@ -247,16 +249,21 @@ static inline bool vma_start_read_locked_nes=
ted(struct vm_area_struct *vma, int
> > >> >  }
> > >> >
> > >> >  /*
> > >> > - * Use only while holding mmap read lock which guarantees that lo=
cking will not
> > >> > - * fail (nobody can concurrently write-lock the vma). vma_start_r=
ead() should
> > >> > + * Use only while holding mmap read lock which guarantees that vm=
a lock is not
> > >> > + * contended (nobody can concurrently write-lock the vma). vma_st=
art_read() should
> > >> >   * not be used in such cases because it might fail due to mm_lock=
_seq overflow.
> > >> >   * This functionality is used to obtain vma read lock and drop th=
e mmap read lock.
> > >> > + * VMA can't be detached while we are holding mmap lock, therefor=
e in practice this
> > >> > + * function can fail only when there are so many readers that vm_=
refcnt overflows.
> > >> >   */
> > >> >  static inline bool vma_start_read_locked(struct vm_area_struct *v=
ma)
> > >> >  {
> > >> >          return vma_start_read_locked_nested(vma, 0);
> > >> >  }
> > >> >
> > >> > +struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *=
mm,
> > >> > +                                               unsigned long addr=
ess);
> > >> > +
> > >> >  static inline void vma_end_read(struct vm_area_struct *vma)
> > >> >  {
> > >> >          vma_refcount_put(vma);
> > >> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > >> > index e20d01e8d38f..6ff05e68e61b 100644
> > >> > --- a/mm/mmap_lock.c
> > >> > +++ b/mm/mmap_lock.c
> > >> > @@ -338,6 +338,35 @@ struct vm_area_struct *lock_vma_under_rcu(str=
uct mm_struct *mm,
> > >> >          return NULL;
> > >> >  }
> > >> >
> > >> > +/*
> > >> > + * Find the VMA covering 'address' and lock it for reading. Waits=
 for writers to
> > >> > + * finish if the VMA is being modified. Returns NULL if there is =
no VMA covering
> > >> > + * 'address'.
> > >>
> > >> Hm but it can also return NULL when vm_refcnt overflows, in theory.
> > >> Should we also return -EAGAIN (like uffd_lock_vma() below), or just =
retry in
> > >> here and hope for the best? The latter would be simpler for the user=
s.
> > >> (AFAICS due to VM_REFCNT_LIMIT we never end up triggering the refcou=
nt
> > >> saturation)
> > >
> > > The problem is everything's unlocked so 'didn't find a VMA' doesn't r=
eally mean
> > > much more than 'something went wrong' because hey maybe if you check =
again now
> > > you'll find something :)
> >
> > Well there might be use cases where you know that either there's a vma =
with
> > your address and then you need to do something with it, or there's not =
and
> > then you don't. And it can't suddenly appear after you check.
>
> You don't hold a lock that prevents new VMAs appearing/disappearing
> spontaneously at the point you call lock_vma_under_rcu(), or after you dr=
op the
> mmap read lock, only that at the point of checking a VMA spans address, s=
o
> there's nothing preventing a VMA suddenly appearing after you check right=
? Or it
> not being the one you wanted?
>
> And checking to see if it's 'really the one you meant' is itself fraught =
(see
> the whole uffd saga on that).
>
> Point I'm making is that in any case where you'd actually care you'd need=
 to
> take a stronger lock anyway, so it's actually potentially dangerous to
> differentiate between the two.

Yeah, I tend to agree with Lorenzo that  when lock_vma_under_rcu()
fails, we should not make any assumptions about the reason because the
range is not locked and therefore is not stable. Any assumption risks
being wrong if a race occurs.

>
> Given the overflow is very very unlikely I think it's also not a big deal=
 to not
> differentiate anyway.
>
> >
> > So in that case treating that spurious NULL as "there's no vma so I don=
't
> > need to do anything" would be wrong.
> >
> > The usages in 4/5 and 5/5 seem like they are not this case though. So i=
t's
> > fine. But perhaps worth just mentioning it in the comment then.
>
> Agree this is worth spelling out in the comment (I raised similarly).
>
> Maybe something like:
>
>         If a VMA exists which spans @address, return that VMA, read-locke=
d.
>
>         If no VMA is mapped there or, very unlikely, a reference count ov=
erflow
>         occurred, return NULL.
>
>         Nothing prevents VMAs being unmapped/mapped before or after the V=
MA is
>         looked up, if a stronger guarantee is required, take an mmap lock=
.

This last statement is true only if the function returns NULL, so I
think it should be in the same paragraph as the "If no VMA is
mapped..." sentence and prepended with "In this case...". So:

       If no VMA is mapped there or, very unlikely, a reference count overf=
low
       occurred, return NULL. In this case, nothing prevents VMAs
being unmapped/
       mapped before or after the VMA is looked up, if a stronger guarantee=
 is
       required, take an mmap lock.

Does that sounds good?

>
> >
> > > So I think this might be a feature more than a bug, especially given =
overflow is
> > > not exactly likely.
> > >
> > >>
> > >> > + *
> > >> > + * Use only in code paths where no mmap_lock and no VMA lock is h=
eld.
> > >> > + *
> > >> > + * The fast path does not take mmap_lock.
> > >> > + */
> > >> > +struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *=
mm,
> > >> > +                                               unsigned long addr=
ess)
> > >> > +{
> > >> > +        struct vm_area_struct *vma;
> > >> > +
> > >> > +        /* Fast path: return stable VMA covering 'address': */
> > >> > +        vma =3D lock_vma_under_rcu(mm, address);
> > >> > +        if (vma)
> > >> > +                return vma;
> > >> > +
> > >> > +        /* Slow path: preclude VMA writers by temporarily getting=
 mmap read lock. */
> > >> > +        mmap_read_lock(mm);
> > >> > +        vma =3D vma_lookup(mm, address);
> > >> > +        if (vma && !vma_start_read_locked(vma))
> > >> > +                vma =3D NULL;
> > >> > +        mmap_read_unlock(mm);
> > >> > +
> > >> > +        return vma;
> > >> > +}
> > >> > +
> > >> >  static struct vm_area_struct *lock_next_vma_under_mmap_lock(struc=
t mm_struct *mm,
> > >> >                                                              struc=
t vma_iterator *vmi,
> > >> >                                                              unsig=
ned long from_addr)
> > >> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > >> > index edd90892f8cc..c3a0c38a3dc3 100644
> > >> > --- a/mm/userfaultfd.c
> > >> > +++ b/mm/userfaultfd.c
> > >> > @@ -129,8 +129,10 @@ struct vm_area_struct *find_vma_and_prepare_a=
non(struct mm_struct *mm,
> > >> >   *
> > >> >   * Should be called without holding mmap_lock.
> > >> >   *
> > >> > - * Return: A locked vma containing @address, -ENOENT if no vma is=
 found, or
> > >> > - * -ENOMEM if anon_vma couldn't be allocated.
> > >> > + * Return: A locked vma containing @address, -ENOENT if no vma is=
 found,
> > >> > + * -ENOMEM if anon_vma couldn't be allocated, or -EAGAIN if vma r=
efcount
> > >> > + * overflow happened due to high number of readers and the caller=
 should
> > >> > + * retry later.
> > >> >   */
> > >> >  static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
> > >> >                                         unsigned long address)
> > >>
> > >
> > > --
> > > Cheers, Lorenzo
> >
>
> --
> Cheers, Lorenzo
