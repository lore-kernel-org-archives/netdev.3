Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF435E1B8;
	Fri,  2 Oct 2026 03:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790912121; cv=none; b=OPJLBOc3KqYV+s5468Ikf4jHwFQeIP5pI3WB9JcR6qAsfqUbl4tRxWG7vw94mkh2G1kvxMr3nScg6FfGJ5RdNTcK/TXkrmeiu7C1gqSbmW6q2FCwTldISsgGLt0HlwudQ0h/TJgd7bG4W09g8VwjsKdCAnuccU3oNo8pMjWXZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790912121; c=relaxed/simple;
	bh=k/Cd56kkgyKRtT4domImJUr3YG7zWaNV3L6l8q3Wpaw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgCnYEFpjXHxNFiwAGIlEh5uojLsB33nGv5wY6eA67TVV/fKNu2XrGoDZVJN1Wz97EvIs/GeW/GHOHczlY+KNK/ing3ygj6gagyOqAguGdKRndQ5qMw+4B818BeSGzoFeq1iMkPtFIUUGthARJX3Zk0JBPeCL3Tn5sxMqesdAck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5HdzWfL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5HdzWfL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC0B1F00898;
	Fri,  2 Oct 2026 03:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790912119;
	bh=S5KwbT+y3NwsgzKkidZiQ9OGGHQzYVf8mBfHsrV6byM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g5HdzWfLyzCEvvy/4xFboWfn1i1E05isUteyrga3ZiICrd1neLlA0ruz5l50YLLAW
	 EXosHuaPf8vTM+Cm6OHkvNOV3xKBw3VSbPdoqYQDro9kfyPJpmd033d7Oe6Th7/HcV
	 c5LGvireoXX9+FA+V6ZaHAidaKpqhwEGLhxUXLNX5RTZqhDV08p4kSOgCD2cVYRFCb
	 eBuRB0GToKZvq2L/r43Y7mwZeZaY3Syir4o9druJBv7fvwOGbQebFF4JX3FEmws9ID
	 foAniKt5AIAOJH8LcTMcQSDAe6NNKQOmWw5bUuy4LjWw8A7rSrtaRtw8lPjWS5uz14
	 Zdq4NTPmr9sdg==
Subject: Re: [PATCH v30 net-next 6/8] net/nebula-matrix: dispatch: implement
 channel RPC framework and serialize hardware ops
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 03:35:18 +0000
Message-ID: <179091211823.434549.12932765831147789319@kernel.org>
In-Reply-To: <20260928123237.88994-7-illusion.wang@nebula-matrix.com>
References: <20260928123237.88994-7-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes three changes that are not in
  this patch.
- [Low] The commit message contradicts the error codes the patch actually
  returns.
- [Low] Concern (baseline: not a valid finding at end of series):
  nbl_disp_remove()'s new comment describes a teardown sequence that…
- [Low] The new disp_mgt->ops_mutex_lock is redundant with the resource
  layer's own locking, which contradicts the commit message's claim that…
- [Low] Concern (baseline: not a valid finding):
  nbl_disp_chan_cfg_msix_map_resp() passes the peer's num_net_msix and…

--

net/nebula-matrix: dispatch: implement channel RPC framework and serialize hardware ops

This patch adds mailbox RPC request and response handlers for five
dispatch operations: cfg_msix_map, destroy_msix_map, set_mailbox_irq,
get_vsi_id and get_eth_id. The management PF calls the resource ops
directly, and net-capable non-management PFs forward them to the
management PF over the channel. It also adds a per-dispatch mutex around
the MSI-X and mailbox IRQ operations, which change hardware state.

> Fix error propagation by forwarding native Linux errnos from remote
> resource operations instead of unconditionally returning -EREMOTEIO.
> Only truncated ACK responses return -EREMOTEIO to distinguish protocol
> errors from legitimate operation failures. Transport layer errors are
> passed through unchanged from channel send routines.

