Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432847ACF4
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158606; cv=none; b=UCsjoIj0aF+ssZ8Zdtr2bWy0wNOj4hxQebp1o7HW15WIfrQS6ZSGcEUHEZncRRP2qnKK5oTU84wOXVJgCZjMXBxH8grp83JZptP2X12+Y/kqSkrDjF9cN1CqmpVbV6BhqlZL2EwFXnSSuYUjlWG+bQf6xSUTXS4cyAgAsMkI8Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158606; c=relaxed/simple;
	bh=5x4wS/2WbqzdRgu0bqzQ/bOx8qfLhh2xg9K86s+jIkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJ46T4iK3W1atJK53nmc+yFDdUjq9nKCKAY20U4S2IbMJYi7cT1LeS0PW/X+nZ28Yfw+jg58d6UNyW3nG7SuJLJgCdIIVcyz1xCbl4AEktIdmjwpDGSXwl8f0x2sRFxJSdjKt8jmWm1ibo6yytv+Qg/Ci8W1qFGOvUhn3brnark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERV0CdLq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERV0CdLq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3521F000E9;
	Wed, 19 Aug 2026 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787158605;
	bh=qHdFN2y41D7UXWts2KuvbWh6creh2s0UAlWzeqvwFNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ERV0CdLqFcYcD/YS0U44XIx05541ssucOV6QClUPGPJHrjHMamfVoIU3J7mYv6smL
	 m/wNLShdpj9DcOHpwR4tF61R8X7B0hVelQh3coQIThS07vGGe+Dk4iXVJCPsaw6oDf
	 Tr6OGebhuVKDZBcx0YM7PQPnk3+pbb9L5WeoHD83rgoJlwY4KOjpPBltRnrxol59l4
	 VlTtY0/jOYytV8IyvSnF191t37OqHMufhRK/363sCNzNdHCjLIJ1v/hmEasukCasGL
	 4UKqromeXZuT4qyD+Im59+Gu0l6gzxkHWkOuR5On7D2f0Z+S5M0gt5GQ5qj8zmscH2
	 byMLXk0ZPdmOw==
Date: Wed, 19 Aug 2026 17:56:40 +0100
From: Simon Horman <horms@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, 0x7f454c46@gmail.com, fruggeri@arista.com,
	noureddine@arista.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net/tcp-ao: fix use-after-free of current_key on
 reconnect to another peer
Message-ID: <20260819165640.GW265046@horms.kernel.org>
References: <aoIriv3pHDgII2YR@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoIriv3pHDgII2YR@v4bel>

On Mon, Aug 17, 2026 at 06:28:42AM +0900, Hyunwoo Kim wrote:
> tcp_inbound_ao_hash() is called before bh_lock_sock_nested() is taken,
> with only rcu_read_lock() held. On the fast path for established
> sockets, if the rnext_keyid sent by the peer differs from
> current_key->sndid, the key the peer asked for is looked up and stored
> in current_key. The lookup is inside the RCU read side, but current_key
> outlives it.
> 
> When the socket is disconnected and connect() is called again for
> another peer, tcp_ao_connect_init() unlinks every key that does not
> match the new peer and frees it with call_rcu(). If current_key points
> at such a key, it is cleared to NULL.
> 
> The fast path reads sk_state only once on entry, so a softirq that got
> into it while the socket was still established can update current_key
> after that loop has already run. The update is inside the RCU read side,
> so it comes before the call_rcu() callback, and once the callback frees
> the key, current_key is left pointing at freed memory.
> 
> The next transmission picks that pointer up in tcp_get_current_key().
> tcp_ao_transmit_skb() then reads the traffic key from the freed object,
> which is the use-after-free.
> 
> Wait for one grace period before unlinking, and only if a key is going
> to be removed. By the time tcp_connect() runs the socket is already in
> TCP_SYN_SENT, and TCP_AO_ESTABLISHED does not contain TCPF_SYN_SENT, so
> a softirq entering after the wait cannot reach the fast path, and the
> ones already in it have finished. The existing NULL handling in the loop
> is then enough.
> 
> Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

I do have some concern about potential performance impact of using
synchronize_rcu(). But on the balance I agree that this is a good
bug-fix patch.

Reviewed-by: Simon Horman <horms@kernel.org>
