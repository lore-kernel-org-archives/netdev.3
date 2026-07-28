Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1F32192F9;
	Tue, 28 Jul 2026 00:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199306; cv=none; b=s8KsxYB+3/XBSnJNC8iESjv3+U2bCY/T/FLTOu284XlPMQZpSlCmBfojU50jofKQ6DfdzDuNX1lEQdQQ24noO8uCz/cL0aDPrj4gou197XYAA+VBOW76el6PEdxKxo9Ch6ygD6zMGi+sBqiu6orr5r3B5oSLKBFZDe+2qTzuHNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199306; c=relaxed/simple;
	bh=OBaMjcZ5CqbplYtUvK7RIfu/p9R3uotKC/8/fCT6Zdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKty6sYiY3CZvpcqzOYsg/FhL4wxicPo546pijqLuR8DmeansyFSokXSqPLwio53sjF0f2R0ZCCpLVZji0Kinyb1fCoxPWrZ/i8E6Nsl5Ff+9aN+0s+5TUgfYARWeEG11LKZLQdQAiUPZMkJ1IsRWdFw5ab4RkBivXJed2Meiyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAiYIIV/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAiYIIV/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B705F1F000E9;
	Tue, 28 Jul 2026 00:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785199305;
	bh=wOg/cOfgphBOkOh2okQcEfs9e9H1tdnk7lScVuyFRF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LAiYIIV/Uv48Gj9T8rJPm9xlvXgVUxKzQ/gpxdtXf+DXZK3H0BkMayT3wb7hjahm9
	 6ecQy6y38njnFQtaQUJmF28VCDmLqbcVyOOupcSGH2MUO19VRIT2Ol5mXOvliiNVnV
	 MDpKbLRB4h0dwxLu7JT4nQ/Ov0x+BpuyQEISRj6HqQMjVD74atR9LWRa5qhbPvVHrg
	 slORHqNjjv8GbPm3JjhIxyrfQx/JzFuj3gOj1V5Ux6c9h8eKS3/vJZFWN8v9QQrb9o
	 Lf7IOgbAnPTLBznkySJLDMKzAPSgRMsRvzGwGcQqQOVdQNAHTy3J77o1MawCjgN3yI
	 6vJoit+zoVdGQ==
From: Jakub Kicinski <kuba@kernel.org>
To: satishkh@cisco.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leitao@debian.org,
	sebaddel@cisco.com
Subject: Re: [PATCH net-next v12 05/12] enic: add admin CQ service with MSI-X interrupt and workqueue polling
Date: Mon, 27 Jul 2026 17:41:43 -0700
Message-ID: <20260728004143.2979882-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260719-enic-sriov-v2-admin-channel-v2-v12-5-6ff2c617001d@cisco.com>
References: <20260719-enic-sriov-v2-admin-channel-v2-v12-5-6ff2c617001d@cisco.com>
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
--- Patch [5]: [PATCH net-next v12 05/12] enic: add admin CQ service with MSI-X interrupt and workqueue polling ---
commit 91aacafcb0c0e3c10237617f2d69726711e41d5c
Author: Satish Kharat <satishkh@cisco.com>

enic: add admin CQ service with MSI-X interrupt and workqueue polling

This commit adds a completion queue service for the admin channel work
queue and receive queue. It sets up an MSI-X interrupt that schedules
a workqueue poller to drain completions and dispatch received messages.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
> index b2be420921064..9358165263d98 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_admin.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
[ ... ]
> +unsigned int enic_admin_rq_cq_service(struct enic *enic)
> +{
[ ... ]
> +		enic_admin_msg_enqueue(enic, buf->os_buf, bytes_written);
> +
> +next_desc:
> +		enic_admin_rq_buf_clean(rq, rq->to_clean);
> +		rq->to_clean = rq->to_clean->next;
> +		rq->ring.desc_avail++;
> +
> +		vnic_cq_inc_to_clean(cq);
> +		work++;
> +		desc = vnic_cq_to_clean(cq);
> +	}
> +
> +	if (enic_admin_rq_fill(enic, GFP_KERNEL) && net_ratelimit())
> +		netdev_warn(enic->netdev,
> +			    "admin RQ refill failed\n");

[Severity: High]
What happens if enic_admin_rq_fill() fails to allocate memory here?

If it fails under memory pressure and returns without posting new buffers
to the hardware, does the admin channel permanently stall? It looks like
there is no retry timer or fallback mechanism to refill the queue later.
Without available receive buffers, the hardware won't be able to post further
receive completions, meaning the MSI-X interrupt won't fire again to recover
the channel.

> +
> +	return work;
> +}
[ ... ]
> @@ -220,6 +500,19 @@ int enic_admin_channel_open(struct enic *enic)
>  		return err;
>  	}
>  
> +	spin_lock_init(&enic->admin_msg_lock);
> +	INIT_LIST_HEAD(&enic->admin_msg_list);
> +	INIT_WORK(&enic->admin_msg_work, enic_admin_msg_work_handler);
> +	INIT_WORK(&enic->admin_poll_work, enic_admin_poll_work_handler);
> +
> +	err = enic_admin_setup_intr(enic);
> +	if (err) {
> +		netdev_err(enic->netdev,
> +			   "Admin channel requires MSI-X, SR-IOV unavailable: %d\n",
> +			   err);
> +		goto free_resources;
> +	}
> +
> +	enic_admin_init_resources(enic);

[Severity: High]
Since enic_admin_setup_intr() calls request_irq(), is it possible for an
interrupt to fire before enic_admin_init_resources() initializes the
hardware queues?

If a spurious interrupt arrives immediately after request_irq(), it would
schedule admin_poll_work which then calls enic_admin_rq_cq_service().
Because the ring pointers (such as rq->to_use) haven't been initialized by
enic_admin_init_resources() yet, could this lead to a NULL pointer
dereference or lockless data corruption?

>  
>  	vnic_wq_enable(&enic->admin_wq);
> @@ -239,17 +532,31 @@ int enic_admin_channel_open(struct enic *enic)
