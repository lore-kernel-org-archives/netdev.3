Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552211;
	b=1gh+Ud4mMnsSag/wwCCE83nj0qh0l7vaEcg2RB5uPSz6eFJvNuLJNGlwgWa164+kYK0p
	 E09ByIkC7V7KbXvq9XcGcKwtalVdJBxFHy/FbwbCrM0OGl7S8v5iyW3k2XpCsoGxSOhbn
	 Kfl+TsRZNU+kyMUDKknhipIQmF7LJtC4BF358Ydr03NI+j2dpXSoeqj6rPB4HMx2oXrqr
	 eMd8HGFCbyUgVz83W6BenrZUwxE5Q33Lgv9c+ruQ6CAYO3baHyna5Wd9fJX9HRKVXPiZs
	 MFYOpEwq2EBBg3Gn5CMmLLcD09QFSM29xs+hvym/zRkflxtl+R+EulvbTAvyOFvdO7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552211;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=O5r9uFNjCnSFzUE3KezEuv7MRcWVKwW1Scl7caNddMk=;
	b=scyk7i5qiFY3HUAp7onKL7AZ/WDuW1JRCCS56ExlwFSIChDFxHZFRd1RO7DrUs4RNmZ/
	 FgwT+Heo216CGgXjkk8b+PBmmpX6sqJ1QGw4hqivs0b/xsDrwewUtqUQri8rYKcdn3tfP
	 ec016Qo1poewXtMFpJpBS7HEgQ14c5d0tPNYxCp7N87LfFma8eXOdoBgiCK6a9q5pAZPy
	 8RUoOliP0Nvr3pn0pVpSZDI8HhLtIRTdMgXp1V51rL/7V4rOoLHMyJr12fu1nOxWeEWRY
	 9NW+8qwcc/7ac4GQqp81rxL0PXOeRw+YgQllW/B6+2sINt5Fr9wRMGAfd1/4+rKu42w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Go8SaYyE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAF6606A323
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Go8SaYyE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225311F000C4;
	Fri, 13 Nov 2026 06:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552211;
	bh=O5r9uFNjCnSFzUE3KezEuv7MRcWVKwW1Scl7caNddMk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Go8SaYyEHOPhTbBZTfuf2A+C3xEWiSBxhWaLkTQ5NUtwpnicM8/Yi2yGqh7JF23zV
	 Ge3j6Cx/L0fxcs0QmCLIDBmFWS/Up14EgOhWhQNrXuSZC9qffGo4ee7DyPohfBRZh5
	 M2qOETDggTneIGOTHIDs909aas28BW02EgQzBBZTCLvDADocqSlsjn64JOjrmlK3Xh
	 IzsMbKye6leOcuYrtTWyYbrvD46hJE7nfq3lWXO53r8fAFuqfAb+WXTZpz9UV1T8wE
	 Vjvyyw/fewXTkWNLOnJOWkqKWB5CjRRMX982L9ds4twJHqBgxk+I6KsmrdqzkQkSka
	 TdKKnaJdP7quw==
Subject: Re: [PATCH net] xfrm: reschedule NAT keepalive work for new states
From: netdev-bot+sashiko@kernel.org
To: pocj8ur4in@gmail.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 eyal.birger@gmail.com, netdev@vger.kernel.org, kuba@kernel.org
Date: Fri, 13 Nov 2026 06:43:30 +0000
Message-ID: <179455221070.2199510.2565326422781227405@kernel.org>
In-Reply-To: <20261110144321.94096-1-pocj8ur4in@gmail.com>
References: <20261110144321.94096-1-pocj8ur4in@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In xfrm_nat_keepalive_state_updated()
  (net/xfrm/xfrm_nat_keepalive.c:294), the new insert path queues the…
- [Medium] Before this patch, inserting or deleting a keepalive SA while
  the per-netns nat_keepalive_work timer was pending did nothing…

--

xfrm: reschedule NAT keepalive work for new states

When a non-dead state is added, xfrm_nat_keepalive_state_updated() now
calls mod_delayed_work() instead of schedule_delayed_work(), so the
per-netns NAT keepalive worker runs right away. Before, it waited for an
older, longer pending deadline. Deleted states still use
schedule_delayed_work().

> diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
> index 8ed30e6c263b6..6814f9063969e 100644
> --- a/net/xfrm/xfrm_nat_keepalive.c
> +++ b/net/xfrm/xfrm_nat_keepalive.c
> @@ -288,7 +288,10 @@ void xfrm_nat_keepalive_state_updated(struct xfrm_state *x)
>  		return;
>  
>  	net = xs_net(x);
> -	schedule_delayed_work(&net->xfrm.nat_keepalive_work, 0);
> +	if (x->km.state == XFRM_STATE_DEAD)
> +		schedule_delayed_work(&net->xfrm.nat_keepalive_work, 0);
> +	else
> +		mod_delayed_work(system_wq, &net->xfrm.nat_keepalive_work, 0);

[Severity: High]
Should this be system_percpu_wq instead of system_wq?

The DEAD branch above and the re-arm at the end of nat_keepalive_work()
both use schedule_delayed_work(), which queues on system_percpu_wq:

include/linux/workqueue.h:
static inline bool schedule_delayed_work(struct delayed_work *dwork,
					 unsigned long delay)
{
	return queue_delayed_work(system_percpu_wq, dwork, delay);
}

workqueue_init_early() allocates these as two separate workqueues, and
system_wq is marked deprecated:

	system_wq = alloc_workqueue("events", WQ_PERCPU | __WQ_DEPRECATED, 0);
	system_percpu_wq = alloc_workqueue("events", WQ_PERCPU, 0);

So the first keepalive SA insert will trigger the "enqueued on deprecated
workqueue" pr_warn_once() in __queue_work().

The bigger concern is non-reentrancy. In __queue_work(), the check that
stops the same work item running on two CPUs only applies when it is
requeued on the same workqueue:

		if (worker && worker->current_pwq->wq == wq) {

Say nat_keepalive_work() is already running from system_percpu_wq on one
CPU, so PENDING is clear. An SA insert on another CPU then calls
mod_delayed_work(system_wq, ..., 0). Can a second instance start and run
at the same time as the first?

If it can, the first instance computed its deadline without the new
state. If it finishes after the second one has started, its re-arm wins:

CPU X (instance A)                   CPU Y (instance B)
nat_keepalive_work()
                                     nat_keepalive_work()
  schedule_delayed_work(long)
    sets PENDING
                                       schedule_delayed_work(short)
                                         PENDING already set, no-op

Wouldn't the new SA then wait for the old long deadline, which is the
problem this patch is trying to fix? Before this patch the requeue went
to the same workqueue, so B was queued behind A on A's pool and B's
deadline won.

Two concurrent instances could also both reach the send branch in
nat_keepalive_work_single() for the same state, because that branch does
not update nat_keepalive_expiration:

	} else {
		next_run = ctx->now + interval;
		nat_keepalive_init(&ka, x);
		send_keepalive = true;
	}

That would send duplicate keepalives.

Netns teardown is also affected. xfrm_net_exit()->
xfrm_nat_keepalive_net_fini() does:

	disable_delayed_work_sync(&net->xfrm.nat_keepalive_work);

start_flush_work() only looks for an executing worker on the pool
recorded in work->data, which belongs to the instance that started
last. Could an earlier instance still be walking net->xfrm.state_all
under xfrm_state_lock while xfrm_state_fini() runs and struct net is
freed?

Using mod_delayed_work(system_percpu_wq, ...) here would keep every
enqueue on the same workqueue and would still move the pending deadline.

[Severity: Medium]
Does this remove the rate limit on full state walks?

Before this patch, inserting a keepalive SA while the timer was pending
did nothing. Full walks were limited to one per computed next_run.

Now every non-DEAD call from __xfrm_state_insert() forces an immediate
run, or queues another run if one is already executing. This covers add,
ACQ replacement in update, migrate and rekey.

Each run calls xfrm_state_walk(), which holds net->xfrm.xfrm_state_lock
with BH disabled while it steps over every ESP state that has no
keepalive interval:

nat_keepalive_work_collect() {
	...
	if (!READ_ONCE(x->nat_keepalive_interval))
		return 0;
	...
}

The lock is only dropped after a batch of 16 keepalive states is
collected, so each run costs O(N) in the number of ESP states.

A user with CAP_NET_ADMIN in its own user and net namespace, and many
ESP SAs, could repeatedly send XFRM_MSG_NEWSA and XFRM_MSG_DELSA for a
single keepalive SA:

xfrm_add_sa()
  xfrm_state_add()
    __xfrm_state_insert()
      xfrm_nat_keepalive_state_updated()
        mod_delayed_work(..., 0)
          nat_keepalive_work()
            xfrm_state_walk()

Would each pair of messages then force another full walk in a shared
system kworker, with the CPU time not charged to the caller?

The commit message doesn't cover this. Would it work to move the timer
only when it is set to fire later than the new state's interval allows?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110144321.94096-1-pocj8ur4in%40gmail.com
