Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3193DEFFC
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510315; cv=none; b=nj3BHD9nqU9+mCYhgB/7+5+/IRYritICtj+aTperELxuPOeHYGJf/rEPZdBFBbVjQTpwVx2pVFggq/4e26FY5uca51z4Sn4Y4+V6dV//8rsC6IdXhEIiVoIlor7YBWrbOx2uBcwhpAGIvei7FI4YdKSBEkM6s6bcFHQZ7kfkXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510315; c=relaxed/simple;
	bh=kBHIcN6v7FG9VNSo+uzn77Kzq5mp7ihAWpDyw9mZzkQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=stp+qKw/vmxQR/UCmJ3INyNx2Uxy72QzWDSvACA/WCXDVmf70r0JY4M7AKjeQljAlCUDSTT+ltIIDnWEIYW21JII9msvNheOOUngWkRPr1gZ5oCgkugWBBz8iq6m17TquHEwfI/widL3rZeLwTQNz4xiuJIPlIYmHcvsAh4daIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQOX7USA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQOX7USA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C451F00A3E;
	Fri,  4 Sep 2026 08:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788510313;
	bh=xTliH7gMmMjPEOOX4nG5/HJ7nVO9uqQE6N/nQEZMR4g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GQOX7USAQHFyRuGMVwY/nFyTBn+EehzHCIBhznmCGePMBXdWjvcH9HTFtKUmZypDu
	 UOEOkcfBHVbys6/GxBv58FYLIPtx19lqxy2lLwdCEKMxwY3WP9/aMU+4l2CxcaySFf
	 jAfW37HNjDzEfBrUFsDUFyhIHr2DVto4tomzzfC32vAMdXwM47eLOryfoN4raKpMet
	 +mSwiE/lTgMwOAAB8QHBPK1rH/lK1VLwtzqRiJkK/gYPKxPDM/Mx6vzRFVAOsbFvwS
	 Rwyude5IkMSKq97GIwDNNNlNXnbWQTnoiowg+7nWJfleMd6bBg4rvXO+VsynJnps7e
	 5TIv3k/g0/K2A==
Subject:
 Re: [PATCH v1 net 1/3] af_unix: Update last skb marker in manage_oob().
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, fahad@codepure.com, kuni1840@gmail.com,
 netdev@vger.kernel.org
Date: Fri, 04 Sep 2026 08:25:12 +0000
Message-ID: <178851031241.4131868.9083667477267963758@kernel.org>
In-Reply-To: <20260902202202.892676-2-kuniyu@google.com>
References: <20260902202202.892676-2-kuniyu@google.com>
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

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 0

- [Medium] With only this patch applied, a zero-length receive that hits
  the OOB-skip path turns a busy-wait into an indefinite block.

Pre-existing issues:
- [Medium] manage_oob() (net/unix/af_unix.c:2815-2869) drops the
  unconsumed OOB skb without decrementing u->inq_len, so SIOCINQ /…
- [Medium] The wait marker @last passed to unix_stream_data_wait() is a
  bare skb address captured under unix_state_lock, but both…

--

af_unix: Update last skb marker in manage_oob().

manage_oob() can skip OOB skbs and return NULL, after which
unix_stream_read_generic() may call unix_stream_data_wait() with a stale
@last, so the wait returns immediately and the reader busy-waits.  This
patch passes @last into manage_oob() and updates it on the paths that skip
or unlink an OOB skb.

> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 13f9926bf205..6861370062df 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2812,8 +2812,8 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
>  	return 1;
>  }
>  
> -static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
> -				  int flags, int copied)
> +static struct sk_buff *manage_oob(struct sk_buff *skb, struct sk_buff **last,
> +				  struct sock *sk, int flags, int copied)
>  {
>  	struct sk_buff *read_skb = NULL, *unread_skb = NULL;
>  	struct unix_sock *u = unix_sk(sk);
> @@ -2827,11 +2827,13 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>  		if (copied && (!u->oob_skb || skb == u->oob_skb)) {
>  			skb = NULL;
>  		} else if (flags & MSG_PEEK) {
> +			*last = skb;
>  			skb = skb_peek_next(skb, &sk->sk_receive_queue);
>  		} else {
>  			read_skb = skb;
>  			skb = skb_peek_next(skb, &sk->sk_receive_queue);
>  			__skb_unlink(read_skb, &sk->sk_receive_queue);
> +			*last = skb;
>  		}
>  
>  		if (!skb)
> @@ -2850,8 +2852,10 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>  			__skb_unlink(skb, &sk->sk_receive_queue);
>  			unread_skb = skb;
>  			skb = skb_peek(&sk->sk_receive_queue);
> +			*last = skb;
>  		}

