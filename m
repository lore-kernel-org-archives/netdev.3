Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4127C44A40F;
	Sat, 26 Sep 2026 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431249; cv=none; b=rGmsVlY8+YNwQ9hfjb8RIujAW4MwukYietWnKOk4eEu19HaVmPcf2Fahenb8rJwTK94ME2sQhtHXpfWTV5mfz3xDSc6WOC4SKarzybQmO4rJnWHIbmJ0qjwbjm8LDUoclU901vdNfQI2WbzDSPyM82BmLxy/NpWK6YRf3zcfqxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431249; c=relaxed/simple;
	bh=fJNnmA0srwbU0i+wVKht+7ndG3HFGL7GyzybeLQqbjk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cyp5Ku6XMpSlLrLGpvGI4Cd0T4ebhinGrAfNgax1hl/QH6U6e5tVl+B+wSIBbaMhjpESPycV53dEVzgARA0Np673QOyerB2pZcJ/9Vt1xcE77y7B5EIxex1mwSXjFWDEBdKIxDkXuWP2PWKuR8Pp3CMu5/gTbjABmnSnrYm8G8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPq6+0gH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPq6+0gH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58111F0089D;
	Sat, 26 Sep 2026 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790431236;
	bh=dHWI2IBmBClY2UpHRSlgiQdrTuiKXJbfVW4rY7icnMs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EPq6+0gHnTMl+C0sJynu1TKCU3XlbGosSFFxLC5jr6r271hHIgAcj/Q6HTSdBBtvl
	 etqu7ubWQ4wjnN0fxK+xFLpPSL+xT0jJabXccgYX7YptkegjRnF0ddyqYBTsOZokp+
	 mHR796KwbdPRruQPy6ByLgCX4cy8F6830+IjYrv/sbyMXhcIpvKaGnQbA2L3BzulUR
	 KpYHRTMstbhdOB2R08RwJ7nsg9eMEKFpAsbzKoMrtCCd+FCqKYOtswuUkwdD802hqU
	 VNS4SUeW4V+FtB1UvXtqDQtXj4mog/y7jcoEuWV2qINMegaReN87ls1pGEufGJXpoo
	 58LiRRyuheRvQ==
Subject: Re: [PATCH v29 net-next 8/8] net/nebula-matrix: add common dev
 start/stop operation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 26 Sep 2026 14:00:35 +0000
Message-ID: <179043123539.2160803.12073720136764328000@kernel.org>
In-Reply-To: <20260922120311.86593-9-illusion.wang@nebula-matrix.com>
References: <20260922120311.86593-9-illusion.wang@nebula-matrix.com>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] nbl_dev_start() only translates -ETIMEDOUT into -EPROBE_DEFER
  for the get_vsi_id()/get_eth_id() RPCs, but the *first* mailbox RPC a…
- [Medium] nbl_dev_clear_interrupt_scheme() (nbl_dev.c:221-231) has an
  empty body, yet the two call sites assert that kernel-side MSI-X…
- [Low] Concern (validated as a false positive for the current code,
  retained for policy): nbl_dev_init_interrupt_scheme() (nbl_dev.c:206)…

--

net/nebula-matrix: add common dev start/stop operation

This adds nbl_dev_start() and nbl_dev_stop() to configure the hardware
MSI-X map, fetch VSI/ETH identity, allocate MSI-X vectors and set up the
mailbox interrupt, plus nbl_core_start()/nbl_core_stop() wrappers hooked
into the PCI probe and remove paths.

A few questions about the start/stop paths below.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> index 35410c6f1fb9c..e672478f61146 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c

[ ... ]

> @@ -18,6 +29,206 @@ static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)

[ ... ]

