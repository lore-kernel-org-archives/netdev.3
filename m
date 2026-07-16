Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1668C38AC90
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 07:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186596; cv=none; b=uTU+A8K3TLdxldr6RjICIQEfck94eKbSYJHBx01Ur3Eut3KwhMp8UjI+r3APC1s6MWjaClXRjfGJ8MTrjfmyG9Sqpi0j1lTP1rslWsxR5HV/ew/smtppKekOTd/t5xLGHUmLTP3oLOZYw4gIli1kLfGyYXPGpQHXXqdryqFBo8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186596; c=relaxed/simple;
	bh=DTS9s2zQUvhm8YwKonN0KjvlmpTlhvxOoRTV4wXVPZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPGp+A2XGV5StgPUgJkAaBWjqlU7v7YriMW+asyyYKHYQswiBitAE+HnEx0t2sl61EZp//6hLklsD5L48smhbc2h4jS7i27bs6yJZh+Y4gV1akAMmOBZz8xih99lF1TZ6EHlVNx3w287yj/wLurIQ59u89D/YmGK9dvuvJTilHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qgug8mII; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qgug8mII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EDD1F000E9;
	Thu, 16 Jul 2026 07:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784186587;
	bh=Uxj+upEb4p+lImYmOB6aMg273tRKgEBTzWALRpOChcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qgug8mIIUDphcYQ3tbq4o0V1gUcmrjt9PvbawUjqR4bUxprF5NGQKQ5InxvE0KdZp
	 /R8WrQuzq8I5EhBtjJU8WnseTfhrHRa81gX0rlAONA6kfN2GpEbMdsIeRKyyoDWkDR
	 zAZy0kqpCLu8/V4tadC2HDsFwi/uxzLEbe9c7HmZ3V4mSSsnDo1xgKMkGmDJQgjF3C
	 zyEKGIjpFu1nWJpMsF7gEddMfAeZvcBVsrRLHCZsEu0cdQC1dEeRIqfUNcTyC2imBF
	 E159wrYxIJsnsZCyA/JXnKbYrerr/3RxC0SACL+i2w/2Qp/s18frDSJ4d+CvwtX/UP
	 DwK5JrRqIyqAw==
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
Subject: Re: [PATCH 4/6] pds_core: add PLDM component info display
Date: Thu, 16 Jul 2026 08:22:49 +0100
Message-ID: <20260716072248.190353-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708212222.296202-5-nikhil.rao@amd.com>
References: <20260708212222.296202-5-nikhil.rao@amd.com>
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
--- Patch [4]: [PATCH 4/6] pds_core: add PLDM component info display ---
commit 4d0cc8aef76c7e2e30f98535495312200941b646
Author: Brett Creeley <brett.creeley@amd.com>

pds_core: add PLDM component info display
    
Add detailed component information display via devlink info. This
allows users to see individual firmware components and their versions.
Components are reported as fixed, running, or stored based on their
firmware-provided flags.

> diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
> index 3b763ee1715ee..63fe45e91f710 100644
> --- a/drivers/net/ethernet/amd/pds_core/devlink.c
> +++ b/drivers/net/ethernet/amd/pds_core/devlink.c

[ ... ]

> +static int pdsc_dl_component_info_get(struct devlink *dl,
> +				      struct devlink_info_req *req,
> +				      struct netlink_ext_ack *extack)
> +{
> +	struct pdsc *pdsc = devlink_priv(dl);
> +	u8 num_components;
> +	int err;
> +	int i;
> +
> +	/* Pairs with WRITE_ONCE in pdsc_fw_components_invalidate().
> +	 * Use READ_ONCE to get a consistent snapshot of num_components.
> +	 * pdsc_fw_components_invalidate() can zero it concurrently during
> +	 * firmware recovery; using the local copy avoids iterating zero
> +	 * times when we already decided the cache was valid.
> +	 */
> +	num_components = READ_ONCE(pdsc->fw_components.num_components);
> +	if (!num_components) {
> +		err = pdsc_get_component_info(pdsc);

[Severity: High]
Does this code expose uninitialized memory to concurrent readers?

If two threads execute this concurrently after the firmware component list
has been invalidated, one thread could enter pdsc_get_component_info(),
which updates the count before the array is populated:

drivers/net/ethernet/amd/pds_core/fw.c:pdsc_get_component_info() {
    ...
	pdsc->fw_components.num_components = num_components;
	for (i = 0; i < num_components; i++) {
		struct pds_core_fw_component_info *info =
			&pdsc->fw_components.info[i];

		memcpy(info, &list_info->info[i], sizeof(*info));
    ...
}

A second thread could concurrently execute pdsc_dl_component_info_get(), see
num_components > 0 via READ_ONCE(), and proceed to iterate over the array
while the first thread is still executing memcpy() into the array.

Could this be addressed by moving the update of num_components to after the
array population is complete, perhaps using smp_store_release() and
smp_load_acquire() to ensure proper ordering?

> +		if (err)
> +			return pdsc_dl_report_fw_ver(req,
> +						    pdsc->dev_info.fw_version);
> +		num_components = READ_ONCE(pdsc->fw_components.num_components);
> +		if (!num_components)
> +			return pdsc_dl_report_fw_ver(req,
> +						    pdsc->dev_info.fw_version);
> +	}
> +
> +	num_components = min_t(u16, num_components,
> +			       le16_to_cpu(pdsc->dev_ident.max_fw_slots));
> +	for (i = 0; i < num_components; i++) {
> +		err = pdsc_dl_report_component(req,
> +					       &pdsc->fw_components.info[i]);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
