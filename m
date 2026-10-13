Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD131618B;
	Tue, 13 Oct 2026 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885433; cv=none; b=dUnvKGCpYfpw7fz2Q9A71ttpW2vG5/4rXLx4tJ3NlG0d112i+BnjbgsFzQrqQ1rKnY79b2OIGoz8Y+jah+wXqJ6MtmUfGkH0VUZGmgUG6Sp6xnu7BKETTXWX4n3VNeG4o1Zr2UZ+grcJ+s91fy5sF8wIjxgvJRGz9afZuc3n+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885433; c=relaxed/simple;
	bh=t2Qo3ECCQqCJBwajFAp+fsRQ3I/abKrecMp8TwIjkMA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ti2oKinJiYo5e35vLR+2xU+IrzOMNcKOCxh9ydljenZkG836PwbzbLo8RQICJB1tgCH0lhOAXBpI2tL44SqsHQ0HdrYPR/DNBsO9iAy2u5zRvYGK/MTNONyGu4nQ6uPpcalv2xAfL/v8wpLpotvix2DRLYGKdTdmEsHldp0CNM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efp4fUSq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efp4fUSq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083031F000FF;
	Tue, 13 Oct 2026 09:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791885431;
	bh=if0uNjh4h/CYQ+sEFDBGtCC3viO1OAf/zhF4iUSK9rg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=efp4fUSqhgtGoB0kgxmQ54Pvr2rFZOAGNAmKFtinrGIrgfpDzCt8y3N/CUapywHg8
	 8JHSJ4QYkpMBwaULtaBS2XXFyE4CY93Kp/z3782b5kV1vru62Fg5PmXMTDpryLhOyX
	 gjyqu7jo6eXW2o2zI9NZTB7EEl8NBOk6lpiYal4j6yjKo7qpi2jxA+KZjzWqrpj8zK
	 amAHpae9KXSRSPNyZyxEM9fO+e7tgwnFaJrDgCsOgRzNJGn222ICe35QHrBMwZy7QS
	 dJkvRbnbzDAPmijhov0jMe4XclMl2cMPsepHj/b4tJvRa0HsnZMy99asAQPdTOD6gj
	 ubspBao8/3ePw==
Subject: Re: [PATCH net-next v4 1/6] ibmvnic: Move long delayed work on
 system_dfl_long_wq
From: netdev-bot+sashiko@kernel.org
To: marco.crivellari@suse.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org,
 jiangshanlai@gmail.com, frederic@kernel.org, bigeasy@linutronix.de,
 mhocko@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 enelsonmoore@gmail.com, linux-usb@vger.kernel.org
Date: Tue, 13 Oct 2026 09:57:10 +0000
Message-ID: <179188543058.434549.5512079399970642953@kernel.org>
In-Reply-To: <20261012095452.135828-2-marco.crivellari@suse.com>
References: <20261012095452.135828-2-marco.crivellari@suse.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message does not match all of the diff.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  edits a call inside the affected critical section.
- [High] This problem wasn't introduced by this patch, but
  ibmvnic_reset() can call ibmvnic_close(), which may sleep, from atomic…
- [Medium] This problem wasn't introduced by this patch, but device
  removal can leak queued reset requests.

--

ibmvnic: Move long delayed work on system_dfl_long_wq

This commit moves the ibmvnic reset work items from the per-cpu
system_long_wq to the unbound system_dfl_long_wq. It converts the two
queue_delayed_work() calls in __ibmvnic_reset() and the queue_work() call
in ibmvnic_reset().

> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 5a510eed335ea..d4c284c8ef437 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c

[ ... ]

