Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A24F648E;
	Thu,  3 Sep 2026 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455926; cv=none; b=igBqoghTSiGAPnVAToI7jIBRzPzt+myO2CfGOymecX9zuAen0RJLFy1RLPo3MybbI1Z+vOParOJeE+tqYjFj6lGL+4W3VHq6xUBCjZuvKaDlI+kTwVnl5R147o6fq6EF/GAMXbvck+IstHtaPUypPr9JHArGWL5SsloHJyr6oF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455926; c=relaxed/simple;
	bh=H0sJBh3iUa08WvqQ5JDWgyEAeOZooaz4nRPyuuyryZ4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eutUj9c3eXIst9hUxXvg/Dm4/b+MnvwBTc9wytigG+1Rush6HlhlxietNVOpc+giHusyQJ8gBSYRKUZ49/Lt7vmP1nLbV4Ob2hOKCgztq6Ye9xNjK3qrZu+EVaHmTUFV8JUsn5ws2p663ld4bzed0WDdSo0hqun5h+q5/Rq2FII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2mEkntg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2mEkntg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD031F0155A;
	Thu,  3 Sep 2026 17:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455923;
	bh=MOtVnJbS/DYlH7nyySfpVxUsD+BgnvAkYBMz7V8I6DM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k2mEkntg4pQCrjxbAPJJfUvh7iVavCJU5bs5Xro1weVwC+xN6W5s0yNKdRUadTuQ8
	 CQeZ6K5oeLaZiOPSTKc0nK8AEqJDTnEGEy4kqsD2t5/yTJqHrNaVhMwW0OtLf/HzEf
	 I90+/aDoBGrPRvcA58Gf2EeBLuXel8RU5apb4PTKytpLsDj342W0JcgXZmuvDRWNU/
	 xakl48xmKF1g7gQ5Ow63qkFuTylJN4Qa7qaG/rvEmufUT/ZpUuanE0OJxU7kSG/c/7
	 hTaGmiT1CNy3WQmYLZV3BxD5lzILpAyLLU74xgMQ8pkTFugB4nKC3jPp6Qf/31pRj0
	 VasE/5vb2YKyg==
Subject: Re: [v26,net-next,08/10] net/nebula-matrix: dispatch: implement
 channel RPC framework and serialize hardware ops
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 17:18:42 +0000
Message-ID: <178845592228.3394541.3958833094999526357@kernel.org>
In-Reply-To: <20260831021408.2325-9-illusion.wang@nebula-matrix.com>
References: <20260831021408.2325-9-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 4 · Low: 4

- [Medium] All five new *_req() helpers translate the return value of
  chan_ops->send_msg() with a switch that only enumerates the four wire…
- [Medium] nbl_disp_setup_msg()'s rollback calls
  chan_ops->unregister_all_msg(), which is…
- [Medium] nbl_disp_chan_get_vsi_id_req() and
  nbl_disp_chan_get_eth_id_req() consume the ACK payload without…
