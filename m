Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8762F8EBE
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816248; cv=none; b=pztXhZ5oXk9Vn6ENVLc8uMA8GNryw/w/NNZck+Ye9205c7ZozSOvFMausmvJqSCLTO3EkVy/Kc8jvBv75KFVsrPTFG8/CM2u8KCRpMVx/B2qc+9AhyWIEhWowAcVMvDLAS+0gEtRH+d11LL+0/nntVt0gHxL95Wm59z/7n+fTRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816248; c=relaxed/simple;
	bh=k7kOfkWyrIIQDo5EBfvPByenOT+paR+TxTKc+NExxaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIUg5GWV5Hd4KpMqzptQwJJePssQOWyKbxffaaIX/1tmjS0soMY+5+Xim3p0ggaGq/UWFtyWljwCNgJTv8EPTszISwWbIBgyGL+RDJXBhJGcBvOwpcCSIBYlASwN0YyGctFJ43Uk238wZJjjecHJLPU7CeIluaBephd+czIdTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FF01F000E9;
	Thu, 23 Jul 2026 14:17:22 +0000 (UTC)
From: Jakub Kicinski <kuba@kernel.org>
To: nikhil.rao@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	brett.creeley@amd.com,
	eric.joyner@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net v2] pds_core: keep the health thread stopped during reset
Date: Thu, 23 Jul 2026 07:17:20 -0700
Message-ID: <20260723141720.623532-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722001621.22527-1-nikhil.rao@amd.com>
References: <20260722001621.22527-1-nikhil.rao@amd.com>
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
--- Patch [1]: [PATCH net v2] pds_core: keep the health thread stopped during reset ---
commit 253bc338bd6e7dd7e1be6b7664ab1b26f176624e
Author: Nikhil P. Rao <nikhil.rao@amd.com>

pds_core: keep the health thread stopped during reset

This commit replaces cancel_work_sync() with disable_work_sync() for the
health thread to ensure it doesn't get re-queued by a timeout during reset.
It then restarts the thread using enable_work().

Link: https://sashiko.dev/#/patchset/20260629200358.2626129-1-nikhil.rao%40amd.com?part=2

> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
> index 8d94a4d70395e..ccb8aa7b95f7e 100644
> --- a/drivers/net/ethernet/amd/pds_core/main.c
> +++ b/drivers/net/ethernet/amd/pds_core/main.c
> @@ -471,7 +471,7 @@ static void pdsc_stop_health_thread(struct pdsc *pdsc)
>  
>  	timer_shutdown_sync(&pdsc->wdtimer);
>  	if (pdsc->health_work.func)
> -		cancel_work_sync(&pdsc->health_work);
> +		disable_work_sync(&pdsc->health_work);

[Severity: High]
Could this lead to an unbalanced disable count during an Advanced Error
Reporting (AER) reset?

Unlike cancel_work_sync(), disable_work_sync() increments a depth counter.
During an AER fatal error, pdsc_pci_error_detected() manually invokes
pdsc_reset_prepare(), which calls pdsc_stop_health_thread(), setting the
disable count to 1.

Later, the AER resume path in pdsc_pci_error_resume() calls
pci_reset_function_locked(), which internally calls the driver's
.reset_prepare callback a second time:

drivers/pci/pci.c:pci_reset_function_locked() {
	pci_dev_save_and_disable(dev);
	rc = __pci_reset_function_locked(dev);
	pci_dev_restore(dev);
}

Because pci_dev_save_and_disable() invokes the driver's .reset_prepare,
the disable count increments to 2. However, pci_dev_restore() only triggers
.reset_done once, which means enable_work() is only called once.

Will this leave the health work item permanently disabled (with a count of 1),
preventing the driver from monitoring firmware health or triggering future
recoveries?
-- 
pw-bot: cr
