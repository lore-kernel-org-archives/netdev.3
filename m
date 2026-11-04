Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784649;
	b=MHYGk+uMqovisDynlJOLi3uQUzxb/BcuN4jeDm583bMkbJOAkAvp206GSKfjWweCJ0Di
	 n2rD42F54DUcE0yD5L6DHvxPxY5BibaG7KKiZ62q+ZDloqJOC1bzsvxNhlzIb3tHlXcRN
	 Znabo3SH/6zCAMRk9eLqUdpPikRhv6LfGf3fKhbHPKEMukNdfYnpwsRi20q89su27tu41
	 s0PjFsvrLiJKK4Tab/RSw3/PHjn2UQGAYkNxaLD0MopW7EMHfMHlGuvu2bCHSb2SDr+3j
	 f2pzLA2bVMtbzYgajlyM9RkdFb+BcpYhjYER7HVtfOok7ibVjqMaj2dpklsbPiMmmHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784649;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MRomafyDlwzptTqN1etIkbhtQYDZ3H4jUzUChgsePjk=;
	b=QDORQE4J3qw+R+0ZSNLZskCeFT31fyKJAfjZc1vnHPbwQehzlDftGExOU5wD7cjzkkqo
	 e5jKa6rbDrHOzP5T5RPO+lI2q/RsliQvESlyPIcJbpLyNb6Snt6cmaO7QIAcUDx605/9G
	 IgI145SLf5nJkaxs5q63YqrRY6wp1dvTQXlJA4vE6myaSmDtmsVrnVJBSplwQJoFk+Y5S
	 BTxewc5c1NMpx6E4CwXNKmkyRgx75I/cLosKFxDUA11EK0ykfop1vr+dXK0GVHv3MB2p2
	 u4VOKjCmaHvo2qrXH+neKCSWpdH6zQ7t00D3Ji6A+lxKCCoIfBzbkMOnPyzcDE46ZVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YKmL9G3M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1FA606A331
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YKmL9G3M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263841F00A17;
	Wed,  4 Nov 2026 09:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793784648;
	bh=MRomafyDlwzptTqN1etIkbhtQYDZ3H4jUzUChgsePjk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YKmL9G3MG8ox1lL+F/0rwgYejEwHtMkPvYRlDI02F+VFTggOpb2xtaOZMxBcJcFd8
	 rkxwWgfmxIQg1UQYQHAhxhdeKiz5LlO6Rd0XIL/bO/W4wIrwrqFISDXqysmhA0L7yC
	 ZqvIJKTzkEruB+8b82+EclMRczMQXFyNQu/CwzXUk4p9AQMLbPltNl/Y33vAqVBunN
	 FMe1w1VLjYgj7X11ZWKVHVLip4eYzUu7DuzS3O31pEpjgV4WdzCayUeQ80xrThCsFU
	 KzTc3Rpunqehnkb1dTVeU4WyzVu1wey+1Hg166T6lugi+98Op1OWavAgIHBeWcy1qX
	 MApv18Z0qECSQ==
Subject: Re: [PATCH net] inet: frags: bound the wmem charge of the socket
 completing a reassembly
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 netdev@vger.kernel.org, fw@strlen.de
Date: Wed, 04 Nov 2026 09:30:47 +0000
Message-ID: <179378464765.488856.7246331085173485104@kernel.org>
In-Reply-To: <20261103092957.4164530-1-edumazet@kernel.org>
References: <20261103092957.4164530-1-edumazet@kernel.org>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In net/ipv4/inet_fragment.c, inet_frag_wmem_ok() (lines 533-540)
  reads sk->sk_wmem_alloc without any socket-wide lock or reservation…

--

inet: frags: bound the wmem charge of the socket completing a reassembly

This patch adds inet_frag_wmem_ok(). The new helper refuses a reassembly
when charging the queue's truesize to the completing socket would push
sk_wmem_alloc above 2 * sk_sndbuf + 4MB, capped at INET_FRAG_MAX_TRUESIZE.
The aim is to keep sk_wmem_alloc from saturating while several reassembled
skbs owned by the same socket are alive at the same time.