- [Medium] The newly exposed destroy_msix_map op (local
  nbl_disp_destroy_msix_map(), remote…
- [Low] The commit message describes work the diff does not contain.
- [Low] nbl_disp_init() sets NBL_DISP_CTRL_LVL_NET whenever
  common->has_net, with a comment claiming this enables the 'net control…
- [Low] The kernel-doc block that this patch extends states 'Warning: All
  ops except init_module/deinit_module can be safely called on PF/VF',…
- [Low] The newly exposed NBL_CHAN_MSG_CONFIGURE_MSIX_MAP handler
  forwards peer-supplied vector counts straight to the global allocator…

--

net/nebula-matrix: dispatch: implement channel RPC framework and serialize
hardware ops

This adds mailbox RPC request/response handlers for configure_msix_map,
destroy_msix_map, set_mailbox_irq, get_vsi_id and get_eth_id, resolving the
dispatch ops to either local hardware calls (control PF) or remote requests
to the manager PF. It also adds a per-dispatch mutex to serialize the
mutable hardware ops, plus new wire message types and a permission-denied
status code.

A few questions below about the commit message and about the new handlers.

The commit message says:

    Improve message payload validation for forward compatibility:
    reject requests with insufficient payload length, enforce bounds
    checks before parsing incoming RPC parameters. Fix unimplemented
    operation check ordering to avoid potential NULL pointer
    dereferences.

and:

    Add helper to register channel response callbacks; extend wire
    protocol with new message types and NBL_CHAN_RESP_PERM_DENY error
    code.

[Severity: Low]
Which pre-existing code do the words "Improve", "Fix ... ordering" and
"Add helper" refer to?

At the parent commit the only helpers in nbl_dispatch.c are
nbl_disp_init_module() and nbl_disp_deinit_module(), and both already had
the guard:

	if (res_ops->init_module)
		return res_ops->init_module(p);
	return -EOPNOTSUPP;

Neither is touched by this patch, so no check ordering appears to change.
Likewise, every handler containing a data_len < sizeof(param) test is
introduced by this patch, so there is no earlier validation being improved.

register_msg() and unregister_all_msg() also already exist in
struct nbl_channel_ops, and nbl_chan_setup_ops() already registers
NBL_CHAN_MSG_ACK; what this patch adds is a dispatch-layer setup function,
nbl_disp_setup_msg(), not a channel helper.

Could the wording be changed to describe the new code as new, so readers do
not look for a Fixes: tag and a previously broken commit?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> index 3da5f8351fa4..239d8317a9c5 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> @@ -3,9 +3,170 @@
>   * Copyright (c) 2026 Nebula Matrix Limited.
>   */
>  #include <linux/device.h>
> +#include <linux/mutex.h>
>  #include <linux/pci.h>
>  #include "nbl_dispatch.h"
>  
> +static int nbl_disp_chan_get_vsi_id_req(struct nbl_dispatch_mgt *disp_mgt,
> +					u16 type, u16 *vsi_id)
> +{
> +	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
> +	struct nbl_common_info *common = disp_mgt->common;
> +	struct nbl_chan_param_get_vsi_id result = { 0 };
> +	struct nbl_chan_param_get_vsi_id param = { 0 };
> +	struct nbl_chan_send_info chan_send = {0};
> +	int ret;
> +
> +	param.type = cpu_to_le16(type);
> +
> +	nbl_chan_fill_send_info(&chan_send, common->mgt_pf,
> +				NBL_CHAN_MSG_GET_VSI_ID,
> +				&param, sizeof(param), &result,
> +				sizeof(result), 1);
> +	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
> +	switch (ret) {
> +	case NBL_CHAN_RESP_OK:
> +		break;
> +	case NBL_CHAN_RESP_UNIMPLEMENTED:
> +		return -EOPNOTSUPP;
> +	case NBL_CHAN_RESP_ERR:
> +		return -EREMOTEIO;
> +	case NBL_CHAN_RESP_PERM_DENY:
> +		return -EPERM;
> +	default:
> +		return -EREMOTEIO;
> +	}

[Severity: Medium]
Does this switch turn every local transport error into -EREMOTEIO?

nbl_chan_send_msg() only returns a wire status code when an ACK actually
arrives.  Otherwise it returns a negative Linux errno:

nbl_channel/nbl_channel.c:nbl_chan_send_msg() {
	...
	if (READ_ONCE(chan_info->shutdn)) { ... return -ESHUTDOWN; }
	...
	ret = -ETIMEDOUT;
	...
	ret = READ_ONCE(wait_head->ack_err);
}

plus -EINVAL for oversized arg_len/resp_len, -EAGAIN when all TX wait slots
are busy, and -EIO when the mailbox IRQ is disabled mid-wait.

All of those land in the default arm, so a caller cannot tell a retryable
or teardown condition from a genuine remote hardware failure, and
nbl_dev_stop() ends up logging a remote I/O error for what was really
-ESHUTDOWN or -ETIMEDOUT.  The same switch is repeated in
nbl_disp_chan_get_eth_id_req(), nbl_disp_chan_cfg_msix_map_req(),
nbl_disp_chan_destroy_msix_map_req() and
nbl_disp_chan_set_mailbox_irq_req().

Would an early "if (ret < 0) return ret;" before the switch preserve the
error semantics the changelog aims for?

> +	*vsi_id = le16_to_cpu(result.vsi_id);
> +	return 0;
> +}

[ ... ]

> +	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
> +	switch (ret) {
> +	case NBL_CHAN_RESP_OK:
> +		break;
> +	case NBL_CHAN_RESP_UNIMPLEMENTED:
> +		return -EOPNOTSUPP;
> +	case NBL_CHAN_RESP_ERR:
> +		return -EREMOTEIO;
> +	case NBL_CHAN_RESP_PERM_DENY:
> +		return -EPERM;
> +	default:
> +		return -EREMOTEIO;
> +	}
> +	*eth_num = result.eth_num;
> +	*eth_id = result.eth_id;
> +	*logic_eth_id = result.logic_eth_id;
> +
> +	return 0;
> +}

