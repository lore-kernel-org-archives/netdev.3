Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF51331354C;
	Sat,  8 Aug 2026 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786179732; cv=none; b=k3Z1jqPrjPm0D03p6YB1iOVwIfDOeN75WwZcnjoH+Cxz8ZqgEbvFW8u14rLSxT3bE3x5WJgTEZhGPEkc+KitmT/GNZ5rGqt5l7XiqnHFEMeoDIQpXbz2am0jSuLwCm1w/ipPdN/qS+TxXDmj0lv2f/VJ5ZipA2FLtVFQApr/u4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786179732; c=relaxed/simple;
	bh=Ta3ydkwxadwVfeEOrPVNo+tQcGjpYYV3d7hcM4vz+js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avoB3TzLxzmDx/B6gZKvbnJbIDgxoqQ3VXoELfcPwP0Puf3nQQA0AtHZJbIYnkOfh+kmWzv3wReERFZOruGl58KGNLPGbKKObMDTS26kjyKh6X4nzLkzl4UAE7HxWw9NwCNni4X7krEuouIUVfQosgE11UbQ9rtkt+jyHQV2TtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BVdRq9Ub; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BVdRq9Ub"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i25+lI2q8WnrC5a18HSJkcZlF/JN3MlaxK8/+QXZiCY=; b=BVdRq9UbvI/M0u/TLUL0NocVdk
	HVYbTisDtERvwSWi5Yz70hqfKSdSwIl8E5T/mUHS+0yZkaJUWss0RcOqTTdPiqCn8/a+Rjd5Clao8
	FwBXwUmMDAVSegrqXQTE7tNrU9iTzbG/+vPy8XpZ9NcX7ebZdp0KODA2ftyba4dQMkQL+v/nuAmRf
	7p1UjWBIxBrjRXPltK8BgrfsiycNfZvEgcBd7QVeMotqnKgz278HcnIwG19zTs6klmDttFJnhmGYx
	TVnL6O4bV55W1EI/CUy2vhFFSqtfaK3hmH3uv1C9cDiAhEBZQlavkiWgl8iS5s5idgMHpVglcsbv+
	P8KgkxHw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsbPr-00000004jNh-11E4;
	Sat, 08 Aug 2026 07:24:23 +0000
Date: Sat, 8 Aug 2026 08:24:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com,
	Liam.Howlett@oracle.com, ljs@kernel.org, david@kernel.org,
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com,
	aliceryhl@google.com, arve@android.com, cmllamas@google.com,
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org,
	davem@davemloft.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 3/5] mm: Add RCU-based VMA lookup helper that waits
 for writers
Message-ID: <anbZpzFbtYG7Ngit@casper.infradead.org>
References: <20260806200548.3124802-1-surenb@google.com>
 <20260806200548.3124802-4-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806200548.3124802-4-surenb@google.com>

On Thu, Aug 06, 2026 at 01:05:46PM -0700, Suren Baghdasaryan wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> == Background ==

I think we can do without the headings?

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

Umm.  I don't see how this avoids deadlock.  Assuming the next patch
converts copy_from_user() to use the VMA lock, surely the following
situation would obtain:

A takes mmap_read_lock
B tries to take mmap_write_lock, blocks
A calls copy_from_user()
A calls vma_start_read_unlocked() (because it doesn't know A actually
holds the mmap_read_lock() already)
A does a lookup under RCU, but gets NULL back (maybe it's calling
c_f_u() with an invalid address?)
A tries to take the mmap_read_lock again to make sure.  Deadlock
because B is waiting for A to release the mmap_read_lock.
 
Am I missing something?

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