> @@ -3267,7 +3267,7 @@ static void __ibmvnic_reset(struct work_struct *work)
>  	spin_lock(&adapter->rwi_lock);
>  	if (!list_empty(&adapter->rwi_list)) {
>  		if (test_and_set_bit_lock(0, &adapter->resetting)) {
> -			queue_delayed_work(system_long_wq,
> +			queue_delayed_work(system_dfl_long_wq,
>  					   &adapter->ibmvnic_delayed_reset,
>  					   IBMVNIC_RESET_DELAY);
>  		} else {

[Severity: High]
This isn't a bug introduced by this patch, but can this plain spin_lock()
on adapter->rwi_lock deadlock against softirq users of the same lock?

__ibmvnic_reset() runs as a work item in process context with BH enabled.
ibmvnic_reset() takes the same lock from softirq context:

ibmvnic_tasklet()
  spin_lock_irqsave(&queue->lock, flags);
  ibmvnic_handle_crq()
    ibmvnic_reset(adapter, VNIC_RESET_MOBILITY);
      spin_lock_irqsave(&adapter->rwi_lock, flags);

The CRQ_INIT and fatal XPORT events in ibmvnic_handle_crq() reach
ibmvnic_reset() the same way. So does the tx watchdog path,
dev_watchdog()->ibmvnic_tx_timeout()->ibmvnic_reset().

Suppose a CRQ interrupt arrives on the worker's CPU while this section
holds rwi_lock. The tasklet can then run on irq_exit and spin forever in
ibmvnic_reset(), with IRQs disabled and crq.lock held.

Would this need spin_lock_bh(), or spin_lock_irqsave() like the other
users? Lockdep should report this as inconsistent {IN-SOFTIRQ-W} ->
{SOFTIRQ-ON-W} usage.

The plain spin_lock() in ibmvnic_remove() looks fine, because it is nested
inside spin_lock_irqsave(&adapter->state_lock, flags).

The plain spin_lock() here appears to date back to commit fd98693cb072
("ibmvnic: Allow queueing resets during probe").

[ ... ]

> @@ -3454,7 +3454,7 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
>  	list_add_tail(&rwi->list, &adapter->rwi_list);

[Severity: Medium]
This is a pre-existing issue, but can the struct ibmvnic_rwi entries added
to adapter->rwi_list here leak when the device is removed?

ibmvnic_remove() sets adapter->state = VNIC_REMOVING and then does:

	flush_work(&adapter->ibmvnic_reset);
	flush_delayed_work(&adapter->ibmvnic_delayed_reset);
	...
	free_netdev(netdev);

__ibmvnic_reset() returns early without touching the list:

	if (adapter->state == VNIC_REMOVING)
		return;

If the worker is already inside its loop, it frees only the current rwi
and breaks out.

ibmvnic_remove() never calls flush_reset_queue(). Are the remaining
entries lost when free_netdev() frees the adapter? The probe failure path
does call flush_reset_queue() before free_netdev().

>  	netdev_dbg(adapter->netdev, "Scheduling reset (reason %s)\n",
>  		   reset_reason_to_string(reason));
> -	queue_work(system_long_wq, &adapter->ibmvnic_reset);
> +	queue_work(system_dfl_long_wq, &adapter->ibmvnic_reset);

[Severity: Low]
This isn't a bug, but the commit message doesn't seem to cover this hunk:

  ibmvnic: Move long delayed work on system_dfl_long_wq

  Currently the code enqueue work items using {queue|mod}_delayed_work(),
  using system_long_wq.

  The function(s) end up calling __queue_delayed_work(), which set a global
  timer that could fire anywhere, enqueuing the work where the timer fired.

ibmvnic doesn't call mod_delayed_work(). Also, this call site is a plain
queue_work() of ibmvnic_reset, not delayed work, so the timer argument
doesn't apply to it.

Every reset request (CRQ events, tx timeout, change-param, sysfs failover)
goes through this call. Before, it ran on the CPU that submitted it. Now
it runs on an unbound pool.

Could the commit message also mention this conversion?

>  
>  	ret = 0;
>  err:

[Severity: High]
This is a pre-existing issue, but can ibmvnic_reset() sleep in atomic
context on the ENOMEM path just below?

	rwi = kzalloc_obj(*rwi, GFP_ATOMIC);
	if (!rwi) {
		ret = ENOMEM;
		goto err;
	}
	...
err:
	/* ibmvnic_close() below can block, so drop the lock first */
	spin_unlock_irqrestore(&adapter->rwi_lock, flags);

	if (ret == ENOMEM)
		ibmvnic_close(netdev);

For most callers, dropping rwi_lock does not leave atomic context.
ibmvnic_tasklet() holds adapter->crq.lock with spin_lock_irqsave() around
ibmvnic_handle_crq(). ibmvnic_tx_timeout() runs from the dev_watchdog
timer.

When failover_pending is false, the close path can block:

ibmvnic_close()
  __ibmvnic_close()
    set_link_state()
      wait_for_completion_timeout(&adapter->init_done, timeout);
  ibmvnic_cleanup()
    synchronize_rcu();

Wouldn't this trigger "scheduling while atomic"? Also, init_done is
completed by CRQ processing in that same tasklet, which is the context
blocked here.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012095452.135828-1-marco.crivellari%40suse.com
