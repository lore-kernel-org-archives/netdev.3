Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8492D4AC14E;
	Thu, 17 Sep 2026 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684511; cv=none; b=OZpft/g8CTxJT9LyaXve3qKssDe0gScCv67oBaG6Jr886vAZcEXncIjIWfAZKAuTm0s7Efdz/qFKVUC5dEbpsyHrbF55RdPw2dpaEpL1bdzVcG0Dbr0vQ32oPjR4S88fDHSF5mNDViK44hZD6lRyxXaRPD0IRnZSAutFLWEfWo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684511; c=relaxed/simple;
	bh=x1KoCSBjFplvpwHarrwxy8YPA9AIfmA5TkL2uY/Y1r0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oeT/PnxUB+UmJMosnPz3qT5xNyz4SRFZNQN39EQTunBwh/R+B+4yxTwafiJNWPHbwiT/KiC8SAndNzssL5MdwQUrNPmv6/CU+VWkV873sp4D5rCgLwbVhK79lMz5rUA5KI36SJ0nBi6JPUfkqoCsI10G3F9KjV3wot4NiIBVS44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXCSCAGt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXCSCAGt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E14F1F000FF;
	Thu, 17 Sep 2026 22:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684508;
	bh=kMP8hn6LfDE+etrtls+P4ot/7ZMb3V803kW72PMV+RM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OXCSCAGt4L1m0gIoHYmmNbyQUcdnPSMFFiL5czxcwhCm11mnJScaJK5JXTDG+rq7U
	 IIBpU7ADYWrahJGpXppRf4g8RMgVPAREMZoCs8I7UXosMHkyL/SLRpLxnx+DEBX5th
	 0Q5BAUOpJnNKhdVT5nhhcad+L9W56Pu2WWqbmf/9VZbsJrZmEs7cIOYe79TrYaQ5yq
	 LZTqEodJHq6PwoI1IeTo+BiRHJNd9VdsWnUJnBfCujg9mpKKX0x4iUTahY1IS/H4i2
	 CoN3TitzIkSl8og2kvjAYSXfGnBHvA1LVgz/cKsxcJosKQwU9WAO72hXPgB/fv0Kbi
	 a2J0ti5CQmq6g==
Subject: Re: [PATCH v28 net-next 06/10] net/nebula-matrix: add chip-wide
 hardware init/deinit implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 22:35:06 +0000
Message-ID: <178968450670.22033.12730889480864035536@kernel.org>
In-Reply-To: <20260914123429.56596-7-illusion.wang@nebula-matrix.com>
References: <20260914123429.56596-7-illusion.wang@nebula-matrix.com>
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

Critical: 0 · High: 0 · Medium: 3 · Low: 5

