Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792920267;
	b=2P9NtPfVNXilrJVgvFpkNg1SYeLoINc55ijOWb9dULe7GE33VcwXxytucQ9ddN+F/AwD
	 xbLhCYYwvUq0gUkbRjBJYU0Lbdt4Rgra8LqIQpUK2+vLdn7gnohIuljdFxAmgDGMrFARu
	 vI6pPpQov2jwxu7Y5aX8BHOY1IqDEHEZhSQJAAHcZmK+GW6oBvdW8WtZA6AtN5UzvhKCk
	 d0uZ1YfmUEquvaQ2VCbylhvfTPNbJ2c0uV4lTVRFiCD+8tzM+mmQ1/U6v9u/Ux0rElN+8
	 e+o6x5rTvmBiJVgNVLUShAtDKy63G1Io8pjPBhso8lSXoKRwHFVgiclUtF65UzFTlQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792920267;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8ru8WucTgf5XxTTBZ+kWcpF4CX3cvFOX6RXg7kHDSH8=;
	b=DvQaeexF/qCPtNufUIzSTuEF8DOvob0hLA/r3iD4LBdfxdpLRjfbRZVT5yXCSlIy8v3F
	 Ari1EsbbbrtLgOhSbskLjVqbIaV1EKV3yiqvoUCbAajL28HeMEHhLgSGUbjbGXbkRs8FH
	 bhv2C1OGEeIMacmIURHdShz0gBm6CKMLBFVZi25WOXWrMJ/dE95jqzaB0Z9OPOVwVWTfU
	 cjRYws8HDbgaDoI4Gixdaj153W2YnPIsLxlU9cnCFLZgL4HMrhSNbuOBmSWZZu3bA8Kjm
	 OQue9UHudmC6TSCvkJ36et+cNSdRD+lfURtUjkFyW9bVNGWleW9nm/AgzD1iaFm893A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZMyfoPq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1324606A32F;
	Sun, 25 Oct 2026 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZMyfoPq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0332D1F01825;
	Sun, 25 Oct 2026 09:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792920266;
	bh=8ru8WucTgf5XxTTBZ+kWcpF4CX3cvFOX6RXg7kHDSH8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QZMyfoPqMVgCEguqdcJuKeGJecn6vc/Iu6h8q1gX2W+6mNkajoO2AP0w32SgR9Z30
	 xmLhYdNOpqTMWYt5ao6AISrAGvl879z0I1cKyPv14UWj3DEQkUpi0F9pVxO+GyHnKp
	 GCkEX+u0QKe0Z7uhXOXCf7pVuaFByl9HBl1FydyOWAOVldjS2z9qAAJ27+zKx/rFyy
	 r5oIKfRPltdaS66Z3FoZyU9rw6hjSAgyYWojAc8+h4fcEluMl7sEK6GLkh/aFjPwyj
	 JaGr2sPahSKH9PM6M9pDU3YoNonH2BchVMmSrh7sELsv6/wlf6U24okCvl4ODBXeei
	 Wet4+KsgSnlHQ==
Subject: Re: [PATCH v32 net-next 4/8] net/nebula-matrix: add chip-wide
 hardware init/deinit implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 andrew+netdev@lunn.ch, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 09:24:25 +0000
Message-ID: <179292026555.3134.12245469100906472128@kernel.org>
In-Reply-To: <20261021062113.2158-5-illusion.wang@nebula-matrix.com>
References: <20261021062113.2158-5-illusion.wang@nebula-matrix.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] nbl_hw_clear_stale_status() and nbl_hw_deinit_module() only
  wait a fixed 2-3 ms before going on, and nothing confirms the firmware…
- [Medium] nbl_hw_set_driver_status() does a host-side read-modify-write
  of NBL_DRIVER_STATUS_REG (0x1300444): rd32, clear and set BIT(16),…
- [Low] The commit message and one code comment do not match the code.
- [Low] The header comment on nbl_hw_init_module() says 'Full chip
  hardware initialization is handled by firmware.
- [Low] Concern (baseline decision: false positive): nbl_shaping_init()
  does a read-modify-write of NBL_DSCH_PSHA_EN_ADDR with…

--

