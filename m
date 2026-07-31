Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A16310784;
	Fri, 31 Jul 2026 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785461440; cv=none; b=HkqUWuAIWP6pxVH0JmslCuk3sSTRSKxJ3g68WA/w4a8932wq1gjRGr6ncWmbBBdjIl4huZvZ10Sx1InK7eHnDOK3YKaQ4mp63xX2MhaEmmsVoH4S/s2LTt3qC/Bu3+1mVkzTHJ75OQGTPRoTDszLA7KzJXep8mwTISPFDkrogts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785461440; c=relaxed/simple;
	bh=xPDrJaqgw7+MdDETG7rXo/iSyyI6oJoqyq5irHWafUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KELDGz5dXb8XQGmsMirXGpyoy+9420cyrtlWcQZNvaUnhI6DyIt0YHVvThbNOt+SvyT1iWEEab6Jz/vKzYQcc/Xbn+Gnhnx/c61IFAnrBX9x0Qc7O2wdSkLvi3G1ee1LWsYqww50kbCtHPsGGbf3oT6CJTQ7mPPu9Ir+FB9aiA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkYhe+ZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkYhe+ZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606A21F000E9;
	Fri, 31 Jul 2026 01:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785461438;
	bh=rCZ/vR92USILll2U9ywKs1c2qZqbzrvcbQrXrq9o/Qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EkYhe+ZXCUbYm6wolRaVPbfFG/i/M28VpJDsdTBfS+cHUQok98kY9WckarHRzNqf7
	 25nKgJIjwFEAx/Dz4tw9ZX0WX0F5IQ1eHIWuecvug401slseiaYJzRJWEiJ+i0lZch
	 JDJwrzV0VRiJ0TIQHhe2h6gUmTJVm+DH4Mzxobjl4n6TiBmd7/iSBamNu8jYAYAv2W
	 y4Phn97WYQJncaIwoCG6116dw2lMo0nq9pCOfGpSL8eoTa/9fBgh+7TytwMlTqXpr9
	 WEsTz49RMvc7FT4vMnXiyVX4rMnn8Gk65iQDaOQfzo+j9t3lG7uAVIUCzkOkZPfdks
	 ISsARoRmLPfAA==
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
Subject: Re: [PATCH v22 net-next 12/12] net/nebula-matrix: add common dev start/stop operation
Date: Thu, 30 Jul 2026 18:30:37 -0700
Message-ID: <20260731013037.745372-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723040110.91410-13-illusion.wang@nebula-matrix.com>
References: <20260723040110.91410-13-illusion.wang@nebula-matrix.com>
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
--- Patch [12]: [PATCH v22 net-next 12/12] net/nebula-matrix: add common dev start/stop operation ---
commit 87deb0868f9edbdb2f584ecc55b9f7839da1fb23
Author: illusion wang <illusion.wang@nebula-matrix.com>

net/nebula-matrix: add common dev start/stop operation

This patch adds device start/stop helper functions for MSI-X mapping and 
mailbox interrupts. It creates an unbound global workqueue for mailbox tasks. 
It also extends channel TX logic with polling fallback.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
[ ... ]
> +int nbl_common_create_wq(struct nbl_common_info *common)
> +{
> +	char wq_name[32];
> +
> +	snprintf(wq_name, sizeof(wq_name), "nbl_wq_%s", pci_name(common->pdev));
> +	common->wq = alloc_workqueue(wq_name, WQ_UNBOUND, 0);

[Severity: Medium]
Is wq_name safely used as the format string here?

Since alloc_workqueue() takes a printf-style format string, passing the
variable directly can cause a format string vulnerability if the PCI name
contains format specifiers. Should this be updated to:
alloc_workqueue("%s", WQ_UNBOUND, 0, wq_name)?

[Severity: Medium]
This patch creates a dedicated workqueue for mailbox tasks, but does the
cleanup task occasionally reschedule itself to the default system workqueue?

In nbl_chan_clean_queue():

    if (more_work && READ_ONCE(chan_info->clean_task))
        schedule_work(chan_info->clean_task);

Should this use queue_work(common->wq, ...) instead to ensure the task
stays on the dedicated workqueue?

> +	if (!common->wq) {
> +		pr_err("Failed to create workqueue nbl_wq\n");
> +		goto alloc_wq_failed;
> +	}
> +
> +	return 0;
> +alloc_wq_failed:
> +	return -ENOMEM;
> +}
[ ... ]
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> @@ -725,6 +725,7 @@ static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
>  	struct nbl_common_info *common = chan_mgt->common;
>  	struct nbl_chan_waitqueue_head *wait_head;
>  	struct nbl_chan_tx_param tx_param = { 0 };
> +	int i = NBL_CHAN_TX_WAIT_ACK_TIMES;
>  	struct nbl_chan_info *chan_info =
>  		chan_mgt->chan_info[NBL_CHAN_TYPE_MAILBOX];
>  	struct device *dev = common->dev;

[Severity: High]
Does checking the shutdown flag before incrementing the inflight counter
create a race condition?

Earlier in nbl_chan_send_msg():

    if (READ_ONCE(chan_info->shutdown))
        return -ESHUTDOWN;
    /* Ensure shutdown load is ordered before inflight counter increment */
    smp_rmb();
    atomic_inc(&chan_info->inflight_tx_cnt);

If a thread is preempted after checking the shutdown flag but before
incrementing the counter, could another thread set the shutdown flag, observe
a zero counter, and free the queues? When the first thread resumes, it would
operate on the freed queues. Should the counter be incremented before checking
the flag?

[Severity: High]
When waiting for an interrupt ack in nbl_chan_send_msg(), does a timeout
correctly return an error?

    if (ret == 0) {
        if (READ_ONCE(wait_head->status) ==
            NBL_MBX_STATUS_WAITING) {
            wait_head->status =
                NBL_MBX_STATUS_TIMEOUT;
            wait_head->acked = 0;
            wait_head->ack_data = NULL;
            wait_head->ack_data_len = 0;
        }
        spin_unlock_irq(&wait_head->status_lock);
        dev_err(dev,
            "Channel waiting ack failed, message type: %d, msg id: %u\n",
            chan_send->msg_type, msgid);
        goto inflight_dec_out;
    }

Because ret is 0 from wait_event_timeout() and isn't reassigned to an error
code like -ETIMEDOUT, will the function return 0 and cause the caller to
consume uninitialized or stale response data?

> @@ -852,6 +853,49 @@ static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
>  		goto inflight_dec_out;
>  	}
>  
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
Can this sequence race with device teardown?

In nbl_dev_remove_common_dev(), the teardown sequence appears to set the
task to NULL and cancels the work before the shutdown flag is set:

nbl_dev_remove_common_dev()
    nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
    cancel_work_sync(&common_dev->clean_mbx_task);
    nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);

If a sender bypasses the shutdown check and enters the polling loop,
can the double read of chan_info->clean_task allow queue_work()
to be called with a NULL pointer, or to queue the work after it was already
cancelled, leading to a use-after-free when the work accesses the freed queues?

> +
> +		spin_lock_irq(&wait_head->status_lock);
> +		if (READ_ONCE(wait_head->acked)) {
[ ... ]
