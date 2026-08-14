Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2785371CFF;
	Fri, 14 Aug 2026 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736901; cv=none; b=YMAIcqk+BYA2dmoMFiLOaR3YPDvabXN580IGyQq0opZKjIHOjf/D+EuBMWR5sUQIu7xYZGhBMQdELGB1D2MNK5N/YXo3RnvVCzPbWJHsll4gwGDpUuebhkfx1Lz+po8r87DrF+rI6dNb/MgiKGw9B6tnsWMHGg+yRXAPYsctV7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736901; c=relaxed/simple;
	bh=L2UBnNEioWvOjt95HkXthddIhhyVVzBTVk4pTtB9TLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDEOHwrDmDKGvxYaIHFNx32OnZKh6YFsLNHD9feEGd7YuARXv1UEcLGZbEKoOdqWouBpIWMk9QiTmlnmTK2RrofGj7T3LuS1ghN7RS/wumYoZ8ofFGJ0S2AL/aiMMekCmyMOLp4xPVRrZpqLtj+Cw3KB/ANIWmjNEbYb5OZ/LUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa3+hFFd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa3+hFFd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09871F000E9;
	Fri, 14 Aug 2026 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786736899;
	bh=4+14QEwiJy2qdOdlERrHJROx+aMg0PyNKC8Iwx3ni4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oa3+hFFdx6KYdymCIXoIErBlXo/FBiScjwsy52V4o/5S3G4eTIpxHgmR4orvtDuZk
	 rm6100DOkSInaCZQeCVAF70sd3mfBx98a0AKRl3gYNu/losFOYDbUIJRzJergJqo7D
	 qvWX+TisPGcSIpqPvWPwHzIlWETsjVwD8o4KZQQWVLOeNMBVAvBEOWtFJen5FNTBfV
	 0zR13uN3f8ngcuU1QvlHQK45WWNNa2KuiiP5odGIXtDx9UFcHZKdzAaa7dUmxIrkhx
	 DYpW51W/3kT1BaKivfQP+aSyHz1wixLsVkJnSWjWrwOd8EsjaRXgNk8ENJ+8+or+zb
	 L1Phk5WNnOOYg==
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
Subject: Re: [PATCH v24 net-next 10/11] net/nebula-matrix: add common/ctrl dev init/remove operation
Date: Fri, 14 Aug 2026 12:48:18 -0700
Message-ID: <20260814194818.3201147-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807044422.2356-11-illusion.wang@nebula-matrix.com>
References: <20260807044422.2356-11-illusion.wang@nebula-matrix.com>
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
net/nebula-matrix: add common/ctrl dev init/remove operation

This adds nbl_dev.c with nbl_dev_setup_common_dev() and
nbl_dev_setup_ctrl_dev() plus their teardown paths, hooks them into
nbl_core_init()/nbl_core_remove(), adds a per-adapter workqueue helper, and
extends nbl_chan_send_msg() with a polling ACK path used when
NBL_CHAN_INTERRUPT_READY is not set.

A few questions on the changelog and on the new code below.

[Severity: Low]
Is this paragraph describing the state of the tree at this commit?

> Mailbox message processing is implemented via work_struct. This task
> registration framework is reused for interrupt-driven receive now, and
> can be shared with polling receive mode introduced in follow-up patches.

At this commit NBL_CHAN_INTERRUPT_READY is only ever tested, in
nbl_chan_send_msg(); nothing sets it, and there is no request_irq() or
pci_alloc_irq_vectors() anywhere under drivers/net/ethernet/nebula-matrix/.
The bit is first set (and the mailbox IRQ first requested) by the later
"net/nebula-matrix: add common dev start/stop operation" patch.

