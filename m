Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7813F4DD6;
	Fri, 11 Sep 2026 03:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098113; cv=none; b=Z2AZAGjllgN5d5FOPIHxt1BMx22oJPUsuNJxVt7whsBkNjmdiFrVrIfcySm6GSxMf8ucjVXsjQvk+VEQNtsbRqxc/5vcndtzVP8OWOgLdara6OkxdDdPyKU7Ya9Rr+HPnYCiduUB8CyxuPqv2F3ynp2vRNlngmEkyDIqyDHjatU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098113; c=relaxed/simple;
	bh=Y4VNoFzXY4eYalK4AQe0FEOIqJH0NNBfNYfMCD+AIzA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RBpM6qVB4TX8rCZb7ob/SMHoUd+rhawRb7QYJCAZ+Cvj+SHl+8kLtQURStsw7GkG6cZylr94INL3VXeicfo7OUxrAb+sNzx+0th0Sndss9ZneAoUPrrGd5ngtHSrj50mUzltVv7vNpzyiN2OkKUuFPWHG/nRqpykLf2mP6LCBo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0L6Kk9I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0L6Kk9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057A81F00893;
	Fri, 11 Sep 2026 03:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789098111;
	bh=JHG8FC+sycMjkGPNlWnWZ50aRp9iDjOjkbL+0K704n4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=A0L6Kk9Id18urQduc3v+Zw7s/WRsi0DLtMvBf/c4vpFLTSpe0bEyZExiZaSrXHK0E
	 T5U6EK9lt7pHszALEv/L2POyanEYf6w1T5j93kg7V0T6IQF51SIR5Ajmp2xWM33r/R
	 Yn8Fw3BW1BWItTJgWHnlMSzOSpi/xKS888dco9v8R5PANpZuG3SsYfJ3Bq9i3FQ1fU
	 YTje9iehWhkkp/cDAwJG8fKLbJLO9HzwXdPsdO817rYI1hCxItpoV6FO6dbowk0Dvk
	 NsBKYD9FTn/Q5FRFURg1veB3+Tq+UmI0XcS0v92tmL6AAadwl4vs4YPxjspbhzWZHJ
	 TXaIACFZ44Bpw==
Subject: Re: [PATCH v27 net-next 06/10] net/nebula-matrix: add chip-wide
 hardware init/deinit implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 03:41:50 +0000
Message-ID: <178909811060.219967.8481279776743770072@kernel.org>
In-Reply-To: <20260907123848.30256-7-illusion.wang@nebula-matrix.com>
References: <20260907123848.30256-7-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] No hardware unwind path exists for the chip-wide state armed
  by nbl_hw_init_module() (nbl_hw_leonis.c:681), neither on init failure…

--

net/nebula-matrix: add chip-wide hardware init/deinit implementation

This adds the Leonis chip-wide init/deinit implementation, programming the
datapath pipeline (packet engines, scheduler, buffer stores, queue manager,
port shaping and flow control) plus the driver_status flag read by firmware.
The new hw_ops.init_module/deinit_module and the matching resource_ops entry
points are registered here, with the invocation path landing in a later
patch.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index 4c2e577610230..9f1054067e14c 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> @@ -115,6 +115,585 @@ static void nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt, u32 *eth_map)

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

> +	default:
> +		dev_err(hw_mgt->common->dev,
> +			"Unsupported port speed %u for eth%u\n", speed, eth_id);
> +		return -EINVAL;
> +	}

[ ... ]

> +	/* 3. commit: set valid last */
> +	low_val = FIELD_PREP(NBL_DPORT_VALID_MASK, 1);
> +	dport.data[0] |= lower_32_bits(low_val);
> +
> +	low_val = FIELD_PREP(NBL_DPORT_VALID_MASK, 1);
> +	dvn_dport.data[0] |= lower_32_bits(low_val);
> +
> +	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DPORT_REG(eth_id), dport.data,
> +		       sizeof(dport));
> +	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DVN_DPORT_REG(eth_id),
> +		       dvn_dport.data, sizeof(dvn_dport));
> +	spin_unlock(&hw_mgt->reg_lock);
> +	return 0;
> +}
> +
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

[ ... ]

