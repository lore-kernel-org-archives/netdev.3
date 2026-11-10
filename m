Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322306;
	b=RbKwdUGxjX+qpPCwMxRbsx+Jv222n3yVKhTNCbPwkJqKWL9kwA4cP3b1qAAhm+LAPKdu
	 IsteObnhHd+FQlY2Wyq+6VlzOM9yG2qyqT9Kr2+qwk7A7/P5OT9L0O9WNUIYigDiwTON2
	 ZVkoo5Qgl6ZcJcxVWFP1pbYvQ1KQqq3vu5EU1DYFRNI0npL1zAhB3H9x1kf2OKF4Nyx5n
	 f6L18v+5cRE6fP6Gz8jvGmR8+Pyr5fYTk0uniMnfQHkJ5rhQtg2OgT8TbgQQxnmNCvAyq
	 zIQMkpjHORDdwYOxF9MENW0bFaTA7uwkgzurzDObEZFoljMzE/G1zVy9TIrGQ7FZI6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322306;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=buqZEZjWv/CuOhvpfn3bLKl+wDA/z75kMCodt1O5PGo=;
	b=GfXOJjnyUKwvyuQg8kEAcm2UD0dSOjL0e1Jgp1Q244yV34WXOz2gJFuEKiIJksBRSEDH
	 WDwCO4TQYp2+R0Oro2xpAYjLacO3Ng461HE3NXJxyFwSJnEqRuDKmS/1++gBYGqA9f1If
	 P45ozQ4asVAgXjP1IUO4moAhNeIqDjewYHrfzY3AQ3Fuwb7Q8qq7L/1zpcBUsS7uhQIsX
	 04joY5Kl7fxX/pIeeSsxcvqCJeP9rDgiqJDAMSNCi3/gMtP9RPEDHUAyO6EG50VTpd4a2
	 +z56bzLAfAIwuT1HlqLAZhx+fpBnTBMdnwoNAtdIeov3+MeojRPT3AzvWCUx9epAE0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mU0EHLUP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9048C60A2611;
	Tue, 10 Nov 2026 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mU0EHLUP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81361F008A1;
	Tue, 10 Nov 2026 14:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322306;
	bh=buqZEZjWv/CuOhvpfn3bLKl+wDA/z75kMCodt1O5PGo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mU0EHLUPFtdTnlLMSRLnbhxj3OS4Xny+JOYThVKdO2oogPcfSma425HAgbaz2oLs4
	 L/8TRf9s4HSBQXxWvNB8OMKk9hA7hvzxeO7buoLF5jKKD4a+ckQKFNaoIj3epppmVS
	 NdkDJ7LgVKaosR/i7xUFUB6amSMafh6IwPuO9XqVwKvhGnydEufVJEgyPtebnC2chG
	 R5odv2RRQ7uNoZEbKnfdk0WD2bbVlBAYQfcDB4dm9VGcLHNmdEYTp7+d5puX/y7Sbx
	 UHQSyuMC6PCoWhrzaDPEfKiT0r0Fw+OFyZ9V32vvhVKrNhctWDuU8mH5Bc/7uxSKZT
	 ksg7SrakSMGaA==
Subject: Re: [PATCH v33 net-next 4/8] net/nebula-matrix: add chip-wide
 hardware init/deinit implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 andrew+netdev@lunn.ch, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Nov 2026 14:51:45 +0000
Message-ID: <179432230546.994134.4294945675510273127@kernel.org>
In-Reply-To: <20261106045631.2224-5-illusion.wang@nebula-matrix.com>
References: <20261106045631.2224-5-illusion.wang@nebula-matrix.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] nbl_dvn_init() and nbl_uvn_init() in nbl_hw_leonis.c turn the
  relaxed-ordering (RO) enables in two chip-wide registers on or off:…

--

net/nebula-matrix: add chip-wide hardware init/deinit implementation

This adds the Leonis chip-wide init_module() and deinit_module() hooks
in the hw and resource layers. They run only on the control PF. They
program the DP datapath registers (DPED, UPED, SHAPING, DSCH, USTORE,
DSTORE, DVN, UVN, UQM, PADPT) and drive the driver_status handshake
with firmware.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index 75d6982ae1e83..2b55f2c2518b4 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c

