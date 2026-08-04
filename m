Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BEE43CE47;
	Tue,  4 Aug 2026 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834957; cv=none; b=NAF4ZlgtUTlJC13cZlTv4vsnBvPtQRAtygpqMJF7tosYmvzkG0MtqsuXbmcH9jIahAnNCsyXHENtgCfUd7LoCz62HpJnPSCodO4ERIbZ2cysw9hIcGW8sMEMVB9wBep9DXRA9JBegQVgpRtb0cvFIYleMbgXkypUnnrOZ3MPp9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834957; c=relaxed/simple;
	bh=N+8lOiPK/zx1hLf2lsaNjsg7FWoUVWAFnoajIOzPEio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3zft1UXDlJFlhkFtTplvXrBki7JeTpZiNRbMcXAynKPiGdN2Ju7oB2pm1iZymq1JTaONf2+xDlI25KGXtxjDQx1aDmoFyF9ncLhi077N0qbyMIdnJa/sywhHsUnMdagbyk6JkRaBoj8JejZ3pCJ/W2PusdJIT29BoLk64To+O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IP77FCNl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IP77FCNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950531F000E9;
	Tue,  4 Aug 2026 09:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785834956;
	bh=N+8lOiPK/zx1hLf2lsaNjsg7FWoUVWAFnoajIOzPEio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IP77FCNlujLEZJxBpA1To4wJJrfrBZJ8ili1VbgkD0dIE4al2SH744rzn1B1gnBs7
	 nHD57ielGtxCer28m/Dql3HHTnvjClXL0hBR/e857l5RxOizXFJUTsC+zADB9xZy9z
	 /q/DVrR/gmGLGhtv8qg2wcI4dNOtEz08s7c0+SC9PcYcsleZASCMErq0ly4YnRdcR4
	 D1gzK3hp08iT3hWMOoyEO2BSJeue4dZRe5YVxMpZloQLYvExBY2MePtqX4lxiBV4+7
	 hHvIyQ3Y8gtccpOrnCGjyv83CkwKn6AfmJeUoJgTwRr3xXUqEeLqCfBRaMDENillRJ
	 Od7C64eOAXJTg==
Date: Tue, 4 Aug 2026 10:15:36 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, david@redhat.com, willy@infradead.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com, arve@android.com, 
	cmllamas@google.com, christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/5] binder: Make shrinker rely solely on per-VMA lock
Message-ID: <anGtsbfmlJ-HmpkZ@lucifer>
References: <20260802215459.2769283-1-surenb@google.com>
 <20260802215459.2769283-3-surenb@google.com>
 <anBj40CVAhcGMnQ4@google.com>
 <anByayBh6Ed2bXox@lucifer>
 <CAJuCfpFTqK0jkhm6FQ8Q7DrPG+VSeKufV4Wyny-a3bDi-7R-iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFTqK0jkhm6FQ8Q7DrPG+VSeKufV4Wyny-a3bDi-7R-iw@mail.gmail.com>

On Mon, Aug 03, 2026 at 11:02:06AM -0700, Suren Baghdasaryan wrote:
> On Mon, Aug 3, 2026 at 3:50 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >
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
> No. I think the corresponding function is rust_shrink_free_page() and
> it does not have mmap_fallback logic. IIUC, it just returns LRU_SKIP
> on failure.

OK great thanks :)

>
> >
> > --
> > Cheers, Lorenzo

--
Cheers, Lorenzo
