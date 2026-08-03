Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62173421226
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778907; cv=pass; b=jCteUjOS67HSEoLmFF4oHbY8U3KeLogA2YK41kSbYnDu8tI9xjZCG2/oH9RrZ/tASm81pQAkmOpS2tbZAbwVyTMe2tF1tymHLgwmBo24dgYPX1zH1cDy6n3usEz9Fu81OLUq7l5sJMnDuB156ZeNu2VKJqPTW2HQyer3QdhGFpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778907; c=relaxed/simple;
	bh=m+s/NpsJ2vxd6nQf9mYbVKAEJ7bH7qIbDORr9taCqPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNWaShd2UfWfxPtQBnR3WJvGh+j0tQGoMOJ4Dkfrhwk+VVgnD8Mfe4zYVZKcOgxtvINhMaHhVxHpnKxkg3uMzW3fQUVSFLSUksM2jN4uJHOPyZUeOyyw2X6Ls7LJ3RiE3+Xys88ilvx5ABqbN1jSeroX4dsYsqTHYM1gDPQxzSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rh93a9y6; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rh93a9y6"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c10e86e52so15411cf.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 10:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785778904; cv=none;
        d=google.com; s=arc-20260327;
        b=A1FT8SJPuim1n5me4V8QSwE97V7k67jsSUtTQhhrBLt4guoSXafTLETnV71BJaqZbD
         /7U3SD994vYIwikLvz3OXb7jbKw5NJGoELeUjQLzpjLTPagVZOjzA47ivvjlmjXy/iD7
         L3fa6Xnmvzbsz8Y0vt/pvrtvxC4Uy4Aq8us8OIwmgvVaAjh8x/MErcYPNZdLOXFfJMii
         U1Gyabvm3a7D8NebEi+e2elEBFESua2yKjk9L/pVaSYzm6hJUtAJzJgpNBmGg1awtjg/
         w0Cari6rzozcueZvvoTYLdW097qxS+rwmfz7gzzoXFBNkDXHkd/dW4/ki8qqOSbKBiJJ
         Fefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m+s/NpsJ2vxd6nQf9mYbVKAEJ7bH7qIbDORr9taCqPo=;
        fh=RkANrRtI9Ht120op+T2tXICK93+YClE4CFe2Sy6mkv8=;
        b=XWre8Hy41OtAv8fTRIe1DNRUSZfywXF2IYpVCCauUCKc61G8mwOZLkHP3YShy9dx4R
         5/Rx9brj9/VxEHsM5B6gpmcujp9YxtNq6dv39fjHlyzGWnceiesVgkGHNVu7qo+V0swB
         6XSwBiWFAaAU9R5E0wgG7uN/pI38XoFTPjc9cPdp09zUJZ3G4VYsKdQ8BmzE8kbWDewm
         8kH71YQ8JRrA7JFe3zgtzsA6H3dcvuamZjqIJI4jwEkeXKeN3GUzVBzdpvpdbTIi0Fam
         KilhZCvC5F0DcSSXumsuwBc4DVqog5Mw6oAP6CYhgWjtTmdX5bgaPp/OTf3GoJItE8yL
         mGpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785778904; x=1786383704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m+s/NpsJ2vxd6nQf9mYbVKAEJ7bH7qIbDORr9taCqPo=;
        b=rh93a9y6zBS86Fagg0lJWIxpT1rkfPcSM36S37loj9Z9F2Qfmo0rEYLcgPyiXr33L4
         Rk9agM2r8ghMjC8+KjlNE1nqY/sQn+jhgY76DqFPSFkwEgUcjuvCwu/7kdIK1dT/S2US
         LQ+8gg/u7h1kLa7zXdc9tW7wvprYThR3zsZwHSs4u5735erBZwqgiEmT/8jflK8kaY7w
         VwGIm5xKvR//dMXxAzkKPnX6vA4IIoMzp/FnJ+RmPlvHMe6OkrgMYHuievaYQIVS22G4
         JVfuYGPFm4I6UyY7jtqJj2aY66wp3cL7iP+mquvZSKIP1SPWFQJzd0aNazVtm7jnzxJs
         Vwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785778904; x=1786383704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m+s/NpsJ2vxd6nQf9mYbVKAEJ7bH7qIbDORr9taCqPo=;
        b=qzZfWpMkT6ESMIZAMWvYjYTLuKSVF7/ZAzk431au7sGrb4oKSbajuk7He+AAkUaSng
         lhBtGND+Vi14q+0MiVIrUcVI5632mu5pwuI3OuWC5OVwXY6QYSFKklZ1j6FaArQ/H81I
         lVN5W5YNdgS1wJrBAU3EhkVMNBTQAB8Mg7yvltesvPiSf+EOTS90f7bAjUGs/4vsN12H
         84F/mtXy2DrzpaJOnw9t9zj8B6ohwcYdKF5AHquybfvDXTtcrTuSzaw15CnC6ZUirahH
         ivm9X/Fu1eWfjg7gzpR6618K+651nQTTjSt4y8cNGkDAxg6wvc2feDcuY3XppfCFgP+7
         7F4g==
X-Forwarded-Encrypted: i=1; AHgh+RqsnbOb6GIoHCznTbz6nV6MJHhgzysee0QLKMQpT7aRgsm+GIMPabHHhwjnrjaWngOpIAjKsV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZHIfPGBzartRp0+rEJS8b2yxf44CYFTSCqZILYk8BI3KhS4K
	VxxbBdwMuWfWqWaZpaHtxMWIj6+t8NmBnGQtXXDb/5WtJaFSV00W3MCFqCiQsb2rg3z/P2nk6D/
	HWgocuEy0jke7hDWj1sS/6XWYL33Q+7esdhcoP1eC
