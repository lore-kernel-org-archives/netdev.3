Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793289950;
	b=JqNbqAcRhMqiyPA2yR+rr3WDO4gHuaEDPqhIcYSCukNJ4IG/DEe93rQuL6PRl8eBdrFM
	 kx1kdGQJxzTEp0jAWPb91RO19IV+IP43kSmWcdLaifQxL5wvafpJWEHiUepe4cl/g3V1h
	 u/m5PUPSkqm1VdYv7QrChc+43xDQNaVYTKuYJ0+XCHrAsfjrONJzM4zp1sbmWNpZQh+B4
	 ElBqe8QomRpnHGDiExaqWZBI+dJ964z85kBF3aZQOVZXYFT4tSGktvDxApD1XmwcZjSPl
	 nT5wo0ViYglwklgVSuAJJ/xvORvUQVWEhnKWIyEcLMNj8Lu/ldExWX3i9jm69InopoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289950;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aEjyC6JaZB+jkSH2kxxxCeATB3E82l9u+iXW3DqdTrs=;
	b=pr+dauTEVanD/fdSXiasx4o5Wz6ZWCbHvsSxILP5Yj52ufRV+dJZ1+v9HZ9yQ0F7kGwi
	 1KdSgG9faFNsK1FYyjt+n9fOi6KPqk5KdU+o1YdDL8yWPtDcws82QEf4sX8rdwgDVfWAf
	 Xu4avLQCQRO18gZSbj6Y+altnG6g5ccZtTDRKQM9AdeqIqoDt4jhGHySltEdD0vZOP7kT
	 aH68Wv3z0wvRFrwDLbKcDsWEVOjPlHv8gLybNVGeghbiRKiDAbm3Q6I9JYUT15Qwm9Gjp
	 KsHFz+S61NsdrSiaW10gzEjapIO5ic4q9KSm9NrFtZ/tLKzEiIPj9+2twRs8Q6hW+0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItUeNj7m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D8A606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItUeNj7m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309361F01816;
	Thu, 29 Oct 2026 16:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793289949;
	bh=aEjyC6JaZB+jkSH2kxxxCeATB3E82l9u+iXW3DqdTrs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ItUeNj7mpjrOYCKLrtMg7FrKC4IRZ9PWhLR8DBWeFmyBHKXvu0Tb4lamYUxo8drlo
	 L75rv8ii0SiYdmTuh4MaT+qpbSK723jh++ZB747hVl4UYN5vkADrnug0NX41lWbi7p
	 all97XU5QFiuGjy6W5zQ3Qnf4Id7LswfagzHJtKRF3hF0kee4AIg4KA06NPnIOGtKO
	 xL6tdCDZlxyfF5gHo5TWMlGx9REkk+Pmsr+12uCYo5jwmi9RPZKEOBHSMItVaWn4Ud
	 0pB5yv7d7gz5Gne1nRdhh4h6xm+Y4CfCOsP+NNu1HU73/ksDkOKNcYCb5YjEAYL5xQ
	 qCCOhDjNqVjDA==
Subject: Re: [PATCH net] tcp: initialize mapped children before route lookup
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com,
 ncardwell@google.com, horms@kernel.org, netdev@vger.kernel.org,
 kylebot@openai.com
Date: Thu, 29 Oct 2026 16:05:48 +0000
Message-ID: <179328994870.3134.5952794338568067839@kernel.org>
In-Reply-To: <20261028154101.2153360-1-edumazet@kernel.org>
References: <20261028154101.2153360-1-edumazet@kernel.org>
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

- [Medium] The code change is correct, but the commit message understates
  what it fixes and the Fixes: tag is too narrow for stable backports.

--

tcp: initialize mapped children before route lookup

This patch moves the opt_child_init() call in tcp_v4_syn_recv_sock() so it
runs before inet_csk_route_child_sock(). A v4-mapped child on a dual-stack
listener now gets its pinet6 and ipv6_fl_list detached from the listener
before the route lookup can fail and tcp_done() destroys the clone.

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index ebe5aa70374a3..a7f9242f1e429 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1723,6 +1723,12 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
>  	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_reflect_tos))
>  		newinet->tos = tcp_rsk(req)->syn_tos & ~INET_ECN_MASK;
>  
> +#if IS_ENABLED(CONFIG_IPV6)
> +	/* Detach IPv6 state before a route lookup can fail. */
> +	if (opt_child_init)
> +		opt_child_init(newsk, sk);
> +#endif
> +
>  	if (!dst) {
>  		dst = inet_csk_route_child_sock(sk, newsk, req);
>  		if (!dst)

[Severity: Medium]

The code change looks right. Does the commit message undersell what this
fixes, though? And is the Fixes: tag narrower than it should be?

The commit message only describes the flowlabel use-after-free:

  With the flowlabel list head in inet_sock, fl6_free_socklist() walks
  the clone's list and RCU-frees its nodes without unlinking them from the
  live listener.

  Fixes: 1c17f4373d4d ("ipv6: Move ipv6_fl_list from ipv6_pinfo to inet_sock.")

Before this patch, if inet_csk_route_child_sock() fails, the clone made by
sk_clone_lock() still has newinet->pinet6 pointing at the listener's
ipv6_pinfo. Only tcp_v6_mapped_child_init() resets it:

  newinet->pinet6 = newnp = tcp_inet6_sk(newsk);
  newinet->ipv6_fl_list = NULL;

The clone is then torn down like this:

tcp_v4_syn_recv_sock()
  put_and_exit
    inet_csk_prepare_forced_close()
    tcp_done(newsk)
      ... __sk_destruct()
        inet6_sock_destruct()
          inet6_cleanup_sock()

In that path, inet6_cleanup_sock() uses np = inet6_sk() of the child, which
is the listener's pinfo:

net/ipv6/af_inet6.c:inet6_cleanup_sock() {
    ...
	skb = xchg(&np->pktoptions, NULL);
	kfree_skb(skb);

	skb = xchg(&np->rxpmtu, NULL);
	kfree_skb(skb);
    ...
	opt = unrcu_pointer(xchg(&np->opt, NULL));
	if (opt) {
		atomic_sub(opt->tot_len, &sk->sk_omem_alloc);
		txopt_put(opt);
	}
    ...
}

Wouldn't this free the listener's pktoptions and rxpmtu? It would also
drop the IPv6 tx options set on the listener with setsockopt (hop-by-hop,
routing and destination headers).

The atomic_sub() also seems to hit the child's sk_omem_alloc. That would
leave the listener charged for opt->tot_len and push the child's counter
negative.

None of this depends on 1c17f4373d4d. On trees before 1c17f4373d4d,
fl6_free_socklist() worked on np->ipv6_fl_list. The aliased np would
therefore drain and release the listener's own flowlabel list as well.

The aliasing on this error path seems to go back to the original v4-mapped
handling. Commit 858d2a4f67ff ("tcp: fix potential race in
tcp_v6_syn_recv_sock()"), which has Fixes: 1da177e4c3f4, added the
opt_child_init callback but left it after the route lookup. This patch
builds on that callback.

With only Fixes: 1c17f4373d4d, would stable trees that have 858d2a4f67ff
but not 1c17f4373d4d (older than v6.19) skip this fix? Those trees would
keep the listener state clobbering described above.

Could the commit message mention the np->opt, pktoptions and rxpmtu impact?
It could also add a Fixes: tag for 858d2a4f67ff (or 1da177e4c3f4), or list
the affected stable trees.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028154101.2153360-1-edumazet%40kernel.org