- [Medium] The doc comment above nbl_hw_deinit_module()
  (drivers/net/ethernet/nebula-…
- [Medium] Chip-wide teardown is tied to a single PF's unbind with no
  interlock.
- [Medium] Three chip registers whose only documented fields are narrow
  bitfields are programmed with a blind full-word write built from zero,…
- [Low] The patch introduces an entirely new firmware ABI word
  (nbl_hw_get_quirks(), NBL_LEONIS_QUIRKS_OFFSET 0x140,…
- [Low] Concern that the ~600 lines of hardware programming and the two
  new ops in nbl_hw_ops/nbl_resource_ops have no caller at this commit,…
- [Low] nbl_dsch_qid_max_init() (nbl_hw_leonis.c:298-312), described in
  the changelog as "dsch: Scheduler core (qid limit, VN quanta)", also…
- [Low] In nbl_shaping_eth_init() (nbl_hw_leonis.c:210) `depth =
  max_t(u32, rate * 2, NBL_LR_LEONIS_NET_BUCKET_DEPTH);` can never…
- [Low] Two of the new register configuration sequences perform a read-
  modify-write while dropping hw_mgt->reg_lock between the read and the…

--

net/nebula-matrix: add chip-wide hardware init/deinit implementation

This adds the Leonis chip-wide init/deinit routines that program the
datapath pipeline (packet editors, scheduler, buffer stores, queue
manager, shaping and flow control) and the driver_status flag consumed by
firmware.  The new hw_ops.init_module/deinit_module and the matching
resource_ops entries are registered here; the invocation path arrives in
a later patch.

A few questions about the new code below.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c
> new file mode 100644
> index 0000000000000..419eb6392ada1
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2026 Nebula Matrix Limited.
> + */
> +#include <linux/device.h>
> +#include "nbl_chip.h"
> +
> +void nbl_res_chip_deinit_module(struct nbl_resource_mgt *res_mgt)
> +{
> +	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
> +	struct nbl_common_info *common = res_mgt->common;
> +
> +	if (!common->has_ctrl)
> +		return;
> +	hw_ops->deinit_module(res_mgt->hw_ops_tbl->priv);
> +}

[Severity: Medium]
This teardown is chip-wide but is triggered by a single PF instance
unbinding.  has_ctrl is set only for PCI function 0 in nbl_init_func_caps():

    if ((PCI_FUNC(pdev->devfn) == 0) && !pdev->is_virtfn)
            param->caps.has_ctrl = 1;

and nbl_res_chip_deinit_module() then reaches nbl_hw_set_driver_status(hw_mgt,
false), which by this patch's own comment "notifies firmware to clean up
per-PF hardware state such as qinfo registers" for every PF on the chip.

Each PF is an independent driver instance, so what happens when PF0 is
unbound (or fails probe) while PF1..PF3 are still bound with live mailbox
queues?  Is there anything that keeps firmware from cleaning up their qinfo
state underneath them?

The commit message says:

    Callers must ensure no new DMA is started after deinit_module returns.

Can a per-PF caller actually enforce that on its siblings?  A refcount over
the chip-wide state, an ordering check, or at minimum a warning when
siblings are still bound would make this enforceable in code rather than by
convention.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index 33f6b4e870815..aaf6d25e8ae23 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> @@ -115,6 +115,618 @@ static void nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt, u32 *eth_map)
>  	*eth_map = FIELD_GET(NBL_FW_BOARD_DW6_ETH_BITMAP_MASK, data);
>  }
>  
> +static u32 nbl_hw_get_quirks(struct nbl_hw_mgt *hw_mgt)
> +{
> +	u32 quirks = 0;
> +
> +	/*
> +	 * Read quirk bits from mailbox register.
> +	 * All supported firmware implement the quirk ABI,
> +	 * firmware always populates NBL_LEONIS_QUIRKS_OFFSET.
> +	 * Value ~0U indicates no active quirks.
> +	 */
> +	nbl_hw_read_mbx_regs(hw_mgt, NBL_LEONIS_QUIRKS_OFFSET, &quirks,
> +			     sizeof(u32));
> +
> +	if (quirks == ~0u)
> +		return 0;
> +
> +	return quirks;
> +}

[Severity: Low]
The changelog does not mention this new firmware ABI word at all, even
though it changes chip-wide datapath programming.  Could the quirk word be
described in the commit message?

How is the claim "All supported firmware implement the quirk ABI" verified?
There is no firmware version gating here, and only ~0U is treated as "no
quirks", so any image that leaves something else at offset 0x140 with bit 1
set silently selects a different UVN prefetch mode in nbl_uvn_init():

    FIELD_PREP(NBL_UVN_DESC_PREFETCH_INIT_SEL_MASK,
               (quirks & NBL_QUIRK_UVN_PREFETCH_ALIGN) ? 0 : 1);

There is no log message when a quirk is applied, so an operator has no way
to tell which prefetch mode the chip ended up in.

Also, NBL_QUIRK_NO_TOE has no consumer anywhere in the driver, including at
the end of this series.  Would it be better to add that define together with
the code that uses it?

