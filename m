Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3892F8BC3;
	Fri,  2 Oct 2026 03:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790912116; cv=none; b=I6jXf3hxG8UDPu5B6bFIN+KVyx0IywNtnaopBsAuiQt6Zhfk09CnKyUte1Ba3OSiAr98fycg/gChd8m5GG3zZNZ02lEsYCBLZG572inwsDKARyPfPOr7bUC1dY4QzqFQ25RsVNzUiP9slMHMzEg9r6l0ElEUygcliJY71wo9/Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790912116; c=relaxed/simple;
	bh=hKme58NofFHKnXcDgDlZ8asdhgVfS1iiogQ/rOgG98k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rhZWo+GMum/9TH8DXcVihUyHIDREFyUzPmqNAyNeM7qzqdQ+5lkc63KwlOWfEHBu2BMTdt0OMAOdCeZE+r7TU5hM5peeG7vUVrcgQVOGDxWFZimqNxqI8YD8C+LU0R0pKDzkucxa9CLRJlZUZ9qomPs1243WX6toeXbCv6Vlwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARwvzypa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARwvzypa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62ADF1F00893;
	Fri,  2 Oct 2026 03:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790912114;
	bh=VZuKxe12Q6z1h95yjM/xKWTBvufWAWEK22ksrB/eo4c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ARwvzypamC9gylJ+A1SfNKGFM5zZ8vdiiDBl92NckzZBBZFYtBD95S4NGpnmmkbI4
	 quzTLNCIsOFJEDa7u5qsvlzjJHcyr0d2RCusySN1NAenGg/dfvyvqzJr6D8rkP4pHR
	 m34klKzYpAvm9kx8UZY1j+ryjRo+94OAi1oOyrReVjexeoUoa63tLHoYNVum+FjzE2
	 SDrZRgtEjD5eBDCJNbG/niccSp8QsthPU2fMhJn+OZMQcDRF/hJXW1dbXtH3G9vNhV
	 ZpcnJyW3SOynCHgxVoiEjTAmKTG19Z7NBZ5VfLxXgTIpVn4SCawWgRKavt8dZWMcUT
	 T/m0N+74BnC3Q==
Subject: Re: [PATCH v30 net-next 2/8] net/nebula-matrix: add common resource
 implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 03:35:13 +0000
Message-ID: <179091211398.434549.13877655075907530912@kernel.org>
In-Reply-To: <20260928123237.88994-3-illusion.wang@nebula-matrix.com>
References: <20260928123237.88994-3-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Baseline: the out-of-bounds MMIO hazard is not reachable, but the
  comment is wrong.

--

net/nebula-matrix: add common resource implementation

This patch adds a chip-agnostic resource layer for the Nebula Matrix
driver. It builds read-only PF topology, SR-IOV BDF, Ethernet port and
VSI tables on the control PF at probe time. It also adds several new
hw_ops, including flush_write, get_real_bus, get_fw_eth_map and
get_board_info.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index eeff6216e4aa..4d3477f70bcc 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> @@ -97,6 +97,32 @@ static void nbl_hw_rd_regs_lock(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 *data,
>  	spin_unlock(&hw_mgt->reg_lock);
>  }
>  
> +/*
> + * Only call this when has_ctrl=true, which maps enough space
> + * (bar_len - 8192) to cover NBL_HW_DUMMY_REG (0x1300904).
> + * The flow/design guarantees this is only called in the
> + * has_ctrl path.
> + */
> +static void nbl_flush_writes(struct nbl_hw_mgt *hw_mgt)
> +{
> +	nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
> +}

[Severity: Low]
Is the "(bar_len - 8192)" part of this comment accurate? The has_ctrl
path in nbl_hw_init_leonis() does not size the mapping from bar_len:

    hw_size = PAGE_ALIGN_DOWN(NBL_MEM_BAR_TOTAL_SIZE -
                              NBL_RDMA_NOTIFY_LEN);
    hw_mgt->hw_addr =
        pcim_iomap(pdev, NBL_MEMORY_BAR,
                   hw_size);

The size is fixed and does not depend on bar_len. It is also smaller
than 64 MiB - 8 KiB when PAGE_SIZE is larger than 8 KiB.

The has_ctrl-only rule is also written only in this comment. The
flush_write member of struct nbl_hw_ops in nbl_def_hw.h says nothing
about it, and nbl_hw_setup_ops() installs the op for every PF. That
includes net-only PFs, which map only NBL_REG_NET_ONLY_LEN (8 KiB). For
those PFs, NBL_HW_DUMMY_REG (0x1300904) is well outside the mapping.

This patch adds no callers. Later in the series, the flush_write callers
in nbl_interrupt.c all seem to sit behind has_ctrl checks, so the
out-of-bounds read does not look reachable. Could the comment be
corrected? Could the has_ctrl requirement also be documented on the
flush_write op in nbl_def_hw.h, or enforced in the code?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928123237.88994-1-illusion.wang%40nebula-matrix.com
