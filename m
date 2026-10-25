Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792923801;
	b=dnoQZR7/jMC3hOBI3cP6WsJMp8yjlqhRjBm8plfue0dg7egcrBmY028O84g9dMod2Fpt
	 ox+j9Zk9rtJM3pIdnCYszAAP1wsdqO9p+oNDBtsDQ3FNNmuxrOYfVDFIfwW2I3mkxANoy
	 MAMzkpb68haIyw08xF3hz2jMwNC7mD2s1iICtYTSOX/Ed5e2i14/Ko+ujHgOzsz2l7g38
	 w2B9SuS3x3O1ndbB92CqOHH4/Z2JpS9rgKyHx+hJUG1UPmP031AwtXDz08hMKZcPuLIrz
	 vCrASzaWacW3TnKWEN5X4wjQvJPqYZ1f/Udpdq4/OgEYCNDecwflC7OjX45YsEUz12w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792923801;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GoT4ZVHSTikshyQ0zbV5Oqm1IemHj+H26qOFKFZz1nQ=;
	b=0tE8Cr86PvoaUXfceLtDBSGD0QVWWexGnzAXizrnslVndBQmC+wgGTcGlvi9GuzZmxOJ
	 l6RVfH1M/aG1Np0V527LyH7tndtgJcVqob3F2olmgrvLQOmtujP136fEK4/hrGVAMc4bD
	 DdY5VrDZLGY28gnKlaYLZlE8niLl7fcxK70Unj36mtcDI729VPyWu/oKculkEvI6qL4e3
	 Irc+ZY4idcC9L/m/tbAjEcRBG3yv4OO/flZYHfj276HNZSCeVfLe/HtvMzN8iZE7GCJQ2
	 uzae1KHWkNx4nkBIFus8qsq6oAm3Ww/Y69X5BgtrmJghwextGVulK8q+pJzDdR8LagA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UU8AgQ95;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6386F606A327;
	Sun, 25 Oct 2026 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UU8AgQ95
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D09E1F01828;
	Sun, 25 Oct 2026 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792923801;
	bh=GoT4ZVHSTikshyQ0zbV5Oqm1IemHj+H26qOFKFZz1nQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UU8AgQ952wFGYgFJ3XB6CnIZXneWkCKRuk8ALP/o8TwEQvJu0mrVduutaFPgIMpCA
	 Vrt+EcNBOZEpIo1ujxIij+8cQ9co5gk075y/ttHw2IYtdkG09ezxPtHCvu/2RoAZvT
	 U+DJhFLO8Z+dNOl0eAL1x2PV7NdpzOpfev2eDdoqfqFs9tIrVP2hPGDeOg6qdETmDX
	 C2WT184qgdYm4w6jnG69jY9+Ic3AzdFQpF5Wcc4ftcVf3VWLz/Q6pgo0WkyOf1+5iE
	 s3HCkQUVAq1hQpeYU/JAHLzEzC+snPp9yFG/PfoHhXYsLY/LDWQpF8VK6eH3U7Dpty
	 jL8ikplEiybAA==
Subject: Re: [PATCH net-next v3 2/2] net: wwan: qcom_bam_dmux: Assign
 restricted DMA pool to remote processor
From: netdev-bot+sashiko@kernel.org
To: vishnu.santhosh@oss.qualcomm.com
Cc: stephan@gerhold.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, edumazet@kernel.org, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, deepak.singh@oss.qualcomm.com
Date: Sun, 25 Oct 2026 10:23:19 +0000
Message-ID: <179292379960.3134.17105636011699871887@kernel.org>
In-Reply-To:
 <20261021-qcom-bam-dmux-vmid-ext-v3-2-cedd1f681102@oss.qualcomm.com>
References:
 <20261021-qcom-bam-dmux-vmid-ext-v3-2-cedd1f681102@oss.qualcomm.com>
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 4 (1) · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says BAM descriptor FIFOs "must therefore
  be constrained" to the shared region, and that they are covered "when…
- [Medium] bam_dmux_assign_dma_pool() always passes `u64 src =
  BIT_ULL(QCOM_SCM_VMID_HLOS)` (line 777) to qcom_scm_assign_mem(), so…
- [Medium] In bam_dmux_remove(), `remote_suspended` decides whether the
  pool goes back to HLOS-only, and it can be wrong in two ways.
