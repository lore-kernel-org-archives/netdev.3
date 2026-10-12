Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB72D6E5A;
	Mon, 12 Oct 2026 05:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783188; cv=none; b=D//t0TIPDmQH5Uduwl4KSVYr+It3bBJrfg9jmiL1QHSSyuIRSkaKDcriymldke2J6L1TZqzJRnBOfpmWgAQWi3bdJkjLks6ZfQfptIgkYvEhK0LqehFbTIQZAZJ+dsJ0lOIzAYNKTdI7HE4YMuGm5Yr6KFo81krREYCUsTWCeEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783188; c=relaxed/simple;
	bh=+N7syFePuL/8+6jnO6RbQDpK4WiHjXipxZJg7MTUD80=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PmHcXT3yIMdQIKvvxgFg1H+M0pistB0OWSQdzuA8Bb1LWHvDNTR5EZ6V3KSsME7oc+sjDptWzPpQatX5ollhXDyYFGcA9470VQ0fgDEtMaKoFzGH9jyFNIYFahUWi9skunMKzgUWSIZRcNsK5leH5SgnHjHkCuyFoljnfFSqOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4W0v1aO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4W0v1aO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02041F0089B;
	Mon, 12 Oct 2026 05:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783185;
	bh=OYzQIzmc9o8ylzODnM24SFQCJ9GyZn3u1i7kDIbbMMA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V4W0v1aO22sZw0xe/xCPakKlsqutA5op7vbEYv14RcVmqw1bOOtJrq+bCUW2JQFWn
	 At3P/QshCM/Kr2vam19R8pU4SvgN6cTVYkKRAVpJ2SBhK+4S+BJ3mszVqNWSu/m4/h
	 QJMqpSA3mcdFigINhSOsiCC9XaX0+8Oi0j4uyZTBOaxdoMLpVsEvxpTOSwnb1T1l3H
	 1ZvIcltmtbLEm8OCbZr/v27jPBcb7fd6k5E3xceEBq4aEgWVVcRxN/0HBv7uocueEV
	 9Rl1D7R1nz5rxcaQbyIloSgVogGbvac38XHxNxxPnSKz0oQSnPK+q4vNLte4tGTUge
	 midO/EZTV3luA==
Subject: Re: [PATCH net] tcp: keep the route window metric when SO_RCVBUF is
 set before connect
From: netdev-bot+sashiko@kernel.org
To: jain.sm@gmail.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 05:33:04 +0000
Message-ID: <179178318451.434549.11240799371877264283@kernel.org>
In-Reply-To: <20261011052006.60585-1-jain.sm@gmail.com>
References: <20261011052006.60585-1-jain.sm@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new check in tcp_set_rcvbuf() (net/ipv4/tcp.c:1864) uses
  sk_state to decide whether the window clamp has been chosen yet.
- [Medium] The connect error path in tcp_v4_connect() and
  tcp_v6_connect() puts the socket back in TCP_CLOSE but does not clear…

--

tcp: keep the route window metric when SO_RCVBUF is set before connect

This patch makes tcp_set_rcvbuf() skip the window_clamp update for
sockets in TCP_CLOSE and TCP_LISTEN. tcp_connect_init() and
tcp_openreq_init_rwin() only read the route's RTAX_WINDOW metric when
window_clamp is zero, so skipping the update keeps that metric in effect.

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 87ef6d5cbfeba..9b6f2144119d1 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1856,6 +1856,14 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
>  
>  void tcp_set_rcvbuf(struct sock *sk, int val)
>  {
> +	/* Without a connection there is no clamp to update: it is chosen
> +	 * from the route's window metric and the buffer size when the
> +	 * connection is set up, see tcp_connect_init() and
> +	 * tcp_openreq_init_rwin().
> +	 */
> +	if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
> +		return;

[Severity: High]
Is sk_state a reliable way to tell whether tcp_connect_init() has run
yet? A socket can already be in TCP_SYN_SENT before the clamp is chosen.

net/ipv4/tcp_ipv4.c:tcp_v4_connect() {
    ...
	tcp_set_state(sk, TCP_SYN_SENT);
    ...
	if (tcp_fastopen_defer_connect(sk, &err))
		return err;
    ...
	err = tcp_connect(sk);
    ...
}

tcp_v6_connect() follows the same order. If SO_RCVBUF is set in that
window, tcp_set_rcvbuf() still writes a non-zero clamp. tcp_connect_init()
then skips the metric:

	if (!tp->window_clamp)
		WRITE_ONCE(tp->window_clamp, dst_metric(dst, RTAX_WINDOW));

There seem to be two ways to reach this.

The first is deferred Fast Open. With TCP_FASTOPEN_CONNECT and a cached
cookie, connect() returns to userspace with DEFER_CONNECT set and the
socket in SYN_SENT. A setsockopt(SO_RCVBUF) at that point goes through
sk_setsockopt()->__sock_set_rcvbuf()->tcp_set_rcvbuf() and sets the
clamp. The first write() then runs
tcp_sendmsg_fastopen()->tcp_connect()->tcp_connect_init(), and the
metric is ignored.

The second is BPF sockops. tcp_connect() runs the callback before
tcp_connect_init():

	tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_CONNECT_CB, 0, NULL);
	...
	tcp_connect_init(sk);

sol_socket_sockopt() in net/core/filter.c allows SO_RCVBUF. The in-tree
samples samples/bpf/tcp_bufs_kern.c, tcp_clamp_kern.c and tcp_iw_kern.c
all set SO_RCVBUF from BPF_SOCK_OPS_TCP_CONNECT_CB.

Before b025461303d8 neither path wrote window_clamp, so the "ip route
... window N" metric was honoured. With this patch both paths still
lose it.

Should SYN_SENT before tcp_connect_init() also be covered, so the code
matches what the new comment describes?

[Severity: Medium]
Can the TCP_CLOSE early return keep a stale clamp left by a failed
connect attempt?

tcp_connect() calls tcp_connect_init(), which sets window_clamp. It can
still fail after that:

	tcp_connect_init(sk);
	...
	buff = tcp_stream_alloc_skb(sk, sk->sk_allocation, true);
	if (unlikely(!buff))
		return -ENOBUFS;

The failure label in tcp_v4_connect() puts the socket back in TCP_CLOSE.
So does late_failure in tcp_v6_connect(). Neither one resets
tp->window_clamp.

__inet_stream_connect() returns the error without calling ->disconnect,
so the reset in tcp_disconnect() never runs. The socket stays
SS_UNCONNECTED, and connect() can be called again.

Suppose SO_RCVBUF is raised between the two attempts. The new check
returns early and keeps the old, smaller clamp. Before this patch the
clamp would have been replaced with tcp_win_from_space() of the new
buffer size.

On the retry, tcp_connect_init() keeps the stale value. Because it is
non-zero, the metric is skipped. Because it is smaller than
tcp_full_space(), the SOCK_RCVBUF_LOCK branch leaves it alone:

	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
	    (tp->window_clamp > tcp_full_space(sk) || tp->window_clamp == 0))
		WRITE_ONCE(tp->window_clamp, tcp_full_space(sk));

tcp_select_initial_window() then limits rcv_wnd and rcv_wscale by the
old clamp. That limit stays for the whole connection.

Triggering this requires the SYN skb allocation to fail, for example
under memory pressure or with a restrictive sk_allocation, and then a
retry on the same socket. The behaviour matches what existed before
b025461303d8. Compared with the parent commit, though, this looks like
a regression for the retry case.

>  	tcp_set_window_clamp(sk, tcp_win_from_space(sk, val));
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011052006.60585-1-jain.sm%40gmail.com