[Severity: Medium]
Can a short ACK make these two helpers report success with zeroed
identifiers?

nbl_chan_recv_ack_msg() takes the status straight from the wire and only
clamps the payload copy, reporting the effective length back through
chan_send->ack_len:

nbl_channel/nbl_channel.c:nbl_chan_recv_ack_msg() {
	...
	copy_len = min_t(u32, READ_ONCE(wait_head->ack_data_len), ack_datalen);
	if (READ_ONCE(wait_head->ack_err) >= 0 && copy_len > 0) {
		...
		WRITE_ONCE(wait_head->ack_data_len, (u16)copy_len);
	}
}

nbl_disp_chan_get_vsi_id_req() and nbl_disp_chan_get_eth_id_req() never look
at chan_send.ack_len, so a peer answering status OK with a truncated or
empty payload leaves the "= { 0 }" initialiser values in place and the
caller gets vsi_id 0, eth_id 0, logic_eth_id 0, eth_num 0 and a 0 return.
Per nbl_res_ctrl_dev_vsi_info_init() ("pf0,pf1,pf2,pf3 vsi is 0,256,512,768")
vsi_id 0 and eth_id 0 are valid identifiers belonging to PF0, so a
non-control PF would silently adopt another function's VSI/port identity.

There is also no range check on the returned values, unlike the local
producer:

nbl_hw/nbl_resource.c:nbl_res_get_eth_id() {
	...
	if (rel_pf_id >= eth_info->eth_num) {
		dev_err(dev, "rel_pf_id %d out of range [0, %u)\n", ...);
		return -ERANGE;
	}
}

Should these helpers check chan_send.ack_len against sizeof(result) and
bound eth_num/eth_id/logic_eth_id against NBL_MAX_ETHERNET before handing
the values to the caller?

> @@ -25,6 +186,346 @@ static int nbl_disp_init_module(struct nbl_dispatch_mgt *disp_mgt)
>  	return -EOPNOTSUPP;
>  }
>  

[ ... ]

> +	if (res_ops->cfg_msix_map) {
> +		mutex_lock(&disp_mgt->ops_mutex_lock);
> +		ret = res_ops->cfg_msix_map(p, src_id,
> +					    le16_to_cpu(param.num_net_msix),
> +					    le16_to_cpu(param.num_others_msix),
> +					    !!le16_to_cpu(param.msix_mask_en));
> +		mutex_unlock(&disp_mgt->ops_mutex_lock);
> +		if (ret)
> +			err = NBL_CHAN_RESP_ERR;
> +	} else {
> +		err = NBL_CHAN_RESP_UNIMPLEMENTED;
> +	}

[Severity: Low]
Should there be a per-function limit on the requested vector counts here?

After the coarse src_id check the peer-supplied counts go straight to the
global allocator, which only enforces device-wide maxima:

nbl_hw/nbl_interrupt.c:nbl_res_intr_cfg_msix_map() {
	...
	if (num_net_msix > NBL_MSIX_MAP_TABLE_MAX_ENTRIES ||
	    num_others_msix > NBL_MSIX_MAP_TABLE_MAX_ENTRIES) { ... }
}

The accepted maximum for num_others_msix equals the whole shared pool
(NBL_MAX_OTHER_INTERRUPT is 1024), so a single request for 1024 drains
intr_other_bmap and every later allocation for any function, including the
control PF's own mailbox and misc vectors, then fails with -EAGAIN.

Each request also does a full 1024-entry coherent DMA table allocation and
the usleep_range(100, 120) quiesce inside nbl_res_intr_destroy_msix_map()
while ops_mutex_lock is held, which stalls the control PF's mailbox work
item.

