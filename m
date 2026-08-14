Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA7935B657;
	Fri, 14 Aug 2026 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736902; cv=none; b=ZFhu4/vX08iXK5sEdB/kWEB0jF7NSm7a9+e8qLwP7Jq2YQJWBG9WfQOigtXJYGGIfxLthxM6RWLBJMXw57pqkJLExfBYie7LfauiI6l1sGK7dPjAIzHiUcfg+u1aJe0mYw3aDPYPZuvMChzbumQiVLlEvzQFITunWWAKZN4Es70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736902; c=relaxed/simple;
	bh=aolEbL8Mi/QBU1uulHViUfHycvGZ7h6NDOJVU6UPpK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWSh2sqF9M/uOQH2OBxvMfO4Aibpr67sx2jkQqn5wWeEJwI8CoVceEFDtCjkxqEnNT61V9jJHLeJl3eMDMOzO40xWP3bc2SBGknxezdLwrm5veDch0xJ6OnT69uoPWEFjfIP7Ch4YYqGMNWfSM64tgn/JzUW7/HwhqTkve7jtlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUzP8Sgq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUzP8Sgq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7381F00A3A;
	Fri, 14 Aug 2026 19:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786736900;
	bh=XPQsCt6bEt5odctlZ7pxxeB6Cs5FZtvs8xD8SNadZS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cUzP8Sgq4pSzKCT/N8uSZ+RnXL+/Za5W1NCm7y3ab+Tq0Pl6/MA7QFsTowflGgUqW
	 TMdaRassjbWb1g/XAgxP+oXQgq390v7bKl7JWkqZzc14CEDM3FNiQWoAv51v9M2Tzu
	 +xiwAQeEoyotHrXE58R8j+soSFP5z+IKuM8350UwEim/8K0oNS/uG/EM5XsBCEMSGy
	 +0x4G4kG4dafLQtgVKoZ8qeCczOclRWWQYjB22gYQmbrkmBA125x7y9xWIOu3GCsrB
	 b0NffFaSFok+uVR5tpvP/kXoqZhlCYU72zw7Rmq4sZO/51LpocMEArb0jgkHxOwQGI
	 rcgEA6Oj2STTQ==
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
Subject: Re: [PATCH v24 net-next 11/11] net/nebula-matrix: add common dev start/stop operation
Date: Fri, 14 Aug 2026 12:48:19 -0700
Message-ID: <20260814194819.3201177-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807044422.2356-12-illusion.wang@nebula-matrix.com>
References: <20260807044422.2356-12-illusion.wang@nebula-matrix.com>
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
net/nebula-matrix: add common dev start/stop operation

Adds nbl_dev_start()/nbl_dev_stop() to configure the hardware MSI-X map,
allocate MSI-X vectors, request/free the mailbox IRQ and enable/disable the
mailbox interrupt, and hooks nbl_core_start()/nbl_core_stop() into the PCI
probe and remove paths.  Also drops the NULL checks around the chip
init_module/deinit_module ops.

A few questions below.

> net/nebula-matrix: add common dev start/stop operation
>
> Add device start/stop helper functions to manage MSI-X vector mapping,
> mailbox interrupt resource initialization and deinitialization.
> Create unbound global workqueue for mailbox task scheduling; this shared
> work infrastructure supports both current interrupt-driven receive and
> future polling receive path.
[ ... ]
> Extend channel TX waiting logic with polling fallback and shutdown detection.
> When interrupt path is disabled, send routines rely on active polling to
> wait for message ACK, preventing deadlock during device stop.

[Severity: Low]
Do these two paragraphs describe changes that are in this patch?

Diffing this commit against its parent for nbl_common/ and nbl_channel/
gives an empty diff.  The workqueue is created by the pre-existing
nbl_common_create_wq():

  common->wq = alloc_workqueue("%s", WQ_UNBOUND, 0, wq_name);

which is per-PCI-device rather than global, and the polling/shutdown-aware
ACK wait already exists in nbl_chan_send_msg() from the preceding
"add common/ctrl dev init/remove operation" commit.

This patch only consumes both, via queue_work() in
nbl_dev_clean_mailbox_schedule() and chan_ops->set_queue_state().  Could
the changelog be adjusted so bisection and backporting point at the commit
that actually adds them?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> index bdb4d6a45fbc..3a8b7ee2e475 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c

[ ... ]

