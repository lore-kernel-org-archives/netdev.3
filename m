Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F083F8717;
	Fri, 11 Sep 2026 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098115; cv=none; b=ptQAl9ZbmNTMoblz7eB9gfzdUjce9WX/AJCOnlJy77+i/M9iMlRw8guwPworAqeaFc9SpEmKAXhl8a8kJtitwuNMki8CKHZndaB0TVf9jhbFAPSYKHkwCX5PrZcF7sbkKmXSF4DgP9DSRZqJuflmSlAt/GVlYvdk3mlWJbKVrQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098115; c=relaxed/simple;
	bh=qEY+QKcUivDO6UjZ/dH23QGUG1+t8TO75/LCLqJ2Izk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TnMDys0OeP1BLfJ4y9EPvLyAvsm77OtasvPWVxF1Sk8bJYSzdD1gmaer0kUDqUOY0UcfR7jofCirCDxvQHLvtIWPWIhYog9SsWOsLv4yez+lFkOgm5jRwNvqHf5Jitx0H2hwAXbzrdGqmcopuAZPZ2zbgy71v/z1GbysORIXzFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLC3oDud; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLC3oDud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DC71F000FF;
	Fri, 11 Sep 2026 03:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789098113;
	bh=E/c14Zp9W6T7D/HFuU8gVd+9g9ci+B2NK+C+FDDSVbI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lLC3oDudUViZ2JBtQXr8sSGmVR4VJ7ykrfESqHXhnnuKgoHFQBHJyr2P1ZjQ7n14r
	 97C9Bk9uRI0r6De7HhsCh3sl1np4ncJH4WEFjAFSjC0uFeC/i9Vy7F5TNIV7r05DAr
	 gpy8HFQZv19yvh/L6hbzaEN3NjBwGnAu8S0HESHAu0YOEjsSee+Pd6NEZ9rKD4k6KQ
	 /rRodTTbQN5B/uTjSN5QMdV5SxVcM9rkpmyKnYEyL3+TC9LuVfB0K0EbNON96WDH6z
	 Obg7IIJQIN/G3FAgUvWzZuqYKD/KTO/FiYlZSAkmsafLs5bYdnPQxLfuYyxhidPNkc
	 s0Iifa1hqVpeA==
Subject: Re: [PATCH v27 net-next 08/10] net/nebula-matrix: dispatch: implement
 channel RPC framework and serialize hardware ops
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 03:41:52 +0000
Message-ID: <178909811204.219967.13607468235706435620@kernel.org>
In-Reply-To: <20260907123848.30256-9-illusion.wang@nebula-matrix.com>
References: <20260907123848.30256-9-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 6

- [Medium] All five new request helpers do 'ret =
  chan_ops->send_msg(...); if (ret < 0) return ret;' before the…
- [Low] Commit message attributes pre-existing resource-layer behaviour
  to this patch.
- [Low] The commit message justifies the new per-dispatch ops_mutex_lock
  with "This eliminates race windows between local control paths and…
- [Low] Over-broad error-path cleanup: on any partial registration
  failure, nbl_disp_setup_msg() calls chan_ops->unregister_all_msg(p),…
- [Low] Claimed namespace inconsistency: the five new responders validate
  the requester with 'src_id >= disp_mgt->common->max_pf' and pass…
- [Low] Claimed teardown race / use-after-teardown: the five responders
  registered by nbl_disp_setup_msg() are never unregistered…
- [Low] Claimed self-defeating RPC: destroy_msix_map (and cfg_msix_map,
  which internally destroys first) tear down the *requesting* function's…

--

net/nebula-matrix: dispatch: implement channel RPC framework and serialize hardware ops

This adds mailbox RPC request/response handlers for five dispatch
operations (configure_msix_map, destroy_msix_map, set_mailbox_irq,
get_vsi_id, get_eth_id), resolves the dispatch ops table based on the PF
control level, and introduces a per-dispatch mutex around the mutable
hardware ops.

A few questions on the changelog and on the new code below.