[Severity: Low]
Does this paragraph match the code? Both new ACK length checks, in
nbl_disp_chan_get_vsi_id_req() and nbl_disp_chan_get_eth_id_req(),
return -EBADMSG, not -EREMOTEIO:

    if (chan_send.ack_len != sizeof(result)) {
        ...
        return -EBADMSG;
    }

The only -EREMOTEIO in the driver appears to be in
nbl_chan_recv_ack_msg() in nbl_channel/nbl_channel.c. There it replaces
an out-of-range remote errno, so it has nothing to do with a truncated
ACK:

    if (raw_err > 0 || raw_err < -MAX_ERRNO)
        raw_err = -EREMOTEIO;

The parent commit also has no RPC request or response code. So there is
no earlier "unconditionally returning -EREMOTEIO" behaviour for this
patch to fix.

Was this paragraph left over from an earlier revision?

> - Other functions: all dispatch ops are null and return -EOPNOTSUPP.

[ ... ]

> For MSIX map reconfiguration, pre-allocate DMA buffers and vector indices
> prior to tearing down old configurations to prevent interrupt loss.
> Destroy path clears mailbox MSIX routing entries upfront to avoid stale
> interrupt triggers from recycled hardware vectors.

[ ... ]

> Narrow kernel-doc warning to clarify new ops are PF-capability bounded,
> not available for VF functions.

[Severity: Medium]
Several parts of the commit message describe changes that this patch
does not contain.

For a function with neither the MGT bit nor the NET bit set,
nbl_disp_refresh_ctrl_ops() memsets disp_ops and assigns nothing, so the
pointers stay NULL. Calling one of those ops is a NULL function pointer
call, not an -EOPNOTSUPP return. The kernel-doc in nbl_def_dispatch.h
already says callers must not invoke them, which matches the code.

The MSI-X pre-allocation, and the clearing of the mailbox routing at the
start of destroy, live in nbl_res_intr_cfg_msix_map() and
__nbl_res_intr_prepare_destroy_msix_map() in nbl_hw/nbl_interrupt.c. The
earlier commit "net/nebula-matrix: add intr resource implementation"
added that code, and this patch does not touch nbl_hw/.

The "Warning:" paragraph in the struct nbl_dispatch_ops kernel-doc is
identical in the parent commit, which already listed the five ops and
the VF restriction. This patch only adds the @member lines.

Could the commit message describe only what this patch changes?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> index 966fee2dec8b..e6a5e53e9d2d 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c

[ ... ]

> @@ -25,6 +194,357 @@ static int nbl_disp_init_module(struct nbl_dispatch_mgt *disp_mgt)
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
Is ops_mutex_lock needed here? The resource ops already serialize
themselves under intr_mgt->lock. The documentation of
nbl_res_intr_cfg_msix_map() says:

 * Serialization: this function takes intr_mgt->lock internally to
 * protect the global vector bitmaps and per-function state against
 * concurrent callers.

nbl_res_intr_set_mailbox_irq() also takes intr_mgt->lock internally.
nbl_res_intr_destroy_msix_map() takes it around
__nbl_res_intr_destroy_msix_map(). The "add intr resource
implementation" commit also says callers need no upper-layer locking.

This wrapper makes a single resource call. So do
nbl_disp_destroy_msix_map(), nbl_disp_set_mailbox_irq() and the three
matching *_resp handlers. None of them has a multi-step sequence that
needs an outer lock.

The field comment in nbl_dispatch.h, "use for the caller not in
interrupt", does not say what the mutex protects. That makes the commit
message's claim that the mutex eliminates concurrent modification races
hard to square with the code.

Could the mutex be dropped? If it covers state that intr_mgt->lock does
not, could that state be documented?

[ ... ]