net/nebula-matrix: add chip-wide hardware init/deinit implementation

This patch adds the Leonis chip-wide init_module() and deinit_module()
hooks in the hw and resource layers, gated on has_ctrl. init_module()
programs the DPED/UPED/SHAPING/DSCH/USTORE/DSTORE/DVN/UVN/UQM/PADPT
datapath registers and sets the driver_status bit. deinit_module() clears
that bit and sleeps 2-3 ms for the asynchronous firmware cleanup, and a
stale driver_status bit is cleared early in nbl_hw_init_leonis().

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index 75d6982ae1e83..05f21d0416104 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c

[ ... ]

> @@ -150,6 +167,695 @@ static void nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt, u32 *eth_map)

[ ... ]

> +static int nbl_shaping_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
> +{

[ ... ]

> +	nbl_hw_rd_regs_lock(hw_mgt, NBL_DSCH_PSHA_EN_ADDR, &reg_val,
> +			    sizeof(reg_val));
> +	reg_val &= ~NBL_DSCH_PSHA_EN_MASK;
> +	reg_val |= FIELD_PREP(NBL_DSCH_PSHA_EN_MASK,
> +			      eth_bitmap & GENMASK(3, 0));
> +	nbl_hw_wr_regs_lock(hw_mgt, NBL_DSCH_PSHA_EN_ADDR, &reg_val,
> +			    sizeof(reg_val));

[Severity: Low]
This isn't a bug, but this read-modify-write of NBL_DSCH_PSHA_EN_ADDR drops
reg_lock between nbl_hw_rd_regs_lock() and nbl_hw_wr_regs_lock(). Right
now nbl_shaping_init() is the only code that touches this register, and it
only runs from the serialized control-PF probe, so no update can be lost.

nbl_dvn_init() also writes NBL_DVN_ECPU_QUEUE_NUM without the lock:

    nbl_hw_wr32(hw_mgt, NBL_DVN_ECPU_QUEUE_NUM, 0);

nbl_uvn_init(), by contrast, writes NBL_UVN_ECPU_QUEUE_NUM under reg_lock.

To match the rest of the file, would it make sense to hold reg_lock
across the whole read-modify-write here, and to take it in nbl_dvn_init()
too?

[ ... ]

> +/*
> + * Read-modify-write under reg_lock: NBL_DRIVER_STATUS_BIT is the only
> + * bit the driver owns, and the RMW leaves every other bit of the
> + * register untouched.
> + */
> +static void nbl_hw_set_driver_status(struct nbl_hw_mgt *hw_mgt, bool active)
> +{
> +	u32 status;
> +
> +	spin_lock(&hw_mgt->reg_lock);
> +	status = nbl_hw_rd32(hw_mgt, NBL_DRIVER_STATUS_REG);
> +
> +	status &= ~BIT(NBL_DRIVER_STATUS_BIT);
> +	status |= FIELD_PREP(BIT(NBL_DRIVER_STATUS_BIT), active);
> +
> +	nbl_hw_wr32(hw_mgt, NBL_DRIVER_STATUS_REG, status);
> +	spin_unlock(&hw_mgt->reg_lock);
> +}

[Severity: Medium]
The comment says bit 16 is the only bit the driver owns. That suggests the
other bits of NBL_DRIVER_STATUS_REG (0x1300444) belong to some other agent,
most likely firmware, which already consumes this register.

reg_lock only serializes accesses from the CPU. If firmware updates
another bit of this register between the nbl_hw_rd32() and the
nbl_hw_wr32(), can the driver write back a stale value and undo that
firmware update?

All three callers can hit this: the stale-status clear in probe,
nbl_hw_init_module() and nbl_hw_deinit_module().

Is this register driver-exclusive? Or does it have W1S/W1C semantics that
would let the driver set and clear bit 16 without a read-modify-write?
Could the semantics be documented next to NBL_DRIVER_STATUS_REG?

[ ... ]

> +/*
> + * Clear a stale driver_status active bit before this probe programs any
> + * per-PF state.
> + *
> + * A previous kernel instance can leave the bit set (kexec, or an unload
> + * that never reached deinit_module()) and firmware then never ran the
> + * per-PF cleanup it drives off the 1 -> 0 transition.  That cleanup
> + * reclaims the mailbox QINFO routing and the qinfo registers, which is
> + * exactly what nbl_dev_setup_chan_qinfo() and nbl_chan_setup_queue()
> + * write later in this probe.  Clearing it there - as the chip init path
> + * used to - wipes those registers and leaves the inter-PF mailbox dead,

[Severity: Low]
This isn't a bug, but "as the chip init path used to" seems to describe an
earlier revision of this patch, not code in the tree. Could the comment
just state the current ordering requirement?

Also, the commit message says:

  The relaxed-ordering bits in
  both DVN and UVN are derived from the PCIe DEVCTL state through
  pci_relaxed_ordering_enabled().

There is no pci_relaxed_ordering_enabled(). nbl_dvn_init() and
nbl_uvn_init() both call pcie_relaxed_ordering_enabled(). Should the commit
message use that name?

> + * so sibling PFs' RPCs time out in nbl_dev_start() and their probes
> + * fail.  It also has to happen before the mailbox queue is live, so the
> + * cleanup cannot reclaim routing under an in-flight transfer.
> + *
> + * Only the control PF owns this chip-wide handshake.  The bounded wait
> + * after the clear is best-effort, see NBL_FW_CLEANUP_SYNC_MIN_US.
> + */
> +static void nbl_hw_clear_stale_status(struct nbl_hw_mgt *hw_mgt)
> +{

[ ... ]

> +	dev_warn(hw_mgt->common->dev,
> +		 "driver_status already set, stale cleanup forced\n");
> +	nbl_hw_set_driver_status(hw_mgt, false);
> +	nbl_flush_writes(hw_mgt);
> +	usleep_range(NBL_FW_CLEANUP_SYNC_MIN_US, NBL_FW_CLEANUP_SYNC_MAX_US);
> +}

[Severity: Medium]
Is a fixed 2-3 ms sleep enough to keep the firmware cleanup pass from
racing with the rest of this probe?

nbl_flush_writes() only shows that the status write reached the device.
The comments also say the hardware has no cleanup-complete bit.

With the later patches in the series applied, the probe order is roughly:

nbl_core_init()
  nbl_hw_init_leonis()
    nbl_hw_clear_stale_status()    /* clear bit 16, sleep 2-3 ms */
  ...
  nbl_dev_init()
    nbl_dev_setup_chan_qinfo()     /* programs mailbox QINFO routing */
    nbl_dev_setup_common_dev()
      nbl_chan_setup_queue()       /* programs qinfo, sets QUEUE_EN */

Suppose firmware takes longer than about 2-3 ms, for example because the
ECPU is busy right after kexec. Can it then reclaim the routing and qinfo
registers that were just programmed?

That would leave the inter-PF mailbox dead, and sibling PF RPCs would time
out in nbl_dev_start(). That is the failure the comment above describes.
It could also reclaim routing under a live queue.

nbl_hw_deinit_module() relies on the same unverified delay. On a later
rebind driver_status is already 0, so nbl_hw_clear_stale_status() returns
at once without knowing whether the earlier pass has finished.

The NBL_FW_CLEANUP_SYNC_MIN_US value does not appear to come from any
documented firmware latency.

Could the driver poll for an observable side effect of the cleanup with a
timeout, such as the QINFO/qinfo entries reading back as reclaimed? Or
could it check the registers after programming them?

> +/*
> + * Full chip hardware initialization is handled by firmware.
> + * This function only configures driver-level table entries and registers.
> + *

[Severity: Low]
This isn't a bug, but does this comment match what the function does?

Through nbl_dp_init() and nbl_intf_init() it programs chip-wide datapath
registers that every PF shares (SHAPING, DSCH, USTORE/DSTORE, DVN/UVN, UQM,
PADPT). The commit message also says "none of which firmware sets up on
the driver's behalf".

The comment on nbl_hw_deinit_module() describes the same registers
differently:

 * Note: firmware does NOT automatically revert chip-wide registers
 * configured in this init flow.

The nbl_dev_init() comment added later in the series repeats the "Chip
hardware initialization is completed by firmware at power-up" wording.

Could these comments agree on who owns this state?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021062113.2158-1-illusion.wang%40nebula-matrix.com
