Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF4125B0AB;
	Sat, 11 Jul 2026 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783788401; cv=none; b=dSGQqrV8cPkCUREG0s6x9oDEjdnufYotx2ApkJg649duwrJdKa/So57VdF5K6Nw1kOb6TFNAeSm0+20q5wuJqVXL2LqN5VHfP+9g5Ai0r6WM62SGeIaSQH32amHtMw5eVgJCP/0TsfuCxrksrMTBn6QAMlIsJFGs5FdvokdTNfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783788401; c=relaxed/simple;
	bh=NdVb64UP9ak9CXCVZ8IQzR2f51jrsCTHtGwUyIknODs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=un1FhxB0Bee3x8XtbmsM9n/FTtpeJXgLqgV5ydCdvRViMNpD835TcScAuTVv4QxCqpAIm7pey6msrEN57bPPwcQkHKa74yhrgaUi/lbkIwiaHq/SFRQwLjwCZMKYySGiEFBARzEqPELJvE06/5fTGwBh5XN5HcHFyDTzme7QKTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLH2GSGM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLH2GSGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD471F000E9;
	Sat, 11 Jul 2026 16:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783788399;
	bh=cM9LgFsbZTDjYiy18HwMAuC8kGSx4JeoT+KMqviKn+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TLH2GSGMPMW19im8G6zP7jRQiBvHngY9bfqAQ1Bu/WlIrIrrrFidO3qMaHMnrjJTd
	 ETMpa0s8pocaLR80UhvvsICjmhg3C+QWn00jKECJJhmfkDoOkMDQBXRcKWvNMDQX9X
	 7fM3jIBuqcYQniZZhbZLhbRYMHATliqIFw115GOCKwwx4Yy2bi3YTiQBoNnVkBnejg
	 N3SN9ilY4w89Pa68wELxpDEb/Yq7nOZpVFsQOxCo3ffj0dxqBU+E8+W+66Z7d7xZPR
	 Fq8U2Z+AC7TerkT3M1PMw2ZpSwODH9Dn2vmdYxkI3Ll62jCaU4/q7mouvbZL1Fk53O
	 RQdnBaGUTRpVg==
From: Simon Horman <horms@kernel.org>
To: marco.crivellari@suse.com
Cc: Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	tj@kernel.org,
	jiangshanlai@gmail.com,
	frederic@kernel.org,
	bigeasy@linutronix.de,
	mhocko@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	enelsonmoore@gmail.com,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ibmvnic: Move long delayed work on system_dfl_long_wq
Date: Sat, 11 Jul 2026 17:44:36 +0100
Message-ID: <20260711164434.1691221-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706134033.244295-2-marco.crivellari@suse.com>
References: <20260706134033.244295-2-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev

Simon says: While I think that the pre-existing issue flagged below is
            orthogonal to this patch, I wonder if you could respond
	    to the question regarding scope raised in the first
	    issue flagged below.

---
    ibmvnic: Move long delayed work on system_dfl_long_wq

This commit changes the code to enqueue delayed reset work items using
system_dfl_long_wq instead of the per-cpu system_long_wq. The intent is to
allow these unbound, long-running works to benefit from scheduler task
placement.

[ ... ]

>     Since the workqueue work doesn't rely on per-cpu variables, there is no
>     obvious reason that justify the use of a per-cpu workqueue. So change
>     system_long_wq with system_dfl_long_wq so that the work may benefit from
>     scheduler task placement.

[Severity: Medium]
Will this leave the primary reset path bound to the per-cpu system_long_wq?

While this patch partially migrates delayed reset works to system_dfl_long_wq,
the initial reset work enqueued in ibmvnic_reset() is still bound to the
per-CPU system_long_wq:

drivers/net/ethernet/ibm/ibmvnic.c:ibmvnic_reset() {
    ...
    rwi->reset_reason = reason;
    list_add_tail(&rwi->list, &adapter->rwi_list);
    netdev_dbg(adapter->netdev, "Scheduling reset (reason %s)\n",
               reset_reason_to_string(reason));
    queue_work(system_long_wq, &adapter->ibmvnic_reset);
    ...
}

Should queue_work(system_long_wq, ...) also be migrated to ensure the
reset workload fully benefits from scheduler placement as intended?

> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 5a510eed335ea..a1c01c9820d20 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
[ ... ]
> @@ -3267,7 +3267,7 @@ static void __ibmvnic_reset(struct work_struct *work)
>  	spin_lock(&adapter->rwi_lock);

[Severity: High]
This is a pre-existing issue, but can this plain spin_lock() cause a
deadlock against the tasklet context?

The workqueue handler __ibmvnic_reset() acquires adapter->rwi_lock using a
plain spin_lock() without disabling softirqs.

If a hardware interrupt fires on the same CPU while this lock is held, local
softirqs are processed on return, invoking ibmvnic_tasklet().

If the tasklet handles CRQ events via ibmvnic_handle_crq() and triggers a
reset (e.g., IBMVNIC_DEVICE_FAILOVER):

ibmvnic_reset()
    spin_lock_irqsave(&adapter->rwi_lock, flags);

Will the tasklet spin forever trying to acquire rwi_lock since the preempted
__ibmvnic_reset() already holds it?

>  	if (!list_empty(&adapter->rwi_list)) {
>  		if (test_and_set_bit_lock(0, &adapter->resetting)) {
> -			queue_delayed_work(system_long_wq,
> +			queue_delayed_work(system_dfl_long_wq,
>  					   &adapter->ibmvnic_delayed_reset,
>  					   IBMVNIC_RESET_DELAY);
>  		} else {
