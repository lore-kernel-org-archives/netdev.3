Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322305;
	b=s87oUcOYUCxPEPDOPGECSMQ202b5VINGzxii3zNlEebHRUlQ6u3RgYcBS/hIUTpEeNUQ
	 hs4GWbAMM9dNnzHySbA1YybU1bpGDGzKAPL+s0NKziEe6IrLgFJZiYPSnh2OOfv1RxJ/d
	 07k7wxk9Zjj45Q8zz6BljsTEWlgJckV+hmVSWdfUj0st2CnqZT7Ciu+4cX6638y72Gacv
	 +A4fb2Y1oLF4L6hY+rJKAqe09Tei6aPNpebgUBnIyBhI0Lq5H1Z4nkOB1/D7J4ACjVPy/
	 vv0fNju4ZoEuAnq7Fs0x/3BqrUAfQkFSlsH7mfx5IUIW3xHnh/7sAYD6hnRmjlnXsfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322305;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cwpX+dVpu5CaxbPP6Ln2m2mFL8thjfoLF0vm+KYF0Hs=;
	b=pyVpdJ48myq0PJnHGM4WNpPUBNvepmrJcf4+kULnSPf3zvWFknUn1LbV1wvO6l06Hb8Q
	 JX6gdgdLRSWDikM1htOTRHpxQIIWXteMXg7p25FT6+SfpFZQrfpjE547I9G++B/An+Gm6
	 FrdMfX++tQEoVduDH5w29ePC+3GrtACgEtIBf/alWpRMjiP1fWHcYWrjBUxV/YT+7Sfxc
	 /jfTnLQ9Owg1eSIv9sGiu/iv81Q5rW9D4cf8wQ8SEmCUEgrJEXjG131yLpbhi1OIhXnKY
	 Xjj6hM6npW1bHTLN029JK94z59UNSFwpiSBS98Hg+LaWnsn81UbrB4JyPoLSAPOCMTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=betAamhu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B4A606A321;
	Tue, 10 Nov 2026 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=betAamhu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E8E1F008A1;
	Tue, 10 Nov 2026 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322304;
	bh=cwpX+dVpu5CaxbPP6Ln2m2mFL8thjfoLF0vm+KYF0Hs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=betAamhuof+jQGiiMoYLmp7QLOMbPR8dMLfdi33tXl/MdFbrO9taJf3kPCXH1EUW+
	 J9pgL0qxm1tgpBAKvBwTEsDko1VGr5V+Jsh8Ghfo5L/tqrMdeXks/vs8C+A58Sd//S
	 5iqHxpzs+5ZxBUm1HLbx5Cxai8Zz7GyTCnL8aXYfj/8uvzBGY1gYD7hYMyUkSXgTHr
	 ah2JMDT1F4d96bMj5svCihDCQFefGDX2uV27lgHHQBijxzaH3mnTlzMWOsDrpes8h3
	 OREny81/ehHJaJaIRiaRP005+Ne010lYQdUP0I8AA8wt5VEXT+IsNBI1MYiwXr+vt0
	 ke5Rf/5Vi/QEQ==
Subject: Re: [PATCH v33 net-next 2/8] net/nebula-matrix: add common resource
 implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 andrew+netdev@lunn.ch, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Nov 2026 14:51:43 +0000
Message-ID: <179432230306.994134.15975682994342856597@kernel.org>
In-Reply-To: <20261106045631.2224-3-illusion.wang@nebula-matrix.com>
References: <20261106045631.2224-3-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This commit adds the k_pf_mask validator, nbl_res_init_pf_num(),
  but two comments about it are wrong.
- [Low] net/nebula-matrix: redundant single-implementation resource and
  hw ops tables

--

net/nebula-matrix: add common resource implementation

This commit adds a chip-agnostic resource layer to the Nebula Matrix
driver. On the control PF at probe time it validates the firmware PF
mask, builds per-PF BDF, Ethernet port and VSI tables, and provides
VSI/PF/Eth ID conversion helpers.

The resource layer is hooked into nbl_core_init() after the channel
layer.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> new file mode 100644
> index 0000000000000..dd8cf9e514960
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c

[ ... ]

