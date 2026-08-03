Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41DA3BCD17;
	Mon,  3 Aug 2026 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756860; cv=none; b=uhoWQUDvTEOVSDb1skvz8Drml59gMAgszuxZYiIZq4MT3ZH2DCJqB1FYqjxXDqn/xQDo7lPZD8QyJw7wsRdby7kVVo7EAlGecUi8gE6EeqYrpeGA0o/AdzJhcPoHTqt96NmKrAhNh/uUuVcxIZUW5+VCcyKc4Y9Nb2ymlNRYo7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756860; c=relaxed/simple;
	bh=0kHUmLMeRZVJZjueskv9sjmPlPCMx3RZ4Rj1jejfviM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFeibEB06LYWz2bpwvJgd8XEiDPly8zTICb4fTmd9HqNPz91+LzSM2orLFBQgBNarR+nnjsE+lJ9br6jOMXgegvNG04guiTwyVE506BXKnthyDLNY6Wb+UTtUWAZ+c3vOI9d+kfxobHilk7TmgEbs6mtMu0VRu5h1OU8Yjcpzhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laxXRj3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laxXRj3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8171F000E9;
	Mon,  3 Aug 2026 11:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785756858;
	bh=0kHUmLMeRZVJZjueskv9sjmPlPCMx3RZ4Rj1jejfviM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=laxXRj3+r8yZ9K+RSpG6vi6zKPDvYe3GBYTALOFtRWTH76t/I70VijHNz5j7r1YnN
	 K42uEbRi7TYxjqJpNq+sI8ickY/webiCvSvJ4kA92iCsWF1MF+nH2sJgSjPaxlVNaA
	 nkFiYLwbaCdJmmm2ra700kIvVrWHk+HsMAQen60pOIryMAaBgjOWl0fkQzZzefnGmL
	 tywpJe+9RccEmg8ZJLN9bo//HnItnHLK/3+HLNxSC1noJ3RzfapmRypwjRqBQrWqLP
	 78wZoIX9HcVY45Kr80Wpuk4lxUiGHBOySzTDyOnpoRxcpSJjtjHfNbCTMLSf98w+Up
	 pqe/HkGpyJsTw==
Date: Mon, 3 Aug 2026 12:33:59 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, david@redhat.com, willy@infradead.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com, arve@android.com, 
	cmllamas@google.com, christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/5] binder: Make shrinker rely solely on per-VMA lock
Message-ID: <anB8kGIczeuqRA_P@lucifer>
References: <20260802215459.2769283-1-surenb@google.com>
 <20260802215459.2769283-3-surenb@google.com>
 <anBj40CVAhcGMnQ4@google.com>
 <anByayBh6Ed2bXox@lucifer>
 <anB3XVHI2nVgz_T8@lucifer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anB3XVHI2nVgz_T8@lucifer>

On Mon, Aug 03, 2026 at 12:11:42PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Aug 03, 2026 at 11:50:41AM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Aug 03, 2026 at 09:48:19AM +0000, Alice Ryhl wrote:
> > > On Sun, Aug 02, 2026 at 02:54:56PM -0700, Suren Baghdasaryan wrote:
> > > > From: Dave Hansen <dave.hansen@linux.intel.com>
> > > >
> > > > tl;dr: lock_vma_under_rcu() is already a trylock. No need to do both
> > > > it and mmap_read_trylock().
> > > >
> > > > Long Version:
> > > >
> > > > == Background ==
> > > >
> > > > Historically, binder used an mmap_read_trylock() in its shrinker code.
> > > > This ensures that reclaim is not blocked on an mmap_lock. Commit
> > > > 95bc2d4a9020 ("binder: use per-vma lock in page reclaiming") added
> > > > support for the per-VMA lock, but left mmap_read_trylock() as a
> > > > fallback.
> > > >
> > > > This was presumably because the per-VMA locking can fail for several
> > > > reasons and most (all?) lock_vma_under_rcu() callers have a fallback
> > > > to mmap_read_trylock().
> > > >
> > > > == Problem ==
> > > >
> > > > The fallback is not worth the complexity here. lock_vma_under_rcu() is
> > > > essentially already a non-blocking trylock. The main reason it fails
> > > > is also the reason mmap_read_trylock() fails: something is holding
> > > > mmap_write_lock().
> > > >
> > > > The only remedy for a collision with mmap_write_lock() is to wait,
> > > > which this code can not do. So the "fallback" after
> > > > lock_vma_under_rcu() failure is not really a fallback: it is really
> > > > likely to just be retrying in vain. That retry in an of itself isn't
> > > > horrible. But it adds complexity.
> > > >
> > > > == Solution ==
> > > >
> > > > Now that per-VMA locks are universally available, lock_vma_under_rcu()
> > > > will not persistently fail. Rely on it alone and simplify the code.
> > > >
> > > > Full disclosure: I originally tried to do this with
> > > > lock_vma_under_rcu_wait(), but it did not fit well with the mmap_lock
> > > > trylock semantics. Claude caught this in a review and suggested the
> > > > approach in this path. It seemed sane to me. So, Suggesed-by: Claude,
> > > > I guess.
> > > >
> > > > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >
> > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >
> > Is there anything on the rust side that needs to be changed also?
>
> Ah ok addressed in 4/5, disregard :)

OK disregard the disregard :)) that addresses something different. So question
remains :P

--
Cheers, Lorenzo
