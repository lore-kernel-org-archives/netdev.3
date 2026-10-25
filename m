Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792946143;
	b=JYFRofWD8rGHJK2mCb4SkUife9U1if8pU6sHp+ufidWoIlwVjZiB+4kJcsUvZRqG4Oza
	 xzkuwp7141y0rzu9aYzpRffd4wAvjHgS5A+UT4VUgYhbex7gDPzt6oXwlQ7Z1KBxBQrBO
	 xXPlWKs3jQMlIF9v6c1Wx2iFNhuS1JbUUzEdd7gaI1Cp4jZdZzTPxbNfkAgJi6d2fuBjC
	 Bri6aQi6unUt2ONcoLnlrRGUxmLwRrr2Q4eKMolJe4zPGrZL5cnOHZy5geBl5aBUBbXVe
	 x9qigL+UZs3+aiyxWHhPbtIjuxdCt7z+aJg3m7RXBE8dje9g6lr7ZDPxHAB9uxrtadg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792946143;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bPmM7jPV12+A5yMCa9enXrOMHKwR1XmYaS6FdKIgNrk=;
	b=krjCnMgxCI+GWN0hXCrS3gIl6qcHI9c7+Jpinm2VCx5aq0WVIPBj2/Rue2qG4+62BjwZ
	 fSUcmxc4QIguM8GFxN90Y0/9dOhz1ylZFmIK2mlPkxnaoUj5uqPmcbPRuBF3eDr9+5FRy
	 tV35bTr245tyyIqlDgYcfXxYQIC3Jm5oDe9LGhU/q+aLhEDZMZ/Y9ZdJZO98EkQc0ojVJ
	 dIhHjP3aICm2JRsGG3a6ZyLkG1LcbZBUfgvDKjDnOk+2k+Zu5PpcEy4mM+TbGeKmpNr5Z
	 96PeH+K4qt8wj9rlqYDsgBgY9b6Yh4OfB9MbDtz7DLQ8jmoN8Uaezyj+FsQnriL/kHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HXU/Tc7l";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43632606A31A;
	Sun, 25 Oct 2026 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXU/Tc7l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8971F01825;
	Sun, 25 Oct 2026 16:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792946142;
	bh=bPmM7jPV12+A5yMCa9enXrOMHKwR1XmYaS6FdKIgNrk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HXU/Tc7lRKLIMMtT0QgsC+2boygE949sSbn5B+2Ef9OW0gwIrIjdKbqe0Vjg/mQSd
	 MqIMA2NoOz8WW+9h4lyd7WaH0jQj1/IuLY6V3+FQfpZP5iH47EcjgCZGKOF21CT8kj
	 nJPikF/7GQnylYapA6YxXbDCrPhA0q2PXK5HLMQlTc1HZaVQw1b7GA+cnxZgVRhlqw
	 OZ0hEOj9PKTZHlJYfX+KAIzdwoNcW9IPOFgWON3STOfksTx9O+CGOiOIg0EWlJ7O4u
	 NXbYopt9UyTG1Dloo3+kWii89oQ/qnh+r2eT94iVNb37oHygQHDAA3mmf7y4QSGVMy
	 uZ4C+p+BVlPqA==
Subject: Re: [PATCH net-next v4 1/2] tcp: keep the route window metric when
 SO_RCVBUF is set before connect
From: netdev-bot+sashiko@kernel.org
To: jain.sm@gmail.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 16:35:41 +0000
Message-ID: <179294614147.3134.15330394649606203025@kernel.org>
In-Reply-To: <20261021155715.30094-2-jain.sm@gmail.com>
References: <20261021155715.30094-2-jain.sm@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] tcp: unordered lockless reads of window_clamp in
  tcp_req_window_clamp()
- [Low] The changelog says: "Without an RTAX_WINDOW metric and without
  TCP_WINDOW_CLAMP nothing changes".

Pre-existing issues:
- [Medium] The patch adds tp->window_clamp_user and comments that
  window_clamp "never goes above a clamp the user set with…

--

tcp: keep the route window metric when SO_RCVBUF is set before connect

