Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A654FB9C3;
	Thu,  3 Sep 2026 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455924; cv=none; b=nN2Q2hvKFXUb28CGavjRteQ3z1PfFfk+DSkCNVKwawheT8/jRzL3tXPXONk5sMIOLjpg1c8L/7XXbyY+Bxht0knEMOczTxiRzbsDxF4Gs4nFik0Qktk1IdY/gxKpo+BRVqqQJlQTvtI1TCFWlCesALGK4FB3sP0fJzZtW0K/quQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455924; c=relaxed/simple;
	bh=n4yqb12u2SmRLRirXNE38v9y9aZ1BO4pYNjMthMr3pk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d/hoL4ttQLew2fjqw9e+auMrFNuRF8hu42RNESJvaYVJAxUAs0Sw+abmWZ/pytGshdUg9cK7LnxphHexEbGzRgzzspG/of3RlY6c28OC4E25rRBqa1JE1wIMc5Sn9q7rLM6q3usLjA9tDM4l6HAg4DpDI97j+Vdlidmx8dSUjM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEIZYoer; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEIZYoer"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D0F1F000E9;
	Thu,  3 Sep 2026 17:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455922;
	bh=9y9AltG5MnIXdhGBTrde0ATNL2ExMf3Hzybqkth0dUk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SEIZYoerQMxYk11PM/bqJQltKIEz3f1Gpp++Jjot9UbMkinXsX5u3PY7Nq4hgKkCR
	 Jwjole3/wiROu1/ID1X7jMFJGowB1D0uPUQflavgS90jPW6YNriPUjG8zA9SihH/nL
	 wMnQnNSuE6IUfmQbZDYl1h+eihRC3yKKoxgT549+SNeuiUtmmAHFQmPdH7LpFyBW0G
	 rvvOPKugHBivW8hrDWQcNC1b56OXL5OqBufptZLPVFhKVFtQj5nJQf/QrJO5S2RrDD
	 U6OIwPX5wpwFe37j1wWchwOnwqC68E/81YUN+0C5xFhC67sxlIryYCoC1XZLvGOWPs
	 XUGl8ZtfVIRxA==
Subject: Re: [v26,net-next,06/10] net/nebula-matrix: add chip-wide hardware
 init/deinit implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 17:18:40 +0000
Message-ID: <178845592064.3394541.11817046722626766650@kernel.org>
In-Reply-To: <20260831021408.2325-7-illusion.wang@nebula-matrix.com>
References: <20260831021408.2325-7-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 7

- [Medium] nbl_dp_init() programs DPED, UPED, shaping and DSCH into
  hardware before nbl_ustore_init() validates the firmware-reported…
- [Medium] Within nbl_uvn_init() the driver read-modify-writes
  NBL_UVN_DIF_REQ_RO_FLAG and NBL_UVN_QUEUE_ERR_MASK to preserve…
- [Low] hw_ops->init_module / hw_ops->deinit_module (and the resource
  wrappers nbl_res_chip_init_module / nbl_res_chip_deinit_module)…
- [Low] New firmware quirk ABI is described inconsistently.
- [Low] nbl_hw_deinit_module() clears the driver_status bit and issues a
  dummy-register read, with no acknowledgement or completion polling for…
- [Low] New register definitions mix conventions and pollute the global
  macro namespace: NBL_SHAPING_DPORT_ADDR 0x504700 /…
