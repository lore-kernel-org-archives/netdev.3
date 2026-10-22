Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676624;
	b=cXAcgHTfRiheUw0ukrnhIIQOy1sI0W67zRmq3Ukx9UDXtCg4HDgSaa/SlYe1SrXAfUE7
	 ghI8vhsLywBMq6Tho6jmIAatyxOfRvZ06a/EfQj2bj3AURw1iia60DCJ72ZoSiKt6Dqq8
	 rBPTZqFdefHWOy95AxnAKr3bCRXP0Aa4B9vxleEj9XVC2j8XXK+icZDt0zqqBkaEErDau
	 MaLCN4hL1hMrWNqGgnWwkOXa+nff3hofLWzfZVpgwm61HwDISpCx5oqy6YDAc2yVFE7KX
	 3S+cFKyQuXpZZAUQYh4dpv8s5pO2taNOX+66DevHbngiwp/aXfSPpKnLYu385ygoPWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676624;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JfIOramtLWCfF2fj5VyatXzHdLxQiImQY8A2BeyheHw=;
	b=mhpG+h5AUSARo8mPgqD3al7UKGpywMP+S2AQBAHOULBh9uUKadUka75eGTWV5ycTrKh/
	 /c5OI9jHcMK1ROO1pI4/O5jaN8x5ZtoI1duDwSD/qUq9ut1VenCQ4w/Vf/J+KhXh1k1tZ
	 rXBzDEwWf8WJGJjgZmkRsM//IWjwxtxj4uM+38sSmO8iKgh9/mwuyfelaSZ++oVOO3cDG
	 ROmSlqQrFFgGZmyspfGdkt+7o/iQAjThiJ/QgzGV3Xk5FxjoNegbRaKa4qs/SpWrGD4K/
	 ciE8efCk2xJ8W6BlpUCSRHfXCDXwINuu8PxCDAyaRywABc5XLUJwz2dvHfXhX509LUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpkohZ1h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A11860A2631;
	Thu, 22 Oct 2026 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpkohZ1h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCBE1F000C1;
	Thu, 22 Oct 2026 13:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792676623;
	bh=JfIOramtLWCfF2fj5VyatXzHdLxQiImQY8A2BeyheHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZpkohZ1hNfp06ULQCWHIWTKxOV83W2+3xIQY1UqscDgT5MRTuhu1eFEeL8vRIaEFn
	 nosXBi8CF/TArGD8eh/Hs2tPaXOIQFYLQsmGzi214WeTI7DC+/L3m+Aodxdcd8kfru
	 yeWaSmesq4At99wK4HPA/poSxHJVwqtTGaxD7hiNj/9u2PoSIYipWwI7baxjKrEiyu
	 GfAo2oslWyMHRx1a83s4U2oMqZx1mn1KnP1wwMK70j89m/i9ILbcIWQQfwgqSpv0pq
	 UeI96x2EnbKp4Fo3HOc53l3fPmgxMK67NikaYIq8VSIPS5seS9as9HSCy2pzIgL39Z
	 Awkb9/8hyWz6g==
Date: Thu, 22 Oct 2026 14:43:42 +0100
From: Harry Yoo <harry@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, Hao Ge <hao.ge@linux.dev>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Subject: Re: [PATCH slab/for-next 05/14] net: skbuff: specify
 SLAB_MAY_ACCOUNT for skbuff_head_cache
Message-ID: <atoHqLrf70QSkn8F@thinkstation>
References: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
 <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-5-096800aa3330@kernel.org>
 <20261021121941.4d8f8edf@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021121941.4d8f8edf@kernel.org>

Hi Jakub,

On Wed, Oct 21, 2026 at 12:19:41PM -0700, Jakub Kicinski wrote:
> On Wed, 21 Oct 2026 12:46:46 +0100 Harry Yoo (Meta) wrote:
> > AF_UNIX sets sk->sk_allocation to GFP_KERNEL_ACCOUNT, so skbs can be
> > allocated from skbuff_head_cache with __GFP_ACCOUNT. Specify
> > SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
> > __GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.
> 
> Could you please skip this for the first batch and resend
> later to net-next?

Apologies. Wasn't keen to the net-next development process.

I can resubmit later, but hmm, actually, do you mind if we let it go
through slab/for-next with Acked-by: from networking folks?

It's only few lines of change and it'll create a lot of dependency for
pull requests if each patch goes through each subsystem's tree...

Thanks!

-- 
Cheers,
Harry / Hyeonggon
