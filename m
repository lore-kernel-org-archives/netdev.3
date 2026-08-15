Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9439631E820
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 01:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786756119; cv=none; b=ToGf6t3nZyCK0/wxnuYdAH5W4V78tcY1iy+nlh5g3PTtWGNnG6/59Xuqdq1O62bUsESyim/PofKZEBDU0h464aHbYHbfeXHxSdkwbT6ZZ2b/Dg3oLJsh+9pYrlI5AYaC6tVWMNKTOLbOFd4MKP8GHUN2wQM/d0XNWERUgLQ5nu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786756119; c=relaxed/simple;
	bh=7o+1KtI0zZ/g7VBmIPoP7jQv4Hd6/Jllv2m0vsr1XPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FbMWiFztADBcjVqjnqPHA0pc6823Aiqx6Q/zDOACgmBPXjKtSQer5l8xfN+PlJVZgDX1Wa7Y5wPUrBgd+2PBB9gOwxf+kQAVJy7SvMvA3MQuBwpGF7+XYFg/eaoJ1f+USHRhHtP3Xw0kMnRACxfSzHQe7LrJf+aF3ujL2ENYKS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcJ0zlvo; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcJ0zlvo"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9f1f24cbcso1325135a34.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 18:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786756116; x=1787360916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7VA9P9TmAckj6vhir0RJ/OmqAptpB42Jyovrg4yN07c=;
        b=BcJ0zlvoWTQFa852xlJDV3WUZpH5AQGFD03QtP7bX8FQCnVcj6k1G0uL1lJK8dKG0p
         tSWhUWK53jg0DX7MylegGh2Rxs8Cd3ayPb8i/uJim0LF2b+z4nttqlcatmWalB9nWZwn
         NoXpnOAWVazGjBqxbeQheHqJYq/NTFokfp1eVWbbf65VsPlzJ/2ha1P/HzokWeSffbrl
         2w377ZVinI2rRJDHbjagOovtAvXG8+wOzOMUU3TSItSng7qSLFyePJjOgCbIC+viBoV0
         BIk+CnIzw9olgVfuUP3orBrlqhGaixA6nhbd67zdn3WYVAU+XoseoDAEIVjfohZAXn5Q
         HwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786756116; x=1787360916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7VA9P9TmAckj6vhir0RJ/OmqAptpB42Jyovrg4yN07c=;
        b=FQ94OxoV+RP1kFXkxaoqFscfAi3rf0CTkqCQQMtWkQmZAUWNq+yJGN54uBkXAdf2PT
         WbE0lmkzL6jRrjvx/KcPpJgeICIlx+b/ui6tLYDB+Kv6mrd/lfxCZHMVN1ZhdjLdKjo3
         PRJdYggLUnmV+BVBRqRdu5STXp/J4lKQYmwWnzjWSgKSrBIgV8L8ttF8c8u//QlFFMq1
         gzge5P3hYsB0UmH4Z4iT4at0Jv1FWDqATvIIv4cKu+DUkrTptgsDMqorzcOiUfvzjQP/
         PfrK+ETjdEuaNO4BwN28WzTgAd6opp+cksXrOBwutmeJ+NIVuVBT6vV8shPT6J6wkn4z
         dvLg==
X-Gm-Message-State: AOJu0YzpUkV4UqPNwSZJhjNDl23prXhQngTQYjJiHmz21HIPY4k0H8L3
	BG9CXa/u5WDgkHRvle8oO2oyfJNzjos6u6m8RQEMvDJLqnqaaEL53Fpm
X-Gm-Gg: AR+sD11svcb5ydh8A/FAQLtqHbG0FrD3CrxorCaXqhuVe0pAJxsn2eEn+A4mtQykH+Z
	P2GqM37xazqLr5hRxITWC7JK0u71uMoytbkf0pp5W5UUdks3seke6MWSknRNkXRbwFUgouh1DcU
	65j6mk6Fj6jz+4PoUr/bdRTLTXdRU4t9xQHaOxXr0M2swY62Pk8t+oaK+7i6TsGGk1KrTAYH3aB
	WcmHkXNm1yG3YGzdRemy/jPhCDu0T7TmH4f+hexXHEE1Tf8jc/vkiOthMKhJTgCIlXmc4sPtW+9
	AT920JkqDZLe5xZosVC4mB9LDYAF6SeiDZnWkECQXeNn97o3A26VN+czXiuWNr7r8xGEqyqkt+B
	nf2RnT0bf3BZ2iKUMTnR35dATZzxF5qGprYwE3YrSvSRx6bEJLmQGIBjE3i5zAPcTHTEWAGiOGP
	yEE2AROFD7M5NJHndxYrCSADHcQU6M9dDjpIZNNz2wQdw7boCMhatSTctoFGLJ617CuqFhh3+mj
	wfKYk4xnOPxus4SZzgD
X-Received: by 2002:a9d:69ca:0:b0:7f3:daf9:eda3 with SMTP id 46e09a7af769-7f3daf9f40emr4856740a34.4.1786756116462;
        Fri, 14 Aug 2026 18:08:36 -0700 (PDT)
Received: from shiv-machina.. (174-16-201-18.hlrn.qwest.net. [174.16.201.18])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3e86282fesm2232153a34.14.2026.08.14.18.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 18:08:36 -0700 (PDT)
From: Shivani Gupta <shivani07g@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Matthew Vick <matthew.vick@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net 2/2] igb: Clear pending Tx timestamp requests when disabling Tx timestamping
Date: Sat, 15 Aug 2026 01:08:27 +0000
Message-Id: <20260815010827.91912-3-shivani07g@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260815010827.91912-1-shivani07g@gmail.com>
References: <20260815010827.91912-1-shivani07g@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disabling Tx hardware timestamping clears TSYNCTXCTL.EN but leaves an
outstanding request in ptp_tx_skb. Re-enabling within
IGB_PTP_TX_TIMEOUT therefore finds the single timestamp slot occupied
and skips new requests until the watchdog reports a misleading timeout,
producing a blackout of up to 15 seconds.