- [Low] nbl_uvn_init() is declared `static void` yet its last statement
  is `return nbl_hw_wr_regs_lock(hw_mgt, NBL_UVN_DESC_PREFETCH_INIT,…
- [Low] The shaping register block documents two incompatible units for a
  CIR value of 1: nbl_hw_leonis.h:264 says "cir 1, bandwidth 1kB/s in…
- [Low] The only documentation of the UQM que_type register added by this
  patch contradicts itself: `/* bit 0: bp mode , bit1: drop mode, resv…

--

net/nebula-matrix: add chip-wide hardware init/deinit implementation

This adds the Leonis chip-wide init/deinit path, programming the DP
sub-modules (dped, uped, dsch, ustore, dstore, dvn, uvn, uqm), per-port
shaping and host padpt flow control, plus the driver_status flag consumed by
firmware.  It also registers hw_ops.init_module/deinit_module and the matching
resource_ops entry points, and introduces a firmware quirk word read from the
mailbox.  A few questions below.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c
> new file mode 100644
> index 000000000000..e1ba7b7e36ca
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c
> @@ -0,0 +1,23 @@
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
> +
> +	hw_ops->deinit_module(res_mgt->hw_ops_tbl->priv);
> +}
> +
> +int nbl_res_chip_init_module(struct nbl_resource_mgt *res_mgt)
> +{
> +	u8 eth_speed = res_mgt->resource_info->board_info.eth_speed;
> +	u8 eth_num = res_mgt->resource_info->board_info.eth_num;
> +	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
> +	struct nbl_hw_mgt *p = res_mgt->hw_ops_tbl->priv;
> +
> +	return hw_ops->init_module(p, eth_speed, eth_num);
> +}

[Severity: Low]
This isn't a bug, but would it be worth adding the has_ctrl check here for
consistency with the sibling resource ops?

Every other resource op added so far starts with:

	if (!common->has_ctrl)
		return -EINVAL;

(see nbl_res_intr_cfg_msix_map() and friends in nbl_interrupt.c and the
helpers in nbl_resource.c), while nbl_res_chip_init_module() and
nbl_res_chip_deinit_module() go straight into chip-global register
programming.

The registers touched by that path are well outside the mapping a non-control
function gets, for example NBL_DRIVER_STATUS_REG 0x1300444 and the dummy
register used by nbl_flush_writes() at 0x1300904, while nbl_hw_init_leonis()
only ioremaps NBL_REG_NET_ONLY_LEN when has_ctrl is not set, and
nbl_hw_wr32()/nbl_hw_rd32() do not bound-check against hw_size.

I checked and this is not reachable: nbl_dev_init() only calls
nbl_dev_setup_ctrl_dev() under if (common->has_ctrl), and
disp_ops->init_module/deinit_module are only assigned for
NBL_DISP_CTRL_LVL_MGT, which is only set when common->has_ctrl.  So this is
purely a defense-in-depth remark, matching what the commit message already
says about the caller guarantee.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index fd6bc992fa0f..7f2626db731a 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> @@ -115,6 +115,548 @@ static void nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt, u32 *eth_map)
>  	*eth_map = FIELD_GET(NBL_FW_BOARD_DW6_ETH_BITMAP_MASK, data);
>  }
>  
> +static u32 nbl_hw_get_quirks(struct nbl_hw_mgt *hw_mgt)
> +{
> +	u32 quirks = 0;
> +
> +	nbl_hw_read_mbx_regs(hw_mgt, NBL_LEONIS_QUIRKS_OFFSET, &quirks,
> +			     sizeof(u32));
> +
> +	if (quirks == ~0u)
> +		return 0;
> +
> +	return quirks;
> +}

[Severity: Low]
The quirk interface is described in three places and the three descriptions
do not agree.

The commit message says:

    NBL_QUIRK_UVN_PREFETCH_ALIGN (BIT(1)), BIT(0) is reserved for future use.

but nbl_include.h defines BIT(0) as a named quirk:

	#define NBL_QUIRKS_NO_TOE		BIT(0)
	#define NBL_QUIRK_UVN_PREFETCH_ALIGN	BIT(1)

with the comment "ABI defined, driver implementation pending".
NBL_QUIRKS_NO_TOE has no user anywhere in the driver at the end of the
series.  Should the commit message say BIT(0) is defined but unused, or
should the define be dropped until it is used?

The two prefixes also differ (NBL_QUIRKS_NO_TOE versus
NBL_QUIRK_UVN_PREFETCH_ALIGN), and the explanatory comment in nbl_uvn_init()
names a macro that does not exist in the tree:

	 * Default is sel=1, unless NBL_QUIRKS_UVN_PREFETCH_ALIGN is set,

while the code a few lines below uses NBL_QUIRK_UVN_PREFETCH_ALIGN.

One more question on the sentinel above: only ~0u is treated as "no quirks",
so on firmware predating this ABI, any other stale non-zero content at
mailbox offset 0x140 is taken as live quirk bits and can flip
NBL_UVN_DESC_PREFETCH_INIT_SEL.  Is there a version or magic word that could
gate the read instead?  I cannot inspect firmware images, so this part is
speculative.

[ ... ]

> +static int nbl_shaping_eth_init(struct nbl_hw_mgt *hw_mgt, u8 eth_id, u8 speed)
> +{
> +	struct nbl_shaping_dvn_dport_u dvn_dport = { 0 };
> +	struct nbl_shaping_dport_u dport = { 0 };
> +	u32 rate, half_rate;
> +	u32 depth;
> +	u64 low_val, high_val;
> +
> +	switch (speed) {
> +	case NBL_FW_PORT_SPEED_100G:
> +		rate = 100000;
> +		break;

[ ... ]

> +	/* 2. write config words (valid=0, safe) */
> +	low_val = FIELD_PREP(DPORT_CIR_MASK, rate) |
> +		  FIELD_PREP(DPORT_PIR_MASK, rate) |

