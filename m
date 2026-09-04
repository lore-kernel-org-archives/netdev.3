Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC793EA973
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510317; cv=none; b=j+vyKK8tKPRtiv76GFoSXJ0X3qej79a7gpsddd1Q5hJ6VKYyF4lLfGvkPdg5VJhJ1A4HX3YRYwYvZnPbrqjSXVwA6vIuXspSAN3C49u3rO1mQ6JrQCyZQ3cxlacS1GRdslQTNI3mpwiuErZDM7VqIeu+4Io8pUPBqPcnH3NkG6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510317; c=relaxed/simple;
	bh=UfKACdaL7C5inou1iF8mgvBRh2CdgvPEK5Ww10sGXcI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kYy+vvs9gM8n09SrXOwuaC3UPSDIqBAWpb7ILPUWaAympAq9zfI3P40nivc0pDJ4s+/zHCmsjV/d1hRwLALiUv4XrtBIFuUqCItyHN2GEHhLYkHqvdf0xu9QcDeEjNFuU47SAbtcdwC7M5Up1BCwaZ4abm7LFR16bLSUU88Lxbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0o7115f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0o7115f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1271F1F00AC4;
	Fri,  4 Sep 2026 08:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788510315;
	bh=WNVNCxCDOzoDfqB1CAl/4N9CcrRK25SXILKwDd0JzvY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M0o7115frkDsUhvBtdSzANzWGC4OmsxbQrwogIRaEMf0Kl5xoqRlsgmt0OcJW84ji
	 Y/sqt1OVTJv9OtTfoIcxyGNE9QEgR+mlRGYZR0IhSbIfHJfLLcze3BKNi1P+sl331U
	 BpP5pPSbGAg0L0uy7sIbxIHks9nXnkylMFKc7rq+1+ROCyWADgiIAhO3kIyXh2/a6q
	 o9aHR3Pk9mD8O8LIl8sgL9SSi3sb8rZG56brQ6vNMsWOrUxI2C5CTjlnBrDeaF5OCS
	 GJGfPoBKoyy0Tm7HurJUWAyOAE3zhDnoMKb2zlLQkyM9Rd8JNesOUKHJToTc7UVwQe
	 Fjn83OxUPNFig==
Subject:
 Re: [PATCH v1 net 3/3] selftest: af_unix: Add zero-buffer test for msg_oob.c
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, fahad@codepure.com, kuni1840@gmail.com,
 netdev@vger.kernel.org
Date: Fri, 04 Sep 2026 08:25:14 +0000
Message-ID: <178851031460.4131868.15000425596101479252@kernel.org>
In-Reply-To: <20260902202202.892676-4-kuniyu@google.com>
References: <20260902202202.892676-4-kuniyu@google.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 0

- [Medium] The six new zero-buffer tests
  (tools/testing/selftests/net/af_unix/msg_oob.c:913-955) assert only…
- [Medium] The new tests do not exercise the last-skb marker updates
  added by the companion commit "af_unix: Update last skb marker in…
- [Medium] Incomplete test matrix: Missing coverage for Case 2 enumerated
  in the corresponding core patch.

--

selftest: af_unix: Add zero-buffer test for msg_oob.c

This adds a __setblockingpair() helper plus six new tests that send an
MSG_OOB byte and then perform a zero-length receive, in both non-blocking
and blocking mode.  The tests are meant to cover the two zero-length
buffer / MSG_PEEK fixes from the earlier patches in the series.

No Link: tags in the commit header.

> diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
> index 1b499d56656c..f051d79f7a8e 100644
> --- a/tools/testing/selftests/net/af_unix/msg_oob.c
> +++ b/tools/testing/selftests/net/af_unix/msg_oob.c

[ ... ]

> @@ -888,4 +910,49 @@ TEST_F(msg_oob, inline_ex_oob_siocatmark)
>  	resetpair(true);
>  }
>  
> +TEST_F(msg_oob, zero_buf_oob)
> +{
> +	sendpair("a", 1, MSG_OOB);
> +	recvpair("", 0, 0, 0);
> +}

[Severity: Medium]

Should these new tests also check the OOB state with epollpair() and
siocatmarkpair() the way the rest of the file does?  Every other test in
msg_oob.c (for example oob() and inline_ex_oob_siocatmark()) brackets each
send/recv with epollpair()/siocatmarkpair() and ends with resetpair(), while
zero_buf_oob() through zero_buf_ex_oob_oob_blocking() assert only the recv()
return value.

Because of that, do these tests pass whether or not the zero-length read
consumed the OOB byte?  For the non-peek pass of recvpair("", 0, 0, 0),
unix_stream_read_generic() calls manage_oob() with copied == 0 and no
MSG_PEEK, which takes:

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
}

and the unlinked skb is then dropped with
kfree_skb_reason(unread_skb, SKB_DROP_REASON_UNIX_SKIP_OOB), so EPOLLPRI and
SIOCATMARK are cleared even though recv() reported 0 bytes.

Since these tests run with self->tcp_compliant == true and are not wrapped in
tcp_incompliant, do they implicitly claim TCP behaves the same here?  On the
TCP side a len == 0 receive leaves the urgent state alone:

