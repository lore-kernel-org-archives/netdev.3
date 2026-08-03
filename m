Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2101A40DB2D
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779117; cv=pass; b=lG5PYgrAjm317JR54ZWb7YYIvOirC+V6zFWehI4SQtXV0H0scagMNofurtzLo73U1wH4b0wubacWcjImpT7qqCxNeaR3939V57yd6LDdJHG4LDgIp0htcU+yX2g/N9Md3T06Z1Mot1Vk72R7l4tHooBCGGmUNz66CId2s45Ktlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779117; c=relaxed/simple;
	bh=pcaqbwXbbgtya7su1KF5hkBcYz1hpu+5KQQa0CxMdOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsXfJzLvNJw63O//ZR0k1HSwemHmK97pZS0FNRVOgLLQRhU83puWPPoV40CGdDt9QmRN+UonfhqhY4WTxNo+6HuaBAVrXs1iroP3wF6YEhFG+zzWEcPaBVw/ullR5o0jVwdCqMvMAtsihKNm5ZhMfRi5Ubrqq4nC7/gQncwO2u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TYuwah5X; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TYuwah5X"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c15a5b265so16511cf.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 10:45:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785779113; cv=none;
        d=google.com; s=arc-20260327;
        b=WFx+20NqkYOsDOWhUhfYryr33tGvjgq6b9mO8FMGTBlhxGz+0yFUQyLY80NHdjRmyw
         G8yge1vSxicn6aURxAVoh5juSXvo2ZqUdjD6iib8lLpPnKeSuQso/7Ht9G0R+bgFrUUO
         hex8aRTvgpDaWkf7d3KrCkLNll3EBCx8azBkib+lh77BOPZTaQRE1xxVqIuz4TH5mz9j
         onGxSVMsI5igB9BE5fht9ZrgFoaHcfxx4Vvg6KV+8AwCn50UWOV4D2DqtBBqwmjVCbRK
         5IZnVIz2AMtfW4yHJu75CA8tDF1QdUTr7UY2n5sO+f2ACx8qGdebD6p62/HJXX3nic6M
         Vcpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dzPyuOh4D8LB8f5KYlnObQrd/WHhEUKx52+e4JaPcOc=;
        fh=5HCirRTRM4wDETPUDkXTrBB7BRzNMTn0xMVf0PbGQf0=;
        b=JTYg/WMb0iZpm+8I7FsZQn+iQ9XJ67tkVJ3/bgzi/SDegqFJHUb65MxL5mbF67FX2O
         BXn1gVLRcdiLN655vnpWm5bqOxCElL5xsOWKAFuHvq/upNZDM0fRbLYC1eQwUYsZ8wOs
         6NMcQB4baCBv8OpxFxf7wKv5AA+KpUBDS2xoDTB2xZ27ewYySOq8i78TSyqVvZuBY/65
         +4+KOGBiASwqcsar2wh9F6eXSSbVkEtGBcWehtjg6vIMrbvDc8wHfeQ+57aswr9NG/yx
         d29a1fmbp1OOGnjJ2zDOqnPJXD6LwAE1Hw7o9kP1H1RUPLxmWMhcm84XVjW67OW85wEF
         ITpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785779113; x=1786383913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dzPyuOh4D8LB8f5KYlnObQrd/WHhEUKx52+e4JaPcOc=;
        b=TYuwah5X0TlhLx/B8SHXB5/0Nq+YXh76u9PaQqbo16Ef7kTr4tuIp7K3drxBWNTpJs
         S1bTDevWv6PS2IxIG0gdvcG+BsUY2P5KXeTn8OD+4yhm/vW1OGGiFemdypq+JrEyAKW/
         zm0VDxy1lqoIuWytWt61g5dOrYov308s2tCiG8f/eRfb5rpKXenXFIh7WtaQipySB0C6
         m6eqFJkX0fb9FZgdcO9wRPsPAt6GAXmp1N7uwuar+ebQcZ+yUpfVuK4jExpJotOzjWiD
         bZCE+coyxealhG58vpdp8l5FfOQlEyshXJLuvf2ZPkZC3uK0rr01sdjIcwVD8UYMkTck
         mTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785779113; x=1786383913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dzPyuOh4D8LB8f5KYlnObQrd/WHhEUKx52+e4JaPcOc=;
        b=kOwtxbVTEQho2KbaVQcdzr2McTq5XR8YtWZpaGy0NPMPDK6qzMT7TDYyFTUfIm4nxv
         NGc4et7ecTR11Q/fesVDyzDnqYdUMOkooK1EiKnwLGxh0uI5nF+5BrHsllTSKUu+YYVz
         Kb4aCDjlXMOFIGLJNG0LEaojzDISOVFtQpzCOp7pZijdy4BZDEvd5TsPMRBvXGzYHQTD
         apKAxNLgtCSFmUp/9i5xm+01mw5ExtHeteSzPgVYZguJjTBZ7APbkBF3tnshXZtjG1bM
         9KaOIoplZc4A8ZMGQJOl4mCInr0gVVNFnSw57PnshhLvIu9nnf39lpc1drtLkMsSSH+Z
         S4wQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZh791zScSBR40CfmXZOp41lJd6wFq8oTtCOba04BIPnoa1huwHGyGKK16h5/HKw/pou6ZDbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhR5xn8r7pPc3i5BYbM1r3wwkJv05/SouvAYq3EXEQF2FA3DfC
	2RK12PcloF8Scjg4XBlSuz5xC81db5pZL4m6TCU3YIgjDpWh2ulHV909D5AuFzkcdGHPjdjfPIJ
	Kd7nZU5q5MbWg5aw4COo98LM4YwNVW96sT9F+FvXS
