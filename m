Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8D390231
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936300; cv=none; b=YTKtM1mxHvp00wHMmuGL4UBFTAjo+WSz3UhxHnYEEGZwb8waWFbySipaAFmCXHIi6DJZ0opnIM8b97adLd7Lb7ZNqgYKhTHvQfxZEug/2JID18XdaSs/guaKxezYX+T+SIyBG5MYanIYV0yJ96nWfRzUoIHEO3gyja3v+yjgT1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936300; c=relaxed/simple;
	bh=Tc+kyTrwgV5fVxF+TVTMzzRV8pS+LC2+lWm4rGw29us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKnvxcXfTe6YxA+i0p/G6dtWBj0ZWaO9eI7akduUNbUMITFpm/uVc64038cNaHVQ/352zRQkx6nNtilF8GtXLVE8w9egvTPlpHLLssZl99NjYwFzEBeXGBs7euSp939uX+25d7hKJX5dizxz/AOeLQ/IA6/EBmoNWuz3tELvVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6MOYS4P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6MOYS4P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D421F000E9;
	Fri, 28 Aug 2026 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787936293;
	bh=lgjw3dPxE1FCMUtveMSarz0lLZzABoWwz9/pVEQSxRk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L6MOYS4PrY40stkxVhZz9FVhpuCuGHsHy66i+ZNO4Dx4C+Ewfxri71fWhnmJX0EeF
	 zh+aGtgSb6ROl29l64zduBn1USxkslGQuXYcOzrEdcEtsfID+DQxc5LH/9dFGp7jHc
	 DF4sfbtsgJiAt2wi3SF6Z/45l13m9WJdI9vdhho33mMuJqDx/liUFGiZekN8GL9Opj
	 fhBP7w1bDjPPGEPktBR1rAOT511wGq0pqhiRLkkI+uCkEhkq6utGEm0b3ApJKVvz7u
	 2scHwZO3kU+UdKSB4dFCyQaX5OHt2i7SgEUfGToaB0g2xC2av2gpKrHge3DYRtfPjQ
	 u7S0bjFfPG9ig==
Message-ID: <8dabbae4-514b-4fa1-8fd5-f80dba052237@kernel.org>
Date: Fri, 28 Aug 2026 18:58:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 net] tcp: use GFP_ATOMIC in tcp_send_active_reset()
Content-Language: fr
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260827095936.551524-1-edumazet@google.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260827095936.551524-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

On 27/08/2026 11:59, Eric Dumazet wrote:
> tcp_send_active_reset() can be called from contexts where gfp_any()
> (in tcp_disconnect()) or sk->sk_allocation (in __tcp_close() and
> mptcp_do_fastclose()) evaluates to GFP_KERNEL, which includes
> __GFP_FS and __GFP_DIRECT_RECLAIM.
> 
> Allocating with GFP_KERNEL while holding the socket lock (sk_lock) creates
> a lockdep dependency:
>   sk_lock -> fs_reclaim
> 
> This causes false-positive lockdep circular locking warnings with storage
> subsystems (such as nvme-tcp) that acquire socket locks in block I/O paths
> and invoke tcp_disconnect() or close sockets upon teardown:
>   set->srcu -> sk_lock -> fs_reclaim -> elevator_lock -> set->srcu
> 
> Active resets are small RST packet headers that should never
> enter direct reclaim or block while holding socket locks.
> 
> Use sk_gfp_mask(sk, GFP_ATOMIC | __GFP_NOWARN) inside tcp_send_active_reset()
> and remove its priority argument. This preserves __GFP_MEMALLOC access
> for SOCK_MEMALLOC sockets, suppresses allocation failure warnings,
> and aligns with other control packet allocations (e.g. tcp_send_fin(),
> __tcp_send_ack(), tcp_xmit_probe_skb()).

Thank you for the modification! For the MPTCP part:

Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