net/ipv4/tcp.c:tcp_recvmsg_locked() {
	...
		if (unlikely(tp->urg_data)) {
			u32 urg_offset = tp->urg_seq - *seq;
			if (urg_offset < used) {
	...
}

with used == 0 the condition is false, so tp->urg_data and copied_seq stay
untouched and SIOCATMARK still returns 1 with EPOLLPRI set.  Adding
epollpair()/siocatmarkpair() after the new recvpair() calls would show
answ[0] == 0 versus answ[1] == 1, which looks like exactly the case the
tcp_incompliant idiom exists for.

For the peek fixture variant, recvpair() issues the MSG_PEEK receive first and
then the normal one, but with an expectation of 0 bytes is there anything left
that would catch a regression where the MSG_PEEK pass itself dropped or
consumed the queued OOB skb?

> +
> +TEST_F(msg_oob, zero_buf_oob_blocking)
> +{
> +	sendpair("a", 1, MSG_OOB);
> +	setblockingpair();
> +	recvpair("", 0, 0, 0);
> +}
> +
> +TEST_F(msg_oob, zero_buf_non_oob_oob)
> +{
> +	sendpair("ab", 2, MSG_OOB);
> +	recvpair("", 0, 0, 0);
> +}
> +
> +TEST_F(msg_oob, zero_buf_non_oob_oob_blocking)
> +{
> +	sendpair("ab", 2, MSG_OOB);
> +	setblockingpair();
> +	recvpair("", 0, 0, 0);
> +}
> +
> +TEST_F(msg_oob, zero_buf_ex_oob_oob)
> +{
> +	sendpair("a", 1, MSG_OOB);
> +	recvpair("a", 1, 1, MSG_OOB);
> +
> +	sendpair("b", 1, MSG_OOB);
> +	recvpair("", 0, 0, 0);
> +}
> +
> +TEST_F(msg_oob, zero_buf_ex_oob_oob_blocking)
> +{
> +	sendpair("a", 1, MSG_OOB);
> +	recvpair("a", 1, 1, MSG_OOB);
> +
> +	sendpair("b", 1, MSG_OOB);
> +	setblockingpair();
> +	recvpair("", 0, 0, 0);
> +}

[Severity: Medium]
The core patch in this series enumerated three distinct cases that
manage_oob() gets wrong for a zero-length receive, but the new tests
only seem to cover two of them.  zero_buf_non_oob_oob() and
zero_buf_non_oob_oob_blocking() send "ab" with MSG_OOB and then do a
0-byte recv, which is case 1 (a normal skb followed by a live OOB skb,
u->oob_skb still set).  zero_buf_ex_oob_oob() and its _blocking twin
cover case 3 (an already consumed OOB skb followed by a new OOB skb).
I cannot find a test for case 2, where the queue head is a plain skb
followed by an OOB skb whose OOB byte has already been consumed, so
u->oob_skb no longer points at it and manage_oob() has to take the
skip-consumed-OOB path instead of the unlink path.

Would it be worth adding something like sendpair("ab", 2, MSG_OOB) then
recvpair("b", 1, 1, MSG_OOB) to consume the OOB byte while leaving "a"
and the consumed OOB skb queued, followed by recvpair("", 0, 0, 0)?
Without it, the commit message's claim that this patch adds tests
"corresponding" to the previous fixes does not quite match what is
here, and the case that led to the busy-wait/CPU hog in the consumed
skb path stays uncovered.  Or is case 2 already exercised indirectly by
one of the existing tests in a way I am missing?

[Severity: Medium]

The commit message says "The previous patches fixed two issues related to
zero-length buffer with MSG_PEEK for MSG_OOB skb.  Let's add corresponding
tests in msg_oob.c."  Do the new tests actually cover the second fix, the
last-skb marker updates from "af_unix: Update last skb marker in
manage_oob()"?

All six tests call recvpair() with buf_len == 0, including the three blocking
ones, so state->size == 0 and unix_stream_read_generic() leaves as soon as
manage_oob() returns NULL:

net/unix/af_unix.c:unix_stream_read_generic() {
	...
			skb = manage_oob(skb, &last, sk, flags, copied);
			if (!skb && (copied || !state->size)) {
				unix_state_unlock(sk);
				break;
			}
	...
}

With size == 0 the loop cannot iterate and copied never becomes non-zero, so
unix_stream_data_wait(sk, timeo, last, freezable) is never reached and the
*last assignments in manage_oob() are never observed.

Would all 12 new cases (6 tests x 2 fixture variants) still pass if those
*last updates were reverted?  Case 3 in that commit message uses a non-zero
length blocking MSG_PEEK:

	send "a" MSG_OOB
	recv(buf, 1, MSG_OOB)
	send "b" MSG_OOB
	recv(buf, 1, MSG_PEEK)

zero_buf_ex_oob_oob_blocking() uses recvpair("", 0, 0, 0) instead of a 1-byte
MSG_PEEK, so the busy-wait that fix addresses appears to be left without
coverage.  Would adding a blocking test with buf_len == 1 and MSG_PEEK close
that gap?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902202202.892676-1-kuniyu%40google.com
