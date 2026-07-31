Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AF830567D;
	Fri, 31 Jul 2026 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785461431; cv=none; b=sXjlFeAct4Ec0X3aPJvmWSbJ+H/5JVlVgzjAiW41YHDgyAoumJdXl2q+cKXYUVHrEhp4N/rxrzdNy56g4G0EjxuT/XCQlkq00kzFVxGWdljUB59OxTTis8WHsjP9BehuBry8rd84zSIMb4Q81++XL+J8x66E9dNO9/MMnRWQ/iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785461431; c=relaxed/simple;
	bh=fZi4jVfPsujVUdGj8sZ0uehBREvQuWGw4rD2/QI7/Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spWv09RHOtTlrSpVEkY1tpHeBwYrKfPhYp84hWvTxAsBNYttb18w0Ob+Iykcegjgoa3oi4NUIQGdq1Xrr78ZoIIchu6Z+fl85cBSaPk9h368M0GYAIL7j0tCttlYS0DvDxmtIqqPMvInvpc1nlhBqobYhHGs+qtYHuHhfzsOceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ssu1gW1C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ssu1gW1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8BA1F00A3A;
	Fri, 31 Jul 2026 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785461429;
	bh=LRjT+KAX8gcZXAISOAOkgM/iAzcME+Bdl+E5ixUjZBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ssu1gW1CqaAPzsPfOjudekF4xh4DW0o3HAu/JKsKyNDx6PlqUxJwwbNzFtludx0zI
	 3S4tggL6IVdQJHA2V2Zt+ZCC6fh2ybtx+0F7WEZ5/NPQAalkymrLMMJh4r1r9ugxdx
	 muw2AE40/UhTdECPHEgO7qpkK8iXhoSklFbIl1cfMs/UyQmLnkT7UKircOyxSkpKzc
	 sR5KVvJsehD1pt3DDkDqGRL2L5vBWfaTbEt1a/QYDssrZIIesnvEsLHJ8P0vnIixjL
	 6jqlgeECrj1lct7521y94G3Mk4HVCPAwiuHK8QfLGEekODWJbEsdKLL6sSmah8rsHM
	 rsgawGhex4hhg==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v22 net-next 04/12] net/nebula-matrix: add channel layer
Date: Thu, 30 Jul 2026 18:30:28 -0700
Message-ID: <20260731013028.745006-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723040110.91410-5-illusion.wang@nebula-matrix.com>
References: <20260723040110.91410-5-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [4]: [PATCH v22 net-next 04/12] net/nebula-matrix: add channel layer ---
commit 52547754390ebdc264a4b6a5c891b4ecfbcd56a7
Author: illusion wang <illusion.wang@nebula-matrix.com>

net/nebula-matrix: add channel layer

This patch introduces a channel management layer for the Nebula Matrix
driver to handle communication between different components and drivers.
It adds support for mailbox channels, queue initialization, hardware
abstraction, and interrupt-driven receive paths with waitqueues for
transmission.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> new file mode 100644
> index 0000000000000..85218f826f59d
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
[ ... ]
> +static void nbl_chan_clean_queue(struct nbl_channel_mgt *chan_mgt,
> +				 struct nbl_chan_info *chan_info)
> +{
[ ... ]
> +	rxq->next_to_clean = next_to_clean;
> +	/* add READ_ONCE check to avoid UAF when clean_task is null*/
> +	if (more_work && READ_ONCE(chan_info->clean_task))
> +		schedule_work(chan_info->clean_task);
> +}

[Severity: High]
Can this result in a NULL pointer dereference if chan_info->clean_task is
cleared concurrently?

When calling schedule_work(chan_info->clean_task), the compiler fetches the
pointer from memory a second time. If nbl_chan_teardown_queue() sets
chan_info->clean_task = NULL right after the READ_ONCE() check but before
the schedule_work() call, wouldn't a NULL pointer be passed to the workqueue
API? Could a local variable be used to cache the pointer to avoid this?

