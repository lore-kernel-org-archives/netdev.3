Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792920270;
	b=PaTY+d+HFpexLTDo65PVs8vCEo25/b+BesZ5cysEl+Q6On/9U8cMerNBHswsqWL8JKwg
	 e7CPF7BDwi8Q5ubYZsSBgxfxhb4hMiLp4HWSWsE927sL4jirt4TlerDHUFTTQXIYSNSym
	 078ScC3MPuB0+OkHnOhec3ao8U4ZIsEGhXEwZck0BG4d+nSgzAKgUFifJGDVrg8Zp4l6U
	 PFSMhhd4GVAO7fgLQVw2rnE1m9YRzvScvDzHrU+aK0xtngOrPP8bVyBsli/dYzyqtFvHN
	 Op0Km1J62586oN5e52hjrw8v4fkDjukcfpSShxkBhJRd5K2I2cv5JIXAY3b4OrgDeUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792920270;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Esv2wW8UYNqWRE8a3dqXmd0C0FksG0AdEfP0t2fsL6s=;
	b=5g62UJBVtbv85OdMAKndxjp1n53EdJDOE8G8hQuHiiNpmu31xp3N/MDuOBJleS3GNR22
	 HEOMd3VeKC4qGuf2sSEJt0kwvwqnYK2djs9KVDxekVy5KhNuHO6OwZ7o+QwPgjAKyuLAR
	 zpwVyDccefZrho1S1BCPVaRSiDa36nW9KM0dstkIYndZujp/O5WgLVnjr47pgFiBnLAKv
	 IxDHffgB5iZFjaFgj1Qt3vy9RtKillQTkFdX3RV8r45NQOPOzU30pCoQ3f/1vsx1D3G2V
	 1SE3wxTXOPTDF6fimZrrEupDX93WDalkDMTFNBetf0WX2jO2RPB1Sv68JSA7l0PNeqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g77XnNQt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D98760A2602;
	Sun, 25 Oct 2026 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g77XnNQt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4E21F031E3;
	Sun, 25 Oct 2026 09:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792920270;
	bh=Esv2wW8UYNqWRE8a3dqXmd0C0FksG0AdEfP0t2fsL6s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g77XnNQto8MCsJfTalil8Y0wdMi4baRc9LPM8AI7E+1ytlAx51mf/BoCLgtKUZfHA
	 b4HOiXRAnnMjnhEpRDha8FAIymoCarS0gtc5auLT7hpXG4lvjtt9LJt5afiPDf/B6X
	 YIe///N3qEkQpmqYoCvrt/beOMo+WcX1r4CA2gKuYDGroOmicB+Oe8hofoMB5D29xP
	 ENakuuCi8qUZC9P4trD99uVP4HEVA6WLatwfAqhYPWVe+o46St7lbALZRir68j3lEu
	 MA8EQHyV81eqH4rUUCRd1DnFjVYmCUZaakRmTkgH969H4LLIP6Ujl9Pn/EdI7YwRqR
	 wDeWwbutvGdEg==
Subject: Re: [PATCH v32 net-next 8/8] net/nebula-matrix: add common dev
 start/stop operation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 andrew+netdev@lunn.ch, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 09:24:29 +0000
Message-ID: <179292026913.3134.14520526365813127623@kernel.org>
In-Reply-To: <20261021062113.2158-9-illusion.wang@nebula-matrix.com>
References: <20261021062113.2158-9-illusion.wang@nebula-matrix.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] nbl_dev_stop() calls nbl_dev_destroy_msix_map()
  (nbl_dev.c:673) to tear down the per-function pcompleter…
- [Low] Commit message omits a user-visible change in nbl_probe().
- [Low] The comment in nbl_dev_start() (drivers/net/ethernet/nebula-
  matrix/nbl/nbl_core/nbl_dev.c, around lines 550-560) says the control…
- [Low] The best-effort comment in nbl_dev_stop()
  (drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c:661-668)…

--

net/nebula-matrix: add common dev start/stop operation

This patch adds nbl_dev_start() and nbl_dev_stop(), called from
nbl_probe() and nbl_remove() through nbl_core_start() and nbl_core_stop().
Start configures the MSI-X map, fetches the VSI/ETH ids, allocates the
MSI-X vectors and arms the mailbox interrupt. Stop tears these down on a
best-effort basis.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> index cbb0b06b80117..356a23ee72959 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c

