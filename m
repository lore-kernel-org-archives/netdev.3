Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4426B1ADC97;
	Fri, 31 Jul 2026 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785461429; cv=none; b=nTn2XtSSaPzCXVErL+0mo9BOa+Q0dx1vd59iT9lsUl64+yRVGjEDPaYYf7sZ6tHLJiWrkcQ3R3trWacFAtknZTfT0NDFqsOUUFgBXkHNXZyDMGsM8Lg3TfZ3azcL5W0b42CzlCiem0+7V8Oar9my66+srzBTO4y7NebLvFwS0NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785461429; c=relaxed/simple;
	bh=bAy+SyUYKuCPkucmeCAkOaTT3QFJC2+AHkivq/BPmTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKOJhXsjyKq7m2cquuVSUnESU0VrsCSJbMCFCdTkoh+4935+ALo2ovFPqiUFixZHWp2Zrkiti47+RuXA14XfVHOBKigcdTmcrscWmalL9N7uF0FnOwZgAOhz7Mqxjv16WcOXQMKPuZiVohRvMfFal7jgfa+mQHzlDBRSVOCP3kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8ZY2HpP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8ZY2HpP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBFA1F000E9;
	Fri, 31 Jul 2026 01:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785461428;
	bh=1hVT3vwctn7nCJ9n6D8j9gvOh7LB2JRLhCxC5rMcOIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i8ZY2HpP+hKJDsvNrgii/KKGb+j4Hhjn4GTkfPz3s5oPPuuGUFqshmvYASqooVsd8
	 1MxM4JPnFXoVFzJ4QfC/ExJFfIiTjs0C0GCWWgq3R6IvflojJpKxjJtx6LRZv3HQuT
	 44eOugCEd1fy1ZzKzOTxTf3hwssv0YVHkfsvTo0dqE54N2/ZU55PpfK5RJv/KWmaNg
	 V1X8dNjC6SC0OeVoekjuwuXIxjOsaMIjyU5IW2KI6bViO8gnus0V++BqxGyjMJXP8M
	 ARLYabkhSruD/Tz8hCXjvLsLUECPJZ/vpNaiDhQ8TTPygrJIPqybDFB0aYn47G1Qug
	 ljT1z/sSBEo3w==
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
Subject: Re: [PATCH v22 net-next 02/12] net/nebula-matrix: add core driver architecture and HW layer initialization
Date: Thu, 30 Jul 2026 18:30:25 -0700
Message-ID: <20260731013025.744937-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723040110.91410-3-illusion.wang@nebula-matrix.com>
References: <20260723040110.91410-3-illusion.wang@nebula-matrix.com>
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
--- Patch [2]: [PATCH v22 net-next 02/12] net/nebula-matrix: add core driver architecture and HW layer initialization ---
commit b4e4638b25f9e82d490889327022a039dbb63644
Author: illusion wang <illusion.wang@nebula-matrix.com>

net/nebula-matrix: add core driver architecture and HW layer initialization

This commit adds the core driver framework and hardware layer initialization
for the NBL NIC family. It handles basic device capability parsing, DMA
mask fallback, and Leonis hardware BAR resource requests and mappings.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> new file mode 100644
> index 0000000000000..79a4b15c01a90
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
[ ... ]
> +int nbl_hw_init_leonis(struct nbl_adapter *adapter)
> +{
[ ... ]
> +	if (common->has_ctrl) {
> +		/*
> +		 * The fixed 16MiB MEMORY BAR of PF0 contains both control
> +		 * register region and the 8KiB RDMA notify partition inside
> +		 * this single 16MiB window. The RDMA notify area does not
> +		 * occupy extra space outside the BAR range.
> +		 * We only map the front part of BAR by cutting off the last
> +		 * NBL_RDMA_NOTIFY_LEN bytes for hardware exclusive RDMA
> +		 * notification use,
> +		 * so the mapping length equals bar_len - NBL_RDMA_NOTIFY_LEN.
> +		 * Since the RDMA notify region is internal to the 16MiB BAR,
> +		 * the minimum BAR size check remains bar_len >=
> +		 * NBL_HW_REG_SPACE_SIZE to ensure full register space is
> +		 * available.
> +		 */
> +		if (bar_len < NBL_HW_REG_SPACE_SIZE) {
> +			dev_err(&pdev->dev,
> +				"MEMORY BAR len %pa too small for ctrl reg space\n",
> +				&bar_len);
> +			ret = -EINVAL;
> +			goto setup_mgt_fail;
> +		}
> +
> +		hw_mgt->hw_size = bar_len - NBL_RDMA_NOTIFY_LEN;
> +		hw_mgt->hw_addr =
> +			pcim_iomap(pdev, NBL_MEMORY_BAR,
> +				   hw_mgt->hw_size);

[Severity: Medium]
Will this map the hardware-exclusive RDMA notify region if the platform or
hypervisor assigns a BAR larger than 16 MiB (NBL_HW_REG_SPACE_SIZE)?

If bar_len > NBL_HW_REG_SPACE_SIZE, hw_size will span beyond the front part
of the fixed 16 MiB window and cover the RDMA notify region.

If an RDMA driver later attempts to map this same region with Write-Combining
(WC) attributes, could it conflict with the Ethernet driver's Uncacheable (UC)
mapping and cause x86 PAT attribute aliasing issues?

Should this calculation use NBL_HW_REG_SPACE_SIZE instead of bar_len?

> +	} else {
> +		if (bar_len < NBL_REG_NET_ONLY_LEN) {
[ ... ]
-- 
pw-bot: cr