> +static int nbl_dev_init_interrupt_scheme(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
> +	struct nbl_msix_info *msix_info = &dev_common->msix_info;
> +	struct nbl_common_info *common = dev_mgt->common;
> +	int needed = 0;
> +	int err;
> +	int i;
> +
> +	for (i = 0; i < NBL_MSIX_TYPE_MAX; i++)
> +		needed += msix_info->serv_info[i].num;
> +
> +	err = pci_alloc_irq_vectors(common->pdev, needed, needed,
> +				    PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);

[Severity: Low]
This isn't a bug in this patch, but PCI_IRQ_AFFINITY makes the mailbox
vector an affinity-managed vector.

Today that is harmless: nbl_dev_init_msix_cnt() only sets
serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1, and with one group
__group_cpus_evenly() takes the

	if (numgrps <= nodes) {

branch, which ORs every node's CPUs into masks[0], so the vector's mask
covers all CPUs and can never lose its last online CPU.

Once net vectors are added and the spreading no longer degenerates, a
managed mailbox vector can be shut down by CPU offline while
NBL_CHAN_IRQ_RDY is still set, which would turn every mailbox RPC into a
timeout. Would it be worth excluding the administrative vector up front via
irq_affinity.pre_vectors?

> +	if (err < 0) {
> +		dev_err(common->dev,
> +			"pci_alloc_irq_vectors failed, err = %d\n", err);
> +		return err;
> +	}
> +	if (err != needed) {
> +		dev_err(common->dev, "pci_alloc_irq_vectors got %d vecs, need %d\n",
> +			err, needed);
> +		return -ENOSPC;
> +	}
> +	return 0;
> +}
> +
> +static void nbl_dev_clear_interrupt_scheme(struct nbl_dev_mgt *dev_mgt)
> +{
> +	/*
> +	 * pcim_enable_device() is used in nbl_probe().
> +	 * pci_alloc_irq_vectors() registers pcim_msi_release devres callback,
> +	 * which invokes pci_free_irq_vectors() automatically on device detach.
> +	 * Do NOT call pci_free_irq_vectors() explicitly here to avoid
> +	 * double-free.
> +	 */
> +}

[Severity: Medium]
nbl_dev_clear_interrupt_scheme() has an empty body, yet both call sites
state that the kernel-side vectors are released at that point. In the
err_destroy_map block of nbl_dev_start():

	 * Destroy device-side MSI-X map BEFORE releasing kernel-side
	 * vectors. This masks all hardware vectors and clears the
	 * pcompleter map entry, so no MSI-X message can fire after
	 * vector release.
	 ...
	 * This is best-effort teardown: we still release kernel vectors
	 * even if remote RPC fails.

and in nbl_dev_stop():

	 * This is best-effort teardown: if destroy_msix_map RPC fails,
	 * hardware MSI-X map remains valid. We proceed to release
	 * kernel vectors anyway.

Nothing is released here, so pdev->msix_enabled is still set when
nbl_dev_stop() returns, and the ordering invariant is only established later
by pcim_msi_release() at device detach. Could these comments be reworded to
say that the vectors deliberately stay allocated until detach?

Related to that, nbl_core_start()/nbl_core_stop() are exported in nbl_core.h
as a pair, but the pair is not repeatable: a second nbl_dev_start() calls
pci_alloc_irq_vectors() again on a device that still has MSI-X enabled, and
__pci_enable_msix_range() starts with

	if (WARN_ON_ONCE(dev->msix_enabled))
		return -EINVAL;

Is only probe/remove ever expected to call these?

[ ... ]

> @@ -257,3 +476,126 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
>  	if (common->has_ctrl)
>  		nbl_dev_remove_ctrl_dev(adapter);
>  }
> +
> +/* ----------  Dev start process  ---------- */
> +int nbl_dev_start(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> +	struct nbl_dispatch_mgt *priv = dev_mgt->disp_ops_tbl->priv;
> +	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
> +	struct nbl_common_info *common = dev_mgt->common;
> +	int cleanup_ret;
> +	int ret;
> +
> +	ret = nbl_dev_cfg_msix_map(dev_mgt);
> +	if (ret)
> +		goto err_destroy_map;

[Severity: High]
The commit message says:

    For non-control PF, if mailbox RPC times out because control
    PF is not ready yet, return -EPROBE_DEFER to trigger deferred
    probing, so kernel will retry later once PF0 comes up.

Does that cover the first RPC? On a non-control PF, nbl_dev_cfg_msix_map()
is already a cross-PF mailbox call: disp_ops->cfg_msix_map is
nbl_disp_chan_cfg_msix_map_req(), which sends an ack-requested message to
common->mgt_pf:

	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
	if (ret)
		return ret;

NBL_CHAN_IRQ_RDY has not been set yet at this point, so nbl_chan_send_msg()
takes the polling path and, if nobody answers, returns after
NBL_CHAN_TX_WAIT_ACK_TIMES(5000) x ~1ms:

		dev_err_ratelimited(dev,
				    "Channel polling ack failed, message type: %d msg id: %u\n",
				    chan_send->msg_type, msgid);
		ret = -ETIMEDOUT;

That -ETIMEDOUT reaches err_destroy_map unchanged, so nbl_probe() returns
-ETIMEDOUT and the driver core treats it as a hard probe failure with no
retry once PF0 binds. The -EPROBE_DEFER conversion below is unreachable in
exactly the case the commit message describes. Should the conversion be
applied to nbl_dev_cfg_msix_map() as well, and to set_mailbox_irq() in
nbl_dev_enable_mailbox_irq(), which returns an untranslated timeout too?

Is nbl_probe_chip_deps() sufficient to order this? device_link_add() is
called from the consumer's own probe, and an unbound func 0 gives a DORMANT
link, so this probe attempt still continues into nbl_dev_start().

One more effect of the same path: err_destroy_map issues another
ack-requested RPC (destroy_msix_map) to the same unresponsive control PF, so
the failing probe spends a second ~5 s polling timeout and logs
"rollback: destroy MSI-X map failed".

> +
> +	/* Fetch VSI/ETH identity after cfg_msix_map */
> +	ret = disp_ops->get_vsi_id(priv, NBL_VSI_DATA, &common->vsi_id);
> +	if (ret) {
> +		if (!common->has_ctrl && ret == -ETIMEDOUT)
> +			ret = -EPROBE_DEFER;
> +		goto err_destroy_map;
> +	}
> +	ret = disp_ops->get_eth_id(priv, common->vsi_id, &common->eth_num,
> +				   &common->eth_id, &common->logic_eth_id);
> +	if (ret) {
> +		if (!common->has_ctrl && ret == -ETIMEDOUT)
> +			ret = -EPROBE_DEFER;
> +		goto err_destroy_map;
> +	}
> +
> +	ret = nbl_dev_init_interrupt_scheme(dev_mgt);
> +	if (ret)
> +		goto err_destroy_map;
> +
> +	ret = nbl_dev_request_mailbox_irq(dev_mgt);
> +	if (ret)
> +		goto err_destroy_map;
> +
> +	ret = nbl_dev_enable_mailbox_irq(dev_mgt);
> +	if (ret)
> +		goto err_disable_irq;
> +
> +	return 0;

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index d362f1270d83e..170a4d13494b7 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

[ ... ]

> @@ -181,7 +191,13 @@ static int nbl_probe(struct pci_dev *pdev,
>  		goto adapter_init_err;
>  	}
>  	pci_set_drvdata(pdev, adapter);
> +	err = nbl_core_start(adapter);
> +	if (err)
> +		goto core_start_err;
> +
>  	return 0;
> +core_start_err:
> +	nbl_core_remove(adapter);
>  adapter_init_err:
>  chip_deps_err:
>  	pci_clear_master(pdev);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922120311.86593-2-illusion.wang%40nebula-matrix.com
