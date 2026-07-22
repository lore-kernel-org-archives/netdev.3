Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459723E1208;
	Wed, 22 Jul 2026 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736849; cv=none; b=e2Syt93i4aWQf0D19au4BUAcfeqsVa9LwosFcOZvNHPiVNIgI7eUMTchxPq1Zuob8B8yZ/W+HSIW8IDvf93qWatPiGIRDCfGbm+OCgmdQY/X4Bh7cKE5XNGGLXaSWi67zZecV4gs2y9USUoVjGooTjRQkRrFlK0oUo6WVBP4Yss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736849; c=relaxed/simple;
	bh=bFw3bpM1QD8jSICLtjnFV+3gOguyWkdvw1ecs87OGnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNx6Uio/gG5AOpoIrK5q+zpfHzfL7GQepdPdJ5KGuD4wySu/6KZhyOToTPynVIz8RTpoKOMtDrG7VkqyKXymAGV7vNfxzyoO6LBN4uths1lM8go0xfLEPo+fg/oDYyWeb5HSkefcNrSYisrYXd7trISbfqvKFA+eFLfYlilATsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtiBA9jL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtiBA9jL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5D71F000E9;
	Wed, 22 Jul 2026 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736847;
	bh=D+6sV+NUCOs4DK4/+6GxIwgp4J7Mrp+LAJofiqS5Owg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PtiBA9jLYMy9Zl2mm5BWlRJWsPoGorVaKQC1qM3wYW1Nqb43yJfVtyHAsPAamdYz/
	 G/Hoivs4cD5I++sVehGTSZIMZDq+1Dg9f9eP5uRoPjGl8CO522S0mdNVZbtB7yZUXA
	 nyvfV8GbOjK/8bY681T6ZYoFCvzUBgEgoUbwHRtOSF/T+XkgWNXzVkxzbuCTU6TbzM
	 GXgOCOog139EALxgmmbPMSJHZn2nEfGew6Fh9Ukiz9KG6RnpOLGBnqfQpmjpsbSJrL
	 Xoa5Z5OTx2qxf7e64Y2tfikaXtasT/OO1hUpgJl3UGtIv9I4VX7A91wPewaYziLJO3
	 zpOVCeiETF6og==
From: Simon Horman <horms@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	larysa.zaremba@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	madhu.chittim@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	jiri@resnulli.us,
	corbet@lwn.net,
	richardcochran@gmail.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	Bharath.r@intel.com
Subject: Re: [PATCH net-next v5 08/15] idpf: refactor idpf to use libie_pci APIs
Date: Wed, 22 Jul 2026 17:13:52 +0100
Message-ID: <20260722161352.543079-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715180042.1972010-9-anthony.l.nguyen@intel.com>
References: <20260715180042.1972010-9-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260715180042.1972010-2-anthony.l.nguyen@intel.com?part=8
---
--- Patch [8]: [PATCH net-next v5 08/15] idpf: refactor idpf to use libie_pci APIs ---
commit 131cbea6d4e2fb71f297aa7df605c1576a8704cf
Author: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: idpf: refactor idpf to use libie_pci APIs

This commit refactors the idpf driver to use the libie_pci initialization
and MMIO APIs. It updates register accesses across various components like
control queues and virtchnl messages to rely on the libie_ctlq_ctx
structure.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
> index c5e47e79a6411..92a120aadfcd2 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h

[ ... ]

> @@ -945,7 +884,8 @@ static inline bool idpf_is_reset_detected(struct idpf_adapter *adapter)
>  	if (!adapter->hw.arq)
>  		return true;
>  
> -	return !(readl(idpf_get_mbx_reg_addr(adapter, adapter->hw.arq->reg.len)) &
> +	return !(readl(libie_pci_get_mmio_addr(&adapter->ctlq_ctx.mmio_info,
> +					       adapter->hw.arq->reg.len)) &
>  		 adapter->hw.arq->reg.len_mask);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the transition to
libie_pci_get_mmio_addr() expose us to linked-list corruption here?

The old code performed an array access, but libie_pci_get_mmio_addr()
traverses the mmio_info->mmio_list. This traversal appears to be lockless
in asynchronous paths like idpf_is_reset_detected() in idpf.h and
idpf_ctlq_send() in idpf_controlq.c.

At the same time, driver teardown (idpf_remove) or hardware reset
(idpf_init_hard_reset) can call idpf_decfg_lan_memory_regions(), which
uses libie_pci_unmap_fltr_regs() to concurrently modify and free items
from this same list using list_del() and kvfree().

Since idpf_vc_xn_shutdown() doesn't wait for in-flight transactions
to drain, could a concurrent ethtool or interface operation preempt
during this list traversal and cause a use-after-free or list corruption?

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq.h b/drivers/net/ethernet/intel/idpf/idpf_controlq.h
> index de4ece40c2ff3..acf595e9265f5 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_controlq.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_controlq.h
> @@ -109,8 +109,6 @@ struct idpf_mmio_reg {
>   * Align to ctlq_hw_info
>   */
>  struct idpf_hw {
> -	struct idpf_mmio_reg mbx;
> -	struct idpf_mmio_reg rstat;
>  	/* Array of remaining LAN BAR regions */
>  	int num_lan_regs;
>  	struct idpf_mmio_reg *lan_regs;

[Severity: Low]
Are these num_lan_regs and lan_regs fields still needed?

It looks like the new libie_pci API uses 
adapter->ctlq_ctx.mmio_info.mmio_list for LAN memory regions, and all
allocations and references to these array fields have been successfully
removed from the source files.