So the relationship looks inverted: polling is what is live now, and the
wait_event_timeout() branch of nbl_chan_send_msg() is unreachable here.
Every synchronous request issued by this patch (get_vsi_id/get_eth_id from
nbl_dev_setup_common_dev()) goes through the new polling loop, which can
run NBL_CHAN_TX_WAIT_ACK_TIMES (5000) iterations of roughly 1 ms, i.e. up
to about 5 seconds per message during probe. Would it be worth saying that
explicitly?

Also on this sentence:

> requests rely on polling to wait for firmware ACK, avoiding silent
> success and uninitialized variable reads when NBL_CHAN_INTERRUPT_READY
> is not yet set.

Before this patch, ret still held 0 from nbl_chan_kick_tx_ring() when the
if/else fell through, so the old behaviour was returning success with an
unpopulated response buffer rather than reading an uninitialized variable.
Could the wording be adjusted?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> index 9e0f9b6c4c3a..3b7f3876a075 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> @@ -636,10 +636,13 @@ static void nbl_chan_advance_rx_ring(struct nbl_channel_mgt *chan_mgt,
>  static void nbl_chan_clean_queue(struct nbl_channel_mgt *chan_mgt,
>  				 struct nbl_chan_info *chan_info)
>  {
> +	struct nbl_common_info *common = chan_mgt->common;
>  	struct nbl_chan_ring *rxq = &chan_info->rxq;
>  	struct device *dev = chan_mgt->common->dev;
>  	struct nbl_chan_rx_desc *rx_desc;
>  	struct nbl_chan_buf *rx_buf;
> +	struct work_struct *task;
> +	bool more_work = false;
>  	u16 next_to_clean;
>  	u32 budget = 64;
>  	u16 flags;
> @@ -666,11 +669,22 @@ static void nbl_chan_clean_queue(struct nbl_channel_mgt *chan_mgt,
>  			next_to_clean = 0;
>  		rx_desc = NBL_CHAN_RX_RING_TO_DESC(rxq, next_to_clean);
>  		rx_buf = NBL_CHAN_RX_RING_TO_BUF(rxq, next_to_clean);
> -		if (--budget == 0)
> +		if (--budget == 0) {
> +			more_work = true;
>  			break;
> +		}
>  		cond_resched();
>  	}
>  	rxq->next_to_clean = next_to_clean;
> +

[Severity: Low]
Should the changelog mention that nbl_chan_clean_queue() becomes a
self-rearming worker here? The changelog only says "Mailbox message
processing is implemented via work_struct" and describes the polling ACK
fallback, but this hunk also changes the semantics of an existing function
in nbl_channel.c: it now re-queues its own work item on budget exhaustion
and returns early on shutdown.

Small related point: more_work is set purely on budget exhaustion, so a
ring holding exactly 64 used descriptors re-arms the work once with nothing
left to clean. Is that intended?

> +	/* Prevent queue_work after teardown clears clean_task */
> +	if (READ_ONCE(chan_info->shutdown))
> +		return;

[Severity: Low]
Does this comment hold? The guard is two independent unordered loads
followed by queue_work(), with nothing serializing them against
nbl_chan_teardown_queue().

Looking at nbl_chan_teardown_queue():

	while (atomic_read(&chan_info->inflight_tx_cnt) != 0) {
		if (time_after(jiffies, wait_start + wait_timeout)) {
			dev_warn(chan_mgt->common->dev,
				 "teardown: wait inflight_tx_cnt timeout, force continue\n");
			ret = -ETIMEDOUT;
			break;
		}
		...
	}

	/* Step3: All send paths drained, safely cancel cleanup work */
	if (chan_info->clean_task) {
		cancel_work_sync(chan_info->clean_task);
		chan_info->clean_task = NULL;
	}

The drain is bounded at 5 s and teardown continues regardless, so a context
that has already observed shutdown == false and a non-NULL clean_task can
still call queue_work() after teardown finished. The flag check narrows the
window but does not close it, and the same pattern is repeated in the new
polling loop of nbl_chan_send_msg(). Could the comment be reworded, or the
publish/clear of clean_task be made to actually interlock with the readers?

> +	if (common->wq && more_work) {
> +		task = READ_ONCE(chan_info->clean_task);
> +		if (task)
> +			queue_work(common->wq, task);
> +	}
>  }
>  
>  static void nbl_chan_clean_queue_subtask(struct nbl_channel_mgt *chan_mgt,

[ ... ]

> @@ -869,6 +885,60 @@ static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
>  		WRITE_ONCE(wait_head->ack_data_len, 0);
>  		spin_unlock_irq(&wait_head->status_lock);
>  		goto inflight_dec_out;
> +	} else {
> +		/* Polling wait path for synchronous ACK */
> +		while (i--) {
> +			if (READ_ONCE(chan_info->shutdown)) {
> +				ret = -ESHUTDOWN;
> +				/*
> +				 * Shutdown happens during polling wait,
> +				 * reclaim slot
> +				 */
> +				spin_lock_irq(&wait_head->status_lock);
> +				WRITE_ONCE(wait_head->acked, 0);
> +				WRITE_ONCE(wait_head->ack_data, NULL);
> +				WRITE_ONCE(wait_head->ack_data_len, 0);
> +				WRITE_ONCE(wait_head->status,
> +					   NBL_MBX_STATUS_TIMEOUT);
> +				spin_unlock_irq(&wait_head->status_lock);
> +				goto inflight_dec_out;
> +			}
> +
> +			task = READ_ONCE(chan_info->clean_task);
> +			if (common->wq && task &&
> +			    !READ_ONCE(chan_info->shutdown))
> +				queue_work(common->wq, task);
> +
> +			spin_lock_irq(&wait_head->status_lock);
> +			if (READ_ONCE(wait_head->acked)) {
> +				chan_send->ack_len = wait_head->ack_data_len;
> +				ret = wait_head->ack_err;
> +				WRITE_ONCE(wait_head->acked, 0);
> +				WRITE_ONCE(wait_head->status,
> +					   NBL_MBX_STATUS_IDLE);
> +				spin_unlock_irq(&wait_head->status_lock);
> +				goto inflight_dec_out;
> +			}

[Severity: Low]
Is it intentional that this success path leaves wait_head->ack_data and
wait_head->ack_data_len set while publishing the slot as
NBL_MBX_STATUS_IDLE?

Every other exit of nbl_chan_send_msg() clears both, for example the
interrupt-wait success path just above:

	WRITE_ONCE(wait_head->acked, 0);
	WRITE_ONCE(wait_head->status, NBL_MBX_STATUS_IDLE);
	WRITE_ONCE(wait_head->ack_data, NULL);
	WRITE_ONCE(wait_head->ack_data_len, 0);

and so do the new polling shutdown and polling timeout blocks. Here the
slot is released as IDLE with ack_data still pointing at the caller's stack
response buffer (for instance the local result struct in
nbl_disp_chan_get_vsi_id_req()) and a non-zero ack_data_len.

Today nothing dereferences it, because nbl_chan_recv_ack_msg() only writes
through ack_data when status == NBL_MBX_STATUS_WAITING, and the send path
re-assigns both fields before re-arming a slot as WAITING. The visible
effect is a stale length in the "Skip ack with invalid status" diagnostic.
Should this path clear them anyway to keep the slot-release contract
uniform?

> +			spin_unlock_irq(&wait_head->status_lock);
> +
> +			usleep_range(NBL_CHAN_TX_WAIT_ACK_US_MIN,
> +				     NBL_CHAN_TX_WAIT_ACK_US_MAX);
> +			cond_resched();
> +		}
> +
> +		/* Polling loop exhausted, reclaim slot */
> +		spin_lock_irq(&wait_head->status_lock);
> +		WRITE_ONCE(wait_head->acked, 0);
> +		WRITE_ONCE(wait_head->ack_data, NULL);
> +		WRITE_ONCE(wait_head->ack_data_len, 0);
> +		WRITE_ONCE(wait_head->status, NBL_MBX_STATUS_TIMEOUT);
> +		spin_unlock_irq(&wait_head->status_lock);

[Severity: Low]
Can this block throw away an ACK that arrived during the last sleep?

The final iteration tests acked before its usleep_range(1000, 1200), and
this cleanup then clears acked and forces NBL_MBX_STATUS_TIMEOUT without
re-testing it. An ACK delivered in that last window is processed by the
clean work item, which reaches nbl_chan_recv_ack_msg():

	ack_done:
		WRITE_ONCE(wait_head->acked, 1);
		spin_unlock_irq(&wait_head->status_lock);

That only sets acked/ack_err/ack_data_len and leaves status at
NBL_MBX_STATUS_WAITING, so the cleanup here cannot distinguish "never
acked" from "just acked". The caller gets -ETIMEDOUT even though the
response was already copied into its buffer, and in
nbl_dev_setup_common_dev() that aborts nbl_dev_init() and the whole probe.
The interrupt path re-tests the status before overwriting it; should this
one do the same?

> +
> +		dev_err_ratelimited(dev,
> +				    "Channel polling ack failed, message type: %d msg id: %u\n",
> +				    chan_send->msg_type, msgid);
> +		ret = -ETIMEDOUT;
> +		goto inflight_dec_out;
>  	}
>  
>  inflight_dec_out:
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
> index 92db39e1b05e..d59e660be9c7 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
> @@ -24,6 +24,9 @@
>  #define NBL_CHAN_TX_WAIT_US			100
>  #define NBL_CHAN_TX_WAIT_US_MAX			120
>  #define NBL_CHAN_TX_WAIT_TIMES			100
> +#define NBL_CHAN_TX_WAIT_ACK_US_MIN		1000
> +#define NBL_CHAN_TX_WAIT_ACK_US_MAX		1200
> +#define NBL_CHAN_TX_WAIT_ACK_TIMES		5000
>  #define NBL_CHAN_QUEUE_LEN			256
>  #define NBL_CHAN_BUF_LEN			4096
>  #define NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN	16
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
> index 149681dd216d..f10ef78ee7f6 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
> @@ -7,6 +7,27 @@
>  #include <linux/jhash.h>
>  #include "nbl_common.h"
>  
> +void nbl_common_destroy_wq(struct nbl_common_info *common)
> +{
> +	destroy_workqueue(common->wq);
> +}

[Severity: Medium]
Should this set common->wq = NULL after destroy_workqueue()?

Both new queue_work() sites use the pointer itself as the liveness test:

nbl_chan_clean_queue():
	if (common->wq && more_work) {
		task = READ_ONCE(chan_info->clean_task);
		if (task)
			queue_work(common->wq, task);
	}

nbl_chan_send_msg() polling loop:
	task = READ_ONCE(chan_info->clean_task);
	if (common->wq && task && !READ_ONCE(chan_info->shutdown))
		queue_work(common->wq, task);

Can this end up as a use-after-free of the workqueue? nbl_dev_remove()
runs nbl_dev_remove_common_dev() (which reaches nbl_chan_teardown_queue(),
whose inflight drain is explicitly best-effort: after 5 s it prints
"teardown: wait inflight_tx_cnt timeout, force continue", sets -ETIMEDOUT
and proceeds to cancel_work_sync() plus clean_task = NULL), then calls
nbl_common_destroy_wq(common) unconditionally, ignoring that result.

Meanwhile the polling loop itself can run 5000 iterations of 1.0-1.2 ms,
which is longer than the 5 s drain bound. A sender preempted between its
shutdown check and queue_work(common->wq, task) would then queue onto a
freed workqueue and re-arm a work item after cancel_work_sync(). Would
clearing common->wq under the same ordering that clears clean_task, plus a
NULL guard here, close that?

> +
> +int nbl_common_create_wq(struct nbl_common_info *common)
> +{
> +	char wq_name[32];
> +
> +	snprintf(wq_name, sizeof(wq_name), "nbl_wq_%s", pci_name(common->pdev));
> +	common->wq = alloc_workqueue("%s", WQ_UNBOUND, 0, wq_name);
> +	if (!common->wq) {
> +		pr_err("Failed to create workqueue nbl_wq\n");
> +		goto alloc_wq_failed;
> +	}
> +
> +	return 0;
> +alloc_wq_failed:
> +	return -ENOMEM;
> +}
> +

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> new file mode 100644
> index 000000000000..bdb4d6a45fbc
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c

[ ... ]

> +/* ----------  Channel config  ---------- */
> +static void nbl_dev_setup_chan_qinfo(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
> +{
> +	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
> +	struct nbl_channel_mgt *priv = dev_mgt->chan_ops_tbl->priv;
> +	struct nbl_common_info *common = dev_mgt->common;
> +
> +	if (!chan_ops->check_queue_exist(priv, chan_type))
> +		return;
> +
> +	chan_ops->cfg_chan_qinfo_map_table(priv, common->hw_bus, common->devid);
> +}

[Severity: Low]
This isn't a bug introduced here, but this patch adds the only caller of
cfg_chan_qinfo_map_table(), which makes an existing comment checkable and
wrong. In nbl_res_ctrl_dev_sriov_info_init() the hw_bus assignment carries:

	/*
	 * common->hw_bus supplies bus number for channel mailbox QINFO mapping.
	 * Execution order guarantee: this assignment runs before
	 * cfg_chan_qinfo_map_table() in nbl_dev_start(), only executed
	 * on control PF path.
	 */

There is no nbl_dev_start() at this commit, and even after
"net/nebula-matrix: add common dev start/stop operation" adds one, it does
not call cfg_chan_qinfo_map_table(); the call lives in
nbl_dev_setup_chan_qinfo() from nbl_dev_setup_ctrl_dev(). The ordering
claim itself holds, only the named consumer is wrong. Could the comment be
updated to name nbl_dev_setup_ctrl_dev()?

[Severity: Medium]
Can this write clobber the mailbox MSI-X fields of other PFs?

nbl_chan_cfg_qinfo_map_table() loops over every host PF:

	hw_ops->get_host_pf_mask(p, &pf_mask);
	for (func_id = 0; func_id < NBL_MAX_PF; func_id++) {
		if (!(pf_mask & (1 << func_id)))
			hw_ops->cfg_mailbox_qinfo(p, func_id, bus,
						  devid, func_id);

and nbl_hw_cfg_mailbox_qinfo() is a full-word write built from zero:

	u32 data = 0;

	data = FIELD_PREP(NBL_MAILBOX_QINFO_MAP_FUNCTION_MASK, function) |
	       FIELD_PREP(NBL_MAILBOX_QINFO_MAP_DEVID_MASK, devid) |
	       FIELD_PREP(NBL_MAILBOX_QINFO_MAP_BUS_MASK, bus);
	nbl_hw_wr_regs_lock(hw_mgt, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id),
			    &data, sizeof(data));

so NBL_MAILBOX_QINFO_MAP_MSIX_IDX and MSIX_IDX_VALID are zeroed. Those are
exactly the fields nbl_hw_set_mailbox_irq() programs in the same register,
and that function already warns about this:

	/*
	 * Note: This RMW is currently safe because the two callers are strictly
	 * sequential: nbl_hw_cfg_mailbox_qinfo() runs at init, nbl_hw_set_mailbox_irq()
	 * runs at start. Future reset/hot-add/VF-reinit paths must preserve this
	 * ordering; ...
	 */

This patch puts the clobbering write on the ctrl-PF probe path, and it
rewrites entries belonging to other functions. If PF0 is unbound and
rebound while other PF instances stay bound with their mailbox MSI-X
already programmed on their behalf by the ctrl PF, do those functions lose
MSIX_IDX_VALID in hardware while their drivers still have
NBL_CHAN_INTERRUPT_READY set and keep waiting on interrupts? Would making
this write an RMW under reg_lock, or limiting it to func_ids owned by this
PF, be preferable?

> +
> +static int nbl_dev_setup_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
> +{
> +	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
> +	struct nbl_channel_mgt *priv = dev_mgt->chan_ops_tbl->priv;
> +	int ret = 0;
> +
> +	if (chan_ops->check_queue_exist(priv, chan_type))
> +		ret = chan_ops->setup_queue(priv, chan_type);
> +
> +	return ret;
> +}
> +
> +static int nbl_dev_remove_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
> +{
> +	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
> +	struct nbl_channel_mgt *priv = dev_mgt->chan_ops_tbl->priv;
> +	int ret = 0;
> +
> +	if (chan_ops->check_queue_exist(priv, chan_type))
> +		ret = chan_ops->teardown_queue(priv, chan_type);
> +
> +	return ret;
> +}

[ ... ]

> +/* ----------  Dev init process  ---------- */
> +static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter)
> +{

[ ... ]

> +	ret = nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +	if (ret)
> +		return ret;
> +
> +	INIT_WORK(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX,
> +				   &common_dev->clean_mbx_task);

[Severity: Low]
Should the publication of clean_task here be annotated? The store side is a
plain assignment in nbl_chan_register_chan_task():

	chan_info->clean_task = task;

and the clearing side in nbl_chan_teardown_queue() is likewise a plain
chan_info->clean_task = NULL, while all consumers added by this patch read
it with READ_ONCE() and immediately queue_work() the result. The
asymmetry is an unmarked-write/marked-read race that KCSAN would flag,
and in principle a cross-CPU reader could observe the pointer before the
INIT_WORK() stores to work->func. I could not find such a remote reader at
this commit or at the end of the series, so this looks latent rather than
live. Would WRITE_ONCE() or smp_store_release() here match the readers?

> +	/*
> +	 * Even if has_ctrl=false (no dedicated control PF channel), we fetch
> +	 * VSI/ETH info via regular mailbox message  instead of
> +	 * dedicated control command.
> +	 */
> +	ret = disp_ops->get_vsi_id(priv, NBL_VSI_DATA, &common->vsi_id);
> +	if (ret)
> +		goto err_cleanup;
> +	ret = disp_ops->get_eth_id(priv, common->vsi_id, &common->eth_num,
> +			     &common->eth_id, &common->logic_eth_id);
> +	if (ret)
> +		goto err_cleanup;

[ ... ]

> +static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
> +
> +	if (!common_dev)
> +		return;
> +	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +	cancel_work_sync(&common_dev->clean_mbx_task);
> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
> +}

[Severity: Low]
nbl_chan_teardown_queue() and nbl_chan_setup_queue() came from the earlier
"net/nebula-matrix: add channel layer" patch, so this isn't introduced
here, but this patch adds the first callers, so it becomes reachable.

Teardown puts both mailbox queues into hardware reset via
stop_mailbox_rxq()/stop_mailbox_txq() but leaves chan_info->init_done
true, chan_info->shutdown true, and all ring indices (txq->next_to_use,
txq->tail_ptr, rxq->next_to_clean/next_to_use/tail_ptr) at stale values.
Since nbl_chan_setup_queue() starts with:

	if (READ_ONCE(chan_info->init_done))
		return 0;

would a later re-init silently report success without re-programming the
queue base/size/QUEUE_EN registers, re-arming RX descriptors, or clearing
shutdown? Today the only setup caller is nbl_dev_setup_common_dev() and
chan_info is freshly devm_kzalloc()'d per probe, so nothing re-inits within
one adapter lifetime, but the reset/recovery paths the changelog mentions
would hit it. Should teardown clear init_done/shutdown and reset the ring
indices?

Related ordering question in the same function: nbl_chan_stop_queue() runs
before the inflight-sender drain, so a sender that already passed its
shutdown check can still publish an AVAIL descriptor, bump txq->tail_ptr
and ring the doorbell of an already-reset queue. At the end of the series
the mailbox worker sends ACKs via nbl_chan_send_ack() concurrently with
removal, so this is reachable; the effect looks like a dropped ACK plus a
tail counter permanently ahead of the zeroed hardware tail. Would draining
before stopping the queues be safer?

> +
> +static int nbl_dev_setup_ctrl_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> +	int ret;
> +
> +	ret = disp_ops->init_module(dev_mgt->disp_ops_tbl->priv);
> +	if (ret)
> +		return ret;
> +
> +	nbl_dev_setup_chan_qinfo(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +
> +	return 0;
> +}

[ ... ]

> +int nbl_dev_init(struct nbl_adapter *adapter)
> +{

[ ... ]

> +	/*
> +	 * Chip hardware initialization is completed by firmware at power-up.
> +	 * Only driver functional table/register config follows here, safe to
> +	 * access hardware registers before ctrl dev setup.
> +	 */
> +	ret = nbl_dev_setup_common_dev(adapter);
> +	if (ret)
> +		goto setup_err;
> +
> +	if (common->has_ctrl) {
> +		ret = nbl_dev_setup_ctrl_dev(adapter);
> +		if (ret)
> +			goto setup_ctrl_dev_fail;
> +	}

[Severity: Medium]
Does the firmware really cover everything this ordering depends on?

nbl_dev_setup_common_dev() reaches nbl_chan_setup_queue(), which enables
mailbox DMA before nbl_dev_setup_ctrl_dev() has run:

	nbl_chan_config_queue(chan_mgt, chan_info, true); /* tx */
	nbl_chan_config_queue(chan_mgt, chan_info, false); /* rx */
	nbl_chan_update_tail_ptr(hw_ops, chan_mgt->hw_ops_tbl->priv,
				 rxq->tail_ptr, NBL_MB_RX_QID);

Only afterwards does nbl_dev_setup_ctrl_dev() call init_module(), which
goes to nbl_hw_init_module() -> nbl_intf_init() -> nbl_host_padpt_init()
writing NBL_HOST_PADPT_HOST_CFG_FC_CPLH_UP and the other flow-control
credit registers, plus nbl_hw_set_driver_status(true); and then
nbl_dev_setup_chan_qinfo() programs the per-function routing map
NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id). Those are driver writes, not
firmware ones, so the changelog statement

> Chip core hardware initialization is fully handled by firmware during
> power-on; the driver only configures functional table entries and
> registers after hardware is ready.

does not seem to cover them. Per the driver's own comment in
nbl_hw_get_board_info(), these registers read zero after cold boot, FLR or
bus reset, so between queue enable and the qinfo write the mailbox block is
armed with an all-zero (00:00.0) routing entry.

For a PF with has_ctrl == false, nbl_dev_setup_ctrl_dev() is skipped
entirely, yet nbl_dev_setup_common_dev() deliberately issues real mailbox
transactions (get_vsi_id/get_eth_id resolve to the request variants). Does
that leave such a PF depending on a separate ctrl PF instance having
already programmed its qinfo entry, with nothing in the code enforcing or
checking it? If the ctrl PF is unbound or assigned to vfio-pci, the new
polling fallback turns this into a silent multi-second stall before
-ETIMEDOUT. Would it be safer to program the credits, driver status and
qinfo map before enabling the mailbox queues?

> +
> +	return 0;
> +setup_ctrl_dev_fail:
> +	nbl_dev_remove_common_dev(adapter);
> +setup_err:
> +	nbl_common_destroy_wq(common);
> +	return ret;
> +}

[ ... ]