- [Medium] Once the restricted pool is assigned RW to the modem VMID,
  every RX buffer mapping copies uninitialized HLOS memory into memory…
- [Low] The patch changes the probe error path in bam_dmux_probe() for an
  irq_get_irqchip_state() failure.
- [Low] The binding and the driver disagree on which qcom,vmid values are
  valid.
- [Low] The driver and binding accept qcom,vmid values up to 63, and
  bam_dmux_reclaim_dma_pool() passes `src = BIT_ULL(HLOS) |…

Pre-existing issues:
- [High] bam_dmux_remove() calls
  cancel_work_sync(&dmux->register_netdev_work) at line 964, before RX…
- [Medium] This problem wasn't introduced by this patch, but net_devices
  that registered successfully are unregistered and never freed.

--

net: wwan: qcom_bam_dmux: Assign restricted DMA pool to remote processor

When qcom,vmid is present in DT, this patch requires a restricted DMA pool
and uses SCM to assign the whole pool to both HLOS and the remote VMID. The
pool is reclaimed for HLOS on remove or on probe error cleanup, unless the
remote side did not drop its power vote. It also changes the
irq_get_irqchip_state() failure path in probe to call bam_dmux_remove().

> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
> index cc6ace8d64371..fa3621224a56e 100644
> --- a/drivers/net/wwan/qcom_bam_dmux.c
> +++ b/drivers/net/wwan/qcom_bam_dmux.c

[ ... ]

> @@ -762,6 +768,96 @@ static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int bam_dmux_assign_dma_pool(struct bam_dmux *dmux)
> +{
> +	struct device *dev = dmux->dev;
> +	struct device_node *rmem_np;
> +	struct reserved_mem *rmem;
> +	struct qcom_scm_vmperm dst[2];
> +	u64 src = BIT_ULL(QCOM_SCM_VMID_HLOS);

[Severity: Medium]

Is it safe to assume on every probe that HLOS is the only current owner?
qcom_scm_assign_mem() documents @srcvm as the "vmid for current set of
owners".

Two paths can leave the pool owned by {HLOS, vmid} after the driver
instance is gone. The first is bam_dmux_remove(), which skips the reclaim
on a remote timeout:

	else if (dmux->dma_pool_perms)
		dev_warn(dev, "Leaving restricted DMA pool assigned to remote\n");

The second is bam_dmux_reclaim_dma_pool(), which only logs when the SCM
call fails.

In both cases the only record of the assignment is dmux->dma_pool_perms.
That field lives in devm_kzalloc() memory, which is freed right after
remove or after the failed probe.

On the next probe (module reload, or unbind/bind of the remoteproc
parent), the zeroed dmux would ask TZ to move the pool from {HLOS} while
{HLOS, vmid} actually owns it. Would the assign then fail with "SCM assign
restricted DMA pool failed" until reboot?

The new probe error path calls bam_dmux_remove() right after the PC IRQ
may have powered up RX, so it seems likely to hit the timeout case.

> +	u32 vmid;
> +	int ret;
> +
> +	if (!of_property_present(dev->of_node, "qcom,vmid"))
> +		return 0;
> +
> +	ret = of_property_read_u32(dev->of_node, "qcom,vmid", &vmid);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read qcom,vmid\n");
> +	if (vmid == QCOM_SCM_VMID_HLOS || vmid >= BITS_PER_TYPE(u64))
> +		return dev_err_probe(dev, -EINVAL, "Invalid qcom,vmid %u\n", vmid);

[Severity: Low]

Should the binding and this check agree on the valid range? The
qcom,bam-dmux.yaml binding in this series allows:

    items:
      minimum: 1
      maximum: 63

This check rejects 3 (QCOM_SCM_VMID_HLOS) but accepts 0. So a DT with
qcom,vmid = <3> passes dtbs_check and then fails probe with -EINVAL. In
the other direction, vmid 0 is rejected by the schema but is passed to
SCM here.

[Severity: Low]

On 32-bit kernels, can a vmid between 32 and 63 be reclaimed correctly?
bam_dmux_reclaim_dma_pool() passes src = BIT_ULL(HLOS) | BIT_ULL(vmid).
However, qcom_scm_assign_mem() builds the source list with the unsigned
long BIT():

	for (b = 0; b < BITS_PER_TYPE(u64); b++) {
		if (srcvm_bits & BIT(b))
			src[i++] = cpu_to_le32(b);
	}

On 32-bit this shift is undefined for b >= 32, so the remote VMID entry
would not be written. src_sz is still computed with hweight64(), so the
SCM call would see an uninitialized trailing source slot. The helper's
int next_vm |= BIT(newvm->vmid) has a similar limit.

The root cause is in the existing SCM helper. However, this patch adds a
caller and accepts a range the helper cannot encode on 32-bit, and
QCOM_BAM_DMUX is used on 32-bit SoCs such as MSM8974. Should the range be
tightened here, or should the helper switch to BIT_ULL()?

[ ... ]

> +	rmem = of_reserved_mem_lookup(rmem_np);
> +	of_node_put(rmem_np);
> +	if (!rmem)
> +		return dev_err_probe(dev, -EINVAL,
> +					     "Failed to look up restricted DMA pool\n");
> +
> +	if (!is_swiotlb_for_alloc(dev))
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Restricted DMA pool not attached\n");

[Severity: Medium]

The commit message says:

    BAM-DMUX DMA mappings and BAM descriptor FIFOs must therefore be
    constrained to a designated memory region ...

    When the BAM DMA controller references the same pool, its descriptor
    FIFOs are covered by the assignment as well.

This check only looks at the bam-dmux device. The descriptor FIFOs are
allocated on the BAM controller's own device in bam_alloc_chan():

	bchan->fifo_virt = dma_alloc_wc(bdev->dev, BAM_DESC_FIFO_SIZE,
					&bchan->fifo_phys, GFP_KERNEL);

Their address is then programmed into BAM_P_DESC_FIFO_ADDR in
bam_chan_init_hw().

Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml has no
memory-region property and sets additionalProperties: false. This series
only updates the bam-dmux binding.

With a schema-valid DT, wouldn't the FIFOs stay in ordinary memory that
the modem VMID cannot reach? That would leave the XPU violation possible
for FIFO accesses.

Should the bam-dma binding gain a memory-region property? Should the
driver also verify, or at least warn, that the DMA controller behind the
rx/tx channels uses the same pool?

> +
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
> +	dst[0].vmid = QCOM_SCM_VMID_HLOS;
> +	dst[0].perm = QCOM_SCM_PERM_RW;
> +	dst[1].vmid = vmid;
> +	dst[1].perm = QCOM_SCM_PERM_RW;
> +
> +	ret = qcom_scm_assign_mem(rmem->base, rmem->size, &src, dst,
> +				  ARRAY_SIZE(dst));

[Severity: Medium]

Once the whole pool is RW for the modem VMID, does every RX mapping copy
uninitialized kernel memory into it?

bam_dmux_skb_dma_queue_rx() allocates the RX skb with
__netdev_alloc_skb() and calls skb_put(skb, BAM_DMUX_BUFFER_SIZE) without
zeroing. It then maps the buffer DMA_FROM_DEVICE.

With a restricted-dma-pool, swiotlb_tbl_map_single() copies the original
buffer into the pool slot before the transfer, whatever the direction:

	swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE, pool);

That would put up to 2 KiB of stale kernel data per buffer into memory
shared with the modem. This happens for all 32 RX buffers at power-on and
again on each refill in bam_dmux_rx_callback().

Should the RX buffers be zeroed before mapping when qcom,vmid is set?

[ ... ]

> @@ -829,8 +929,11 @@ static int bam_dmux_probe(struct platform_device *pdev)
>  
>  	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
>  				    &dmux->pc_state);
> -	if (ret)
> -		goto err_disable_pm;
> +	if (ret) {
> +		/* The PC IRQ may already have powered up the RX path */
> +		bam_dmux_remove(pdev);
> +		return ret;
> +	}

[Severity: Low]

This changes the irq_get_irqchip_state() failure path from only disabling
runtime PM to a full bam_dmux_remove(). That seems to fix an existing bug.
The threaded PC IRQ is already registered at this point and may have run
bam_dmux_power_on(), which requests the RX channel and maps and submits
the RX skbs. The old err_disable_pm path leaked all of that while devm
freed dmux.

Could this be split into a separate patch with a Fixes: tag so it reaches
stable, and mentioned in the commit message?

The change also alters probe behaviour. The failure path can now block in
wait_event_timeout() for up to BAM_DMUX_REMOTE_TIMEOUT, it sends a
power-down vote through bam_dmux_runtime_suspend(), and it calls
disable_irq() on devm-managed IRQs.

[ ... ]

> @@ -853,6 +957,7 @@ static void bam_dmux_remove(struct platform_device *pdev)
>  	struct bam_dmux *dmux = platform_get_drvdata(pdev);
>  	struct device *dev = dmux->dev;
>  	LIST_HEAD(list);
> +	bool remote_suspended;
>  	int i;
>  
>  	/* Unregister network interfaces */

[Severity: High]

This isn't a bug introduced by this patch, but the new probe error path
relies on bam_dmux_remove() to tear down an RX path that may already be
active. remove cancels register_netdev_work before RX is stopped:

	cancel_work_sync(&dmux->register_netdev_work);
	...
	remote_suspended = wait_event_timeout(dmux->pc_wait, !dmux->rx,
	...
	disable_irq(dmux->pc_irq);
	bam_dmux_power_off(dmux);

During the wait, an RX completion can carry a BAM_DMUX_CMD_OPEN command
for a channel that has no netdev. That goes through
bam_dmux_rx_callback()->bam_dmux_cmd_open(), which calls
schedule_work(&dmux->register_netdev_work) again. Nothing cancels the work
after that.

Can the work then run after devres frees dmux, or register netdevs that
point at the freed dmux and are never unregistered?

During probe, netdevs[] is all NULL, so after a power-up ack every open
command from the modem would schedule the work.

[Severity: Medium]

This isn't a bug introduced by this patch, but are the registered
net_devices ever freed?

bam_dmux_register_netdev_work() calls free_netdev() only when
register_netdev() fails. bam_dmux_netdev_setup() does not set
needs_free_netdev, and this path only calls unregister_netdevice_queue()
and unregister_netdevice_many(). netdev_run_todo() only frees the device
when needs_free_netdev is set.

So each registered netdev seems to leak on remove. With this patch it can
also leak in the new probe error cleanup, if interfaces were already
created.

> @@ -872,13 +977,21 @@ static void bam_dmux_remove(struct platform_device *pdev)
>  	pm_runtime_set_suspended(dev);
>  
>  	/* Try to wait for remote side to drop power vote */
> -	if (!wait_event_timeout(dmux->pc_wait, !dmux->rx, BAM_DMUX_REMOTE_TIMEOUT))
> +	remote_suspended = wait_event_timeout(dmux->pc_wait, !dmux->rx,
> +					      BAM_DMUX_REMOTE_TIMEOUT);
> +	if (!remote_suspended)
>  		dev_err(dev, "Timed out waiting for remote side to suspend\n");
>  
>  	/* Make sure everything is cleaned up before we return */
>  	disable_irq(dmux->pc_irq);
>  	bam_dmux_power_off(dmux);
>  	bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
> +
> +	/* The remote side may still access the pool if it did not suspend */
> +	if (remote_suspended)
> +		bam_dmux_reclaim_dma_pool(dmux);

[Severity: Medium]

Can remote_suspended be stale or wrong by the time it gates the reclaim?

It is sampled while the PC IRQ is still enabled, and disable_irq() only
runs afterwards. In between, the modem can raise its power vote again,
and bam_dmux_pc_irq() would run:

	if (new_state) {
		if (bam_dmux_power_on(dmux))
			bam_dmux_pc_ack(dmux);

That requests RX, maps the RX skbs into the pool and acks the modem.
disable_irq() only waits for the handler to finish. The earlier true value
then reclaims the pool while the modem believes the link is up.

Also, dmux->rx == NULL does not necessarily mean the remote powered down.
If bam_dmux_power_on() fails in the PC IRQ handler or in probe,
bam_dmux_power_off() clears rx while pc_state is set to true. The wait
then returns immediately and the pool is reclaimed while the remote vote
is still asserted.

The commit message says:

    Skip the reclaim and leave the pool assigned if the remote side did not
    acknowledge the power-down, since it may still access the pool.

Would it be more robust to make this decision after disable_irq(), based
on the remote PC state (for example !dmux->pc_state)?

> +	else if (dmux->dma_pool_perms)
> +		dev_warn(dev, "Leaving restricted DMA pool assigned to remote\n");
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021-qcom-bam-dmux-vmid-ext-v3-0-cedd1f681102%40oss.qualcomm.com
