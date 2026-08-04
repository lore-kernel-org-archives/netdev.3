Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DBB12AAF1;
	Tue,  4 Aug 2026 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833250; cv=none; b=Y0RIQ978sAUJP1lYEYh47/GJXrqPukWYyOucZY6k56Fsr9ozIkAZVDi7L9VRJs6UMdMFA0xLPT2nyXv63jFUHVBgdsj4Q1JkhA8KY395BE+nZ4PisgT6o7TtDWxcY5zGfvyWvo5mexZiDji1zfS4QO8zeKivbKT1qzT5q6DYdOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833250; c=relaxed/simple;
	bh=NqiKsRYYVbuQqY7nHLialtw6kx8x3k5FD72ILevSnF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiWViSTCIpaFesHoj2k15+UmX5ey0CQrgrH4jeoFvNQoD78jLD4FA6a2kkt62f0BVhw03PX1rkWyCISWDWsgUYRUk7tFd857WHBBhVwa6G73DnolGp5Ibcc5nmVxTGaT273rMHqxx4nhT1jy9fH2A99K2rMJaNAPiXNCAv0g9CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYrgl8t+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYrgl8t+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527801F000E9;
	Tue,  4 Aug 2026 08:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785833248;
	bh=/ZI4KvO3TZzvxXooPpURKi7ZY7TsoO8ReB6MMTXfTw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fYrgl8t+dx9DoEUlWL0RaLGBVzgfDlaj8IV6/wDXH5Yu/vp18PPBC+1QHDNnPRXf0
	 Rv1Kc6CvBp2dvEx5UAwUkQX8MIoQnQY3jYdPbQGs8eezKYAuy4u3G8dTtrov5UlPaM
	 EWRyh6xqnhGkahoR4b/ES9qaIU9ifJdPxBtzP9PefLeCXbyr9UYGZQ9GfBCLYqSzTq
	 z69GNP8fS2anTDSsVq2BoqzXMtY/q94yNWUlLNfWTv9YoQ7K7FTzSOSI9F1EMC2qFT
	 RWlt+CR/IG81+Bl8pJz7rRy2Y1Khz5Kad9JyQLkMOOZcas6YKn9+UfF/shjehA//w4
	 kmhP7WZwqxl1w==
Date: Tue, 4 Aug 2026 09:47:09 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, david@redhat.com, willy@infradead.org, shakeel.butt@linux.dev, 
	vbabka@kernel.org, jannh@google.com, aliceryhl@google.com, arve@android.com, 
	cmllamas@google.com, christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 3/5] mm: Add RCU-based VMA lookup helper that waits
 for writers
Message-ID: <anGmhgqk-HjhejJL@lucifer>
References: <20260802215459.2769283-1-surenb@google.com>
 <20260802215459.2769283-4-surenb@google.com>
 <anB4uxEbKsa1Re0w@lucifer>
 <CAJuCfpGXk8jfRrJ=JwMLvpzxbNnzJUOYRHfWUX5e4vgP5j72Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGXk8jfRrJ=JwMLvpzxbNnzJUOYRHfWUX5e4vgP5j72Og@mail.gmail.com>

On Mon, Aug 03, 2026 at 12:01:21PM -0700, Suren Baghdasaryan wrote:
> On Mon, Aug 3, 2026 at 4:28 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > >
> >
> > Would be nice to have a:
> >
> > Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> Ack.

Thanks!

>
> >
> > Here given https://lore.kernel.org/linux-mm/af4Zx0gJIWbdDeY2@lucifer/ :)
> >

> > > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > > index e20d01e8d38f..6ff05e68e61b 100644
> > > --- a/mm/mmap_lock.c
> > > +++ b/mm/mmap_lock.c
> > > @@ -338,6 +338,35 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > >       return NULL;
> > >  }
> > >
> > > +/*
> >
> > Why not a kdoc comment?
>
> Indeed. Will change.

Thanks!

>
> >
> > > + * Find the VMA covering 'address' and lock it for reading. Waits for writers to
> > > + * finish if the VMA is being modified. Returns NULL if there is no VMA covering
> > > + * 'address'.
> > > + *
> > > + * Use only in code paths where no mmap_lock and no VMA lock is held.
> >
> > Well, a VMA read lock can be held which would make this a noop essentially.
> >
> > If a VMA write lock is held you're also ok as the mmap read lock will preclude
> > an mmap write lock, meaning vma_end_write_all() will have been called and the
> > write lock released.
> >
> > So I think you can just drop this line?
>
> Maybe instead of this I should say: Use when mmap_lock is not held,
> otherwise use vma_start_read_locked() ? I think that was the original
> reason for this comment.

Yeah that works thanks!

>
> >
> > > + *
> > > + * The fast path does not take mmap_lock.
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
> >
> > This maybe warrants an unlikely() given it can only happen if refcount
> > overflows? Also worth having a comment to that effect here?
>
> vma_start_read_locked()
>   vma_start_read_locked()
>     vma_start_read_locked_nested()
>       unlikely(!__refcount_inc_not_zero_limited_acquire())
>
> already contains "unlikely" clause. Do we need to add it in all its users?
> I can modify the comment for vma_start_read_locked() stating that
> refcount overflow is very unlikely. Would that work or do you want
> callers to have that too?

Ah ok not an issue then. But good to add a comment at least?

> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index edd90892f8cc..c3a0c38a3dc3 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -129,8 +129,10 @@ struct vm_area_struct *find_vma_and_prepare_anon(struct mm_struct *mm,
> > >   *
> > >   * Should be called without holding mmap_lock.
> > >   *
> > > - * Return: A locked vma containing @address, -ENOENT if no vma is found, or
> > > - * -ENOMEM if anon_vma couldn't be allocated.
> > > + * Return: A locked vma containing @address, -ENOENT if no vma is found,
> > > + * -ENOMEM if anon_vma couldn't be allocated, or -EAGAIN if vma refcount
> > > + * overflow happened due to high number of readers and the caller should
> > > + * retry later.
> >
> > I'm guessing you're fixing this up as part of the patch? But it feels a bit
> > random, I mean fine but you should mention this change in the commit message +
> > explain why.
>
> I'm fixing that because Vlastimil asked about these inconsistencies in
> his previous review :)
> I can package these fixes as a separate patch or add a comment in the
> changelog, smth like "While at it, fix the comments for related
> functions". Would that work?

Comment in change log is fine thanks!

--
Cheers, Lorenzo