[ ... ]

> @@ -150,6 +175,719 @@ static void nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt, u32 *eth_map)

[ ... ]

> +static void nbl_dvn_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
> +{
> +	u32 timeout = 0;
> +	u32 ro_flag = 0;
> +

[ ... ]

> +	spin_lock(&hw_mgt->reg_lock);
> +	nbl_hw_rd_regs(hw_mgt, NBL_DVN_DIF_REQ_RD_RO_FLAG, &ro_flag,
> +		       sizeof(ro_flag));
> +	if (pcie_relaxed_ordering_enabled(hw_mgt->common->pdev)) {
> +		ro_flag |=
> +			FIELD_PREP(NBL_DVN_DIF_REQ_RD_RO_FLAG_DESC_RO_EN_MASK,
> +				   1) |
> +			FIELD_PREP(NBL_DVN_DIF_REQ_RD_RO_FLAG_DATA_RO_EN_MASK,
> +				   1) |
> +			FIELD_PREP(NBL_DVN_DIF_REQ_RD_RO_FLAG_AVRING_RO_EN_MASK,
> +				   1);
> +	} else {

[ ... ]

> +	}
> +	nbl_hw_wr_regs(hw_mgt, NBL_DVN_DIF_REQ_RD_RO_FLAG, &ro_flag,
> +		       sizeof(ro_flag));
> +	spin_unlock(&hw_mgt->reg_lock);

[ ... ]

> +static void nbl_uvn_init(struct nbl_hw_mgt *hw_mgt)
> +{

[ ... ]

> +	ro_enabled = pcie_relaxed_ordering_enabled(hw_mgt->common->pdev);
> +
> +	nbl_hw_rd_regs(hw_mgt, NBL_UVN_DIF_REQ_RO_FLAG, &flag, sizeof(flag));
> +	if (ro_enabled) {
> +		flag |= FIELD_PREP(NBL_UVN_DIF_REQ_RO_FLAG_AVAIL_RD_MASK, 1) |
> +		FIELD_PREP(NBL_UVN_DIF_REQ_RO_FLAG_DESC_RD_MASK, 1) |
> +		FIELD_PREP(NBL_UVN_DIF_REQ_RO_FLAG_PKT_WR_MASK, 1);
> +		flag &= ~FIELD_PREP(NBL_UVN_DIF_REQ_RO_FLAG_DESC_WR_MASK, 1);
> +	} else {

[ ... ]

> +	}
> +	nbl_hw_wr_regs(hw_mgt, NBL_UVN_DIF_REQ_RO_FLAG, &flag, sizeof(flag));

[Severity: Medium]
Both of these RO flag registers seem to be single chip-wide registers
in the DP block, not per-function ones:

#define NBL_DVN_DIF_REQ_RD_RO_FLAG		(NBL_DP_DVN_BASE + 0x0000045C)
#define NBL_UVN_DIF_REQ_RO_FLAG			(NBL_DP_UVN_BASE + 0x00000250)

nbl_res_chip_init_module() in nbl_chip.c runs this only on the
control PF:

	if (!common->has_ctrl)
		return -EINVAL;

That means nbl_dvn_init() and nbl_uvn_init() check
PCI_EXP_DEVCTL_RELAX_EN only on the control PF's pdev, and that one bit
sets relaxed ordering for every function's queues on the chip.

In PCIe, Enable Relaxed Ordering is a per-function permission. Suppose
a sibling PF has RO cleared in its own DEVCTL, for example by a guest
that owns it through vfio-pci, by setpci, or by a driver applying an
erratum. If the control PF has RO enabled, would the DVN/UVN engines
still issue RO-tagged descriptor and avail-ring reads, and RO packet
writes, for that sibling's queues?

The value is also read only once, here. deinit_module() leaves it
programmed, so later DEVCTL changes on any function are never picked
up.

Does the hardware also gate the RO attribute on each requester
function's own DEVCTL? If not, could this use the AND of RO enable
across all functions on the chip, or program RO per function if the
hardware supports that? If the hardware does gate it per function,
could a comment here say so?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106045631.2224-1-illusion.wang%40nebula-matrix.com