> +	if (src_id > NBL_MAX_PF_SRC_ID) {
> +		err = NBL_CHAN_RESP_PERM_DENY;
> +		goto ack_out;
> +	}
> +	if (res_ops->destroy_msix_map) {
> +		mutex_lock(&disp_mgt->ops_mutex_lock);
> +		ret = res_ops->destroy_msix_map(p, src_id);
> +		mutex_unlock(&disp_mgt->ops_mutex_lock);
> +		if (ret)
> +			err = NBL_CHAN_RESP_ERR;
> +	} else {
> +		err = NBL_CHAN_RESP_UNIMPLEMENTED;
> +	}

[Severity: Medium]
Does making destroy_msix_map remotely invokable leave the requester's
mailbox interrupt routing armed on a recycled vector?

nbl_res_intr_destroy_msix_map() masks the per-vector entries, returns the
global vector numbers to the bitmaps and frees the per-function array:

nbl_hw/nbl_interrupt.c:nbl_res_intr_destroy_msix_map() {
	...
	nbl_intr_release_bitmap(res_mgt, interrupts, intr_num);
	...
	kfree(intr_mgt->func_intr_res[func_id].interrupts);
	intr_mgt->func_intr_res[func_id].interrupts = NULL;
}

but MSIX_IDX/MSIX_IDX_VALID in NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id),
written only by nbl_hw_set_mailbox_irq(), is left pointing at the vector
that was just released.  It cannot be cleared afterwards either:

nbl_hw/nbl_interrupt.c:nbl_res_intr_set_mailbox_irq() {
	if (!intr_mgt->func_intr_res[func_id].interrupts) {
		dev_err(dev, "func %u MSIX map not configured\n", func_id);
		return -ENODEV;
	}
}

A later nbl_res_intr_cfg_msix_map() for another function re-validates the
same global vector with the new owner's BDF, so a mailbox event for the old
function would raise an interrupt owned by a different PF.
nbl_res_intr_cfg_msix_map() also calls the same teardown internally, so a
peer sending CONFIGURE_MSIX_MAP twice, or DESTROY_MSIX_MAP while its
mailbox IRQ is still armed, reaches this from the wire.

Would it be better to clear the mailbox QINFO mapping as part of
destroy_msix_map, or at least document the required ordering against
set_mailbox_irq in nbl_def_dispatch.h?

> +static int nbl_disp_setup_msg(struct nbl_dispatch_mgt *disp_mgt)
> +{
> +	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
> +	struct nbl_channel_mgt *p = disp_mgt->chan_ops_tbl->priv;
> +	int ret = 0;
> +	int _ret;
> +
> +	_ret = chan_ops->register_msg(p, NBL_CHAN_MSG_CONFIGURE_MSIX_MAP,
> +				      nbl_disp_chan_cfg_msix_map_resp,
> +				      disp_mgt);
> +	if (_ret < 0 && !ret)
> +		ret = _ret;

[ ... ]

> +	if (ret)
> +		chan_ops->unregister_all_msg(p);
> +	return ret;
> +}

[Severity: Medium]
Does this rollback destroy state owned by the channel layer?

unregister_all_msg is nbl_chan_remove_msg_handler():

nbl_channel/nbl_channel.c:nbl_chan_remove_msg_handler() {
	if (!chan_mgt->handle_hash_tbl)
		return;
	nbl_common_remove_hash_table(chan_mgt->handle_hash_tbl);
	chan_mgt->handle_hash_tbl = NULL;
}

That frees every handler node, including the channel's own ACK handler
registered by nbl_chan_setup_ops():

	ret = nbl_chan_register_msg(chan_mgt, NBL_CHAN_MSG_ACK,
				    nbl_chan_recv_ack_msg, chan_mgt);

and then NULLs the shared table pointer with no re-init path, since
nbl_chan_init_msg_handler() is only called from nbl_chan_setup_chan_mgt().
Neither accessor tolerates a NULL table:

nbl_common/nbl_common.c:nbl_common_get_hash_node() {
	...
	key_size = tbl_mgt->tbl_key.key_size;
}

