Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6273C3002B3
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209664; cv=none; b=d29iy7CPm/IX4qJx+5Hxl6r28cT+HO4J6VkAnUokQ5kNTWgeH+BE4u99z+Cj5cFroEzazLD5pQb/LqnBjFwDcCJK6SOnGfmWbEk3xUKmuc5y2ql1oBJTUhdm4vuMs0pKXwFzdWJv13M/T2rNv0AysSImLvnFYcg7FVljZoqje/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209664; c=relaxed/simple;
	bh=V1vFdNYaIpbGZXcijisYxU96s3bI+6vyGzTjcBOFSBk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RWZbUSXW9m0kPpFQQ9zoHr+8yOoe190zJobmFLCM2E9RXRcxgJn3dn/UHXoQE4vpyNIiJ6Fl0XizEKm1BQ4um8P6Y1tI577lI3lJCwmqkc93IJBNM3h2BZo1F0mUxeGfDclxjF6bI+lHJEMTvLmLJWx6SA24inY2LJOinbta9iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeRZCTop; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeRZCTop"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F49C1F00898;
	Thu, 24 Sep 2026 00:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209662;
	bh=sVaoajbb32KDXAPJfeHt0yTzGxb0Jf64PdJeQjPBgfY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XeRZCTopGn+sL89jE3eGSucfmi8VjKKifBmg40vo1huLUFHZsFmswy34bp9I+sSoN
	 05xQl32ocTEWe1PNWiNrnTBKSKGCW2HkGgbxmnaDK1KN1BB9KkNh5+fakDYLa3lCt1
	 GoH1fO8zAqB/V87va9spfGTHfxftUaVTKSZUKCwYddtGazVdQscicur1/XYsGyfnQ3
	 nfkxCRrT8GvIsUnTqRWEdwPWuejTr/Gv2eSyDsnA0DjURPJK0pcHonIMCtxHsRgceh
	 O6USW6hikf/mWe2zr7g0wo2lbF6++t9oxdlb8tlVpEMG9z45Ar0UMeGQjqennAQixE
	 kE6+zfpgIk9rA==
Subject: Re: [PATCH net-next 9/9] tcp: add tp->tcp_nospace
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, willemb@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Thu, 24 Sep 2026 00:27:41 +0000
Message-ID: <179020966110.2160803.10658313067830814782@kernel.org>
In-Reply-To: <20260922122721.3568295-10-edumazet@google.com>
References: <20260922122721.3568295-10-edumazet@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Commit message claim "It fits in an existing hole,
  sizeof(struct tcp_sock) is unchanged" is wrong for the chosen position.
- [Medium] The invariant the commit message and include/net/tcp.h:787-793
  claim to maintain — "SOCK_NOSPACE set => tp->tcp_nospace set" — is not…
- [Low] The new field comment in include/linux/tcp.h states an invariant
  that in-tree code added by the same patch deliberately violates.

--

tcp: add tp->tcp_nospace

This adds a u8 mirror of SOCK_NOSPACE to struct tcp_sock so that
tcp_check_space() no longer has to touch sk->sk_socket->flags on every
incoming ACK and every transmitted packet.  The mirror is maintained by
sk_set_nospace()/sk_clear_nospace(), __tcp_check_space() keeps the
authoritative SOCK_NOSPACE test, and MPTCP subflows pin the mirror in
subflow_ulp_init().

A few questions below about the claimed layout and about the claimed
invariant.

[ ... ]

> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 6a8c77719322f..d51aae60aa45b 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -307,6 +307,10 @@ struct tcp_sock {
>  		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
>  		prev_ecnfield:2; /* ECN bits from the previous segment */
>  	__be32	pred_flags;
> +	u8	tcp_nospace;	/* mirrors SOCK_NOSPACE, but in a cache line
> +				 * that tcp_check_space() already needs.

[Severity: Medium]

The changelog says:

    Add tp->tcp_nospace, a mirror of SOCK_NOSPACE placed in the
    tcp_sock_write_txrx group [...] It fits in an existing hole,
    sizeof(struct tcp_sock) is unchanged.

Is there actually a hole at this particular position?

Counting from the 64-byte aligned start of the tcp_sock_write_tx group
(the __cacheline_group_begin/end markers are zero-length u8 arrays and
consume no space), ecn_flags ends at group-relative offset 145, so the
three u8 bitfield bytes that open tcp_sock_write_txrx occupy 145, 146 and
147:

	u8	nonagle : 4,
		rate_app_limited:1;			/* byte 145 */
	u8	received_ce_pending:4, ...		/* byte 146 */
	u8	accecn_minlen:2, ...			/* byte 147 */
	__be32	pred_flags;				/* 148..151 */
	u64	tcp_clock_cache;			/* 152 */

pred_flags then lands exactly at 148..151 and the 8-byte aligned
tcp_clock_cache exactly at 152, with no padding in between.  The 2-byte
hole that used to precede pred_flags was consumed by the AccECN u8
bitfields that now sit in front of it.

Doesn't inserting a u8 between pred_flags and tcp_clock_cache therefore
add 7 bytes of padding and push tcp_clock_cache, tcp_mstamp, rcv_nxt and
everything up to segs_out 8 bytes further into the hottest group, rather
than filling a hole?

Two places in the same cache line look genuinely free: the spare
unused2:3 bits in the received_ce_pending bitfield right above, or the
3-byte hole after u8 chrono_type in the tx group.

Would it be worth adding a CACHELINE_ASSERT_GROUP_SIZE() for struct
tcp_sock as well?  tcp_struct_check() only uses
CACHELINE_ASSERT_GROUP_MEMBER(), so an 8-byte growth of
tcp_sock_write_txrx is not caught at build time.  A pahole diff of
struct tcp_sock before and after would settle the "sizeof(struct
tcp_sock) is unchanged" claim either way.

> +				 * Can only be set if SOCK_NOSPACE is set.
> +				 */

[Severity: Low]

This comment says the mirror "Can only be set if SOCK_NOSPACE is set",
but subflow_ulp_init() in net/mptcp/subflow.c sets tp->tcp_nospace = 1
at ULP init time, when the shared struct socket has SOCK_NOSPACE clear,
and tcp_clear_nospace() then refuses to ever clear it again for MPTCP
subflows.

The direction the rest of the patch relies on is the reverse one
(SOCK_NOSPACE set => mirror set), which is what the comment block above
tcp_set_nospace() in include/net/tcp.h and the changelog describe.
Could this field comment be reworded to state that direction instead?
As written, the two headers document opposite contracts for the same
field, and a reader trusting this one might drop the SOCK_NOSPACE
re-test just added to __tcp_check_space(), or add a warning for
"mirror set but SOCK_NOSPACE clear", and break MPTCP.

