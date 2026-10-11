Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99484399FB;
	Sun, 11 Oct 2026 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715886; cv=none; b=U379kVqwc2mQM1bHyRshKybqA4CxBnzkwjIAQZBdMDHCxmcZh4GAid5xglzSJ2j6zM+aZKiltkdB/0YjLhrP91W1NcbDkbxivPJPeiQilOKVV0lB4o49O64Yj/kLCfVpHbVnnJZhRKPyH3ko5E8344HgT0l52r0jSOfXf++W/Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715886; c=relaxed/simple;
	bh=as3ihcP+oak57EeL07rY+lPYLlsI1ssmjH8ifKRsFTE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b12uITHKkTPkTBZoc06VGV4p3kVPT/TJUVls5VLe9HELy/jZn6Abtx94WyddyLabN0o1Me0SsE82Hk7izvy4p3xVOfpjL9hT3BqkY4+Gmqdu0wisim17cXXpxZNpObIYXASbK7w+IWzDDJDG5QOi7gc0WNGF3FJsXUbGSgUSpWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvDVl7A4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvDVl7A4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8051F0089B;
	Sun, 11 Oct 2026 10:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791715884;
	bh=rWm/iIxqTz2W2z7/7Z6sI2zjSnesShsR3wonGIZZxLo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mvDVl7A4r06ljLllvB34LpYH8//j4Ax+tPbhYQ9H6tpE81ZPu79FruJvnijZZDw2v
	 aeSkagUkPiMTs7ruiYygvTIo+iWHWv8Qc8h/k97q2N11o6ntazj5zL3jS9nVc5AMH3
	 Jnn869cpsNJdqG77TdbNYf1ZEX8V6Zhcy8wHfNZQWfKXyDfG3zvHOv0s4XrOuP28j8
	 ippfUnTd4c9m5EIlViHtNHtGHcMXH53WcYC9S0glsDdQOilPKZ/AE2+m+mal5P2r4X
	 bKvtpj1H6NqM4u/TvLmX8q6MwyWFVO36n2EGPyvIced/7Dvk3tGvmHXbOv21WgfZA3
	 fZ3MI5zDwiHzw==
Subject: Re: [PATCH v31 net-next 4/8] net/nebula-matrix: add chip-wide
 hardware init/deinit implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 10:51:23 +0000
Message-ID: <179171588376.434549.16751659679042954344@kernel.org>
In-Reply-To: <20261010095939.2230-5-illusion.wang@nebula-matrix.com>
References: <20261010095939.2230-5-illusion.wang@nebula-matrix.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The stale-state recovery in nbl_hw_init_module() can wipe the
  per-PF mailbox state the driver has just programmed.
- [Medium] The only synchronization between the driver and firmware's
  asynchronous driver_status cleanup is a fixed usleep_range(2000,…
- [Medium] nbl_shaping_init() clears the shaping_net table
  (NBL_SHAPING_NET_REG(i)) only for i < NBL_MAX_PF (8), yet the loop…
- [Low] The comment on nbl_hw_deinit_module() (lines 730-734) says the
  safety of a later init_module() rests on the device link, and that the…
- [Low] The commit message covers only the driver_status handshake and
  the 2-3 ms best-effort wait.
- [Low] Baseline decision: false positive, because the series fixes it.
- [Low] Baseline decision: false positive.

--

net/nebula-matrix: add chip-wide hardware init/deinit implementation

This adds Leonis chip-wide init_module and deinit_module hooks in the hw
and resource layers. deinit_module clears the driver_status bit, flushes
and sleeps 2-3 ms to give the asynchronous firmware cleanup time to run.
init_module programs the datapath registers. If it finds driver_status
already set by a previous instance, it first clears the bit and waits for
the same window.

> Add Leonis chip-wide datapath init/deinit hooks (init_module and
> deinit_module) in the hw and resource layers. The hooks use the
> driver_status register as a handshake with firmware.

[Severity: Low]
This isn't a bug, but the commit message only describes the driver_status
handshake and the 2-3 ms wait. Most of the patch is chip-wide datapath
programming in nbl_dp_init() and nbl_intf_init(), and several of those
writes change device behaviour:

  - SCTP L4 checksum enable in DPED
  - UPED TCP L3-length edit profiles
  - per-port CIR/PIR shaping from the firmware speed (DVN dport CIR at
    half rate), and PSHA enable
  - DSCH host QID max (0x7ff) and quanta
  - USTORE min packet length 42 and drop thresholds
  - DSTORE drop-enable clear and XON/XOFF thresholds
  - relaxed ordering bits taken from DEVCTL
  - UQM counter clearing and que_type forced to backpressure mode
  - PADPT flow control credits

The patch also adds a new firmware ABI dependency in nbl_hw_get_quirks(). It
reads a quirk word at mailbox offset 0x140, where ~0U means no quirks and
BIT(1) selects the UVN prefetch mode.

deinit_module also doesn't revert any of these datapath registers. They stay
programmed until chip reset, even if the control PF is later bound to
another driver.

Could the commit message describe these?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c
> new file mode 100644
> index 0000000000000..419eb6392ada1
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c
> @@ -0,0 +1,32 @@

[ ... ]

> +int nbl_res_chip_init_module(struct nbl_resource_mgt *res_mgt)
> +{

[ ... ]

> +	hw_ops = res_mgt->hw_ops_tbl->ops;
> +	p = res_mgt->hw_ops_tbl->priv;
> +	return hw_ops->init_module(p, eth_speed, eth_num);
> +}

[Severity: Low]
This isn't a bug, but nothing calls init_module or deinit_module at this
point in the series. nbl_hw_setup_ops() and nbl_res_setup_ops() only check
the new hooks for NULL.

Two later commits wire them up:

  - "net/nebula-matrix: dispatch: add control-level routing core
    infrastructure" adds nbl_disp_init_module() and
    nbl_disp_deinit_module()
  - "net/nebula-matrix: add common/ctrl dev init/remove operation" calls
    them from nbl_dev_setup_ctrl_dev() and nbl_dev_remove_ctrl_dev()

So the final state of the series looks fine. nbl_hw_init_module() also
validates eth_num with nbl_hw_eth_num_valid().

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index 1712cdbc5fe74..bd1216265036b 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c

[ ... ]

> @@ -150,6 +164,658 @@ static void nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt, u32 *eth_map)

