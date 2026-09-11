Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E54C3E9C33;
	Fri, 11 Sep 2026 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095620; cv=none; b=cZ7u6DQY6UI3Q1bIVQv6mNGvXHWuRjLp5e3+vd2mLyZmeI8r/rO6lUEaba5x647y/WVHyTIXOp845XJyW/+wZZT4/nFlS35By3f7g2GibAQb/ZIv8ELJkvFvdf30ioCwtgbjE8uljTKhO6ablTIpskGwpU+ylgu6QzBRrQ3Ry1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095620; c=relaxed/simple;
	bh=J6mTqdfgS7B/8Fdde3gl134iuRkFJ2ocPd05rdeyR6E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GBAGxB9A6Gd6bHSBF8sIcMOF89nCodYldsXCL9LH89v6+VRLwsE//5yyYzG32Vo9PzhIKJBBHyKJBR9hbv4S7CMW0MuEoVvTrK4bD/Q+Whn6Sb/fcKW8joIuR/9fzSEYeRgx2qiRY/b2KHiSQW+FdTnvV2OK29X8e9AQVz2WduI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX6Xd/x9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX6Xd/x9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AD71F000FF;
	Fri, 11 Sep 2026 03:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789095618;
	bh=/cgl8DAJ++n4m0tHhdvPQtZmhWWV/ODnx7jCnfSy9pE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MX6Xd/x9bFmk8GrgvbgXY2XYDdu3Y7e1QSaZvBbk3mdcdQ7XCCEZdy8ORgoOn1n5d
	 YNpsNCU72rIQj2/ZBKbvhMeWqnpSKOK1rxc3hzR9obBu4k4lviek4MZ8wmkR147rET
	 7YnsjPrMeQfFcyfLcYiobunjRr4EmzhFX9dBWrbh9ZANkh6VxXrKYNWQnkJ7FizgxV
	 98K3coEZlWUqHGnAYh7i9fM4G/jHkzaxo3GZntp0dlQTyM+n2mUV4U4x4DVj8FoGPq
	 RIVCquQ9RaaGuJ1CH6igIvHAwoKbQWaIDZUTjST/YYnxyAUHbgLA9SrbxkcWXFk+gX
	 Mm/B5XUC8Jemw==
Subject: Re: [PATCH net] tcp: fix data-race in tcp_recv_should_stop
From: netdev-bot+sashiko@kernel.org
To: quanyeyang@proton.me
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 matttbe@kernel.org, geliang@kernel.org, martineau@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 03:00:17 +0000
Message-ID: <178909561770.219967.14152174482046052505@kernel.org>
In-Reply-To: <20260908-mptcp-sk-err-net-v1-1-da71aaec9afd@proton.me>
References: <20260908-mptcp-sk-err-net-v1-1-da71aaec9afd@proton.me>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] Incomplete data-race fix: only the sk_err load inside
  tcp_recv_should_stop() is annotated, while every caller of the helper…

--

tcp: fix data-race in tcp_recv_should_stop

This converts the sk_err load in the tcp_recv_should_stop() helper to
READ_ONCE(), since do_recvmmsg() calls sock_error() without the socket
lock and clears sk_err with xchg(). A KCSAN report on an MPTCP socket
is quoted in the changelog.

Link: https://lore.kernel.org/all/14749060-d011-41e7-9a4b-754eb5bd9d5b@redhat.com/

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 436495ff2271d..c61d8678eafd3 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -3082,7 +3082,8 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
>  
>  static inline int tcp_recv_should_stop(struct sock *sk)
>  {
> -	return sk->sk_err ||
> +	/* sk_err can be cleared locklessly by sock_error(). */
> +	return READ_ONCE(sk->sk_err) ||
>  	       sk->sk_state == TCP_CLOSE ||
>  	       (sk->sk_shutdown & RCV_SHUTDOWN) ||
>  	       signal_pending(current);

[Severity: High]
Does annotating only the helper close the race the changelog describes?
Every caller of tcp_recv_should_stop() still has a plain load of the same
field in the same wait loop, a few lines below the helper call.

net/mptcp/protocol.c:mptcp_recvmsg() - the function named in the quoted
report:

	if (copied) {
		if (tcp_recv_should_stop(sk) ||
		    !timeo)
			break;
	} else {
		if (sk->sk_err) {
			copied = sock_error(sk);
			break;
		}

net/ipv4/tcp.c:tcp_recvmsg_locked() has the identical pair:

		if (copied) {
			if (!timeo ||
			    tcp_recv_should_stop(sk))
				break;
		} else {
			if (sock_flag(sk, SOCK_DONE))
				break;

			if (sk->sk_err) {
				copied = sock_error(sk);
				break;
			}

The same unmarked load also remains in tcp_splice_read() and in
mptcp_splice_read(), which are the other two callers of the helper.

The racing writer is unchanged in all four cases:

net/socket.c:do_recvmmsg() {
	...
	if (likely(!(flags & MSG_ERRQUEUE))) {
		err = sock_error(sock->sk);
	...
}

which runs with no socket lock and does xchg(&sk->sk_err, 0) in
sock_error(). So a thread in recvmsg() on the copied == 0 path and a
second thread in recvmmsg() on the same socket still produce the marked
read-write versus unmarked read pair, and the splat looks like it would
just be re-reported from mptcp_recvmsg() and tcp_recvmsg_locked()
directly instead of from the inlined helper.

Would it make sense to convert those four sibling loads to READ_ONCE()
in the same patch?

The changelog only mentions the leftover problem as:

    This does not consume sk_err; the check-then-sock_error() TOCTOU
    on the no-data paths is a separate issue.

That describes a semantic check-then-act concern, which is distinct from
the plain concurrent load. Could the changelog say explicitly which
sk_err loads remain unmarked after this change?

Converting the sibling reads would also make the change applicable to
trees that predate the Fixes: eb477fdd6803 helper, where only those reads
exist.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-mptcp-sk-err-net-v1-1-da71aaec9afd%40proton.me
