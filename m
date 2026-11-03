Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693103;
	b=UDizNDbk2XTE1jppOxGKEC/PUC2XTaVdhKls3Y0RoTgs0Vddl8E+ulRAfyc58s5Trmn0
	 +kuxSnKTKoqpCF0a8XtpmdcD5Bqf4u0wQYfD7UPrVQO1Mzfg02uVJsgesKI8Dyhs6tMXO
	 Lwt9lSo1HfdVfKHulG8ojtoxsM4yW28RNdaof14HPpXNl8l8pfZXfXZ2QHrCmMEvUS1t8
	 d1iY5tKwBWqZJXF1QWxJu3Hen/R1COfOJpwu/JWCXJS3Yv7aZG7grUqS6Ht+FybhMYO2M
	 1Gr41NbTYz3S9uFWHRZz1c8UXtUmAp84iVqFXYDpbDD6nfRqWC4lPG1GNkEGVgzjv/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693103;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SKr8KVYCoXV6nvYY37CvWM/S3f7h+586zXtd/TK+Tos=;
	b=Spo+IyQM9kJSSuGaOgPbZr5/F9evYK3/PA5J55mbvwksDM+ie4zUBH3wZSTclo/HlhEQ
	 BuMuTvboABHCto50HhxRTfyCXkx+bd/lnZ6bMoRY7oCyl5D5OZn+oiMPH98PNU07bPTY/
	 llwrLF36JwVOxeSGdUX0Mqs3C01vUVlofFRBcYlrAF393wN+xkqmTCE6mS45nvigx9yIq
	 y9tcUFZoKNHVe3j1zubHiP1l/28XUeHmirF7arIIPv63BVG///sZEPantvwjnPky419Lv
	 wBir86nkt/EpmA5yzunsBDa2Ez8M4oLewtbmckmP/4gj7PX51LEG6ZXar+fwReenRxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NvEuHClj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB7A606A332
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NvEuHClj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBED41F0093A;
	Tue,  3 Nov 2026 08:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793693102;
	bh=SKr8KVYCoXV6nvYY37CvWM/S3f7h+586zXtd/TK+Tos=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NvEuHCljGTQ4aP0kmMT5S3Guhg1VS9VGyIz7ntIqfsQFe98+1vJ7qTveuHoVCvKAS
	 Gr8Rl0f7JMx5gbOP5Dpq1fU2dnnaXsK8fIG3KnXFEFcjobnJYrjVx+JP7UBlq5W4mF
	 FQzZkHH2P+m/wDc/MTPTQGfmMcNCCgD5AuHfksooi7QjtQ7sFjBLCgpQNatCTiDbnb
	 cFAve6OED6mXs6t+W1p0sM1gfsfcUTi0uimoLducbHFhcF6zGhnRNy+AF8vBG6DxY4
	 p0l/dtGOCjplJPts+IZ8lHILiz+duB0l0DOg8fCi+JYSEGY7eo6qGfDDv8lHb4JxUS
	 fq4iKSgbV+CUQ==
Subject:
 Re: [PATCH 04/14] xfrm: espintcp: reorder operations within espintcp_init_sk
From: netdev-bot+sashiko@kernel.org
To: steffen.klassert@secunet.com
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org
Date: Tue, 03 Nov 2026 08:05:01 +0000
Message-ID: <179369310134.488856.11660609562678130680@kernel.org>
In-Reply-To: <20261102100451.2505200-5-steffen.klassert@secunet.com>
References: <20261102100451.2505200-5-steffen.klassert@secunet.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch annotates only part of the concurrent access to
  sk->sk_prot.

Pre-existing issues:
- [Critical] esp_find_tcp_sk() (net/ipv4/esp4.c:138-145) and
  esp6_find_tcp_sk() (net/ipv6/esp6.c:155-162) drop the lookup reference…
- [Medium] espintcp_close() (net/xfrm/espintcp.c:536) always restores
  `sk->sk_prot = &tcp_prot`, even for AF_INET6 sockets.
- [Medium] On the AF_INET6 path, the first espintcp_init_sk() call after
  boot fills the static espintcp6_prot/espintcp6_ops with…