[ ... ]

> +static int nbl_shaping_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
> +{
> +#define NBL_SHAPING_FLUSH_INTERVAL 128

[ ... ]

> +	for (i = 0; i < NBL_MAX_PF; i++) {
> +		nbl_hw_wr_regs_lock(hw_mgt, NBL_SHAPING_NET_REG(i),
> +				    net_shaping.data,
> +				    sizeof(net_shaping));
> +		if ((i + 1) % NBL_SHAPING_FLUSH_INTERVAL == 0)
> +			nbl_flush_writes(hw_mgt);
> +	}
> +	nbl_flush_writes(hw_mgt);
> +	return 0;
> +}

[Severity: Medium]
Is NBL_MAX_PF the right bound for the shaping_net table here?

NBL_MAX_PF is 8 and NBL_SHAPING_FLUSH_INTERVAL is 128, so (i + 1) % 128 == 0
is never true and the periodic flush is dead code. Flushing every 128 writes
suggests a table with hundreds of entries.

The other tables this patch sweeps have depth macros
(NBL_DSTORE_PORT_DROP_TH_DEPTH, NBL_UQM_PORT_DROP_DEPTH and
NBL_UQM_DPORT_DROP_DEPTH). shaping_net has none, so the bound can't be
checked against the register map.

If the table is deeper than 8, would entries above index 7 keep whatever a
previous instance or firmware left there across kexec or rebind? That could
include VALID set with stale CIR/PIR.

[ ... ]

> +/*
> + * Setting driver status to false notifies firmware to clean up per-PF
> + * hardware state such as qinfo registers.
> + *
> + * Note: firmware does NOT automatically revert chip-wide registers
> + * configured in this init flow. Those chip-wide settings remain valid
> + * until chip reset or explicitly overwritten by driver.

[ ... ]

> + * does not guarantee that the firmware pass has finished.  The ordering
> + * this relies on is the device-link one: sibling PFs are unbound before
> + * the control PF, so a later init_module() requires an admin (or the
> + * core's AUTOPROBE re-probe) to bind this PF again, which is not
> + * instantaneous - but there is no hard firmware handshake.

[Severity: Low]
Is the AUTOPROBE part of this comment accurate?

init_module and deinit_module only run on the control PF, because of the
has_ctrl checks in nbl_chip.c. nbl_probe_chip_deps() in nbl_main.c returns
early when has_ctrl is set. For the siblings it does:

    link = device_link_add(&pdev->dev, &mgt->dev,
                           DL_FLAG_AUTOPROBE_CONSUMER);

This makes the siblings consumers and func 0 the supplier.
DL_FLAG_AUTOPROBE_CONSUMER only re-probes consumers, so it never rebinds the
control PF.

The link also doesn't order the control PF's own deinit against its next
init. Only the 2-3 ms sleep does that.

The two comments in this file also disagree. The one above
NBL_FW_CLEANUP_SYNC_MIN_US says:

    Bounding the wait keeps a later init_module() from reprogramming
    per-PF/chip-wide registers while firmware is realistically still
    wiping them

This comment says firmware does not automatically revert chip-wide
registers. Which one describes what firmware actually cleans?

> + *
> + * Caller must ensure no new DMA is initiated after this point.
> + * The mailbox channel is stopped by nbl_chan_teardown_queue()
> + * before this function is called, so no in-flight mailbox DMA
> + * remains.
> + */
> +static void nbl_hw_deinit_module(struct nbl_hw_mgt *hw_mgt)
> +{
> +	nbl_hw_set_driver_status(hw_mgt, false);
> +	/* ensure driver_status reaches the chip */
> +	nbl_flush_writes(hw_mgt);
> +	/*
> +	 * Give the asynchronous firmware cleanup pass time to settle
> +	 * before returning; best-effort, see NBL_FW_CLEANUP_SYNC_MIN_US.
> +	 */
> +	usleep_range(NBL_FW_CLEANUP_SYNC_MIN_US, NBL_FW_CLEANUP_SYNC_MAX_US);
> +}

