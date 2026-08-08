Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01133B0AE8;
	Sat,  8 Aug 2026 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786179696; cv=none; b=ec45Y3nn+7LswT4GqK0NT8iOdNeGgGxRlRtinVawfzlORisAkDVwp7kgqxyOGiZBneBAJC0TCoML/3oE08fjtP5q/suPtRQYqwIfaw68Jjb7OCQOQsyYIh7MbfHajwdtJPreLBa9Oaa2MzpXAHXQz7xF7mNtgY0ubclXhB0VvCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786179696; c=relaxed/simple;
	bh=2SokEHj2ZmZA/9+0U9Iz8XvklBdLfLD90Av6URGtqCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZK4VaXvSVIQqvU3IhpSbio/KQmOgOq/v8uhLpHeBCl8doTZfxtKq+SKVPXCZUHwGkmHfouHI0HHeDnSC8zxm67mEH57zoiUwR3EycqCbZnPLjN1rVK/3a0Mj1arxjOm0NRu8QDISlfOFRlGly66/6iCVz06q6qGv47pOC4nI0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W7lzaSx5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W7lzaSx5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=enYcDXlR0yhFbDH+2aaIlGrTlCM5GxSFhS1h+rPoprw=; b=W7lzaSx5ETUEASip6Ojo9Ht0Dc
	mxlUcZ4DHwrIX3MCzn3+YVbUZYq94+ldl6ZmNuS44kPKc4YkZTPbevAWLnj/C6yT4/eu6F1Yupv8S
	ESKVykga7hYQkc9PvY/+DXMsMW2GNEnZWSe9K3tnGLzgrf2Uq55fqVdGaG3b8APwudxYr/WbwLKDT
	P2bz7OZ6e9Vfc+dS+UGkby30gs8f7RjRPSJqMqpkvky+2gcsLi+Q7MZyJywsYhVgYskgqwekfjriQ
	CXWbYHe3uBXl5MQS51Be2b6KQ6E/uHaKkowZW1cQHZQaureEifZLGeKkvw8dKiW7qysZEQxqUQFxU
	kVpRPlHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsbcQ-00000004vh6-15Hy;
	Sat, 08 Aug 2026 07:37:22 +0000
Date: Sat, 8 Aug 2026 08:37:22 +0100
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
Message-ID: <anbcsiwuxE-8Edgc@casper.infradead.org>
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
> 
> == Solution ==
> 
> Add vma_start_read_unlocked() - a variant of the RCU-based lookup that
> waits for writers. This is basically the same as the existing RCU-based
> lookup, but on a failure to lock it temporarily takes mmap_lock for read
> and waits for writers to finish before locking the VMA, dropping the
> mmap_lock and returning the locked VMA. This has some advantages:
> 
>  1. Callers do not need to have a fallback path for when they
>     collide with writers.
>  2. It can be used in contexts where page faults can happen because
>     it can take the mmap_lock for read but never *holds* it.
>  3. Its fast path does not require taking mmap_lock for read.
> 
> Basically, when applied correctly, this approach results in faster
> *and* simpler code.

Maybe just write a new commit message, because while this is a useful
primitive to have, (as evidenced by patch 5) it doesn't do what this
commit message claims.