Registration is also unpaired at this layer: nbl_disp_remove() is empty and
delegates handler teardown to nbl_chan_remove_common().  As far as I can
tell no crash is reachable today, because the only failure mode of
nbl_chan_register_msg() is -ENOMEM during nbl_disp_init(), and at that point
no mailbox queue, IRQ or clean_mbx_task exists yet, so nothing looks the
table up during the unwind.  Would it be more robust to unregister only the
five message types this function registered, and to do it from
nbl_disp_remove()?

> @@ -104,14 +621,30 @@ int nbl_disp_init(struct nbl_adapter *adapter)
>  	adapter->core.disp_mgt = disp_mgt;
>  	adapter->intf.dispatch_ops_tbl = disp_ops_tbl;
>  
> +	ret = nbl_disp_setup_msg(disp_mgt);
> +	if (ret)
> +		return ret;
> +
>  	if (common->has_ctrl)
>  		nbl_disp_set_ctrl_bit(disp_mgt, NBL_DISP_CTRL_LVL_MGT);
>  
> +	/*
> +	 * For non-control PF with network capability, enable net control
> +	 * level.
> +	 * All dispatch ops declared with NBL_DISP_CTRL_LVL_MGT fall back
> +	 * to remote mailbox msg_req handlers when MGT bit is not set.
> +	 */
> +	if (common->has_net)
> +		nbl_disp_set_ctrl_bit(disp_mgt, NBL_DISP_CTRL_LVL_NET);

[Severity: Low]
Is anything reading NBL_DISP_CTRL_LVL_NET?

Grepping the nbl driver at this commit, the symbol appears only in its enum
definition in nbl_def_dispatch.h and in this new set_bit().  The single
consumer of ctrl_lvl only tests the MGT bit:

nbl_core/nbl_dispatch.c:nbl_disp_refresh_ctrl_ops() {
	if (test_bit(NBL_DISP_CTRL_LVL_MGT, disp_mgt->ctrl_lvl)) {
	...
}

so the NET bit is write-only state.

The comment also says "For non-control PF with network capability", but the
condition is just common->has_net, and every entry in nbl_id_table sets
BIT(NBL_CAP_HAS_NET_BIT), so the control PF takes this branch too.  Should
the condition and the comment be reconciled, or the bit dropped until a
reader exists?

>  	nbl_disp_refresh_ctrl_ops(disp_mgt);
>  	return 0;
>  }

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> index d5e7da0fef6e..61083a750da4 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> @@ -22,12 +22,28 @@ enum {
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

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> index ebf85702cef6..a53138530c54 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> @@ -15,6 +15,8 @@
>  
>  #define NBL_MAX_FUNC					520
>  #define NBL_MAX_ETHERNET				4
> +/* Product firmware only supports 1/2/4 contiguous PFs (ID 0~3) */
> +#define NBL_MAX_PF_SRC_ID				3

[Severity: Low]
Does this constant contradict the documented contract just above?

The kernel-doc extended by this patch says the five new ops "can be safely
called on PF/VF", but on a non-control function they resolve to the *_req()
helpers, and every new responder starts with:

	if (src_id > NBL_MAX_PF_SRC_ID) {
		err = NBL_CHAN_RESP_PERM_DENY;
		goto ack_out;
	}

src_id is the mailbox descriptor srcid in a function-id space of
NBL_MAX_FUNC (520), so any VF requester is denied by construction and its
*_req() helper returns -EPERM.

The hardcoded 3 also disagrees with the runtime model used elsewhere:
nbl_common_func_id_to_rel_pf_id() computes pf_id - common->mgt_pf and is
documented to "Support future non-zero management PF", while
nbl_res_func_id_to_bdf() and nbl_res_get_eth_id() validate against
resource_info->max_pf.  With mgt_pf != 0 the legitimate absolute PF ids
exceed 3 and would be denied as well.

No VF can bind this driver today, since nbl_id_table lists only PF device
ids and mgt_pf is hardcoded to 0 in nbl_core_init(), so this is a
documentation and future-proofing question rather than an active failure.
Would validating src_id against mgt_pf plus max_pf be preferable to the new
constant, or should the "PF/VF" wording be adjusted?

>  
>  enum {
>  	NBL_VSI_DATA = 0,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831021408.2325-1-illusion.wang%40nebula-matrix.com
