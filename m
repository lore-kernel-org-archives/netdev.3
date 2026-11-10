Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322308;
	b=W6B6vfNUaXtv7NFXFMQHITKiq3FA6HtlGB2Htyr9mlmfWHFdV5PcS9IT4AkobMzSCXIR
	 b5y76qoS7c54+5lXp9iYLy79RUfNCoZGbFKn/kI8xTKqJdMqDX+LLoviupFZTHF2aKRgO
	 eegv7GLnLygZpHr6J+AHIqCWnYcvFnDY3KXuF3hOYHPLq+I+bx5Yd97WRyc7Kll9y0CR9
	 aPYA9mi6rpg5amZFgl1FDPZRj4Lj3HFYrFKyFH4pWR0967jpO4WHvphQfeCXVIDAVN8fw
	 U4/aFj2Z93LZTRyDvdBGxqAC7G8uYzY7iybT47vDBR1npdwDgkbu5Rh4Ijouz++q/fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322308;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=D1Vu7xfdQF4eR4hyPgmWTlPYuWOE0VKf4S3hs2sAvyY=;
	b=L0jhK/n1b8b6gH4McltzOgmgqQWyHK7R+SaJhM+JTr5P/esMKuLlbRonU6DTU8CJ6fRE
	 jLsmWZUp5PJft0+kDAuKCu0oER1QBCTTgC9jVBnwFcI2oC9FQ+XyrzRAahyav04J7c9JA
	 oNW+HzCiDEtA/UH0Auhl53Z922P3miUGLc2HCfJYSRATB6LRiP2+hWUqY0FBBH1PzazNV
	 bufwGMfXv865vquil/82XH0ra1uQ9f3iSS57XkbaAZUtsaVz0YPN0zqkKa4DPq0V6fNbC
	 o/I5HsU6cjn+1JSxogW90ildbRzvI5UTtu17c444v991OS556EgQfE8WnAfQMoMvvFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L75IIeDI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30D60A2630;
	Tue, 10 Nov 2026 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L75IIeDI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FB61F008A3;
	Tue, 10 Nov 2026 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322307;
	bh=D1Vu7xfdQF4eR4hyPgmWTlPYuWOE0VKf4S3hs2sAvyY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L75IIeDI4FcIvAHtztGd7gJLu0ZS06G5ckGf2x+jJfHs4/xO2VljpY/tAdT3XYzeq
	 D82VsBlbZFvZQ1RftVAiHzY/tUBhn4Efb3KcSzbOagGCinFKnSQewLVFkpe3nWMiCP
	 wYuSAd5+Vx27OnKNIye32VtLkZuPxuGLNmX0qcNMTpcPGS7yPCkaorPA/m+itLHmdU
	 EfFn0nRMwlov8li/OmIjEjeNKVUrYdjJwDEibmHnetQHfknRT5qypgsEqotrQXxv2a
	 2giI7Xw41BP5KzZ1S9i0CLHIyas3IQyXaVIqnrm3ca6xDf2bHtxWcFYQaADqvKZW51
	 x5wRzgcCgb3TA==
Subject: Re: [PATCH v33 net-next 6/8] net/nebula-matrix: dispatch: implement
 channel RPC framework and serialize hardware ops
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 andrew+netdev@lunn.ch, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Nov 2026 14:51:46 +0000
Message-ID: <179432230658.994134.11954971726039862043@kernel.org>
In-Reply-To: <20261106045631.2224-7-illusion.wang@nebula-matrix.com>
References: <20261106045631.2224-7-illusion.wang@nebula-matrix.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch makes it possible for a sibling PF to trigger
  runtime teardown of its own MSI-X map on the control PF, and that…
- [Low] The subject line says "dispatch: implement channel RPC framework
  and serialize hardware ops", but the patch does neither of those…
- [Low] The struct nbl_dispatch_ops kernel-doc in nbl_def_dispatch.h
  justifies the empty nbl_disp_remove() like this: "the teardown order…
- [Low] nbl_disp_chan_cfg_msix_map_req(),
  nbl_disp_chan_destroy_msix_map_req() and…
- [Low] The commit message says cfg_msix_map, destroy_msix_map and
  set_mailbox_irq "carry a caller precondition": clear mailbox IRQ_RDY…

--

net/nebula-matrix: dispatch: implement channel RPC framework and serialize hardware ops