--

xfrm: espintcp: reorder operations within espintcp_init_sk

This commit reorders espintcp_init_sk() so the espintcp_ctx is fully
set up and published as icsk_ulp_data before the socket callbacks and
proto/ops are switched to the espintcp versions. An smp_wmb()/smp_rmb()
pair is added between espintcp_init_sk() and espintcp_getctx(), along
with some READ_ONCE/WRITE_ONCE annotations on sk_prot, sk_socket->ops
and the callbacks.

Link: https://lore.kernel.org/all/c30b645074a1b379e0f7fe297f917c66137d9964.1778464688.git.zylzyl2333@gmail.com/
Link: https://lore.kernel.org/all/20260819155349.3555804-1-jjy600901@snu.ac.kr

> diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
> index 3e72b9f067b9b..4052ae5bbb2ea 100644
> --- a/net/xfrm/espintcp.c
> +++ b/net/xfrm/espintcp.c
> @@ -434,7 +434,9 @@ static void espintcp_destruct(struct sock *sk)
>  
>  bool tcp_is_ulp_esp(struct sock *sk)
>  {
> -	return sk->sk_prot == &espintcp_prot || sk->sk_prot == &espintcp6_prot;
> +	const struct proto *prot = READ_ONCE(sk->sk_prot);
> +
> +	return prot == &espintcp_prot || prot == &espintcp6_prot;
>  }

[Severity: Low]

tcp_is_ulp_esp() now reads sk->sk_prot with READ_ONCE(), and
espintcp_init_sk() installs it with WRITE_ONCE(). Should the restore in
espintcp_close() get the same treatment?

net/xfrm/espintcp.c:espintcp_close() {
	...
	strp_stop(&ctx->strp);

	sk->sk_prot = &tcp_prot;

	synchronize_rcu();
	...
}

This plain store is the one that actually runs at the same time as the
lockless reader. espintcp_close() is reached through
inet_release()->sk->sk_prot->close() without lock_sock. esp_find_tcp_sk()
and esp6_find_tcp_sk() call tcp_is_ulp_esp() holding only
rcu_read_lock(). The synchronize_rcu() right after the store exists
because of those readers.

The TLS ULP marks its restore path with WRITE_ONCE(sk->sk_prot,
ctx->sk_proto) in net/tls/tls_main.c. Would WRITE_ONCE(sk->sk_prot,
&tcp_prot) in espintcp_close() complete the annotation?

[Severity: Critical]

This is a pre-existing issue, but since this patch touches
tcp_is_ulp_esp(): can its callers call sock_put() on a minisocket?

net/ipv4/esp4.c:esp_find_tcp_sk() {
	...
	sk = inet_lookup_established(net, x->id.daddr.a4, dport,
				     x->props.saddr.a4, sport, 0);
	if (!sk)
		return ERR_PTR(-ENOENT);

	if (!tcp_is_ulp_esp(sk)) {
		sock_put(sk);
		return ERR_PTR(-EINVAL);
	}
	...
}

esp6_find_tcp_sk() in net/ipv6/esp6.c follows the same pattern.

__inet_lookup_established() walks the ehash chain, which also contains
TIME_WAIT and NEW_SYN_RECV sockets, and takes a reference with
refcount_inc_not_zero(). Its own mismatch path drops that reference
with sock_gen_put().

A timewait socket's tw_prot is sk_prot_creator (tcp_prot or
tcpv6_prot), so tcp_is_ulp_esp() always returns false for it and the
sock_put() path runs.

Here is one possible sequence. The espintcp socket was actively closed,
so its 4-tuple is in TIME_WAIT with tw_refcnt == 3:

CPU1 (ESP output)
esp_output_tcp_finish()
  esp_find_tcp_sk()
    __inet_lookup_established()
      refcount_inc_not_zero()        /* 3 -> 4 */

CPU2 (tw timer)
tw_timer_handler()
  inet_twsk_kill()
    sk_nulls_del_node_init_rcu()     /* 4 -> 3 */
    inet_twsk_bind_unhash()          /* 3 -> 2 */
    inet_twsk_put()                  /* 2 -> 1 */

