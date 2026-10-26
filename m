Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023663;
	b=M+cjLf5Dsu5KdfGADKq3S/rm92LHtqmr/fupMPjZptkByAObCrNVabwIXbuoUjtYWgkj
	 6kkcEWndgp7e+Ya4++O6GrKoZneyzTR2axvt5YDVQz709i75BxJEtVXow5RRjc1B997fS
	 FeeKKusiaOhdEhcCxesCOikAz1M5+Ee1nESujiGVnGwtEEh1akqLL6G7WgegVhOC68RmQ
	 veK1EpkSowNER+D70mjRAp4H+J0Rq18WY9PtidU3S+BwDuoC514C17hzFH/q96bVaCp01
	 8XRlhatPsH5ZV2Gkli8SNFAxervCTZ9fvQ2Ry6BWZXAECsIaoJ4MNF2JA8+8cIpXw0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023663;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=XakBI9gtX78sZAtOezqM1zuZ81mvr8zjp5zgGUEv5HU=;
	b=1pjm87dwOZeOWhllJXQzE9vh2G3QttK4UW5QHrSmKVAxg/x7dnQcF4qfn4wgwIE4yvOQ
	 FChoGzn4I7ZootSB1KT0kMcqfBeVC59LFsglAE1EmvDddypGwqkL6v3w5pN9SopLB0NYX
	 xugY0BiJniueR/bWVs/8j7ROkDJxPLOwTQDT2hpVmyMb56haCXyPiecjAJWHNfkDQms36
	 c3gwWDrBzOGmx4wVOqD+Cy7CfxTtW0nH/Rb2NCoYxkerRrlWkheVDy0gtYFoSPjJeOToP
	 0fJhXdysiv49VpECyye/TkOz8TpMMZyW8sle/+XlMGCc8BRwJSi2MWGu+xt5sTi5N2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxCaJxpS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE625606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxCaJxpS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4655D1F01829;
	Mon, 26 Oct 2026 14:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793023662;
	bh=XakBI9gtX78sZAtOezqM1zuZ81mvr8zjp5zgGUEv5HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WxCaJxpS4RT5Rt6eFzT7+wZgOe/GRPAmjH3AqsGfiakObwHg1VY1JJNi0pIrPnik7
	 LWYUmo8hc6UufQZ6WHKxTq9xYwbctTZ+0V8AZm/Z02qLsvfpJt7QpBAZgJOCKzRq8b
	 sO7fSzYxI/xVJdBACOmvAHKmydVSAMW8sUJZZm+pSIFUmUMVDQnzgfjRaYB7HOKPfB
	 8K/X3fm9h1Ezl7Pbgv0hIS5Bah6UFMYHfpQFCQK7NfXthDC1gzOTcq7h57iFe/sWML
	 xIx3xXObFoyp8zxwmf0IcVx7xyYYpYRotsMlMTcylm+ek7EU4LeQjkZ4lLZHCkyk9l
	 9Az6ytO70tYAw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4787AF4006B;
	Mon, 26 Oct 2026 10:07:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 26 Oct 2026 10:07:41 -0400
X-ME-Sender: <xms:rV7falXFc8rgY0kZiZWLQpp1duK7t-4d9jeFRjqXvwSfhMHN10ofSA>
    <xme:rV7fasECXzzTPU7FmoGw7wHH_lOJhNS2cuSzui5LWFp97epFbQfWb0yhOIIzvShvW
    J2W6gz3ZRtykHe8PTuZj89CZkbws1-vFkPZfgQROlgNwVXF-uwY1A>
X-ME-Received: <xmr:rV7favacw5EJcxahdH_aor83_I4OEGEoUXOjpNBI5g89xHlgNZWIDn8bDq-hDy_XMmb09fOiJ0NxRXTDf1HPXYUcXD4Uapm6>
X-ME-Proxy-Cause: dmFkZTGHPTZoVgbYo32XJYjko3kEymooXPsi2xL+ta6zn/3CUgwvCNza6QO5ml4d3WEJSX
    B81f6OQ8BX84Th8MBukku5MrddiFNHjISGbII1oow9cL+KR1qJtAn3Rfwc6udslhg5fBBp
    NAkuxktdRq/ThSyoW/6sYm66Cx/DQ3w7QOCjEdJxbQd42O8vjWlPjxpr3/wSVNEQejPqjv
    aKoaOW4wQlRbkOCDqqLh7kwEaiRAbG45JUeMUE3BPjDvbzO33lTRXHrwK3qQ7jmjepaNUU
    Tg+7i3Ffl+6pV5qh9j3V7RIBtcc25Tt+4S+gMFFdS81OnFT7XartKSIMtVN4JSyO6qSObr
    T7UrxbOlATSwsvTh0zS0YBns1MjUgFDrqQpjSBCY3phjoAbdeiKt5RDc58KbUkNLJigsSB
    UavNU12IDc/Vl0iH5helDCcurXjtOc5wNNv/gfdFf0MceCdCqkyvz+gRgYBag/4r7xHLiJ
    PJclNhsn5D1ldF8pMVmWGN2xcD4teWGa7DqqVXl7gOpClUjLo8iBX3W+18hJrPB2LqZwTI
    qqNKh4T/NYOyVIsZzeG1C+GtoSzCyag57mSEBGmaRHIQq5+OpLkKKLz90eMd6aBAxmR++6
    5qqp5iTOyk90EdfAprSHPCRTO619iQxYKKz1RB2W2iPvLV4bqJaZC3KrU5mg
