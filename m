Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7954FDE40;
	Thu,  3 Sep 2026 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455928; cv=none; b=P4qp19iQ07n2HzwTyZ0I1/+xJY5Hyn19u8rTBfciwfbGDP2EsD/0ti+KH/g6jdiVV86R6MP5CVJ17lCjOpH83+ztJAEihkH1T8Akj1vzUJI38P/HtzO371MSOPsZSguEZRdDy97MM9uP/U75Ts886csbsPBWhigIUcYbsR47xfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455928; c=relaxed/simple;
	bh=mXX/Etrqb4EFrEaomh5MkwNzuyyRPV1gF/1or3ELYe4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pRYleiWSTWOpvuZaZ8Yr7Me7cvg9xaqbEKc8FM2QIMqX817McC0jX2mp6X67VaJGH1G1Mr1ivRDG+yds3DFwTofv9yMGEiNGnOgxFtzHEiDPck/YNYE//Z4Jj9sqHrKmeZL97ElSCodSqKKArY77WaBp6nknGxNEsMT9Kqc7AXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yk8H5Q8a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yk8H5Q8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAA51F000E9;
	Thu,  3 Sep 2026 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455926;
	bh=6/4SlY1teK8eTFIpFdeomtz5puYwSoy2NSf6sYKyA2I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Yk8H5Q8aZMB1iOP3pS3ymeFceap1st7ql64SEvg/XOJrpdhyF1eQ2On6ILk8a6+24
	 +WSaRtWDI7vAZjpUGMke298SbGMzu2RpMqAZlTe3xa8FvLvkSQmvyohIT3nf7HtjBE
	 nS79S0UEFMCBbJi14XEVyAf72oahN1dFReKeKNKja5a3OZuFWgGg500MUdIxE3pSXF
	 axGQRpE62t/Fn237dBi0NxKfpg8JgllUOKIgSIri5eLdRFeIxyUgLHfzhyyh4H9uXp
	 l7llLajDGF52VDcQmB/6VmQ0LANPtT3YwSIBHGC2VbG113DeLMOB+SIrbLNj5T7ioN
	 G1ycculSM6aFA==
Subject: Re: [v26,net-next,10/10] net/nebula-matrix: add common dev start/stop
 operation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 17:18:45 +0000
Message-ID: <178845592524.3394541.17926965120518392179@kernel.org>
In-Reply-To: <20260831021408.2325-11-illusion.wang@nebula-matrix.com>
References: <20260831021408.2325-11-illusion.wang@nebula-matrix.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 1

- [High] This patch adds the first live callers of
  cfg_msix_map()/destroy_msix_map(), so the control PF (function 0) now…
- [Medium] In nbl_dev_stop() (nbl_core/nbl_dev.c:489-495) and in the
  identical unwind inside nbl_dev_start() (nbl_dev.c:465-472), a failure…
- [Low] Claim (assessed FALSE POSITIVE): nbl_dev_disable_mailbox_irq()
  clears NBL_CHAN_IRQ_RDY (nbl_core/nbl_dev.c:137-139) without waking…

--

net/nebula-matrix: add common dev start/stop operation

This adds nbl_dev_start() and nbl_dev_stop() to configure the hardware
MSI-X map, allocate MSI-X vectors, request the mailbox interrupt and tear
all of that down again.  Thin nbl_core_start() / nbl_core_stop() wrappers
are hooked into the PCI probe and remove paths.

A few questions on the new start/stop paths below.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> index 4fc52cadf60f..26b785c9a05f 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c

[ ... ]

> @@ -14,6 +25,189 @@ static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
>  	msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1;
>  }
>  

[ ... ]

> +static int nbl_dev_disable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> +	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
> +	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
> +	struct nbl_msix_info *msix_info = &dev_common->msix_info;
> +	u16 local_vec_id;
> +
> +	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
> +		return 0;
> +
> +	local_vec_id =
> +		msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;

[ ... comment block snipped ... ]

