Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F874F798D;
	Thu,  3 Sep 2026 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455921; cv=none; b=S1npVLuyOPTRBvaB11UcIXT2tws7rn3hkyTeS8PzkQElS5rpu1CeV/1g1OgOxGEzoepYPP5LRpU3msvcuTB1TujQdZ+EDc7vYu7kGHHA1QGoz5VJCtAGKgb/hrIUtpuajisPa3EgdtmXGnZ7MW588+IlJlLsiCkJ/p+SZq5ZQQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455921; c=relaxed/simple;
	bh=Crk/5TifzmN1stfZp9E3ID3itI66S5PvzceleYce+4U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B/rqFc0CRSmqz1QLnKPeBcDF1fxAESRRz1twKIqicHBO9/usQDko+7swzXr8oZ6eXdtUjTzcpP0RG1ZXbmIkgEk5DArLnI13S8eo9M305vq5Rm9e1FpmDckzHIQF7MxwW8UqLvhDdHTY+haPuQyjBgaycHhMOJ/yvqjGnb+gyEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBShT6IR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBShT6IR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E659D1F00A3D;
	Thu,  3 Sep 2026 17:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455918;
	bh=n17bE9u5TzzmrZQ7nDaW9yGufaf+IFDdVTwqtixbGWY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HBShT6IRGDeE2yqTrcblHfa24ZJL0CzbuAblUDQ1U2FrvUH+FfaVkA8XAHo5S3wl+
	 J1l2EiOhEfQARI44Q1LIcvO2HqrCjiUlxiGJAuiwz7w+8xo9PUBPCPnQQYRgvEO8nF
	 vR/ky6lSOs8NL5+ygy0FbUHc+Vt8OwjW2QHSl+ZAzEQ/uRd5C97TwbnWCt4FGD1zJf
	 q0zKV+VkTRLziy66eDQypmtCAKrqLbllFMfVuR/Ghoh2zEV3dI0D4PBeGC6xDBhLsO
	 n9OXFJoplOPK1HlrIb8U5mvEGjyQKvqd3nSL6uxyaNk5XuOlaoDYzjJolqE+g1CSUa
	 ndW63VX6LOwAQ==
Subject: Re: [v26,net-next,04/10] net/nebula-matrix: add common resource
 implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 17:18:37 +0000
Message-ID: <178845591752.3394541.1488499474047337134@kernel.org>
In-Reply-To: <20260831021408.2325-5-illusion.wang@nebula-matrix.com>
References: <20260831021408.2325-5-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 4

- [Medium] New, undisclosed fatal probe conditions derived purely from
  firmware/register content.
- [Medium] The kernel-doc contract of nbl_hw_ops::get_host_pf_mask in
  nbl_include/nbl_def_hw.h states 'PF0 cannot be masked, bit0 is…
- [Low] The commit message and a new code comment describe consumers and
  an execution-order guarantee that do not exist at this commit, and the…
