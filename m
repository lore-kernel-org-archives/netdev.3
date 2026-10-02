Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A1360EC9;
	Fri,  2 Oct 2026 03:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790912121; cv=none; b=aq0zQpLWele35x9vfhYgE1nDXtu0NScaDnBbWYEs02CfYA46AM1xAeE8QFLnZzt39gvaujjOH5JTEetXgw7zLwdAh7LjwuvVenf2Wa0vuliYiBFo/kvLqfpa4pwXGAx+W9kZPLIEBFbBHfFRxjRrJsEyzd+U1gDQBAwmLHazfno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790912121; c=relaxed/simple;
	bh=kQxEPa5E07gqsb1mmi3Jm2st33+zyWCpmb40UhuMGno=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CD+O3dyg2zKoCUlYp/eUsIFIZuEfZAOYLywtTkDBk1pC//ZZhhcbIQXweq3MOuS/GIb166ky7xK25nChgs/Y0GB9aZqgbp/Qf2dbkbeXsndoCJdNvW6IZCkcsEl6B6/MrLH75LfPbq1lxEq9/IWY+Ljn+HRjg2JGIgG8OmgCEmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeLJs+bd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeLJs+bd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B716B1F000FF;
	Fri,  2 Oct 2026 03:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790912120;
	bh=Nnx5VwBBVGIAap/fKt1dWv7S2bkE64d1PQfmyTpSLk8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GeLJs+bdP20AwUFouDiNbwWgfh2fFHEhYYbrsl3YLkno9PBMPENauf3yv3DXRLq/D
	 SWlXTsY1AH5qZKul5KCei6I6FQ9T/wPYIV1TILntbXnQjBLK+blmx9617TkNg3zQol
	 kp6Xv1I1bI2j9onN2k+2UxgqFsMcqk29BYoqOoYaFRNVo2dtrBvjjGf9pfP288jsOp
	 eRty86wM4kJ5SlY8jC622oYoLXtaEkf3LzFBWeEknSZQ67+K73kGCBnWrlZMWAAcEI
	 ZCrk2enxxuEm7VsdyX2bIVrqnkvG7DAH/PBPlaJLuWtnjZEWWHAkIrL63oebM+X+V5
	 /8jFb/1frQ0Nw==
Subject: Re: [PATCH v30 net-next 7/8] net/nebula-matrix: add common/ctrl dev
 init/remove operation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 03:35:19 +0000
Message-ID: <179091211925.434549.7123730162166302836@kernel.org>
In-Reply-To: <20260928123237.88994-8-illusion.wang@nebula-matrix.com>
References: <20260928123237.88994-8-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The control-PF teardown and init added here rely on
  nbl_probe_chip_deps() to guarantee that no sibling PF probes unless…
- [Low] The commit message says 'The firmware handles global hardware
  cleanup and QINFO routing state reclamation asynchronously after…
- [Low] The new callers disagree with how nbl_chan_teardown_queue()
  actually behaves.
- [Low] Two comments on the same control-PF remove sequence contradict
  each other.

--

net/nebula-matrix: add common/ctrl dev init/remove operation

This commit adds nbl_dev.c with nbl_dev_init() and nbl_dev_remove(). They
set up the mailbox channel queue and cleanup work, program mailbox QINFO
routing on the control PF, and call chip-level init_module/deinit_module.
Teardown destroys the mailbox queue before notifying firmware through
deinit_module.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> new file mode 100644
> index 000000000000..e094b97acdfb
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> @@ -0,0 +1,253 @@

[ ... ]

> +/* ----------  Dev init process  ---------- */
> +static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter)
> +{

[ ... ]

> +	ret = nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +	if (ret)
> +		goto err_cleanup;

[ ... ]

> +	return 0;
> +err_cleanup:
> +	cancel_work_sync(&common_dev->clean_mbx_task);
> +	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
> +	return ret;
> +}
> +
> +static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
> +	int ret;
> +
> +	if (!common_dev)
> +		return;
> +	cancel_work_sync(&common_dev->clean_mbx_task);
> +	ret = nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +	if (ret)
> +		dev_warn(&adapter->pdev->dev, "mailbox queue teardown failed, inflight DMA may exist: %d\n",
> +			 ret);

[Severity: Low]
Can nbl_dev_remove_chan_queue() return non-zero here? Both exits of
nbl_chan_teardown_queue() return 0: the early return when the channel is
not active, and the normal path after draining. That makes this dev_warn()
unreachable.

The message also suggests teardown can fail with DMA still in flight. If
it could, nbl_dev_remove() would still go on to call deinit_module, and
nbl_hw_deinit_module() assumes no mailbox DMA is left at that point. Does
this warning cover a real failure mode, or can it be dropped?

There is a related issue on the err_cleanup path of
nbl_dev_setup_common_dev() above. That path only runs when setup_queue
failed, and chan_info->active is only set to true when setup succeeds. So
the teardown lands here:

nbl_chan_teardown_queue() {
	if (!READ_ONCE(chan_info->active)) {
		dev_warn(chan_mgt->common->dev, "channel not active, skip duplicate teardown\n");
		return 0;
	}
	...
}

