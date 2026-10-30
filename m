Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399479;
	b=sJu+pfI7HaenSoyRKl6zqVwapgk4MQuNRgfczkSiRHaQniIX6F6EcKCHcYaSuodgbKXS
	 yjrE8UOp0pjdCaBk1hOCFSPFev3XQEiC6HGs2l1Rs7neMAu6Lvb+MFdFzS46NG3UloyzW
	 OXTGdPFRIQ+9RNCFYeMbCRHjQsB3wtdK4EjN3A2Pl3p+q0l+rk6Hnbt9DWbteWg7do81w
	 Z9N/VpU4OgO5wD7oFYQeaq5X+9FCf2PGXC/B6iBmaQdHLigCwzYQbOWjWKjmgKethEG3y
	 yAa7mkyBnupUfBSdvdBmdSjCWy84hQ0+4gBH1GA4d2ZEwEw7HjF1Kctf19xk+zjN2lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399479;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=u4i08XfvjxZQq2WmcsQfove9xezxcApRnsZ13Qb1Yug=;
	b=5tJHT7JkPn9muuykTLK4qSPrHasfqZioYsrMnppj5RWbRvxow1i4u6kA29QVYLCxdXkZ
	 uRQu4K6vbfhwzJMcxa6i1SMnaIJev8x3tyLI3nbKGYFM5PlMVQD9Cwm0lJ6OPNIRskxT9
	 aBYHMyvlFZjpO3NXnL/sptIy/HRc1lUBcCE6ItXCr9pYhxTLurh28weSqa+Ij0wZsTDzE
	 DCGJaIkCLrIBEjFL1VfKyXDqJcB/gdLnXfgXK2ictKxmpMSeenqj37zcsttji+rqx1334
	 BhtzMZpzT7Y6QAJXp/BW7mquRvvvlQlLLGqBZf9iOx25K/bfKC2aRDoXx0/depD5ZkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UiV/8+Xb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F531606A31A;
	Fri, 30 Oct 2026 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UiV/8+Xb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013F21F000C1;
	Fri, 30 Oct 2026 22:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793399479;
	bh=u4i08XfvjxZQq2WmcsQfove9xezxcApRnsZ13Qb1Yug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UiV/8+Xbv7p5vT/2rYxF8yVt931uVfP6+H31IPpPgC/qb3i1plcoJu3zKxr7/kvja
	 Ndu66o46Epb0UM4ILJIeHwraRT+n4Nj8KozXCWToAXYGXR6GfKsZEvd1z6OOfsCUZK
	 9/gnE2jMgN+zGRVPtV7TFtSsZ+vMtogS4yFBQbfA1T/La5wb89LWySWec3JvHLpU7Q
	 0gpKMvn97pf2VRGVqk89JuvX/8VU2EtBbCBr8wqZyha7a3FcWsdmyM6wSn5+HlVN6x
	 zDT9jEYDSk4SKg9tJL29Sr4jPR8eG0ey1zYdmH8C5NAnv8zLHjmrQCHJ+DYvdhFMDM
	 l2cIA7V2Sm3GA==
Date: Fri, 30 Oct 2026 15:31:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shubhang <sh@gentwo.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@toke.dk>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Simon Horman <horms@kernel.org>, Jonas
 =?UTF-8?B?S8O2cHBlbGVy?= <j.koeppeler@tu-berlin.de>, Shubhang Kaushik
 <shubhang@os.amperecomputing.com>, "Christoph Lameter (Ampere)"
 <cl@gentwo.org>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, cake@lists.bufferbloat.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/sched: sch_cake: skip redundant cake_mq rate
 updates
Message-ID: <20261030153118.1d9f255b@kernel.org>
In-Reply-To: <bc677053-f438-fda5-defc-a53532262779@gentwo.org>
References: <20261026-net_sched_sch_cake-v2-1-cb1d4e6ed990@gentwo.org>
	<bb202893-9fd5-4dad-ad69-9f86dfd91cc3@redhat.com>
	<bc677053-f438-fda5-defc-a53532262779@gentwo.org>
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

On Thu, 29 Oct 2026 14:45:19 -0700 (PDT) Shubhang wrote:
> I repeated the test with whole-host CPU accounting on this 80-core system 
> and could not measure a reliable aggregate CPU-use difference; throughput 
> was unchanged. The benefit is visible in focused cake_configure_rates() 
> trace, but I agree this is more appropriate for net-next.

In which case you'll need to repost once
https://netdev.bots.linux.dev/net-next.html
says net-next is open. Make sure to remove the Fixes tag.