[ ... ]

> @@ -293,3 +534,153 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
>  	if (common->has_ctrl)
>  		nbl_dev_remove_ctrl_dev(adapter);
>  }
> +
> +/* ----------  Dev start process  ---------- */
> +int nbl_dev_start(struct nbl_adapter *adapter)
> +{

[ ... ]

> +	/*
> +	 * Startup RPC failures are reported as they are, including the
> +	 * -ETIMEDOUT of a 5-6s polling wait against an unresponsive peer.
> +	 * nbl_probe() already deferred this PF until the control PF had
> +	 * completed probing (nbl_probe_chip_deps()), and that completion
> +	 * includes the control PF's own nbl_core_start(); its mailbox
> +	 * responder has been live since nbl_dev_init().  A timeout here

[Severity: Low]

Is the part saying the responder "has been live since nbl_dev_init()"
accurate? The commit message makes the same claim:

  "and that completion includes the control PF's own start, whose
  mailbox responder has been live since nbl_dev_init()."

On the control PF, received mailbox messages are only processed by
clean_mbx_task. That work item gets queued from three places:

  nbl_dev_clean_mailbox() -> nbl_dev_clean_mailbox_schedule()
      the hardirq handler, registered by nbl_dev_request_mailbox_irq()
      inside nbl_dev_start()

  nbl_chan_clean_queue_subtask()
      a self-requeue, which only runs if the task is already running

  nbl_chan_send_msg()
      the polling send path, which only runs when this function sends
      an ACK-requested RPC itself

The control PF uses the local management dispatch ops, so it never sends
through nbl_chan_send_msg() here. Mailbox routing is first armed by
set_mailbox_irq(true) in nbl_dev_enable_mailbox_irq(), and that is the
last step of nbl_dev_start().

So doesn't the responder only become live at the end of nbl_dev_start(),
and not at nbl_dev_init()?

Keeping -ETIMEDOUT instead of -EPROBE_DEFER still looks right. The reason
is that nbl_probe_chip_deps() waits for func 0 to reach
DL_DEV_DRIVER_BOUND, which only happens after its whole probe, including
nbl_core_start(), has returned. Could the comment and the commit message
give that reason instead?

If the dependency were later relaxed to "func 0 finished nbl_dev_init()"
because of the current wording, sibling RPCs would hit the multi-second
polling timeout.

[ ... ]

> +void nbl_dev_stop(struct nbl_adapter *adapter)
> +{

[ ... ]

> +	/*
> +	 * Destroy the hardware MSI-X map now, before the kernel vectors
> +	 * are released at device detach (they deliberately stay
> +	 * allocated until then - see nbl_dev_clear_interrupt_scheme).
> +	 * Masks all device vectors and clears the pcompleter map entry.
> +	 *
> +	 * Best-effort: if the destroy RPC fails, the control PF still owns
> +	 * this function's map entry, its intr_net/other_bmap bits and its
> +	 * coherent map table.  Those are host resources of that driver,
> +	 * released either by a later successful configuration of this
> +	 * function (reconfiguration recycles them) or by
> +	 * nbl_intr_mgt_stop() when the control PF is removed; nothing else
> +	 * collects them, so the hardware entry stays as it is until chip
> +	 * reset - and nothing requests one.

[Severity: Low]

This isn't a bug, but does "the hardware entry stays as it is until chip
reset" match the code? Both recovery paths named just above it rewrite
the hardware entry without a chip reset.

nbl_intr_mgt_stop() walks every NBL_INTR_FUNC_CONFIGURED function and
calls __nbl_res_intr_prepare_destroy_msix_map(). That disables mailbox
routing, invalidates the MSI-X info entries and clears the
FUNCTION_MSIX_MAP valid bit:

    hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func,
                         false, func_res->msix_map_table.dma,
                         0, 0, 0);

__nbl_res_intr_complete_destroy_msix_map() then zeroes the DMA address.

A later nbl_res_intr_cfg_msix_map() for the same function also
invalidates and rewrites the entry on its had_config path.

> +	 *
> +	 * pci_clear_master() on a non-control PF cannot stop DMA using the
> +	 * management PF's BDF.
> +	 */
> +	ret = nbl_dev_destroy_msix_map(dev_mgt);
> +	if (ret)
> +		dev_err(dev_mgt->common->dev,
> +			"Failed to destroy MSI-X map: %d\n", ret);
> +
> +	nbl_dev_clear_interrupt_scheme(dev_mgt);

[Severity: Medium]

Is it safe to leave the PCI core's MSI-X shutdown until after the
pcompleter FUNCTION_MSIX_MAP has been destroyed here?

nbl_dev_clear_interrupt_scheme() is empty, so the pcim_msi_release devres
releases the vectors later, at detach:

pcim_msi_release()
  pci_free_irq_vectors()
    pci_disable_msix()
      pci_msix_shutdown()
        pci_msix_mask()      for every descriptor

pci_msix_mask() writes the vector control word in the MSI-X table and
then does readl(desc->pci.mask_base) to flush the write. Those MMIO
writes and non-posted reads reach the function after destroy_msix_map has
cleared the valid bit, invalidated the info entries and freed the map
table. How the device responds to them depends on the hardware.

nbl_dev_start() uses the opposite order: cfg_msix_map runs before
pci_alloc_irq_vectors_affinity().

The rollback in nbl_dev_start() has the same order as stop. That path
runs when nbl_dev_init_interrupt_scheme() succeeded and then
nbl_dev_request_mailbox_irq() or nbl_dev_enable_mailbox_irq() failed.

The comment above nbl_dev_clear_interrupt_scheme() says that freeing the
vectors here "would double-free that callback". Is that the case?
pcim_msi_release() only calls pci_free_irq_vectors(), and
pci_disable_msix() returns early once MSI-X is already disabled:

    if (!pci_msi_enabled() || !dev || !dev->msix_enabled)
        return;

Would calling pci_free_irq_vectors() before nbl_dev_destroy_msix_map(),
in nbl_dev_stop() and in the nbl_dev_start() rollback, let the PCI core
finish its table accesses while the mapping is still valid?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index 7598ebac91e3d..84152cf683947 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

[ ... ]

> @@ -235,6 +245,21 @@ static int nbl_probe(struct pci_dev *pdev,
>  	int err;
>  
>  	nbl_get_func_param(pdev, id->driver_data, &param);
> +	/*
> +	 * Reject a function with neither capability before touching any
> +	 * hardware.  nbl_disp_refresh_ctrl_ops() leaves every dispatch op NULL
> +	 * for such a function, while nbl_dev_start() reaches cfg_msix_map,
> +	 * get_vsi_id, get_eth_id and (on unwind) destroy_msix_map through
> +	 * those pointers.  The state is reachable through driver_override:
> +	 * binding this driver to a function that is not in nbl_id_table (a VF,
> +	 * or a non-func-0 PF) makes pci_match_device() pass the dummy ID whose
> +	 * driver_data 0 leaves has_ctrl and has_net both clear.
> +	 */
> +	if (!param.caps.has_ctrl && !param.caps.has_net) {
> +		dev_err(dev, "Function has neither ctrl nor net capability\n");
> +		return -EOPNOTSUPP;
> +	}

[Severity: Low]

This isn't a bug, but should the commit message mention this new
rejection?

Before this patch, a driver_override bind to a function with driver_data
0 (a VF, or a non-func-0 device) completed probe. Now it fails with
-EOPNOTSUPP.

The check itself looks necessary. nbl_disp_refresh_ctrl_ops() leaves
every op NULL in that case, and nbl_dev_start() calls
disp_ops->cfg_msix_map unconditionally.

The commit message also leaves out the label renames in nbl_dev_init(),
where setup_ctrl_dev_fail and setup_err become out_remove_common_dev.

One small note on the comment: it lists only "a VF, or a non-func-0 PF".
A foreign device at func 0 still gets has_ctrl = 1 from
nbl_get_func_param(), passes this check and runs nbl_core_init() with the
local control ops. This patch doesn't change that behaviour.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021062113.2158-1-illusion.wang%40nebula-matrix.com
