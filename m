Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B61B40758E
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548793; cv=none; b=aiGxeTDOgmzkfsd69voj16sVB3HYOQRLtTcSOmW18rXLstqs+sD36x12qJNExJp1ivcxBzER9+SgBnVwN25aE6Q0kFkcAH6GtbbqLdmn+n+yJc9huWJWssW3fe0So7ffwIIsaWiY3DAKepQncXVggrJkfpOU3/DEbERfLd/CVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548793; c=relaxed/simple;
	bh=3Qa1md3gpL9jsIYZbhz9+7TaVde+9fOYEFgulqhfeJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=in3sxPU3xC4AKVbDJncCM/9T5zW1STRY9RCg3LnyKfNV6/Sff8B3e4jPvISfUuftkISDW4tFStepTSrQZngKmVaNBM/Zw6vUnB5MTfp+5/6bzQFFN/4r+R9zDD/FYf0dxrGgWwyJf6WTUs7CsU1oiuBWpC5CsTXQRE7IZSRy2P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUAd1Zww; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUAd1Zww"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784548792; x=1816084792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Qa1md3gpL9jsIYZbhz9+7TaVde+9fOYEFgulqhfeJg=;
  b=HUAd1ZwwPFG5YvBeNE0taz6ojrC+90t8IETuEf/Vm0Lx+fzxx4/iBqh0
   eEdMTIhXhXQ2MZrMt394pDKeeF8KC2e1zBjt5wcjKW6K6bg/g5eRKO4BO
   qdcRpQq3O4W/qXgThbOEqPMsVDSpnL9WHogmN8ketArwv3YFk0tN+Es8z
   uz4ywXUmxmYbqx3kEqAjUCBAtipC8HaR6eiNyQKsFxizP98j8EgnTSKrB
   YWMr2I+BrhDhJs+2wAGcIpgxAJUQX1k5n3+JMZ/KqIbOu1ViNoOGItYm+
   n9X/yKMQmfyr0iApcU60/jjJotecTKWGpS5DCTV+yzM62HTDirIJR7/hr
   g==;
X-CSE-ConnectionGUID: +YeJW0P4REqkcjMbvSsExw==
X-CSE-MsgGUID: fZwPWtx3SSK0Q7esP9mZ7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85328163"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="85328163"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 04:59:51 -0700
X-CSE-ConnectionGUID: 1UK3JgvkTpi0Wr6shGMjOQ==
X-CSE-MsgGUID: 5Xre1jopRMOrZpvlBcluFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="258078363"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by orviesa009.jf.intel.com with ESMTP; 20 Jul 2026 04:59:49 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	arkadiusz.kubalewski@intel.com,
	konstantin.ilichev@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-net 1/4] ice: keep Tx timestamps disabled until offset calibration completes
Date: Mon, 20 Jul 2026 14:01:29 +0200
Message-ID: <20260720120151.2675206-2-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720120151.2675206-1-przemyslaw.korba@intel.com>
References: <20260720120151.2675206-1-przemyslaw.korba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Do not clear the tx.calibrating flag immediately after starting the PHY
timer in ice_ptp_port_phy_restart(). Instead, keep Tx timestamps
disabled until the offset verification work (ice_ptp_wait_for_offsets)
has confirmed that both Tx and Rx PHY offsets are properly configured.

Previously, tx.calibrating was set to true, then immediately back to
false right after ice_start_phy_timer_e82x() returned. This allowed Tx
timestamp requests to be served during the window where offset
verification was still pending. Timestamps produced during this window
use uncalibrated PHY offsets and can produce incorrect values.

When ptp4l receives incorrect timestamps, it may reject them and wait
for the next sync interval (typically 1-2 seconds), compounding delays
during link cycling. This contributes to the time transmitter port
becoming unresponsive after repeated link down/up cycles.

Move the tx.calibrating = false to ice_ptp_wait_for_offsets(), after
both Tx and Rx offset configuration has completed successfully. This
ensures that Tx timestamps are only reported with properly calibrated
PHY offsets.

If ice_start_phy_timer_e82x() fails, restore calibrating to false on
the error path to prevent permanently disabling Tx timestamps when
ov_work is never queued.

Log a debug message while offset calibration is still pending, including
the specific Tx/Rx error codes to aid debugging stalled calibration.
This path is expected on every routine link-up: ov_work is first queued
with no delay and the vernier offset cannot be computed until at least
one packet has been transmitted, so the first several invocations
normally land here. Use dev_dbg() rather than a rate-limited warning to
avoid emitting KERN_WARNING on every link-up during normal operation.
Log a debug message when calibration completes successfully.

Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 36 ++++++++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 6984fe5bf033..1aa440b0639f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1149,6 +1149,7 @@ static int ice_ptp_check_tx_fifo(struct ice_ptp_port *port)
 static void ice_ptp_wait_for_offsets(struct kthread_work *work)
 {
 	struct ice_ptp_port *port;
+	unsigned long flags;
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	int tx_err;
@@ -1171,12 +1172,28 @@ static void ice_ptp_wait_for_offsets(struct kthread_work *work)
 		tx_err = ice_phy_cfg_tx_offset_e82x(hw, port->port_num);
 	rx_err = ice_phy_cfg_rx_offset_e82x(hw, port->port_num);
 	if (tx_err || rx_err) {
-		/* Tx and/or Rx offset not yet configured, try again later */
+		/* Tx and/or Rx offset not yet configured, try again later.
+		 * This is expected during normal link-up: the vernier offset
+		 * calibration cannot complete until at least one packet has
+		 * been transmitted, so the first retries routinely land here.
+		 */
+		dev_dbg(ice_pf_to_dev(pf),
+			"PTP offset not yet valid for port %u (tx_err=%d rx_err=%d)\n",
+			port->port_num, tx_err, rx_err);
 		kthread_queue_delayed_work(pf->ptp.kworker,
 					   &port->ov_work,
 					   msecs_to_jiffies(100));
 		return;
 	}
+
+	/* Tx and Rx offsets are now configured, enable Tx timestamps */
+	spin_lock_irqsave(&port->tx.lock, flags);
+	port->tx.calibrating = false;
+	spin_unlock_irqrestore(&port->tx.lock, flags);
+
+	dev_dbg(ice_pf_to_dev(pf),
+		"PTP offset valid for port %u, Tx timestamps enabled\n",
+		port->port_num);
 }
 
 /**
@@ -1259,13 +1276,20 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 
 		/* Start the PHY timer in Vernier mode */
 		err = ice_start_phy_timer_e82x(hw, port);
-		if (err)
+		if (err) {
+			spin_lock_irqsave(&ptp_port->tx.lock, flags);
+			ptp_port->tx.calibrating = false;
+			spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
 			break;
+		}
 
-		/* Enable Tx timestamps right away */
-		spin_lock_irqsave(&ptp_port->tx.lock, flags);
-		ptp_port->tx.calibrating = false;
-		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
+		/* Do not clear calibrating flag here. Tx timestamps remain
+		 * disabled until ice_ptp_wait_for_offsets() has verified
+		 * that the Tx and Rx offset calibration has completed.
+		 * Clearing it here would allow Tx timestamps to be reported
+		 * before the PHY offset registers are configured, leading
+		 * to incorrect timestamp values.
+		 */
 
 		kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
 					   0);
-- 
2.43.0

