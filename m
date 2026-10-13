Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A863FCB10;
	Tue, 13 Oct 2026 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899550; cv=none; b=aDg26/d49TPZzG+wcLP55ufjuD1hyMbDqs/rrXQsXWmen2uLvMuCXhEChTcXSXJztcWo1S397d6NTaH2C7gu/kV43Umj1tjTgSlrmdX1MlQYbRPXfEpmByrJ74Qt6T1TsMy4ifijP6BBIPb1Fm5MjQ5SmnFuyoGxoI6In5nXJNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899550; c=relaxed/simple;
	bh=pEYMxmYxe4FRLqIyZY8c/oDGXDmlznWxeFoZIxTmgY8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eZyrrgIJZnU/tPGOcT1OV8cCnx2Z3j/i8itQdjC9BzXIbF5n0Dvc240tKoQFxznxL3TN8jiZ/qV8RBccp9ThG/0qSciSl+DH/NkXWvboV0KrVSY/ks5XyAUyNuuQlmz1nuwSvxpKO7Un8XmnB2H3ZWoeoNJKGEimXSCgnAEIFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWlYWjYT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWlYWjYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1C81F00893;
	Tue, 13 Oct 2026 13:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899548;
	bh=s2xis/I+dDAnOZNwKUu1+i88VKTq7cNXnb1sSX5WJbs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YWlYWjYT5Xg4os8169kUp5SJZGNcPHJ35UNYCP3ibOX8i5Oj8nzs7v6q1AycPG39w
	 mgAJLtOBR14tIwExwmjwbEs8Lv3qnxyrLe+1W6FZCZE5UUP6CqtR6pwdyYS312G0Tn
	 nspeVJel7mhD4L2bdECesXn+rI6Fy0mjmkZC8KSD/w7HIrxVfOyZvo7dOfJ33C0nAt
	 Ahx0TlJQih045cmpTeUXlGbzYZH8NrArOJbl9yD9mNzAjbj9UBGNejLElZBaS7/lWn
	 gVHcrSVEhQaVQ8s3dJttICp61o2J+Ttps0NwEALgMANJ49SZsoo4qA747anR2kt+bX
	 o0HIZh0kOmdrA==
Subject: Re: [PATCH net-next v3 1/2] tcp: keep the route window metric when
 SO_RCVBUF is set before connect
From: netdev-bot+sashiko@kernel.org
To: jain.sm@gmail.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 13:52:27 +0000
Message-ID: <179189954738.434549.203786477614465237@kernel.org>
In-Reply-To: <20261012132622.48550-2-jain.sm@gmail.com>
References: <20261012132622.48550-2-jain.sm@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch changes only one of the three places that choose
  req->rsk_window_clamp, so SYN-cookie connections can end up with the…
- [Medium] The new early return in tcp_set_rcvbuf()
  (net/ipv4/tcp.c:1867-1868) is keyed on a single bit, window_clamp_user.
- [Medium] tcp_openreq_init_rwin() (net/ipv4/tcp_minisocks.c:448) reads
  the new bitfield tp->window_clamp_user with a plain load on a listener…
- [Low] The patch adds a new bitfield `window_clamp_user` to struct
  tcp_sock, in the tcp_sock_write_txrx cacheline group next to nonagle…

--

tcp: keep the route window metric when SO_RCVBUF is set before connect

This patch adds a window_clamp_user bit to struct tcp_sock. The bit records
whether TCP_WINDOW_CLAMP was set explicitly. tcp_connect_init() and
tcp_openreq_init_rwin() now apply the RTAX_WINDOW route metric whenever that
bit is clear, and tcp_set_rcvbuf() stops updating window_clamp once a user
clamp is set.

> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index e4d1720f49f08..2324841e53f27 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -301,7 +301,8 @@ struct tcp_sock {
>   *	0x5?10 << 16 + snd_wnd in net byte order
>   */
>  	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
> -		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
> +		rate_app_limited:1,  /* rate_{delivered,interval_us} limited? */
> +		window_clamp_user:1; /* TCP_WINDOW_CLAMP set by the user */

[Severity: Low]
This isn't a bug, but the comment at the top of struct tcp_sock says
"Please update the document when adding new fields." Should
window_clamp_user be added to
Documentation/networking/net_cachelines/tcp_sock.rst? That file already
lists the neighbouring nonagle and rate_app_limited fields.

>  	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
>  		accecn_opt_sent_w_dsack:1,/* Sent ACCECN opt in previous ACK w/ D-SACK */
>  		unused2:3;
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index f4c9101e5996a..5f364928b72ba 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1858,6 +1858,15 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
>  
>  void tcp_set_rcvbuf(struct sock *sk, int val)
>  {
> +	/* A window clamp set explicitly via setsockopt(TCP_WINDOW_CLAMP)
> +	 * takes precedence: SO_RCVBUF must not overwrite it.  Without such
> +	 * a user clamp, keep updating window_clamp from the buffer size so
> +	 * that SO_RCVBUF on an established socket still grows the advertised
> +	 * window (commit b025461303d8).
> +	 */
> +	if (tcp_sk(sk)->window_clamp_user)
> +		return;

[Severity: Medium]
Can this leave window_clamp stuck below the value the user asked for? The
bit only records that TCP_WINDOW_CLAMP was set. The kernel can still lower
tp->window_clamp afterwards.

Take TCP_WINDOW_CLAMP of 1 MiB set before connect(), with the default
sk_rcvbuf. At establishment, tcp_init_buffer_space() lowers the clamp:

net/ipv4/tcp_input.c:tcp_init_buffer_space() {
    ...
	maxwin = tcp_full_space(sk);

	if (tp->window_clamp >= maxwin) {
		WRITE_ONCE(tp->window_clamp, maxwin);
    ...
}

Suppose the application then enlarges SO_RCVBUF. __sock_set_rcvbuf()
raises sk_rcvbuf and sets SOCK_RCVBUF_LOCK, but tcp_set_rcvbuf() now
returns early, so window_clamp stays near the initial tcp_full_space().

tcp_rcvbuf_grow() also returns early when SOCK_RCVBUF_LOCK is set, and
tcp_grow_window() limits growth to min(window_clamp, tcp_space()).

Doesn't that mean the advertised window can't grow into the larger buffer,
even though the new size is still under the user's 1 MiB clamp? This only
changes if tcp_measure_rcv_mss() happens to reset window_clamp after a
scaling_ratio change. Before this patch, SO_RCVBUF updated the effective
clamp here, as b025461303d8 intended. Passive children inherit
window_clamp_user from the listener, so they would behave the same way.

Would it work to store the requested clamp value, rather than a single bit,
and let SO_RCVBUF raise window_clamp up to that value?

>  	tcp_set_window_clamp(sk, tcp_win_from_space(sk, val));
>  }

[ ... ]

> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 0ddfd5af6e58f..c24dc975a9c43 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -442,8 +442,11 @@ void tcp_openreq_init_rwin(struct request_sock *req,
>  
>  	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
>  	window_clamp = READ_ONCE(tp->window_clamp);
> -	/* Set this up on the first call only */
> -	req->rsk_window_clamp = window_clamp ? : dst_metric(dst, RTAX_WINDOW);
> +	/* Set this up on the first call only.  Honour a window clamp the
> +	 * listener set via TCP_WINDOW_CLAMP; otherwise use the route metric.
> +	 */
> +	req->rsk_window_clamp = tp->window_clamp_user ? window_clamp :
> +				dst_metric(dst, RTAX_WINDOW);

[Severity: High]
Does this leave the SYN cookie paths on the old rule? cookie_v4_check()
and cookie_v6_check() are meant to redo what the SYN-ACK path did. They
still pick the clamp based on a non-zero window_clamp:

net/ipv4/syncookies.c:cookie_v4_check() {
    ...
	/* Try to redo what tcp_v4_send_synack did. */
	req->rsk_window_clamp = READ_ONCE(tp->window_clamp) ? :
				dst_metric(&rt->dst, RTAX_WINDOW);
    ...
	if (!req->syncookie)
		ireq->rcv_wscale = rcv_wscale;
    ...
}

net/ipv6/syncookies.c:cookie_v6_check() {
    ...
	req->rsk_window_clamp = READ_ONCE(tp->window_clamp) ? :dst_metric(dst, RTAX_WINDOW);
    ...
}

tcp_conn_request() also calls tcp_openreq_init_rwin() for want_cookie
requests, so the cookie SYN-ACK now follows the new rule. The cookie does
not encode our rcv_wscale, so it is recomputed when the ACK arrives.

Consider a listener with SO_RCVBUF set but no TCP_WINDOW_CLAMP, a route with
"window 4096", and SYN cookies in use (syncookies=2, or a full accept queue
during a SYN flood):

  SYN-ACK path:  rsk_window_clamp = 4096, wscale 0 advertised
  cookie path:   window_clamp left non-zero by tcp_set_rcvbuf(),
                 rcv_wscale recomputed as about 5

Wouldn't the peer apply a shift of 0 to the child's windows while the child
shifts right by 5? The peer would then see a window about 32 times smaller
for the whole connection. The child's window_clamp would also ignore
RTAX_WINDOW.

Before this patch both paths used the same window_clamp ?: metric
expression, so the advertised and recomputed scales matched.

This also affects the commit message, which says:

  The route metric is then applied on all
  pre-connection paths, regardless of socket state, whenever the clamp was
  not set by the user; a passive socket inherits the decision from its
  listener.

That doesn't hold for SYN cookie connections. Should cookie_v4_check() and
cookie_v6_check() be converted to use window_clamp_user as well?

[Severity: Medium]
Is window_clamp_user read here without the listener lock? window_clamp is
read with READ_ONCE() just above because the listener isn't locked, but
window_clamp_user is a plain load.

On the write side, do_tcp_setsockopt() holds only the listener's socket
lock:

	case TCP_WINDOW_CLAMP:
		err = tcp_set_window_clamp(sk, val);
		if (!err)
			tp->window_clamp_user = !!val;

That is a plain read-modify-write of the u8 that window_clamp_user shares
with nonagle and rate_app_limited. TCP_NODELAY and TCP_CORK also rewrite
that byte on a listener. A bitfield can't be annotated with
READ_ONCE()/WRITE_ONCE(), so won't KCSAN report this race against SYN
processing?

The clamp and the flag are also stored separately, so a concurrent SYN
could see a mix of old and new values:

- If it sees the old SO_RCVBUF-derived window_clamp with the new flag set,
  the request uses a clamp that is neither the route metric nor the
  user's value.

- If it sees the new clamp with the old flag clear, the route metric is
  used, but the child created by sk_clone() later copies
  window_clamp_user=1 from the listener. That child then ignores SO_RCVBUF
  even though no clamp was ever applied to it.

>  
>  	/* limit the window selection if the user enforce a smaller rx buffer */
>  	if (sk_listener->sk_userlocks & SOCK_RCVBUF_LOCK &&

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012132622.48550-1-jain.sm%40gmail.com
