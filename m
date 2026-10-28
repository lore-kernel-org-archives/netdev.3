Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145965;
	b=fOcbR6iShlz0tYyrn5WoJsavfUhKCFbcYwu2rmdU4NbR7j+o6FOC0adRo/YjXb/aGfP+
	 K/Qc/KrduoE1i3hhryqvOnqDBnvjbtZj7HZsGKDbu/y/D7jMI3bWtflEixlSvkWU2HtnR
	 7+UENss6JP/t4kAcean5ppHs7A7klzh3/V8e6SdF2s4bDE0hpc9M7A7K57kcSyfNPd5uN
	 fsRXwm7JxEDUl+0vjnIn/5K/IWUrecGJuJnmFwIkJCdYaPHpVhDv7zEez1HbFWTJ9oATC
	 ElDmd2l0LATcm1uRztcYsKZuR+ygmnDN/HnlFqeJxQ+0QcRXLazaNUxxmKk7mD9DInA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145965;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=YxnvFpuQ1KnuZ8BL+6SNkTYfaaxRTWi3inGN9s/26yc=;
	b=FQhi3q0tnajoqHoyBYuWPN+4NFjoROa0fQYrIG4rJHvMdGaWF+ZX2QQuRxiULuo2eBxq
	 q1juzcSvN/hwInrQG2C8U7mmPPcjfztAXHDF3Kyo9q3XN05A35J8FfskT4QfDqzvnXZH6
	 MmKo+LKchA01VTqy6vS8z4cV30R30cUKoUWgppHkdFxX8ZbKPMT9J6447dZwZJe6AjWxi
	 Li9zC4QrGl9ech4pW7zvo+i0HuG2dK4MShl/mqs317KzoPO5sntaeOkK24t0pkM5ehFsx
	 hbaUC9fzEvWl5Sj703eKV0g3uBp29lMh0e8Gm+tSdbK43H+9RR0PlGdrvNHghichCjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ldzPZfX1;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8677606A31F
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 00:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8677606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ldzPZfX1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793145964; x=1824681964;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=uW66Cj51iEAf/zLSuOoIOt7IMBr2dfZsVbPy/NWG4Nc=;
  b=ldzPZfX1FgV0uPga7/l0vrC5UeRuvj2BHelx7XEB7/FvRF94dhj05CVG
   YZ/0BkQrLNFLxGWxkvl4hMibsA/DAonALGdjV92QUosOrTevOavMjxN28
   4/s3FHsr/6HG0FEIlIQ+Id/b0oGEpjTMVa17jTzQzUCH5fWHkDiav+2fa
   vuUqjeejKx+9Ry3FroX/sWj+GsrHgnDYbDJ0177lAD0lF2rcXan1LUmI2
   RQHJK+dALIQA3Zj1wXqb0gjdwLhzqQJnk86/jvBZ8zWTDUPH5lHQR1X42
   QbB25tUpHowKEYuR2G6fu6GTf80hFTeoT/1a/H/aIHwUmyfql/yCuGxvi
   Q==;
X-CSE-ConnectionGUID: 6DGFIL0DROKYV2dYPOTFOg==
X-CSE-MsgGUID: jimeoNScTLSFaZ/Ix5tI5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1747213"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1747213"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 17:06:02 -0700
X-CSE-ConnectionGUID: hnQbn3VAS363grErH5ALwQ==
X-CSE-MsgGUID: kt58F1x/TBm8Nlm+pgUEqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4776655"
Received: from orcnseosdtjek.amr.corp.intel.com ([10.166.28.128])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 17:06:01 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 27 Oct 2026 17:05:39 -0700
Subject: [PATCH net 3/6] ice: E822: keep Tx timestamps disabled during
 offset calibration
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-reduction-v1-3-81237c67a361@intel.com>
References: <20261027-reduction-v1-0-81237c67a361@intel.com>
In-Reply-To: <20261027-reduction-v1-0-81237c67a361@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Nowlin <alexander.nowlin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, jacob.e.keller@intel.com, 
 maciej.machnikowski@intel.com, przemyslaw.korba@intel.com, 
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com, 
 richardcochran@gmail.com, horms@kernel.org
X-Mailer: b4 0.17-dev-67df5
X-Developer-Signature: v=1; a=openpgp-sha256; l=7370;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=XOynfBy1kpUP6v2ZuaVZHgaVnFq4BuW5dar6JR6oy1s=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyHNsm1mvKLayfJSKXxcq55o/kvZGt86rxNSUnfT11ef
 rxz27EHHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAEzkqivD/zy+5ff+LgjVzN1+
 qPWI5ModzDNz7PZY9Of2Jupr7k++wMDwV8pm17W4SlvVlee84726js33mBKneZCVoS3nlc+vN3u
 kWAE=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Karol Kolacinski <karol.kolacinski@intel.com>

Do not clear the tx.calibrating flag immediately after starting the PHY
timer in ice_ptp_port_phy_restart(). Instead, keep Tx timestamps
disabled until the offset verification work (ice_ptp_wait_for_offsets)
has confirmed that the Tx PHY offset is properly configured.

Previously, tx.calibrating was set to true, then immediately back to
false right after ice_start_phy_timer_e82x() returned. This allowed Tx
timestamp requests to be served during the window where offset
verification was still pending. Timestamps produced during this window
should have their valid bit cleared, but it is better to prevent requests
until the driver has confirmed calibration is complete.

Rename the tx.calibrating field to tx.disabled, and change where it is
cleared. Only clear it in ice_ptp_wait_for_offsets(), and only after Tx
offset configuration has completed successfully. This ensures that new Tx
timestamp requests are only accepted after the PHY has properly calibrated
the Tx offset.