X-Gm-Gg: AR+sD12TX+D5XSdcTukQbn0fDC5w1MRRZjflz53u7Yr+P9Od4vwyQxkNd2qtl8xPEuW
	D6iGu0B6JsBinbpuwliAmFbyv9qtOXYxJy8raio+VWQdLS7O947eoZWPF4lO3tb630tvtmjQKY6
	ooysQuhEKWGIUylfijEn6RaqWdlrY5od00iKQyTt09yMaTlIPgapLhmrHtCcGMoF3D80UfXlZq4
	F03VBZ3XVQSFUqqF2fBqCbOQlWJbj85NgS9Lq/BzyYGLl2sD5ee5aKrDZSVJ+r2an/XUU1lXDxE
	c/pwSbHe/NbF+JpLjz9JWiKi20TQITRqojuQS4l+1Og=
X-Received: by 2002:a05:622a:258c:b0:517:6010:7c71 with SMTP id
 d75a77b69052e-52cd4e7f426mr791711cf.4.1785779111866; Mon, 03 Aug 2026
 10:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-2-surenb@google.com>
 <d01d461b-6af0-4ac6-8e5f-c7c4dfe6234d@kernel.org>
In-Reply-To: <d01d461b-6af0-4ac6-8e5f-c7c4dfe6234d@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 3 Aug 2026 10:45:00 -0700
X-Gm-Features: AUfX_mx9KknoN81NByxAvEeCqA6zpO4fjrQ68YNnLK8NO8HX9nqbtSToSg_mc3U
Message-ID: <CAJuCfpFWSW0Pwh=qtFk14_0=6M9DsY_o8qQn2iFk8Fy2TW9abA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm: Make per-VMA locks available universally
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, ljs@kernel.org, david@redhat.com, 
	willy@infradead.org, shakeel.butt@linux.dev, jannh@google.com, 
	aliceryhl@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 7:01=E2=80=AFAM Vlastimil Babka (SUSE) <vbabka@kerne=