> @@ -14,6 +25,187 @@ static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
>  	msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1;
>  }
>  
> +static int nbl_dev_request_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
> +{
[ ... ]
> +	snprintf(dev_common->mailbox_name, sizeof(dev_common->mailbox_name),
> +		 "nbl_mailbox@pci:%s", pci_name(common->pdev));
> +	err = request_irq(irq_num, nbl_dev_clean_mailbox, 0,
> +			  dev_common->mailbox_name, dev_mgt);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}

[ ... ]

> +static int nbl_dev_disable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
> +{
[ ... ]
> +	 * This helper is invoked in two paths:
> +	 * 1. Error unwind path of nbl_dev_start(): immediately followed by
> +	 *    nbl_dev_free_mailbox_irq(), channel resources
> +	 *    are fully torn down afterwards, no stale descriptors remain.
> +	 * 2. Normal device stop path nbl_dev_stop(): free_irq() synchronously
> +	 *    waits for any in-flight threaded irq bottom-half handler to
> +	 *    finish execution, all pending mailbox cleanup work completes
> +	 *    before channel teardown in late remove stage. No stuck
> +	 *    descriptors will linger in either scenario.
> +	 */

[Severity: Low]
Is there actually a threaded IRQ bottom half here for free_irq() to wait
on?

nbl_dev_request_mailbox_irq() uses request_irq(), which passes
thread_fn == NULL to request_threaded_irq(), so nbl_dev_clean_mailbox()
runs entirely in hardirq context.

The real bottom half is a workqueue item:

  static irqreturn_t nbl_dev_clean_mailbox(int irq, void *data)
  {
	nbl_dev_clean_mailbox_schedule(dev_mgt);   /* queue_work(common->wq, ...) */
	return IRQ_HANDLED;
  }

free_irq() has no knowledge of that work item.  And nbl_dev_stop()
follows free_irq() with cancel_work_sync(&common_dev->clean_mbx_task),
which dequeues a queued-but-not-yet-started item so it never runs, rather
than letting "all pending mailbox cleanup work complete".

Could the comment be reworded to match what the code does?

> +	chan_ops->set_queue_state(dev_mgt->chan_ops_tbl->priv,
> +				  NBL_CHAN_INTERRUPT_READY,
> +				  NBL_CHAN_TYPE_MAILBOX, false);
> +
> +	return disp_ops->set_mailbox_irq(dev_mgt->disp_ops_tbl->priv,
> +					    local_vec_id, false);
> +}