X-Gm-Gg: AR+sD11DYXwMaANUoXotlooUFbmZzXxE9frXccCEcc8GGQIoV/SYgCvP2P/W/8owPwX
	q3ttbHMtRKwTxAyB8p0B/bkkweYTk3LacCxhSW5K5Bj6z3S9mQP3zaNhlquZ5EDryy3cFiStV9X
	HHoFqXmL18hkhy0/tF78uEk78hOBv4qoFxP0cVNqWU+Tm9aZjrbTMEfga5dM+r8JvLHeuP+TXsE
	UqeQYLmfrLRTnNGxN3O6HJYq3mqwf44N+mRWyZlxVhORMx/yfcTiojgGJUfoiQvyDL6Z0n4Na1v
	AqM47URhOtGVWmlONdukj9FzbMOUJ1MHgKlnopIsTJo+CmjUxmtKkg==
X-Received: by 2002:ac8:5907:0:b0:516:3f51:81cb with SMTP id
 d75a77b69052e-52cd52bfef5mr290051cf.13.1785778901815; Mon, 03 Aug 2026
 10:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-2-surenb@google.com>
 <CAJuCfpGezxdaSme_QpHVq-QVeZAUaF360_Ajvkrn3QqDcSQVog@mail.gmail.com> <anC1iE21eonDK06n@lucifer>
In-Reply-To: <anC1iE21eonDK06n@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 3 Aug 2026 10:41:28 -0700
X-Gm-Features: AUfX_mz51-1HJtZcwW0CSKHbqGIW5hvrnHOcHh2u8Z-lL_RgDncrj5lYR4-cybc
Message-ID: <CAJuCfpHNMHKgmP=JLPKY65e6gO6MRpGE5MjUtjd_-2+LHr2Gpg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm: Make per-VMA locks available universally
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

On Mon, Aug 3, 2026 at 9:08=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> On Mon, Aug 03, 2026 at 08:24:44AM -0700, Suren Baghdasaryan wrote:
> > On Sun, Aug 2, 2026 at 2:55=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> > >
> > > From: Dave Hansen <dave.hansen@linux.intel.com>
> > >
> > > The per-VMA locks have been around for several years. They've had som=
e
> > > bugs worked out of them and have seen quite wide use. However, they
> > > are still only available when architectures explicitly enable them.
> > > Remove the conditional compilation around the per-VMA locks, making
> > > them available on all architectures and configs.
> > >
> > > The approach up to now seemed to be to add ARCH_SUPPORTS_PER_VMA_LOCK
> > > when the architecture started using per-VMA locks in the fault
> > > handler. But, contrary to the naming, the Kconfig option does not
> > > really indicate whether the architecture supports per-VMA locks or
> > > not. It is more of a marker for whether the architecture is likely to
> > > benefit from per-VMA locks.
> > >
> > > To me, the most important thing side-effect of universal availability
> > > is letting per-VMA locks be used in SMP=3Dn configs. This lets us use
> > > per-VMA locking in all x86 code without fallbacks.
> > >
> > > Overall, this just generally makes the kernel simpler. Just look at
> > > the diffstat. It also opens the door to users that want to use the
> > > per-VMA locks in common code. Doing *that* brings additional
> > > simplifications.
> > >
> > > The downside of this is adding some fields to vm_area_struct and
> > > mm_struct. There are likely ways to optimize this, especially for
> > > things like SMP=3Dn configs. For now, do the simplest thing: use the
> > > same implementation everywhere.
> > >
> > > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > > Cc: Vlastimil Babka <vbabka@kernel.org>
> > > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > > Cc: linux-mm@kvack.org
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> > > Cc: Todd Kjos <tkjos@android.com>
> > > Cc: Christian Brauner <christian@brauner.io>
> > > Cc: Carlos Llamas <cmllamas@google.com>
> > > Cc: Alice Ryhl <aliceryhl@google.com>
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: David Ahern <dsahern@kernel.org>
> > > Cc: netdev@vger.kernel.org
> > > ---
>
> <snip>
>
> > > -#endif /* CONFIG_PER_VMA_LOCK */
> >
> > Now that I'm looking closer into this, I think we would break NOMMU
> > case because nommu.c does not take VMA write locks at all. So,
> > lock_vma_under_rcu() for example would always succeed.
>
> I don't think anything's broken actually.
>
> Per-VMA locks was gated on CONFIG_MMU so nothing there assumes per-VMA fl=
ags,
> but now you have stuff that happens that didn't before but:
>
> * vm_area_free() -> vma_assert_detached() - fine - it's always detached i=
n nommu.
> * vm_area_dup() -> vma_lock_init() - no asserts, just sets refcount to 0 =
(correct).
>
> AFAICT nothing else.
>
> So seems fine to me?

One place that needs fixing is in BPF iterators. They use
lock_vma_under_rcu() which would always succeeds even if the VMA is
being modified. Instead of removing !IS_ENABLED(CONFIG_PER_VMA_LOCK)
check in bpf_iter_task_vma_new() I'll need to change it to
!IS_ENABLED(CONFIG_MMU).
I'll look into other parts and try to verify they do not affect NOMMU
but ultimately I would like to run some tests with this config, which
is not trivial...

>
> >
> > Extra per_VMA lock-related fields in the vm_area_struct and mm_struct
> > would also inflate NOMMU structure sizes without them being used. I'm
> > not sure if this is an issue we should consider.
>
> As nommu co-maintainer, no it's not :) I won't have that stuff blocking
> important changes for real arches.
>
> Go ahead! :)
>
> --
> Cheers, Lorenzo
