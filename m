Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150FD2FE582
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 02:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723098; cv=none; b=q8y++LsQJP1wP6/JG83nd7vxN8XraIFg79Rib6HCIz9FkJ0bpbpWXRiEuk8R/boV/4MoIC/BRKmoD562ZUftMYgOwK1V1n8joCYCVZULaYOfok9p7aE+lhqZ+DjISdHUAULFCYRWEhULWqWRc8aq+8/mjt4q/Nh2wCZa6zIeocc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723098; c=relaxed/simple;
	bh=HS4iD/fD1tV6Qn5A6qqqxAsg1E3IyPSJ9FwGKNSxf6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjYavAHzVQvT596xbhbTB61CZOnSVyaplb52Wv3ShZ1bodrzLppmBvt73w3eTLYuYeVtJmrWx0sw1cL44xnMXtN10zOA6k2pPlti0uRW1WEb/FinOM6NxbeOMSNcwibE3/J/fGRAMIDeEy7KJxzFTHqc+DZOVOU0AD9F8SLRRd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/h3eM78; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/h3eM78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABCF1F01558
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 02:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785723096;
	bh=mVWtx48ZEGjKyIAYEU5Bv10cYMlPf9YBanNbhypqrsk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=k/h3eM78C7JHR2nlZcbFpPfmYOAVfCETMifYT9eDNmVAps/QzFnRQDyKCvZF+XVXi
	 ooF0t3LNDpxi7L0QW+0ibsSNOhz04RWMCe7QKIFKqMq54douQ31BIukAJM6Gc0C8ow
	 hl3FP+uWXavZHIIBcMxhSYVVHHNiW3LZahWyksNTYEEmF4OBrmeOy04R26mh2WMLpu
	 Bj3jWGDTmZ1lh6wCSnLzagi1h9VQY559eAOI08yqu4mA0wpSIASck7DpP/uGrP5wVH
	 FP5WLa9ADVBmovdkkNwNWN9Bx00FygsDoRokz9Xj9nA0X9HOo6e0r9AkTMLZBlKWpl
	 87lnZa8hbFBlg==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e5b048375so132642785a.1
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 19:11:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoDIBQ6n25d1KpR1PrixcRuLR75DMoLwEgyiKgm3ugTiN40uDrTwZt3tkroIfyuDn1plZfl1vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOSwe4Y3U65zNsKeODC49dbCAbjdG4pgZ24y36JJkMQ3X/DFfe
	AchM46S2PeVH4be9oC8J4GvHIymTuDL6bHLCpd8ai5OnmStb4IGsKCsp2sRnkm2FBPkL9QyeIfu
	kOPkFip8IQstgzQLfKYVIVRS/z9OuIFA=
X-Received: by 2002:a05:620a:640c:b0:92e:f101:5dd6 with SMTP id
 af79cd13be357-934a07561abmr1689941085a.6.1785723095889; Sun, 02 Aug 2026
 19:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com>
In-Reply-To: <20260802215459.2769283-1-surenb@google.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 3 Aug 2026 10:11:24 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wXGf90BMoJp3_z8G4fMTAgED88RXvbp6C4Gf+iy_2nvg@mail.gmail.com>
X-Gm-Features: AUfX_mwIvcG96g06HvvXzFCI6z0cYnWGHyN0Cv1pFy9INXjHgI-8m_UrS99NoUg
Message-ID: <CAGsJ_4wXGf90BMoJp3_z8G4fMTAgED88RXvbp6C4Gf+iy_2nvg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] mm: Unconditional per-VMA locks and cleanups
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, ljs@kernel.org, david@redhat.com, 
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org, 
	jannh@google.com, aliceryhl@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 5:58=E2=80=AFAM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> v2 version of this patchset [1] was written by Dave Hansen and per his
> request, I'm taking over this series.
>
> tl;dr: Make per-VMA locks available in all configs. Simplify some
> of the per-VMA lock users now that they can rely on them being
> always available.
>
> Binder and networking folks: Your code is the target of the cleanups.
> I'm cc'ing you now on v2 because there's emerging consensus on the mm
> side that the approach here is sane. I'm not quite sure how this pile
> would get merged, but ack/review tags would be appreciated if this
> looks good to you.
>
> Longer version:
>
> When working on some x86 shadow stack code, it was a real pain to
> avoid causing recursive locking problems with mmap_lock. One way
> to avoid those was to avoid mmap_lock and use per-VMA locks instead.
> They are great, but they are not available in all configs which
> makes them unusable in generic code, or if you want to completely
> avoid mmap_lock.
>
> Make per-VMA locks available in all configs. Right now, they are
> only available on select architectures when SMP and MMU are enabled.
> But all of the primitives that per-VMA locks are built on (RCU, maple
> trees, refcounts) work just fine without SMP or MMU.
>
> The only real downside is that making VMAs a wee bit bigger on !MMU
> and !SMP builds.
>
> The upside is much cleaner code, lower complexity and less #ifdeffery.
>
> Clean up a binder VMA locking site now that it can rely on per-VMA
> locks.
>
> Building on top of universally-available per-VMA locks, introduce a
> new helper. Since the new API does not require callers to have a
> fallback to mmap_lock, it's much easier to use. Callers can
> potentially replace this very common kernel idiom:
>
>         mmap_read_lock(mm);
>         vma =3D vma_lookup()
>         // fiddle with vma
>         mmap_read_unlock(mm);
>
> with:
>
>         vma =3D vma_start_read_unlocked(mm, address);
>         // fiddle with vma
>         vma_end_read(vma);
>
> Which avoids mmap_lock entirely in the fast path.
>
> Use that new API for another binder site and one in the TCP code.

Nice, Suren and Dave.

I wonder if we could use the same approach in the page fault
path. Instead of falling back to mmap_lock when
lock_vma_under_rcu() fails the first time, could we wait for the
writer to finish and then retry acquiring the VMA lock?
For example:

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 85e23388f9bb..684f38cc4e74 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -677,7 +677,7 @@ static int __kprobes do_page_fault(unsigned long
far, unsigned long esr,
        if (!(mm_flags & FAULT_FLAG_USER))
                goto lock_mmap;

-       vma =3D lock_vma_under_rcu(mm, addr);
+       vma =3D vma_start_read_unlocked(mm, addr);
        if (!vma)
                goto lock_mmap;

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 45b99c3b1442..a3a4c4741e30 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1331,7 +1331,7 @@ void do_user_addr_fault(struct pt_regs *regs,
        if (!(flags & FAULT_FLAG_USER))
                goto lock_mmap;

-       vma =3D lock_vma_under_rcu(mm, address);
+       vma =3D vma_start_read_unlocked(mm, address);
        if (!vma)
                goto lock_mmap;

Best Regards
Barry