X-ME-Proxy: <xmx:rV7farEkwePmR4sfQRVoe5Hm-SU5qBwawyb2C790iv0A5eWl3zj9sw>
    <xmx:rV7fal2ITUuwZfrcHWTVWXb6FsV6O_9_XTUUpORo0oB2y_6W9Aag1A>
    <xmx:rV7favyQCLK6X5mq_0aCQY5GHIagP8RdKxmzxQLtm-UwUAQkSpfn1Q>
    <xmx:rV7fauhwr3eY2MdtPVEq4FUUJfYmy68tIIWhUT3azTJhfSbtPkd6nQ>
    <xmx:rV7fakPKgwsOlzoHYmI3hM607W9wsrCo-oIKB5fXC-woliI2ku0BskAO>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 10:07:40 -0400 (EDT)
Date: Mon, 26 Oct 2026 07:07:39 -0700
From: Boqun Feng <boqun@kernel.org>
To: Vlad Poenaru <vlad.wing@gmail.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Davide Caratti <dcaratti@redhat.com>,
	Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] lockdep: Keep dynamic key hash nodes in
 lockdep-owned storage
Message-ID: <at9eq_3YUIL1ACEK@tardis.local>
References: <ef57e0ab-f0b4-46d6-a2f8-f6c97fec8d8e@acm.org>
 <20261023121946.2260882-1-vlad.wing@gmail.com>
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
In-Reply-To: <20261023121946.2260882-1-vlad.wing@gmail.com>

On Fri, Oct 23, 2026 at 05:19:46AM -0700, Vlad Poenaru wrote:
> On 10/21/26 8:01 PM, Bart Van Assche wrote:
> > This patch introduces a new hard upper limit on the number of dynamic
> > lockdep keys. That's unfortunate but I assume it's not possible to
> > eliminate this hard upper bound if the key storage is owned by
> > lockdep?
> 
> It isn't inherent; it comes from preallocating the nodes the way lockdep
> does for its other tables. Two ways to lift it:
> 
> 1. Fall back to the embedded node when the pool is full. Keys
>    registered after that are linked through their own hash_entry, as
>    today, and only those wait for a grace period when they are
>    unregistered. The key stays at 16 bytes and there is a second lookup
>    path, but running out becomes a slowdown instead of lockdep turning
>    itself off.
> 

This gives me feeling that we did something for nothing, because in a
system where there are a plenty of dynamic keys, we back to the current
status after we introduce another hashlist.

> 2. Grow the pool in chunks allocated outside the graph lock in
>    lockdep_register_key(). That removes the bound without a fallback,
>    but it is the allocation Boqun preferred to avoid.
> 
> For what it's worth, keys whose locks are ever taken already count
> against MAX_LOCKDEP_KEYS (8K classes), and the default pool is 16K, so
> what the cap adds is a limit on keys that never get a class.
> 

Yeah, I think if everyone call lockdep_init_map_type() right after
lockdep_register_key(), MAX_LOCKDEP_KEYS will be reached to the limit
before MAX_LOCKDEP_DYNAMIC_KEYS. So technically it's not a new
limitation. Honestly you can just make MAX_LOCKDEP_DYNAMIC_KEYS = 2 *
MAX_LOCKDEP_KEYS (i.e. without introducing a Kconfig), "2 *" is needed
because a key can be in-between lockdep_register_key() and
lockdep_init_map_type() and pending_free can be delayed, so "2 *"
provides a buffer for when active key numbers > class numbers.

It might be worth checking whether a lockdep_register_key() is always
followed by a some sort of lockdep_init_map_type() in the kernel code
base.

Regards,
Boqun


> Boqun, would you prefer (1), so that the cap can never turn lockdep off?
> 
> Thanks,
> Vlad
