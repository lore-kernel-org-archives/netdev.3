Received: from out-181.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63739479B
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912764; cv=none; b=Xh6v8GEmDf/HLvnFTPE7ohsZp5Z84uyVzR5ASnvKBoRc0twHpNCdv/6X1Ms9MdFotzEPs5cWpksv0n729HZRYqCI8Rep0uj7GVResvcpPrNCrzbSHcNUUAmtdpkGSzSCcuEYBtNGBq4vpRKWFPTc//f5LPaYpV6K3iHieTn5MpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912764; c=relaxed/simple;
	bh=+Q/XUBV4cPag/MTnBRCqk9fw4LkbYaGcZrVKJHxyUnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcvXye8LPkPtf3NV5AXA1z0VThEE4lEwx/MFGAZDRh5fild/M1uG06vUohFGccRnTTYDJ4HCiJUdDobEn57Zg2T76UAlDA/AHRAlgTGlz+TyWaVRV9uzuOgMMCCLeNNu/+P2PHIcV5bAbrPG1X+n0qRZLfH04j+fZGe7bvWzZfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XNPZ1m9f; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XNPZ1m9f"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785912760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=voVYWcFM1kEMQjXsalubElGlOKY9nudK4aM5HFKA5iM=;
	b=XNPZ1m9fQUrcQUiI0/BXgOQFs6omQes+iELI7Xi5v4BwgUqwtpkYqXovgRZrFP9RvLDygH
	Y4/lNqdKAdfWDnpplPYpWMuWm1n9LH8f2n5w2wtRHlShiD3NUgMpbv6GEmiixDr+CwHACk
	1s27wItEiGORl4FLgdyXnwNMF2DyL0A=
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
Subject: [PATCH iwl-net v2 2/5] i40e: serialize timestamp configuration with PTP teardown
Date: Wed,  5 Aug 2026 14:51:29 +0800
Message-ID: <20260805065132.148625-3-xuanqiang.luo@linux.dev>
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

i40e_remove() can call i40e_ptp_stop() without the networking locks held.
A concurrent hardware timestamp request can observe I40E_FLAG_PTP_ENA
before teardown clears it, then program PRTTSYN_CTL0 after teardown has
disabled the event source. This can leave time sync interrupts enabled
during device removal.

Add ptp_config_lock to serialize the enable check and register programming
in i40e_ptp_hwtstamp_set() with the PTP state transition in
i40e_ptp_stop(). Requests which observe PTP enabled finish programming
before the state transition; later requests return -EOPNOTSUPP and cannot
re-enable the interrupt.

Fixes: 1050713026a0 ("i40e: add support for PTP external synchronization clock")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 17 +++++++++++++----
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 4c8bcaa9dd192..84564d747d09a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -668,6 +668,8 @@ struct i40e_pf {
 	struct timespec64 ptp_prev_hw_time;
 	struct work_struct ptp_extts0_work;
 	ktime_t ptp_reset_start;
+	/* Serializes timestamp configuration with PTP teardown. */
+	struct mutex ptp_config_lock;
 	struct mutex tmreg_lock; /* Used to protect the SYSTIME registers. */
 	u32 ptp_adj_mult;
 	u32 tx_hwtstamp_timeouts;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0a259351c127e..8c28788ac634f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12819,6 +12819,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 			 "total-port-shutdown was enabled, link-down-on-close is forced on\n");
 	}
 	mutex_init(&pf->switch_mutex);
+	mutex_init(&pf->ptp_config_lock);
 	spin_lock_init(&pf->ptp_tx_lock);
 
 sw_init_done:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 224568a3af085..f194869947124 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -1328,17 +1328,23 @@ int i40e_ptp_hwtstamp_set(struct net_device *netdev,
 	struct i40e_pf *pf = np->vsi->back;
 	int err;
 
-	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags))
-		return -EOPNOTSUPP;
+	mutex_lock(&pf->ptp_config_lock);
+
+	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags)) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
 
 	err = i40e_ptp_set_timestamp_mode(pf, config);
 	if (err)
-		return err;
+		goto unlock;
 
 	/* save these settings for future reference */
 	pf->tstamp_config = *config;
 
-	return 0;
+unlock:
+	mutex_unlock(&pf->ptp_config_lock);
+	return err;
 }
 
 /**
@@ -1558,6 +1564,8 @@ void i40e_ptp_stop(struct i40e_pf *pf)
 	struct sk_buff *skb;
 	u32 regval;
 
+	mutex_lock(&pf->ptp_config_lock);
+
 	spin_lock_irqsave(&pf->ptp_tx_lock, flags);
 	clear_bit(I40E_FLAG_PTP_ENA, pf->flags);
 	pf->ptp_tx = false;
@@ -1566,6 +1574,7 @@ void i40e_ptp_stop(struct i40e_pf *pf)
 	spin_unlock_irqrestore(&pf->ptp_tx_lock, flags);
 
 	pf->ptp_rx = false;
+	mutex_unlock(&pf->ptp_config_lock);
 
 	if (skb)
 		dev_kfree_skb_any(skb);
-- 
2.43.0

