Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC973542CF;
	Mon,  3 Aug 2026 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769224; cv=none; b=km5U93zTa0p8V68c3IGMyotzjvgvKMFLz7un58kNfsw2NOuN7PzJxG05xV6Fy5APpDFYQ1fuLjyU4mWFCE1n/OAKCQLfEodB7QNjJGEoGmidE+F/++bY4q79CwIhWOAmIII/zg6CWCUp3ve6x7CaCVoP76fXlbO+kUAxC6VhRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769224; c=relaxed/simple;
	bh=xn7HS/i4bXS7raN+YmRA7gDPOscAguRsatQPD6RRxRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnEbjmU5zSEIPkDRg3lf31Lx2qMeLA/deDypQFmj7HXtiRNN/B1Xs+Q1hEXRP2F4q8dKLRp7N9dog1Qia8Wn0Vr7+lz4dME3OqqLgl6JBZ9KYDK2OArPJuMNuZP8AQNXij1XoVvU96ZG5rq9tSDmtR5+/hu9UW0hZV/1KUwonK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vik1jTt9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vik1jTt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497791F000E9;
	Mon,  3 Aug 2026 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785769222;
	bh=DYHyaHJJHP3pEUUb5RArEn5q/XsXxIfPC78T9whGzr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vik1jTt96uERvXxcpWMtBKyCMxM7oKJ8U3XxdDaLQjOA/eaiXi9ghWpojIC1nx5sj
	 SInRjLBNlBxYVLqGczOlWQMaFdN7nqiY+qvXjmqmdz8kz7VZbEWVD9poNGm+i26c2M
	 JK1AQu1n0NWlD/Cthka2vqxGKv+RqTy6RJCNnh4fGsjxYhe7JjkXDCFhonSQO/DjdM
	 7Wq3J1rNCZMF+d60g7RJOjJv9u1PMhlIym75jFvhPbqutLH5HW8cGvify3q8CTj5Y3
	 LSWGOaVywlWzPaS6TqltFmgDdeDHYBpn1Fz0VpobpJvslhtUb787FiEPCfDsP9oVun
	 HxVT9AwBzssKg==
Date: Mon, 3 Aug 2026 16:00:04 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, david@redhat.com, willy@infradead.org, 
	shakeel.butt@linux.dev, jannh@google.com, aliceryhl@google.com, arve@android.com, 
	cmllamas@google.com, christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 3/5] mm: Add RCU-based VMA lookup helper that waits
 for writers
Message-ID: <anCst8u7ybHf39n8@lucifer>
References: <20260802215459.2769283-1-surenb@google.com>
 <20260802215459.2769283-4-surenb@google.com>
 <152ee467-b5e4-470c-ad95-c638aa9986bc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <152ee467-b5e4-470c-ad95-c638aa9986bc@kernel.org>