Won't this log "skip duplicate teardown" on the first cleanup after a
failed setup, when no duplicate teardown has happened?

[ ... ]

> +/*
> + * Tear down control device: deinit_module sets driver_status=false
> + * to notify firmware to clean all per-PF hardware state (including
> + * qinfo registers).  The qinfo map programmed in nbl_dev_init() via
> + * nbl_dev_setup_chan_qinfo() is not explicitly cleared; firmware
> + * handles it on driver_status change.
> + *
> + * Teardown ordering guarantee: every non-management PF creates a
> + * consumer->control PF device link in its probe path, so the driver
> + * core always unbinds all siblings before allowing the control PF to
> + * be detached (sysfs unbind, driver unregister and hot-unplug alike).

[Severity: Low]
This comment conflicts with the one in nbl_res_remove_leonis(), which
nbl_core_remove() calls right after nbl_dev_remove():

nbl_res_remove_leonis() {
	...
	/*
	 * Tear down all MSI-X maps before destroying coherent tables.
	 * This is critical on the control PF, which may hold
	 * maps for remote PFs that are still bound.
	 */
	...
}

If the driver core always unbinds all siblings before the control PF, no
remote PF can still be bound at that point. Which of these does the
teardown actually rely on? One of the two comments probably needs
updating.

This patch relies on the stronger claim to justify calling deinit_module
unconditionally. The next comment describes a case where it does not
fully hold.

> + * nbl_probe_chip_deps() defers a sibling's probe until the control PF
> + * is fully bound (DL_DEV_DRIVER_BOUND), so no sibling can race its
> + * mailbox setup against this deinit.

[Severity: Medium]
Is this exclusion guaranteed? nbl_probe_chip_deps() in nbl_main.c checks
the supplier state without a lock, then creates the link, and rejects only
one link state:

	if (READ_ONCE(mgt->dev.links.status) != DL_DEV_DRIVER_BOUND) {
		pci_dev_put(mgt);
		return -EPROBE_DEFER;
	}

	link = device_link_add(&pdev->dev, &mgt->dev,
			       DL_FLAG_AUTOREMOVE_CONSUMER);
	...
	if (READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
		return -EPROBE_DEFER;

device_link_init_status() in drivers/base/core.c sets
DL_STATE_SUPPLIER_UNBIND only while the supplier is DL_DEV_UNBINDING:

	case DL_DEV_UNBINDING:
		link->status = DL_STATE_SUPPLIER_UNBIND;
		break;
	default:
		link->status = DL_STATE_DORMANT;

Two cases seem to get past the check:

(a) The control PF finishes unbinding, including nbl_dev_remove() ->
deinit_module, between the check and device_link_add(). It is then
DL_DEV_NO_DRIVER, so the link starts as DL_STATE_DORMANT and passes.

(b) The control PF has started re-probing (DL_DEV_PROBING) while the
sibling is probing. The link starts as DL_STATE_CONSUMER_PROBE and also
passes.

In both cases the sibling goes on to nbl_core_init() -> nbl_dev_init()
and sets up its mailbox queue. In (a) this happens right after the
control PF set driver_status=false, while the firmware's asynchronous
per-PF cleanup may still be running. In (b) it races the control PF's
nbl_dev_setup_chan_qinfo() and init_module programming.

The sibling and the control PF hold separate device_lock()s, so the
driver core does not serialize these paths.

The commit message makes the same claim:

  Device link dependency established during non-control PF probe ensures
  sibling PFs are unbound before the control PF is removed.

Should nbl_probe_chip_deps() re-check the supplier state after
device_link_add() and also reject DORMANT links and links to a supplier
that is still probing?

[ ... ]

> +/*
> + * Teardown order: Stop mailbox channel and drain all inflight DMA first,
> + * then invoke deinit_module to notify firmware.
> + *
> + * This intentionally breaks strict init/teardown mirror symmetry due to
> + * hardware constraint: firmware may perform asynchronous global hardware
> + * cleanup once driver_status=false is set. We must guarantee no ongoing
> + * mailbox DMA before deinit_module to avoid invalid DMA write.

[Severity: Low]
The commit message says:

  The firmware handles global hardware cleanup and QINFO routing state
  reclamation asynchronously after driver status is marked inactive.

This comment likewise refers to "asynchronous global hardware cleanup".
Is that accurate? This path reaches nbl_hw_deinit_module() in
nbl_hw_leonis.c through deinit_module, and that function documents a
narrower contract:

 * Setting driver status to false notifies firmware to clean up per-PF
 * hardware state such as qinfo registers.
 *
 * Note: firmware does NOT automatically revert chip-wide registers
 * configured in this init flow. Those chip-wide settings remain valid
 * until chip reset or explicitly overwritten by driver.

The earlier "add chip-wide hardware init/deinit implementation" commit
also says that firmware does not restore chip-wide datapath registers on
deinit.

So after the control PF is removed, the registers programmed by
nbl_dp_init() and nbl_intf_init() stay in place until chip reset. Could
the commit message and this comment say per-PF cleanup instead of global
cleanup?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928123237.88994-1-illusion.wang%40nebula-matrix.com
