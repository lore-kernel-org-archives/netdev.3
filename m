Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7324908C6
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787698510; cv=none; b=Aw6MGOaAEtjEPFsB21+ze+/ODD8DF+LRi6CkllAWLUUmS9J/KGbv1rwBYS2I/Xn3xn0Zg5kiL/I6D4DuaIpSBXpZYcnx38GodwIQVLoz5hmLgMjplCBgfYfKUs9GLA1uR8C+kVbZr76xrbMn7RD9PO/gvU5/DQsSoZYK/VPVofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787698510; c=relaxed/simple;
	bh=DADCx5ikbCjxZtfqVaLtabxb276pvs/kXKBlg9ol2f0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l8x/IMaHPi4PgTi384j/u/7RmipN3yh+Hzr9UgkpcQ/QXYLgYQvyX78c35ZnKqgcWx1cPvbDL4eHwOZcc3ZNof2n3c1Q1brjEoKjyqNP4kfQRQBDR/wECGfrx2HU7uOprYw/77R3375JCY0xO1O65U7doVoVXnogkl0bhtay37I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqsFcZxz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqsFcZxz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787698509; x=1819234509;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DADCx5ikbCjxZtfqVaLtabxb276pvs/kXKBlg9ol2f0=;
  b=XqsFcZxzxdYbCPh/G8IUehsXEqQJF7x4YqRL+H/TGcUrCxYTl04x+j46
   eslBXLS1IcBiw9vbJvRrgkRdvszke0rej74gvAHKoTnz2UfQlGxDlmB2e
   ZBTXAQSbH6QrkBhYa5XW8QrkarmReLyM9JGWQt0S3js/oMeS3e4UC6ksc
   +D/J7qL9NuhcIvrzdUKu+S80R+l8WMLW8xRcHhBPugMQBzlPhxsM2JN3N
   brMeFEDcUTf4xiTSBZZjXeldKfbT1oB7cl31F9Z3vYHmMUEdt8FWG4Pcd
   4LNlFVg8wIqso03c8DNcp679ICGxF2NayrfZBQiji1GeWaaMpTstCVcN7
   A==;
X-CSE-ConnectionGUID: 1VtmmnABS36kBqy/scSqWQ==
X-CSE-MsgGUID: 4TgfEtcBSdyverZaEbJ/EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120423"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="87120423"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:06 -0700
X-CSE-ConnectionGUID: r7EGaFgHRXmNyLaYQR0A1Q==
X-CSE-MsgGUID: HfkQSuG6Traqb9bCoEnPBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="264789671"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:05 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:28 -0700
Subject: [PATCH iwl-net v2 04/14] ice: E822: keep Tx timestamps disabled
 during offset calibration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-4-8223f95d26e3@intel.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>
X-Mailer: b4 0.17-dev-c276d
X-Developer-Signature: v=1; a=openpgp-sha256; l=4837;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Mk4dR0jl1aKzjq+uRi7trGpIdPS1BReUetnmDWNHCEE=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+Wesbe9ea15gstMnik2EP1GR7eSa5yPTZ8V7Feb9/7
 U46zhvfUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwETi1Rj+Sv/b80//8/Zbju/u
 7vm96N3HI7v+Ghg5C//1Pzh92jKHiipGhs5uu+cPDC+1JMbIBYW4Cp6O1PaWS91/Pfm8i9SJ6rQ
 wFgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

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

Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 68537705e839..d018f02f700d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1156,6 +1156,7 @@ static int ice_ptp_check_tx_fifo(struct ice_ptp_port *port)
 static void ice_ptp_wait_for_offsets(struct kthread_work *work)
 {
 	struct ice_ptp_port *port;
+	unsigned long flags;
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	int tx_err;
@@ -1178,12 +1179,28 @@ static void ice_ptp_wait_for_offsets(struct kthread_work *work)
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
@@ -1269,10 +1286,13 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 		if (err)
 			break;
 
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
2.55.0.814.gc42f45431d0f

