Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20079381EB6
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653003; cv=none; b=vDjgAxj5iZPHvv/o1AhFkvcbQV7r+GtgbvySD8f0gEcBg2EAdRIaHpLE2NBJfMYBuEfDJi5Op7Ka/l0ZeCpjQriPTq0QMTwfmmU9u5fTzC3cOm4EF195pCHFM4YJiZB4IZ3SRFyQTTFEj/f3eNupV5BfNCrRFpc4dXe4YIV5NDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653003; c=relaxed/simple;
	bh=NMF8U6NT7BoEAPP6gLGKXHeS44ZkBY12dNZw6ybPtbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6jixzEz1yRcUk62C5dkkie1i3svDwksDVT2iHcblxdafjTu9dgT9XfKIcx4lW3stf36McwJ1+DIxlHgAYGulKaATARwdaoRqf/EbHT571irzLvnNgq1v8pn+zj9efa1UuWGPN3fH5EYKu2Lc2qQX/BQAMl7ddL05gYd27okgHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1lNEES9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1lNEES9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6181F000E9;
	Tue, 21 Jul 2026 16:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653001;
	bh=ZrWAfW15RpqB3xMmNCWCTpoi7DNEOWBCZIKqAXg2xjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M1lNEES9nY77LziqArCY7MAJ7BRcUFTU2CdRw7ioWEzg52mhoz6ilw1/zYPFFjZD3
	 wQBYvqSc/LPC0ynu1KI8MZ7Hp2/nUoC/4NpEx25InTib8Xed0uphHszl0AX39jLJd4
	 1V+eg+uBBQstJCuHiizJMw21g5F63X43av8AU/Lhqgk5MPCq2Wbz74ZTb3+L2MNQuj
	 2ykVqQtRq/VxzNzS/XxD0WEFz57PF7GDJCXPGQgwJl7e74wvrnnUV8enh1p5/KX7HA
	 LITrtDo75iP0WJDgK9AkTcAk3nnpsSeNdNeeSSW7J2gn9PTwXS+z3rZ1cuyALLA3Hd
	 T9IdMcUI6YgjA==
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
	pabeni@redhat.com
Subject: Re: [PATCH net v3 1/2] pds_core: fix deadlock between reset thread and remove
Date: Tue, 21 Jul 2026 17:55:13 +0100
Message-ID: <20260721165512.423561-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714180223.1642792-2-nikhil.rao@amd.com>
References: <20260714180223.1642792-2-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260714180223.1642792-2-nikhil.rao@amd.com?part=1
---
--- Patch [1]: [PATCH net v3 1/2] pds_core: fix deadlock between reset thread and remove ---
commit e973ecbe07b7edd4ed406cf37388217ed5a167be
Author: Nikhil P. Rao <nikhil.rao@amd.com>

pds_core: fix deadlock between reset thread and remove

This commit switches the PCI reset function in pdsc_pci_reset_thread() to
use pci_try_reset_function(). This avoids a deadlock that occurs when
pdsc_remove() holds the device_lock while waiting for destroy_workqueue()
to complete.

Link: https://patchwork.kernel.org/comment/27002369/

> pci_reset_function() acquires device_lock before performing the reset.
> pdsc_remove() is called by the PCI core with device_lock already held.
> If pdsc_pci_reset_thread() is running when pdsc_remove() is called,
> destroy_workqueue() will block waiting for the work to complete, while
> the work is blocked waiting for device_lock - deadlock.
> 
> Use pci_try_reset_function() which uses pci_dev_trylock() internally.
> This acquires both the device lock and the PCI config access lock
> without blocking - if either lock is contended, it returns -EAGAIN
> immediately. This avoids the deadlock while also ensuring proper
> config space access serialization during the reset.
> 
> The pci_dev_get/put calls are also removed as they were unnecessary -
> the driver-owned workqueue is destroyed in pdsc_remove(), guaranteeing
> the work completes before remove returns. The PCI core holds its
> reference to pci_dev throughout the entire unbind sequence.

[Severity: High]
This is a pre-existing issue, but since we rely on destroy_workqueue() 
during pdsc_remove(), does this leave a dangling pointer that can be 
accessed during teardown?

In pdsc_remove(), destroy_workqueue(pdsc->wq) is called but pdsc->wq is 
not set to NULL. Immediately after, pdsc_remove() calls pdsc_teardown() 
which calls pdsc_devcmd_reset(). If the firmware is unresponsive, 
pdsc_devcmd_wait() times out and pdsc_devcmd_locked() will unconditionally 
evaluate if (pdsc->wq), which remains true, and attempt to queue health work.

Additionally, hardware interrupts are not fully masked until pdsc_stop() 
is called after destroy_workqueue(). Could an interrupt arriving during this 
narrow window cause pdsc_adminq_isr() to race and call 
queue_work(pdsc->wq, &qcq->work) on the destroyed workqueue?

> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
> index 38a2446571afa..1074a022a52fb 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.c
> +++ b/drivers/net/ethernet/amd/pds_core/core.c
> @@ -606,9 +606,10 @@ void pdsc_pci_reset_thread(struct work_struct *work)
>  	struct pdsc *pdsc = container_of(work, struct pdsc, pci_reset_work);
>  	struct pci_dev *pdev = pdsc->pdev;
>  
> -	pci_dev_get(pdev);
> -	pci_reset_function(pdev);
> -	pci_dev_put(pdev);
> +	/* Use try variant to avoid deadlock with pdsc_remove().
> +	 * If lock is contended, the watchdog timer will retry.
> +	 */
> +	pci_try_reset_function(pdev);

[Severity: High]
This is a pre-existing issue, but could this uncancelled work item perform 
an uncoordinated PCI reset if it executes after an AER recovery?

When a PCI error is detected, pdsc_health_thread() queues pci_reset_work. 
If the PCI core independently initiates AER recovery before this work executes, 
it calls pdsc_reset_prepare(), which then calls pdsc_stop_health_thread().

While pdsc_stop_health_thread() cancels health_work, it does not appear to 
cancel this already-queued pci_reset_work. 

Because the AER thread holds the device lock during recovery, if this work 
is delayed and executes after AER recovery completes and releases the lock, 
will pci_try_reset_function() successfully acquire the lock and perform a 
hardware reset while the driver thinks the device is actively running?