Cancel timestamp retrieval when disabling Tx timestamping, then publish
HWTSTAMP_TX_OFF and release the pending request under ptp_tx_lock. The
transmit path tests both the configured mode and slot ownership under
the same lock, so no request can be admitted between clearing the slot
and publishing the disabled state. Updates to the saved configuration
and the watchdog mode check use that lock as well.

Suspend uses the same cleanup helper without changing the saved mode,
allowing reset to restore the requested configuration after resume.

Only count a timestamp request as skipped when hardware timestamping is
enabled and the slot is occupied. Requests carrying SKBTX_HW_TSTAMP
while the feature is disabled could never have been serviced and are
ignored without changing the counter.

Fixes: 1f6e8178d685 ("igb: Prevent dropped Tx timestamps via work items and interrupts.")
Signed-off-by: Shivani Gupta <shivani07g@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 26 +++++++++++++----------
 drivers/net/ethernet/intel/igb/igb_ptp.c  | 20 +++++++++++++++--
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index fc70f7aa4ce0..42204e3307d6 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6565,18 +6565,22 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 		struct igb_adapter *adapter = netdev_priv(tx_ring->netdev);
 		unsigned long flags;
 
+		/* A timestamp that was requested while Tx timestamping was
+		 * not enabled can never be delivered, it is not "skipped".
+		 */
 		spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
-		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
-		    !adapter->ptp_tx_skb) {
-			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-			tx_flags |= IGB_TX_FLAGS_TSTAMP;
-
-			adapter->ptp_tx_skb = skb_get(skb);
-			adapter->ptp_tx_start = jiffies;
-			if (adapter->hw.mac.type == e1000_82576)
-				schedule_work(&adapter->ptp_tx_work);
-		} else {
-			adapter->tx_hwtstamp_skipped++;
+		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON) {
+			if (!adapter->ptp_tx_skb) {
+				skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+				tx_flags |= IGB_TX_FLAGS_TSTAMP;
+
+				adapter->ptp_tx_skb = skb_get(skb);
+				adapter->ptp_tx_start = jiffies;
+				if (adapter->hw.mac.type == e1000_82576)
+					schedule_work(&adapter->ptp_tx_work);
+			} else {
+				adapter->tx_hwtstamp_skipped++;
+			}
 		}
 		spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 	}
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 3cc05f9198f8..adc7be6a2ee2 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -914,6 +914,9 @@ void igb_ptp_tx_hang(struct igb_adapter *adapter)
 
 	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 
+	if (adapter->tstamp_config.tx_type != HWTSTAMP_TX_ON)
+		goto unlock;
+
 	if (!adapter->ptp_tx_skb)
 		goto unlock;
 
@@ -933,19 +936,22 @@ void igb_ptp_tx_hang(struct igb_adapter *adapter)
 /**
  * igb_ptp_clear_tx_tstamp - drop a pending Tx timestamp request
  * @adapter: private network adapter structure
+ * @disable: whether to disable Tx timestamp admission
  *
  * Cancel the timestamp retrieval work and free a pending timestamp skb.
  *
  * Context: Must be called in sleepable context with ptp_tx_lock not held;
  *          cancel_work_sync() waits for igb_ptp_tx_work() which takes it.
  */
-static void igb_ptp_clear_tx_tstamp(struct igb_adapter *adapter)
+static void igb_ptp_clear_tx_tstamp(struct igb_adapter *adapter, bool disable)
 {
 	unsigned long flags;
 
 	cancel_work_sync(&adapter->ptp_tx_work);
 
 	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
+	if (disable)
+		adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
 	dev_kfree_skb_any(adapter->ptp_tx_skb);
 	adapter->ptp_tx_skb = NULL;
 	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
@@ -1250,6 +1256,13 @@ static int igb_ptp_set_timestamp_mode(struct igb_adapter *adapter,
 	regval |= tsync_tx_ctl;
 	wr32(E1000_TSYNCTXCTL, regval);
 
+	/* Drop a possibly pending Tx timestamp request when disabling Tx
+	 * timestamping. It would otherwise block new requests until it is
+	 * flagged as timed out by the watchdog up to 15 seconds later.
+	 */
+	if (!tsync_tx_ctl)
+		igb_ptp_clear_tx_tstamp(adapter, true);
+
 	/* enable/disable RX */
 	regval = rd32(E1000_TSYNCRXCTL);
 	regval &= ~(E1000_TSYNCRXCTL_ENABLED | E1000_TSYNCRXCTL_TYPE_MASK);
@@ -1310,6 +1323,7 @@ int igb_ptp_hwtstamp_set(struct net_device *netdev,
 			 struct netlink_ext_ack *extack)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
+	unsigned long flags;
 	int err;
 
 	err = igb_ptp_set_timestamp_mode(adapter, config);
@@ -1317,7 +1331,9 @@ int igb_ptp_hwtstamp_set(struct net_device *netdev,
 		return err;
 
 	/* save these settings for future reference */
+	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 	adapter->tstamp_config = *config;
+	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 
 	return 0;
 }
@@ -1461,7 +1477,7 @@ void igb_ptp_suspend(struct igb_adapter *adapter)
 	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
 		cancel_delayed_work_sync(&adapter->ptp_overflow_work);
 
-	igb_ptp_clear_tx_tstamp(adapter);
+	igb_ptp_clear_tx_tstamp(adapter, false);
 }
 
 /**
