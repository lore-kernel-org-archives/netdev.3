Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6828E361979;
	Fri,  2 Oct 2026 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790912127; cv=none; b=UPPgg2mt5OZRa3qejiijAkEC9z8MUcjdy2uPXDuZuxp3UxaRmQPZhVjMTV1ae1xhY+TeeTJY+3DgK3/ZF8dzFWHakCqUY9byFn7EP2NGa98JVbaP6geNJjod44KFDCfw0PuzKUWgF6QZPrCVxuKRtrymRowA7KPCtMbA1GlZt/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790912127; c=relaxed/simple;
	bh=ZUgSO/KwU8KvPl34DvSBxIzdnxXirh2lS0IcZ9ffA8o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R5zNn19NNLXli02W84UtoqyQYvxv9DdrsYyWEg9ukvRPBxYTS4JA5z7VY7RcRnNG4nX5hQGWpXmmacvw9+UWQXy57FtF/rzbBgAmesJHwBr2G4bGQaiKrJvvCB/8AX0T8LQXHTD1bOSpgydYIHlzlSfBz0scalWhIA7j28mGsiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+Co6Ndh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+Co6Ndh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90491F00893;
	Fri,  2 Oct 2026 03:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790912121;
	bh=DKxwCtwEMckAvcGWTCZ8VKNJ0zAVEqVNhn2MRyho99E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K+Co6NdhZypfkGS6JpCUQrszjIKPXqKPqBHkP/Inowk4ommpqAVgeSAp+UlmWEC6B
	 RYVBuzWr+Vvro7qXcQvZNPrQ3DCzJ7hA7762KLtJHljvK7SkBshcnzvVbgyumV58lC
	 G7pNv17+fOOojVAcAMSuA3SYS8mNUh1LJelKRBNg5wFl/cLvwsHRK3t8LjM8FxiHYs
	 d2YFpTi5/aktl8PCE3GEAD9WJ1Yq9Bc8WgiXh77Q1x14B12uB+2FPyAdMn1mwf12+Z
	 H6bzvjzqEo6VICU7+ChavxZKE8cc4bVoqaewjjAd95hvMfteRgxdK6VLdj0yPsa6cS
	 3wfKeUuzrFwfQ==
Subject: Re: [PATCH v30 net-next 8/8] net/nebula-matrix: add common dev
 start/stop operation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 03:35:20 +0000
Message-ID: <179091212046.434549.16882401439925001221@kernel.org>
In-Reply-To: <20260928123237.88994-9-illusion.wang@nebula-matrix.com>
References: <20260928123237.88994-9-illusion.wang@nebula-matrix.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] nbl_dev_rpc_timeout() in drivers/net/ethernet/nebula-
  matrix/nbl/nbl_core/nbl_dev.c (lines 85-90) turns every -ETIMEDOUT…
- [Medium] In nbl_dev_start() (nbl_dev.c:513-516), map_ready is set only
  after cfg_msix_map returns success.
- [Low] The commit message says teardown is best-effort 'with
  pci_clear_master() serving as the final safety net' when the MSI-X…
- [Low] Two problems here.
- [Low] The commit message says clearing NBL_CHAN_IRQ_RDY before masking
  the hardware interrupt is done 'preventing in-flight ACK discard and…

--

net/nebula-matrix: add common dev start/stop operation

This patch adds nbl_dev_start() and nbl_dev_stop(). Start configures the
device MSI-X map, fetches the VSI/ETH ids, allocates MSI-X vectors and sets
up the mailbox interrupt; stop does the matching teardown. Startup RPC
timeouts on non-control PFs become -EPROBE_DEFER, and both functions are
called from nbl_probe()/nbl_remove() through nbl_core_start()/nbl_core_stop().

> Teardown is best-effort: failed MSI-X destroy RPC leaves stale hardware
> entries which are reclaimed by firmware on chip reset, with
> pci_clear_master() serving as the final safety net. The start/stop
> pair is single-shot and non-repeatable, tied strictly to PCI probe/remove
> device lifecycle.

[Severity: Low]
Is the pci_clear_master() safety net claim accurate for non-control PFs?
The comments this patch adds in nbl_dev_start() and nbl_dev_stop() say the
opposite:

 * pci_clear_master() on a non-control PF cannot stop DMA using the
 * management PF's BDF.

nbl_res_intr_cfg_msix_map() programs the PCOMPLETER map with the control
PF's common->hw_bus/devid/function. If destroy_msix_map fails, clearing bus
mastering on the departing PF would not stop those map-table fetches.

Could the commit message be changed to match the code comments?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> index e094b97acdfb..79c62c169d70 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c

[ ... ]