[Severity: Low]
This isn't a bug today, but the wait strategy in nbl_chan_send_msg() is
picked once from an unlocked test_bit():

  if (test_bit(NBL_CHAN_INTERRUPT_READY, chan_info->state)) {
	... wait_event_timeout(wait_head->wait_queue,
		READ_ONCE(wait_head->acked) || READ_ONCE(chan_info->shutdown),
		NBL_CHAN_ACK_WAIT_TIME);

A sender that already sampled the bit as set and committed to that branch
would not be released by nbl_dev_stop(), since the stop path never sets
chan_info->shutdown (only nbl_chan_teardown_queue() does, and it runs
later) and never wakes the wait queues, so it would burn the full ack
timeout and report a spurious failure.

Enumerating the ack=1 senders, all of them are the dispatch request
wrappers called only from nbl_dev_init()/nbl_dev_start()/nbl_dev_stop(),
i.e. probe/remove for that device, which the driver core serialises, and
the mailbox RX path only sends acks with ack=0.  So no second waiter can
exist for a given chan_info at the moment.  Is it worth re-checking the
bit inside the wait, or setting shutdown/waking the waiters here, for
future concurrent users?

[ ... ]

> @@ -238,3 +438,62 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
[ ... ]
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
> +		return ret;

[Severity: Medium]
Should this return jump to init_interrupt_scheme_err instead, so that
nbl_dev_destroy_msix_map() runs?

Every other step in the sequence has an unwind label, and this one can
fail after the hardware side already committed.  On a non-control PF
(has_ctrl == 0, i.e. any function other than PF0), cfg_msix_map is
nbl_disp_chan_cfg_msix_map_req(), a mailbox RPC that returns whatever
nbl_chan_send_msg() returns, including -ETIMEDOUT when the ack is lost or
late, while the control PF responder already ran res_ops->cfg_msix_map()
successfully.

On the control PF that call reaches the point of no return:

  /* Phase2: All new resource allocation succeeded. */
  ret = nbl_res_intr_destroy_msix_map(res_mgt, func_id);
  ...
  intr_mgt->func_intr_res[func_id].interrupts = tmp_interrupts;

after which the kcalloc'ed interrupts[] array, the dmam_alloc_coherent
MSI-X map table and the bits set in intr_net_bmap/intr_other_bmap are only
released by nbl_res_intr_destroy_msix_map(), reachable only through
destroy_msix_map.

Combined with the probe error path below clearing drvdata, nbl_dev_stop()
never runs afterwards, so destroy_msix_map is never issued.  Does this
leak the control PF's interrupts[] array, the MSI-X map DMA table and the
vector bitmap bits?

> +
> +	ret = nbl_dev_init_interrupt_scheme(dev_mgt);
> +	if (ret)
> +		goto init_interrupt_scheme_err;
[ ... ]
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
> +	cancel_work_sync(&common_dev->clean_mbx_task);
> +	nbl_dev_clear_interrupt_scheme(dev_mgt);
> +	ret = nbl_dev_destroy_msix_map(dev_mgt);

[Severity: Low]
Does this cancel_work_sync() achieve anything, given what the next call
does?

nbl_dev_disable_mailbox_irq() has just cleared NBL_CHAN_INTERRUPT_READY,
so on a non-control PF nbl_dev_destroy_msix_map() ->
nbl_disp_chan_destroy_msix_map_req() -> send_msg(..., ack=1) takes the
polling branch of nbl_chan_send_msg(), which re-arms the same work item on
each poll iteration:

  task = READ_ONCE(chan_info->clean_task);
  if (common->wq && task && !READ_ONCE(chan_info->shutdown))
	queue_work(common->wq, task);

clean_task is &common_dev->clean_mbx_task, registered by
nbl_dev_register_chan_task(), so clean_mbx_task is pending or running
again by the time nbl_dev_stop() returns.

It is harmless today because nbl_dev_remove_chan_queue() ->
nbl_chan_teardown_queue() later drains inflight senders, cancel_work_sync()s
clean_task and NULLs it before nbl_common_destroy_wq().  Would moving the
cancel after destroy_msix_map(), or dropping it, be clearer?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c
> index bd175e200408..c1e6180a7010 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c
> @@ -9,8 +9,7 @@ void nbl_res_chip_deinit_module(struct nbl_resource_mgt *res_mgt)
>  {
>  	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
>  
> -	if (hw_ops->deinit_module)
> -		hw_ops->deinit_module(res_mgt->hw_ops_tbl->priv);
> +	hw_ops->deinit_module(res_mgt->hw_ops_tbl->priv);
>  }
>  
>  int nbl_res_chip_init_module(struct nbl_resource_mgt *res_mgt)
> @@ -20,7 +19,5 @@ int nbl_res_chip_init_module(struct nbl_resource_mgt *res_mgt)
>  	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
>  	struct nbl_hw_mgt *p = res_mgt->hw_ops_tbl->priv;
>  
> -	if (hw_ops->init_module)
> -		return hw_ops->init_module(p, eth_speed, eth_num);
> -	return -EOPNOTSUPP;
> +	return hw_ops->init_module(p, eth_speed, eth_num);
>  }

[Severity: Low]
Is this hunk related to dev start/stop?  Nothing in the changelog mentions
removing the NULL guards or the -EOPNOTSUPP fallback.

The removal looks safe today, since the single hw_ops instance statically
initialises both callbacks and nbl_hw_setup_ops() rejects a table with
NULL init_module/deinit_module, but none of that is visible from the
changelog.  Could this go into its own patch, or at least be mentioned?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index 8a968a06b5b6..c12a53da6a9b 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> @@ -131,7 +141,14 @@ static int nbl_probe(struct pci_dev *pdev,
>  		goto adapter_init_err;
>  	}
>  	pci_set_drvdata(pdev, adapter);
> +	err = nbl_core_start(adapter);
> +	if (err)
> +		goto core_start_err;
> +
>  	return 0;
> +core_start_err:
> +	pci_set_drvdata(pdev, NULL);
> +	nbl_core_remove(adapter);
>  adapter_init_err:
>  	pci_clear_master(pdev);
>  configure_dma_err:

This is the path referenced above: clearing drvdata here means nbl_remove()
sees a NULL adapter, so nbl_core_stop() and therefore
nbl_dev_destroy_msix_map() can never run for a probe that failed inside
nbl_dev_start().
