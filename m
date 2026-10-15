Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE153A8A3
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091489; cv=none; b=Yx2XzITZ3XqkhMH9GlWbffw88E0oKhdTkreGJR1E4sdF4iptZ2BKAdQaziEsyTW+VYKupaczUMr45IdSYxQiN63lKXPK6k9fn/JS4W37DRpgRatCsrpFPHr+++qgkDzjVdAb0bRRNfOIB9HbAJfIUexb0bs/EuJUGATw+rljl/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091489; c=relaxed/simple;
	bh=LdCaL5jIsiSzQ71Wo83q/leCKwn9tiJ25QM20ZBhKqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hg78u7pYKrI52wXRXarbiEYbD9wT1WgCiVF4f0MEfRUrs+MRf5kk8lGeQ3kExcGTLS6Ljc4V0xBA2OPDDH3CaJW0bPWdUjwSxfHVpsGEEIhvpn+6JAifq7KSsUPmre+Ky/vtlxE4Npk4qZxStA8qjz1K1lMPuK3mWsE6mAv72kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmybIcSC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmybIcSC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792091486; x=1823627486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LdCaL5jIsiSzQ71Wo83q/leCKwn9tiJ25QM20ZBhKqk=;
  b=VmybIcSCEI/9FjW5+4YWSZZF9ksm4CHcLkMCLyouNtxnUrWmnjea4hgJ
   Koav2cvL+hX1z3hBmpIUBZBjFzWCF+zbCP+Gt4FRGRCjIu+yWllUKfm76
   bfG2l7vqMU7Ae1pKgGToIMTin5QhwGFmkVbnJFmBk0N9aDdnGbT6+uXSQ
   A3ZZgwi1l7droV8sN25YPKv+jP5Vtsw42geP3cmNRHwQt9yQZqTY6qU1x
   G2YYTeP1pPMiRvCwRjvP1r4+X+nfDMiNHt275IXBZgYajuUWcl2RWHHYB
   1k8qCblCaIbDMUiR9UHEoUpovT5X2V2H0v6MUMgrVoVNrFKq0CKpE0gFu
   Q==;
X-CSE-ConnectionGUID: gUKkFPaiTAmYyhdTg96eDQ==
X-CSE-MsgGUID: XcxOfpWoQLGCdUUUwzkBKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="765576"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="765576"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:11:14 -0700
X-CSE-ConnectionGUID: IDHsg2yYRey21Jg3YRcJPg==
X-CSE-MsgGUID: hsvAuCeLRn+MX9K6/GSP8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2078482"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 15 Oct 2026 12:11:13 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <anthony.l.nguyen@intel.com>,
	jacob.e.keller@intel.com,
	maciej.machnikowski@intel.com,
	przemyslaw.korba@intel.com,
	grzegorz.nitka@intel.com,
	sergey.temerkhanov@intel.com,
	arkadiusz.kubalewski@intel.com,
	poros@redhat.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v3 06/14] ice: E822: keep Tx timestamps disabled during offset calibration
Date: Thu, 15 Oct 2026 12:10:52 -0700
Message-ID: <20261015191102.1174111-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261015191102.1174111-1-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-1-anthony.l.nguyen@intel.com>
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
has confirmed that the Tx PHY offset is properly configured.

Previously, tx.calibrating was set to true, then immediately back to
false right after ice_start_phy_timer_e82x() returned. This allowed Tx
timestamp requests to be served during the window where offset
verification was still pending. Timestamps produced during this window
should have their valid bit cleared, but it is better to prevent requests
until the driver has confirmed calibration is complete.

Move the tx.calibrating = false to ice_ptp_wait_for_offsets(), after
Tx offset configuration has completed successfully. This ensures that new
Tx timestamp requests are only accepted after the PHY has properly
calibrated the Tx offset.

If ice_start_phy_timer_e82x() fails, do not restore calibrating to false.
The device is in a state where timestamps cannot succeed properly anyways.
A dev_err message is already logged on failure to start the timer at the
end of the function.

Log a debug message while offset calibration is still pending, including
the specific Tx/Rx error codes to aid debugging stalled calibration.
This path is expected on every routine link-up: ov_work is first queued
with no delay and the vernier offset cannot be computed until at least
one packet has been transmitted, so the first several invocations
normally land here. Use dev_dbg() rather than a rate-limited warning to
avoid emitting KERN_WARNING on every link-up during normal operation.
Log a debug message when calibration completes successfully.

Note that sashiko review has previously complained that leaving the
calibrating flag enabled "permanently" disables Tx timestamps if vernier
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
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 29 +++++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp.h |  2 +-
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 776f211290ec..828d46a73f29 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
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
+		if (port->tx.calibrating) {
+			port->tx.calibrating = false;
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
@@ -1283,11 +1301,10 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 		if (err)
 			break;
 
-		/* Enable Tx timestamps right away */
-		spin_lock_irqsave(&ptp_port->tx.lock, flags);
-		ptp_port->tx.calibrating = false;
-		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
-
+		/* Do not clear calibrating flag here. Tx timestamp requests
+		 * remain disabled until ice_ptp_wait_for_offsets() has
+		 * verified that the Tx offset calibration has completed.
+		 */
 		kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
 					   0);
 		break;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 27ea502b7576..029ee4612d76 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -107,7 +107,7 @@ enum ice_tx_tstamp_work {
  * @len: length of the tstamps and in_use fields.
  * @init: if true, the tracker is initialized;
  * @calibrating: if true, the PHY is calibrating the Tx offset. During this
- *               window, timestamps are temporarily disabled.
+ *               window, timestamp requests are disabled.
  * @has_ready_bitmap: if true, the hardware has a valid Tx timestamp ready
  *                    bitmap register. If false, fall back to verifying new
  *                    timestamp values against previously cached copy.
-- 
2.47.1

