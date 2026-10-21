Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792610383;
	b=C5JZIc2cG3uVAdbpyeXMCpIfVd9wkbRbDxiL+oC2rclHgSf8PaAaosYHqyyrStvjJYgM
	 t18s3eB+Gtu6IKHDAH9jRsTDZpRBDMqjqFsf/EMNJEYMoH4n0IDv2MfVGWZrDKygvHjzL
	 7YcW3+O6HeKUUqSiWj0CTKitElyE9GRM2RUMWGcCkscCPdwxtDf35tRZ2URc909IWB4A8
	 SdpS3/AXRUP1JRf7Ht1EFi3B+mtrAPRlPUugYi/PHZ264fQJ+f1Vjd1db49AS1J5EPtla
	 ugOutVpRqKWz0pOvZ0aCmlYYk7wnL24Hf4s8MP2QY+Gitzsi1O06q+5ti1xA8DMuenw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792610383;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WKM0XORuuhLQvH0dOGvlGgJrze/6esCqKxEQFA6bgwk=;
	b=M2EtxiYwpJwY00qtUIlIQEJocws2dMRUdBndQIefvmSPrwkDCir0ww3344pjYzNfBx3P
	 ovnd7sRqK7JS9qTqatwdWQ1BxJVyLJHzs8yTUOoHh54PFTHIDRMf+peR2jn3DsP2f0IG/
	 z3+iVVLNlLNmFA6G0MC5fdG9boQxzj0VAcWbBBfwC2S1oGw8LdYXld8qg9AwWcyzqZv/T
	 maxI9xAyoBk/miTFiqxEgj+pD3rwbICHYmNcAVA75M5tmemSoJlSncZTOLFihikapF4gw
	 CqVW3Pr3/m0yZIbpGr0I8Kpi6oCI+9jDbqSiQOhBZiqfwfvoZPrxKVW0sIZ+AHzfbAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eumAA3k4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3707A606A31B;
	Wed, 21 Oct 2026 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eumAA3k4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0185A1F000C1;
	Wed, 21 Oct 2026 19:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792610382;
	bh=WKM0XORuuhLQvH0dOGvlGgJrze/6esCqKxEQFA6bgwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eumAA3k42K6yB6RZB1WU+xt5GGoRMa4EQmog24F7MJERClHfXOFO7yv08z0jvcCmv
	 w1uGdCt3PZw3rvBVei3wJi6cCcD3YrMWXxLfyGjV51YUCT5H9CZY1WM+9FX144+H93
	 PbZXbnow1re3NMVT8taE7YypLSXNbeCdMQ9VMh/N4vIxCxnzqR+n+ANhYyXcwaR2LP
	 ErhyGeSHX0HKoX24vZ3qa4ipO1l0uT48xXwBaRaNYnFv0DT7AJJcJHK5ZmiJRcGVLJ
	 I0vWNgkubvcElxaySbtT9b0dgXpVM3xx00admRyflohfS0RgxZbaTECcufe52mCwT0
	 K/hcSks9Awr4A==
Date: Wed, 21 Oct 2026 12:19:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Harry Yoo (Meta)" <harry@kernel.org>
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
Message-ID: <20261021121941.4d8f8edf@kernel.org>
In-Reply-To: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-5-096800aa3330@kernel.org>
References: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
	<20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-5-096800aa3330@kernel.org>
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

On Wed, 21 Oct 2026 12:46:46 +0100 Harry Yoo (Meta) wrote:
> AF_UNIX sets sk->sk_allocation to GFP_KERNEL_ACCOUNT, so skbs can be
> allocated from skbuff_head_cache with __GFP_ACCOUNT. Specify
> SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
> __GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.

Could you please skip this for the first batch and resend
later to net-next?

## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