This patch adds tp->window_clamp_user to record the clamp set with
TCP_WINDOW_CLAMP. tcp_connect_init(), tcp_openreq_init_rwin() and the SYN
cookie paths now use it, instead of any non-zero window_clamp, to decide
whether to apply the RTAX_WINDOW route metric. tcp_set_rcvbuf() now caps
window_clamp at the user's clamp.

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 99d7237a623d8..64465bc257d18 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1859,7 +1859,15 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
>  
>  void tcp_set_rcvbuf(struct sock *sk, int val)
>  {
> -	tcp_set_window_clamp(sk, tcp_win_from_space(sk, val));
> +	u32 user_clamp = tcp_sk(sk)->window_clamp_user;
> +	int win = tcp_win_from_space(sk, val);
> +
> +	/* window_clamp follows the receive buffer, but never goes above a
> +	 * clamp the user set with TCP_WINDOW_CLAMP.
> +	 */
> +	if (user_clamp)
> +		win = min_t(u32, win, user_clamp);
> +	tcp_set_window_clamp(sk, win);
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but the new comment says
window_clamp never goes above a clamp set with TCP_WINDOW_CLAMP. Only
tcp_set_rcvbuf() enforces that. The other writers of tp->window_clamp
still ignore window_clamp_user.

tcp_measure_rcv_mss() resets window_clamp from sk_rcvbuf every time
scaling_ratio changes, even with SOCK_RCVBUF_LOCK set:

net/ipv4/tcp_input.c:tcp_measure_rcv_mss() {
    ...
			if (old_ratio != tcp_sk(sk)->scaling_ratio) {
				struct tcp_sock *tp = tcp_sk(sk);

				val = tcp_win_from_space(sk, sk->sk_rcvbuf);
				WRITE_ONCE(tp->window_clamp, val);
    ...
}

tcp_rcvbuf_grow() raises it during DRS autotuning:

net/ipv4/tcp_input.c:tcp_rcvbuf_grow() {
    ...
		WRITE_ONCE(tp->window_clamp,
			   tcp_win_from_space(sk, rcvbuf));
    ...
}

tcp_set_rcvlowat() raises a non-zero clamp in any state, including
TCP_LISTEN:

net/ipv4/tcp.c:tcp_set_rcvlowat() {
    ...
		if (tp->window_clamp && tp->window_clamp < val)
			WRITE_ONCE(tp->window_clamp, val);
    ...
}

mptcp_set_rcvlowat() also writes the subflow window_clamp directly.

Take an established socket that sets TCP_WINDOW_CLAMP=X and then a large
SO_RCVBUF. window_clamp stays capped at X only until the next
scaling_ratio change, when tcp_measure_rcv_mss() sets it from the larger
sk_rcvbuf.

Is the changelog statement that SO_RCVBUF no longer grows window_clamp
"above a clamp set with TCP_WINDOW_CLAMP" accurate beyond that short
window?

Now take a listener that sets TCP_WINDOW_CLAMP=X and then SO_RCVLOWAT=Y,
with Y > X and the rcvbuf not locked. This leaves window_clamp=Y and
window_clamp_user=X. tcp_req_window_clamp() then gives Y to request
sockets and SYN cookies as if it were the user's clamp:

	if (READ_ONCE(tp->window_clamp_user))
		return READ_ONCE(tp->window_clamp);

The same things happened before this patch, so this is not a
regression. Should these writers also be capped at window_clamp_user? If
not, could the new comment and the changelog be reworded to cover only
the tcp_set_rcvbuf() path?

[ ... ]

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index c8865205cdc8b..21b4ae303dd63 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -4137,7 +4137,7 @@ static void tcp_connect_init(struct sock *sk)
>  
>  	tcp_ca_dst_init(sk, dst);
>  
> -	if (!tp->window_clamp)
> +	if (!tp->window_clamp_user)
>  		WRITE_ONCE(tp->window_clamp, dst_metric(dst, RTAX_WINDOW));
>  	tp->advmss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));

[Severity: Low]
The changelog says:

  Without an RTAX_WINDOW metric and without TCP_WINDOW_CLAMP nothing
  changes: before and after this patch the advertised window and scale
  are derived from sk_rcvbuf (tcp_full_space()).

Does that hold for MPTCP subflows? mptcp_set_rcvlowat() writes the
subflow window_clamp directly and never sets window_clamp_user:

net/mptcp/sockopt.c:mptcp_set_rcvlowat() {
    ...
	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
		...
		WRITE_ONCE(ssk->sk_rcvbuf, space);
		WRITE_ONCE(tcp_sk(ssk)->window_clamp, val);
    ...
}

__mptcp_socket_create() adds msk->first to conn_list as soon as it is
created. That happens on bind(), on listen(), or on any setsockopt that
goes through __mptcp_nmpc_sk(). So SO_RCVLOWAT can reach a subflow that
is still in TCP_CLOSE, or the listener subflow. The write happens when
the rcvbuf is not locked and mptcp_space_from_win(val) > sk_rcvbuf.

