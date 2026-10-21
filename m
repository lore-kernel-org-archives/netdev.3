Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598927;
	b=iUzYsZS6gQL0EMl0pBaRY938ZsVPxBnQ/hRfK5AkJvHUHb7wvqo2XbGbvH2QTpuDO7Gm
	 oLoAwGrCYL33AR3yumpVSlkrH2j7YVKnQghuGULexxkQm22vJ9gBjEr6/dFBvcDE6nsp0
	 4VDPhPS3FBaQ21388rkQ4Yj4lfTf53DUpN/scpJomHzn8yx76YPk7okgGHPcVvzTs9OCF
	 J+g7bHShbAMxXVmlx3cJDHX0cxJ4iAUGwRjSI+vkVMKPsRcI3l5j9+KWOkBEeGqpyGD4b
	 RtNQxm4c4gpXlNalwVyLSEELUlQWRwNPdAHnuVdpErFL8xqxX6HKhmC4Pqf1VCo5XtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598927;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OEJmC1fFv8S7z8NwMiScdSijf14THAuxH59eqNfgV1U=;
	b=R9fZHjoXAR4SzlJ6wvZIMnHB6Gsk+unix7X0efFrQcnFW+hn9EgWJ95+CMJgW6oOcJZk
	 lh53hZGHjgT44BEBb6z/lKqntGmFQXqXM5uDQ5qSDLwVtIwvQsradymo+y/BDMpfWlm/l
	 EYFAITnmiRi59jEoF8tC55U1nYFxc958VaqK/bSSBPdG+fXffI/Ju1WyO+jCB0bLNCLmf
	 DSGCSSAy18Ypt3md+wVHQ/8/OTQAmuc2q4bvtFp0b6etSWdbsas4F2XT6lanZ/7lhrc0q
	 oIiYk0mViiorr8EuJsdRpxXIVrO6g2sOOrs9Si8H/yPTzdQLH9OotkwB6tELuvH22cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzVorcfh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A565D606A31B;
	Wed, 21 Oct 2026 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzVorcfh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBC31F000C1;
	Wed, 21 Oct 2026 16:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792598926;
	bh=OEJmC1fFv8S7z8NwMiScdSijf14THAuxH59eqNfgV1U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LzVorcfhuI+BT7kiF+DhCKC9yTZ5BsUrIjRVN78Hjn1E0m7JrY6tIbJjvKLdA0+6K
	 WnvoE3uJWlbCXEOl+nC+6RieLTR/VupnK+ufz6OEQVJeFLIqHiAKvsVNlp2FVpK2yr
	 XEaudClAucD+roJoBNGv6vSTK5m/kBHmObf5O8BZY9tEDBsxC3IKIKjLQn2SapHVtG
	 55pPPZXRHvuVzk/0OBHuXntduo1J2z+zKSGsICzQYAfKWvdujWtdcjgoEAmoy2RX1a
	 t5PTFkAjWhhxxqnZlIm2T7Wd40qchukieMF4aJrGyu0npZDUS8F2p5DXUzg0JSrz91
	 SskYiyTmWwCmQ==
Subject:
 Re: [PATCH net v1] bnx2x: Close the VF when loading it fails after INIT
From: netdev-bot+sashiko@kernel.org
To: oss.patchbox@gmail.com
Cc: skalluru@marvell.com, manishc@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Oct 2026 16:08:45 +0000
Message-ID: <179259892503.3135.1020842170103430745@kernel.org>
In-Reply-To: <20261019041122.1054520-2-oss.patchbox@gmail.com>
References: <20261019041122.1054520-2-oss.patchbox@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This fix is incomplete when a VF load fails at load_error3.
- [Medium] The new close_vf in the load-failure unwind can wipe a valid
  guest MAC.
- [Medium] The new unwind in bnx2x_nic_load() frees fw_stats, the status
  blocks and the fp memory at load_error0 (bnx2x_cmn.c:2979) whether or…

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but
  bnx2x_vfpf_init() failures in bnx2x_nic_load() still go to load_error0…

--

bnx2x: Close the VF when loading it fails after INIT

This commit adds a bnx2x_vfpf_close_vf() call to the bnx2x_nic_load() error
unwind. The goal is for the PF to stop using the VF status blocks, queues
and statistics buffer before they are freed. It also moves bnx2x_vfpf_init()
after bnx2x_set_real_num_queues(), so that failures after INIT go through
load_error1.

> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> index 5a9742fd3ddfb..5463de650f703 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c

[ ... ]

> @@ -2706,6 +2699,13 @@ int bnx2x_nic_load(struct bnx2x *bp, int load_mode)
>  		LOAD_ERROR_EXIT(bp, load_error0);
>  	}
>  
> +	/* request pf to initialize status blocks */
> +	if (IS_VF(bp)) {
> +		rc = bnx2x_vfpf_init(bp);
> +		if (rc)
> +			LOAD_ERROR_EXIT(bp, load_error0);
> +	}
> +

[Severity: Low]
This is a pre-existing issue, but what happens when bnx2x_vfpf_init() itself
times out? That error still goes to load_error0 and skips the new
bnx2x_vfpf_close_vf().

bnx2x_send_msg2pf() triggers the PF before it starts polling. On timeout it
returns without cancelling the request:

drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c:bnx2x_send_msg2pf() {
    ...
	writeb_relaxed(1, &zone_data->trigger.vf_pf_channel.addr_valid);
	/* Wait for PF to complete */
	while ((tout >= 0) && (!*done)) {
    ...
	if (!*done) {
		BNX2X_ERR("PF response has timed out\n");
		return -EAGAIN;
	}
    ...
}

The PF may process that INIT later. If it does, bnx2x_vf_mbx_init_vf()
records vf->fw_stat_map. bnx2x_vf_init() then programs the status block
addresses with bnx2x_init_sb() and sets vf->state = VF_ENABLED.

By then the VF has already freed those buffers at load_error0. Every later
INIT is rejected, because bnx2x_vf_init() requires VF_ACQUIRED.

Actual DMA seems unlikely here, since no queues have been set up yet. Still,
the phrase "every failure after INIT" in the commit message doesn't seem to
cover INIT itself timing out.

Sending CLOSE after a timed out mailbox request would race with the
outstanding request. So this may be a general limitation of the VF/PF
channel.

[ ... ]

> @@ -2967,6 +2967,15 @@ int bnx2x_nic_load(struct bnx2x *bp, int load_mode)
>  	/* clear pf_load status, as it was already set */
>  	if (IS_PF(bp))
>  		bnx2x_clear_pf_load(bp);
> +
> +	/* The PF may still use the status blocks, queues and statistics
> +	 * buffer it got from bnx2x_vfpf_init(). Close the VF, as
> +	 * bnx2x_nic_unload() does, before they are freed below.
> +	 */
> +	if (IS_VF(bp)) {
> +		bnx2x_clear_vlan_info(bp);
> +		bnx2x_vfpf_close_vf(bp);
> +	}

[Severity: Medium]
Is the VF closed early enough when a failure lands at load_error3?

For a VF, load_error3 is reached after SETUP_Q. That happens when any of
these fail: bnx2x_setup_leading(), bnx2x_vfpf_setup_q(), bnx2x_init_rss(),
bnx2x_vfpf_config_mac() or bnx2x_vlan_reconfigure_vid().

That label still runs this before it falls through to the new close:

load_error3:
	...
	/* Free SKBs, SGEs, TPA pool and driver internals */
	bnx2x_free_skbs(bp);
	for_each_rx_queue(bp, i)
		bnx2x_free_rx_sge_range(bp, bp->fp + i, NUM_RX_SGE);

	/* Release IRQs */
	bnx2x_free_irq(bp);

So the RX BD buffers, TPA pool and SGE pages are unmapped and freed, and
the MSI-X handlers are removed. Meanwhile the PF/FW RX clients created by
SETUP_Q are still alive.

The VF IGU status blocks are also still enabled. The PF only calls
bnx2x_vf_igu_disable() as part of CLOSE.

bnx2x_nic_unload() does it the other way round: it calls
bnx2x_vfpf_close_vf() first and bnx2x_free_skbs() later.

The window covers several VF->PF mailbox exchanges. Each one can take up to
about 10 seconds in bnx2x_send_msg2pf().

Could the FW place an RX frame or TPA aggregation into the freed pages
during that window? Could it raise MSI-X on vectors that no longer have
handlers?

Every load_error3 exit happens before bnx2x_set_rx_mode_inner(). So the
client is probably still in drop-all mode, which may limit this.

The commit message says:

    Close the VF in the unwind before the memory is freed, as
    bnx2x_nic_unload() does.

This seems to hold for the fw_stats, status blocks and fp rings freed at
load_error0. It doesn't seem to hold for the RX data buffers and IRQs
released at load_error3.

Would it make sense to send TEARDOWN_Q/CLOSE for VFs before
bnx2x_free_skbs() and bnx2x_free_irq()?

[Severity: Medium]
Can this new close wipe the guest's MAC address when the PF never set up
the leading queue?

Take the first open after probe, with no MAC assigned by the host. INIT
succeeds, then bnx2x_setup_irqs() fails and jumps to load_error2. That now
reaches bnx2x_vfpf_close_vf(), which sends a MAC delete:

	bnx2x_vfpf_config_mac(bp, bp->dev->dev_addr, bp->fp->index, false);

On the PF, q->sp_initialized only becomes true in bnx2x_leading_vfq_init(),
when SETUP_Q for the leading queue is processed. So
bnx2x_vf_mac_vlan_config_list() returns early:

	if (!bnx2x_validate_vf_sp_objs(bp, vf, true))
		return -EINVAL;

That early return also skips the kfree(filters) later in the function. It
looks like the PF host leaks the filter list each time this happens.

The -EINVAL turns into PFVF_STATUS_FAILURE. The failure loop in
bnx2x_vfpf_config_mac() on the VF then does this:

	while (resp->hdr.status == PFVF_STATUS_FAILURE) {
		...
		/* copy mac from bulletin to device */
		eth_hw_addr_set(bp->dev, bulletin.mac);

It doesn't check whether the request was a delete, or whether
MAC_ADDR_VALID is set in the bulletin. With no host MAC, bulletin.mac is all
zeros, so the netdev address becomes 00:00:00:00:00:00.

Wouldn't the next open then fail in bnx2x_validate_addr() with
-EADDRNOTAVAIL until a MAC is set again? Before this patch, a load failure
never sent a MAC delete.

>  load_error0:
>  	bnx2x_free_fw_stats_mem(bp);
>  	bnx2x_free_fp_mem(bp);

[Severity: Medium]
What happens to the memory freed here if the PF does not complete CLOSE?

bnx2x_vfpf_close_vf() returns void and only logs failures:

	if (rc)
		BNX2X_ERR("Sending CLOSE failed. rc was: %d\n", rc);
	else if (resp->hdr.status != PFVF_STATUS_SUCCESS)
		BNX2X_ERR("Sending CLOSE failed: pf response was %d\n", resp->hdr.status);

On the PF, bnx2x_vf_close() can stop before it moves the VF to
VF_ACQUIRED. That happens on the first bnx2x_vf_queue_teardown() error. It
also happens when bnx2x_stats_safe_exec() returns -EBUSY because the
stats_lock or stats_pending wait timed out:

	for (i = 0; i < vf_rxq_count(vf); i++) {
		rc = bnx2x_vf_queue_teardown(bp, vf, i);
		if (rc)
			goto op_err;
	}
	...
		rc = bnx2x_stats_safe_exec(bp, bnx2x_set_vf_state, &cookie);
		if (rc)
			goto op_err;

In either case the VF stays VF_ENABLED, so later INITs are still rejected.
If queues survive a failed teardown, stats ramrods can still DMA into the
fw_stats buffer that was freed here.

The new unwind also adds a way to hit the teardown failure. After a
bnx2x_setup_irqs() failure, CLOSE is sent even though the leading queue was
never set up.

bnx2x_vf_queue_teardown() still posts an rx-mode ramrod for that queue,
without the sp_initialized check:

	if (qid == LEADING_IDX) {
		rc = bnx2x_vf_rxmode(bp, vf, qid, 0);
		if (rc)
			goto op_err;
		/* Remove filtering if feasible */
		if (bnx2x_validate_vf_sp_objs(bp, vf, true)) {

The FW may not complete that ramrod for a cid that was never initialized.
Would both TEARDOWN_Q and CLOSE then fail, and leave the VF in the same
stuck state this patch is meant to fix?

Ignoring the return value here is the same as in bnx2x_nic_unload(). The
rx-mode path for an unset queue was also reachable before, through RELEASE.
So the worst case may just match the pre-patch behaviour.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019041122.1054520-2-oss.patchbox%40gmail.com
