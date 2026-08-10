Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8819B3B05BF;
	Mon, 10 Aug 2026 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357469; cv=none; b=shMqviQf3uOXmaI0/dg9d1Wi1sugQQVvneCvUFALgGC0zF19sLBeMcFWEA1n7HV38nhcfhO3OO0lQD5axikCtmJ39qWh0Gdt5O79VMpEcHclBMd1FyjGFaCwEQcTkHRChobvR5M3oxK2eVu7Uh4e46yPlj2Ujm2ganj8j9PDuLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357469; c=relaxed/simple;
	bh=TwBrygGoLaYh0Mod4Q467d4Ua87QqCapzKX4D+nyNVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWGVSxDvtmvaK4bxr0tdLd75fey/ZYQSvBIxzZEhqV0UOiy3FdGzoAAYviVmNInxcnxrZZ0yMQzy3WclTWMfpIVFrqZ2BRbe5urlsVbqqjxNzKFx3qwhMHzRFTG8EnLe0YerXqvq1yeIOpxf/7RkIeUAR88intWXrrLAyVPV6/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSIvhxVM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSIvhxVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338BD1F000E9;
	Mon, 10 Aug 2026 10:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786357468;
	bh=V+30XIEt4axj88eYlJLK7TU4i6nGzQ+Od4GX/hv+/YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iSIvhxVMigb3vQKU577R3rcnVFfHYAu+hl+Vi3T+Q+aHUI7L4/7aJjvZWvKP49+2g
	 Kt1yEntPq9LXZxpjNn30YSZgJxOsi9irJsmFS7+eIenlwqOsDcGHjIyoZ9NlyomAiv
	 2x+sKlUE+RBLQWNm5cse3yIGmtV+vhS7awfNW3CD34L+y423TJQf70m2phSG+Mz6+j
	 cJavjieztY+lw7sEhvHsFrw6qpIm5QVDKgOXzr33JezLv5z/ChK3WLy63mLWSo7QHq
	 xT8RyByrKcIPJ/C5bsiQ1g6DX52J+NIM4VpLBsxr+eKLKlG+EiJMM7QfUcfWEa7l55
	 b+VVh2iHoIAGw==
Date: Mon, 10 Aug 2026 11:24:08 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, david@kernel.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com, aliceryhl@google.com, 
	arve@android.com, cmllamas@google.com, christian@brauner.io, tkjos@android.com, 
	dsahern@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 3/5] mm: Add RCU-based VMA lookup helper that waits
 for writers
Message-ID: <anmmd0tIiqu2V6Lr@lucifer>
References: <20260806200548.3124802-1-surenb@google.com>
 <20260806200548.3124802-4-surenb@google.com>
 <anbZpzFbtYG7Ngit@casper.infradead.org>
 <CAJuCfpGdyNq10F15G9Z=TrkcGL8my5RB1w+nZMKOTaH1o9mrGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGdyNq10F15G9Z=TrkcGL8my5RB1w+nZMKOTaH1o9mrGA@mail.gmail.com>