> +	chan_ops->set_queue_state(dev_mgt->chan_ops_tbl->priv,
> +				  NBL_CHAN_IRQ_RDY,
> +				  NBL_CHAN_TYPE_MAILBOX, false);
> +
> +	return disp_ops->set_mailbox_irq(dev_mgt->disp_ops_tbl->priv,
> +					    local_vec_id, false);
> +}

[Severity: Low]
This isn't a bug in the tree as it stands, but clearing NBL_CHAN_IRQ_RDY
here does not wake the per-message ACK wait queues that test that same
bit.

nbl_chan_send_msg() sleeps on it:

	ret = wait_event_timeout(wait_head->wait_queue,
				 READ_ONCE(wait_head->acked) ||
				 READ_ONCE(chan_info->shutdn) ||
				 !test_bit(NBL_CHAN_IRQ_RDY,
					   chan_info->state),
				 NBL_CHAN_ACK_WAIT_TIME);

At this point in the series every ack-requesting sender is one of the
nbl_disp_chan_*_req() helpers, all reached only from
nbl_dev_setup_common_dev(), nbl_dev_start() and nbl_dev_stop(), which the
driver core serializes against this path, and nbl_chan_send_ack() sends
with ack = 0 and never sleeps.  So no waiter can be stranded today.

Once netdev or ethtool paths start sending mailbox messages, would this
also need the WRITE_ONCE(wait_head->acked, 1) plus wake_up() sequence that
nbl_chan_teardown_queue() already does?

[ ... ]

> @@ -234,3 +436,69 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
>  		nbl_dev_remove_ctrl_dev(adapter);
>  	nbl_dev_remove_common_dev(adapter);
>  }
> +
> +/* ----------  Dev start process  ---------- */
> +int nbl_dev_start(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
> +	int cleanup_ret;
> +	int ret;
> +
> +	ret = nbl_dev_cfg_msix_map(dev_mgt);
> +	if (ret)
> +		goto cfg_msix_map_err;

[Severity: High]
This is the first live caller of cfg_msix_map() / destroy_msix_map(), so
the control PF now allocates per-function MSI-X state on behalf of the
other PFs.  Is there anything on the control PF side that ever releases
that state?

On the control PF, nbl_res_intr_cfg_msix_map() allocates:

	tmp_msix_tbl->base_addr = dmam_alloc_coherent(dev, tmp_msix_tbl->size,
						      &tmp_msix_tbl->dma,
						      GFP_KERNEL);
	...
	tmp_interrupts = kcalloc(requested, sizeof(tmp_interrupts[0]), GFP_KERNEL);

stores both in intr_mgt->func_intr_res[func_id] and programs the hardware
map with VALID=1.  The only release path is
nbl_res_intr_destroy_msix_map(), which for a peer function runs only when
that peer PF executes its own nbl_dev_stop() and its DESTROY_MSIX_MAP
mailbox request succeeds.

On the control PF side, nbl_intr_mgt_start() has no stop counterpart,
nbl_res_remove_leonis() is a stub:

void nbl_res_remove_leonis(struct nbl_adapter *adap)
{
	/*
	 * No resource release here because all memory uses devm managed
	 * allocation
	 */
}

and nbl_dev_remove_ctrl_dev() only calls disp_ops->deinit_module().

Does unbinding or hot-removing the control PF while another PF is still
bound leak the kcalloc()'d func_intr_res[].interrupts arrays?  intr_mgt
itself is devm_kzalloc()'d, so the pointers to those arrays look
unreachable once devres frees it, and the comment above claims everything
is devm managed.

In the same scenario, can the peer function be left with
NBL_PCOMPLETER_FUNCTION_MSIX_MAP still VALID=1 pointing at the coherent
table that devres just reclaimed together with the control PF, so a later
interrupt from that function makes the device DMA-read freed memory?  The
peer's own DESTROY_MSIX_MAP request has no manager left at that point, and
nbl_dev_stop() only logs the failure.

> +
> +	ret = nbl_dev_init_interrupt_scheme(dev_mgt);
> +	if (ret)
> +		goto init_interrupt_scheme_err;
> +	ret = nbl_dev_request_mailbox_irq(dev_mgt);
> +	if (ret)
> +		goto mailbox_request_irq_err;
> +	ret = nbl_dev_enable_mailbox_irq(dev_mgt);
> +	if (ret)
> +		goto enable_mailbox_irq_err;
> +
> +	return 0;
> +
> +enable_mailbox_irq_err:
> +	cleanup_ret = nbl_dev_disable_mailbox_irq(dev_mgt);
> +	if (cleanup_ret)
> +		dev_err(dev_mgt->common->dev,
> +			"Failed to disable mailbox IRQ: %d\n", cleanup_ret);
> +	nbl_dev_free_mailbox_irq(dev_mgt);
> +	cancel_work_sync(&common_dev->clean_mbx_task);
> +mailbox_request_irq_err:
> +	nbl_dev_clear_interrupt_scheme(dev_mgt);
> +init_interrupt_scheme_err:
> +cfg_msix_map_err:
> +	cleanup_ret = nbl_dev_destroy_msix_map(dev_mgt);
> +	if (cleanup_ret)
> +		dev_err(dev_mgt->common->dev,
> +			"Failed to destroy MSI-X map: %d\n", cleanup_ret);
> +	cancel_work_sync(&common_dev->clean_mbx_task);
> +	return ret;
> +}
> +
> +void nbl_dev_stop(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
> +	int ret;
> +
> +	ret = nbl_dev_disable_mailbox_irq(dev_mgt);
> +	if (ret)
> +		dev_err(dev_mgt->common->dev,
> +			"Failed to disable mailbox IRQ: %d\n", ret);
> +	nbl_dev_free_mailbox_irq(dev_mgt);
> +	nbl_dev_clear_interrupt_scheme(dev_mgt);
> +	ret = nbl_dev_destroy_msix_map(dev_mgt);
> +	if (ret)
> +		dev_err(dev_mgt->common->dev,
> +			"Failed to destroy MSI-X map: %d\n", ret);

[Severity: Medium]
Here a failure of nbl_dev_disable_mailbox_irq() is only logged and
teardown carries on.  On a non-control PF that helper is a mailbox RPC,
nbl_disp_chan_set_mailbox_irq_req(), which can return -EREMOTEIO,
-ETIMEDOUT or -ESHUTDOWN when the manager PF is unresponsive or already
unbound.

It is also the only operation that clears MSIX_IDX and MSIX_IDX_VALID in
NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id):