> +static int nbl_ustore_init(struct nbl_hw_mgt *hw_mgt, u8 eth_num)
> +{

[ ... ]

> +	if (WARN_ON(eth_num != 1 && eth_num != 2 && eth_num != 4))
> +		return -EINVAL;

[ ... ]

> +		fc_th |= FIELD_PREP(NBL_DSTORE_D_DPORT_FC_FC_EN_MASK, 1);
> +		nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_D_DPORT_FC_TH_REG(i), &fc_th,
> +			       sizeof(fc_th));
> +		spin_unlock(&hw_mgt->reg_lock);
> +	}
> +}

[ ... ]

> +static int nbl_dp_init(struct nbl_hw_mgt *hw_mgt, u8 speed, u8 eth_num)
> +{
> +	int ret;
> +
> +	nbl_dped_init(hw_mgt);
> +	nbl_uped_init(hw_mgt);
> +	ret = nbl_shaping_init(hw_mgt, speed);
> +	if (ret)
> +		return ret;
> +	nbl_dsch_qid_max_init(hw_mgt);
> +	ret = nbl_ustore_init(hw_mgt, eth_num);
> +	if (ret)
> +		return ret;
> +	nbl_dstore_init(hw_mgt, speed);
> +	nbl_dvn_init(hw_mgt, speed);
> +	nbl_uvn_init(hw_mgt);
> +	nbl_uqm_init(hw_mgt);
> +	return 0;
> +}

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

[ ... ]

> +static int nbl_hw_init_module(struct nbl_hw_mgt *hw_mgt, u8 eth_speed,
> +			      u8 eth_num)
> +{
> +	int ret;
> +
> +	ret = nbl_dp_init(hw_mgt, eth_speed, eth_num);
> +	if (ret)
> +		return ret;
> +	nbl_intf_init(hw_mgt);
> +	nbl_hw_set_driver_status(hw_mgt, true);

[Severity: Medium]

nbl_hw_init_module() can return an error after a good part of the chip has
already been programmed, and nothing puts those registers back. There are
two failure points inside nbl_dp_init():

nbl_shaping_init() -> nbl_shaping_eth_init() returns -EINVAL from the
switch default for any speed outside 10/25/50/100G. By then the ports
earlier in the eth_bitmap loop have already been committed with VALID=1,
and NBL_DSCH_PSHA_EN plus the NBL_SHAPING_NET_REG() clearing loop are
skipped.

nbl_ustore_init() returns -EINVAL from
WARN_ON(eth_num != 1 && eth_num != 2 && eth_num != 4) after DPED, UPED,
shaping and DSCH were already programmed.

The speed comes from firmware, read by nbl_hw_get_board_info() out of
NBL_FW_BOARD_DW3, so a value outside enum nbl_fw_port_speed reaches
nbl_shaping_eth_init() without any earlier check.

In both cases the error is propagated before
nbl_hw_set_driver_status(hw_mgt, true), so firmware is never told a driver
attached and the firmware-side cleanup that deinit relies on is not
triggered either.

Should nbl_dp_init() unwind the sub-modules it has already programmed, or
should eth_speed and eth_num be validated before the first register write?

On the teardown side, the comment above nbl_hw_deinit_module() says
setting driver status to false makes firmware "perform full cleanup of all
per-PF hardware state, including qinfo registers", but the state this
patch programs is chip-wide rather than per-PF:

	shaping DPORT/DVN_DPORT entries with VALID=1
	NBL_DSCH_PSHA_EN
	USTORE per-port drop threshold EN
	DSTORE DISC_BP_TH EN and per-port FC_EN
	DVN/UVN relaxed-ordering flags
	UVN prefetch init and queue err mask
	UQM que_type

Most of those are programmed read-modify-write, for example:

	nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_DISC_BP_TH, &bp_th, sizeof(bp_th));
	bp_th |= FIELD_PREP(NBL_DSTORE_DISC_BP_TH_EN_MASK, 1);
	nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_DISC_BP_TH, &bp_th, sizeof(bp_th));

so after an unbind or a failed control PF probe, do these enables stay
armed and get carried into the next attach, or into another consumer such
as vfio-pci? Also, the relaxed-ordering bits are derived from the PCIe
DEVCTL value observed at init time only.

Could the commit message or the comment state which of these chip-wide
registers firmware actually reverts, so the claim can be checked against
the register list above?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907123848.30256-1-illusion.wang%40nebula-matrix.com
