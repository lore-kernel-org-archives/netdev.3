Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9652F7EFE;
	Fri, 31 Jul 2026 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785461432; cv=none; b=eA89KUMSoRpnxQFKb32Lb9f6JFheFNlX77i0+vqpZtyZGxiiFkQ3I948w2sVs9I+ERcIS5gTfa1/aBQHZ9pqFW/e1LCLUQgZUi/tyIda+H0VPDFkeNOj/SMsMN335k+p9Xtg/yDrbshRseZycXivR1X1JGJ43RGoO/pY5ADjBDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785461432; c=relaxed/simple;
	bh=ZJg4Tbkx4zEWG/RUSmAXR5v72+cebG7ZfbdODsW0Z08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFTSfZOhlC8hGYKKmvoocx83cj1Ag9ajiW3kUf3WVtrF+ZGsDTC2Ns64PEVYRr5s2uDZp5x0ItysYxUnoADhts9H9OHJ/+wmVjTwP2PRHh1noJ0md8gJd/xflspBRqSwvBvltrjVd3wJ8o5wnfOTgRodRV1/HgEPExDZ1QqNKEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUHa3M/f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUHa3M/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D861F000E9;
	Fri, 31 Jul 2026 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785461431;
	bh=tO4akjwUPHMhgTErtbLTcBL2x6FVO2cY0DLEncCKQdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cUHa3M/ft0GJq/sZ6PXKF2DV/PTcbWWW5GYhCZYL9YshDCZEy/nw4MAxvL7FncaXq
	 SFoz8PbMbzw/AJajjlT9u/fsKCgG9zvtityAqT3BtQw7/I1PH1RePSzW5JNg6xxqRC
	 Jtqv90qjwe9sxBvrbuKR3HWpHbeLc9tzDSVcqqAdHGsI082FTm6HoySf/s97OADVzI
	 XLuJzj4n1hDyD0ZNKkx0viN51rgtRT28+FaJYCvHgRoxO+5FJKaJc2ylRbCllk6RAM
	 Oq/bGWabBqteW2dEah6ugaz6iPtcPPdpu5LNSyQUo4ehsHaF9+Wg1PjUKl3JjXQtOf
	 PG7QKZSnPNJ9A==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v22 net-next 05/12] net/nebula-matrix: add common resource implementation
Date: Thu, 30 Jul 2026 18:30:29 -0700
Message-ID: <20260731013029.745041-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723040110.91410-6-illusion.wang@nebula-matrix.com>
References: <20260723040110.91410-6-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [5]: [PATCH v22 net-next 05/12] net/nebula-matrix: add common resource implementation ---
commit d40e580d6fb636a87bb6f2eb1a3079e1e85c78a0
Author: illusion wang <illusion.wang@nebula-matrix.com>

net/nebula-matrix: add common resource implementation

The patch introduces the common resource implementation for the Nebula
Matrix driver. It provides conversions among vsi_id, func_id, eth_id,
and pf_id, and sets up initialization for the control devices.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index b37df49f86c80..4c7eea24c70ed 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
[ ... ]
> @@ -133,6 +154,14 @@ static u32 nbl_hw_get_host_pf_mask(struct nbl_hw_mgt *hw_mgt)
>  	return data;
>  }
>  
> +static u8 nbl_hw_get_real_bus(struct nbl_hw_mgt *hw_mgt)
> +{
> +	u32 data;
> +
> +	data = nbl_hw_rd32(hw_mgt, NBL_PCIE_HOST_TL_CFG_BUSDEV);

[Severity: High]
Will this cause a kernel panic due to an out-of-bounds MMIO read?

During device initialization, nbl_res_ctrl_dev_sriov_info_init() calls
hw_ops->get_real_bus(), which performs an MMIO read on
NBL_PCIE_HOST_TL_CFG_BUSDEV.

Since NBL_PCIE_HOST_TL_CFG_BUSDEV is defined using NBL_INTF_HOST_PCIE_BASE
(which is roughly a 21 MiB offset), and the driver only maps a 16 MiB PCI
BAR during nbl_hw_init_leonis(), this appears to read from an unmapped
physical address.

Similarly, the call to hw_ops->get_host_pf_mask() from nbl_res_init_pf_num()
will read from NBL_PCIE_HOST_K_PF_MASK_REG, which also evaluates to an
out-of-bounds register address.

> +	return FIELD_GET(NBL_PCIE_BUS_MASK, data);
> +}
> +
