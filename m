Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853BC17993;
	Sun, 20 Sep 2026 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789946396; cv=none; b=uTi3ixjryUbGDbzXiJKJZNzMwGG+td2Zq9j+gjvoASWxlqIPlHT11mQIDTrgC1pTSbF/oEIqmv1EG2JsOKzdzaDjDljziKiF5uVWsKk9V1eWWIrOIaB5a35BBCXvY8QzaP9J+oeae2Dyr6KZYNzAtvamw075l4JLxQ3vFRkgWWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789946396; c=relaxed/simple;
	bh=03Zr9KxeAhddr4YdloeR93XDVOaorlhRh5tb3WPvkr4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F5vYgtVuvCo+Om98eowMSDCmUZ8XyV+GkTQ4OBy+z1qgVniuLmxIFoCdxfOBoUvJtQLVUxFf55+oklMCJJocq/VX6qJhPKsSzmDeYAu/WAjqvT2kTsSSZqHvXOqQsqD1xqdHSiS6XCF5/jEcJyibOCuVxu5TpbakTOTv9X7jCoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwV06Rf4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwV06Rf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D281F1F000FF;
	Sun, 20 Sep 2026 23:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789946395;
	bh=f5JHHIzrrJsl0MAmW3u29Cg5qybvyulN3vFB+ixgo70=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DwV06Rf4rdqgo61+KrvCu4wHU94zwpi75qKJVital0V8IEfbGlix0/VqMUmKPmmO4
	 +iKjGzHqLj68q4r2Y/m2A9EAfbo4Dn/SrpLg+5aZlC3xILWOAVuASauVCMiCik2qXc
	 vTJoaUIIGJ6DAGLHvxvwvTk1M0emgJBtIAG4sNBf//3+nMNcMb8iNS7KitQVrUyYwA
	 OIbrP/D+wLyAD55uE5a9O5ABShxAl2NTYtfAe5vkDRok6Vo0lT7Pl1zcFX+/5gtD2A
	 DpE7+Mx5DhhGyoQN1fDgXzlneVAaA1vwVqY+7oXtRWfX0PXxj5bC2/qtpSuMoLsZwP
	 yAPeTziiYcG+Q==
Subject: Re: [PATCH] af_unix: fix u->inq_len accounting in manage_oob() and
 unix_stream_read_skb()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: kuniyu@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 23:19:54 +0000
Message-ID: <178994639435.2160803.947828699469290336@kernel.org>
In-Reply-To: <20260919221735.3708237-1-benquike@gmail.com>
References: <20260919221735.3708237-1-benquike@gmail.com>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Kernel BUG() (oops/panic) in the sockmap read path: the
  newly added `skb_pull(skb, UNIXCB(skb).consumed)` in…
- [Medium] Commit message does not match the code, and two of the three
  hunks are unrelated to inq_len accounting (scope creep).
- [Medium] Incorrect Fixes tag / wrong bug attribution.
- [Medium] Unbalanced SCM_RIGHTS accounting on the new early-drop path in
  `unix_stream_read_skb()`: the added block frees the dequeued skb with…

--

af_unix: fix u->inq_len accounting in manage_oob() and unix_stream_read_skb()

This adds a u->inq_len decrement when manage_oob() discards a replaced OOB
skb, makes unix_stream_read_skb() skip and free fully consumed skbs, and
pulls the already consumed prefix out of the skb before handing it to the
recv_actor.  No Link: tags are present in the commit header.

A few questions on the changelog and on the two new blocks in
unix_stream_read_skb().

> When an old OOB skb is replaced and discarded in manage_oob(), or when a
> fully consumed OOB skb is skipped in unix_stream_read_skb(), the
> discarded byte count is not subtracted from u->inq_len (or is subtracted
> inconsistently), causing SIOCINQ / FIONREAD to report stale positive
> byte counts on an empty AF_UNIX stream socket.

[Severity: Medium]
Is the unix_stream_read_skb() half of this description accurate?

unix_skb_len() is:

    static unsigned int unix_skb_len(const struct sk_buff *skb)
    {
    	return skb->len - UNIXCB(skb).consumed;
    }

so a fully consumed skb contributes 0 bytes, and the pre-existing
subtraction already in that function:

    WRITE_ONCE(u->inq_len, u->inq_len - unix_skb_len(skb));

subtracts exactly 0 for it.  The bytes were already removed either by the
partial read in unix_stream_read_generic():

    WRITE_ONCE(u->inq_len, u->inq_len - chunk);

or by unix_stream_recv_urg():

    WRITE_ONCE(u->inq_len, u->inq_len - 1);

Can a fully consumed skb still hold un-accounted bytes in this path?

The new !unix_skb_len(skb) block contains no inq_len update at all, and the
new skb_pull() block is not mentioned in the changelog.  Both change what
the ->read_skb() (BPF sockmap) consumer sees: one stops delivery of a
zero-payload skb, the other stops re-delivering already consumed bytes.
Could those two changes be split out with their own justification, so that
this patch only carries the manage_oob() accounting fix?

> Fixes: 314001f0bf92 ("af_unix: Add OOB support")

[Severity: Medium]
Is this the right Fixes target?  u->inq_len does not exist at that commit;
blame on include/net/af_unix.h attributes

    int			inq_len;

