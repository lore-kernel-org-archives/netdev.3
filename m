Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E423A7F50;
	Mon, 10 Aug 2026 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358531; cv=none; b=dzyQNpGUSiOnQiND+rIxb3l7z9uki9x9ZRB+rOhKi6Btrl1u1gX5IJqXXHi7LYALWJoluakcl0bVz2LjcY3fVqAjvKFDqjIYSqkkS1v9I6mGy1Pm1qsWHmvGJ7nJC2P8DPhlbjnm/Xg91SmpDaxPxTAQRQuJEljLHbY2bRFjYtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358531; c=relaxed/simple;
	bh=WGxTiMDkmqQLtSX1485WkmUTOlARMqKeHYhSxpm0huw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qO7fUbCIUAQ9mtyNlhHGnB8+RmEvoiKQANUvPmi+HaBAg85wajZcuv01FITm8jqfGcIbSCYWmxXcplk4ohmVi0YRvRRf3/Xj3+29KpFE08CJJWBDR8WRlastJJgfk5soBK9Ygbl1rhoTJlK5wDpx/VyHrKPsyuJwF1YMvRDt/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPvKTRDH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPvKTRDH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8495C1F00A3A;
	Mon, 10 Aug 2026 10:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786358529;
	bh=TfDEpbXj9Skvq0RQ7XQBYjnmsLgpmOAdrHJWVqiBMAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lPvKTRDHEB+uKRPoWeR6D/YeT/rUTkGXFwbDrQ98m/iDDJ3bmK8saddWm4WCwXZFm
	 u6IH48pvyLJSgRM2ghH3EGYffp7eSbJUnO3fow7dFpesG8pD0hIta+fN2wXlJI7JD9
	 Oe33b54M+bQ/tWbVs0kVjEM1r1m1XTbBHHb016T01AyQpv1hH6KjHpigL1IvqVDF8/
	 Ku8lpLAHZ0bn2GJBqzs6SNnvMl18qhHPXfRRaKkBRnIuN2BOP1OPcgTPGVZZpH03qD
	 bLkOf0Pu728XFi7TISj4VGlk9QffTfjPuiFRBQLhhTGSxj5w6ofVFiBiLOG8QNQr+U
	 uRk940HN2pIgQ==
Date: Mon, 10 Aug 2026 11:41:50 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, david@kernel.org, willy@infradead.org, shakeel.butt@linux.dev, 
	vbabka@kernel.org, jannh@google.com, aliceryhl@google.com, arve@android.com, 
	cmllamas@google.com, christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 3/5] mm: Add RCU-based VMA lookup helper that waits
 for writers
Message-ID: <anmm18_pG4HXMZo_@lucifer>
References: <20260806200548.3124802-1-surenb@google.com>
 <20260806200548.3124802-4-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260806200548.3124802-4-surenb@google.com>

On Thu, Aug 06, 2026 at 01:05:46PM -0700, Suren Baghdasaryan wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> == Background ==
>
> There are basically two parallel ways to look up a VMA: the
> traditional way, which is protected by mmap_read_lock, and the RCU-based
> per-VMA lock way which is based on RCU and refcounts.
>
> == Problem ==
>
> The mmap_lock one is more straightforward to use but it has a big
> disadvantage in that it can not be mixed with page faults since those
> can take mmap_lock for read, which can deadlock when mixed with nested
> page faults and parallel writers.
> For example:
>
> 	mmap_read_lock(mm);
> 	// Another thread does mmap_write_lock().
> 	// New mmap_lock readers are blocked.
> 	vma = vma_lookup(mm, address);
> 	// This deadlocks on mmap_read_lock() if it faults:
> 	copy_from_user(address);
> 	mmap_read_unlock(mm);
>
> The per-VMA lock can be mixed with faults, but they can fail and need to
> be able to fall back to the traditional way.

As discussed in reply to Matthew, this isn't so useful to have here I don't
think.

>
> == Solution ==
>
> Add vma_start_read_unlocked() - a variant of the RCU-based lookup that
> waits for writers. This is basically the same as the existing RCU-based
> lookup, but on a failure to lock it temporarily takes mmap_lock for read
> and waits for writers to finish before locking the VMA, dropping the
> mmap_lock and returning the locked VMA. This has some advantages:

Nitty but maybe reads better as something like:

	..., on failing to acquire the VMA lock it waits for writers to
	finish by temporarily acquiring the mmap read lock and taking the
	VMA lock with it held via vma_start_read_locked() before dropping
	it again.

>
>  1. Callers do not need to have a fallback path for when they
>     collide with writers.
>  2. It can be used in contexts where page faults can happen because
>     it can take the mmap_lock for read but never *holds* it.
>  3. Its fast path does not require taking mmap_lock for read.
>
> Basically, when applied correctly, this approach results in faster
> *and* simpler code.

I think this suffices as justification for the function with the above
deadlock scenario simply excised.

