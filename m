Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC98C3E0732
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912786; cv=none; b=pG9x+l5yqN0gBx12MprgzqYyNgFc2tYaWX+X3wLfE6BPaUcGXisBhPiZzUsFmS92DG12SrmTPWnHyRBJcdZfga887XgHQv+L3DujD1gv75aMtm4j7F8vhrFqwKmvMXGFHNR30FgVx6CTNKNwUefnxm4s6Xxi0vQWQSXvzf0Af+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912786; c=relaxed/simple;
	bh=UWh8p8c9Bx5Mot/mVtEsBdsA0FooCdrKhDS6oRIkoLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFqg4a6RSPRMf9FxGaJYXh8x150BUlJl5XrgXWvQeAgPjk72oih+shyY6WswkKV6dMPppX47kMDvAAyljCFnTwDmihc06FtYdMILUXP8ELaCSe0sqJaXgMrd4ic0C7IAcfv4SjUccf4FYtYyOm5HPBAGvVVZ5LHbiPH2qzx8q1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X9gdgtbA; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X9gdgtbA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785912779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+EQTtWgrsaKUEW5GmngOUgOvaosfIxELLzA0tSOpboA=;
	b=X9gdgtbAHDOHcJD7LZ8khRbKH3lPNb/Hp6VX1wNFDxK74t3E1AN3u6lO9O1m7wBfphdgWe
	vyV8iTkAufGtZacL0w04rOEP6LVV8/lnutjO4SVEeyu+aT4RdpkyBF3iqHNpsN1ON/8pOR
	uEZ57ObN4QbwZpIX6s4+S9OfukQySv8=
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
Subject: [PATCH iwl-net v2 5/5] i40e: fix races in PTP external timestamp work handling
Date: Wed,  5 Aug 2026 14:51:32 +0800
Message-ID: <20260805065132.148625-6-xuanqiang.luo@linux.dev>
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

The time sync interrupt queues ptp_extts0_work, which reads device
registers and reports events through pf->ptp_clock. i40e_ptp_stop()
unregisters the PHC before disabling the event source or draining the
work. The worker can therefore use the clock or PF after either has been
freed.

Move the event-source shutdown before PHC unregister. i40e_ptp_stop()
first clears I40E_FLAG_PTP_ENA under ptp_config_lock, so timestamp
configuration cannot re-enable the source after the lock is released.
Then call disable_work_sync() to reject later queue attempts and drain
work already pending or running.

INIT_WORK() is currently called from i40e_ptp_set_timestamp_mode(), which
runs on reset and whenever timestamping is reconfigured. Reinitializing
pending or running work can corrupt its workqueue state. Initialize the
work once from i40e_sw_init() instead.

Fixes: 1050713026a0 ("i40e: add support for PTP external synchronization clock")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 25 +++++++++++++++------
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 84564d747d09a..18452f9aa74e1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1318,6 +1318,7 @@ int i40e_ptp_hwtstamp_set(struct net_device *netdev,
 			  struct netlink_ext_ack *extack);
 void i40e_ptp_save_hw_time(struct i40e_pf *pf);
 void i40e_ptp_restore_hw_time(struct i40e_pf *pf);
+void i40e_ptp_init_work(struct i40e_pf *pf);
 void i40e_ptp_init(struct i40e_pf *pf);
 void i40e_ptp_stop(struct i40e_pf *pf);
 int i40e_ptp_alloc_pins(struct i40e_pf *pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c19d4c81d6532..48ba38a452d0b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12822,6 +12822,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	}
 	mutex_init(&pf->switch_mutex);
 	mutex_init(&pf->ptp_config_lock);
+	i40e_ptp_init_work(pf);
 	spin_lock_init(&pf->ptp_tx_lock);
 
 sw_init_done:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index f194869947124..5f15a3d4a91ed 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -169,6 +169,17 @@ static void i40e_ptp_extts0_work(struct work_struct *work)
 	ptp_clock_event(pf->ptp_clock, &event);
 }
 
+/**
+ * i40e_ptp_init_work - Initialize PTP work for a PF
+ * @pf: Board private structure
+ *
+ * Initialize work which must remain valid for the lifetime of the PF.
+ */
+void i40e_ptp_init_work(struct i40e_pf *pf)
+{
+	INIT_WORK(&pf->ptp_extts0_work, i40e_ptp_extts0_work);
+}
+
 /**
  * i40e_is_ptp_pin_dev - check if device supports PTP pins
  * @hw: pointer to the hardware structure
@@ -1201,8 +1212,6 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
 	regval |= 1 << I40E_PRTTSYN_CTL0_EVENT_INT_ENA_SHIFT;
 	wr32(hw, I40E_PRTTSYN_CTL0, regval);
 
-	INIT_WORK(&pf->ptp_extts0_work, i40e_ptp_extts0_work);
-
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		pf->ptp_tx = false;
@@ -1576,6 +1585,13 @@ void i40e_ptp_stop(struct i40e_pf *pf)
 	pf->ptp_rx = false;
 	mutex_unlock(&pf->ptp_config_lock);
 
+	/* Stop external timestamp events before unregistering the clock. */
+	regval = rd32(hw, I40E_PRTTSYN_CTL0);
+	regval &= ~I40E_PRTTSYN_CTL0_EVENT_INT_ENA_MASK;
+	wr32(hw, I40E_PRTTSYN_CTL0, regval);
+
+	disable_work_sync(&pf->ptp_extts0_work);
+
 	if (skb)
 		dev_kfree_skb_any(skb);
 
@@ -1596,10 +1612,5 @@ void i40e_ptp_stop(struct i40e_pf *pf)
 	regval &= ~I40E_PRTTSYN_AUX_0_PTPFLAG_MASK;
 	wr32(hw, I40E_PRTTSYN_AUX_0(0), regval);
 
-	/* Disable interrupts */
-	regval = rd32(hw, I40E_PRTTSYN_CTL0);
-	regval &= ~I40E_PRTTSYN_CTL0_EVENT_INT_ENA_MASK;
-	wr32(hw, I40E_PRTTSYN_CTL0, regval);
-
 	i40e_ptp_free_pins(pf);
 }
-- 
2.43.0

