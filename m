Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93EC3C278B
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537791; cv=none; b=cLiZdVtSguEI+rw3Fw1i9ISjh2cDESLGGicyvA15O8zrMmFk/NmKcD+ClDcG/9PcDabAHIcdEx5F+Ri++1qSFUmuPtRq4v4uQliz6PbNZrQTKy5lho0x4+w7Qjf5PIoZTgecnpqdoANhW9VQs78YuNvC99C+yDLH8xRJguQHCGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537791; c=relaxed/simple;
	bh=Dm4U4Hi4/nFJkXtzRjSL6ktuC64YkGZPD9vJK62ai90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gM+xRgsCuTxLMr2HV+CuKMDlU0TxfLTmzz+B+92WfeHWAGeBaMndzxuOzDWlJTEqalQOdO3METVcaQNpJGkuRdjhXyCQtWM1Hdmtgo5LILKniU3k7PagVvMIsEVJft6p2ORchp8fOnS9ItEPhGKPZPxO8rmPbtob3VZX8eFdFwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVjrPYrr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVjrPYrr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30921F00A3A;
	Mon, 15 Jun 2026 15:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781537790;
	bh=kJBwT4LlDOvM5QQ3EbkbClxRFi55fXuNZvaQcUNW1qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QVjrPYrrx9O6gpp2nXOApkQASJOG3kTD3BDUJzNhylTIjLpAvLYQLmyFcwHILK1tk
	 EMw/msCRkIHW11HXB21IJ2jbv3TrtyCaPmRVm4v7obSS0d4JXWGQCLtNMw/qGtoSlr
	 v0WgH8bJCM+NFqXWRAWNuSEJnkkgFsHdlqrigMgd4662Ke/zXzcDKYYgtGE19o1JR9
	 GJVowZmMEsZbHG0B4zkUBJnWuiH0SmZfyz5TtOh83x9AmkTy6somGg8cF1n+Bx75HB
	 FVCPThBWEdF66u5lbta2SnuPO2w4woTXMjQJiVYttvqB+e8wVkeQWBuv3XOMXahZFB
	 cJuGZY766jRQA==
From: Simon Horman <horms@kernel.org>
To: nikhil.rao@amd.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric.joyner@amd.com
Subject: Re: [PATCH v4 3/6] pds_core: add PLDM firmware update support via devlink flash
Date: Mon, 15 Jun 2026 16:36:19 +0100
Message-ID: <20260615153620.775599-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614050052.1048328-4-nikhil.rao@amd.com>
References: <20260614050052.1048328-4-nikhil.rao@amd.com>
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
pds_core: add PLDM firmware update support via devlink flash

Implement PLDM FW Update in the pds_core driver using the upstream
pldmfw API. This allows updating an entire PLDM FW package at once
or updating specific firmware components by name.

> diff --git a/drivers/net/ethernet/amd/pds_core/fw.c b/drivers/net/ethernet/amd/pds_core/fw.c
> --- a/drivers/net/ethernet/amd/pds_core/fw.c
> +++ b/drivers/net/ethernet/amd/pds_core/fw.c
> [ ... ]
> @@ -195,3 +239,720 @@ int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
> [ ... ]
> +static int pdsc_flash_component_chunk(struct pdsc *pdsc, struct device *dev,
> [ ... ]
> +	err = pdsc_devcmd_send_component(pdsc, info, info_sz, dma_addr,
> +					 copy_sz, offset, slot_id, comp);
> +	if (err == -ETIMEDOUT || err == -EAGAIN) {
> +		pdsc_deferred_dma_add(pdsc, deferred, dma_addr,
> +				      component_data, copy_sz, DMA_TO_DEVICE);
> +		return err;
> +	}

[Severity: High]
Can this lead to a race condition that leaks the DMA mapping and memory?

If pdsc_devcmd_send_component() encounters a timeout in the lower level
__pdsc_devcmd_locked() function, it will queue pdsc->health_work. The wrapper
function __pdsc_devcmd_with_data_nomsg() will then release the devcmd_lock
before returning the timeout error back here.

If the scheduled health_work runs and acquires devcmd_lock before this code
reaches pdsc_deferred_dma_add(), it could execute a recovery devcmd and
call pdsc_deferred_dma_free() on an empty list. When this thread resumes,
it adds the timed-out buffer to the deferred DMA list, but its cleanup
trigger has already fired, leaving the buffer leaked.

> [ ... ]
> +int pdsc_firmware_update(struct pdsc *pdsc,
> +			 struct devlink_flash_update_params *params,
> +			 struct netlink_ext_ack *extack)
> +{
> +	int err;
> +
> +	if (pdsc->dev_ident.version >= PDS_CORE_IDENTITY_VERSION_2 &&
> +	    pdsc->dev_ident.capabilities &
> +		cpu_to_le64(PDS_CORE_DEV_CAP_PLDM_FW_UPDATE))
> +		err = pdsc_pldm_firmware_update(pdsc, params, extack,
> +						params->fw);
> +	else
> +		err = pdsc_legacy_firmware_update(pdsc, params->fw, extack);

[Severity: High]
Does this fallback path ignore the requested component name?

If the device does not support PLDM, the driver falls back to
pdsc_legacy_firmware_update() which only takes the params->fw pointer.
If a user requested a targeted component update using devlink, this would
ignore the component filter and flash the entire monolithic image onto
the device.

Should this explicitly check if params->component is set before falling
back, and return -EOPNOTSUPP if a component is specified on legacy
firmware?