> +static int nbl_shaping_eth_init(struct nbl_hw_mgt *hw_mgt, u8 eth_id, u8 speed)
> +{

[ ... ]

> +	half_rate = rate / 2;
> +	depth = max_t(u32, rate * 2, NBL_LR_LEONIS_NET_BUCKET_DEPTH);

[Severity: Low]
Can the NBL_LR_LEONIS_NET_BUCKET_DEPTH operand ever be selected here?
nbl_hw_init_module() rejects anything outside {10G, 25G, 50G, 100G} through
nbl_hw_eth_speed_valid(), so rate is one of 10000/25000/50000/100000 and
rate * 2 is always at least 20000, which is greater than 9600.

Was a cap (min_t) intended instead, or is the 9600 constant expressed in a
different unit than the "1 = 1 Mbit/s" rate unit documented in the header?
depth feeds NBL_DPORT_DEPTH_MASK, the CBS halves and NBL_DPORT_PBS_MASK, so
a unit mismatch here mis-programs the shaper silently.

> +static int nbl_shaping_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
> +{
> +#define NBL_SHAPING_FLUSH_INTERVAL 128
> +	struct nbl_shaping_net_u net_shaping = { 0 };
> +	u32 eth_bitmap = 0;
> +	u32 psha_en = 0;
> +	int ret;
> +	int i;
> +
> +	nbl_hw_get_fw_eth_map(hw_mgt, &eth_bitmap);
> +	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
> +		if (!(eth_bitmap & BIT(i)))
> +			continue;
> +		ret = nbl_shaping_eth_init(hw_mgt, i, speed);
> +		if (ret)
> +			return ret;
> +	}
> +	psha_en = eth_bitmap & GENMASK(3, 0);
> +	psha_en = FIELD_PREP(NBL_DSCH_PSHA_EN_MASK, psha_en);
> +	nbl_hw_wr_regs_lock(hw_mgt, NBL_DSCH_PSHA_EN_ADDR, &psha_en,
> +			    sizeof(psha_en));

[Severity: Medium]
psha_en starts at 0 and only bits 3:0 are set (NBL_DSCH_PSHA_EN_MASK is
GENMASK(3, 0)), yet the full 32-bit word is written without a prior read.
Does this clobber bits 31:4 of NBL_DSCH_PSHA_EN_ADDR?

The same pattern shows up twice more in this patch:

nbl_dsch_qid_max_init():
    nbl_hw_wr32(hw_mgt, NBL_DSCH_HOST_QID_MAX, NBL_MAX_QUEUE_ID);

nbl_ustore_init():
    drop_th |= FIELD_PREP(NBL_USTORE_PORT_DROP_TH_EN_MASK, 1);
    ...
    nbl_hw_wr_regs(hw_mgt, NBL_USTORE_PORT_DROP_TH_REG_ARR(i),
                   &drop_th, sizeof(drop_th));

drop_th is built from 0 with only GENMASK(11, 0) and BIT(31) set, so bits
30:12 go to zero.  That is in the same function that read-modify-writes
NBL_USTORE_PKT_LEN_ADDR with the comment "(to preserve other fields while
updating 'min')".

NBL_DSTORE_PORT_DROP_TH_REG(), NBL_DSTORE_DISC_BP_TH,
NBL_DSTORE_D_DPORT_FC_TH_REG(), NBL_DPED_L4_CK_CMD_40_ADDR,
NBL_UVN_DESC_WR_TIMEOUT and NBL_UVN_DIF_REQ_RO_FLAG are all read-modify-
written in this patch.  Should these three be as well, or do those words
really contain nothing else?

Since deinit does not reprogram these registers, any firmware default
destroyed here stays destroyed until chip reset.

> +static void nbl_dsch_qid_max_init(struct nbl_hw_mgt *hw_mgt)
> +{
> +	u32 quanta = 0;
> +
> +	quanta = FIELD_PREP(NBL_DSCH_VN_QUANTA_H_QUA_MASK, NBL_HOST_QUANTA) |
> +		 FIELD_PREP(NBL_DSCH_VN_QUANTA_E_QUA_MASK, NBL_ECPU_QUANTA);
> +	spin_lock(&hw_mgt->reg_lock);
> +	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_VN_QUANTA_ADDR, &quanta,
> +		       sizeof(quanta));
> +	nbl_hw_wr32(hw_mgt, NBL_DSCH_HOST_QID_MAX, NBL_MAX_QUEUE_ID);
> +
> +	nbl_hw_wr32(hw_mgt, NBL_DVN_ECPU_QUEUE_NUM, 0);
> +	nbl_hw_wr32(hw_mgt, NBL_UVN_ECPU_QUEUE_NUM, 0);
> +	spin_unlock(&hw_mgt->reg_lock);
> +}