- [Low] nbl_include/nbl_def_channel.h newly uses static_assert() but is
  not self-contained: its only include is <linux/types.h> (which pulls…
- [Low] The kernel-doc block for nbl_hw_ops::get_host_pf_mask documents
  '@priv: hw ops private context', but the declared first parameter is…
- [Low] Comment/implementation mismatch in
  nbl_res_ctrl_dev_setup_eth_info(): the comment states 'Code accepts…

--

net/nebula-matrix: add common resource implementation

This patch adds the common resource layer for the nbl driver, with helpers
converting between vsi_id, func_id, eth_id and pf_id, plus new hw ops to
read the board info, the FW eth bitmap and the real bus number.
nbl_res_init_leonis() is now called from nbl_core_init() and initializes
the VSI/Eth/PF data only for control devices.

A few questions below about the new firmware topology checks, the ops
documentation and some of the new comments.

> nbl_res_start() initializes VSI/Eth/PF data structures only for control
> devices (`common->has_ctrl == true`). Framework dispatch layer ensures
> resource mapping APIs such as nbl_res_func_id_to_vsi_id() are only invoked
> on control devices.

[Severity: Low]
Which dispatch layer is meant here?  At this commit nbl_core_init() returns
right after nbl_res_init_leonis():

	ret = nbl_res_init_leonis(adapter);
	if (ret)
		goto res_init_fail;
	return adapter;

adap->intf.resource_ops_tbl is published but has no consumer yet, and
nbl_res_vsi_id_to_pf_id() and nbl_res_pf_dev_vsi_type_to_hw_vsi_type() are
non-static with no users outside nbl_resource.c.

Could the commit message describe the guarantee that exists at this point in
the series, i.e. the has_ctrl checks inside the helpers themselves?

The same concern applies to the ordering comment in
nbl_res_ctrl_dev_sriov_info_init(), see below.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> new file mode 100644
> index 000000000000..a719cc8fbf8a
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> @@ -0,0 +1,334 @@

[ ... ]

> +	eth_info->eth_num = fw_port_num;
> +	/* Intentional design constraint: each PF maps to exactly one
> +	 * Ethernet port. This couples PF identity to port identity
> +	 * and is required by nbl_res_get_eth_id() which indexes
> +	 * eth_info->eth_id[] by relative PF id.
> +	 */
> +	if (res_mgt->resource_info->max_pf != eth_info->eth_num) {
> +		dev_err(dev, "Invalid PF-to-port topology: max_pf=%u, eth_num=%u\n",
> +			res_mgt->resource_info->max_pf, eth_info->eth_num);
> +		return -EINVAL;
> +	}

[Severity: Medium]
Is the equality of these two values actually guaranteed by the hardware?

max_pf comes from the k_pf_mask register via nbl_res_init_pf_num(), while
eth_num comes from NBL_FW_BOARD_DW3 port_num via nbl_hw_get_board_info().
The two quantities are reported independently by firmware, and the only
statement that they must match is this comment.

The consequence is a probe failure: nbl_probe() -> nbl_core_init() ->
nbl_res_init_leonis() -> nbl_res_start() -> nbl_res_ctrl_dev_setup_eth_info()
returns -EINVAL, and nbl_core_init() turns that into ERR_PTR(ret), so the
control PF does not bind at all.

Would it make sense to document this firmware contract in nbl_def_hw.h next
to get_host_pf_mask/get_board_info, and to mention in the changelog that this
patch introduces new fatal probe conditions?

> +
> +	/*
> +	 * Original comment said dual-port board eth_id fixed to 0,2;
> +	 * Code accepts any contiguous valid bitmap bits (0/1 or 0/2 etc).
> +	 * Firmware only needs to report correct count of active ports,
> +	 * no hard-coded fixed bit positions required.
> +	 */
> +	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
> +		if ((1 << i) & eth_bitmap) {
> +			set_bit(i, eth_info->eth_bitmap);
> +			eth_info->eth_id[eth_num] = i;
> +			eth_info->logic_eth_id[i] = eth_num;
> +			eth_num++;
> +		}
> +	}

[Severity: Low]
This isn't a bug, but the word "contiguous" in the comment does not match the
loop, and the example given (0/2) is not contiguous either.

The loop imposes no contiguity rule: any subset of bits 0..3 whose population
count equals board_info.eth_num (and equals max_pf) is accepted, so
eth_bitmap = 0b1010 is mapped to PF0/PF1 as well.

Should the word be dropped, or should the bitmap actually be checked for
contiguity?

[ ... ]

> +	res_mgt->resource_info->sriov_info = sriov_info;
> +	/*
> +	 * common->hw_bus supplies bus number for channel mailbox QINFO mapping.
> +	 * Execution order guarantee: this assignment runs before
> +	 * cfg_chan_qinfo_map_table() in nbl_dev_start(), only executed
> +	 * on control PF path.
> +	 */
> +	common->hw_bus = hw_bus;

[Severity: Low]
Where is nbl_dev_start()?  It does not exist at this commit, and later in the
series cfg_chan_qinfo_map_table() is reached from nbl_dev_setup_ctrl_dev() via
nbl_dev_setup_chan_qinfo():

	nbl_dev_setup_ctrl_dev()
	  nbl_dev_setup_chan_qinfo(dev_mgt, NBL_CHAN_TYPE_MAILBOX)
	    cfg_chan_qinfo_map_table()

so the function named in the ordering comment is wrong even at the end of the
series.  Could the comment name the actual caller?

[ ... ]

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
> +	 * Hardware constraint: bit0 is reserved, PF0 cannot be masked.
> +	 * All-zero pf_mask means all PF0~PF7 are enabled.
> +	 *
> +	 * Product firmware constraint: only 3 valid configurations supported:
> +	 * 1 PF  (PF0 only): pf_num = 1, mask = 0xfe
> +	 * 2 PFs (PF0,PF1):  pf_num = 2, mask = 0xfc
> +	 * 4 PFs (PF0~PF3): pf_num = 4, mask = 0xf0
> +	 * No other PF count or sparse/non-contiguous PF layout is allowed.
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