On Mon, Aug 03, 2026 at 04:55:19PM +0200, Vlastimil Babka (SUSE) wrote:
> On 8/2/26 23:54, Suren Baghdasaryan wrote:
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> >
> > == Background ==
> >
> > There are basically two parallel ways to look up a VMA: the
> > traditional way, which is protected by mmap_read_lock, and the RCU-based
> > per-VMA lock way which is based on RCU and refcounts.
> >
> > == Problem ==
> >
> > The mmap_lock one is more straightforward to use but it has a big
> > disadvantage in that it can not be mixed with page faults since those
> > can take mmap_lock for read, which can deadlock when mixed with nested
> > page faults and parallel writers.
> > For example:
> >
> > 	mmap_read_lock(mm);
> > 	// Another thread does mmap_write_lock().
> > 	// New mmap_lock readers are blocked.
> > 	vma = vma_lookup(mm, address);
> > 	// This deadlocks on mmap_read_lock() if it faults:
> > 	copy_from_user(address);
> > 	mmap_read_unlock(mm);
> >
> > The per-VMA lock can be mixed with faults, but they can fail and need to
> > be able to fall back to the traditional way.
> >
> > == Solution ==
> >
> > Add a variant of the RCU-based lookup that waits for writers. This is
> > basically the same as the existing RCU-based lookup, but on a failure to
> > lock it temporarily takes mmap_lock for read and waits for writers
> > to finish before locking the VMA, dropping the mmap_lock and returning
> > the locked VMA. This has some advantages:
>
> Maybe mention that the helper is called vma_start_read_unlocked()?
>
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
> > Cc: Arve Hjønnevåg <arve@android.com>
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
> > @@ -228,10 +228,12 @@ static inline void vma_refcount_put(struct vm_area_struct *vma)
> >  }
> >
> >  /*
> > - * Use only while holding mmap read lock which guarantees that locking will not
> > - * fail (nobody can concurrently write-lock the vma). vma_start_read() should
> > + * Use only while holding mmap read lock which guarantees that vma lock is not
> > + * contended (nobody can concurrently write-lock the vma). vma_start_read() should
> >   * not be used in such cases because it might fail due to mm_lock_seq overflow.
> >   * This functionality is used to obtain vma read lock and drop the mmap read lock.
> > + * VMA can't be detached while we are holding mmap lock, therefore in practice this
> > + * function can fail only when there are so many readers that vm_refcnt overflows.
> >   */
> >  static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
> >  {
> > @@ -247,16 +249,21 @@ static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int
> >  }
> >
> >  /*
> > - * Use only while holding mmap read lock which guarantees that locking will not
> > - * fail (nobody can concurrently write-lock the vma). vma_start_read() should
> > + * Use only while holding mmap read lock which guarantees that vma lock is not
> > + * contended (nobody can concurrently write-lock the vma). vma_start_read() should
> >   * not be used in such cases because it might fail due to mm_lock_seq overflow.
> >   * This functionality is used to obtain vma read lock and drop the mmap read lock.
> > + * VMA can't be detached while we are holding mmap lock, therefore in practice this
> > + * function can fail only when there are so many readers that vm_refcnt overflows.
> >   */
> >  static inline bool vma_start_read_locked(struct vm_area_struct *vma)
> >  {
> >  	return vma_start_read_locked_nested(vma, 0);
> >  }
> >
> > +struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
> > +					       unsigned long address);
> > +
> >  static inline void vma_end_read(struct vm_area_struct *vma)
> >  {
> >  	vma_refcount_put(vma);
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > index e20d01e8d38f..6ff05e68e61b 100644
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -338,6 +338,35 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> >  	return NULL;
> >  }
> >
> > +/*
> > + * Find the VMA covering 'address' and lock it for reading. Waits for writers to
> > + * finish if the VMA is being modified. Returns NULL if there is no VMA covering
> > + * 'address'.
>
> Hm but it can also return NULL when vm_refcnt overflows, in theory.
> Should we also return -EAGAIN (like uffd_lock_vma() below), or just retry in
> here and hope for the best? The latter would be simpler for the users.
> (AFAICS due to VM_REFCNT_LIMIT we never end up triggering the refcount
> saturation)

The problem is everything's unlocked so 'didn't find a VMA' doesn't really mean
much more than 'something went wrong' because hey maybe if you check again now
you'll find something :)

So I think this might be a feature more than a bug, especially given overflow is
not exactly likely.

>
> > + *
> > + * Use only in code paths where no mmap_lock and no VMA lock is held.
> > + *
> > + * The fast path does not take mmap_lock.
> > + */
> > +struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
> > +					       unsigned long address)
> > +{
> > +	struct vm_area_struct *vma;
> > +
> > +	/* Fast path: return stable VMA covering 'address': */
> > +	vma = lock_vma_under_rcu(mm, address);
> > +	if (vma)
> > +		return vma;
> > +
> > +	/* Slow path: preclude VMA writers by temporarily getting mmap read lock. */
> > +	mmap_read_lock(mm);
> > +	vma = vma_lookup(mm, address);
> > +	if (vma && !vma_start_read_locked(vma))
> > +		vma = NULL;
> > +	mmap_read_unlock(mm);
> > +
> > +	return vma;
> > +}
> > +
> >  static struct vm_area_struct *lock_next_vma_under_mmap_lock(struct mm_struct *mm,
> >  							    struct vma_iterator *vmi,
> >  							    unsigned long from_addr)
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index edd90892f8cc..c3a0c38a3dc3 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -129,8 +129,10 @@ struct vm_area_struct *find_vma_and_prepare_anon(struct mm_struct *mm,
> >   *
> >   * Should be called without holding mmap_lock.
> >   *
> > - * Return: A locked vma containing @address, -ENOENT if no vma is found, or
> > - * -ENOMEM if anon_vma couldn't be allocated.
> > + * Return: A locked vma containing @address, -ENOENT if no vma is found,
> > + * -ENOMEM if anon_vma couldn't be allocated, or -EAGAIN if vma refcount
> > + * overflow happened due to high number of readers and the caller should
> > + * retry later.
> >   */
> >  static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
> >  				       unsigned long address)
>

--
Cheers, Lorenzo
