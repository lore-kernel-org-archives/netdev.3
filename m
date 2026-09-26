Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8B54734CD;
	Sat, 26 Sep 2026 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431246; cv=none; b=vCIGAVjbRevTXxQllNdllPrZfpp7hhCJm97l2ByJPZ97cHj5/FEVFYc3mvlLb/BuAGeZxODxu1V399OBN3HpT3C5w2MfWWcYNW7pRDyjTTmRQRY2JOAyOwKtobSPKQvTjnDuv2Lz6uGQF0TlxGANANstx+xp3wcPxARhAw847vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431246; c=relaxed/simple;
	bh=UVyorD8u+HmPFG3WUMfRVj3Ac1ihAuAQYGtgrl7BbXI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HXV9um6VHwv7WHRzdFr7hwcDmwLCrqesBjDnchDcJEnX0zOWO+NDinHLJaS2cnvH5N1CIo7U/FIjy0BqAnCUReCMMmsYpKSDSOkK48P3d3g3+wPVwqFCRvYy4dboVS5SWFtBBE0lMymtBtUSVq6aZt+xhnlO2blXZcVfI83shlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3J/9Aqp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3J/9Aqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CD81F0089B;
	Sat, 26 Sep 2026 14:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790431234;
	bh=7/sXmsCvX1jyRUOrAuOig/cu508hL2DMPFty0GgacIs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m3J/9AqpGeLe8s5whgzoMvQ4pHTuOAzi5KcHkMkC+yZeEZLb+mMJKHtrXHbRqgU/Q
	 8RYaSinEJ8NQ2mVCaYeOcGZok+q1vzwB59dMsDopn5YBmCS1Im+AFrWSr60jQ0CGoI
	 hWnI/jFqWWBUdvUFAXtVTItDUST73tH3NN9MY2pwHZDZNyQjlh9Yef8kMj0b1AN6kx
	 reWTEDjWTIlb3rtzPs4i1VGV1odcwJC8xtutMqzVIpZKxRUxx1yBjPAbMi+krSORNr
	 6V8pTFymLz7jgEUec0EHKS50xuAbnp3rhFxoIOJhuysmfBb4gTdLZHm/nCCtpXB4cJ
	 StERshNvKn8hA==