nbl_hw_leonis.c:nbl_hw_set_mailbox_irq() {
	data &= ~(NBL_MAILBOX_QINFO_MAP_MSIX_IDX_MASK |
		  NBL_MAILBOX_QINFO_MAP_MSIX_IDX_VALID_MASK);
}

So if that RPC fails, the mailbox queue stays armed to emit an MSI-X
message while nbl_dev_free_mailbox_irq() and then pci_free_irq_vectors()
run.  Can that leave the device sending a vector with no handler behind
it?

The remaining masking path is reached over the same mailbox channel:

nbl_interrupt.c:nbl_res_intr_destroy_msix_map() {
	for (i = 0; i < intr_num; i++) {
		hw_ops->cfg_msix_info(res_mgt->hw_ops_tbl->priv,
				      func_id, false, interrupts[i],
				      0, 0, 0, false);
	}
}

and its failure is likewise only logged, so when the channel is wedged
nothing quiesces the interrupt source.  Should stop fail loudly or use a
local register write instead of the RPC for the masking step?

Separately, even on the success path nbl_dev_clear_interrupt_scheme()
runs before nbl_dev_destroy_msix_map(), i.e. the kernel-side vectors are
released while the device-side mapping is still valid.  Was that ordering
intended, given that only the (fallible) disable makes it safe?

The identical unwind in nbl_dev_start() under enable_mailbox_irq_err
ignores both failures in the same way, so probe can fail with the MSI-X
map and mailbox routing still armed on the device.

> +	/*
> +	 * destroy_msix_map() sends ack-requested messages which may requeue
> +	 * clean_mbx_task via polling send path. Drain work after the operation.
> +	 */
> +	cancel_work_sync(&common_dev->clean_mbx_task);
> +}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831021408.2325-1-illusion.wang%40nebula-matrix.com