l.org> wrote:
>
> On 8/2/26 23:54, Suren Baghdasaryan wrote:
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> >
> > The per-VMA locks have been around for several years. They've had some
> > bugs worked out of them and have seen quite wide use. However, they
> > are still only available when architectures explicitly enable them.
> > Remove the conditional compilation around the per-VMA locks, making
> > them available on all architectures and configs.
> >
> > The approach up to now seemed to be to add ARCH_SUPPORTS_PER_VMA_LOCK
> > when the architecture started using per-VMA locks in the fault
> > handler. But, contrary to the naming, the Kconfig option does not
> > really indicate whether the architecture supports per-VMA locks or
> > not. It is more of a marker for whether the architecture is likely to
> > benefit from per-VMA locks.
> >
> > To me, the most important thing side-effect of universal availability
> > is letting per-VMA locks be used in SMP=3Dn configs. This lets us use
> > per-VMA locking in all x86 code without fallbacks.
> >
> > Overall, this just generally makes the kernel simpler. Just look at
> > the diffstat. It also opens the door to users that want to use the
> > per-VMA locks in common code. Doing *that* brings additional
> > simplifications.
> >
> > The downside of this is adding some fields to vm_area_struct and
> > mm_struct. There are likely ways to optimize this, especially for
> > things like SMP=3Dn configs. For now, do the simplest thing: use the
> > same implementation everywhere.
> >
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>
> Nits:
>
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 060190e12bce..77103b46b679 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -1425,19 +1425,6 @@ config LRU_GEN_STATS
> >  config LRU_GEN_WALKS_MMU
> >       def_bool y
> >       depends on LRU_GEN && ARCH_HAS_HW_PTE_YOUNG
> > -# }
>
> I think either leave this in place, or remove the line above with "#
> multi-gen LRU {" as well?

Ah, missed it. I'll keep it in place.

>
> > -
> > -config ARCH_SUPPORTS_PER_VMA_LOCK
> > -       def_bool n
> > -
> > -config PER_VMA_LOCK
> > -     def_bool y
> > -     depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
> > -     help
> > -       Allow per-vma locking during page fault handling.
> > -
> > -       This feature allows locking each virtual memory area separately=
 when
> > -       handling page faults instead of taking mmap_lock.
> >
> >  config LOCK_MM_AND_FIND_VMA
> >       bool
>
> ...
>
> > diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> > index 4764d7b68f2a..2633e704c83d 100644
> > --- a/rust/kernel/mm.rs
> > +++ b/rust/kernel/mm.rs
> > @@ -174,26 +174,20 @@ pub unsafe fn from_raw<'a>(ptr: *const bindings::=
mm_struct) -> &'a MmWithUser {
> >      /// When per-vma locks are disabled, this always returns `None`.
> >      #[inline]
> >      pub fn lock_vma_under_rcu(&self, vma_addr: usize) -> Option<VmaRea=
dGuard<'_>> {
> > -        #[cfg(CONFIG_PER_VMA_LOCK)]
> >          {
> >              // SAFETY: Calling `bindings::lock_vma_under_rcu` is alway=
s okay given an mm where
> >              // `mm_users` is non-zero.
> >              let vma =3D unsafe { bindings::lock_vma_under_rcu(self.as_=
raw(), vma_addr) };
> > -            if !vma.is_null() {
> > -                return Some(VmaReadGuard {
> > -                    // SAFETY: If `lock_vma_under_rcu` returns a non-n=
ull ptr, then it points at a
> > -                    // valid vma. The vma is stable for as long as the=
 vma read lock is held.
> > -                    vma: unsafe { VmaRef::from_raw(vma) },
> > -                    _nts: NotThreadSafe,
> > -                });
> > +            if vma.is_null() {
> > +                return None;
> >              }
> > +            Some(VmaReadGuard {
> > +                // SAFETY: If `lock_vma_under_rcu` returns a non-null =
ptr, then it points at a
> > +                // valid vma. The vma is stable for as long as the vma=
 read lock is held.
> > +                vma: unsafe { VmaRef::from_raw(vma) },
> > +                _nts: NotThreadSafe,
> > +            })
> >          }
>
> With the "#[cfg(CONFIG_PER_VMA_LOCK)]" does this still need to be in a { =
}
> block?

I don't think it needs to be. I'll remove the extra braces.
Thanks!

>
> > -
> > -        // Silence warnings about unused variables.
> > -        #[cfg(not(CONFIG_PER_VMA_LOCK))]
> > -        let _ =3D vma_addr;
> > -
> > -        None
> >      }
> >
> >      /// Lock the mmap read lock.