Two paragraphs of the changelog describe behaviour that lives in
nbl_hw/nbl_interrupt.c, which this patch does not touch:

>     destroy_msix_map responder clears the mailbox QINFO MSIX routing
>     (MSIX_IDX / MSIX_IDX_VALID) as Step 0 before tearing down the
>     MSI-X map, ensuring a recycled global vector cannot trigger an
>     interrupt owned by a different function.
>
>     cfg_msix_map pre-allocates all coherent DMA buffers and global
>     vector indices before destroying the old configuration, then swaps
>     the new resources into the per-function entry to avoid interrupt
>     loss during reconfiguration.

[Severity: Low]
Are these two paragraphs describing this patch?

nbl_disp_chan_destroy_msix_map_resp() only validates src_id and calls
res_ops->destroy_msix_map(), and nbl_disp_chan_cfg_msix_map_resp() only
forwards to res_ops->cfg_msix_map().

The "Step 0" comment and the pre-allocate/swap sequence are in
__nbl_res_intr_destroy_msix_map() and nbl_res_intr_cfg_msix_map() in
nbl_hw/nbl_interrupt.c:

    /* Step 0: disable mailbox IRQ routing before tearing down map */
    __nbl_res_intr_set_mailbox_irq(res_mgt, func_id, 0, false);

