Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B023905EC;
	Mon, 21 Sep 2026 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999818; cv=none; b=T/YA+wT+oFO4rCdYda2JYFQsdCEsxjSTgCTj5hziNVmAFxbP89b1egw1d7fC+8Dv23F8xTiGMF91EeY5uIO/N/YuMOLHI+Qi/GdYVIr3YSxsI5wuIlGI02sOy6hS77oPw5cGKYCFTI3Fijr6m3Bel3fIcolbzn59u9qkYyl5ld8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999818; c=relaxed/simple;
	bh=Q1s7yRBzLky6QTkAiCNCOrjP7ZRnEa+zJhfm/ZYb0R8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sC0D/mdAJvN1csrGAc//2qFaUkNu6WtB01DkTGwWDYecFil95cb8922El8279ChQr+F5oXwuy6mOJA+9a5rT+e3q/n4ZoUD3auqV2xZLX3J+z5ybMUCYD0rXRK3AkvXMq2yuWl4yptC6xdtIpfzX2ElJvsrpGf0ULZmOpvljrxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pr175d57; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pr175d57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826AA1F000FF;
	Mon, 21 Sep 2026 14:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789999816;
	bh=wwLKBbFNELL1uaqVUkS4iLSEWnb4HQ8FbjsIKKudu9g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Pr175d57SPVGwkxnZJYKydqY1XB6SSJ5RpVObj5REEZ1Ym1qaSRJTEeRtPuJGRbaQ
	 dpYE3gzqT0p7CqBneAiLsb4xL1qY2vcb6mRYx30D7OdjlU8JUHhuKXIm2M2HzH4Sxh
	 k3iOR5KxT5vHuaM90/Lv0r0bVVIAUi2AiyEHzi21/32oFD2bMDM2ULjFIPDbDaRyeh
	 NjEC0jbQtlsiicHFMNSxfx1HzqDvLLdZtvGYzdLzkxdrwQI8tv+j2TZdC+CrsLufZw
	 jBJ9t2rHZWW2uQlk6CH2aajnAOpz3tHxAcMryDgVfiy691dsTtXQjtBpWV4DD9jCcy
	 boeFFtzp4Tl7A==
Subject:
 Re: [PATCH net-next v4 1/2] tcp: annotate lockless access to sk->sk_err
From: netdev-bot+sashiko@kernel.org
To: quanyeyang@proton.me
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 matttbe@kernel.org, geliang@kernel.org, martineau@kernel.org,
 jiayuan.chen@linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2026 14:10:15 +0000
Message-ID: <178999981507.2160803.15037788484628952910@kernel.org>
In-Reply-To: <20260917-mptcp-sk-err-net-v4-1-1f04f52f2561@proton.me>
References: <20260917-mptcp-sk-err-net-v4-1-1f04f52f2561@proton.me>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Commit message does not describe the tcp_bpf_sendmsg() hunk.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the
  annotated peeks are still followed by a second, independent read of…
- [Medium] This problem wasn't introduced by this patch, but
  tcp_bpf_sendmsg() (net/ipv4/tcp_bpf.c) discards a failed iterator-copy…

--

tcp: annotate lockless access to sk->sk_err

This annotates the plain sk->sk_err loads on the TCP send, receive and
splice paths with READ_ONCE(), since sock_error() clears sk_err with
xchg() from do_recvmmsg() and getsockopt(SO_ERROR) without holding the
socket lock. The tcp_bpf_sendmsg() site is also restructured while the
other sites are annotated in place.

