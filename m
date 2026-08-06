Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF11C72630;
	Thu,  6 Aug 2026 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033564; cv=none; b=IYJaIK34kF1Eo/grWX90j/c2FxweVESHgyae+02AiMw06ul3HbikbcreE6RoC2ZGQNTq50aS8hhSP015qs6/qE9Iy2MBJKTyMIZAfwU6E/DCvsZfMoqI+ZY6r4T75G/5x4ebC2UPUREH9X7J0ChETlHL2IpPJ+AoAujwBr9HSiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033564; c=relaxed/simple;
	bh=Zdz4AamfADr3XK46qmwzYaIUsXJGcIMU0hXb306ZFE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkQRSEvWxQGq5YpPeD+Vxn4p6qJMlwsbXGmEnHWxoPozrFOPSYM9IQUup8+XF1rwo/4nYX57pmfwpkTDgkn+ymRqRL5mQP/kV5HKzg8Ap8HsGJCSobTbehArh4gJFm1ZKGhsnVjYBUubAanOQ9WcEgRDdmLXlvPlhyND2O60C6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2yW3w82; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2yW3w82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEA21F00A3A;
	Thu,  6 Aug 2026 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786033561;
	bh=u4RsgIZcu96S1X/MBHHiPJWkRkCreoY4QnQgdHmXRtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n2yW3w82csDkz1uTa44CEDtpy2K29rkCFMGsuhxGfb4kFeOaR+Q1NdSSIqHlvEHON
	 erMfm47Vc2Ps9oHnqCgMtNtDL/qQ7ldqXnQ+vJ8r3yxgZLSP2sP3KeqpCSxSeEfva/
	 MAQBuSLB3PbWB8dYpq7uYqELz/KohQUveJMvw8ZNXE+4OHkAWwKhyxMxGUwLClSWcf
	 o0ukSqXm+iafv7E4d0w39XXPbwZomF3vbXpelI0E0pocTcN3EcRE7B3uYNc/aATVT3
	 B1/EEouQB8yjnUCLDuZJ3gXb92/pGxC92KweN7aM/EoeCODrTEYHrHyLOcgepClFpU
	 LKNfVLcueNGRQ==
From: Jakub Kicinski <kuba@kernel.org>
To: vineeth.karumanchi@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	git@amd.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: macb: configure ENST registers for all queues
Date: Thu,  6 Aug 2026 09:25:57 -0700
Message-ID: <20260806162557.2762166-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805044204.272989-1-vineeth.karumanchi@amd.com>
References: <20260805044204.272989-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "What's the expectation for the other queues?"
---
net: macb: configure ENST registers for all queues

The per-queue ENST config array is now sized to bp->num_queues and indexed
by queue_id, and the hardware programming loop writes ENST_START_TIME,
ENST_ON_TIME and ENST_OFF_TIME for every queue instead of only the queues
named in the taprio config. Queues absent from the config get the
kcalloc()-zeroed slot, so their timing registers are written as 0.

Link: https://lore.kernel.org/netdev/20260724043257.2221030-1-vineeth.karumanchi@amd.com/

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index d394f1f43b685..d58430fe9c41e 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -4357,7 +4357,7 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
>  		return -EINVAL;
>  	}
>  
> -	enst_queue = kcalloc(conf->num_entries, sizeof(*enst_queue), GFP_KERNEL);
> +	enst_queue = kcalloc(bp->num_queues, sizeof(*enst_queue), GFP_KERNEL);
>  	if (unlikely(!enst_queue))
>  		return -ENOMEM;
>  

[ ... ]

> @@ -4448,15 +4447,14 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
>  		gem_writel(bp, ENST_CONTROL,
>  			   queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);
>  
> -		for (i = 0; i < conf->num_entries; i++) {
> -			queue = &bp->queues[enst_queue[i].queue_id];
> +		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>  			/* Configure queue timing registers */
>  			queue_writel(queue, ENST_START_TIME,
> -				     enst_queue[i].start_time_mask);
> +				     enst_queue[q].start_time_mask);
>  			queue_writel(queue, ENST_ON_TIME,
> -				     enst_queue[i].on_time_bytes);
> +				     enst_queue[q].on_time_bytes);
>  			queue_writel(queue, ENST_OFF_TIME,
> -				     enst_queue[i].off_time_bytes);
> +				     enst_queue[q].off_time_bytes);
>  		}
>  
>  		/* Enable ENST for all configured queues in one write */

[Severity: Medium]
Can transmission on the queues left out of the taprio config stall after
this change?

For a queue that does not appear in conf->entries, enst_queue[q] is the
kcalloc()-zeroed slot, so macb_taprio_setup_replace() now writes
ENST_ON_TIME = 0 for it, and the following write only arms the configured
ones:

	gem_writel(bp, ENST_CONTROL, configured_queues);

The commit message argues the change is needed because the stale on-time of
the unconfigured queues altered the gating of q0/q1:

    Leaving the ENST on-time registers of unused queues at their reset
    value (0x0001FFFF) disrupts the scheduling of the configured queues,
    whereas programming them with 0x0 yields the expected ENST operation.

If the hardware consults ENST_ON_TIME of a queue whose ENST enable bit in
ENST_CONTROL is clear, then on_time = 0 in the 17-bit GEM_ON_TIME field is
not obviously a neutral "cleared" value; it could read as an on-window that
never opens.

The reported measurements only cover p0 and p1 on the two configured queues:

    With the unused queues (q2 and q3) explicitly programmed with
    enst_on_time = 0x0:
    - During T0 on-time, only p0 packets are transmitted.
    - During T1 on-time, only p1 packets are transmitted.

Was traffic on q2/q3 checked in that same experiment? All bp->num_queues
queues are real netdev TX queues:

drivers/net/ethernet/cadence/macb_main.c:macb_probe() {
	...
	dev = alloc_etherdev_mq(sizeof(*bp), num_queues);
	...
}

so ordinary traffic is hashed onto q2/q3 while the taprio qdisc is
installed.

macb_taprio_destroy() writes the same zeros, but there ENST_CONTROL holds
the disable mask for every queue and nothing is re-enabled afterwards:

drivers/net/ethernet/cadence/macb_main.c:macb_taprio_destroy() {
	...
		gem_writel(bp, ENST_CONTROL,
			   queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);

		/* Clear all queue ENST registers in batch */
		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
			queue_writel(queue, ENST_START_TIME, 0);
	...
}

That path leaves the engine globally quiescent, so it does not show that
all-zero timing registers are inert for a non-enabled queue while ENST is
running for other queues.

Since this carries a Fixes: tag and is stable-bound, could the commit
message state whether the non-scheduled queues still transmit normally, or
cite the hardware rule that makes on_time = 0 inert for a queue whose ENST
enable bit is clear? If the timing registers of disabled queues are in fact
not honoured, the stated mechanism behind the fix would need reworking too.
