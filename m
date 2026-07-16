Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B93AA1B0
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186615; cv=none; b=NbAZZQ+gFfUO/MX7nN86RZaj7XnmT8feaD0fv86D/3jENCOJlG/bnDbVSC+0cVmAiIkB6wQb/8U5EmGjLAsuqv0WQLJbXNtSOibEXLZ2kgViOQEaU69xhZ+KyJQgz8nXIon61T0liUV9khbE/wHN2IQv7Dsjq8IvLI8nwlK7OCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186615; c=relaxed/simple;
	bh=Qj93WcIf0roTA+UVGrxKqKVHv9uIT7q9yB6krGE2dXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDyrSjhHTvJ6xBfRXkO4z4XKQXJ7v1f4iY8ZyNgVXurEcNDCg3XHqaP9shd/LdHo3OhQoFENzMYP4LNzThxgOKaF+toG+3YgADJuli3Y5IFZgxwxNFVf2sMdjl8/LKSPHZ3qTzeCeCF2gXcFBEL7EXnTydAurHeAZpWsoUkmnmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAcHFnt/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAcHFnt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3BA1F000E9;
	Thu, 16 Jul 2026 07:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784186602;
	bh=p24jZ2ZMlRf79TdHC+v9jF63crGEdKFlpawhSZZaWgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XAcHFnt/Le+2eqPaSU22+Jo2dLIUh9C3lDgK+Asr8X0Ct5SE4ivo2Qj/TZ5NotYAe
	 bPTQ0H/zPLE6sBNHh+SRJm1Qn/1l11unpccM0eyGPy4IKCVTM6yoA2f0udNsLXRvij
	 unJ8qTxyKdHw2jUeqKO9NKoplGUUN+j0sekkh7TqRV/aIQHnLKpxPTSzZUhyCzwMjf
	 Myy+DcX226pWHUHUZG3/6jqkWBi575bSFbyolHCzkcWeMdOwC7NgLLAeGGFkJpWl2z
	 bAeVERWroVXpBEy60fN5J2wO7pIaMnM+ZdaWJjjlKjFXL29slLvMLsil4T8creqY/K
	 4neIWQYwlQk+g==
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
Subject: Re: [PATCH 5/6] pds_core: add host backed memory support for firmware
Date: Thu, 16 Jul 2026 08:23:13 +0100
Message-ID: <20260716072313.192902-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708212222.296202-6-nikhil.rao@amd.com>
References: <20260708212222.296202-6-nikhil.rao@amd.com>
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
--- Patch [5]: [PATCH 5/6] pds_core: add host backed memory support for firmware ---
commit 0970ce1c8fa02a37c722e99472916638286b6ad9
Author: Nikhil P. Rao <nikhil.rao@amd.com>

pds_core: add host backed memory support for firmware

Some newer AMD/Pensando cards have minimal memory and there are cases
where components, specifically in the control plane, need more memory.
This series adds support for host backed DMA memory that can be used
by the firmware for the previously mentioned cases.

> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
> index a7a0bcf98ed3f..356a69c895b63 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.c
> +++ b/drivers/net/ethernet/amd/pds_core/core.c

[ ... ]

> @@ -673,3 +675,161 @@ void pdsc_health_thread(struct work_struct *work)

[ ... ]

> +static int pdsc_host_mem_add_one(struct pdsc *pdsc, int index)
> +{
> +	struct pdsc_host_mem *hm = &pdsc->host_mem_reqs[index];
> +	union pds_core_dev_comp comp = {};
> +	union pds_core_dev_cmd cmd = {};
> +	int err;

[ ... ]

> +	/* Track this allocation so pdsc_host_mem_free() can clean it up */
> +	pdsc->num_host_mem_reqs++;
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +	memset(&comp, 0, sizeof(comp));
> +	cmd.host_mem.opcode = PDS_CORE_CMD_HOST_MEM;
> +	cmd.host_mem.oper = PDS_CORE_HOST_MEM_ADD;
> +	cmd.host_mem.tag = cpu_to_le16(hm->tag);
> +	cmd.host_mem.size = cpu_to_le32(hm->size);
> +	cmd.host_mem.buf_pa = cpu_to_le64(hm->pa);
> +
> +	dev_dbg(pdsc->dev, "Sending devcmd for mem add tag %d size %d pa %pad\n",
> +		hm->tag, hm->size, &hm->pa);
> +	err = pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
> +	if (err || comp.status != PDS_RC_SUCCESS) {
> +		dev_err(pdsc->dev, "mem add failed err %d status %d for tag %d\n",
> +			err, comp.status, hm->tag);
> +		err = err ? err : -EIO;
> +		goto err_del;
> +	}
> +	dev_dbg(pdsc->dev, "mem add completed for tag %d\n", hm->tag);
> +
> +	return 0;
> +
> +err_del:
> +	/* After MEM_QUERY succeeds, firmware expects MEM_ADD or MEM_DEL */
> +	pdsc_host_mem_del_one(pdsc, hm->tag, PDS_RC_ENOMEM);
> +	return err;
> +}

[Severity: Medium]
When the MEM_ADD device command fails, does this error path leave the memory
allocated and DMA mapped?

Since pdsc->num_host_mem_reqs was incremented before the command, the memory
will eventually be freed when pdsc_host_mem_free() runs at driver teardown.
However, it appears up to 4MB of memory per failed request could be held
uselessly for the entire operational runtime of the driver. 

Should the driver explicitly unmap and free the memory in this error path?

[ ... ]

> +void pdsc_host_mem_free(struct pdsc *pdsc)
> +{
> +	int i;
> +
> +	if (!pdsc->host_mem_reqs)
> +		return;
> +
> +	for (i = 0; i < pdsc->num_host_mem_reqs; i++) {
> +		dma_unmap_page(pdsc->dev, pdsc->host_mem_reqs[i].pa,
> +			       pdsc->host_mem_reqs[i].size,
> +			       DMA_BIDIRECTIONAL);
> +		__free_pages(pdsc->host_mem_reqs[i].pg,
> +			     pdsc->host_mem_reqs[i].order);
> +	}
> +
> +	kfree(pdsc->host_mem_reqs);
> +	pdsc->host_mem_reqs = NULL;
> +	pdsc->num_host_mem_reqs = 0;
> +}

[Severity: High]
Does this code risk leaving the firmware with dangling DMA addresses?

The loop unmaps and frees the provisioned host memory pages, but it doesn't
appear to send a corresponding PDS_CORE_HOST_MEM_DEL device command to notify
the firmware that the memory has been revoked.

While pdsc_teardown() sends an explicit reset command for Physical Functions,
it skips this step for Virtual Functions. If a VF frees memory without sending
a MEM_DEL command, could the firmware still attempt to access the freed memory,
resulting in IOMMU faults or use-after-free corruption?