Link: https://lore.kernel.org/netdev/8bbee583-6f21-4817-bfeb-2d60057380a3@linux.dev/
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/632

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 1c867a3024446..9e7fa7e397265 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -843,7 +843,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
>  				break;
>  			if (sock_flag(sk, SOCK_DONE))
>  				break;
> -			if (sk->sk_err) {
> +			if (READ_ONCE(sk->sk_err)) {
>  				ret = sock_error(sk);
>  				break;
>  			}

[ ... ]

> @@ -2760,7 +2760,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
>  			if (sock_flag(sk, SOCK_DONE))
>  				break;
>  
> -			if (sk->sk_err) {
> +			if (READ_ONCE(sk->sk_err)) {
>  				copied = sock_error(sk);
>  				break;
>  			}

[Severity: Medium]
This isn't a bug introduced by this patch, but the annotated peek is
still followed by a second, independent read of sk_err inside
sock_error(), so the value can be gone by the time it is consumed.

include/net/sock.h:sock_error() {
	if (likely(data_race(!sk->sk_err)))
		return 0;

	err = xchg(&sk->sk_err, 0);
	return -err;
}

sock_error() is reachable without the socket lock from do_recvmmsg() and
from getsockopt(SO_ERROR), which is the same writer named in the splat:

CPU0 (socket lock held, tcp_recvmsg_locked())
	if (READ_ONCE(sk->sk_err))	/* sees 0x6b, enters branch */

CPU1 (no socket lock, do_recvmmsg() -> sock_error())
	err = xchg(&sk->sk_err, 0);	/* consumes the error */

CPU0 continues:
		copied = sock_error(sk);	/* now returns 0 */
		break;

Since the break is unconditional, does recvmsg() then return 0 rather
than falling through to the RCV_SHUTDOWN / TCP_CLOSE / !timeo / signal
checks?  For a nonblocking receive on an open, empty socket the expected
result would be -EAGAIN, and userspace reads 0 as an orderly shutdown.

The same shape exists in tcp_splice_read(), where ret = sock_error(sk)
followed by "if (spliced) return spliced; return ret;" returns 0, and in
tcp_bpf_recvmsg_parser(), where copied = sock_error(sk) is followed by
goto out.

The changelog does say "the check-then-sock_error() TOCTOU on the
no-data paths is a separate issue".  Would consuming the value once
(copied = sock_error(sk); if (copied) break;) close both the data race
and this window in one step?

One related note: once these loads are marked, KCSAN will no longer
report these sites, so the signal that produced this report goes away
while the check-then-consume window stays.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 2e234d155b5e6..a96323e65758e 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -286,7 +286,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  		if (sock_flag(sk, SOCK_DONE))
>  			goto out;
>  
> -		if (sk->sk_err) {
> +		if (READ_ONCE(sk->sk_err)) {
>  			copied = sock_error(sk);
>  			goto out;
>  		}
> @@ -553,10 +553,9 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  		bool enospc = false;
>  		u32 copy, osize;
>  
> -		if (sk->sk_err) {
> -			err = -sk->sk_err;
> +		err = -READ_ONCE(sk->sk_err);
> +		if (err)
>  			goto out_err;
> -		}

[Severity: Medium]
Could the changelog cover this hunk?  It describes the patch as a pure
annotation:

  "Annotate those peeks with READ_ONCE(). No extra ordering is needed:
   the value is only used to decide whether I/O should stop. This does
   not consume sk_err"

In tcp_bpf_sendmsg() the value is not only used to decide whether I/O
stops, it becomes the errno handed back to userspace:

net/ipv4/tcp_bpf.c:tcp_bpf_sendmsg() {
	...
out_err:
	if (err < 0)
		err = sk_stream_error(sk, msg->msg_flags, err);
	release_sock(sk);
	sk_psock_put(sk, psock);
	return copied > 0 ? copied : err;
}

The rewrite also looks like it changes behaviour beyond annotation.  The
old form read sk->sk_err twice:

		if (sk->sk_err) {
			err = -sk->sk_err;

If the lockless sock_error() consumer cleared sk_err between those two
reads, err became 0 while control still jumped to out_err, where
"if (err < 0)" is false and the function returned
"copied > 0 ? copied : 0", i.e. a zero-byte success instead of the
pending error.  The new single READ_ONCE() closes that.  Should this be
called out in the changelog, with a Fixes: tag, or split into its own
patch so the remaining five hunks stay mechanical?

Also, err is now assigned on every loop iteration rather than only when
sk_err is set.  Every later use of err in the loop is preceded by its
own assignment from sk_msg_alloc(), tcp_bpf_send_verdict() or
sk_stream_wait_memory(), so this looks behaviour preserving, but it is
unexplained restructuring in an annotation-only patch.

[Severity: Medium]
This is a pre-existing issue, but while looking at the same loop in
tcp_bpf_sendmsg(): can a failed copy from the user buffer be reported as
a zero-byte send?

The copy result goes into ret, not err, and out_err returns err:

net/ipv4/tcp_bpf.c:tcp_bpf_sendmsg() {
	...
		err = sk_msg_alloc(sk, msg_tx, msg_tx->sg.size + copy, msg_tx->sg.end - 1);
		if (err) {
			if (err != -ENOSPC)
				goto wait_for_memory;
			enospc = true;
			copy = msg_tx->sg.size - osize;
		}

		ret = sk_msg_memcopy_from_iter(sk, &msg->msg_iter, msg_tx,
					       copy);
		if (ret < 0) {
			sk_msg_trim(sk, msg_tx, osize);
			goto out_err;
		}
	...
}

sk_msg_memcopy_from_iter() returns -EFAULT on a short copy:

net/core/skmsg.c:sk_msg_memcopy_from_iter() {
	...
		if (ret != copy) {
			ret = -EFAULT;
			goto out;
		}
	...
}

On the first iteration a successful sk_msg_alloc() leaves err == 0, so
out_err skips sk_stream_error() and, with copied == 0, sendmsg() returns
0 rather than -EFAULT.  If sk_msg_alloc() had returned the tolerated
-ENOSPC, the stale -ENOSPC is reported instead of the copy failure.
Would "err = ret;" before the goto preserve the real failure?

Reproducing this needs a sockmap/psock attached to the socket, then a
sendmsg() with a partially unmapped user buffer.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917-mptcp-sk-err-net-v4-0-1f04f52f2561%40proton.me
