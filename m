Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388E3314B77
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787431807; cv=none; b=nfo9fXKSebeyk/jzK8O90AZFfNJYMOH4DorM/DgmdOfr+UJWBBRX5v7Wu0DQ4ackTgPZutEH87YAH9wRZkDp67LitFU00oDpw9Q/Fx0IxCZlL13istKkM68iyrsb3IFnHDinE35t122AXBwc9JA7CI5/1CgaBE4aoCWZa8su1io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787431807; c=relaxed/simple;
	bh=OgTcMezDOEMx89OLdcyDlF6bhWaard+lF07HW14+0MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7CvuOsXA3/upIjJHAaEmc5fehUFKA4A29URhlsKkxalD3pYIv0eCoje/k4plo/A5IvYKosOKDl9Z1whuG2dt583750k49ywHYrYeSeeQm3XXidZUrCAtCXfHvV68P1yMVUnlB7Iv4CcAimnIcBsVp43dZnLhss4+Wz0R2Pinb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wvuy15ca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wvuy15ca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866231F000E9;
	Sat, 22 Aug 2026 20:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787431805;
	bh=kOjmzHw2qgkIWEUqOS9EYL89FgzRE1JKxiWZn/tI1FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wvuy15ca/E/XvKn9/yHY8rAPzdq1gsgsbGOuZdE/PQFxuVZF8CZV4AVHjlfx9stN+
	 Kzu7Z/sATn3NSCiazTTAZKfRNZkdhquaQOkgUUHVPt4Y9L2hyDtDZx+EK67P01yDej
	 ypDAEVycKow7tWU97g7763elBU897cXxyZ5HhcvUoLODEmePx3KTgu+oZekOmOhp+Z
	 w6IBR9IM+64HCsQGEQCv2AwYfs7hGwQC6BtYU2Q67OGoZNAVANNuwsCDuvaG2F1drn
	 g1SVsbdtarmiBUkIo0NPrDzbgvNbN80P565aIQJe6rEs7NZ3qbxoUTihJVR9CtP1SC
	 4NbrYYe7Jj79g==
From: Jakub Kicinski <kuba@kernel.org>
To: ag@ffroot.co.za
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	wellslutw@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] net: sunplus: fix tx_poll spin_lock missing irqsave in NAPI context
Date: Sat, 22 Aug 2026 13:50:04 -0700
Message-ID: <20260822205004.2253192-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820130159.1584806-1-ag@ffroot.co.za>
References: <20260820130159.1584806-1-ag@ffroot.co.za>
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
net: sunplus: fix tx_poll spin_lock missing irqsave in NAPI context

This converts the comm->tx_lock acquisition in spl2sw_tx_poll() from
spin_lock()/spin_unlock() to spin_lock_irqsave()/spin_unlock_irqrestore(),
reusing the existing flags variable. The stated reason is a possible
same-CPU deadlock against the hardirq handler.

> diff --git a/drivers/net/ethernet/sunplus/spl2sw_int.c b/drivers/net/ethernet/sunplus/spl2sw_int.c
> index a37c9a4c281f0..7e07cd9414347 100644
> --- a/drivers/net/ethernet/sunplus/spl2sw_int.c
> +++ b/drivers/net/ethernet/sunplus/spl2sw_int.c

>     spl2sw_tx_poll() runs in NAPI (softirq) context and acquires
>     comm->tx_lock with plain spin_lock(). The hardirq handler
>     spl2sw_ethernet_interrupt() acquires the same lock, so a hardirq on
>     the same CPU while the NAPI poll holds the lock would deadlock with
>     IRQs disabled. Use spin_lock_irqsave/spin_unlock_irqrestore.

[Severity: Medium]
Is the claim that "The hardirq handler spl2sw_ethernet_interrupt() acquires
the same lock" accurate?

Looking at spl2sw_ethernet_interrupt() in
drivers/net/ethernet/sunplus/spl2sw_int.c, every acquisition there is of
comm->int_mask_lock, not comm->tx_lock:

	if (status & MAC_INT_TX) {
		/* Disable TX interrupts. */
		spin_lock(&comm->int_mask_lock);
		mask = readl(comm->l2sw_reg_base + L2SW_SW_INT_MASK_0);
		mask |= MAC_INT_TX;
		writel(mask, comm->l2sw_reg_base + L2SW_SW_INT_MASK_0);
		spin_unlock(&comm->int_mask_lock);
		...
			napi_schedule(&comm->tx_napi);
	}

The other acquirers of comm->tx_lock are spl2sw_ethernet_start_xmit() and
spl2sw_ethernet_tx_timeout() in drivers/net/ethernet/sunplus/spl2sw_driver.c,
both in non-hardirq context and both already using spin_lock_irqsave().
With spl2sw_tx_poll() that appears to be the complete set of acquirers, and
none of them run in hardirq context.

Does that mean the plain spin_lock() in the softirq-only holder was already
correct, and the described same-CPU self-deadlock cannot occur?

The declaration in drivers/net/ethernet/sunplus/spl2sw_define.h also seems to
draw the distinction between the two locks:

	spinlock_t tx_lock;		/* spinlock for accessing tx buffer */

> @@ -147,7 +147,7 @@ int spl2sw_tx_poll(struct napi_struct *napi, int budget)
>  	u32 cmd;
>  	int i;
>  
> -	spin_lock(&comm->tx_lock);
> +	spin_lock_irqsave(&comm->tx_lock, flags);
>  
>  	tx_done_pos = comm->tx_done_pos;
>  	while (((tx_done_pos != comm->tx_pos) || (comm->tx_desc_full == 1)) && budget_left) {

[Severity: Medium]
With no hardirq contender for comm->tx_lock, does this change simply extend
the hard-IRQ-disabled window over the whole TX reclaim path?

The section now covered with interrupts off in spl2sw_tx_poll() is up to a
full NAPI budget of descriptors, each doing:

		dma_unmap_single(&comm->pdev->dev, skbinfo->mapping, skbinfo->len,
				 DMA_TO_DEVICE);
		skbinfo->mapping = 0;
		dev_kfree_skb_irq(skbinfo->skb);

followed by the netif_wake_queue() loop over MAX_NETDEV_NUM devices.

If the intent is only to make the tx_lock users look consistent with
spl2sw_ethernet_start_xmit() and spl2sw_ethernet_tx_timeout(), could the
changelog say that and drop the deadlock description, along with the "fix"
in the subject?

> -	spin_unlock(&comm->tx_lock);
> +	spin_unlock_irqrestore(&comm->tx_lock, flags);
>  
>  	spin_lock_irqsave(&comm->int_mask_lock, flags);
>  	mask = readl(comm->l2sw_reg_base + L2SW_SW_INT_MASK_0);

[Severity: Low]
One note on tagging: a patch described as fixing an IRQs-disabled deadlock
would normally carry a Fixes: tag, and git blame shows the plain
spin_lock(&comm->tx_lock) here came in with fd3040b9394c ("net: ethernet:
Add driver for Sunplus SP7021").

Given that spl2sw_ethernet_interrupt() only ever takes comm->int_mask_lock,
would such a tag point at a bug that was never there? Rewording the
changelog as a cleanup instead of a fix seems like the way to avoid the
question entirely.