If ice_start_phy_timer_e82x() fails, do not restore disabled to false.
The device is in a state where timestamps cannot succeed properly anyways.
A dev_err message is already logged on failure to start the timer at the
end of the function.

Renaming the field improves clarity and will better reflect the nature of
the flag in a future change that also applies disabling Tx timestamps in
software in a following commit.

Log a debug message while offset calibration is still pending, including
the specific Tx/Rx error codes to aid debugging stalled calibration.
This path is expected on every routine link-up: ov_work is first queued
with no delay and the vernier offset cannot be computed until at least
one packet has been transmitted, so the first several invocations
normally land here. Use dev_dbg() rather than a rate-limited warning to
avoid emitting KERN_WARNING on every link-up during normal operation.
Log a debug message when calibration completes successfully.

Note that sashiko review has previously complained that leaving the
disabled flag set "permanently" disables Tx timestamps if vernier
calibration never completes. This is true, but its important to realize
that timestamps would still fail regardless of whether the flag is set.
Until vernier calibration completes the device will not report valid
timestamps regardless. Thus, keeping the calibrating flag set simply
prevents new timestamp requests from software while it is known that the
hardware will not complete them.

Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.h |  6 +++---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 37 ++++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index da2003ba3bb0..8d46e57368ca 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -106,8 +106,8 @@ enum ice_tx_tstamp_work {
  * @offset: offset into timestamp block to get the real index
  * @len: length of the tstamps and in_use fields.
  * @init: if true, the tracker is initialized;
- * @calibrating: if true, the PHY is calibrating the Tx offset. During this
- *               window, timestamps are temporarily disabled.
+ * @disabled: set to true when new Tx timestamp requests are disabled, such as
+ *            while the PHY Tx offset configuration has not yet completed.
  * @has_ready_bitmap: if true, the hardware has a valid Tx timestamp ready
  *                    bitmap register. If false, fall back to verifying new
  *                    timestamp values against previously cached copy.
@@ -122,7 +122,7 @@ struct ice_ptp_tx {
 	u8 offset;
 	u8 len;
 	u8 init : 1;
-	u8 calibrating : 1;
+	u8 disabled : 1;
 	u8 has_ready_bitmap : 1;
 	s8 last_ll_ts_idx_read;
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 48fde5561668..2f8563eb6fb1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -367,7 +367,7 @@ ice_ptp_is_tx_tracker_up(struct ice_ptp_tx *tx)
 {
 	lockdep_assert_held(&tx->lock);
 
-	return tx->init && !tx->calibrating;
+	return tx->init && !tx->disabled;
 }
 
 /**
@@ -1168,6 +1168,7 @@ static int ice_ptp_check_tx_fifo(struct ice_ptp_port *port)
 static void ice_ptp_wait_for_offsets(struct kthread_work *work)
 {
 	struct ice_ptp_port *port;
+	unsigned long flags;
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	int tx_err;
@@ -1188,9 +1189,26 @@ static void ice_ptp_wait_for_offsets(struct kthread_work *work)
 	tx_err = ice_ptp_check_tx_fifo(port);
 	if (!tx_err)
 		tx_err = ice_phy_cfg_tx_offset_e82x(hw, port->port_num);
+	if (!tx_err) {
+		/* Tx offset has been configured, re-enable Tx timestamps */
+		spin_lock_irqsave(&port->tx.lock, flags);
+		if (port->tx.disabled) {
+			port->tx.disabled = false;
+			dev_dbg(ice_pf_to_dev(pf), "PTP Tx offset valid for port %u, Tx timestamps enabled\n",
+				port->port_num);
+		}
+		spin_unlock_irqrestore(&port->tx.lock, flags);
+	}
+
 	rx_err = ice_phy_cfg_rx_offset_e82x(hw, port->port_num);
 	if (tx_err || rx_err) {
-		/* Tx and/or Rx offset not yet configured, try again later */
+		/* Tx and/or Rx offset not yet configured, try again later.
+		 * This is expected during normal link-up: the vernier offset
+		 * calibration cannot complete until at least one packet has
+		 * been transmitted, so the first retries routinely land here.
+		 */
+		dev_dbg(ice_pf_to_dev(pf), "PTP offset not yet valid for port %u (tx_err=%d rx_err=%d)\n",
+			port->port_num, tx_err, rx_err);
 		kthread_queue_delayed_work(pf->ptp.kworker,
 					   &port->ov_work,
 					   msecs_to_jiffies(100));
@@ -1268,11 +1286,9 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 		/* Start the PHY timer in Vernier mode */
 		kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
 
-		/* temporarily disable Tx timestamps while calibrating
-		 * PHY offset
-		 */
+		/* Disable Tx timestamps until PHY calibration completes */
 		spin_lock_irqsave(&ptp_port->tx.lock, flags);
-		ptp_port->tx.calibrating = true;
+		ptp_port->tx.disabled = true;
 		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
 		ptp_port->tx_fifo_busy_cnt = 0;
 
@@ -1281,11 +1297,10 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 		if (err)
 			break;
 
-		/* Enable Tx timestamps right away */
-		spin_lock_irqsave(&ptp_port->tx.lock, flags);
-		ptp_port->tx.calibrating = false;
-		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
-
+		/* Do not clear disabled flag here. Tx timestamp requests
+		 * remain disabled until ice_ptp_wait_for_offsets() has
+		 * verified that the Tx offset calibration has completed.
+		 */
 		kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
 					   0);
 		break;

-- 
2.56.0.215.g47fdf2208c5b