[Severity: Low]
The changelog describes this helper as:

    - dsch:           Scheduler core (qid limit, VN quanta)

but it also programs NBL_DVN_ECPU_QUEUE_NUM and NBL_UVN_ECPU_QUEUE_NUM,
which belong to the DVN and UVN blocks.  nbl_dvn_init() and nbl_uvn_init()
never touch them.

Would these two writes fit better in nbl_dvn_init() and nbl_uvn_init(), so
that the per-module decomposition in the changelog matches the code?

> +static void nbl_dvn_descreq_num_cfg(struct nbl_hw_mgt *hw_mgt, u8 descreq_num)
> +{
> +	u8 split_ring_num = (descreq_num >> 3) & 0x1;
> +	u8 ring_num = descreq_num & 0x7;
> +	u32 num_cfg;
> +	u32 reg_val;
> +
> +	nbl_hw_rd_regs_lock(hw_mgt, NBL_DVN_DESCREQ_NUM_CFG, &reg_val,
> +			    sizeof(reg_val));
> +
> +	num_cfg = FIELD_PREP(NBL_DVN_DESCREQ_NUM_CFG_AVRING_DESREQ_NUM_CFG_MASK,
> +			     split_ring_num) |
> +		  FIELD_PREP(NBL_DVN_DESCREQ_NUM_CFG_PACKED_L1_NUM_MASK,
> +			     ring_num);
> +	reg_val &= ~(NBL_DVN_DESCREQ_NUM_CFG_AVRING_DESREQ_NUM_CFG_MASK |
> +		NBL_DVN_DESCREQ_NUM_CFG_PACKED_L1_NUM_MASK);
> +	reg_val |= num_cfg;
> +	nbl_hw_wr_regs_lock(hw_mgt, NBL_DVN_DESCREQ_NUM_CFG, &reg_val,
> +			    sizeof(reg_val));
> +}

[Severity: Low]
Is reg_lock meant to cover this read-modify-write?  Both helpers take and
drop the lock themselves:

    static void nbl_hw_rd_regs_lock(...)
    {
            ...
            spin_lock(&hw_mgt->reg_lock);
            for (i = 0; i < size; i++)
                    data[i] = rd32(hw_mgt->hw_addr, reg + i * sizeof(u32));
            spin_unlock(&hw_mgt->reg_lock);
    }

so the sequence is lock/read/unlock ... lock/write/unlock and no lock is
held while reg_val is modified.  The same split appears in nbl_uvn_init()
for NBL_UVN_DESC_PREFETCH_INIT.

Every other read-modify-write added by this patch holds reg_lock across the
whole sequence (nbl_configure_dped_checksum(), nbl_uped_init(),
nbl_dstore_init(), the first half of nbl_uvn_init(),
nbl_hw_set_driver_status()), and the comment above nbl_hw_set_mailbox_irq()
states "The full RMW sequence is wrapped by reg_lock".  Since both writes
preserve the register's other bits, would an interleaved writer lose its
update here?