That file is unchanged here, and the earlier series commit that added the
intr resource implementation already documents both behaviours.  Could
these two paragraphs be dropped or reworded to describe only the
forwarding the responders do?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> index 3da5f8351fa42..5be2d0887ad41 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> @@ -3,9 +3,186 @@
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
> +	if (ret < 0)
> +		return ret;
> +	switch (ret) {

[Severity: Medium]
The changelog says the early return here only passes through local
transport errors:

>     Local transport errors (-ETIMEDOUT, -ESHUTDOWN,
>     -EAGAIN, -EIO, -EINVAL) are passed through unchanged via an early
>     "if (ret < 0) return ret" before the status switch.

Can this early return also pass through a value taken straight off the
wire?  On a successful ACK, nbl_chan_send_msg() returns
READ_ONCE(wait_head->ack_err), and nbl_chan_recv_ack_msg() fills that
field without any validation:

    WRITE_ONCE(wait_head->ack_err,
               (s32)le32_to_cpu(*(__le32 *)&payload[NBL_CHAN_ACK_RET_POS]));

So any negative 32-bit value the peer puts in the ACK is returned to the
caller as if it were a locally generated errno, bypassing the
NBL_CHAN_RESP_* translation switch that follows.  The same pattern is in
nbl_disp_chan_get_eth_id_req(), nbl_disp_chan_cfg_msix_map_req(),
nbl_disp_chan_destroy_msix_map_req() and
nbl_disp_chan_set_mailbox_irq_req().

For get_vsi_id()/get_eth_id() the value reaches ERR_PTR():

nbl_dev_setup_common_dev() -> nbl_dev_init() -> nbl_core_init()
    return ERR_PTR(ret);

nbl_probe() then only recognises the range [-4095,-1]:

    adapter = nbl_core_init(pdev, &param);
    if (IS_ERR(adapter)) { ... }
    err = nbl_core_start(adapter);

With a magnitude larger than MAX_ERRNO, IS_ERR() is false and
nbl_core_start() runs on a bogus pointer.  Would it make sense to clamp
or reject out-of-range ack_err values in nbl_chan_recv_ack_msg(), or to
sanitize the return in these helpers rather than passing it through?

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

[ ... ]

> +static void nbl_disp_chan_get_vsi_id_resp(void *priv, u16 src_id, u16 msg_id,
> +					  void *data, u32 data_len)
> +{

[ ... ]

> +	if (src_id >= disp_mgt->common->max_pf) {
> +		err = NBL_CHAN_RESP_PERM_DENY;
> +		goto ack_out;
> +	}

[Severity: Low]
This isn't a bug today, but the five responders check src_id against
[0, max_pf) and then hand src_id to res_ops->* as a func_id, while the
resource layer defines the PF func_id space relative to common->mgt_pf:

nbl_common_func_id_to_rel_pf_id() {
    if (pf_id < common->mgt_pf)
        return -EINVAL;
    *rel_pf_id = pf_id - common->mgt_pf;
    ...
}

Since nbl_core_init() sets common->mgt_pf = 0 unconditionally and nothing
else writes it, the two ranges are identical, so there is no divergence
at the moment.  Would using nbl_common_func_id_to_rel_pf_id() in the
responders keep the two layers in agreement if the "future non-zero
management PF" mentioned in the kernel-doc is ever implemented?

> +	if (data_len < sizeof(param)) {
> +		err = NBL_CHAN_RESP_ERR;
> +		goto ack_out;
> +	}
> +	memcpy(&param, data, sizeof(param));

[ ... ]

> @@ -25,6 +202,352 @@ static int nbl_disp_init_module(struct nbl_dispatch_mgt *disp_mgt)
>  	return -EOPNOTSUPP;
>  }
>  
> +static int nbl_disp_cfg_msix_map(struct nbl_dispatch_mgt *disp_mgt,
> +				 u16 num_net_msix, u16 num_others_msix,
> +				 bool net_msix_mask_en)
> +{
> +	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
> +	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
> +	struct nbl_common_info *common = disp_mgt->common;
> +	int ret;
> +
> +	if (!res_ops->cfg_msix_map)
> +		return -EOPNOTSUPP;
> +	mutex_lock(&disp_mgt->ops_mutex_lock);
> +	ret = res_ops->cfg_msix_map(p, common->mgt_pf, num_net_msix,
> +					  num_others_msix, net_msix_mask_en);
> +	mutex_unlock(&disp_mgt->ops_mutex_lock);
> +	return ret;
> +}

[Severity: Low]
The changelog says of ops_mutex_lock:

>     This eliminates race windows between local control paths and
>     asynchronous remote mailbox RPC response handlers.

Is there a race window left to eliminate?  The three wrapped ops already
serialize themselves in nbl_interrupt.c:

    nbl_res_intr_destroy_msix_map() {
        mutex_lock(&intr_mgt->lock);
        ret = __nbl_res_intr_destroy_msix_map(res_mgt, func_id);
        mutex_unlock(&intr_mgt->lock);
    }

nbl_res_intr_set_mailbox_irq() does the same, and
nbl_res_intr_cfg_msix_map() holds intr_mgt->lock across its
allocate/destroy/swap sequence.  The earlier series commit states "All
public entry points (cfg/destroy/set_irq) take this lock internally;
callers need not hold any upper-layer lock."

So this nests a second mutex around calls that are already mutually
exclusive (in a consistent order, so no deadlock).  Could the rationale
be reworded, or the outer mutex dropped, if the intent is only defensive
serialization?

[ ... ]

> +static void nbl_disp_chan_destroy_msix_map_resp(void *priv, u16 src_id,
> +						u16 msg_id, void *data,
> +						u32 data_len)
> +{

[ ... ]

> +	if (res_ops->destroy_msix_map) {
> +		mutex_lock(&disp_mgt->ops_mutex_lock);
> +		ret = res_ops->destroy_msix_map(p, src_id);
> +		mutex_unlock(&disp_mgt->ops_mutex_lock);
> +		if (ret)
> +			err = NBL_CHAN_RESP_ERR;
> +	} else {
> +		err = NBL_CHAN_RESP_UNIMPLEMENTED;
> +	}
> +ack_out:
> +	nbl_chan_fill_ack_info(&chan_ack, src_id,
> +			       NBL_CHAN_MSG_DESTROY_MSIX_MAP, msg_id,
> +			       err, NULL, 0);
> +	ret = chan_ops->send_ack(disp_mgt->chan_ops_tbl->priv, &chan_ack);

[Severity: Low]
Does the ACK here still reach the requester?  This tears down the
requesting function's map, and __nbl_res_intr_destroy_msix_map() disables
that function's mailbox MSI-X route first:

    /* Step 0: disable mailbox IRQ routing before tearing down map */
    __nbl_res_intr_set_mailbox_irq(res_mgt, func_id, 0, false);

The ACK is then sent over the mailbox whose interrupt was just disarmed,
and the NBL_CHAN_IRQ_RDY branch of nbl_chan_send_msg() only waits on
wait_event_timeout().  The same applies to cfg_msix_map, which destroys
before reconfiguring.

Looking at the callers added later in the series, this appears to be
avoided: nbl_dev_disable_mailbox_irq() clears NBL_CHAN_IRQ_RDY before
issuing the RPC, nbl_dev_stop() and the err_destroy_map path of
nbl_dev_start() only call destroy_msix_map() after that, and
nbl_dev_cfg_msix_map() runs before nbl_dev_enable_mailbox_irq() ever sets
IRQ_RDY, so send_msg() takes the polling branch and consumes the ACK
without an interrupt.  Is that ordering an invariant worth documenting
next to these responders, since it is what keeps them from timing out on
an operation that succeeded?

[ ... ]

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

[Severity: Low]
Does this rollback destroy state the dispatch layer does not own?
unregister_all_msg is nbl_chan_remove_msg_handler():

nbl_channel.c:nbl_chan_remove_msg_handler() {
    if (!chan_mgt->handle_hash_tbl)
        return;
    nbl_common_remove_hash_table(chan_mgt->handle_hash_tbl);
    chan_mgt->handle_hash_tbl = NULL;
}

That frees the whole per-adapter handler table, including the channel
layer's own NBL_CHAN_MSG_ACK handler registered in nbl_chan_setup_ops():

    ret = nbl_chan_register_msg(chan_mgt, NBL_CHAN_MSG_ACK,
                                nbl_chan_recv_ack_msg, chan_mgt);

and leaves chan_mgt (alive until nbl_chan_remove_common()) with
handle_hash_tbl == NULL, which nbl_chan_recv_msg() would pass into
nbl_common_get_hash_node(), whose first statement is:

    key_size = tbl_mgt->tbl_key.key_size;

with no NULL check.  The failure itself is reachable, since
nbl_chan_add_msg_handler() -> nbl_common_alloc_hash_node() can return
-ENOMEM.  Today nothing can crash, because on failure nbl_disp_init()
returns the error and probe is aborted before the mailbox RX ring is ever
set up, so no frame is received and no ACK is awaited.

There is no per-msg-type unregister in struct nbl_channel_ops, so a
correct partial rollback cannot be expressed with the current interface.
Would adding an unregister for a single msg_type, or simply leaving the
already-registered handlers in place on failure, be preferable to tearing
down the shared table?

[ ... ]

> @@ -104,14 +644,24 @@ int nbl_disp_init(struct nbl_adapter *adapter)
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
> -	/* All dispatch objects allocated via devm */
> +	/*
> +	 * All dispatch objects allocated via devm
> +	 * All message handlers will be cleaned up inside channel layer
> +	 * nbl_chan_remove_common() at final device tear-down
> +	 */
>  }

[Severity: Low]
Since the five responders registered by nbl_disp_setup_msg() are never
unregistered, can one of them run after the resource layer has been
stopped?  In nbl_core_remove() the order is nbl_disp_remove() ->
nbl_res_remove_leonis() (nbl_intr_mgt_stop() frees the per-function
interrupt arrays and clears res_mgt->intr_mgt) -> nbl_chan_remove_common().

Reading the later commits in the series, this looks closed:
nbl_dev_remove() runs first in nbl_core_remove(), and
nbl_dev_remove_common_dev() does

    cancel_work_sync(&common_dev->clean_mbx_task);
    nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);

which sets chan_info->shutdn, and nbl_chan_recv_msg() bails out on

    if (READ_ONCE(chan_info->shutdn))
        return;

so no responder can execute once the mailbox queue is torn down.  Is that
dependency worth spelling out in the comment, i.e. that the safety of the
no-op relies on the dev layer quiescing the channel before
nbl_res_remove_leonis() runs, rather than on nbl_chan_remove_common()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907123848.30256-1-illusion.wang%40nebula-matrix.com