Closes: https://lore.kernel.org/netdev/24feda7d-ae49-45af-9596-2cc5f149f28e@redhat.com/

> diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
> index 0b8d22ffafca6..c11d7e976dfa5 100644
> --- a/net/ipv4/inet_fragment.c
> +++ b/net/ipv4/inet_fragment.c

[ ... ]

> @@ -519,6 +520,25 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
>  }
>  EXPORT_SYMBOL(inet_frag_queue_insert);
>  
> +/* When a socket owned fragment completes a queue, the truesize of all
> + * other fragments is charged to its sk_wmem_alloc, although they were
> + * orphaned when queued and possibly sent by someone else.
> + * Bound this like ip_append_data() bounds the memory a socket can
> + * allocate (2 * sk_sndbuf), plus slack for fragments inflated by a
> + * refragmentation using a small MTU. Otherwise, several reassembled skbs
> + * alive at the same time can saturate sk_wmem_alloc, and leak the socket.
> + */
> +#define INET_FRAG_WMEM_SLACK	SZ_4M
> +
> +static bool inet_frag_wmem_ok(const struct inet_frag_queue *q,
> +			      const struct sock *sk)
> +{
> +	u64 limit = 2ULL * READ_ONCE(sk->sk_sndbuf) + INET_FRAG_WMEM_SLACK;
> +	u64 wmem = (u64)refcount_read(&sk->sk_wmem_alloc) + q->truesize;
> +
> +	return wmem <= min_t(u64, limit, INET_FRAG_MAX_TRUESIZE);
> +}

[Severity: High]
Is this check safe when other reassemblies charge the same socket at the
same time?

inet_frag_wmem_ok() reads sk_wmem_alloc without a lock. The charge it
approves is applied later, in two steps:

inet_frag_reasm_prepare()
    refcount_add(ts_delta, &sk->sk_wmem_alloc);

inet_frag_reasm_finish()
    /* after the loop over every fragment */
    refcount_add(sum_truesize - head_truesize, &sk->sk_wmem_alloc);

The only lock held across this is the per-queue lock, for example
spin_lock(&qp->q.lock) in ip_defrag(). The IPv6, nf_conntrack and 6lowpan
callers follow the same pattern. That lock serializes one queue, not all
the queues charging the same socket.

Suppose several CPUs complete different queues for the same socket. Can
they all read the same sk_wmem_alloc value W, all see
W + q->truesize <= limit, and then all add their charge?

The limit is at most INET_FRAG_MAX_TRUESIZE (INT_MAX / 2). So three such
completions racing would seem to be enough to push sk_wmem_alloc past
INT_MAX. That is the saturation and socket leak the commit message
describes.

One possible path from an unprivileged user/net namespace:

tun_chr_open() sets tfile->sk.sk_sndbuf = INT_MAX, so the limit works out
to min(2 * INT_MAX + 4M, INT_MAX / 2) = INT_MAX / 2.

tun_build_skb() and the sock_alloc_send_pskb() path leave the skbs owned
by the tun socket via skb_set_owner_w(), so is_skb_wmem() is true. These
skbs are not orphaned before tc ingress, and tun_get_user() takes no
per-write lock outside the napi_frags mode.

Add clsact plus act_ct on the tun device and raise ipfrag_high_thresh.
Then several threads writing the final fragments of different datagrams
to the same tun fd would each reach this path on their own CPU, each
under a different q->lock:

netif_receive_skb()
  tcf_ct_handle_fragments()
    nf_ct_handle_fragments()
      ip_defrag()
        inet_frag_reasm_prepare()
          inet_frag_wmem_ok()

The window between the check and the second refcount_add() covers
skb_clone(), skb_morph(), skb_unclone() and the whole fragment loop in
inet_frag_reasm_finish().

Would this need an atomic reservation on sk_wmem_alloc instead? For
example, add the charge first and then recheck and roll back, or use a
cmpxchg loop.

> +
>  void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
>  			      struct sk_buff *parent)
>  {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103092957.4164530-1-edumazet%40kernel.org