This patch adds mailbox RPC request and response handlers for five
dispatch ops: cfg_msix_map, destroy_msix_map, set_mailbox_irq, get_vsi_id
and get_eth_id. Based on has_ctrl/has_net, each op becomes either a local
resource call or a channel RPC to the management PF. The five responders
are registered with the channel layer.

> net/nebula-matrix: dispatch: implement channel RPC framework and serialize hardware ops

[Severity: Low]
This isn't a bug, but does the subject line match what the patch does?

The patch adds no lock, mutex or other serialization. The body says "No
dispatch-layer lock is taken around these ops", and the comment in
nbl_disp_cfg_msix_map() says the same thing. The only serialization is
intr_mgt->lock, which an earlier patch, "net/nebula-matrix: add intr
resource implementation", added to the resource layer.

The channel RPC framework (send_msg, send_ack, register_msg and the ACK
errno plumbing) was also added earlier, in "net/nebula-matrix: add channel
layer". This patch adds five request/response handlers on top of it.

Could the subject describe that instead, for example "dispatch: add
mailbox RPCs for msix map, mailbox irq and vsi/eth id"?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> index 966fee2dec8b0..cb68544e02723 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c

[ ... ]

> @@ -25,6 +193,353 @@ static int nbl_disp_init_module(struct nbl_dispatch_mgt *disp_mgt)
>  	return -EOPNOTSUPP;
>  }
>  

[ ... ]

> +/*
> + * Precondition: caller must disable mailbox IRQ_RDY and switch send_msg
> + * to the polling path before issuing this RPC. The responder rewrites
> + * the requester's mailbox MSI-X routing during the resource op, so the
> + * ACK cannot rely on interrupt wakeup while routing is in flux.
> + */
> +static int
> +nbl_disp_chan_cfg_msix_map_req(struct nbl_dispatch_mgt *disp_mgt,
> +			       u16 num_net_msix, u16 num_others_msix,
> +			       bool net_msix_mask_en)
> +{

[ ... ]

> +	nbl_chan_fill_send_info(&chan_send, common->mgt_pf,
> +				NBL_CHAN_MSG_CONFIGURE_MSIX_MAP,
> +				&param, sizeof(param),
> +				NULL, 0, 1);
> +	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);

[Severity: Low]
This precondition appears only as a comment, here and above
nbl_disp_chan_destroy_msix_map_req() and
nbl_disp_chan_set_mailbox_irq_req(). Could it be enforced in code instead?

Suppose one of these RPCs were sent with NBL_CHAN_IRQ_RDY set. The
responder would rewrite the requester's mailbox MSI-X routing before it
writes the ACK. The requester would then wait in the interrupt-mode path
of nbl_chan_send_msg(), which has no RX polling fallback:

nbl_chan_send_msg() {
    ...
	if (test_bit(NBL_CHAN_IRQ_RDY, chan_info->state)) {
		while (!READ_ONCE(wait_head->acked)) {
    ...
			ret = wait_event_timeout(wait_head->wait_queue,
    ...
}

In that case the call would return -ETIMEDOUT even though the hardware
state had already changed.

No in-tree caller later in the series does this. nbl_dev_start(),
nbl_dev_enable_mailbox_irq(), nbl_dev_disable_mailbox_irq(),
nbl_dev_stop() and the err_destroy_map rollback in nbl_dev_start() all
follow the precondition. A check would only be defensive.

[ ... ]

> +static void nbl_disp_chan_destroy_msix_map_resp(void *priv, u16 src_id,
> +						u16 msg_id, void *data,
> +						u32 data_len)
> +{

[ ... ]

> +	if (res_ops->destroy_msix_map) {
> +		ret = res_ops->destroy_msix_map(p, src_id);

[Severity: Medium]
Can this let the device fetch a sibling PF's MSI-X map table after the
table has been freed?

This responder is the first way a sibling PF can trigger a runtime
teardown of its map on the control PF:

nbl_dev_destroy_msix_map()                        (sibling PF)
  -> NBL_CHAN_MSG_DESTROY_MSIX_MAP
    -> nbl_disp_chan_destroy_msix_map_resp()      (control PF)
      -> nbl_res_intr_destroy_msix_map()
        -> __nbl_res_intr_prepare_destroy_msix_map()   clears VALID
        -> nbl_intr_quiesce_wait()                     usleep_range()
        -> __nbl_res_intr_complete_destroy_msix_map()  dma_free_coherent()

The comment above nbl_intr_quiesce_wait() in nbl_interrupt.c says the
window "is not a guarantee", and continues:

 * A future caller that cannot tolerate the residual risk must keep the
 * table allocated for the lifetime of the function instead of relying on
 * this delay.
 ...
 * fetch inside this window.  It cannot help a sibling PF's map destroyed
 * at runtime, because those fetches carry the control PF's BDF and so
 * are unaffected by clearing bus mastering on the sibling.  Runtime
 * destroys of sibling maps only become reachable with the mailbox RPC
 * added later in this series.

This responder is that mailbox RPC, but the table is still freed right
after the roughly 1ms delay. The control PF stays bus master the whole
time. A pcompleter fetch that is still in flight would read freed or
reused memory. With an IOMMU that is a fault. Without one, the device
could use stale gvec routing and deliver an interrupt to the wrong
function.

nbl_disp_chan_cfg_msix_map_resp() has the same exposure when it reaches
the had_config path of nbl_res_intr_cfg_msix_map(). That path returns the
old global vectors to the shared pool via nbl_intr_release_bitmap() after
the same window.

Later in the series, the sibling frees its vectors with
pci_free_irq_vectors() (via nbl_dev_clear_interrupt_scheme()) before it
sends destroy_msix_map. That makes new fetches unlikely, but it still
gives no hardware completion guarantee.

Would it be safer to keep sibling map tables allocated for the lifetime
of the function, as the resource layer comment suggests?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> index b5a695164cbcd..7da9e242c621e 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h

[ ... ]

> @@ -32,16 +33,44 @@ enum {
>   *               mailbox DMA before calling it, see nbl_dev_remove().
>   *               Returns void.  Control-PF exclusive, same NULL rule as
>   *               @init_module.
> + * @cfg_msix_map: configure function msix mapping table
> + * @destroy_msix_map: tear down msix mapping resource
> + * @set_mailbox_irq: bind mailbox interrupt to specified msix vector

[Severity: Low]
The commit message says cfg_msix_map, destroy_msix_map and
set_mailbox_irq "carry a caller precondition": IRQ_RDY must be cleared
and the polling send path used. That rule is only written above the
static *_req functions in nbl_dispatch.c.

Should the precondition also go in this kernel-doc? Callers program
against struct nbl_dispatch_ops, and from there they cannot tell whether
an op will be a local call or an RPC.

> + * @get_vsi_id: resolve VSI ID by type
> + * @get_eth_id: resolve eth port info from VSI ID
>   *
>   * These callbacks are not dispatch-layer setup/teardown: the dispatch
> - * structures are devm-allocated in nbl_disp_init(), and nbl_disp_remove()
> - * only documents why no explicit teardown is needed. They forward
> - * chip/firmware control down to the layers below instead: a control-PF
> - * function calls the resource ops directly.
> + * structures are devm-allocated in nbl_disp_init(), so nbl_disp_remove()
> + * has nothing to undo. The five responders registered by
> + * nbl_disp_setup_msg() are owned by the channel layer and go away with
> + * it, so they need no explicit unregistration either; the teardown order
> + * that makes that safe is documented with the code that performs it, in
> + * the next patch in this series. They forward chip/firmware control down

[Severity: Low]
This isn't a bug, but won't "the next patch in this series" be
meaningless once this is merged?

At this commit, the code that performs the teardown is:

void nbl_core_remove(struct nbl_adapter *adapter)
{
	nbl_disp_remove(adapter);
	nbl_res_remove_leonis(adapter);
	nbl_chan_remove_common(adapter);
	nbl_hw_remove_leonis(adapter);
}

Neither this function nor the nbl_core_init() error unwind documents the
ordering. Nothing breaks at runtime yet, because setup_queue() has no
callers, so no responder can run.

Later, "net/nebula-matrix: add common/ctrl dev init/remove operation"
makes nbl_core_remove() call nbl_dev_remove() first. That tears down the
mailbox channel queue before the resource layer is removed.

Even so, this header comment is unchanged at the end of the series. The
"Teardown order" comment in nbl_dev_remove() also never mentions the
responders or handler_xa.

Could this comment name nbl_dev_remove() and state the invariant
directly, i.e. that the channel queue is torn down before the resource
layer is removed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106045631.2224-1-illusion.wang%40nebula-matrix.com