[ ... ]

> +static int nbl_hw_init_module(struct nbl_hw_mgt *hw_mgt, u8 eth_speed,
> +			      u8 eth_num)
> +{

[ ... ]

> +	status = nbl_hw_rd32(hw_mgt, NBL_DRIVER_STATUS_REG);

[Severity: Low]
This probably isn't an issue in practice, but bit 16 is tested here with an
unlocked read. The clear below is a separate read-modify-write under
reg_lock in nbl_hw_set_driver_status().

On the driver side, both only run from the serialized control PF probe and
remove paths. Only the driver sets bit 16, so a stale read at worst causes a
redundant clear and sleep.

Does firmware ever write other bits of NBL_DRIVER_STATUS_REG? If it does,
could the read-modify-write in nbl_hw_set_driver_status() lose those
updates?

> +	if (status & BIT(NBL_DRIVER_STATUS_BIT)) {
> +		dev_warn(hw_mgt->common->dev,
> +			 "driver_status already set at init, cleanup forced\n");
> +		nbl_hw_set_driver_status(hw_mgt, false);
> +		nbl_flush_writes(hw_mgt);
> +		usleep_range(NBL_FW_CLEANUP_SYNC_MIN_US,
> +			     NBL_FW_CLEANUP_SYNC_MAX_US);
> +	}

[Severity: High]
Can this forced 1 -> 0 transition wipe the mailbox state the driver has just
programmed?

The deinit_module comment above says firmware reacts to driver_status going
to 0 by cleaning per-PF state such as qinfo registers. Later in the series,
nbl_dev_remove_ctrl_dev() relies on the same behaviour:

    The qinfo map programmed in nbl_dev_init() via
    nbl_dev_setup_chan_qinfo() is not explicitly cleared; firmware
    handles it on driver_status change

In the final state of the series, nbl_dev_init() runs in this order:

nbl_dev_init()
    nbl_dev_setup_chan_qinfo()
        nbl_chan_cfg_qinfo_map_table()
            hw_ops->cfg_mailbox_qinfo()     /* for every PF */
    nbl_dev_setup_common_dev()              /* mailbox queue setup */
    nbl_dev_setup_ctrl_dev()
        nbl_disp_init_module()
            nbl_res_chip_init_module()
                nbl_hw_init_module()
                    nbl_hw_set_driver_status(hw_mgt, false)

So the stale clear happens after the mailbox QINFO map and queue registers
are programmed, and nothing reprograms them afterwards. This function then
sets driver_status back to 1 and returns 0.

The driver has no .shutdown callback, so every kexec reaches this path. The
commit message names kexec as a case init_module handles.

If firmware clears the QINFO routing here, would the inter-PF mailbox stop
working? The sibling PFs' cross-PF requests would then time out and their
probes would fail.

Would it work to do the stale driver_status clear before any per-PF
programming in nbl_dev_init(), or to reprogram the mailbox state after it?

> +
> +	ret = nbl_dp_init(hw_mgt, eth_speed, eth_num);
> +	if (ret)
> +		return ret;
> +	nbl_intf_init(hw_mgt);
> +	nbl_hw_set_driver_status(hw_mgt, true);

[Severity: Medium]
The only synchronization with the asynchronous firmware cleanup is a fixed
usleep_range(2000, 3000). It is used here and in nbl_hw_deinit_module().

On this stale path, the bit stays low only for that sleep plus the
nbl_dp_init() and nbl_intf_init() register writes, and then it is set again
here. If firmware samples driver_status less often than that, can it miss
the 0 entirely? The per-PF cleanup this path is meant to trigger would then
never run.

If firmware does see the 0 but its cleanup takes longer than the window, can
the cleanup overlap the new instance's programming? That includes
driver_status=1 here and the MSI-X map and mailbox IRQ setup later in
nbl_dev_start(). Neither case would be reported.

On the deinit side, only elapsed time separates a quick unbind and rebind
of the control PF from an unfinished firmware pass.

Does firmware provide an acknowledgement that could be polled here, or a
documented upper bound on its polling period and cleanup latency?

> +	/* ensure registers written */
> +	nbl_flush_writes(hw_mgt);
> +
> +	return 0;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010095939.2230-1-illusion.wang%40nebula-matrix.com
