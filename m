Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800557;
	b=1HyzCR6t8rf+lrUMBvmEXWGRLG8Dyy8FqGmT0aoOanTKlGgm+7+wlFGxKkyfenTW8rpH
	 6jVagNeiM697kF2KOuHhHC75smehcUImTDM4Dw9I1BM30ovILJf3g2by2hb3iugud/g3v
	 oyNY7ULAFDLIE8kvW244Z2M/p484B8ur2asvfV4bbljMDtY/WxF/LKA26yr8kQgdXsOLA
	 X/J2KRPobDVxCHSiCAD+mmHhw2rZW8WP99Yv4ikB9+8UYueP5qDvdBHqeiTqbDCiNIlf2
	 ycZZNwFaZMdEYRrcndVZEkQYTgDu0y+gZcie1sieI10XV99o7Fc3jhy1qsu9mOr4KBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800557;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=1La6srXM8X/sIag8bKohAPdLipW0D+7qqlLp+GotLXw=;
	b=wwnnlQq6KKqwBuBw90afIktu/kkUaGe0GxKAFDZ4q+anyG6oeTtWcb8OeyRnyTe+WRzK
	 zXbsKz3hj3EWhUHYIwVk+250yGNzOjBccX7mv35OFYpOOQbTyt95WbZtf3o//WwfYt1Kc
	 Md1epJ7dKcMHRBZYytTtKkYqxkwnSbVlZRv6XDca14rG2y8VUfk/E1VenLQhhW8mw/SOJ
	 AMinW80jkwOlGeuG3lDCtb9PDWzKjbQEivyNKdHAMysHWd9x5YRQDwh4tGq9Xpor8B520
	 5aR0Rg8l9yYGGwaMJF30ug4BYhAaNMhjAhPgesdPuY/5NijwcUdAMTOlA31lzI5Dt9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fyTV59mW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F36606A326;
	Wed,  4 Nov 2026 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fyTV59mW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C6A1F00919;
	Wed,  4 Nov 2026 13:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793800556;
	bh=1La6srXM8X/sIag8bKohAPdLipW0D+7qqlLp+GotLXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fyTV59mWbSB5r4WN7LjlGdDpQLQRh7hjEPnfTdCHa6YIFWvDcWEvB06eYk88OSzsT
	 Ww0bcXPS0BYyI8PRW0YSVj6s+ZOwLablr0X8a/e4eh3KEanqY/34HFwJ+1eSxaIvH2
	 kw1wwOKjwSfk0GpaGiC9I5m+q+RWQg2VxdumiiJgqIRow5+Ym8/1CFPyNNvGkCzep7
	 fXpgSGmpuv2+8vVuparIdANfXIw4wJZ8e4wGkJHq+4lQSyedTIVx81CTGBdYowjCi9
	 P3BCuVmRI61bmD8CpcGzkotpiZtAcdjzGf5yYO6U67lPzEq1f4tTgAN3KPaSZm/JIh
	 D/4mDEJJgjyCw==
Date: Wed, 4 Nov 2026 13:55:51 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pranith Kumar <bobby.prani@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
	Richard Cochran <richardcochran@gmail.com>, "open list:MEMORY MANAGEMENT - CORE" <linux-mm@kvack.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:b|_)ptp(?:b|_)" <netdev@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/rmap: use release ordering for small-folio
 mapcount removal
Message-ID: <aus4ag1KxpuBNSP1@gremlin>
References: <20261104013139.1341582-1-bobby.prani@gmail.com>
 <750560f3-4c5a-44fe-b72a-0611be383f32@kernel.org>
 <CAJhHMCCu8ehOU37_4UpExNO3U8YPygjnht+2S+axkxTwY8bx2w@mail.gmail.com>
 <287698ab-76dc-4aee-8e6c-db1f5d18974c@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <287698ab-76dc-4aee-8e6c-db1f5d18974c@kernel.org>

On Wed, Nov 04, 2026 at 02:37:39PM +0100, David Hildenbrand (Arm) wrote:
> On 11/4/26 10:46, Pranith Kumar wrote:
> > Hi David,
> >
> > Thank you for looking at the patch.
> >
> > On Wed, Nov 4, 2026 at 1:16 AM David Hildenbrand (Arm) <david@kernel.org> wrote:
> >>
> >>
> >>> In an arm64 page map/unmap microbenchmark with 20,480 minor
> >>> faults, simulated cycles fell by 1.54%.
> >>
> >> Thanks for the patch.
> >>
> >> While I see value, I am not convinced this is the right time for this
> >> micro-optimization while we are busy with other things.
> >>
> >> This needs a better evaluation: 1.54% in a micro-benchmark without knowing the
> >> stddev isn't particularly helpful.
> >>
> >
> > This result is from a deterministic simulation, hence no stddev.
>
> Ah, I'd assume even a deterministic simulator would have some variance due to
> preemption, TLB flushes etc.
>
> But the bigger question is: which arm64 variant is simulated? I'd assume it
> might vary heavily no?

I mean 1.54%, theoretically is even less convincing for me :)

In any case for something touching a sensitive memory barrier operation to have
a stronger argument put forward for release ordering being suitable than simply
stating it's fine in the commit message and updating a comment.

--
Cheers, Lorenzo
