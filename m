Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3A4052CC
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779499; cv=pass; b=t72DPyIsVZBXJDh+c/wGHEJ3yNbmFdEJ8C9ntF4X1Xv3/P6pyQRQ2JHPXUkv2CwzFPv7ZMopX/3LXmGgxVcwgFwPM3GZI/fe7iaX9xb/tBVdd9wztj0oWIdifIlk29CPSDiqic9tzfReI34i3shXHLNt00cGWKyu3+Ezt9MR98I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779499; c=relaxed/simple;
	bh=qf48R+ATlcs6kKnpStM+GTWX37m+FIrU2UASnnqGtEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mb1DpySODpk1TVqRqGL5xJVikBgcDRNaGraR7+p9m33m9pEDovBvue/2Sz0tnvKjxGoecDjEvgvOoAOrlg5fAQFRI/JY+CkaX0CTkq6zmGiu4zYf5hSlrSykPa18PVCJcbO/GXfiB0C/VXJoDvssNczYT5j4j0d64r4Iq50+1iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FWUjOeYN; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FWUjOeYN"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c01c79467so23891cf.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 10:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785779497; cv=none;
        d=google.com; s=arc-20260327;
        b=pN0W7EafwHiQyaF7VXVSF/kmfITN4E0P9g8gP/fSEfFMo81N8IDKl9S/8DBjMwpmOX
         WmYw79gQmEkLcYZzS0XaORPQ9boUmulMHVB9ZbxvNMCuikSrwlW751jr/zMtlI7RcD2d
         CFUg4/4bat9yi5ySDR4qMCwQG5TwqjTKvVhgPKRegFXsctny9zkuGq/ZxVD5b/VrOuAU
         eeexG7sA/+y9ms6p1AkfFYjIL5v/ZxB27drNP3hPMAjwrWJ2DUXAOelw9R69iA8HFujQ
         FCUO+biWzgPem7HLzyUVXKSfeZhQMSunqREs1Mc08EJzUP/IcbXLOtTGnyW3o2xQP3f4
         f6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gN9PGDfMfb8sN7B1AJaJ+0FbizOuTl6vkuEoW4uKhkM=;
        fh=6JlG59SooIxOofesKvC/eCqkvNQJMyfijQq1GxXzsQM=;
        b=PByVWsPWkoKZmGYu31RTaShaSewjqgAY1h2MkhQrFzx++2CSWDQGU7SQfpcIlJ577T
         ap7IBPAdAbLGTWy6PmDaj/fJvDtYM1+SqCDK9hLdPOrAJ7txF86enTt7Ef56NNDJLTpA
         zKh4XgOD/dV3nNbI27XK+UTCh+5KJo74CpPcARDzzkxELls4XTOpU6j83kY9fv0obIPj
         OULvE8En91J3s9VgiG4pOCSH0yMxZcOo8w/DKimOrjwDsppqPPeGvcyLf+bgI6ZQmN/5
         MWRwnDmFMrXL/dZllZ5Xos21p9QTSufasU+uDiNrH/tEGdTxlebXfnKjKfVULPu6gj3h
         g6jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785779497; x=1786384297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gN9PGDfMfb8sN7B1AJaJ+0FbizOuTl6vkuEoW4uKhkM=;
        b=FWUjOeYNz5ZemLHR8FpNRAo+TZKYXvlNeb41b9kSocpo5Mm4h9dbUyuYM+ZWdezwP3
         qiExUMR/curY0a+A9GlgGfnhwoXbGEMhpmdiB+460p6WopfiINkcaCnRte+4s58+YhE/
         P8PMJ9q7BctGoQfxm0lYmtPP+EIEeYaE4hwJ9q/ax1iBVRu9NpBsUmzg9QLaFIiAtZTL
         3QYXnteA+RXKPhrIS7Yf9pbpoS8T9BOzC+9YJorN+SgqBGn+aPKTMCynVrbEcNRsHx87
         BTzXW7rMnKsxPghSTUVlQIITeE0DrTC02nrMF7xw488AajT9uGopzmd57Ow1IiOx9hpv
         E3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785779497; x=1786384297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gN9PGDfMfb8sN7B1AJaJ+0FbizOuTl6vkuEoW4uKhkM=;
        b=NyC/IDZ8/jyMDVl6Z9PPWVSufxcdHUzuKwbbLZw4w7zUbnttTHEFW6Wu6mLwWTybWL
         xqUnO+MhaB316VJ5e3WmUieEL9KAgPO0jzFP/I5eYaAZPexg0MPZnMegAiXZm9uM5AG6
         VhE627amOriEFVvb02aEVAnirm85fz3jn5wVH6b8e6FPNH3n3h3qC4nBfKUAhEH5Uv/5
         UfMMBU2ujbnjV2oO93Ww825ngJlfSzDVK5ebihjIMiQ3tcbvCr4hWFXxYYCPZYg1Gzd3
         0nzFHhcO9Dmd49+E5i2dKhs6OBzTeOA+4rdl0ixgiYQyRL9kdK+dwYSSGohohN4L/wYW
         oM9Q==
X-Forwarded-Encrypted: i=1; AHgh+RpJuAxAw3F74n/DjoQJIuF5sk7Gqjt8gJYJpegVvsJYsV4gehH6K+kSVWBhX9Zf6fl3Zf1JbcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoZSpjMwEhYcdMI92h3F9Z66iKyFdImrT9sTvyNM1sBQhwboQc
	sZ6WZES49wRb4ZjkYqMrErqm0W5LLAnbZZsFhsosMToYeahcZDVgkc2XPKzJeYmqjbGgzlL/Gkp
	dpPi8azgzX3zoKZIGrCEz9nppbEkBiGoiorqNl8Y4
