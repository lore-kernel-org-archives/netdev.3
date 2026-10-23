Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778212;
	b=TqQTAUzPIsCd0qNuq1bZ1Dfnh0fLpO4yZmwUMnDH3MjfMiT7YkR450XYpDlYekRc4H+d
	 DvFBE+pVDukou+zdXsxr/GDH7CpA5OkA2osy/AZHJduspIp9OeKWQTJeY+dm9Da3M/QEd
	 xE+Kng4BajdL6AZ5DjB+Mt6md8lKHOnsqSXsXqu7/bHq1HuHszqBGQFQTWb4OAJCTrYwr
	 HMUqOYta1oDrwEVSuVpo8KoMJxzGy3OGJ9hdth/mGwm7MIEdDmCP7uPzfQcwYoWD4pDWJ
	 Hn3693TnqHnoh/CAItv6d6OUW2T3NElgmWHX9lH6xwsfJu45XsTNx4ZOA2f0KvE+YYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778212;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6dF6ilgg1hCkDWkXW/uBaYSBlAJ46T4Q2XsH6HK8HOg=;
	b=XDSe+QnwNShIwBoPNzstLi+Psa3cACw8hWJeIceBwIMW+5Q4ofOFANtO6pVHFNJhFWCg
	 28gLbu1cnVg7ulVvUd2FqMaYCQXBwpGWk850SxSqHOmSnS5izEQsb2UVrI4I9yi/qqPf7
	 Fpparvx7bFnn0KiAkI8PLmTsHlAoLosywGMUkyJjzGKVLToS1hpM/CjToaMtdzRD3XDJZ
	 riqhN4CppCqMq5rd9fsEZBBgicC/o3eZxyUqh5qQtX0j6ta1vutPMMjhZi3tnTqV8RWvn
	 Ggf3g1af4pJN1zTNJgpSLqevgTDQgZSLAHd8vshCs34adFlXypUOsgGeM3EehUsiOUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSS0Ck+N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389C160A3838;
	Fri, 23 Oct 2026 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSS0Ck+N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC88E1F01825;
	Fri, 23 Oct 2026 17:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778211;
	bh=6dF6ilgg1hCkDWkXW/uBaYSBlAJ46T4Q2XsH6HK8HOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cSS0Ck+NSrHUjM87ec4oK+tVdxn6iGBvpBVeHnRpI22pz+cl9kv1k0ewBZ6D1dP+H
	 bVCrhcxC+JX6TIeI103IOMyfzAmdk506bzOeqKt/MOMquKKvT1H3qIU73fAK3GAQD3
	 UQlqk7gxESl8jGzFOcBtz2W413JkJo6jZRh/xmnMPIYxFkrcqf1glg89nY6LY2l/0X
	 aJ/9uKUiEryCHOLmtUz1ro8l08+ntqMmWItaBiiLJxqhRJGDs9MBDrmv54p8TOFGhD
	 QyQb0Jsgts77moGbNmbU+g5dVigMmtm4cqWEQPd5/mN5PVJ1CnseuSeozwbX/TfRV1
	 lwu628+jAAQiw==
Date: Fri, 23 Oct 2026 10:56:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Harry Yoo <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin
 <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Muchun Song
 <muchun.song@linux.dev>, Hao Ge <hao.ge@linux.dev>, Pedro Falcato
 <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, Willem de
 Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 netdev@vger.kernel.org
Subject: Re: [PATCH slab/for-next 05/14] net: skbuff: specify
 SLAB_MAY_ACCOUNT for skbuff_head_cache
Message-ID: <20261023105650.393c8fc8@kernel.org>
In-Reply-To: <atoHqLrf70QSkn8F@thinkstation>
References: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
	<20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-5-096800aa3330@kernel.org>
	<20261021121941.4d8f8edf@kernel.org>
	<atoHqLrf70QSkn8F@thinkstation>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 14:43:42 +0100 Harry Yoo wrote:
> On Wed, Oct 21, 2026 at 12:19:41PM -0700, Jakub Kicinski wrote:
> > On Wed, 21 Oct 2026 12:46:46 +0100 Harry Yoo (Meta) wrote:  
> > > AF_UNIX sets sk->sk_allocation to GFP_KERNEL_ACCOUNT, so skbs can be
> > > allocated from skbuff_head_cache with __GFP_ACCOUNT. Specify
> > > SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
> > > __GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.  
> > 
> > Could you please skip this for the first batch and resend
> > later to net-next?  
> 
> Apologies. Wasn't keen to the net-next development process.
> 
> I can resubmit later, but hmm, actually, do you mind if we let it go
> through slab/for-next with Acked-by: from networking folks?
> 
> It's only few lines of change and it'll create a lot of dependency for
> pull requests if each patch goes through each subsystem's tree...

Think I misread the cover letter.

Acked-by: Jakub Kicinski <kuba@kernel.org>