>  	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
>  	u64	tcp_mstamp;	/* most recent packet received/sent */
>  	u32	rcv_nxt;	/* What we want to receive next		*/
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 5e5f5f9b89a38..1e1950dd184ec 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -783,14 +783,35 @@ void tcp_done_with_error(struct sock *sk, int err);
>  void tcp_reset(struct sock *sk, struct sk_buff *skb);
>  void tcp_fin(struct sock *sk);
>  void __tcp_check_space(struct sock *sk);
> +
> +/* Mirror of SOCK_NOSPACE in tcp_sock, maintained by sk_set_nospace()
> + * and sk_clear_nospace().
> + *
> + * MPTCP subflows share the parent socket, and thus its SOCK_NOSPACE bit.
> + * Keep their mirror always set (see subflow_ulp_init()) so that they
> + * always reach __tcp_check_space() and behave as before.
> + */
> +static inline void tcp_set_nospace(struct sock *sk)
> +{
> +	if (sk_is_tcp(sk))
> +		WRITE_ONCE(tcp_sk(sk)->tcp_nospace, 1);
> +}
> +
> +static inline void tcp_clear_nospace(struct sock *sk)
> +{
> +	if (sk_is_tcp(sk) && !sk_is_mptcp(sk))
> +		WRITE_ONCE(tcp_sk(sk)->tcp_nospace, 0);
> +}
> +
>  static inline void tcp_check_space(struct sock *sk)
>  {
>  	/* pairs with tcp_poll() */
>  	smp_mb();
>  
> -	if (sk->sk_socket && test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
> +	if (unlikely(READ_ONCE(tcp_sk(sk)->tcp_nospace)))
>  		__tcp_check_space(sk);
>  }
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 11a22aec7e414..dce4e8e4e2bbe 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2969,8 +2969,13 @@ void sk_set_nospace(struct sock *sk)
>  {
>  	struct socket *sock = sk->sk_socket;
>  
> -	if (sock)
> -		set_bit(SOCK_NOSPACE, &sock->flags);
> +	if (!sock)
> +		return;
> +	/* Mirror first: callers relying on the barrier implied by
> +	 * set_bit() + smp_mb__after_atomic() are then also covered.
> +	 */
> +	tcp_set_nospace(sk);
> +	set_bit(SOCK_NOSPACE, &sock->flags);
>  }
>  EXPORT_SYMBOL(sk_set_nospace);
>  
> @@ -2985,8 +2990,13 @@ void sk_clear_nospace(struct sock *sk)
>  {
>  	struct socket *sock = sk->sk_socket;
>  
> -	if (sock)
> -		clear_bit(SOCK_NOSPACE, &sock->flags);
> +	if (!sock)
> +		return;
> +	clear_bit(SOCK_NOSPACE, &sock->flags);
> +	/* Mirror last: a stale mirror only costs a slow path, while a
> +	 * stale SOCK_NOSPACE would cost a missed EPOLLOUT.
> +	 */
> +	tcp_clear_nospace(sk);
>  }
>  EXPORT_SYMBOL(sk_clear_nospace);

[Severity: Medium]

Can the invariant the changelog states actually hold?

    The two flags are now only changed from sk_set_nospace() and
    sk_clear_nospace(), which maintain this invariant:

            SOCK_NOSPACE set  =>  tp->tcp_nospace set

The set side stores the mirror first and then the bit, while the clear
side clears the bit first and then the mirror, so the two non-atomic
stores are issued in opposite order on the two sides.  sk_set_nospace()
runs without the socket lock from tcp_poll(), while sk_clear_nospace()
for TCP runs under the socket lock from
tcp_check_space()->__tcp_check_space()->tcp_new_space()->sk_stream_write_space().

CPU0, in tcp_poll(), no socket lock:
	tcp_set_nospace(sk);			/* mirror = 1 */
	/* delayed here */

CPU1, socket lock held, processing an ACK:
	sk_clear_nospace(sk)
		clear_bit(SOCK_NOSPACE, &sock->flags);
		tcp_clear_nospace(sk);		/* mirror = 0 */

CPU0 resumes:
	set_bit(SOCK_NOSPACE, &sock->flags);	/* bit = 1, mirror = 0 */

Doesn't that leave SOCK_NOSPACE set with tp->tcp_nospace clear, the
combination the changelog declares impossible?  It looks like a lost
update across two separate locations, so no barrier or WRITE_ONCE
placement fixes it, and reversing the store order in sk_clear_nospace()
just makes the symmetric interleaving possible instead.

While that state holds, tcp_check_space() short-circuits on every ACK
and every transmitted packet, so tcp_new_space() and
sk->sk_write_space() are never reached: no SOCK_NOSPACE clearing, no
EPOLLOUT/SIGIO wake, no tcp_sndbuf_expand() autotuning, and no
tcp_chrono_stop(TCP_CHRONO_SNDBUF_LIMITED).  Before this patch the same
race could only end up in the safe combination, since the bit being set
always took the slow path.

For poll()/epoll() this seems to self-heal: sk_clear_nospace() in
sk_stream_write_space() is immediately followed by
wake_up_interruptible_poll(EPOLLOUT ...) while the waiter is already
queued, and tcp_poll() re-arms the mirror whenever it finds the socket
not writeable.  sendmsg() callers take the socket lock and cannot race
at all.

The case that does not look self-healing is in-kernel users whose only
re-arm path is the suppressed ->sk_write_space() callback and whose
sk_set_nospace() is lock-free, for example send_to_sock() in
fs/dlm/lowcomms.c:

	sk_set_nospace(con->sock->sk);
	con->sock->sk->sk_write_pending++;

whose retry comes from lowcomms_write_space() requeueing con->swork, and
xs_nospace() in net/sunrpc/xprtsock.c, whose retry comes from
xs_write_space()->xprt_write_space().  Can a transmit stall there until
an unrelated event or an RPC timeout?

Would re-testing SOCK_NOSPACE after the clear (with a full barrier) and
re-arming the mirror, or only clearing the mirror together with a
re-validation by the socket owner, be enough to restore the stated
invariant?

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f0a6725d2c376..e297c88be503b 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -2001,6 +2001,11 @@ static int subflow_ulp_init(struct sock *sk)
>  	pr_debug("subflow=%p, family=%d\n", ctx, sk->sk_family);
>  
>  	tp->is_mptcp = 1;
> +	/* Subflows share the MPTCP socket, and thus its SOCK_NOSPACE bit,
> +	 * which tcp_check_space() can not mirror. Pin the mirror so that
> +	 * __tcp_check_space() always tests the shared bit.
> +	 */
> +	tp->tcp_nospace = 1;
>  	ctx->icsk_af_ops = icsk->icsk_af_ops;
>  	icsk->icsk_af_ops = subflow_default_af_ops(sk);
>  	ctx->tcp_state_change = sk->sk_state_change;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922122721.3568295-1-edumazet%40google.com
