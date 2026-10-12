Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6773ACA64;
	Mon, 12 Oct 2026 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803903; cv=none; b=jDbpVjqHcSpOzXamOJuzI4JM0bh4FngLq2vDaPEoIQpBcqMSrG1KiFN+KFtUdIV/umLNfDpw6F5oK3fkRFqrlwh6Ujxkts5ulyv5+76seG3mi/SlE2E1Ivr9DC/KQfpv3Rk1SGZg2ETNBX01Hs74M/xjpwKVFr7BDjNAjgZ1a5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803903; c=relaxed/simple;
	bh=LQf0qk4sV6UDVR7RukePLilxROge+43Oc2FIzBgx+i0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CH7YV7fpDmlJ4pGL5Z4flVOfVTcJ2OQEHqTkrXYmyNxP98E8pZ6xc+Wi7NA3S7z4BNVyfIF8mkz04lJriAXaBDp7XGvMUC4ErpQ6RIIUyLKvNyTQ4toOKvprvKAIXdKqDEIKwAO2J51rAZr1v/gHTI0LNoT4hLL24K3QTBpV6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErmAX66L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErmAX66L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029491F0089B;
	Mon, 12 Oct 2026 11:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791803901;
	bh=qERazqb8eyeXYj8ho8FOKcuAMRROCm/gPcydjpaESMU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ErmAX66LB/nMEV8t/vdKHp/n3oavbzTQvU1QCCOrJ0AWPzl+v+JrphP1B9zfOJ8FZ
	 YRRK2j7y63Q2GHrQkwW4ZVYxOi2P7jQEUURI6YkxmWglYJlKjscvdZM+7h4VfiZax1
	 qaD/XsBK4qDWBbKbYsIA2S796yadcZa8WhieXWUYwcvPyZkPVyNI6/VLsgWHJlAOQI
	 yCh45CoBQfLQxjzqzWbOyKwQ8JM05rDjz239qZDiUjNB2P9b7x/hsjyV6wD1EvJT4R
	 7riWw/aKQkWohGUBudOYh7onFsZl5kN87PFdgAbtj5CGUQ4cCJ5O+VGBYz8pSVicDU
	 XFyXjwj5yYsEA==
Subject: Re: [PATCH net-next 1/2] tcp: don't set window_clamp from SO_RCVBUF
 before the socket is connected
From: netdev-bot+sashiko@kernel.org
To: jain.sm@gmail.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 11:18:20 +0000
Message-ID: <179180390054.434549.3187163637190599944@kernel.org>
In-Reply-To: <20261011111606.14753-2-jain.sm@gmail.com>
References: <20261011111606.14753-2-jain.sm@gmail.com>
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

- [High] The fix is incomplete.
- [Medium] The commit message misstates and overstates the impact.

--

tcp: don't set window_clamp from SO_RCVBUF before the socket is connected

This patch makes tcp_set_rcvbuf() skip the window_clamp update while the
socket is in TCP_CLOSE or TCP_LISTEN. The aim is to stop a clamp derived
from SO_RCVBUF from overriding the RTAX_WINDOW route metric in
tcp_connect_init() and tcp_openreq_init_rwin().

> tcp_connect_init() and tcp_openreq_init_rwin() treat a non-zero
> window_clamp as a user clamp and, in that case, skip the route window
> metric (RTAX_WINDOW, "ip route ... window N"). A clamp left behind by an
> SO_RCVBUF call made before connect(), or on a listener, therefore
> changes the window and window scale advertised in the SYN and SYN-ACK:
> the route metric is no longer applied, and even without a route metric
> the advertised window and scale come from SO_RCVBUF instead of the
> defaults. This affects any application that sets SO_RCVBUF before
> connect() or listen(), which is more common than using the route metric.

[Severity: Medium]
Is the part about the case without a route metric accurate?

__sock_set_rcvbuf() always sets SOCK_RCVBUF_LOCK and then calls
tcp_set_rcvbuf(sk, sk->sk_rcvbuf). On the old kernel, the clamp left
behind is therefore tcp_win_from_space(sk, sk_rcvbuf), which equals
tcp_full_space(), or SOCK_MIN_RCVBUF / 2 if that is larger.
scaling_ratio cannot change before connect.