> +static void nbl_uvn_init(struct nbl_hw_mgt *hw_mgt)
> +{

[ ... ]

> +	spin_unlock(&hw_mgt->reg_lock);
> +	quirks = nbl_hw_get_quirks(hw_mgt);
> +	/*
> +	 * sel=0: use configured num; sel=1: use internal calc (max 32)
> +	 * Default is sel=1, unless NBL_QUIRK_UVN_PREFETCH_ALIGN is set,
> +	 * in which case override to sel=0.
> +	 */
> +	nbl_hw_rd_regs_lock(hw_mgt, NBL_UVN_DESC_PREFETCH_INIT,
> +			    &reg_val, sizeof(reg_val));
> +	prefetch_init =
> +		FIELD_PREP(NBL_UVN_DESC_PREFETCH_INIT_NUM_MASK,
> +			   NBL_UVN_DESC_PREFETCH_NUM) |
> +		FIELD_PREP(NBL_UVN_DESC_PREFETCH_INIT_SEL_MASK,
> +			   (quirks & NBL_QUIRK_UVN_PREFETCH_ALIGN) ? 0 : 1);
> +	reg_val &= ~(NBL_UVN_DESC_PREFETCH_INIT_NUM_MASK |
> +		NBL_UVN_DESC_PREFETCH_INIT_SEL_MASK);
> +	reg_val |= prefetch_init;
> +	nbl_hw_wr_regs_lock(hw_mgt, NBL_UVN_DESC_PREFETCH_INIT,
> +			    &reg_val, sizeof(reg_val));
> +}

[ ... ]

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
> +
> +/*
> + * Setting driver status to false notifies firmware to clean up per-PF
> + * hardware state such as qinfo registers.
> + *
> + * Note: firmware does NOT automatically revert chip-wide registers
> + * configured in this init flow. Those chip-wide settings remain valid
> + * until chip reset or explicitly cleared by driver.
> + *
> + * For normal successful probe, driver will reset these chip-wide
> + * resources in subsequent deinit. For failed probe before
> + * driver_status is set to true, hardware may stay in partial
> + * programmed state. We validate all input parameters before touching
> + * hardware registers to avoid this scenario.
> + */
> +static void nbl_hw_deinit_module(struct nbl_hw_mgt *hw_mgt)
> +{
> +	nbl_hw_set_driver_status(hw_mgt, false);
> +	/* ensure registers written */
> +	nbl_flush_writes(hw_mgt);

[Severity: Medium]
Where does the reset promised by this comment happen?

    For normal successful probe, driver will reset these chip-wide
    resources in subsequent deinit.

nbl_hw_deinit_module() only clears the driver_status bit and flushes posted
writes.  Nothing here or elsewhere in the series reverts what
nbl_hw_init_module() programmed: the shaping DPORT/DVN_DPORT VALID bits, the
USTORE pkt_len and port drop threshold enables, the DSTORE XON/XOFF plus
FC_EN bits, the DSCH qid max and quanta, the DVN/UVN relaxed-ordering and
prefetch fields, and the host padpt flow-control values.

This also reads the opposite way from the commit message:

    Chip-wide registers programmed here are not automatically restored by
    firmware on deinit; they remain active until chip reset or explicitly
    overwritten.

Could the comment be corrected to match what the code does, so that the
datapath being left programmed and enabled after unbind is documented rather
than described as reset?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> index 7d0adc5bfb0aa..99711f18ddc3a 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> @@ -96,6 +120,202 @@ struct nbl_function_msix_map {

[ ... ]

> +/*  ---------  SHAPING  ---------  */
> +
> +/* Shaping rate unit: 1 = 1 Mbit/s.
> + * e.g. 100000 = 100 Gbit/s, 25000 = 25 Gbit/s.
> + */
> +#define NBL_LR_LEONIS_NET_BUCKET_DEPTH		9600

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> index 2c959832c32f4..f3c807836d24c 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> @@ -30,4 +30,25 @@ struct nbl_init_param {

[ ... ]

> +/*
> + * Firmware quirk word @ NBL_LEONIS_QUIRKS_OFFSET (0x140)
> + * Sentinel value: ~0U (0xFFFFFFFF) = firmware reports no active quirks
> + * BIT(0): NBL_QUIRK_NO_TOE – ABI defined, driver implementation pending
> + * BIT(1): NBL_QUIRK_UVN_PREFETCH_ALIGN – control UVN descriptor prefetch
> + * selection
> + */
> +#define NBL_QUIRK_NO_TOE		BIT(0)
> +#define NBL_QUIRK_UVN_PREFETCH_ALIGN	BIT(1)
> +
>  #endif

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914123429.56596-1-illusion.wang%40nebula-matrix.com