CPU1
    tcp_is_ulp_esp(tw) returns false
    sock_put()                       /* 1 -> 0, sk_free(tw) */

sk_free() then decrements sk_wmem_alloc and may run __sk_free() on
memory that is not a full struct sock. inet_twsk_free() is skipped.

A NEW_SYN_RECV request socket on the same 4-tuple, which a remote SYN
can create, would hit the same wrong-destructor path.

Should esp_find_tcp_sk() and esp6_find_tcp_sk() use sock_gen_put()
here instead?

>  EXPORT_SYMBOL_GPL(tcp_is_ulp_esp);
>  
> @@ -466,34 +468,41 @@ static int espintcp_init_sk(struct sock *sk)

[ ... ]

> +	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
> +
> +	/* pairs with smp_rmb() in espintcp_getctx() */
> +	smp_wmb();
> +
> +	WRITE_ONCE(sk->sk_data_ready, espintcp_data_ready);
> +	WRITE_ONCE(sk->sk_write_space, espintcp_write_space);
> +	sk->sk_destruct = espintcp_destruct;
>  
>  	if (sk->sk_family == AF_INET) {
> -		sk->sk_prot = &espintcp_prot;
> -		sk->sk_socket->ops = &espintcp_ops;
> +		WRITE_ONCE(sk->sk_prot, &espintcp_prot);
> +		WRITE_ONCE(sk->sk_socket->ops, &espintcp_ops);
>  	} else {
>  		mutex_lock(&tcpv6_prot_mutex);
>  		if (!espintcp6_prot.recvmsg)
>  			build_protos(&espintcp6_prot, &espintcp6_ops, sk->sk_prot, sk->sk_socket->ops);
>  		mutex_unlock(&tcpv6_prot_mutex);
>  
> -		sk->sk_prot = &espintcp6_prot;
> -		sk->sk_socket->ops = &espintcp6_ops;
> +		WRITE_ONCE(sk->sk_prot, &espintcp6_prot);
> +		WRITE_ONCE(sk->sk_socket->ops, &espintcp6_ops);
>  	}

[Severity: Medium]

This is a pre-existing issue, but the new smp_wmb() comes before the
AF_INET6 branch. On the first IPv6 espintcp conversion after boot,
build_protos() fills espintcp6_prot and espintcp6_ops using memcpy()
and plain stores. The two WRITE_ONCE() calls above then publish them.

Only mutex_unlock() sits between the two sets of stores. It is a
release, so it doesn't order the later publication stores after the
earlier build_protos() stores.

Can another thread on the same socket see the new pointer before the
struct contents are visible?

sock_recvmsg_nosec() calls READ_ONCE(sock->ops)->recvmsg. inet6_recvmsg()
and inet6_sendmsg() call prot->recvmsg/sendmsg after
READ_ONCE(sk->sk_prot). Neither takes lock_sock. If one of them sees a
still-zero ->recvmsg or ->sendmsg, it calls a NULL function pointer.

Would moving the smp_wmb() after the AF_INET6 build block, or
publishing with smp_store_release(), order both the ctx and the proto
contents?

[Severity: Medium]

This isn't a bug introduced by this patch, but for AF_INET6 sockets
this branch installs espintcp6_prot, which is copied from tcpv6_prot.
espintcp_close() always restores the IPv4 proto:

net/xfrm/espintcp.c:espintcp_close() {
	...
	sk->sk_prot = &tcp_prot;
	...
}

struct espintcp_ctx doesn't save the original proto, so close cannot
restore the per-family one. Does an IPv6 espintcp socket then run
tcp_close() with tcp_prot?

inet_unhash() and inet_twsk_hashdance_schedule() both call:

	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);

The socket was counted under tcpv6_prot's inuse_idx, which
espintcp6_prot copies, but it gets decremented on tcp_prot's. "TCP:
inuse" in /proc/net/sockstat would be undercounted and "TCP6: inuse"
would leak.

Could the ctx save the original sk_prot, as tls_context->sk_proto
does, and restore it in espintcp_close()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102100451.2505200-2-steffen.klassert%40secunet.com
