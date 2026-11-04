Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812518;
	b=ySjwhkdnHE/CYa28yUoSbg3j9Ik9Kp1v/4y/NIFlHIVEbD/55EScWCPlA1ftCPAPIfdN
	 nGPekiabNJpSHP2ojAuJ1nz7DwYgZzHiX+JsxQfEtWOFWPKpxtmtdmay74Uip1BcEm92e
	 FNTRrhLqfA5P47gQWplw+ujbJBonR77ReF2qW/Q3AggyCMLzRJE7A5A9fg2Q7Xdd+py+z
	 u21oVR268kZZq+oFElJ7oUUv4Inqx7K42O6gTw6u1txLA5dbDlcJUeov095tNIh0MGp6/
	 /ed6zjjNY3t8aJSN1RxPA2kxk0qms4rDJUIgy20ehCu+WMf5WQa46hk0dIJn6FwxKXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812518;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=SYq9+BBr0q0gADHtUh7wcOV25vq3s2GgCZsPxG2VA6Q=;
	b=WU62wsbLFGbPE3+qdME1HDvH3wqnmvMpvevFoKHY0W388CpuiWXBdJUqa97g1fO8OC8T
	 za87GaSCXItS92qFWFulPwUP3l83VslavhbGGCgKGC7vCEZZ38Dcspt2W3mCqmgOoxm8c
	 e342uZTiWeoIWjPuDFrp4NiQy7+mXXRWfut6SwKYLDGt+qwH9p1JX6QgRiHC83ANj/6EJ
	 yNv1OvhVvW1c0VjQXTi9SwH5gFJ5kPzXDR3Nn/KaZzfKgzNxRKsJMWM8bc6yS0ic136Sq
	 KHbN7cO8ye4Aiw6zM4NOsuL5xjYPe3hN1JAB9OnBkvTveZhiHUHKHkwEkG5pm844kvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h/WBm7u6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E40606A32F;
	Wed,  4 Nov 2026 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/WBm7u6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3671F00919;
	Wed,  4 Nov 2026 17:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793812517;
	bh=SYq9+BBr0q0gADHtUh7wcOV25vq3s2GgCZsPxG2VA6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h/WBm7u6jgGnIGCnazSx+mTpGGIdY44Edu9dfObP1hyHC87oXtWB0MMAm4MFUJJ/u
	 lBTy/MMP0imnbuTtYVYfUthcWkCCJps5xV7IEhakoied3Y/YAYJ2LCW19zBAqJx4pH
	 sESid7Gte1+yneVlzgi9FxomuyS5X741ccgnYFFmh/GqG+xRbGnDTzIU15SABc9zUT
	 En1QWKFCENGlbrm4Vqm2JURpdLhBKzYNmXQLpTfEcInf5v26cvGepdDB33FjMahU29
	 zYFvvfTS0M08OkXL5giLs6Lh5R2qjGs5WvxH+v452VLnqRD8w0FarnxUqHIsZr2Eln
	 lZUSab8BSMMHg==
Date: Wed, 4 Nov 2026 17:15:10 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Pranith Kumar <bobby.prani@gmail.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
	Richard Cochran <richardcochran@gmail.com>, "open list:MEMORY MANAGEMENT - CORE" <linux-mm@kvack.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:b|_)ptp(?:b|_)" <netdev@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/rmap: use release ordering for small-folio
 mapcount removal
Message-ID: <autmnQwhDvMzqY5E@gremlin>
References: <20261104013139.1341582-1-bobby.prani@gmail.com>
 <750560f3-4c5a-44fe-b72a-0611be383f32@kernel.org>
 <CAJhHMCCu8ehOU37_4UpExNO3U8YPygjnht+2S+axkxTwY8bx2w@mail.gmail.com>
 <287698ab-76dc-4aee-8e6c-db1f5d18974c@kernel.org>
 <aus4ag1KxpuBNSP1@gremlin>
 <CAJhHMCChBTH3QWBFS1Hp17zj5HepN6KFucvG_5tVdpaB4fjCYg@mail.gmail.com>
 <autkT1eNM7-oSM4F@pedro-suse.tail5790ac.ts.net>
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
In-Reply-To: <autkT1eNM7-oSM4F@pedro-suse.tail5790ac.ts.net>

On Wed, Nov 04, 2026 at 05:08:10PM +0000, Pedro Falcato wrote:
> On Wed, Nov 04, 2026 at 08:51:20AM -0800, Pranith Kumar wrote:
> > Hi Lorenzo,
> >
> > On Wed, Nov 4, 2026 at 5:55 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > >
> > > On Wed, Nov 04, 2026 at 02:37:39PM +0100, David Hildenbrand (Arm) wrote:
> > >
> > > I mean 1.54%, theoretically is even less convincing for me :)
> >
> > With reducing the strength of one barrier, I think this is a non-trivial gain.
>
> Counting cycles on an arm64 simulator for a microbenchmark is completely
> unconvincing.

Exactly.

>
> > >
> > > In any case for something touching a sensitive memory barrier operation to have
> > > a stronger argument put forward for release ordering being suitable than simply
> > > stating it's fine in the commit message and updating a comment.
> > >
> >
> > Can you please explain what information is missing? I think the commit

All of it? Your commit message simply asserts that this is true.

> > message has all the details of why release is sufficient instead of
> > full barrier.
>
> rmap is gnarly code and I'm not sure people have an appetite towards weakening
> random atomic ordering semantics for a virtual 1.54% cycles gain in some
> microbenchmark, without actually explaining why it is safe. __folio_remove_rmap()
> has (indirectly) a lot of callers which may subtly expect different semantics.

Exactly. And this patch boldly decides to CHANGE the invariant here without
evidence for a theorised perf gain.

Sorry we don't have time for this. NAK.

--
Cheers, Lorenzo
