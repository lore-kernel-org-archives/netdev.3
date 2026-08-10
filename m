Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CD8374E5A;
	Mon, 10 Aug 2026 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354991; cv=none; b=rMVF6w5gxzYN4v/mjmt7PZe+T5RjAw7vO8O0el9HILLDHA5WtRW7a653ZzfdzkzoDohLpGfh1UOA98Z31+9CBLb0wx6TGuJzRBUCx6L1qKo/dZI9ubJq0GFPpQXXxEe5Hg5vOhIT8WGZEM3rY8V0/BwZrUMhjpEBjblSdr+Ucmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354991; c=relaxed/simple;
	bh=l+cR3J68XUwLYKOjIhys3aXYI/2Uhx6EGHAfFq84X7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZH4XaMmm1ca7DIpyZaS5012NmvblVCG1eNR2gGbkkl8TFxoOjhAo3t+OO7KP1paDNQm7fUZec/HywDSyeNJjIfLA5AM/jppl9k0Y/d4J3OYFJMCoqyldGzAh13zX+IhovLMTd1XyQJPgTN86UpNGcy65y92wIszZQxZGkwXsT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5ogNfyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5ogNfyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD961F000E9;
	Mon, 10 Aug 2026 09:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786354989;
	bh=e8BIKK72EEk4vSL3MS2OzVc4EJiHSyxg4H3wiEsIixo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X5ogNfydnasoQr309886Ja2GO43RLBsS4PLRGVyttiCWNVDzlnuKnK9IQX1ibfqW2
	 r7f5decVshZ+9sjleIIazcUeWZjhxp2Na2uolb3dbUCPXH4ZEonsn90iy6mV7sqFjS
	 /pRjIpoHU9mumz5A4CQo9h423jYS4g26xtEUzEkP1OEcehl4whuMKSWdC5GFWOZ+ED
	 oP4oWpZhjEeiuxhLE0KWPNVVpw1EBhnB8a1/q74iZ+EwrGCWEf6czVYOm2yBskl/Iz
	 YQ4Jvxie7g8QgbtF04zkLqzlHYLf8icFlUGkxbHRKgUQa1xC0cee0UzX70Np/e9JUH
	 qcdR5LkZQpvnA==
Date: Mon, 10 Aug 2026 10:42:50 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, david@kernel.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com, aliceryhl@google.com, 
	arve@android.com, cmllamas@google.com, christian@brauner.io, tkjos@android.com, 
	dsahern@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/5] mm: Make per-VMA locks available universally
Message-ID: <anmcwYilggkd_-B5@lucifer>
References: <20260806200548.3124802-1-surenb@google.com>
 <20260806200548.3124802-2-surenb@google.com>
 <anaCkrk55EQoE2aS@casper.infradead.org>
 <anmQIeQIGkZdCKVU@lucifer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anmQIeQIGkZdCKVU@lucifer>

On Mon, Aug 10, 2026 at 09:52:11AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Sat, Aug 08, 2026 at 02:12:50AM +0100, Matthew Wilcox wrote:
> > On Thu, Aug 06, 2026 at 01:05:44PM -0700, Suren Baghdasaryan wrote:
> > > +++ b/kernel/bpf/stackmap.c
> > > @@ -272,13 +272,8 @@ struct stack_map_vma_lock {
> > >  /*
> > >   * Acquire a stable read-side reference on the VMA covering @ip.
> > >   *
> > > - * With CONFIG_PER_VMA_LOCK=y this returns a VMA with its per-VMA read
> > > - * lock held and mmap_lock dropped, so the caller may sleep.
> > > - *
> > > - * With CONFIG_PER_VMA_LOCK=n it returns a VMA with mmap_lock still
> > > - * held; the caller must snapshot any fields it needs and pin vm_file
> > > - * with get_file() before stack_map_unlock_vma() drops mmap_lock, as
> > > - * the VMA may be split, merged, or freed after that.
> > > + * This returns a VMA with its per-VMA read lock held and mmap_lock
> > > + * dropped, so the caller may sleep.
> >
> > I don't know if BPF is compatible with !MMU or not, but the comment
> > is inconsistent with the code.  How about:
>
> <requisite nommu rant>
>
> I do think there are components that simply don't think to depend on CONFIG_MMU
> even though they do.
>
> In fact more than think - have run into exactly that before.
>
> It's another thing that speaks to nommu being a legacy barnacle that bashes us
> on the head fairly regularly for little to no gain (and nobody is testing it for
> tip kernel AFAICT).
>
> </requisite nommu rant>
>
> >
> >  * On NOMMU configurations, returns with the mmap_lock held.  If the MMU
> >  * is enabled, the per-VMA lock will be held instead.  The lock
> >  * should be released with stack_map_unlock_vma() which will release the
> >  * appropriate lock.  Once the lock is released, the VMA may be freed.
>
> I mean I suppose it's accurate but I don't love the idea of essentially implying
> nommu+bpf is a thing and also treating it as so important that it must be called
> out here.
>
> I'd rather it be inaccurate for nommu as are most comments in mm and mm-adjacent
> components, it's kinda implied in general. Those who care can look at the code.

Actually scratch that I'm wrong, firstly Suren's series explicitly does some
nommu-specific logic in the bpf code and secondly BPF already has nommu-specific
stuff in it.

It seems nommu bpf is (kinda) a supported path.

>
> >
> > >   * Returns NULL on failure, in which case no lock is held.
> > >   */

--
Cheers, Lorenzo
