Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF03E5EC0;
	Tue,  4 Aug 2026 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835690; cv=none; b=roKEgEDdOtfqKgVoEZI1ydZrdo4+ST/4VW/ZZUy7h9+hmYgOlxHmdGv9i9EjLhWRzwDfHdHsSCXO534vruOqRhgsgttVOXp007pMsVzCLLd1KNmN5DFGLhFyTQjSPubQD1sFIyH3YCwIzwlNLeNJy4cVR1yhaEQ52qP5gVuJoKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835690; c=relaxed/simple;
	bh=KCzehUNZ8uPOFFNG7TgoZ/YmkYi069MvfAxwSlB9sY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHGTI+yCb7WtRTlrP6Xv0RNzcFYNvpkJ4GsSwjR026mix3vVBwMWxw6I1bKIijgMRD0WwEsoluRlZHKkIaGep2gQ7/bw7gBb0BL8xjxLV3sgAX8WsRLgiAwiGVIKTMN2b+GPVgtutFhSe2/uIa0sU1l9xmoUUhm2PwNpW5fFh2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbU9E0cz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbU9E0cz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7EC1F000E9;
	Tue,  4 Aug 2026 09:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785835684;
	bh=msuJG1U9NbgNekhZcWKDwtxYvM1yh+0sDaIHOIY7ttI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EbU9E0czt8+05DB8/ZKTVNPnPIYDqTpFQaRmXGDAlJWL06WMeomz3v47cD62g7LdV
	 JqjoafIx26kODLRXip6Ex7ykdxA1IrHSjTfwTxYJb83rC+wQUwW/2Xy/hjuQM4wzv8
	 MKo9jOlhmDEnGUdR8VMNpSvooH0/6IXDZWSzJZLKiCqzSccwIagjjFW4eOU9XEOhQ1
	 I9RfgS0SToEalsxpa8cpHdAd/SIvhN9Qs+v6cH+HIP/GDqcKB2Gxi56n+jj9PYCWYm
	 2eY+Fr8VPrKp34pBwFtBuyKPWpJeEX6N1e9nUO3DyYcs9VphR/V7mRF9WucaN9MsSY
	 CwAEJzcLCNrIg==
Date: Tue, 4 Aug 2026 10:27:45 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Barry Song <baohua@kernel.org>, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, david@redhat.com, willy@infradead.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com, aliceryhl@google.com, 
	arve@android.com, cmllamas@google.com, christian@brauner.io, tkjos@android.com, 
	dsahern@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 0/5] mm: Unconditional per-VMA locks and cleanups
Message-ID: <anGtzyCbkzLzym0Y@lucifer>
References: <20260802215459.2769283-1-surenb@google.com>
 <CAGsJ_4wXGf90BMoJp3_z8G4fMTAgED88RXvbp6C4Gf+iy_2nvg@mail.gmail.com>
 <CAJuCfpEF6SjKhRW33AuboAuUbQz5zv+QKr2eD=52Qd_POL18Kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEF6SjKhRW33AuboAuUbQz5zv+QKr2eD=52Qd_POL18Kg@mail.gmail.com>

On Mon, Aug 03, 2026 at 10:51:25AM -0700, Suren Baghdasaryan wrote:
> On Sun, Aug 2, 2026 at 7:11 PM Barry Song <baohua@kernel.org> wrote:
> >
> > On Mon, Aug 3, 2026 at 5:58 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > v2 version of this patchset [1] was written by Dave Hansen and per his
> > > request, I'm taking over this series.
> > >
> > > tl;dr: Make per-VMA locks available in all configs. Simplify some
> > > of the per-VMA lock users now that they can rely on them being
> > > always available.
> > >
> > > Binder and networking folks: Your code is the target of the cleanups.
> > > I'm cc'ing you now on v2 because there's emerging consensus on the mm
> > > side that the approach here is sane. I'm not quite sure how this pile
> > > would get merged, but ack/review tags would be appreciated if this
> > > looks good to you.
> > >
> > > Longer version:
> > >
> > > When working on some x86 shadow stack code, it was a real pain to
> > > avoid causing recursive locking problems with mmap_lock. One way
> > > to avoid those was to avoid mmap_lock and use per-VMA locks instead.
> > > They are great, but they are not available in all configs which
> > > makes them unusable in generic code, or if you want to completely
> > > avoid mmap_lock.
> > >
> > > Make per-VMA locks available in all configs. Right now, they are
> > > only available on select architectures when SMP and MMU are enabled.
> > > But all of the primitives that per-VMA locks are built on (RCU, maple
> > > trees, refcounts) work just fine without SMP or MMU.
> > >
> > > The only real downside is that making VMAs a wee bit bigger on !MMU
> > > and !SMP builds.
> > >
> > > The upside is much cleaner code, lower complexity and less #ifdeffery.
> > >
> > > Clean up a binder VMA locking site now that it can rely on per-VMA
> > > locks.
> > >
> > > Building on top of universally-available per-VMA locks, introduce a
> > > new helper. Since the new API does not require callers to have a
> > > fallback to mmap_lock, it's much easier to use. Callers can
> > > potentially replace this very common kernel idiom:
> > >
> > >         mmap_read_lock(mm);
> > >         vma = vma_lookup()
> > >         // fiddle with vma
> > >         mmap_read_unlock(mm);
> > >
> > > with:
> > >
> > >         vma = vma_start_read_unlocked(mm, address);
> > >         // fiddle with vma
> > >         vma_end_read(vma);
> > >
> > > Which avoids mmap_lock entirely in the fast path.
> > >
> > > Use that new API for another binder site and one in the TCP code.
> >
> > Nice, Suren and Dave.

And Lorenzo ;)

> >
> > I wonder if we could use the same approach in the page fault
> > path. Instead of falling back to mmap_lock when
> > lock_vma_under_rcu() fails the first time, could we wait for the
> > writer to finish and then retry acquiring the VMA lock?
>
> Yeah, we might be able to do that. Matthew is working on moving common

I think it could really help clean things up actually.

Though obviously you still need to account for the fault retry stuff that still
needs to fall back to mmap lock, so sadly we DO need a fallback path (ugh).

It'd be good to remove some of the duplication.

> page-fault handling code into a single arch-independent place. Your
> suggested change would be simpler if done after Matthew's refactoring.

Yeah might be worth waiting for that :)

>
> > For example:
> >
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 85e23388f9bb..684f38cc4e74 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -677,7 +677,7 @@ static int __kprobes do_page_fault(unsigned long
> > far, unsigned long esr,
> >         if (!(mm_flags & FAULT_FLAG_USER))
> >                 goto lock_mmap;
> >
> > -       vma = lock_vma_under_rcu(mm, addr);
> > +       vma = vma_start_read_unlocked(mm, addr);
> >         if (!vma)
> >                 goto lock_mmap;
> >
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index 45b99c3b1442..a3a4c4741e30 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1331,7 +1331,7 @@ void do_user_addr_fault(struct pt_regs *regs,
> >         if (!(flags & FAULT_FLAG_USER))
> >                 goto lock_mmap;
> >
> > -       vma = lock_vma_under_rcu(mm, address);
> > +       vma = vma_start_read_unlocked(mm, address);
> >         if (!vma)
> >                 goto lock_mmap;
> >
> > Best Regards
> > Barry

--
Cheers, Lorenzo