[Severity: Medium]

This is a pre-existing issue and not something this patch introduces, but
since this branch is being touched: the OOB skb is unlinked here and then
freed at the end of manage_oob():

	kfree_skb_reason(unread_skb, SKB_DROP_REASON_UNIX_SKIP_OOB);

I don't see u->inq_len being adjusted anywhere in manage_oob(), while
queue_oob() accounts the 1-byte OOB skb:

	WRITE_ONCE(ousk->inq_len, ousk->inq_len + 1);

Other places that remove queued bytes do decrement it, including
unix_stream_read_skb(), which drops the same skb with the same reason:

	WRITE_ONCE(u->inq_len, u->inq_len - unix_skb_len(skb));
	if (skb == u->oob_skb) {
		WRITE_ONCE(u->oob_skb, NULL);
		...
		kfree_skb_reason(skb, SKB_DROP_REASON_UNIX_SKIP_OOB);

With:

	send(sk0, "ab", 2, MSG_OOB);
	recv(sk1, buf, 1, 0);	/* reads 'a', inq_len == 1 */
	recv(sk1, buf, 10, 0);	/* manage_oob() unlinks and frees the OOB skb */

the receive queue ends up empty with u->inq_len still 1.  Does SIOCINQ via
unix_inq_len(), and msg_inq/SCM_INQ, then report a readable byte that can
never be read, growing by one for every skipped OOB byte?

>  	} else if (!sock_flag(sk, SOCK_URGINLINE)) {
> +		*last = skb;
>  		skb = skb_peek_next(skb, &sk->sk_receive_queue);
>  	}
>  

[Severity: Medium]

This is a pre-existing property of the @last marker rather than something
introduced here, but this path now publishes u->oob_skb as the wait marker,
and @last is only ever compared as a bare address:

unix_stream_data_wait()
	tail = skb_peek_tail(&sk->sk_receive_queue);
	if (tail != last || ...)
		break;

unix_stream_read_generic() drops both unix_state_lock and u->iolock before
that comparison:

	unix_state_unlock(sk);
	...
	mutex_unlock(&u->iolock);

	timeo = unix_stream_data_wait(sk, timeo, last, freezable);

so a second reader on the same socket can free that OOB skb in manage_oob()
via kfree_skb_reason(unread_skb, SKB_DROP_REASON_UNIX_SKIP_OOB).

If the sk_buff slab hands the same address back for a newly sent skb that
becomes the queue tail before the sleeper reaches prepare_to_wait(), the
accompanying sk_data_ready() finds no waiter and the tail re-check sees
tail == last again.

The pointer is only compared and never dereferenced, so this is not a
use-after-free, but can the recv() then sleep with readable data queued
until the next send, a signal, or SO_RCVTIMEO?  Would comparing a tail
generation counter or qlen be more robust than a raw skb address?

> @@ -2971,7 +2975,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>  again:
>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>  		if (skb) {
> -			skb = manage_oob(skb, sk, flags, copied);
> +			skb = manage_oob(skb, &last, sk, flags, copied);
>  			if (!skb && copied) {
>  				unix_state_unlock(sk);
>  				break;

[Severity: Medium]

For cases 1) and 2) in the commit message, recv(sk[1], buf, 0, MSG_PEEK)
leaves copied == 0 because size is 0, so this escape is not taken when
manage_oob() returns NULL.

Execution then falls into the skb == NULL path, where copied >= target is
0 >= 1 since sock_rcvlowat() clamps target to at least 1, and
unix_stream_data_wait() is entered with @last now set to the skipped OOB
skb, which is also the queue tail.

Since tail == last now holds, does the zero-length blocking peek sleep
until unrelated new data arrives, a signal is delivered, or SO_RCVTIMEO
expires, instead of returning 0?  With MSG_DONTWAIT the same path appears
to return -EAGAIN rather than 0.

The next patch in the series, "af_unix: Return immediately when
manage_oob() returns NULL for 0-length buffer.", changes this test to:

	if (!skb && (copied || !state->size)) {

which looks like it covers exactly this case.  Would it make sense to order
that change first, or fold the two together, so that a bisection landing on
this commit alone does not convert the busy-wait into a blocking recv()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902202202.892676-1-kuniyu%40google.com
