Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D33539D6F2;
	Mon, 10 Aug 2026 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351946; cv=none; b=Jw6/z1Zkp0ydZVwKWHmuP5j2yYc1a8Osf7gJiikUrGtAThAS7rVGVlslY3JXIU48JHHIv9vwGkMmj8uLdv0aJKoqQtmzphTqqeFmo1btb122JoCvxr4UrC48BtlIto8agT/gyVhLPFnCJTIGOksn89GthoUkI4/sgLMbbVRsjGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351946; c=relaxed/simple;
	bh=9fXe0wPPrPf7LEsugMCL6cx+2x0oY+kpAVnhj5p+61g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKnhT0uUdCjMKAZ3TdDRHRyvg0zZc5GhtW+Dt3Cu7kG39RjHlnNlgPFfSbK06xREpiZqR54aj0xc5Pav0buooYsiYqT+hV3Q/32wHhwoprOOO+aDptKLrzMbxhUb2XZnerRChy5OA5ztToEaO41sfiRmmer7l+lWtq1tFSv6GXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvEc+zMN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvEc+zMN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EA11F000E9;
	Mon, 10 Aug 2026 08:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786351944;
	bh=ja+bbx5/k6Ur1P7gZyvdceXvb5QS4sd8f7Hohxvn9oM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZvEc+zMNW/8pT1cKRhb+nZuoMlg8vdkHd5yuLE0Zg2dtbFRoUlPsDVJq/FLUCnzRF
	 La41lPi+VTuopR4OysD0A1dMw2M42MuSZZUFs+qq6QRzoAVJ0mUkjB/RIUGzYzIxsh
	 8HnQlkioNc97hH//K4APckBNNLx4SsIxHr6LHABqM86ZmR4h3L29Y8b2RA2UHQvlOC
	 H2+Lzf7M60DlULqEK8kb6Tp2a/r4+MEgoErg2PEfESuaO9CQH0rdoZUZ3CBqBcWZMi
	 HLwID1l/RyAc/ZSHUbV8BPFjJ1B3yYzPWmWzkQOMDS7ZpAmVDruN/Q8TbJ3gaIqXO6
	 zlnsg5aWbiGiQ==
Date: Mon, 10 Aug 2026 09:52:04 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, david@kernel.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com, aliceryhl@google.com, 
	arve@android.com, cmllamas@google.com, christian@brauner.io, tkjos@android.com, 
	dsahern@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/5] mm: Make per-VMA locks available universally
Message-ID: <anmQIeQIGkZdCKVU@lucifer>
References: <20260806200548.3124802-1-surenb@google.com>
 <20260806200548.3124802-2-surenb@google.com>
 <anaCkrk55EQoE2aS@casper.infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anaCkrk55EQoE2aS@casper.infradead.org>

On Sat, Aug 08, 2026 at 02:12:50AM +0100, Matthew Wilcox wrote:
> On Thu, Aug 06, 2026 at 01:05:44PM -0700, Suren Baghdasaryan wrote:
> > +++ b/kernel/bpf/stackmap.c
> > @@ -272,13 +272,8 @@ struct stack_map_vma_lock {
> >  /*
> >   * Acquire a stable read-side reference on the VMA covering @ip.
> >   *
> > - * With CONFIG_PER_VMA_LOCK=y this returns a VMA with its per-VMA read
> > - * lock held and mmap_lock dropped, so the caller may sleep.
> > - *
> > - * With CONFIG_PER_VMA_LOCK=n it returns a VMA with mmap_lock still
> > - * held; the caller must snapshot any fields it needs and pin vm_file
> > - * with get_file() before stack_map_unlock_vma() drops mmap_lock, as
> > - * the VMA may be split, merged, or freed after that.
> > + * This returns a VMA with its per-VMA read lock held and mmap_lock
> > + * dropped, so the caller may sleep.
>
> I don't know if BPF is compatible with !MMU or not, but the comment
> is inconsistent with the code.  How about:

<requisite nommu rant>

I do think there are components that simply don't think to depend on CONFIG_MMU
even though they do.

In fact more than think - have run into exactly that before.

It's another thing that speaks to nommu being a legacy barnacle that bashes us
on the head fairly regularly for little to no gain (and nobody is testing it for
tip kernel AFAICT).

</requisite nommu rant>

>
>  * On NOMMU configurations, returns with the mmap_lock held.  If the MMU
>  * is enabled, the per-VMA lock will be held instead.  The lock
>  * should be released with stack_map_unlock_vma() which will release the
>  * appropriate lock.  Once the lock is released, the VMA may be freed.

I mean I suppose it's accurate but I don't love the idea of essentially implying
nommu+bpf is a thing and also treating it as so important that it must be called
out here.

I'd rather it be inaccurate for nommu as are most comments in mm and mm-adjacent
components, it's kinda implied in general. Those who care can look at the code.

>
> >   * Returns NULL on failure, in which case no lock is held.
> >   */
> > @@ -288,7 +283,6 @@ stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
> >  	struct mm_struct *mm = lock->mm;
> >  	struct vm_area_struct *vma;
> >
> > -	/* noop under !CONFIG_PER_VMA_LOCK */
> >  	vma = lock_vma_under_rcu(mm, ip);
> >  	if (vma) {
> >  		lock->vma = vma;
> > @@ -308,21 +302,20 @@ stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
> >  		return NULL;
> >  	}
> >
> > -#ifdef CONFIG_PER_VMA_LOCK
> > +#ifdef CONFIG_MMU
> >  	if (!vma_start_read_locked(vma)) {
> >  		mmap_read_unlock(mm);
> >  		return NULL;
> >  	}
> >  	mmap_read_unlock(mm);
> >  #endif
> > -
> >  	lock->vma = vma;
> >  	return vma;
> >  }

--
Cheers, Lorenzo
