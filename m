Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78F53ECBC7;
	Thu,  3 Sep 2026 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468537; cv=none; b=gPcJ/4t65aVlGArKiw/QyUTkSYaC/c5IxknzZ5Vx3nMtt7D3Fsm0hx43eu5az5qLxZ1K98WFbeSW7PimAGha4viXgE6TrviRJZirsLMhjpDbZj64owv3NVcS5u6UxahRf5sdM10wTOGvJ5NHB/ENxEiDXvTpYyKJGgLt5e0FubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468537; c=relaxed/simple;
	bh=vO5Hl0YM5t5B3BwS9+sV78HZ1FjGZ91qkObHFTgba1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqdiWpLB6q+NBAOU7If5SLkZIlVF8c31Xh/r80gHUzd8ncCxiqVIkdqwuAxyG/9cpQinR+6/CP+3V4dprYScmT4Ul2CVyKqtR0+mL1oJjEtjcMB9l3SKGIYr13/bLPN8dHS57fkDKhRB6YKKS5Ge8yUGuwd6S6llwn9Zdtwji3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rj71mU+H; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rj71mU+H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Du1gRA36J1zj7kF4LQrKEJ5dJV/B/IFUJjgHMfdrnXY=; b=Rj71mU+HtoUJyHUY+FEf++U/6Q
	rYCK02wjC/WDCmMc9VfVB9QzKni2praHxmrf21jn82TgYUELJSsod8L1Jc3B29b+XHPcYlH3ZXwpV
	Yf77Co01UtaFMBAkhwEPUwWcWka6mGSjAWBkEJ5/Hi+S5pHlKE0bol12QXwM5lNjqKPwvTkLSQo69
	/7TjdM9l4Y3ghRpjEqJOUMKpBZfDZm4LbkpBpWauMEylXGfgqLfZ0QHT8NXssWHt7JnIqgT0OxOy8
	1PWg15tzA8DAP9kWAn9KJj89dqIfQKsP6im59fKpRxeJCiCod27hGXtbn+jVawxxVGkuJJXzwEcG3
	oq68VlLg==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2EMR-00000000aD8-0e8i;
	Thu, 03 Sep 2026 20:48:39 +0000
Date: Thu, 3 Sep 2026 16:48:31 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, 
	ljs@kernel.org, david@redhat.com, willy@infradead.org, shakeel.butt@linux.dev, 
	vbabka@kernel.org, jannh@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, davem@davemloft.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v6 0/5] mm: Unconditional per-VMA locks and cleanups
Message-ID: <aalhqe37szvcitr46c4fk6xcjtjjzm4zfm7ltrno2spipvq2q5@7svyjfbegb3s>
References: <20260813193433.3318288-1-surenb@google.com>
 <20260829185625.f5ee1b2931818843a78af88d@linux-foundation.org>
 <apVhzM2501wSiGGg@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apVhzM2501wSiGGg@google.com>

On 26/08/31 11:13AM, Alice Ryhl wrote:
> On Sat, Aug 29, 2026 at 06:56:25PM -0700, Andrew Morton wrote:
> > On Thu, 13 Aug 2026 12:34:28 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> > 
> > > v2 version of this patchset [1] was written by Dave Hansen and per his
> > > request, I'm taking over this series.
> > > 
> > > tl;dr: Make per-VMA locks available in all configs. Simplify some
> > > of the per-VMA lock users now that they can rely on them being
> > > always available.
> > 
> > It's been 2+ weeks so perhaps a refresh-and-remind would be helpful.
> > 
> > But it applies well enough and is adequately reviewed so I put it in
> > there for testing, thanks.
> > 
> > AI review might have found a couple of pre-existing binder bugs:
> > 
> > 	https://sashiko.dev/#/patchset/20260813193433.3318288-1-surenb@google.com
> > 
> > and a small rusty thing which you might wish to attend to.
> 
> The binder bug is not actually a bug. When using VM_MIXEDMAP and
> vm_insert_page(), the vma takes a refcount on the page, so there is no
> use-after-free even if free_page() is invoked without removing it from
> the vma.
> 
> Adding an INVARIANT: comment to the Rust code SGTM.
> 

I think you are correct about no UAF here, but the page isn't exactly
pinned to the vma - which is what I thought you were saying when I first
read your reply.  It's sort of misplaced in another vma by an mremap().

vm_insert_page() will increment the ref count, but if the vma is
mremap()'ed with the same size vma (ie, not expanding), then move_vma()
will relocate the pte and the old vma will be closed and set the
binder's mapped = false without a change to alloc->vm_start.

Binder now thinks there is no mapping but the mapping has an address so
it can't map anything new.  You could get around it by replacing the
vma, but I don't think that leads to anything interesting.

So we still have a ref count that's okay, but now binder has an
alloc->vm_start that's stale and a mapped = false which leaves binder in
a bad state (one might say a bind).

Thanks,
Liam