to f4e1fb04c1238 ("af_unix: Use cached value for SOCK_STREAM in
unix_inq_len().").  Before that, unix_inq_len() walked the receive queue:

    skb_queue_walk(&sk->sk_receive_queue, skb)
    	amount += unix_skb_len(skb);

so a discarded OOB skb could not leave a stale count behind.  f4e1fb04c1238
added the inq_len increment in queue_oob() and the decrement in
unix_stream_recv_urg(), but not the manage_oob() discard decrement this
patch adds.  Should the tag point at f4e1fb04c1238 instead, and should the
patch carry Cc: stable@vger.kernel.org given it claims a user-visible
SIOCINQ/FIONREAD fix?

> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 42cffeafc8c1..1770af3c2684 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2849,6 +2849,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sk_buff **last,
>  		WRITE_ONCE(u->oob_skb, NULL);
>  
>  		if (!sock_flag(sk, SOCK_URGINLINE)) {
> +			WRITE_ONCE(u->inq_len, u->inq_len - 1);
>  			__skb_unlink(skb, &sk->sk_receive_queue);
>  			unread_skb = skb;
>  			skb = skb_peek(&sk->sk_receive_queue);
> @@ -2884,6 +2885,7 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>  		return err;
>  
>  	mutex_lock(&u->iolock);
> +again:
>  	spin_lock(&queue->lock);
>  
>  	skb = __skb_dequeue(queue);
> @@ -2893,6 +2895,12 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>  		return -EAGAIN;
>  	}
>  
> +	if (!unix_skb_len(skb)) {
> +		spin_unlock(&queue->lock);
> +		consume_skb(skb);
> +		goto again;
> +	}
> +

[Severity: Medium]
Does this new discard path leave u->scm_stat.nr_fds inflated?

The normal exit of unix_stream_read_skb() goes through:

    static void unix_orphan_scm(struct sock *sk, struct sk_buff *skb)
    {
    	scm_stat_del(sk, skb);
    	unix_destruct_scm(skb);
    	skb->destructor = sock_wfree;
    }

and scm_stat_del() is the only place that decrements nr_fds:

    if (unlikely(fp && fp->count)) {
    	atomic_sub(fp->count, &u->scm_stat.nr_fds);
    	unix_del_edges(fp);
    }

The bare consume_skb() here goes through the destructor chain
unix_wfree() -> unix_destruct_scm() -> unix_detach_fds(), which releases the
files but never touches scm_stat.nr_fds.

A reachable input looks like: sendmsg(MSG_OOB) with SCM_RIGHTS, where
queue_oob() attaches the fds and calls scm_stat_add(other, skb); then a
recvmsg(MSG_OOB) without MSG_PEEK in unix_stream_recv_urg() does

    if (!(state->flags & MSG_PEEK))
    	UNIXCB(oob_skb).consumed += 1;

leaving a queued zero-payload skb that still carries UNIXCB(skb).fp.  When
that skb reaches the head of the queue on a sockmap'd socket, the new branch
frees it without scm_stat_del(), so unix_show_fdinfo() keeps reporting an
inflated scm_fds for the life of the socket.  Would calling
unix_orphan_scm(sk, skb) (or at least scm_stat_del()) before freeing keep
the accounting balanced?

>  	WRITE_ONCE(u->inq_len, u->inq_len - unix_skb_len(skb));
>  
>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> @@ -2908,6 +2916,11 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>  
>  	spin_unlock(&queue->lock);
>  
> +	if (UNIXCB(skb).consumed) {
> +		skb_pull(skb, UNIXCB(skb).consumed);
> +		UNIXCB(skb).consumed = 0;
> +	}
> +

[Severity: Critical]
Can this skb_pull() hit the BUG() in __skb_pull() on a paged skb?

UNIXCB(skb).consumed is a logical stream offset, not bounded by
skb_headlen(skb).  unix_stream_sendmsg() routinely builds non-linear skbs:

    data_len = max_t(int, 0, size - SKB_MAX_HEAD(0));
    ...
    skb = sock_alloc_send_pskb(sk, size - data_len, data_len, ...);

and on the MSG_SPLICE_PAGES branch the head length is 0.

unix_stream_read_generic() then advances consumed and deliberately leaves
the skb queued while any payload remains:

    UNIXCB(skb).consumed += chunk;
    ...
    if (unix_skb_len(skb)) {
    	spin_unlock(&sk->sk_receive_queue.lock);
    	break;
    }

skb_pull() only rejects len > skb->len; __skb_pull() then does:

    skb->len -= len;
    if (unlikely(skb->len < skb->data_len)) {
    	...
    	BUG();
    }

So a peer writing more than SKB_MAX_HEAD(0) bytes (or splicing pages, where
a single consumed byte is enough), a reader consuming a prefix past the
linear head with a normal recvmsg(), and then further data arriving on a
socket with a sockmap verdict program gives
sk_psock_verdict_data_ready() -> ops->read_skb() -> unix_stream_read_skb() ->
skb_pull() -> BUG().

The BUG() fires after spin_unlock(&queue->lock) but before
mutex_unlock(&u->iolock), so the task dies holding u->iolock and further
readers and MSG_OOB users of that socket block forever; the skb is already
dequeued and u->inq_len already decremented.

If already consumed bytes need to be hidden from the recv_actor, would a
paged-safe form such as pskb_pull()/__pskb_pull_tail() with failure handling,
or passing the offset to the actor, be more appropriate here?

>  	unix_orphan_scm(sk, skb);
>  
>  	mutex_unlock(&u->iolock);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919221735.3708237-1-benquike%40gmail.com
