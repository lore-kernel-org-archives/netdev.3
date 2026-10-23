Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792755584;
	b=LfWb2z8wC/I+1nURZrecr4SPSC6MZ2XnlzKPvuOMcIBzs+d2U4m0ykg+hF2hwl3WiQyA
	 lMiWVdEta29diYtEnWu+E/NL0bvAwfnIh4BRViGPIHYSYjjDK1tBQPUytn9YQsDi+0sH0
	 3jj5bqF2mhnJoQ+S+e5QxLVq/il7sOX3VkwUxew47gxNzO8TTlsBcAKCbzPaYoQ6GAc2q
	 ehPdga8FR3W+y+n9C0cs5WN0W4opugyRuxS1n4w0dvN9wibCaeW09RV8lE6r6RrlilEnl
	 ArLhuni6B/6lHBAvXWlM6NeGn6RaTKjMMsmrV6rRrp1INyFIBrsDPZ4ggSnwmJhbiOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792755584;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Q6S79bbMaNSuqrqpLiqNPimBxEwlH1ndoIlreZhWFgs=;
	b=EMoD9DBb/BZfokuuCP6gRaTG0ad4keFy9USaeiAHJQe4sFfvSKoAeYCRwGjwZHGsSPqC
	 ZDOM+KGYtqOyWNUedU2lQ/Uj4s8HO6qXtD4y7u8h9M8QENN1R9Xy3H6VhUtkdpXRhSDVd
	 P3fCeyOVDJlFJaQMzKLqQ3ASKU5faxA6NQJa94xuE4ykWp3zLOd7uRU9n4e+Q84slB9LJ
	 DWnJhtkPE7qvIb9evy2dcK7CD0vclFCuzLId6bHQiQonBL2Uv1+RP1HWyBukWFDGVv/Py
	 foULRxsKv1H6OD+Xxq+Q21z3Lcyqyi2AvR7pHyz/DzN4UHQc+6MIBFmRUEFoCGOnRhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dXbu00Fg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9FC606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dXbu00Fg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEFF1F01825;
	Fri, 23 Oct 2026 11:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792755583;
	bh=Q6S79bbMaNSuqrqpLiqNPimBxEwlH1ndoIlreZhWFgs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dXbu00FgxNz/J6C1nxky8UQOXaBC40ne0Z/z/88qchfSIY000BuEmYr5UqMV9/eMH
	 5nKX5ieIviSs5jqALqBjXMc5XifeBvJGWgbTWx3gNv4IPM/kT+OFn5hR8ukHO2k/TX
	 NJ0uat0w/hXw/ZF+rvv39bCEQfmAnV5Nm0S1O8gpejnyhZZq9dT6qBMUy7YItD3trg
	 053zDTwbn32HPCbqUIBy8OWPYZcnb0EMxtJzpSI9A5W6Igb/EtB+06ou7ZDOYr0J5a
	 h3DhK3DSF6voUToL7zVvVucGgpMYMvvUIKSOVXD4IEOLZHW9UAXlogaNrHEj7ADXz9
	 Grrtx4sDGrFyg==
Subject:
 Re: [PATCH net] inet: reject unhashed sockets during established lookups
From: netdev-bot+sashiko@kernel.org
To: imv4bel@gmail.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
 sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org
Date: Fri, 23 Oct 2026 11:39:42 +0000
Message-ID: <179275558269.3134.17308052093423946226@kernel.org>
In-Reply-To: <ath58Egc-oI6p3Jl@v4bel>
References: <ath58Egc-oI6p3Jl@v4bel>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new reader-side check does not order later loads of socket
  fields.

Pre-existing issues:
- [Medium] When a tuple matches but refcount_inc_not_zero_acquire()
  fails, __inet_lookup_established()…

--

inet: reject unhashed sockets during established lookups

