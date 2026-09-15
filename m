Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B53A63F2
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462878; cv=none; b=Y2epbVHAEiry8JX88V+mZ9KGSz63WcpYpkNXwQnN0ECFQITx1N8jpyTu9wSzHv/qD5wy1QFZP4ye49XXZp8FsDEQyZb77y3Wl4Y+34EQJkRhJInbbdDAT8NHloYQK+YzL1b7erZlNfROBB2hlNsqbqwT0eJSFmR9TSX2QczxRjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462878; c=relaxed/simple;
	bh=igEQLWQbr5DP6EmchFrCUUB2oe4iZRFEQe3Ayfl9VxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSeynVLPLnvdjkVZ1rJhSm1p7qx5jZDC/U3IUsOCsQnsMX5iLE8ILV87hWJVCW0ZDJVj2/csXuhJiIZPAWgDhdy+sXJE/1KhwJiF8NWc6i/DM11joSdDj7sqO7TRkLhXdr8mcRLsAPu4Vj35kLbst9rjQ4U3vawYBxrHrBuqTqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZqoowt4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZqoowt4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C101F000FF;
	Tue, 15 Sep 2026 09:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789462877;
	bh=UALsZXI42bHGe6vxVk1CS0+03P/7WR8iiUuFJSK/haQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BZqoowt4sTyU667o8aUdh0cS52gWokGzqTIM4GpTWZqbPx5Jaknnbl11zknl7DSsE
	 ZmL8teTTbhd2BDw717rQ2mOP3NWwMb6R5QaSWBYcrGyW9KhN0PM0Fs52/AfssP2WWZ
	 SwvxYGMOkgsPvB1cfNyy0tfqIKv2qvfrmnEgNSE3cD27s+/PkcEPCJhe8i6CSi9X17
	 w9RKGLcW2P5Z5ul5+V/vedJUEFYCPvIeSPvy54M7zwrrL4jQtS0/EetbxvgI+K+Qyv
	 kFluGyrfQ2M+507tfMVw8nNblkN3DHhXLbC1VPNYRiSfWV7H5bYv2zfCHUxw480WFN
	 XGtH9lCsy8czg==
Date: Tue, 15 Sep 2026 10:01:11 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net] tcp: do not let tcp_rmem be set below 4096
Message-ID: <20260915090111.GC314999@horms.kernel.org>
References: <20260912144848.3448026-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912144848.3448026-1-edumazet@google.com>

On Sat, Sep 12, 2026 at 02:48:48PM +0000, Eric Dumazet wrote:
> We can hit a division by zero crash in tcp_rcvbuf_grow()
> and tcp_rcv_space_adjust():
> 
> divide error: 0000 [#1] PREEMPT SMP
> RIP: 0010:tcp_rcvbuf_grow+0x187/0x450 net/ipv4/tcp_input.c:939
> ...
> grow = div_u64(((u64)rcvwin << 1) * (newval - oldval), oldval);
> 
> The division uses oldval = tp->rcvq_space.space as divisor.
> When tp->rcvq_space.space is zero, this leads to a divide-by-zero
> exception.
> 
> tp->rcvq_space.space is initialized in tcp_init_buffer_space():
>     tp->rcvq_space.space = min3(tp->rcv_ssthresh, tp->rcv_wnd,
>                                 (u32)TCP_INIT_CWND * tp->advmss);
> 
> If tcp_rmem[1] is configured to very small values (such as 1),
> sk->sk_rcvbuf is initialized to 1. Then tcp_full_space(sk), which
> computes (sk->sk_rcvbuf * scaling_ratio) >> 8, truncates to 0.
> This sets tp->window_clamp = 0, tp->rcv_ssthresh = 0, and
> tp->rcvq_space.space = 0. Later, when data arrives and DRS is invoked,
> tcp_rcvbuf_grow() divides by oldval == 0.
> 
> Back in 2015, commit b1cb59cf2efe ("net: sysctl_net_core: check SNDBUF
> and RCVBUF for min length") ensured that net.core.rmem_default and
> net.core.rmem_max cannot be set below SOCK_MIN_RCVBUF. Similarly,
> SO_RCVBUF setsockopt enforces max_t(int, val * 2, SOCK_MIN_RCVBUF).
> 
> However, net.ipv4.tcp_rmem still had .extra1 = SYSCTL_ONE, allowing
> arbitrarily small values.
> 
> Because SOCK_MIN_RCVBUF depends on sizeof(struct sk_buff) and cacheline
> alignment, its value varies across architectures and configuration options.
> Using a fixed constant of 4096 ensures a predictable, architecture-
> independent lower bound that is safely above SOCK_MIN_RCVBUF everywhere
> and matches the documented 4K default.
> 
> Fix this by setting tcp_rmem.extra1 to 4096 and updating the documentation.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