On Sat, Aug 08, 2026 at 06:07:41PM -0700, Suren Baghdasaryan wrote:
> On Sat, Aug 8, 2026 at 12:24 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Aug 06, 2026 at 01:05:46PM -0700, Suren Baghdasaryan wrote:
> > > From: Dave Hansen <dave.hansen@linux.intel.com>
> > >
> > > == Background ==
> >
> > I think we can do without the headings?
> >
> > > There are basically two parallel ways to look up a VMA: the
> > > traditional way, which is protected by mmap_read_lock, and the RCU-based
> > > per-VMA lock way which is based on RCU and refcounts.
> > >
> > > == Problem ==
> > >
> > > The mmap_lock one is more straightforward to use but it has a big
> > > disadvantage in that it can not be mixed with page faults since those
> > > can take mmap_lock for read, which can deadlock when mixed with nested
> > > page faults and parallel writers.
> > > For example:
> > >
> > >       mmap_read_lock(mm);
> > >       // Another thread does mmap_write_lock().
> > >       // New mmap_lock readers are blocked.
> > >       vma = vma_lookup(mm, address);
> > >       // This deadlocks on mmap_read_lock() if it faults:
> > >       copy_from_user(address);
> > >       mmap_read_unlock(mm);
> > >
> > > The per-VMA lock can be mixed with faults, but they can fail and need to
> > > be able to fall back to the traditional way.
> >
> > Umm.  I don't see how this avoids deadlock.  Assuming the next patch
> > converts copy_from_user() to use the VMA lock, surely the following
> > situation would obtain:
> >
> > A takes mmap_read_lock
> > B tries to take mmap_write_lock, blocks
> > A calls copy_from_user()
> > A calls vma_start_read_unlocked() (because it doesn't know A actually
> > holds the mmap_read_lock() already)
> > A does a lookup under RCU, but gets NULL back (maybe it's calling
> > c_f_u() with an invalid address?)
> > A tries to take the mmap_read_lock again to make sure.  Deadlock
> > because B is waiting for A to release the mmap_read_lock.
> >
> > Am I missing something?
>
> I think Dave's idea was that A would take a VMA lock (which might
> require taking mmap read lock temporarily) and then call
> copy_from_user() with VMA lock only, which allows copy_from_user() to
> take the mmap lock. This was used in the last patch [1] of the
> original RFC. That patch is dropped from the series because this
> approach has a conceptual lock ordering problem - it takes VMA lock
> and then mmap_lock (see explanation at [2]).

Yeah I wonder about the value of this. Dave can write all this up when he makes
the change to use this in the relevant shadow stack (I think it was?) code.

Having it here when just adding the function is not really helpful I don't think.

Other use cases are stronger arguments for it anyway - we are essentially doing
stuff like this in places and falling back to mmap when we don't need to - when
we have the option to 'twiddle' the mmap lock and get a VMA lock.

>
> [1] https://lore.kernel.org/all/20260429182005.00BF70D8@davehans-spike.ostc.intel.com/
> [2] https://lore.kernel.org/all/CAJuCfpHBzYUNEe_LBpeERf68_fso=Hy+UZWtqejTUkm1O4NLfA@mail.gmail.com/
>
> So, yeah. I need to rewrite this commit message.
>
> >
> > > +/**
> > > + * vma_start_read_unlocked() - Find the VMA covering 'address' and read-lock it.
> > > + * @mm: the mm_struct of the address space to search
> > > + * @address: address that the vma should contain
> > > + *
> > > + * The fast path does not take mmap_lock. Waits for writers to finish if the
> > > + * VMA is being modified by taking mmap_lock.
> > > + * Use when mmap_lock is not held, otherwise use vma_start_read_locked().
> > > + * Nothing prevents VMAs being unmapped/mapped before or after the VMA is
> > > + * looked up, if a stronger guarantee is required, take an mmap_lock.
> > > + *
> > > + * Return: If a VMA exists which spans @address, return that VMA, read-locked.
> > > + * If no VMA is mapped there or, very unlikely, a reference count overflow
> > > + * occurred, return NULL.
> > > + */
> > > +struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
> > > +                                            unsigned long address)
> > > +{
> > > +     struct vm_area_struct *vma;
> > > +
> > > +     /* Fast path: return stable VMA covering 'address': */
> > > +     vma = lock_vma_under_rcu(mm, address);
> > > +     if (vma)
> > > +             return vma;
> > > +
> > > +     /* Slow path: preclude VMA writers by temporarily getting mmap read lock. */
> > > +     mmap_read_lock(mm);
> > > +     vma = vma_lookup(mm, address);
> > > +     if (vma && !vma_start_read_locked(vma))
> > > +             vma = NULL;
> > > +     mmap_read_unlock(mm);
> > > +
> > > +     return vma;
> > > +}

--
Cheers, Lorenzo