> @@ -18,6 +29,233 @@ static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)

[ ... ]

> +/*
> + * Translate a mailbox RPC timeout on a non-control PF into deferred
> + * probing: the management PF/firmware is not responsive yet and the
> + * driver core should retry once PF0 is ready. Other errors, and all
> + * errors on the control PF itself, pass through unchanged.
> + */
> +static int nbl_dev_rpc_timeout(struct nbl_common_info *common, int ret)
> +{
> +	if (!common->has_ctrl && ret == -ETIMEDOUT)
> +		return -EPROBE_DEFER;
> +	return ret;
> +}

[Severity: Medium]
Can the "management PF/firmware is not responsive yet" case still happen
when these RPCs are sent? nbl_probe() calls nbl_probe_chip_deps() before
nbl_core_init()/nbl_core_start(), and that function already defers until
func 0 is bound:

nbl_probe_chip_deps() {
    ...
	if (READ_ONCE(mgt->dev.links.status) != DL_DEV_DRIVER_BOUND) {
		pci_dev_put(mgt);
		return -EPROBE_DEFER;
	}
    ...
}

DL_DEV_DRIVER_BOUND is set only after PF0's nbl_probe() returns 0. With
this patch, that probe includes PF0's own nbl_core_start() (cfg_msix_map,
request_irq and set_mailbox_irq(true)). The managed device link also stops
PF0 from unbinding while a consumer is probing.

So on a sibling PF, a -ETIMEDOUT from cfg_msix_map, get_vsi_id, get_eth_id
or set_mailbox_irq(true) comes after a 5-6 second polling wait. That looks
like a real failure, not PF0 still starting up.

Will returning -EPROBE_DEFER here actually cause a retry? really_probe()
only reports the deferral with dev_dbg(). Deferred devices are retried from
driver_bound()->driver_deferred_probe_trigger() when some other device
binds, and PF0's bind trigger has already fired by this point.

If nothing else binds later (the last sibling PF, or a module loaded after
boot), could the PF stay unbound with no probe failure printed at the
default log level? If other devices do bind, does each retry pay another
multi-second timeout for every startup RPC?

If this changes, the commit message wording "to trigger deferred probing
when the control PF is not ready" would need updating too.

[ ... ]

> +static int nbl_dev_disable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
> +{

[ ... ]

> +	/*
> +	 * Disable sequence invariant: update software state first, then mask
> +	 * hardware interrupt. Must not reverse the order.
> +	 *
> +	 * If hardware interrupt is masked before clearing INTERRUPT_READY,
> +	 * the hardware may still transmit outstanding ACK packets for in-flight
> +	 * messages. Subsequent switch to polling mode discards pending ACK
> +	 * processing, triggering "Channel waiting ack failed" and "Skip ack
> +	 * with invalid status" errors.
> +	 *
> +	 * By entering polling mode first, any late hardware interrupts are
> +	 * ignored without pending ACK expectations, then hardware interrupt
> +	 * can be safely disabled.
> +	 *

[ ... ]

> +	 */
> +	chan_ops->set_queue_state(dev_mgt->chan_ops_tbl->priv,
> +				  NBL_CHAN_IRQ_RDY,
> +				  NBL_CHAN_TYPE_MAILBOX, false);
> +
> +	return disp_ops->set_mailbox_irq(dev_mgt->disp_ops_tbl->priv,
> +					 lvec, false);
> +}

[Severity: Low]
Does clearing NBL_CHAN_IRQ_RDY first actually keep in-flight ACKs? When
IRQ_RDY is cleared, nbl_chan_set_queue_state() wakes every waiter:

nbl_chan_set_queue_state() {
    ...
	if (!set && state == NBL_CHAN_IRQ_RDY) {
		for (i = 0; i < chan_info->num_txq_entries; i++)
			wake_up_all(&chan_info->wait[i].wait_queue);
	}
}

An interrupt-mode waiter in nbl_chan_send_msg() then gives up:

			if (!test_bit(NBL_CHAN_IRQ_RDY, chan_info->state)) {
				ret = -EIO;
				goto out_clear_wait_slot;
			}

The slot goes back to IDLE. When the peer's ACK arrives later,
nbl_chan_recv_ack_msg() sees w_status != NBL_MBX_STATUS_WAITING, logs
"Skip ack invalid status" and drops it. The comment says this ordering
prevents exactly that; the only difference is that the sender gets -EIO
instead of -ETIMEDOUT.

In this patch every ACK-requesting sender runs from probe/remove, and the
clean task only sends replies without ACKs, so nothing hits this today.

