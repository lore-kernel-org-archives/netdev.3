Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423739;
	b=GbFRlrjcviURQ+1ZunZxz4eOfhZ/fVL2HfftqvTAIVPFr3HpM77ZIDH7eC/XNHZg0HzV
	 r6MwYarkbZfzFsgIdV0xmVXvm+hI9ChXBeZ50ARF86xID8JKyfITb2A792eC6cnReJKpl
	 GUhtdZJlu6W8kg/68mt21SEMsJqNhR1PJ/aiPCZtMgcARA8ONQ1MCfhhv+468cBya1Hx3
	 9J+7mKVN04eEEmy/Vvvbs+4m+aRVXGx0BFTXXiexaDYdAy2srm8e+pnkwPUiw9dp8Mc7C
	 hJY/hxbNGE72jpO9MX+d2ATdLmVThPvtL8mwGTf8zZeW3L2zSKABAcPrYQYa1eIdxCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423739;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=e22PuywE8UrFGA/QkpEbtslqBE+35TvWuYAk7qPJM74=;
	b=cUkWvWWk82LUqVEY7nb5CSdaB/eT4NXcNbqXZIiXqKTD83im9CsEbQFMyUx06xYTZF46
	 YVOG0ElvzHZHOXRP/e3Ulj9r1OwBV0Kyh2aWCUngU/P71FROX4v0xCK+abg0M+zbXMxUy
	 uqPgbo1hr+EuM66YSjmfL+aAmVmRs3bKwuS8ZSYXDnuMKAndZkZlkf5VrwQ9MDqSu7AKL
	 tgqAXKwVY71MXCD+XvKeHwX3uFGP+f3wtjKGwjbxs+RE5hjoTBueBsQ0HJ6/mUgvQ/AZk
	 sA4Z20lNWYgJmispnoDJvKK7Rz0xVcQt3BOrpfLB5aZkxeDs1b9QZIWJYXe5Wee8y9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lx8ndOiX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BAA60A2627
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lx8ndOiX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034911F00A09;
	Wed, 11 Nov 2026 19:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794423738;
	bh=e22PuywE8UrFGA/QkpEbtslqBE+35TvWuYAk7qPJM74=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Lx8ndOiXwW006PjU1I7F91iAdxDrSqMkmJBSEd+h8AJ0WDOj+LAViCU0j1bo34ECV
	 jjbt6aHvAyzBV3E4oIFO5a4rUl/BLMz3RU/uV8zn8QtlBEXBaUYqkW5KKbsNHPWxDc
	 ncP0rFOk3aEIOVHgP0KtIZA93PqqBjK+rYBp2IM3ptu2hqfZb/pjlqn/9LO5osAJnc
	 mN6+Mg64dA9VRfa+2XFB2Kv/hZc2cWGO2/zP9Tth44KEXbcRyUJWhyqv8BWxShOzpi
	 9SFQ/v5RYbJUgvBatEDh+7VzXHn9mnU/DJyeefNm4Xmr6HEKJ4c45x6u8liNevkExw
	 7ovfCLuUxkhwA==
Subject:
 Re: [PATCH net] tcp: reject v4mapped source addresses in IPv6 SYN cookie ACKs
From: netdev-bot+sashiko@kernel.org
To: imv4bel@gmail.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 martineau@kernel.org, netdev@vger.kernel.org
Date: Wed, 11 Nov 2026 19:02:17 +0000
Message-ID: <179442373755.2199510.13127759467093413622@kernel.org>
In-Reply-To: <avFvW7nn7GIZmZ-a@v4bel>
References: <avFvW7nn7GIZmZ-a@v4bel>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch closes only the v4mapped trigger.

--

tcp: reject v4mapped source addresses in IPv6 SYN cookie ACKs

This patch makes cookie_v6_check() reject ACKs whose IPv6 source address
is v4mapped, before any child socket is created. It matches the check
already done in tcp_v6_conn_request(). Before this, a SYN cookie child
with a v4mapped peer could be found by tcp_v4_err() and end up caching an
IPv4 rtable, which ip6_xmit() then used as an rt6_info.

> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> index b581cb1ee2e8a..6c5bb4bbd349c 100644
> --- a/net/ipv6/syncookies.c
> +++ b/net/ipv6/syncookies.c
> @@ -189,6 +189,12 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
>  	    !th->ack || th->rst)
>  		goto out;
>  
> +	if (ipv6_addr_v4mapped(&ipv6_hdr(skb)->saddr)) {
> +		__IP6_INC_STATS(net, NULL, IPSTATS_MIB_INHDRERRORS);
> +		SKB_DR_SET(reason, IP_INHDR);
> +		goto out_drop;
> +	}
> +
>  	if (cookie_bpf_ok(skb)) {
>  		req = cookie_bpf_check(sk, skb);
>  	} else {

[Severity: Medium]
This closes the v4mapped case. The commit message also names the missing
IPv4 address initialization as part of the chain:

  "cookie_v6_check() initializes the IPv6 address fields of the request
  socket, but not its IPv4 address fields."

Is that still a problem for native IPv6 SYN cookie connections after this
patch? Further down in cookie_v6_check(), only the IPv6 fields are
written:

	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;

The normal SYN path sets the IPv4 fields in tcp_v6_init_req():

	ireq->ir_rmt_addr = LOOPBACK4_IPV6;
	ireq->ir_loc_addr = LOOPBACK4_IPV6;

On the cookie path, the request socket comes from a slab allocation that
is not zeroed:

cookie_tcp_check()
  cookie_tcp_reqsk_alloc()
    inet_reqsk_alloc()
      reqsk_alloc_noprof()
        kmem_cache_alloc_noprof(ops->slab, GFP_ATOMIC | __GFP_NOWARN)

Neither inet_reqsk_alloc() nor cookie_tcp_reqsk_init() sets skc_daddr or
skc_rcv_saddr. inet_csk_clone_lock() then copies those fields into the
child:

	newsk->sk_daddr = ireq->ir_rmt_addr;
	newsk->sk_rcv_saddr = ireq->ir_loc_addr;
	newinet->inet_saddr = ireq->ir_loc_addr;

Since commit a3a128f611a965 ("inet: consolidate inet_csk_clone_lock()"),
tcp_v6_syn_recv_sock() no longer writes LOOPBACK4_IPV6 into the child.
So it looks like leftover slab bytes stay in inet_daddr, inet_rcv_saddr
and inet_saddr of every AF_INET6 child created from a SYN cookie.

Both ipv6_update_options() and do_ip_setsockopt(IP_OPTIONS) branch on
that value:

	inet_sk(sk)->inet_daddr != LOOPBACK4_IPV6

Could this make icsk_ext_hdr_len and the MSS different for a SYN cookie
child than for a normally accepted IPv6 child? Could it also trigger KMSAN
uninit-value reports? The leftover bytes would also show up in the
inet_sock_set_state tracepoint and the BPF ip4 context fields.

Would it make sense to also set ir_rmt_addr and ir_loc_addr to
LOOPBACK4_IPV6 in cookie_v6_check(), as tcp_v6_init_req() does? That
would be in addition to the v4mapped rejection, not a replacement for it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/avFvW7nn7GIZmZ-a%40v4bel