X-Gm-Gg: AR+sD13nqHty8xldEqcGstOuqs7T2K6JtSYCLuYwVLXXbNlmlIyea7FoyPpf6ntWb1I
	AgnXw5rmOpHmj90maXSBSuVWSvPyM9NB+7NEVzOpHTv2n8Zp6w2YyeIXAOzjRNJKrAypWQxUQRy
	zBBGeOOuS5AmpY/82miYZ+0/5kR0JMjI4yEkxvtmFCq57DTJrN4fbO6gx1dHYMxMD/1sRJH5QgN
	qtRGTArUkx+g3aGHEYzlr5GwyQ6XAP4RUmUeOfLTUXrTU0BVGamj6bDor7gcJz3VltmkXaHC7zy
	ADkhPJ7tWa4mhCngauVU5eR6nWeWCIJCP1IfNRsDz1fOW6kfDB2N3g==
X-Received: by 2002:ac8:59d2:0:b0:52c:d3a1:358e with SMTP id
 d75a77b69052e-52cd501c9e2mr508011cf.18.1785779496122; Mon, 03 Aug 2026
 10:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <CAGsJ_4wXGf90BMoJp3_z8G4fMTAgED88RXvbp6C4Gf+iy_2nvg@mail.gmail.com>
In-Reply-To: <CAGsJ_4wXGf90BMoJp3_z8G4fMTAgED88RXvbp6C4Gf+iy_2nvg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 3 Aug 2026 10:51:25 -0700
X-Gm-Features: AUfX_myBHnqbqUHzxMRv2lr_uMcuDR54YU5uhLBh_mtvAIUn3WoWtjNwKbef5Os
Message-ID: <CAJuCfpEF6SjKhRW33AuboAuUbQz5zv+QKr2eD=52Qd_POL18Kg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] mm: Unconditional per-VMA locks and cleanups
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, ljs@kernel.org, david@redhat.com, 
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org, 
	jannh@google.com, aliceryhl@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 7:11=E2=80=AFPM Barry Song <baohua@kernel.org> wrote=
:
>
> On Mon, Aug 3, 2026 at 5:58=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
> >
> > v2 version of this patchset [1] was written by Dave Hansen and per his
> > request, I'm taking over this series.
> >
> > tl;dr: Make per-VMA locks available in all configs. Simplify some
> > of the per-VMA lock users now that they can rely on them being
> > always available.
> >
> > Binder and networking folks: Your code is the target of the cleanups.
> > I'm cc'ing you now on v2 because there's emerging consensus on the mm
> > side that the approach here is sane. I'm not quite sure how this pile
> > would get merged, but ack/review tags would be appreciated if this
> > looks good to you.
> >
> > Longer version:
> >
> > When working on some x86 shadow stack code, it was a real pain to
> > avoid causing recursive locking problems with mmap_lock. One way
> > to avoid those was to avoid mmap_lock and use per-VMA locks instead.
> > They are great, but they are not available in all configs which
> > makes them unusable in generic code, or if you want to completely
> > avoid mmap_lock.
> >
> > Make per-VMA locks available in all configs. Right now, they are
> > only available on select architectures when SMP and MMU are enabled.
> > But all of the primitives that per-VMA locks are built on (RCU, maple
> > trees, refcounts) work just fine without SMP or MMU.
> >
> > The only real downside is that making VMAs a wee bit bigger on !MMU
> > and !SMP builds.
> >
> > The upside is much cleaner code, lower complexity and less #ifdeffery.
> >
> > Clean up a binder VMA locking site now that it can rely on per-VMA
> > locks.
> >
> > Building on top of universally-available per-VMA locks, introduce a
> > new helper. Since the new API does not require callers to have a
> > fallback to mmap_lock, it's much easier to use. Callers can
> > potentially replace this very common kernel idiom:
> >
> >         mmap_read_lock(mm);
> >         vma =3D vma_lookup()
> >         // fiddle with vma
> >         mmap_read_unlock(mm);
> >
> > with:
> >
> >         vma =3D vma_start_read_unlocked(mm, address);
> >         // fiddle with vma
> >         vma_end_read(vma);
> >
> > Which avoids mmap_lock entirely in the fast path.
> >
> > Use that new API for another binder site and one in the TCP code.
>
> Nice, Suren and Dave.
>
> I wonder if we could use the same approach in the page fault
> path. Instead of falling back to mmap_lock when
> lock_vma_under_rcu() fails the first time, could we wait for the
> writer to finish and then retry acquiring the VMA lock?

Yeah, we might be able to do that. Matthew is working on moving common
page-fault handling code into a single arch-independent place. Your
suggested change would be simpler if done after Matthew's refactoring.

> For example:
>
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 85e23388f9bb..684f38cc4e74 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -677,7 +677,7 @@ static int __kprobes do_page_fault(unsigned long
> far, unsigned long esr,
>         if (!(mm_flags & FAULT_FLAG_USER))
>                 goto lock_mmap;
>
> -       vma =3D lock_vma_under_rcu(mm, addr);
> +       vma =3D vma_start_read_unlocked(mm, addr);
>         if (!vma)
>                 goto lock_mmap;
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 45b99c3b1442..a3a4c4741e30 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1331,7 +1331,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>         if (!(flags & FAULT_FLAG_USER))
>                 goto lock_mmap;
>
> -       vma =3D lock_vma_under_rcu(mm, address);
> +       vma =3D vma_start_read_unlocked(mm, address);
>         if (!vma)
>                 goto lock_mmap;
>
> Best Regards
> Barry