This patch changes __inet_lookup_established() and
__inet6_lookup_established() to take the reference with
refcount_inc_not_zero_acquire(). After taking it, the lookup now restarts
if the nulls node is unhashed. It also switches the initial nonzero
refcount stores in the SYN cookie, TFO, request migration and TIME_WAIT
paths to refcount_set_release(), and frees published requests with
reqsk_put().

[ ... ]

> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index ba0faa9ae2bb3..7ffa9171d6de1 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -550,10 +550,11 @@ struct sock *__inet_lookup_established(const struct net *net,
>  		if (sk->sk_hash != hash)
>  			continue;
>  		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
> -			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> +			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
>  				goto out;

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. When
the tuple matches but the refcount increment fails, the lookup still
does goto out and returns NULL instead of restarting.
Documentation/RCU/rculist_nulls.rst restarts the lookup in this case.

Can this miss a live socket that is in the same chain? Here is one window.
In reqsk_timer_handler(), inet_reqsk_clone() does:

    memcpy(nreq_sk, req_sk,
           offsetof(struct sock, sk_dontcopy_begin));

This copies skc_hash and the tuple from oreq, but not skc_refcnt. Until
reqsk_timer_handler() reaches this line:

    refcount_set_release(&nreq->rsk_refcnt, 2 + 1);

nreq carries oreq's hash and tuple with a refcount of 0 left over from its
previous life. During that time oreq is still hashed in the same chain.

A reader whose stale pointer lands on nreq passes the hash and tuple
checks and fails the increment. It then returns NULL without reaching
oreq.

tcp_v4_rcv() then falls back to the listener. For an ACK,
tcp_rcv_state_process() in TCP_LISTEN returns 1, so a RST is sent for a
valid handshake. A similar window exists for a replaced req whose
refcount has already dropped to 0.

A restart has a cost of its own. reqsk_queue_hash_req() hashes a req
before it sets the refcount, so a restarting reader would have to spin
past that window. The window is kept short with preempt_disable_nested().

The same goto out exists in __inet6_lookup_established().

> -			if (unlikely(!inet_match(net, sk, acookie,
> -						 ports, dif, sdif))) {
> +			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
> +				     !inet_match(net, sk, acookie, ports, dif,
> +						 sdif))) {

[Severity: Medium]
On weakly ordered CPUs such as arm64 and POWER, does this check order the
caller's later loads of socket fields?

hlist_nulls_unhashed_lockless() is only:

    return !READ_ONCE(h->pprev);

Branching on it creates a control dependency. That orders later stores,
but not later loads.

For full child sockets, the acquire in refcount_inc_not_zero_acquire()
does not seem to pair with a release either. sk_clone() publishes the
refcount with a plain store:

    smp_wmb();
    refcount_set(&newsk->sk_refcnt, 2);

After that store, inet_csk_clone_lock() writes the child's tuple, clears
icsk_accept_queue, and changes sk_state from the TCP_LISTEN value copied
from the parent to TCP_SYN_RECV. tcp_v4_syn_recv_sock() hashes the child
last.

A stale reader could then see a non-NULL pprev and the new tuple, but
still load the parent's TCP_LISTEN when tcp_v4_rcv() reads sk_state:

    if (sk->sk_state == TCP_LISTEN) {
        ret = tcp_v4_do_rcv(sk, skb);
        goto put_and_return;
    }

That path skips bh_lock_sock_nested(). The packet is processed on the
child without its lock while the creating CPU still holds that lock and
is finishing setup. The result is either a RST from listener handling or
unlocked SYN_RECV processing that races with the creator.

The commit message says:

    This rejects the SYN cookie
    request socket and blocks the child socket path observed in the x86
    test.

Does this hold only under x86 TSO? Is an smp_rmb() (or an acquire load of
pprev) needed after the hashed check, with matching ordering on the
writer side?

The same check in __inet6_lookup_established() has the same ordering
question.

>  				sock_gen_put(sk);
>  				goto begin;
>  			}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/ath58Egc-oI6p3Jl%40v4bel
