Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465984;
	b=3SaVlzrOnwPkHADlglkRYZQ+amF9IjnnTho9lxPrCe2W+iCQViG96uJaY4I0QJP8F4CZ
	 lMMKR1OPORITtZw1CF2+dEDlj17bLCFhdcV8b4+3x++bq5Pw23cey8vlpGqnRmQmmUxMA
	 XIQkHh+UAzldiRLYMc+H86aitlEpp/fmJlsl2/ny3iKXe5rIiAL02+1auXcwiRNQsXH0G
	 2o+926atzvS/z7Bb8FJJabNcyPGaMP28DTvPKhSYQC7cWjnlfkQAKJSby8IKrXoVXaxjo
	 oz4b3z7cMKU8JUltT7Tyhl23hTo9q6n+ENRZ05gXpKQC0Wt0rhGc/2O/cCCWoDktNgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465984;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7BfjYkSPjZ1KO0F7eBvLd/URO41nX1aNFwaBIK6UjHQ=;
	b=lUhcM8/M7k+15r+ZR2bsBJaERofKX+gNci8d2R0kMFD15EU+D4ytJZy0WEVfg1AR4Yby
	 DLzSLqOMIBFZhQEES22NJ0u+JOCsWg3aRnO1d9VJhXueAP16X3MHKOW09Yj5N3T39Z5l1
	 u0OlNGMm6QJIvazaO+ye9JwVk0BlJb3WugTsCPrX4h4TsZOwaLeWCCW3YY7erNIsI4iE9
	 bUUDPaEppp77/ZBKblyUOOzh+e8rKlXpFL+fnFCXlxSrGYo4H4j2pfvQi/fgFh+QGGC1b
	 /brAy9pJFbj1Hv+2EC1v6rnSNTZdvNKHUZBkzlLtfAg5bas57rkg90JqsJBgzxv1pjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2FJfK5E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E20606AF5F
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2FJfK5E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F1A1F000C5;
	Tue, 20 Oct 2026 03:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792465984;
	bh=7BfjYkSPjZ1KO0F7eBvLd/URO41nX1aNFwaBIK6UjHQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D2FJfK5EZ5SbisEos8MjkyTuXA2RJRYL3sX2rjWZCmqGZZeEns9T1z/VLEiIqMY4n
	 D+RCVpJyYkTs6SPVC3dFsfQ8PLtlCDukfqJepq6U53tHna4ivIW8GJFTuF/v7aNpUv
	 kYDl2EEogNIJSQ0EQzmDwMxBHQvrFYd7wCbY3Ot9UpRudlMIS8ZnS9uwyPKJgo4Zsf
	 z3hO0Y0N6iPyrvSY3khb3z8hzaM+7NYfc476sXx1BydmtDLUGyvGtl9ByVmLruGWVj
	 fG5ULFwnOkXC1jyGCesTb9n8n6PO5XpQSuGmNt0wQfX+QXmRSk0qoZ8aHFen7ORq0W
	 agpV7x5lAyTfg==
Subject: Re: [PATCH net v2 2/2] strparser: don't serialize all parser work on
 one ordered workqueue
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Tue, 20 Oct 2026 03:13:03 +0000
Message-ID: <179246598334.3135.16744200632938817852@kernel.org>
In-Reply-To: <20261016025059.289202-3-rjethwani@purestorage.com>
References: <20261016025059.289202-3-rjethwani@purestorage.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Switching kstrp from an ordered workqueue to a per-CPU one
  lets strp_work() and strp_msg_timeout() for the same strparser run on…

--

strparser: don't serialize all parser work on one ordered workqueue

This patch changes the kstrp workqueue from an ordered workqueue (made
with create_singlethread_workqueue()) to a per-CPU WQ_MEM_RECLAIM
workqueue with the default max_active. The aim is to let strparser work
for different sockets run at the same time, so that every strparser
user no longer waits on a single worker.

> diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
> index d5b17d099a0e7..32fe96ba10d61 100644
> --- a/net/strparser/strparser.c
> +++ b/net/strparser/strparser.c
> @@ -542,7 +542,7 @@ static int __init strp_dev_init(void)
>  	BUILD_BUG_ON(sizeof(struct sk_skb_cb) >
>  		     sizeof_field(struct sk_buff, cb));
>  
> -	strp_wq = create_singlethread_workqueue("kstrp");
> +	strp_wq = alloc_workqueue("kstrp", WQ_PERCPU | WQ_MEM_RECLAIM, 0);

[Severity: Medium]
With this change, strp->work and strp->msg_timer_work for the same
strparser can run on two different kworkers at once. Can a message that
has already completed then be followed by a timeout abort?

The commit message says:

    Nothing relies on the ordering:
    [ ... ]
     - strp_work() and strp_msg_timeout() both run under cb.lock, so they
       are serialized against each other per socket by the socket lock,

The socket lock gives mutual exclusion. However, the cancel in
__strp_recv() when a message completes is not a sync cancel:

net/strparser/strparser.c:__strp_recv() {
    ...
		/* Hurray, we have a new message! */
		cancel_delayed_work(&strp->msg_timer_work);
		strp->skb_head = NULL;
    ...
}

strp_msg_timeout() then aborts unconditionally once it gets the lock:

net/strparser/strparser.c:strp_msg_timeout() {
    ...
	STRP_STATS_INCR(strp->stats.msg_timeouts);
	strp->cb.lock(strp);
	strp->cb.abort_parser(strp, -ETIMEDOUT);
	strp->cb.unlock(strp);
}

Assume SO_RCVTIMEO is set on the lower socket, so strp_start_timer()
arms the timer. Assume also that the timer expires while strp->work is
holding lock_sock(), for example during kTLS decryption for KCM:

kworker B (strp->work)               kworker A (msg_timer_work)
do_strp_work()
  strp->cb.lock()
  read_sock() ...
                                     strp_msg_timeout()
                                       msg_timeouts++
                                       strp->cb.lock()  /* sleeps */
  __strp_recv()
    cancel_delayed_work()  /* not pending, no-op */
    strp->cb.rcv_msg()
    new message started
    strp_start_timer()
      mod_delayed_work()
  strp->cb.unlock()
                                       strp->cb.abort_parser(-ETIMEDOUT)

No in-tree user overrides abort_parser, so this calls strp_abort_strp().
That function sets strp->stopped, frees the newly started skb_head, and
reports ETIMEDOUT on the lower socket. The KCM psock, sockmap or
espintcp stream is torn down right after a successful delivery.

With the old ordered workqueue, the expired timeout work stayed on the
pwq inactive list behind strp->work. The cancel_delayed_work() in
__strp_recv() removed it, because try_to_grab_pending() handles
WORK_STRUCT_INACTIVE. So on the workqueue path the message survived.

A similar but much narrower window, spinning on sk_lock.slock, already
exists on the inline softirq strp_data_ready() path. This patch widens
it to the kstrp path, which after the previous patch in the series is
the only path KCM over kTLS uses.

Should strp_msg_timeout() check under cb.lock that the message it was
timing is still in progress before it aborts? A generation counter, or
a check that skb_head and accum_len still match, would do this.

>  	if (unlikely(!strp_wq))
>  		return -ENOMEM;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016025059.289202-1-rjethwani%40purestorage.com