Should the comment and the commit message ("preventing in-flight ACK
discard and "Channel waiting ack failed" errors", "to preserve ACK
integrity") be corrected before later patches rely on this invariant?
Only draining in-flight waiters before clearing IRQ_RDY would provide that
guarantee.

[ ... ]

> @@ -251,3 +497,129 @@ void nbl_dev_remove(struct nbl_adapter *adapter)

[ ... ]

> +/* ----------  Dev start process  ---------- */
> +int nbl_dev_start(struct nbl_adapter *adapter)
> +{

[ ... ]

> +	ret = nbl_dev_rpc_timeout(common, nbl_dev_cfg_msix_map(dev_mgt));
> +	if (ret)
> +		goto err_destroy_map;
> +	map_ready = true;

[ ... ]

> +	ret = nbl_dev_enable_mailbox_irq(dev_mgt);
> +	if (ret)
> +		goto err_disable_irq;
> +
> +	return 0;
> +
> +err_disable_irq:
> +	cleanup_ret = nbl_dev_disable_mailbox_irq(dev_mgt);
> +	if (cleanup_ret)
> +		dev_err(dev_mgt->common->dev,
> +			"rollback: disable mailbox IRQ failed: %d\n",
> +			cleanup_ret);
> +	nbl_dev_free_mailbox_irq(dev_mgt);

[Severity: Low]
Is the set_mailbox_irq(false) RPC needed on this rollback path? If
nbl_dev_enable_mailbox_irq() failed, NBL_CHAN_IRQ_RDY was never set, yet
nbl_dev_disable_mailbox_irq() still sends a polling-mode RPC that requests
an ACK.

Control then falls through to err_destroy_map. On the control PF, the
destroy path already turns off mailbox routing:

__nbl_res_intr_prepare_destroy_msix_map() {
    ...
	/* Step 0: disable mailbox IRQ routing before tearing down map */
	ret = __nbl_res_intr_set_mailbox_irq(res_mgt, func, 0, false);
    ...
}

With an unresponsive peer, this adds another polling timeout of about 5-6
seconds, and every deferred retry repeats it. That works against the stated
goal of removing unnecessary polling timeouts during probe rollback.

Separately, some commit message wording seems to describe changes from an
earlier revision:

  "Skip redundant MSI-X map destroy RPC on unconfigured state during probe
  rollback to eliminate unnecessary polling timeouts. Adjust interrupt
  teardown ordering to ..."

This patch introduces nbl_dev_start()/nbl_dev_stop(), so should these
version notes go below the --- line instead?

> +err_destroy_map:
> +	/*
> +	 * Destroy the device-side MSI-X map only when it was configured.
> +	 * On a cfg RPC failure there is no known-good remote map; when
> +	 * the failure is a timeout against an unready/unresponsive
> +	 * management PF, issuing the destroy RPC would just burn another
> +	 * multi-second ACK timeout. Partial remote state is best-effort
> +	 * and reclaimed by firmware on chip reset.

[ ... ]

> +	 */
> +	if (map_ready) {
> +		cleanup_ret = nbl_dev_destroy_msix_map(dev_mgt);

[Severity: Medium]
If cfg_msix_map times out, can skipping destroy here leave control-PF
resources held for a function that has no driver? A -ETIMEDOUT from the
polling send only means the ACK did not arrive in time.
nbl_chan_send_msg() explicitly handles ACKs that arrive after the sender
has timed out, and the request may still be in the control PF's RX ring.

On the control PF, nbl_disp_chan_cfg_msix_map_resp()->
nbl_res_intr_cfg_msix_map() finishes all of its work before it sends the
ACK:

- kcalloc() for the interrupts array
- dma_alloc_coherent() for the map table
- set_bit() in intr_net_bmap/intr_other_bmap
- setting the PCOMPLETER map to VALID

and finally:

	intr_mgt->func_intr_res[func_id].state = NBL_INTR_FUNC_CONFIGURED;

With map_ready false, the sibling returns -EPROBE_DEFER without sending
destroy. The resources are then freed only when the same PF later
re-probes successfully (the had_config path) or when the control PF
unbinds (nbl_res_remove_leonis()->nbl_intr_mgt_stop()). A re-probe after
deferral is not guaranteed.

The comment "Partial remote state is best-effort and reclaimed by firmware
on chip reset" also looks inaccurate, as does the similar comment in
nbl_dev_stop(). This is host memory and bitmap state owned by the control
PF driver, and nothing requests a chip reset.

Would it be safer to always send destroy after a cfg timeout?
__nbl_res_intr_prepare_destroy_msix_map() returns 0 when the function is
not NBL_INTR_FUNC_CONFIGURED, so it looks harmless in the unconfigured
case.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928123237.88994-1-illusion.wang%40nebula-matrix.com