> +static int nbl_res_init_pf_num(struct nbl_resource_mgt *res_mgt)
> +{

[ ... ]

> +	 * This is the only validation of the mask in the driver.  The channel
> +	 * layer reads the same raw register value to program the mailbox
> +	 * QINFO table and assumes the layout checked here, so it depends on
> +	 * this running first: resource init completes before the channel
> +	 * layer is set up.
> +	 */

[Severity: Low]
This isn't a bug, but is this ordering description accurate? In this same
patch, nbl_core_init() sets up the channel layer before the resource
layer:

nbl_core_init()
    nbl_hw_init_leonis()
    nbl_chan_init_common()
    nbl_res_init_leonis()
        nbl_res_start()
            nbl_res_init_pf_num()

The ordering that actually protects QINFO programming looks different.
The only user of the raw mask is nbl_chan_cfg_qinfo_map_table(). Later in
the series it is called from nbl_dev_setup_chan_qinfo(), inside
nbl_dev_init(), on the control PF only. That happens after
nbl_res_init_leonis(), but well after channel layer setup.

Would it be more accurate to say the validation has to run before QINFO is
first programmed, rather than before the channel layer is set up?

Also, the existing comment in nbl_chan_cfg_qinfo_map_table() in
nbl_channel.c still says:

	 * 0xfe/0xfc/0xf0.  Nothing enforces that here: the resource layer
	 * that validates the mask, and every caller of this op, arrive in
	 * later patches of this series.

This patch adds that resource layer. Should this comment be updated as
well?

The code behaves correctly as it stands, so this only concerns the
comments. Both comments are still unchanged at the end of the series.

[ ... ]

> @@ -0,0 +1,335 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2026 Nebula Matrix Limited.
> + */
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +#include <linux/bits.h>
> +#include "nbl_resource_leonis.h"
> +
> +static struct nbl_resource_ops res_ops = {
> +	.get_vsi_id = nbl_res_func_id_to_vsi_id,
> +	.get_eth_id = nbl_res_get_eth_id,
> +};
> +
> +static struct nbl_resource_mgt *
> +nbl_res_setup_res_mgt(struct nbl_common_info *common)
> +{
> +	struct nbl_resource_info *resource_info;
> +	struct nbl_resource_mgt *res_mgt;
> +	struct device *dev = common->dev;
> +
> +	res_mgt = devm_kzalloc(dev, sizeof(*res_mgt), GFP_KERNEL);
> +	if (!res_mgt)
> +		return ERR_PTR(-ENOMEM);
> +	res_mgt->common = common;
> +
> +	resource_info =
> +		devm_kzalloc(dev, sizeof(*resource_info), GFP_KERNEL);
> +	if (!resource_info)
> +		return ERR_PTR(-ENOMEM);
> +	res_mgt->resource_info = resource_info;
> +
> +	return res_mgt;
> +}
> +
> +static struct nbl_resource_ops_tbl *
> +nbl_res_setup_ops(struct device *dev, struct nbl_resource_mgt *res_mgt)
> +{
> +	struct nbl_resource_ops_tbl *res_ops_tbl;
> +
> +	res_ops_tbl = devm_kzalloc(dev, sizeof(*res_ops_tbl), GFP_KERNEL);
> +	if (!res_ops_tbl)
> +		return ERR_PTR(-ENOMEM);
> +	if (!res_ops.get_vsi_id || !res_ops.get_eth_id)
> +		return ERR_PTR(-EINVAL);
> +	res_ops_tbl->ops = &res_ops;
> +	res_ops_tbl->priv = res_mgt;
> +
> +	return res_ops_tbl;
> +}
> +
> +static int nbl_res_ctrl_dev_setup_eth_info(struct nbl_resource_mgt *res_mgt)
> +{
> +	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
> +	struct device *dev = res_mgt->common->dev;
> +	struct nbl_eth_info *eth_info;
> +	u32 eth_bitmap = 0;
> +	u32 eth_num = 0;
> +	u32 fw_port_num;
> +	int i;
> +
> +	eth_info = devm_kzalloc(dev, sizeof(*eth_info), GFP_KERNEL);
> +	if (!eth_info)
> +		return -ENOMEM;
> +
> +	res_mgt->resource_info->eth_info = eth_info;
> +
> +	fw_port_num = res_mgt->resource_info->board_info.eth_num;
> +
> +	hw_ops->get_fw_eth_map(res_mgt->hw_ops_tbl->priv, &eth_bitmap);
> +	if (eth_bitmap & ~((1 << NBL_MAX_ETHERNET) - 1)) {
> +		dev_err(dev, "FW reported invalid eth_bitmap 0x%x\n",
> +			eth_bitmap);
> +		return -EINVAL;
> +	}
> +	if (fw_port_num != hweight32(eth_bitmap)) {
> +		dev_err(dev, "FW inconsistency: port_num=%u, bitmap=0x%x\n",
> +			fw_port_num, eth_bitmap);
> +		return -EINVAL;
> +	}
> +	/*
> +	 * Firmware is ready before probe. Valid port counts are 1/2/4;
> +	 * 0 (invalid config), 3 (unsupported topology), and >4 (exceeds
> +	 * hardware max) are all rejected with -EINVAL.
> +	 */
> +	if (fw_port_num == 0 || fw_port_num == 3 ||
> +	    fw_port_num > NBL_MAX_ETHERNET) {
> +		dev_err(dev, "FW reports %u Ethernet ports, unsupported (valid: 1/2/4)\n",
> +			fw_port_num);
> +		return -EINVAL;
> +	}
> +	eth_info->eth_num = fw_port_num;
> +	/* Intentional design constraint: each PF maps to exactly one
> +	 * Ethernet port. This couples PF identity to port identity
> +	 * and is required by nbl_res_get_eth_id() which indexes
> +	 * eth_info->eth_id[] by relative PF id.
> +	 */
> +	if (res_mgt->common->max_pf != eth_info->eth_num) {
> +		dev_err(dev, "Invalid PF-to-port topology: max_pf=%u, eth_num=%u\n",
> +			res_mgt->common->max_pf, eth_info->eth_num);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Any subset of valid bitmap bits is accepted (e.g. 0/1, 0/2,
> +	 * 1/3, etc.).  Firmware only needs to report the correct count
> +	 * of active ports; no hard-coded fixed bit positions required.
> +	 * eth_id[] is filled in ascending bitmap-bit order, so the Nth
> +	 * relative PF owns the Nth logical port (max_pf == eth_num is
> +	 * enforced above).
> +	 */
> +	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
> +		if ((1 << i) & eth_bitmap) {
> +			eth_info->eth_id[eth_num] = i;
> +			eth_num++;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int nbl_res_ctrl_dev_sriov_info_init(struct nbl_resource_mgt *res_mgt)
> +{
> +	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
> +	struct nbl_hw_mgt *p = res_mgt->hw_ops_tbl->priv;
> +	struct nbl_common_info *common = res_mgt->common;
> +	struct nbl_sriov_info *sriov_info;
> +	struct device *dev = common->dev;
> +	u8 hw_bus = 0;
> +	u16 function;
> +	u16 func_id;
> +
> +	hw_ops->get_real_bus(p, &hw_bus);
> +	if (common->function + common->max_pf > NBL_MAX_PF) {
> +		dev_err(dev, "PF count exceeds available function space\n");
> +		return -EINVAL;
> +	}
> +	sriov_info = devm_kcalloc(dev, common->max_pf,
> +				  sizeof(*sriov_info), GFP_KERNEL);
> +	if (!sriov_info)
> +		return -ENOMEM;
> +
> +	res_mgt->resource_info->sriov_info = sriov_info;
> +	/*
> +	 * Real bus number of the control PF;
> +	 * the BDF table below is built from it.
> +	 */
> +	common->hw_bus = hw_bus;
> +
> +	for (func_id = 0; func_id < common->max_pf; func_id++) {
> +		sriov_info = res_mgt->resource_info->sriov_info + func_id;
> +		function = common->function + func_id;
> +		sriov_info->bdf = PCI_DEVID(common->hw_bus,
> +					    PCI_DEVFN(common->devid, function));
> +	}
> +
> +	return 0;
> +}
> +
> +static int nbl_res_ctrl_dev_vsi_info_init(struct nbl_resource_mgt *res_mgt)
> +{
> +	struct nbl_eth_info *eth_info = res_mgt->resource_info->eth_info;
> +	struct nbl_common_info *common = res_mgt->common;
> +	struct device *dev = common->dev;
> +	struct nbl_vsi_info *vsi_info;
> +	int i;
> +
> +	vsi_info = devm_kzalloc(dev, sizeof(*vsi_info), GFP_KERNEL);
> +	if (!vsi_info)
> +		return -ENOMEM;
> +
> +	res_mgt->resource_info->vsi_info = vsi_info;
> +	/*
> +	 * case 1 one port(1pf)
> +	 * pf0 (NBL_VSI_SERV_PF_DATA_TYPE) vsi is 0
> +	 * case 2 two port(2pf)
> +	 * pf0,pf1(NBL_VSI_SERV_PF_DATA_TYPE) vsi is 0,512
> +	 * case 3 four port(4pf)
> +	 * pf0,pf1,pf2,pf3(NBL_VSI_SERV_PF_DATA_TYPE) vsi is 0,256,512,768
> +	 */
> +
> +	vsi_info->num = eth_info->eth_num;
> +	/*
> +	 * eth_num can be 1/2/4:
> +	 * - 2/4 ports use dedicated gap constants;
> +	 * - 1 port falls back to NBL_DEFAULT_VSI_ID_GAP (1024).
> +	 * All three values produce valid base_id offsets.
> +	 */
> +	for (i = 0; i < vsi_info->num; i++) {
> +		vsi_info->serv_info[i][NBL_VSI_SERV_PF_DATA_TYPE].base_id =
> +			i * nbl_vsi_id_gap(vsi_info->num);
> +		vsi_info->serv_info[i][NBL_VSI_SERV_PF_DATA_TYPE].num = 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int nbl_res_init_pf_num(struct nbl_resource_mgt *res_mgt)
> +{
> +	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
> +	u32 exp_contiguous_mask = 0;
> +	u32 pf_mask = 0;
> +	u32 pf_num = 0;
> +	int i;
> +
> +	hw_ops->get_host_pf_mask(res_mgt->hw_ops_tbl->priv, &pf_mask);
> +
> +	/*
> +	 * k_pf_mask register rule:
> +	 * bit N == 0  -> PF#N enabled; bit N == 1 -> PF#N masked out.
> +	 * Hardware constraint: bit0 is PF0's mask bit; driver requires
> +	 * PF0 enabled as management PF, so bit0 must be clear.
> +	 * All-zero pf_mask means all PF0~PF7 are enabled, which is unsupported
> +	 * by the driver
> +	 *
> +	 * Product firmware constraint: only 3 valid configurations supported:
> +	 * 1 PF  (PF0 only): pf_num = 1, mask = 0xfe
> +	 * 2 PFs (PF0,PF1):  pf_num = 2, mask = 0xfc
> +	 * 4 PFs (PF0~PF3): pf_num = 4, mask = 0xf0
> +	 * No other PF count or sparse/non-contiguous PF layout is allowed.
> +	 *
> +	 * This is the only validation of the mask in the driver.  The channel
> +	 * layer reads the same raw register value to program the mailbox
> +	 * QINFO table and assumes the layout checked here, so it depends on
> +	 * this running first: resource init completes before the channel
> +	 * layer is set up.
> +	 */
> +	for (i = 0; i < NBL_MAX_PF; i++) {
> +		if (!(pf_mask & (1 << i)))
> +			pf_num++;
> +	}
> +
> +	/*
> +	 * Sanity check: enabled PFs must be contiguous starting from PF0.
> +	 * Current resource framework uses relative PF id, sparse PF layout
> +	 * will cause mismatch between resource layer and hardware func_id.
> +	 */
> +	for (i = 0; i < pf_num; i++)
> +		exp_contiguous_mask |= BIT(i);
> +	if ((pf_mask & exp_contiguous_mask) != 0) {
> +		dev_err(res_mgt->common->dev,
> +			"pf_mask 0x%08x: non-contiguous enabled PF, unsupported\n",
> +			pf_mask);
> +		return -EINVAL;
> +	}
> +
> +	/* Only allow product-specified PF count: 1 / 2 / 4 */
> +	if (pf_num != 1 && pf_num != 2 && pf_num != 4) {
> +		dev_err(res_mgt->common->dev,
> +			"Invalid pf_num=%u (mask=0x%08x), only 1/2/4 PFs supported\n",
> +			pf_num, pf_mask);
> +		return -EINVAL;
> +	}
> +
> +	res_mgt->common->max_pf = pf_num;
> +
> +	return 0;
> +}
> +
> +static void nbl_res_init_board_info(struct nbl_resource_mgt *res_mgt)
> +{
> +	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
> +
> +	hw_ops->get_board_info(res_mgt->hw_ops_tbl->priv,
> +			       &res_mgt->resource_info->board_info);
> +}
> +
> +static int nbl_res_start(struct nbl_resource_mgt *res_mgt)
> +{
> +	struct nbl_common_info *common = res_mgt->common;
> +	int ret = 0;
> +
> +	if (common->has_ctrl) {
> +		nbl_res_init_board_info(res_mgt);
> +
> +		ret = nbl_res_init_pf_num(res_mgt);
> +		if (ret)
> +			return ret;
> +
> +		ret = nbl_res_ctrl_dev_sriov_info_init(res_mgt);
> +		if (ret)
> +			return ret;
> +
> +		ret = nbl_res_ctrl_dev_setup_eth_info(res_mgt);
> +		if (ret)
> +			return ret;
> +
> +		ret = nbl_res_ctrl_dev_vsi_info_init(res_mgt);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int nbl_res_init_leonis(struct nbl_adapter *adap)
> +{
> +	struct nbl_channel_ops_tbl *chan_ops_tbl = adap->intf.channel_ops_tbl;
> +	struct nbl_hw_ops_tbl *hw_ops_tbl = adap->intf.hw_ops_tbl;
> +	struct nbl_common_info *common = &adap->common;
> +	struct nbl_resource_ops_tbl *res_ops_tbl;
> +	struct device *dev = &adap->pdev->dev;
> +	struct nbl_resource_mgt *res_mgt;
> +	int ret;
> +
> +	res_mgt = nbl_res_setup_res_mgt(common);
> +	if (IS_ERR(res_mgt)) {
> +		ret = PTR_ERR(res_mgt);
> +		return ret;
> +	}
> +	res_mgt->chan_ops_tbl = chan_ops_tbl;
> +	res_mgt->hw_ops_tbl = hw_ops_tbl;
> +
> +	ret = nbl_res_start(res_mgt);
> +	if (ret)
> +		return ret;
> +
> +	res_ops_tbl = nbl_res_setup_ops(dev, res_mgt);
> +	if (IS_ERR(res_ops_tbl)) {
> +		ret = PTR_ERR(res_ops_tbl);
> +		return ret;
> +	}
> +	adap->intf.resource_ops_tbl = res_ops_tbl;
> +	adap->core.res_mgt = res_mgt;
> +
> +	return 0;
> +}
> +
> +void nbl_res_remove_leonis(struct nbl_adapter *adap)
> +{
> +	/*
> +	 * No resource release here because all memory uses devm managed
> +	 * allocation
> +	 */
> +}

[Severity: Low]
Does the resource layer need its own ops table? struct
nbl_resource_ops and struct nbl_resource_ops_tbl have exactly one
implementation, res_ops in nbl_resource_leonis.c, and that is still the
only one at the end of the series.

nbl_res_setup_ops() devm-allocates a wrapper whose only job is to hold
&res_ops and res_mgt. It then checks get_vsi_id and get_eth_id for
NULL, but both are statically initialized a few lines above in the same
file, so the -EINVAL branch can never be taken.

The same applies to struct nbl_hw_ops, which this patch extends with
flush_write, get_real_bus, get_fw_eth_map and get_board_info:

  - hw_ops in nbl_hw_leonis.c is its only implementation.
  - nbl_hw_setup_ops() adds more NULL checks on static callbacks.
  - nbl_resource_leonis.c calls the leonis hardware helpers indirectly
    through res_mgt->hw_ops_tbl->ops and ->priv instead of directly.
  - res_mgt->chan_ops_tbl is stored but never used in this patch.

On v22 Jakub asked for abstractions with a single implementation to be
removed until a second implementation actually exists:

https://lore.kernel.org/r/20260730182956.5cbe613a@kernel.org

The dispatch layer later in the series does have two real backends.
It makes local calls on the control PF and mailbox RPCs on the other
PFs, so that indirection looks justified.

Could the series keep only that layer? The dispatch code would call
nbl_res_func_id_to_vsi_id() and nbl_res_get_eth_id() directly, and the
resource code would call the leonis hw helpers directly. That would
drop nbl_resource_ops_tbl, nbl_hw_ops_tbl and the setup_ops() NULL
checks.

If a second chip that needs these tables is planned, could the commit
message say so?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106045631.2224-1-illusion.wang%40nebula-matrix.com