With no RTAX_WINDOW metric, the patched kernel sees window_clamp == 0 and
reads a zero metric. Then this block runs:

net/ipv4/tcp_output.c:tcp_connect_init() {
    ...
	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
	    (tp->window_clamp > tcp_full_space(sk) || tp->window_clamp == 0))
		WRITE_ONCE(tp->window_clamp, tcp_full_space(sk));
    ...
}

The old kernel reaches the same tcp_full_space() value through the
"window_clamp > tcp_full_space(sk)" branch. tcp_openreq_init_rwin() does
the same for req->rsk_window_clamp.

Wouldn't both kernels then pass the same window_clamp to
tcp_select_initial_window(), and advertise the same window and wscale in
the SYN and SYN-ACK?

If so, the visible change is limited to two cases:

- routes with an RTAX_WINDOW metric
- TCP_WINDOW_CLAMP followed by SO_RCVBUF on an unconnected socket or
  listener, where SO_RCVBUF no longer overwrites the clamp

The message does not mention the second case. Neither case is "any
application that sets SO_RCVBUF before connect() or listen()".

The message also seems to contradict itself further down:

> The "after" values match a kernel with b025461303d8 reverted; with no
> route metric the SYN window and scale are the defaults in both cases.

In both cases, wouldn't the values come from SO_RCVBUF via
tcp_full_space() rather than from the defaults?

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index f4c9101e5996..e523cb71b905 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1858,6 +1858,14 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
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
Does this check cover every case where SO_RCVBUF is applied before
tcp_connect_init() runs?

tcp_v4_connect() and tcp_v6_connect() switch the socket to TCP_SYN_SENT
before tcp_connect()->tcp_connect_init(). A clamp written in that gap
still passes this check, and there seem to be two ways to get there.

The first is TCP_FASTOPEN_CONNECT with a cached cookie, where connect()
returns early:

net/ipv4/tcp_ipv4.c:tcp_v4_connect() {
    ...
	tcp_set_state(sk, TCP_SYN_SENT);
    ...
	if (tcp_fastopen_defer_connect(sk, &err))
		return err;
    ...
}

If the application calls setsockopt(SO_RCVBUF) before its first write(),
tcp_set_rcvbuf() sees TCP_SYN_SENT and stores a non-zero window_clamp.
tcp_sendmsg_fastopen() later calls tcp_connect()->tcp_connect_init().

The second is a sock_ops BPF program. tcp_connect() runs the callback
before tcp_connect_init():

net/ipv4/tcp_output.c:tcp_connect() {
    ...
	tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_CONNECT_CB, 0, NULL);
    ...
	tcp_connect_init(sk);
    ...
}

sol_socket_sockopt() allows SO_RCVBUF for bpf_setsockopt(). That call
reaches __sock_set_rcvbuf()->tcp_set_rcvbuf() while the socket is in
TCP_SYN_SENT. samples/bpf/tcp_bufs_kern.c, tcp_clamp_kern.c and
tcp_iw_kern.c all use this pattern.

In both cases tcp_connect_init() then skips the route metric:

	if (!tp->window_clamp)
		WRITE_ONCE(tp->window_clamp, dst_metric(dst, RTAX_WINDOW));

The SOCK_RCVBUF_LOCK block afterwards can only lower the clamp to
tcp_full_space().

Doesn't that leave the b025461303d8 regression in place on these paths,
even though this patch carries the Fixes: tag for it? The selftest in this
series only covers SO_RCVBUF set before connect().

Would it work to base the check on whether tcp_connect_init() has run yet?
Another option would be to let tcp_connect_init() and
tcp_openreq_init_rwin() tell a TCP_WINDOW_CLAMP value apart from one
derived from sk_rcvbuf.

> +
>  	tcp_set_window_clamp(sk, tcp_win_from_space(sk, val));
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011111606.14753-1-jain.sm%40gmail.com
