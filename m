Received: from out-173.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611123E075C
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912782; cv=none; b=qOuukYBS3V7st0dIi+jxTMif17PiZ9UFmUJuVPexFgafESQEdA+IRfLKD6gykHSre/Uq+dN/xhzjG6V9G6CK6BnwqEjsGqQNzIO2fgCSOyX3ugrvyitk1weCDtZKwRIbFlUKowL8SYOh2hb0aJF0E0ADJ2jLO5ry5qRH2ylkrnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912782; c=relaxed/simple;
	bh=fzRgT138klYBwv2/PbdKZQeeX1Pn3lh9h3Ocl4rRsvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P31HI2O+36OFe9pcgZ1Emck9dqR3C5bqps/Tt36pF0EItoY/zaE65Rtt33WFDHD402Rw9MsMVRQwxHoQLie7C0Sbb2hEzugRib5hr3sKzwbjWJPiNsVdwxRKqskkBd1gCODE0Hgdz4fqIzlzJf76wvzOfGF6/s4z8Q6Fj2cEhWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bsWU14Pj; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bsWU14Pj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785912774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJB8I4mT/6RVCSNdvG8ug/nQxSFqGts4V2K/DAvG5QY=;
	b=bsWU14PjrosZV0DY758SKnNeZWdkobizWYH5amkVz63OaOxRAQgxT+26C/ONSxFsLhiyEv
	WCjFcr/kFQMqjuLopex3jYaUc16FBm6Yshn3cp9Kj5WZRK1CxQw2R1VEKAqXLrCIDLC/F0
	YBsGUFRULn/AGMF9fycdUIHJw8gTHOg=
From: xuanqiang.luo@linux.dev
To: intel-wired-lan@lists.osuosl.org,
	horms@kernel.org
Cc: vadim.fedorenko@linux.dev,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	piotr.kwapulinski@intel.com,
	arkadiusz.kubalewski@intel.com,
	aleksandr.loktionov@intel.com,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH iwl-net v2 4/5] i40e: replace reset polling with wait-bit synchronization
Date: Wed,  5 Aug 2026 14:51:31 +0800
Message-ID: <20260805065132.148625-5-xuanqiang.luo@linux.dev>
In-Reply-To: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
References: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

i40e_remove() polls on RESET_RECOVERY_PENDING with a fixed sleep while
waiting for an existing reset owner. This adds teardown latency and does
not provide a wait queue for the reset owner to wake.

Use wait_on_bit_lock() so removal sleeps until the reset owner releases the
bit and then atomically claims it. Pair the reset release paths with
clear_and_wake_up_bit() to provide the required release and wakeup
semantics.

Fixes: 5b6d4a7f20b0 ("i40e: Fix crash during removing i40e driver")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5922f83f324ae..c19d4c81d6532 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7,6 +7,7 @@
 #include <linux/if_bridge.h>
 #include <linux/if_macvlan.h>
 #include <linux/module.h>
+#include <linux/wait_bit.h>
 #include <net/pkt_cls.h>
 #include <net/xdp_sock_drv.h>
 
@@ -10822,7 +10823,8 @@ static int i40e_reset(struct i40e_pf *pf)
 	if (ret) {
 		dev_info(&pf->pdev->dev, "PF reset failed, %d\n", ret);
 		set_bit(__I40E_RESET_FAILED, pf->state);
-		clear_bit(__I40E_RESET_RECOVERY_PENDING, pf->state);
+		clear_and_wake_up_bit(__I40E_RESET_RECOVERY_PENDING,
+				      pf->state);
 	} else {
 		pf->pfr_count++;
 	}
@@ -11115,7 +11117,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 end_core_reset:
 	clear_bit(__I40E_RESET_FAILED, pf->state);
 clear_recovery:
-	clear_bit(__I40E_RESET_RECOVERY_PENDING, pf->state);
+	clear_and_wake_up_bit(__I40E_RESET_RECOVERY_PENDING, pf->state);
 	clear_bit(__I40E_TIMEOUT_RECOVERY_PENDING, pf->state);
 }
 
@@ -16169,8 +16171,8 @@ static void i40e_remove(struct pci_dev *pdev)
 		disable_work_sync(&pf->service_task);
 
 	/* Wait for any reset owner before tearing down device resources. */
-	while (test_and_set_bit(__I40E_RESET_RECOVERY_PENDING, pf->state))
-		usleep_range(1000, 2000);
+	wait_on_bit_lock(pf->state, __I40E_RESET_RECOVERY_PENDING,
+			 TASK_UNINTERRUPTIBLE);
 	set_bit(__I40E_IN_REMOVE, pf->state);
 
 	i40e_dbg_pf_exit(pf);
-- 
2.43.0