Subject: Re: [PATCH v29 net-next 6/8] net/nebula-matrix: dispatch: implement
 channel RPC framework and serialize hardware ops
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 26 Sep 2026 14:00:33 +0000
Message-ID: <179043123302.2160803.15867452260065939664@kernel.org>
In-Reply-To: <20260922120311.86593-7-illusion.wang@nebula-matrix.com>
References: <20260922120311.86593-7-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The kernel-doc block for struct nbl_dispatch_ops
  (drivers/net/ethernet/nebula-…
- [Low] All five new responders collapse resource-layer errors into a
  single -EREMOTEIO on the wire (`ret = res_ops->...(); if (ret) err =…
- [Low] The two "Precondition: caller must disable mailbox IRQ_RDY and
  switch send_msg to polling path ..." comments are attached to the…
- [Low] Reported concern: nbl_disp_chan_set_mailbox_irq_req() is the only
  newly added mutating RPC without the polling-path precondition…
- [Low] Reported concern: the five mailbox responders registered by
  nbl_disp_setup_msg() are never quiesced or unregistered by the…

Pre-existing issues:
- [Low] Reported concern: on the reconfiguration path cfg_msix_map
  rewrites the function's coherent MSI-X map table in place while…

--

net/nebula-matrix: dispatch: implement channel RPC framework and serialize hardware ops

This adds mailbox RPC request/response handlers for five dispatch
operations (configure_msix_map, destroy_msix_map, set_mailbox_irq,
get_vsi_id, get_eth_id), resolves disp_ops dynamically from the PF control
capability, and adds a per-dispatch mutex to serialize the mutating
hardware ops.

A few questions below, mostly about the documented contracts and about
error propagation on the wire.

On the commit message:

>     cfg_msix_map pre-allocates all coherent DMA buffers and global
>     vector indices before destroying the old configuration, then swaps
>     the new resources into the per-function entry to avoid interrupt
>     loss during reconfiguration.

[Severity: Low]
This isn't a bug introduced by this patch, but does the resource layer
actually match this description on the reconfiguration path?

In nbl_res_intr_cfg_msix_map() in nbl_hw/nbl_interrupt.c the existing
coherent map table is rewritten in place:

	msix_map_entries = official_tbl->base_addr;
	memset(msix_map_entries + requested, 0, ...);
	for (i = 0; i < requested; i++)
		msix_map_entries[i].data = ...;

while PCOMPLETER_FUNCTION_MSIX_MAP still has VALID=1 pointing at that
buffer, i.e. without the clear-VALID/quiesce sequence the teardown path
uses.

Each struct nbl_msix_map entry is a single __le16 so no torn entry is
possible, and the old global vectors have already had their
PCOMPLETER_HOST_MSIX_FID_TABLE / PADPT_HOST_MSIX_INFO entries
invalidated, so interrupts arriving in that window are suppressed rather
than misrouted. Also, no caller in this series reaches the
reconfiguration branch, since it requires
func_intr_res[func_id].interrupts != NULL and nbl_dev_start() destroys
the map on every failure path (err_destroy_map), while nbl_dev_stop()
destroys it on the normal path.

Would it be more accurate to drop or qualify the "avoid interrupt loss
during reconfiguration" claim?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> index 966fee2dec8b0..d12ef86835283 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> @@ -3,9 +3,176 @@

[ ... ]

> +	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
> +	if (ret)
> +		return ret;
> +	if (chan_send.ack_len != sizeof(result)) {
> +		dev_err(disp_mgt->common->dev,
> +			"get_vsi_id: short ACK, ack_len=%u expected %zu\n",
> +			chan_send.ack_len, sizeof(result));
> +		return -EREMOTEIO;
> +	}

[ ... ]

> @@ -25,6 +192,347 @@ static int nbl_disp_init_module(struct nbl_dispatch_mgt *disp_mgt)
>  	return -EOPNOTSUPP;
>  }
>  
> +static int nbl_disp_cfg_msix_map(struct nbl_dispatch_mgt *disp_mgt,
> +				 u16 num_net_msix, u16 num_others_msix,
> +				 bool net_msix_mask_en)
> +{
[ ... ]
> +	mutex_lock(&disp_mgt->ops_mutex_lock);
> +	ret = res_ops->cfg_msix_map(p, common->mgt_pf, num_net_msix,
> +					  num_others_msix, net_msix_mask_en);
> +	mutex_unlock(&disp_mgt->ops_mutex_lock);
> +	return ret;
> +}

[ ... ]

> +/*
> + * Precondition: caller must disable mailbox IRQ_RDY and switch send_msg
> + * to polling path before issuing cfg_msix_map RPC.
> + * The responder will disable mailbox MSIX routing during resource ops,
> + * so ACK cannot rely on interrupt wakeup.
> + */
> +static void nbl_disp_chan_cfg_msix_map_resp(void *priv, u16 src_id, u16 msg_id,
> +					    void *data, u32 data_len)

[Severity: Low]
Is this comment attached to the right function? The precondition talks
about what the caller must do, but nbl_disp_chan_cfg_msix_map_resp() runs
on the manager PF out of the mailbox RX work item and has no such caller.

The same applies to the identical comment above
nbl_disp_chan_destroy_msix_map_resp().

The functions whose callers need to honour this are
nbl_disp_chan_cfg_msix_map_req() / nbl_disp_chan_destroy_msix_map_req(),
and the @cfg_msix_map / @destroy_msix_map kernel-doc entries in
nbl_def_dispatch.h that external callers read, none of which mention the
requirement.

A future caller reading only the ops documentation could issue the RPC
with NBL_CHAN_IRQ_RDY still set, so nbl_chan_send_msg() takes the
wait_event_timeout() branch while the responder is retargeting mailbox
MSI-X routing, and the call fails with a spurious timeout. Today
nbl_dev_start() / nbl_dev_stop() do satisfy the precondition, so nothing
misbehaves. Could the comment move to the req helpers and the ops
kernel-doc instead?

> +{
[ ... ]
> +	if (res_ops->cfg_msix_map) {
> +		mutex_lock(&disp_mgt->ops_mutex_lock);
> +		ret = res_ops->cfg_msix_map(p, src_id,
> +					    le16_to_cpu(param.num_net_msix),
> +					    le16_to_cpu(param.num_others_msix),
> +					    !!le16_to_cpu(param.msix_mask_en));
> +		mutex_unlock(&disp_mgt->ops_mutex_lock);
> +		if (ret)
> +			err = -EREMOTEIO;

[Severity: Low]
Is the errno substitution here intentional? All five new responders
collapse every resource-layer failure into -EREMOTEIO, while the local
control-PF implementations of the same disp_ops entries return the
resource errno verbatim:

nbl_disp_cfg_msix_map()
	ret = res_ops->cfg_msix_map(p, common->mgt_pf, ...);
	return ret;

nbl_disp_chan_cfg_msix_map_resp()
	ret = res_ops->cfg_msix_map(p, src_id, ...);
	if (ret)
		err = -EREMOTEIO;

nbl_res_intr_cfg_msix_map() in nbl_hw/nbl_interrupt.c distinguishes the
cases:

		dev_err(dev, "No free control interrupt vectors left\n");
		ret = -EAGAIN;

and also produces -ESHUTDOWN while intr_mgt->stopping, -EBUSY, -EINVAL
and -ENOMEM, all of which are lost on the wire.

-EREMOTEIO is also what nbl_disp_chan_get_vsi_id_req() and
nbl_disp_chan_get_eth_id_req() return for a truncated ACK, so a caller
cannot tell a protocol error from a remote operation failure.

The commit message says:

>     Remote responders return standard Linux errnos directly on the wire.

which reads as pass-through. Could the responders forward ret instead?

> +	} else {
> +		err = -EOPNOTSUPP;
> +	}

[ ... ]

> +static int nbl_disp_chan_set_mailbox_irq_req(struct nbl_dispatch_mgt *disp_mgt,
> +					     u16 vector_id, bool en_msix)
> +{
[ ... ]
> +	nbl_chan_fill_send_info(&chan_send, common->mgt_pf,
> +				NBL_CHAN_MSG_MAILBOX_SET_IRQ,
> +				&param, sizeof(param), NULL, 0, 1);
> +	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);

[Severity: Low]
This is the only newly added mutating RPC without the polling-path
precondition documented for cfg_msix_map / destroy_msix_map, even though
the responder rewrites the requester's own mailbox MSI-X routing
(NBL_MAILBOX_QINFO_MAP MSIX_IDX / MSIX_IDX_VALID) before the ACK is sent.

Looking at the callers in nbl_core/nbl_dev.c, both directions do use the
polling path, so the ACK does arrive:

nbl_dev_enable_mailbox_irq()
	ret = disp_ops->set_mailbox_irq(..., lvec, true);
	if (ret)
		return ret;
	chan_ops->set_queue_state(..., NBL_CHAN_IRQ_RDY, ..., true);

nbl_dev_disable_mailbox_irq()
	chan_ops->set_queue_state(..., NBL_CHAN_IRQ_RDY, ..., false);
	return disp_ops->set_mailbox_irq(..., lvec, false);

and nbl_chan_send_msg() selects the wait path solely on
test_bit(NBL_CHAN_IRQ_RDY, chan_info->state), which is clear in both
cases.

Would it still be worth documenting the same precondition on this req
helper, so the requirement is visible to future callers?

[ ... ]

> @@ -34,9 +542,22 @@ static void nbl_disp_refresh_ctrl_ops(struct nbl_dispatch_mgt *disp_mgt)
>  {
>  	struct nbl_dispatch_ops *disp_ops = disp_mgt->disp_ops_tbl->ops;
>  
> +	memset(disp_ops, 0, sizeof(*disp_ops));
>  	if (test_bit(NBL_DISP_CTRL_LVL_MGT, disp_mgt->ctrl_lvl)) {
>  		disp_ops->init_module = nbl_disp_init_module;
>  		disp_ops->deinit_module = nbl_disp_deinit_module;
> +		disp_ops->cfg_msix_map = nbl_disp_cfg_msix_map;
> +		disp_ops->destroy_msix_map = nbl_disp_destroy_msix_map;
> +		disp_ops->set_mailbox_irq = nbl_disp_set_mailbox_irq;
> +		disp_ops->get_vsi_id = nbl_disp_get_vsi_id;
> +		disp_ops->get_eth_id = nbl_disp_get_eth_id;
> +	} else if (test_bit(NBL_DISP_CTRL_LVL_NET, disp_mgt->ctrl_lvl)) {
> +		disp_ops->cfg_msix_map =
> +			nbl_disp_chan_cfg_msix_map_req;
> +		disp_ops->destroy_msix_map = nbl_disp_chan_destroy_msix_map_req;
> +		disp_ops->set_mailbox_irq = nbl_disp_chan_set_mailbox_irq_req;
> +		disp_ops->get_vsi_id = nbl_disp_chan_get_vsi_id_req;
> +		disp_ops->get_eth_id = nbl_disp_chan_get_eth_id_req;
>  	}
>  }

[ ... ]

> @@ -104,14 +629,25 @@ int nbl_disp_init(struct nbl_adapter *adapter)
>  	adapter->core.disp_mgt = disp_mgt;
>  	adapter->intf.dispatch_ops_tbl = disp_ops_tbl;
>  
> +	ret = nbl_disp_setup_msg(disp_mgt);
> +	if (ret)
> +		return ret;
> +
[ ... ]
>  void nbl_disp_remove(struct nbl_adapter *adapter)
>  {
> -	/* Dispatch structures are allocated via devm */
> +	/*
> +	 * Dispatch structures are allocated via devm.
> +	 * Message handlers registered by nbl_disp_setup_msg() are owned by
> +	 * channel layer; they are unregistered in nbl_chan_remove_common(),
> +	 * not here.
> +	 */
>  }

[Severity: Low]
Since the five responders registered here are never quiesced by the
dispatch layer, is the ordering on teardown guaranteed, i.e. can
nbl_chan_remove_msg_handler() free a handler node while the RX dispatch
path still holds it, or can a responder run after nbl_intr_mgt_stop() has
cleared res_mgt->intr_mgt?

Tracing the remove path, it does look safe. nbl_core_remove() reaches
nbl_dev_remove_common_dev() first:

	cancel_work_sync(&common_dev->clean_mbx_task);
	ret = nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);

which ends in nbl_chan_teardown_queue(), stopping the hardware mailbox
queue and joining the clean task:

	if (task)
		cancel_work_sync(task);
	WRITE_ONCE(chan_info->active, false);

and only afterwards does nbl_chan_remove_common() drain the workqueue
before freeing the nodes:

	nbl_common_destroy_wq(&adap->common);
	...
	nbl_chan_remove_msg_handler(chan_mgt);

Would it be worth spelling out that ordering dependency in the comment,
since it is what makes the empty nbl_disp_remove() correct?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> index b0daabb05d394..61083a750da47 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> @@ -21,12 +22,28 @@ enum {
>   *               caller must check has_ctrl guard
>   * @deinit_module: dispatch layer cleanup, ONLY valid on Control PF,
>   *                 caller must check has_ctrl guard
> + * @cfg_msix_map: configure function msix mapping table
> + * @destroy_msix_map: tear down msix mapping resource
> + * @set_mailbox_irq: bind mailbox interrupt to specified msix vector
> + * @get_vsi_id: resolve VSI ID by type
> + * @get_eth_id: resolve eth port info from VSI ID
> + *
>   * Warning: All ops except init_module/deinit_module can be safely called
>   * on PF/VF; init/deinit hooks are control-PF exclusive to prevent NULL ptr.
>   */

[Severity: Low]
This Warning now also covers the five ops being documented here, but does
it still hold for them?

On the VF part, every new responder rejects a src_id whose relative PF id
is at or above common->max_pf:

	if (rel_pf_id >= disp_mgt->common->max_pf) {
		err = -EPERM;
		goto ack_out;
	}

With mgt_pf as the base, rel_pf_id equals src_id for the usual case and
max_pf is 1, 2 or 4 from nbl_res_init_pf_num() while NBL_MAX_FUNC is 520,
so the entire VF function-id range gets -EPERM. The commit message agrees:

>     - src_id against common->max_pf at runtime; rejects VF and
>       out-of-range function IDs with -EPERM;

On the NULL part, nbl_disp_refresh_ctrl_ops() now starts with
memset(disp_ops, 0, sizeof(*disp_ops)) and fills the table only under MGT
or NET, so a function with neither capability bit leaves all five
pointers NULL, while callers such as nbl_dev_cfg_msix_map() and
nbl_dev_enable_mailbox_irq() in nbl_dev.c dereference
disp_ops->cfg_msix_map and disp_ops->set_mailbox_irq without a NULL test.
That combination is not reachable today, since every entry in
nbl_id_table[] sets BIT(NBL_CAP_HAS_NET_BIT) and no VF is probed.

Could the Warning be narrowed to say the five new ops are PF-only and
depend on the has_ctrl/has_net capability?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922120311.86593-2-illusion.wang%40nebula-matrix.com
