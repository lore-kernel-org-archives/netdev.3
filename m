Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D55D3B14C6
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186574; cv=none; b=tAdhWbhzINpg12OWBt7fRrHT7jN/lIS3837SiQP2/O6OuiOCiWsZHS2ooKZ2Qk+uH7qvZLvCzfDPy/uokN+TPauZ4klg3T++WlKfwzlFMRwI4EvAUeXXRUM3OUz3x62+R23v/Fxw2h7bZdDuDJOdc/9rruLgp7ii//mIw27xQMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186574; c=relaxed/simple;
	bh=SVTBlUu4R3Hfl09VNNEF87vfLmEXpWwc0gLYC1g8S9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjVSdF5TIzwo6OZFlCnOZhUNyvUMeo18zSynokzLc3Xl42tFrwI3nWWXpnKyaHh8cX8VN3gR7cenfyj5iNRjwHjK8ZdoYV+fv1Vop/ZbMq9rbIqZAbrdhAbkbANMjzZZZuFFJGptFQq726CKQviNMILzoJJAmkX2mql12j912c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qsg+O51j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qsg+O51j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3521F000E9;
	Thu, 16 Jul 2026 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784186565;
	bh=2sbVVvI03x/xh4Etjy4K/yfvUOCabFaxBGuw+i3Ky6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qsg+O51jiljFbNxh58lTipgGVTpyNHUyir7VSHh2wQiOaDjYzd998AO6QreKf7SlT
	 Q9+3BgrKdtYaug+wkWRoFZ0xZas3nyuYZm/Hx4T8KpFxv3TG8cE0RVcrAMMk4dp8Qx
	 QmHVeCoOZhimo8inSc30Rkkt48ILmE8FWgmrnYdXFVxFSO2MWn0SG+2GD7To4jOjVg
	 f/omdA0VlepwF7kcOZRrtanEw/WCLuPkmfSioF5koebOBwp9h//lNRw1ypj/Vm+c8n
	 gFCJ3HOy/WbgN4AmxImQjm3U13ys4CroqAwhNu2coEfOuIlEZP+lvgoltAkk4pDjux
	 PkJfuitjay1+g==
From: Simon Horman <horms@kernel.org>
To: nikhil.rao@amd.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	brett.creeley@amd.com,
	eric.joyner@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH 3/6] pds_core: add PLDM firmware update support via devlink flash
Date: Thu, 16 Jul 2026 08:20:43 +0100
Message-ID: <20260716072042.186444-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708212222.296202-4-nikhil.rao@amd.com>
References: <20260708212222.296202-4-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
--- Patch [3]: [PATCH 3/6] pds_core: add PLDM firmware update support via devlink flash ---
commit 865af5a5208d8bbf12e2bc16faaacfc3c3239978
Author: Brett Creeley <brett.creeley@amd.com>

pds_core: add PLDM firmware update support via devlink flash

This commit implements PLDM firmware update support in the pds_core driver
using the upstream pldmfw API. It allows updating an entire PLDM FW package
at once or updating specific firmware components by name.

> diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
> index 84ea502ecb128..b149d29bd2560 100644
> --- a/drivers/net/ethernet/amd/pds_core/dev.c
> +++ b/drivers/net/ethernet/amd/pds_core/dev.c
> @@ -206,15 +206,56 @@ static int __pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
>  	else
>  		memcpy_fromio(comp, &pdsc->cmd_regs->comp, sizeof(*comp));
>  
> +	if (err != -ETIMEDOUT && err != -EAGAIN)
> +		pdsc_deferred_dma_free(pdsc);
> +

[Severity: High]
Can pdsc_deferred_dma_free() prematurely free DMA memory that the device
firmware is still actively accessing?

If a DMA-based devcmd like pdsc_devcmd_send_component() times out after
polling and returns -EAGAIN, the DMA mapping is added to
pdsc->deferred_dma_list in pdsc_flash_component_chunk(). The firmware update
aborts on the host, but the device might still be processing the command in
the background.

If an unrelated devcmd (e.g., from a periodic health check) executes and
succeeds shortly after, this logic will unconditionally unmap and free all
deferred DMA memory. Does this lead to memory corruption or IOMMU faults if
the firmware continues to access the freed memory?

>  	return err;
>  }
>  
> +void pdsc_deferred_dma_add(struct pdsc *pdsc, struct pdsc_deferred_dma *entry,
> +			   dma_addr_t dma_addr, void *va, size_t size,
> +			   enum dma_data_direction dir)
> +{

[ ... ]

> @@ -227,6 +268,47 @@ int pdsc_devcmd(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
>  	return err;
>  }
>  
> +static int __pdsc_devcmd_with_data(struct pdsc *pdsc,
> +				   union pds_core_dev_cmd *cmd,
> +				   const void *data, size_t data_len,
> +				   union pds_core_dev_comp *comp,
> +				   int max_seconds, bool do_msg)
> +{
> +	int err;
> +
> +	mutex_lock(&pdsc->devcmd_lock);
> +	if (!pdsc->cmd_regs) {
> +		err = -ENXIO;
> +		goto unlock;
> +	}
> +	if (data_len > sizeof(pdsc->cmd_regs->data)) {
> +		err = -ENOSPC;
> +		goto unlock;
> +	}
> +	memcpy_toio(&pdsc->cmd_regs->data, data, data_len);

[Severity: High]
This is a pre-existing issue, but can a concurrent PCI reset unmap the device
BARs while the firmware update is actively copying data to MMIO here?

When devlink flash initiates a firmware update, __pdsc_devcmd_with_data()
acquires devcmd_lock and begins copying up to 2KB of data via memcpy_toio().

Concurrently, a PCI reset (e.g., via sysfs or AER) triggers
pdsc_reset_prepare(), which calls pdsc_unmap_bars() without acquiring
devcmd_lock. pdsc_unmap_bars() sets pdsc->cmd_regs = NULL and calls
pci_iounmap().

Could this race cause a kernel panic if the firmware update thread dereferences
the now-NULL pdsc->cmd_regs pointer or accesses unmapped MMIO memory? The long
polling firmware update that repeatedly copies large data blocks might
exacerbate this race window.

> +	err = __pdsc_devcmd_locked(pdsc, cmd, comp, max_seconds, do_msg);
> +unlock:
> +	mutex_unlock(&pdsc->devcmd_lock);
> +
> +	return err;
> +}
