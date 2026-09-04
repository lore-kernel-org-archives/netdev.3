Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF31E5207
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510316; cv=none; b=U38gi5Np0uHYQ+OSR48nrk2H4O3A/Ftwf5MbYW6mj+/8xgD09wgJJBISk6Qzk1jGTGLVpeo/9mU3Ut+jwTvcMY0891qoK6FYGojMoRyA1sEZmK2V489NEgMCc7yUy+uFfEoP5iQGEQdjMpmplyHXl3h7hou2sjg+BMZUDwGATBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510316; c=relaxed/simple;
	bh=2AGrPvo6X184m99uG8N8OEXgOB4VQSrgA6wjtgTrvnI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JPhCWIy3ScAdAZXO3AA2FF4dyQTEUa/yXrjhgCYDRwdOuGEpRsz8eZLfVt4oR+v116K7MMGVZ10jco9vbjsdVGhDTTFxemoyRYEP3XKm1X/xvgBc7l8QaYdMVH5CSTbPlb0ZR1IHki1kjYqlF4ACDbmC06Wjs25x+p7segyPi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHJ+VLa1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHJ+VLa1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC79D1F00A3F;
	Fri,  4 Sep 2026 08:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788510314;
	bh=agiTKoiJNUPToqmnRtWQQ2T7m1JCyr+gVpu5MkyOw/4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jHJ+VLa1mb+p6msicyYBRSzKHYeTiAhTwllPKMrug8QPYHejVaXER2nc0TzhEDSbq
	 hZEcC8ACRGeZdA6RqIxV32K8hv0LztzHjHlCJi5WaS7xGc/0V2t0UbDMGRJmCN5gfX
	 00MxSqcj/fPACq29zoO/V0EFW34BPQMMXyTvb+5PLUY/lmPArTxeP7uR+eh3LXPi/a
	 pm84+2vaiRSN52BoE3qKLlRtvkQFpk2uqEl/Y+wgLdpR90wDTcjZgzSiREAcVTuYen
	 2N1Q6pzSnslI2iy0mHXuL3YakDrFKor2KRCD46QnHbpTXL+hgSx33+WqlvPbvNDeDq
	 mJKSajoLaAtAw==
Subject: Re: [PATCH v1 net 2/3] af_unix: Return immediately when manage_oob()
 returns NULL for 0-length buffer.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, fahad@codepure.com, kuni1840@gmail.com,
 netdev@vger.kernel.org
Date: Fri, 04 Sep 2026 08:25:13 +0000
Message-ID: <178851031352.4131868.6534018713303595286@kernel.org>
In-Reply-To: <20260902202202.892676-3-kuniyu@google.com>
References: <20260902202202.892676-3-kuniyu@google.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Zero-size early return is placed after the queue-mutating
  manage_oob() call: recv(fd, buf, 0, 0) (zero-length, no MSG_PEEK) on…

--

af_unix: Return immediately when manage_oob() returns NULL for 0-length buffer.

This makes unix_stream_read_generic() break out of the receive loop when
manage_oob() returns NULL and the user supplied a zero-length buffer, so a
blocking recv() with a trailing MSG_OOB skb no longer busy-waits.  The stated
goal is to match TCP, which returns 0 immediately in that situation.

> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 6861370062df..2da1017f8873 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2976,7 +2976,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>  		if (skb) {
>  			skb = manage_oob(skb, &last, sk, flags, copied);
> -			if (!skb && copied) {
> +			if (!skb && (copied || !state->size)) {

[Severity: Medium]
The new !state->size condition applies to every zero-length read, not only
the MSG_PEEK case described in the commit message.  Since it is evaluated
after manage_oob() has already run, does a plain recv(fd, buf, 0, 0) now
destroy the pending OOB byte and still report success?

With queue == [oob skb] and SO_OOBINLINE off, manage_oob() takes the
non-peek branch:

net/unix/af_unix.c:manage_oob() {
	...
	} else if (!(flags & MSG_PEEK)) {
		WRITE_ONCE(u->oob_skb, NULL);

		if (!sock_flag(sk, SOCK_URGINLINE)) {
			__skb_unlink(skb, &sk->sk_receive_queue);
			unread_skb = skb;
			skb = skb_peek(&sk->sk_receive_queue);
			*last = skb;
		}
	...
unlock:
	...
	kfree_skb_reason(unread_skb, SKB_DROP_REASON_UNIX_SKIP_OOB);

	return skb;
}

so u->oob_skb is cleared and the byte is freed before the caller ever looks
at state->size.  The loop then breaks and unix_stream_read_generic() returns
0, after which recv(MSG_OOB) returns -EINVAL and SIOCATMARK/EPOLLPRI report
no urgent data.

The commit message says:

    In such a situation, TCP returns 0 immediately regardless of
    blocking or non-blocking.

    Let's follow the behaviour.

Is that comparison exact for the non-peek case?  In tcp_recvmsg_locked() the
found_ok_skb path computes:

net/ipv4/tcp.c:tcp_recvmsg_locked() {
	...
	used = skb->len - offset;
	if (len < used)
		used = len;

	if (unlikely(tp->urg_data)) {
		u32 urg_offset = tp->urg_seq - *seq;
		if (urg_offset < used) {
	...
}

With len == 0 used is 0, so the urgent-skip is not taken and tp->urg_data
survives the zero-length read.  TCP returns 0 without consuming or
invalidating the urgent byte, while AF_UNIX now returns 0 having dropped it.

Would it be equivalent, and non-destructive, to test the zero-length case
before manage_oob() mutates the queue, e.g. break out when
skb && !state->size, so the empty-queue case still blocks the same way as
TCP?

One more note on the selftest added later in this series:

tools/testing/selftests/net/af_unix/msg_oob.c:zero_buf_oob() {
	sendpair("a", 1, MSG_OOB);
	recvpair("", 0, 0, 0);
}

This exercises exactly the destructive non-peek path, but only compares
return values with TCP, so the difference in the resulting socket state is
not detected.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902202202.892676-1-kuniyu%40google.com