Before this patch, and before b025461303d8, that non-zero value was kept
as the clamp. tcp_connect_init() checked "if (!tp->window_clamp)" and
tcp_openreq_init_rwin() used "window_clamp ? : dst_metric(...)".
tcp_select_initial_window() then derived rcv_wscale from it, and the
final window_clamp was capped at val.

After this patch, window_clamp_user is 0 on these subflows.
tcp_connect_init() overwrites window_clamp with
dst_metric(dst, RTAX_WINDOW), which is usually 0, and
tcp_req_window_clamp() ignores the listener subflow's clamp.

With default sysctls and val=1MB, the wscale in the SYN/SYN-ACK seems to
go from about 5 to about 7. The initial window_clamp is also no longer
limited to val.

The new behaviour matches plain TCP, because tcp_set_rcvlowat() only
raises a window_clamp that is already non-zero. This patch has a Fixes:
tag, and this MPTCP change goes back further than b025461303d8. Could
the changelog mention it?

[ ... ]

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1879,6 +1879,20 @@ extern void tcp_openreq_init_rwin(struct request_sock *req,
>  				  const struct sock *sk_listener,
>  				  const struct dst_entry *dst);
>  
> +/* Window clamp for a request socket of listener @tp: the listener's clamp
> + * if the user set one with TCP_WINDOW_CLAMP, else the route window metric.
> + * The SYN-ACK and the SYN cookie paths must make the same choice, or the
> + * child's window scale would not match the one sent in the SYN-ACK.
> + * The listener is not locked here.
> + */
> +static inline u32 tcp_req_window_clamp(const struct tcp_sock *tp,
> +				       const struct dst_entry *dst)
> +{
> +	if (READ_ONCE(tp->window_clamp_user))
> +		return READ_ONCE(tp->window_clamp);
> +	return dst_metric(dst, RTAX_WINDOW);
> +}
> +
>  void tcp_enter_memory_pressure(struct sock *sk);
>  void tcp_leave_memory_pressure(struct sock *sk);
>  

[Severity: Medium]
tcp_req_window_clamp() runs on the listener without the socket lock,
from tcp_openreq_init_rwin() and from cookie_v4_check() and
cookie_v6_check(). It loads window_clamp_user and then window_clamp.
Nothing orders those two loads against the two stores that
setsockopt(TCP_WINDOW_CLAMP) does on the listener.

In do_tcp_setsockopt(), tcp_set_window_clamp() stores the new
window_clamp first, and window_clamp_user is written afterwards with
WRITE_ONCE(). READ_ONCE() and WRITE_ONCE() prevent tearing. They do not
order the two fields against each other. On a weakly ordered
architecture, a SYN handled at the same time on another CPU can see the
new, non-zero window_clamp_user together with the old window_clamp.

If SO_RCVBUF was never set on the listener, the old window_clamp is 0.
tcp_req_window_clamp() then returns 0. Unless SOCK_RCVBUF_LOCK is set,
tcp_select_initial_window() treats a 0 clamp as no clamp at all, so the
request gets neither the user's clamp nor the RTAX_WINDOW metric. If
SO_RCVBUF was set earlier, the reader can instead pick up the old,
larger window_clamp derived from SO_RCVBUF in place of the user's clamp.
The SYN-ACK and the cookie ACK make this choice at different times, so
they can end up with different rcv_wscale values. Avoiding that mismatch
is the point of the new helper.

tcp_disconnect() has the same problem in reverse. It zeroes
window_clamp with a plain store and only then clears window_clamp_user.
A reader that already passed the TCP_LISTEN check can see the old
window_clamp_user and window_clamp == 0. The plain store was there
before this patch. Should it become WRITE_ONCE() now that
tcp_req_window_clamp() reads the field locklessly?

The window is narrow, because it needs a setsockopt() or a disconnect
on a live listener while SYNs arrive. Still, the changelog presents
READ_ONCE()/WRITE_ONCE() as what makes the unlocked listener path safe.

Pairing smp_store_release() on window_clamp_user with smp_load_acquire()
in tcp_req_window_clamp() would cover the setsockopt case. It would not
cover tcp_disconnect(), where the reader can still see the newer
window_clamp of 0. Would it be simpler to make the result robust to a
stale or zero window_clamp? For example, return window_clamp_user
itself, or the minimum of the two with a fallback to window_clamp_user
when window_clamp reads 0. Or is there a reason the listener's
window_clamp has to be used here rather than the stored user value?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021155715.30094-1-jain.sm%40gmail.com