>
> While at it, fix the comments for vma_start_read_locked(),
> vma_start_read_locked_nested(), and uffd_lock_vma().
>
> Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Thanks :>)

> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

LGTM, so with the changes to commit message applied feel free to add:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: linux-mm@kvack.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hjønnevåg <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: netdev@vger.kernel.org
> ---
>  include/linux/mmap_lock.h | 19 +++++++++++++++----
>  mm/mmap_lock.c            | 35 +++++++++++++++++++++++++++++++++++
>  mm/userfaultfd.c          |  6 ++++--
>  3 files changed, 54 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 7b2bbb09a952..a23fe6cbe301 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -228,10 +228,14 @@ static inline void vma_refcount_put(struct vm_area_struct *vma)
>  }
>
>  /*
> - * Use only while holding mmap read lock which guarantees that locking will not
> - * fail (nobody can concurrently write-lock the vma). vma_start_read() should
> + * Use only while holding mmap read lock which guarantees that vma lock is not
> + * contended (nobody can concurrently write-lock the vma). vma_start_read() should
>   * not be used in such cases because it might fail due to mm_lock_seq overflow.
>   * This functionality is used to obtain vma read lock and drop the mmap read lock.
> + *
> + * VMA can't be detached while we are holding mmap lock, therefore in practice this
> + * function can fail only when there are so many readers that vm_refcnt overflows.
> + * The failure case is very unlikely and is already annotated as such internally.
>   */
>  static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
>  {
> @@ -247,16 +251,23 @@ static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int
>  }
>
>  /*
> - * Use only while holding mmap read lock which guarantees that locking will not
> - * fail (nobody can concurrently write-lock the vma). vma_start_read() should
> + * Use only while holding mmap read lock which guarantees that vma lock is not
> + * contended (nobody can concurrently write-lock the vma). vma_start_read() should
>   * not be used in such cases because it might fail due to mm_lock_seq overflow.
>   * This functionality is used to obtain vma read lock and drop the mmap read lock.
> + *
> + * VMA can't be detached while we are holding mmap lock, therefore in practice this
> + * function can fail only when there are so many readers that vm_refcnt overflows.
> + * The failure case is very unlikely and is already annotated as such internally.
>   */
>  static inline bool vma_start_read_locked(struct vm_area_struct *vma)
>  {
>  	return vma_start_read_locked_nested(vma, 0);
>  }
>
> +struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
> +					       unsigned long address);
> +
>  static inline void vma_end_read(struct vm_area_struct *vma)
>  {
>  	vma_refcount_put(vma);
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index e20d01e8d38f..1c4902131e98 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -338,6 +338,41 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  	return NULL;
>  }
>
> +/**
> + * vma_start_read_unlocked() - Find the VMA covering 'address' and read-lock it.
> + * @mm: the mm_struct of the address space to search
> + * @address: address that the vma should contain
> + *
> + * The fast path does not take mmap_lock. Waits for writers to finish if the
> + * VMA is being modified by taking mmap_lock.
> + * Use when mmap_lock is not held, otherwise use vma_start_read_locked().
> + * Nothing prevents VMAs being unmapped/mapped before or after the VMA is
> + * looked up, if a stronger guarantee is required, take an mmap_lock.

Great thanks!

> + *
> + * Return: If a VMA exists which spans @address, return that VMA, read-locked.
> + * If no VMA is mapped there or, very unlikely, a reference count overflow
> + * occurred, return NULL.
> + */
> +struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
> +					       unsigned long address)
> +{
> +	struct vm_area_struct *vma;
> +
> +	/* Fast path: return stable VMA covering 'address': */
> +	vma = lock_vma_under_rcu(mm, address);
> +	if (vma)
> +		return vma;
> +
> +	/* Slow path: preclude VMA writers by temporarily getting mmap read lock. */
> +	mmap_read_lock(mm);
> +	vma = vma_lookup(mm, address);
> +	if (vma && !vma_start_read_locked(vma))
> +		vma = NULL;
> +	mmap_read_unlock(mm);
> +
> +	return vma;
> +}
> +
>  static struct vm_area_struct *lock_next_vma_under_mmap_lock(struct mm_struct *mm,
>  							    struct vma_iterator *vmi,
>  							    unsigned long from_addr)
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index edd90892f8cc..c3a0c38a3dc3 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -129,8 +129,10 @@ struct vm_area_struct *find_vma_and_prepare_anon(struct mm_struct *mm,
>   *
>   * Should be called without holding mmap_lock.
>   *
> - * Return: A locked vma containing @address, -ENOENT if no vma is found, or
> - * -ENOMEM if anon_vma couldn't be allocated.
> + * Return: A locked vma containing @address, -ENOENT if no vma is found,
> + * -ENOMEM if anon_vma couldn't be allocated, or -EAGAIN if vma refcount
> + * overflow happened due to high number of readers and the caller should
> + * retry later.
>   */
>  static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
>  				       unsigned long address)
> --
> 2.55.0.654.g21b8a5bc05-goog
>

--
Cheers, Lorenzo