[Severity: Medium]
Does this treatment of bit0 agree with the ops documentation?

nbl_def_hw.h says of the same register:

	 * PF0 cannot be masked, bit0 is reserved and has no hardware effect.
	 * All-zero mask indicates all supported PFs are present and enabled.

but here bit0 is counted as a normal PF enable bit, and the contiguity test
then requires it to be clear: exp_contiguous_mask always contains BIT(0) for
any accepted pf_num >= 1, so a pf_mask with bit0 set fails.

Two examples: mask 0xff (PF0 only, with the documented-as-reserved bit0 also
set) gives pf_num == 0, and mask 0xfd gives pf_num == 1 with bit0 set and
trips the contiguity check.  Both end in -EINVAL and an aborted probe.

Should nbl_res_init_pf_num() ignore bit0, or should the header comment be
corrected to say bit0 is a real enable bit?

> +
> +	/* Only allow product-specified PF count: 1 / 2 / 4 */
> +	if (pf_num != 1 && pf_num != 2 && pf_num != 4) {
> +		dev_err(res_mgt->common->dev,
> +			"Invalid pf_num=%u (mask=0x%08x), only 1/2/4 PFs supported\n",
> +			pf_num, pf_mask);
> +		return -EINVAL;
> +	}

[Severity: Medium]
What happens on a board where the k_pf_mask register still reads its reset
value of zero?  nbl_def_hw.h describes an all-zero mask as "all supported PFs
are present and enabled", which yields pf_num == 8 here and is then rejected
with -EINVAL, failing probe.

Is the all-zero case expected to be rejected, and if so should the header
comment say so?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> index 4fc987c0e56d..61dd97c779ef 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> @@ -39,6 +39,16 @@ enum nbl_chan_state {
>  	NBL_CHAN_STATE_NBITS
>  };
>  
> +struct nbl_board_port_info {
> +	u8 eth_num;
> +	u8 eth_speed;
> +	u8 p4_version;
> +	u8 rsv[5];
> +};
> +
> +static_assert(sizeof(struct nbl_board_port_info) == 8,
> +	      "nbl_board_port_info size must be 8 bytes");
> +

[Severity: Low]
Should this header include linux/build_bug.h?  static_assert is defined there,
while the only include in nbl_def_channel.h is linux/types.h.

It builds today because every current translation unit pulls in linux/device.h
or linux/pci.h before the nbl headers, but nbl_hw_reg.h already includes
nbl_def_channel.h before linux/pci.h arrives via nbl_core.h, so a future .c or
.h that includes nbl_def_channel.h first would fail with an implicit
declaration of static_assert.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> index 587ac0c58c24..ee53f9e10a8e 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> @@ -34,9 +35,13 @@ struct nbl_hw_ops {
>  	 * or other PF counts are unsupported by driver resource management.
>  	 */
>  	void (*get_host_pf_mask)(struct nbl_hw_mgt *hw_mgt, u32 *pf_mask);
> +	void (*get_real_bus)(struct nbl_hw_mgt *hw_mgt, u8 *bus);

[Severity: Low]
This isn't a bug, but the kernel-doc block just above get_host_pf_mask
documents "@priv: hw ops private context" while the declared first parameter
is struct nbl_hw_mgt *hw_mgt, so scripts/kernel-doc -Wall reports an
undescribed parameter hw_mgt plus an excess @priv description.

Since this patch extends the same ops structure and its new resource-layer
consumer relies on that comment block for the pf_mask contract, could the
parameter name be fixed here?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index b7c80ea54c8d..1aafed2d46d7 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> @@ -42,7 +44,13 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
>  	ret = nbl_chan_init_common(adapter);
>  	if (ret)
>  		goto chan_init_fail;
> +
> +	ret = nbl_res_init_leonis(adapter);
> +	if (ret)
> +		goto res_init_fail;
>  	return adapter;

[Severity: Medium]
This is the point where the new firmware topology validations become probe
failures: any -EINVAL from nbl_res_init_pf_num() or
nbl_res_ctrl_dev_setup_eth_info() propagates here and nbl_core_init() returns
ERR_PTR(ret), so nbl_probe() reports "Nbl adapter init fail" and the device
does not bind.

Could the changelog mention that this patch alone can turn a previously
successful probe into -EINVAL depending on register content?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831021408.2325-1-illusion.wang%40nebula-matrix.com