[Severity: Low]
This isn't a bug, but which unit do these fields actually use?  The header
documents two incompatible ones right above the shaping defines:

	/* cir 1, bandwidth 1kB/s in protol environment */
	/* cir 1, bandwidth 1Mb/s */

The code here writes 10000/25000/50000/100000 for 10/25/50/100 Gbit/s, which
matches only the 1 Mb/s reading; under the 1 kB/s reading a 100G port would
be shaped to roughly 0.8 Gbit/s.  Could the stale comment be deleted or
qualified?

[ ... ]

> +static int nbl_ustore_init(struct nbl_hw_mgt *hw_mgt, u8 eth_num)
> +{
> +	u32 eth_bitmap = 0;
> +	u32 drop_th = 0;
> +	u32 pkt_len = 0;
> +	int i;
> +
> +	if (eth_num != 1 && eth_num != 2 && eth_num != 4)
> +		return -EINVAL;

[Severity: Medium]
Is it intended that eth_num is validated only here, after several sub-modules
have already been committed to the chip?

nbl_dp_init() programs DPED, UPED, shaping and DSCH before reaching this
check:

	nbl_dped_init(hw_mgt);
	nbl_uped_init(hw_mgt);
	ret = nbl_shaping_init(hw_mgt, speed);
	if (ret)
		return ret;
	nbl_dsch_qid_max_init(hw_mgt);
	ret = nbl_ustore_init(hw_mgt, eth_num);
	if (ret)
		return ret;

eth_num comes straight from firmware.  nbl_hw_get_board_info() does:

	board_info->eth_num = FIELD_GET(NBL_FW_BOARD_DW3_PORT_NUM_MASK, data);

and nbl_res_init_board_info() does not validate it, so a board reporting 0, 3
or 8 (or a mailbox read that returns early on its own bounds check, leaving
eth_num 0) fails here with the shaping DPORT/DVN_DPORT VALID bits already set,
DSCH quanta and QID_MAX applied, DPED L4 checksum enabled and the UPED
profiles edited.

There is also no unwind, and nbl_hw_init_module() returns the error before
nbl_hw_set_driver_status(hw_mgt, true), so the firmware cleanup the commit
message relies on ("FW releases all chip hardware state automatically") is
never armed for a failed init, and nbl_hw_deinit_module() only clears a bit
that was never set.

Could eth_num be validated before the first register write?

[ ... ]

> +static void nbl_dvn_descreq_num_cfg(struct nbl_hw_mgt *hw_mgt, u8 descreq_num)
> +{
> +	u8 split_ring_num = (descreq_num >> 3) & 0x1;
> +	u8 ring_num = descreq_num & 0x7;
> +	u32 num_cfg = 0;
> +
> +	num_cfg = FIELD_PREP(NBL_DVN_DESCREQ_NUM_CFG_AVRING_DESREQ_NUM_CFG_MASK,
> +			     split_ring_num) |
> +		  FIELD_PREP(NBL_DVN_DESCREQ_NUM_CFG_PACKED_L1_NUM_MASK,
> +			     ring_num);
> +
> +	nbl_hw_wr_regs_lock(hw_mgt, NBL_DVN_DESCREQ_NUM_CFG, &num_cfg,
> +			    sizeof(num_cfg));
> +}

[ ... ]

> +static void nbl_uvn_init(struct nbl_hw_mgt *hw_mgt)
> +{
> +	u16 wr_timeout = NBL_UVN_DESC_WR_TIMEOUT_VAL;
> +	u32 timeout = NBL_UVN_DESC_RD_WAIT_TICKS;
> +	u32 desc_wr_timeout = 0;
> +	u32 prefetch_init = 0;
> +	bool ro_enabled;
> +	u32 flag = 0;
> +	u32 mask = 0;
> +	u32 quirks;
> +
> +	spin_lock(&hw_mgt->reg_lock);
> +	nbl_hw_wr32(hw_mgt, NBL_UVN_DESC_RD_WAIT, timeout);
> +	desc_wr_timeout =
> +		FIELD_PREP(NBL_UVN_DESC_WR_TIMEOUT_NUM_MASK, wr_timeout);
> +	nbl_hw_wr_regs(hw_mgt, NBL_UVN_DESC_WR_TIMEOUT, &desc_wr_timeout,
> +		       sizeof(desc_wr_timeout));

[Severity: Medium]
Does this write clear NBL_UVN_DESC_WR_TIMEOUT_MASK_MASK?  The patch itself
declares that bit as a live field of the same register:

	#define NBL_UVN_DESC_WR_TIMEOUT_NUM_MASK GENMASK(14, 0)
	#define NBL_UVN_DESC_WR_TIMEOUT_MASK_MASK BIT(15)

but desc_wr_timeout starts at 0 and only NUM is filled in, so BIT(15) is
written back as 0 whatever firmware programmed.  A few lines below, this same
function read-modify-writes NBL_UVN_DIF_REQ_RO_FLAG and
NBL_UVN_QUEUE_ERR_MASK precisely to preserve the other bits, so the
inconsistency is internal to the function.

The same pattern applies to two other registers in this patch:

  - NBL_UVN_DESC_PREFETCH_INIT is written from scratch with only NUM[7:0] and
    SEL[16]
  - NBL_DVN_DESCREQ_NUM_CFG in nbl_dvn_descreq_num_cfg() above is written
    with only BIT(0) and GENMASK(6, 4)

Since deinit relies entirely on firmware cleanup, whatever gets zeroed here
stays zeroed for the life of the chip.  Should these be read-modify-writes
too?  I could not find the reset defaults of those bits documented in the
tree, so this is based on the field definitions the patch adds.

> +	ro_enabled = pcie_relaxed_ordering_enabled(hw_mgt->common->pdev);

[ ... ]

> +	spin_unlock(&hw_mgt->reg_lock);
> +	quirks = nbl_hw_get_quirks(hw_mgt);
> +	/*
> +	 * sel=0: use configured num; sel=1: use internal calc (max 32)
> +	 * Default is sel=1, unless NBL_QUIRKS_UVN_PREFETCH_ALIGN is set,
> +	 * in which case override to sel=0.
> +	 */
> +	prefetch_init =
> +		FIELD_PREP(NBL_UVN_DESC_PREFETCH_INIT_NUM_MASK,
> +			   NBL_UVN_DESC_PREFETCH_NUM) |
> +		FIELD_PREP(NBL_UVN_DESC_PREFETCH_INIT_SEL_MASK,
> +			   (quirks & NBL_QUIRK_UVN_PREFETCH_ALIGN) ? 0 : 1);
> +
> +	return nbl_hw_wr_regs_lock(hw_mgt, NBL_UVN_DESC_PREFETCH_INIT,
> +				   &prefetch_init, sizeof(prefetch_init));
> +}

[Severity: Low]
Was this return intended?  nbl_uvn_init() is declared static void and
nbl_hw_wr_regs_lock() also returns void, so this is a return with an
expression in a void function, which ISO C forbids and -Wpedantic
diagnoses.  Every other sub-init helper in this patch calls the write helper
as a plain statement, and nbl_dp_init() calls nbl_uvn_init() as a statement
too, so nothing is propagated.

While on that topic, only nbl_shaping_init() and nbl_ustore_init() can report
failure to the int-returning nbl_hw_init_module(); the rest are void.  Is the
mixed failure model deliberate?

[ ... ]

> +	for (i = 0; i < NBL_UQM_DPORT_DROP_DEPTH; i++)
> +		nbl_hw_wr_regs(hw_mgt,
> +			       NBL_UQM_DPORT_DROP_CNT + (sizeof(cnt) * i), &cnt,
> +			       sizeof(cnt));
> +	/* bit 0: bp mode , bit1: drop mode, resv bit1-31 */
> +	nbl_hw_wr_regs(hw_mgt, NBL_UQM_QUE_TYPE, &que_type, sizeof(que_type));

[Severity: Low]
This comment gives bit1 two meanings: "drop mode" and part of the reserved
range.  Should the reserved range read bit2-31?

[ ... ]

> +/*
> + * This design is intentional. Setting driver status to false is the
> + * official teardown mechanism: it notifies firmware to perform full
> + * cleanup of all per-PF hardware state, including qinfo registers.
> + * An inverse helper would duplicate work that the firmware already
> + * does, and would add error-path complexity for no benefit. We keep
> + * the deinit path minimal and rely on firmware cleanup for correctness,
> + * including abnormal hardware reset scenarios.
> + */
> +static void nbl_hw_deinit_module(struct nbl_hw_mgt *hw_mgt)
> +{
> +	nbl_hw_set_driver_status(hw_mgt, false);
> +	/* ensure registers written */
> +	nbl_flush_writes(hw_mgt);
> +}

[Severity: Low]
This isn't a bug, but is there any way for the driver to observe that the
firmware cleanup completed?  nbl_flush_writes() only reads the dummy register
to push the posted write out, it is not an acknowledgement, and everything
init armed stays set on return: shaper VALID bits, DSCH PSHA, USTORE
port-drop, DSTORE flow control, DVN/UVN RO and error-mask bits, DPED L4
checksum.

I could not construct a failure path from this in the current series.  The
only DMA engine set up so far is the mailbox channel, and
nbl_chan_teardown_queue() calls nbl_chan_stop_queue(), which stops the
queues in hardware:

	hw_ops->stop_mailbox_rxq(chan_mgt->hw_ops_tbl->priv);
	hw_ops->stop_mailbox_txq(chan_mgt->hw_ops_tbl->priv);

before the buffers are released, and nbl_dev_remove() runs the ctrl-dev
teardown before the common-dev teardown.  So this is only a remark: a defined
"cleanup complete" indication with a timeout would make the firmware contract
verifiable from the driver side.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> index fed2fb16bff8..95d8a12bdcb5 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> @@ -110,6 +124,216 @@ struct nbl_function_msix_map {
>  	u32 data[NBL_FUNC_MSIX_MAP_DWLEN];
>  };
>  

[ ... ]

> +#define NBL_UVN_DESC_WR_TIMEOUT_NUM_MASK GENMASK(14, 0)
> +#define NBL_UVN_DESC_WR_TIMEOUT_MASK_MASK BIT(15)

[ ... ]

> +/*  ---------  SHAPING  ---------  */
> +
> +/* cir 1, bandwidth 1kB/s in protol environment */
> +/* cir 1, bandwidth 1Mb/s */
> +#define NBL_LR_LEONIS_NET_BUCKET_DEPTH		9600
> +#define NBL_SHAPING_DPORT_ADDR 0x504700
> +#define NBL_SHAPING_DPORT_DWLEN 4
> +#define NBL_SHAPING_DPORT_REG(r) \
> +	(NBL_SHAPING_DPORT_ADDR + (NBL_SHAPING_DPORT_DWLEN * 4) * (r))
> +#define NBL_SHAPING_DVN_DPORT_ADDR 0x504750

[ ... ]

> +#define DPORT_VALID_MASK (0x1ULL << 0)
> +#define DPORT_DEPTH_MASK (0x7FFFFULL << 1)	// [19:1]
> +#define DPORT_CIR_MASK (0x7FFFFULL << 20)	// [38:20]
> +#define DPORT_PIR_MASK (0x7FFFFULL << 39)	// [57:39]
> +#define DPORT_CBS_MASK_LOW (0x3FULL << 58)		// [63:58]
> +#define DPORT_CBS_MASK_HIGH (0x7FFFULL << (0)) // [78:64] -> high[14:0]
> +#define DPORT_PBS_MASK (0x1FFFFFULL << (79 - 64)) // [99:79] -> high[35:15]

[Severity: Low]
This isn't a bug, but the new register defines mix several conventions.

The C99 // comments above are a checkpatch error, and the masks are
hand-rolled shifts where the rest of this header uses GENMASK()/
GENMASK_ULL().  The DPORT_* and DEFAULT_DVN_* macros also lack the NBL_
prefix used by everything else, so they land in the global macro namespace.

Several of the new addresses are spelled out numerically even though the
matching base already exists in this header:

	NBL_SHAPING_DPORT_ADDR     0x504700
	NBL_SHAPING_DVN_DPORT_ADDR 0x504750
	NBL_SHAPING_NET_ADDR       0x505800

all sit inside NBL_DP_SHAPING_BASE (0x00504000), which is now left with no
user at all in the tree.  Same for NBL_DSCH_PSHA_EN_ADDR 0x404314
(NBL_DP_DSCH_BASE + 0x314), NBL_DSTORE_D_DPORT_FC_TH_ADDR 0x704600 and
NBL_DSTORE_PORT_DROP_TH_ADDR 0x704150 (NBL_DP_DSTORE_BASE + 0x600 / + 0x150),
and NBL_DPED_L4_CK_CMD_40_ADDR 0x75c338 (NBL_DP_DPED_BASE + 0x338).

Finally, a number of the added defines have no user at the end of the series,
for example the NBL_DPED_L4_CK_CMD_40_* field masks other than EN,
NBL_DSTORE_PORT_DROP_DISC_TH_MASK, NBL_UVN_DESC_WR_TIMEOUT_MASK_MASK and the
_DEPTH/_WIDTH/_DWLEN triplets.  Could the unused ones be dropped until they
are needed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831021408.2325-1-illusion.wang%40nebula-matrix.com