[ ... ]
> +static int nbl_chan_teardown_queue(struct nbl_channel_mgt *chan_mgt,
> +				   u8 chan_type)
> +{
> +	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
> +	struct nbl_chan_waitqueue_head *wait_head;
> +	u16 i;
> +
> +	/* Step 1: Mark shutdown flag, reject all new send requests */
> +	WRITE_ONCE(chan_info->shutdown, true);
> +
> +	/* Stop hardware queues */
> +	nbl_chan_stop_queue(chan_mgt);
> +
> +	/* Cancel any pending cleanup work */
> +	if (chan_info->clean_task) {
> +		cancel_work_sync(chan_info->clean_task);
> +		chan_info->clean_task = NULL;
> +	}
> +	for (i = 0; i < chan_info->num_txq_entries; i++) {
[ ... ]
> +	}
> +
> +	/* Step 2: Wait all in-flight send_msg threads exit via counter */
> +	while (atomic_read(&chan_info->inflight_tx_cnt) != 0) {
> +		/* synchronize atomic counter load with other CPUs */
> +		smp_rmb();
> +		usleep_range(100, 1000);
> +	}
> +	return 0;
> +}

[Severity: High]
Is cancel_work_sync() called too early here?

Since cancel_work_sync() is called before waiting for inflight_tx_cnt to
drain, could an in-flight sender thread currently executing its polling loop
call queue_work() concurrently after the cancellation is finished? This
might leave pending work in the queue that executes after the device has been
torn down, causing a use-after-free regression.

[ ... ]
> +static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
> +			     struct nbl_chan_send_info *chan_send)
> +{
[ ... ]
> +	/* Reject new send if shutdown already triggered */
> +	if (READ_ONCE(chan_info->shutdown))
> +		return -ESHUTDOWN;
> +	/* Ensure shutdown load is ordered before inflight counter increment */
> +	smp_rmb();
> +	atomic_inc(&chan_info->inflight_tx_cnt);

[Severity: High]
Does this sequence create a TOCTOU race with nbl_chan_teardown_queue()?

If a sender thread checks READ_ONCE(chan_info->shutdown) and it is false,
but the thread is then preempted before incrementing inflight_tx_cnt,
could nbl_chan_teardown_queue() set shutdown = true, observe the counter
is 0, and proceed to free resources? When the sender resumes, wouldn't it
increment the counter and access destroyed queues?

[ ... ]
> +	if (test_bit(NBL_CHAN_INTERRUPT_READY, chan_info->state)) {
> +		spin_lock_irq(&wait_head->status_lock);
> +		while (!READ_ONCE(wait_head->acked)) {
> +			spin_unlock_irq(&wait_head->status_lock);
> +			ret = wait_event_timeout(wait_head->wait_queue,
> +						 READ_ONCE(wait_head->acked),
> +						 NBL_CHAN_ACK_WAIT_TIME);
> +			spin_lock_irq(&wait_head->status_lock);
> +
> +			if (READ_ONCE(chan_info->shutdown)) {
> +				ret = -ESHUTDOWN;
> +				goto inflight_dec_out;
> +			}

[Severity: Critical]
Does this error path leak the spinlock and leave interrupts disabled?

Since spin_lock_irq(&wait_head->status_lock) was called right before this
check, and the inflight_dec_out label simply decrements the counter and
returns, shouldn't spin_unlock_irq() be called before taking this goto?

> +			if (ret == 0) {
> +				if (READ_ONCE(wait_head->status) ==
> +				    NBL_MBX_STATUS_WAITING) {
> +					wait_head->status =
> +						NBL_MBX_STATUS_TIMEOUT;
> +					wait_head->acked = 0;
> +					wait_head->ack_data = NULL;
> +					wait_head->ack_data_len = 0;
> +				}
> +				spin_unlock_irq(&wait_head->status_lock);
> +				dev_err(dev,
> +					"Channel waiting ack failed, message type: %d, msg id: %u\n",
> +					chan_send->msg_type, msgid);
> +				goto inflight_dec_out;
> +			}

[Severity: High]
When wait_event_timeout() times out, it returns 0. If this path is taken,
will the function incorrectly return 0 (success) instead of -ETIMEDOUT to
the caller? This might lead callers to believe the transmission succeeded and
read uninitialized response buffers.

[ ... ]
> +	/* Polling: only init/deinit, add shutdown detect to avoid deadlock */
> +	while (i--) {
> +		if (READ_ONCE(chan_info->shutdown)) {
> +			ret = -ESHUTDOWN;
> +			goto inflight_dec_out;
> +		}
> +		/* Order shutdown read before accessing clean_task/workqueue */
> +		smp_rmb();
> +		if (READ_ONCE(chan_info->clean_task) && common->wq)
> +			queue_work(common->wq, chan_info->clean_task);

[Severity: High]
Could this suffer from the same double-read TOCTOU race as in
nbl_chan_clean_queue()?

If chan_info->clean_task is set to NULL after the READ_ONCE() check but
before queue_work() evaluates its arguments, could this pass a NULL pointer
to the workqueue core?
