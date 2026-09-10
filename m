Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22F813FEE;
	Thu, 10 Sep 2026 02:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789008985; cv=none; b=EJbu3EP5f2mhiMV8yn4hwnYESR+lZ+5tlmxL/FvBIdku1fZHjFNQmfrHXWI5ibXGzUlMcwhajH+UI7LZQxX4AiWGK7b1NcrUG282UHOMzfxImVW9Y5VfNKQXs+hyb+zctL8d2Bg1rL6s63AyF7IADy0mX3lchz/5EV3Hg5tc/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789008985; c=relaxed/simple;
	bh=GktVKQnEbT9KW8UaajJfm1ICJhdLsgwAgF2qytpdsP8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PKQ+8Oi1l0RJNYapnzW219XdiI/bpORwVVTQG+GP6lcgPgN1lC3pCmqSLRYNLND3AxOeyCOMdSv4UASmaiyaBATG2IVQKPd0SQdZKoHf+FTOZBOPpjwMOnBvHvlqX2yQU0H6E4F+sbyiUJK35iyiKWADwR2ncpkvvHrZ5/hDz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMIBxMc8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMIBxMc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224061F000FF;
	Thu, 10 Sep 2026 02:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789008983;
	bh=KI65WBUh40jbbVotgEpM8eZaw1mpVin9nwHnJbG1n4k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iMIBxMc8W/3W5GSN0ZT47y5D5hmSOEhiUnsARpnpoLZuiy3Ot9o//QgCM0J5fZXKg
	 Kjc2DgsluVKpP20Rd8jsfihQXSeawdbchc/kWq+lIqT1M7fD79lZVHgvGxkSrQJhop
	 4WXTonvMQ46q0VyxnLLqvCriky3kO1bkPBl1Etq2E0ZQOaPJn5LWvUtFHx1AEQfMZf
	 ERRPBMPYTaoOPzyuon8r01XLI6VifHJK02GNIFGW9QfPlKDnDRwabRWlokeudip1ra
	 ELGqVaiTAPAQRNKCfFOk1YskLb8rKxkz/czE0xtbYqLXoJ1g688jZsUGV0IYzhN1Ev
	 FDwJXi8coDdqg==
Subject: Re: [PATCH net v2] tcp: fix data-race in tcp_recv_should_stop
From: netdev-bot+sashiko@kernel.org
To: quanyeyang@proton.me
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 matttbe@kernel.org, geliang@kernel.org, martineau@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 02:56:22 +0000
Message-ID: <178900898267.219967.2865361878538179994@kernel.org>
In-Reply-To: <20260909-mptcp-sk-err-net-v2-1-5044abecac90@proton.me>
References: <20260909-mptcp-sk-err-net-v2-1-5044abecac90@proton.me>
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

- [High] Incomplete data-race fix: the patch converts only the sk_err
  load inside tcp_recv_should_stop() (include/net/tcp.h:3086) to…

--

tcp: fix data-race in tcp_recv_should_stop

This converts the sk_err load inside tcp_recv_should_stop() to READ_ONCE()
because do_recvmmsg() calls sock_error() without the socket lock and
sock_error() clears sk_err with xchg(). It carries a Fixes: tag for
eb477fdd6803 and a Closes: tag for the MPTCP syzkaller report.

Link: https://lore.kernel.org/all/14749060-d011-41e7-9a4b-754eb5bd9d5b@redhat.com/

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 436495ff2271..c61d8678eafd 100644
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
Is annotating only this read enough to close the reported race?

Every caller of tcp_recv_should_stop() keeps a plain read of the same
field in the other arm of the very same loop.  In mptcp_recvmsg(), the
function named in the KCSAN splat:

net/mptcp/protocol.c:mptcp_recvmsg() {
	...
		if (copied) {
			if (tcp_recv_should_stop(sk) ||
			    !timeo)
				break;
		} else {
			if (sk->sk_err) {
				copied = sock_error(sk);
				break;
			}
	...
}

The same shape exists in tcp_recvmsg_locked():

net/ipv4/tcp.c:tcp_recvmsg_locked() {
	...
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
	...
}

and in tcp_splice_read() and mptcp_splice_read(), whose loops both end
with the now-annotated helper:

net/ipv4/tcp.c:tcp_splice_read() {
	...
			if (sk->sk_err) {
				ret = sock_error(sk);
				break;
			}
	...
		if (tcp_recv_should_stop(sk))
			break;
	...
}

The writer described in the changelog, do_recvmmsg() calling
sock_error(sock->sk) with no lock_sock() and clearing the field with
xchg(&sk->sk_err, 0), races with those four plain reads exactly as it
raced with the one that was annotated, since lock_sock() in the readers
gives no exclusion against it.

Would a reproducer that lands in the blocking, copied == 0 arm still
produce the identical "data-race in do_recvmmsg / mptcp_recvmsg" report,
just attributed to mptcp_recvmsg() rather than to
tcp_recv_should_stop()?  If so, should the Closes: tag be dropped, or
should the four remaining reads be converted in the same patch?

The Fixes: tag points at eb477fdd6803, but that commit only moved these
pre-existing plain reads into the new helper; the sibling reads left
behind are part of the same defect.  Does the Fixes: attribution still
hold with only the helper annotated?

The added comment states "sk_err can be cleared locklessly by
sock_error()", which reads as a property of the field rather than of this
one call site.  Should the write side conventions be noted too, since
the writers in these files already use WRITE_ONCE() and sock_error()
itself uses data_race() for its own read?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-mptcp-sk-err-net-v2-1-5044abecac90%40proton.me