> +static void nbl_disp_chan_cfg_msix_map_resp(void *priv, u16 src_id, u16 msg_id,
> +					    void *data, u32 data_len)
> +{

[ ... ]

> +	if (res_ops->cfg_msix_map) {
> +		mutex_lock(&disp_mgt->ops_mutex_lock);
> +		ret = res_ops->cfg_msix_map(p, src_id,
> +					    le16_to_cpu(param.num_net_msix),
> +					    le16_to_cpu(param.num_others_msix),
> +					    !!le16_to_cpu(param.msix_mask_en));
> +		mutex_unlock(&disp_mgt->ops_mutex_lock);

[Severity: Low]
num_net_msix and num_others_msix come straight from the peer PF and go
to nbl_res_intr_cfg_msix_map(). The only bound there appears to be the
table size:

    if (num_net_msix > NBL_MSIX_MAP_TABLE_MAX_ENTRIES ||
        num_others_msix > NBL_MSIX_MAP_TABLE_MAX_ENTRIES) {

NBL_MSIX_MAP_TABLE_MAX_ENTRIES (1024) equals the size of the other
interrupt pool (NBL_MAX_OTHER_INTERRUPT). Could one PF request nearly
all of the other vectors and leave the remaining PFs with -EAGAIN?

This probably can't be reached in practice:

- The rel_pf_id < max_pf check rejects VFs.
- nbl_get_func_param() in nbl_main.c says the hardware and firmware
  forbid PF passthrough to guests. Every peer PF therefore runs this
  same host driver.
- The in-tree requester nbl_dev_cfg_msix_map() only asks for the counts
  from nbl_dev_init_msix_cnt(): one mailbox vector and no net vectors.

Is a per-function limit worth adding anyway, or is a peer PF always
treated as trusted?

[ ... ]

> @@ -104,14 +641,40 @@ int nbl_disp_init(struct nbl_adapter *adapter)

[ ... ]

>  void nbl_disp_remove(struct nbl_adapter *adapter)
>  {
> -	/* Dispatch structures are allocated via devm */
> +	/*
> +	 * Dispatch structures are devm-allocated and freed at detach.
> +	 *
> +	 * The five responders registered by nbl_disp_setup_msg() are
> +	 * owned by the channel layer (xarray of handlers) and are never
> +	 * unregistered here. This is safe because the teardown order
> +	 * guarantees no responder can run after this point:
> +	 *
> +	 *   mailbox teardown
> +	 *     -> cancel_work_sync(clean_mbx_task)   // drain RX work
> +	 *     -> nbl_chan_teardown_queue()          // stop HW queue,
> +	 *                                                 // join clean task,
> +	 *                                                 // active=false
> +	 *     -> nbl_chan_remove_common()
> +	 *          -> destroy_wq()                       // no new work
> +	 *          -> nbl_chan_remove_msg_handler()      // free handler nodes
> +	 *
> +	 * By the time devres frees disp_mgt, the mailbox queue is stopped
> +	 * and the handler xarray is empty, so no responder can touch
> +	 * res_mgt->intr_mgt after nbl_intr_mgt_stop() has cleared it.
> +	 */
>  }

[Severity: Low]
Does this teardown sequence exist at this commit? clean_mbx_task is not
defined yet, and nothing calls the channel setup_queue or teardown_queue
ops. So the "cancel_work_sync(clean_mbx_task) ->
nbl_chan_teardown_queue()" chain refers to code that doesn't exist yet
at this point in the series.

This is not a reachable race here, because the mailbox queue is never
set up and the responders can't run.

The next patch, "net/nebula-matrix: add common/ctrl dev init/remove
operation", makes the comment accurate. It adds nbl_dev_remove() ahead
of nbl_disp_remove() in nbl_core_remove(). Its
nbl_dev_remove_common_dev() calls
cancel_work_sync(&common_dev->clean_mbx_task) and then
nbl_chan_teardown_queue(), both before nbl_res_remove_leonis() calls
nbl_intr_mgt_stop().

Would it make sense to move this comment into that patch, so the comment
matches the code at each point in the series?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928123237.88994-1-illusion.wang%40nebula-matrix.com
