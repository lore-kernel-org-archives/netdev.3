Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489580;
	b=k9f+Fmh+/zGg4e+85YPEF6h5AK5HhjT8pMwixJhBNFdZzrLlZvbyuPFwtCKKhk69I3lh
	 jWl9wQsuw5VORe4JVQoOcwt1f6I47DE9WGeWvkgZ1Vm3tfqzRfytG/SoAODZ+ZxJ1pKNA
	 k/i4Z5um0AM/Ghmsut8LcBsivPhGvhk9yDb4KlB+ZTlT4/qGafIPnvMr7bsnmWvpHp5vL
	 gIWIw2tA/8RLB0l3plJHCmJudTT7cuVk6Zf/hAzOhCWIJmlQT/GauYbb5yVL6zM9P2smv
	 UkbILoi4Qvd/X8mzucEx5DXhBoUWjVkaR3JGAI3J9WwPOtZWFycTb0GHHjtoQxMtlLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489580;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=IX7RgdK/u+jEM7Oddr/DxLx4dPDvY88uypHFy7NlwuY=;
	b=BoOBLwmxKS/pN3/bYpfm7fdCZko4cuZm3d4CkpzcXokV5iVwMasT6OI+AdBpJAIBt+3O
	 k0KbdFKJd80XNtbJSZpfCELc1ZhYc09MobvKHWJx0FK0Tur+NzJ+bAqxVjv8LLkB4eBqJ
	 JLh6hbikbA7O7I0QoJRGJ0Z2tlMk7JTClPIyxaVoQk3ejlfACHck24gA3oApAn7OOTfYI
	 ZxyzxS3zoDt2MJOk2VAAk2U7nqhcCP7/p7xdzDvOgKGaAaMCsAfX2BMBPsTUFzOEjIoex
	 4zJxnSggEsM4hlb3uqTlo7l3CjdEYoOxLpPttcy1nC/0f98tz83gCjg4iPnIReP1KyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W8F8ZyCW;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF71606A339
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BF71606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W8F8ZyCW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792489579; x=1824025579;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=6U1HEFTHek9tvTfbHxxbTFLySiT0aWBNEPp6y27n+lA=;
  b=W8F8ZyCWG2W5lruGqRbXgb4KCUdQK7Nuhm31QHfrgaNB9SF415r8yBTK
   /wwiLQ0VIEy1yInCdKXGeNzBqrxbRYsK1wKOsPAEOWgVjNgespBrCISP9
   0LPE0LEngTG44C1IgUXIOERy4PdWTpffUBwLUPepHWPOL1CmuHYkiRCxR
   kBopSMpNUWKENgRtlptq4JOT2A3a/nhFhvm3bPP37DqrbT1asHyiy6IkA
   ST1W5R5afZu3xg6FS2yRH48AD/Onyo4b46WNXo7AoDIv5diV6ktqAwn1f
   2q+/h12qTFBshufnTzU6aaJcVFr3hjNKm9Bh4EqpboA+xqNOnaTLwoSEi
   Q==;
X-CSE-ConnectionGUID: ifscL0nRSpGGCqYLMLpFng==
X-CSE-MsgGUID: NTF5WEY9QFqEjjgWthNHmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1287902"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1287902"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
X-CSE-ConnectionGUID: Q1+1sqGRRh63wobTa/VBMA==
X-CSE-MsgGUID: 3yWBH5I+STCjTvo63ndfwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2723904"
Received: from orcnseosdtnuc.amr.corp.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 20 Oct 2026 02:45:37 -0700
Subject: [PATCH iwl-net v4 06/13] ice: E822: keep Tx timestamps disabled
 during offset calibration
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
Message-Id: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-6-3e30fc9adc73@intel.com>
References: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
In-Reply-To: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
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
 bh=YY+XtsRk0vaKSnYEY0nLGZmbANoVHlP3zuzXjfhlbRg=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqzrFvFf/Jd1u270D+XOnjEhPrRz8tLmKMaARbP6Xacez
 F/8d/XDjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACbis43hf/gcQ1MBpeivcUs6
 hYJNnHz9LD/LTBXVlpksKZe1xuKFF8P/sOVu8d8PLb21yOzqzjlPKngvmtwRNszZ+uTF8vOTeI1
 ZmQA=
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
index 27ea502b7576..d70f022c850b 100644
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
index f43918f334e8..57e2606655c4 100644
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
@@ -1270,11 +1288,9 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
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
 
@@ -1283,11 +1299,10 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
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
2.56.0.212.g129ede20d986

