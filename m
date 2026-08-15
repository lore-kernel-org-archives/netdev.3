Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E7A31ED7C
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786756118; cv=none; b=mq3MIA3feVZQV7QOUHToWQwkna3pxZKfyfoJK4u1U4BEDIcpWEH4LaEh2yeQ4eK4VjiVKv1rSzz2RrJ1SSz2OkJnDsHv1KfS83B+uxBR/RR6tXJPQtbQuMZSNF+gF3oHtTF1/3smAltGhMKMmd3rXIkc3QX5j/XYID4s/jcz0u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786756118; c=relaxed/simple;
	bh=e3z45CP4vdDBjSxwmlNhdTt8RlVurE4vCAB/LGUpSyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jXiTEkf2k4s65n4qPQX8/l1AAkEBZ4ojllb8eSkaBbocFV/XD28sTd4gRJRtKV8IIAz8SrxJLeKvyiq8rIhzBaPFoPIRquWlJC9NG1aim/A6q3QaXMK9/A8PfSXMCMkpZZpFoLhQ2H1SQMD8jwKmfxjlZxZdWHPojrMSXeP1ogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0ctsmyB; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0ctsmyB"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7ee37dc91f5so1065019a34.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 18:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786756114; x=1787360914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0XZsci9bH9VjVjaoFyFfeIOs5MILIPzzI3xZQHGP9Vc=;
        b=j0ctsmyBidNiQIBWyslgX3aw0acsA4R5gyahU6vrKfOr3bWarkL12If8CYyaUAm0kN
         p8Xkogm367FyR3YDDnOFebvQcLDCyjbS7DyiSSY2VljHfk8LXVaUM9sx8uGypTW9IJov
         VPrIC06JqbyfcxNcG2cpddXUkWiA1+tCwRDTHvp7kBuR4xVf7P04f/LAJQQupXi+OTS3
         +LEVXkfZY95q8n+tBPrV9n5s5LVcFA+vYTMyjDI+xqqoudhjpqmjpyArdgXcjxPzFi3O
         W/oc+TCXN04Dqm7Ha+ub7G8pRJw5MreQ9k3fSGdnzxQjIik/WyS8q2siK+BvC/Sim7i4
         j1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786756114; x=1787360914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0XZsci9bH9VjVjaoFyFfeIOs5MILIPzzI3xZQHGP9Vc=;
        b=SGVQzqf64VN6lvmeTrA0xXzJvvS5kS0mEjea8ZtXKg008XRLBKTYmpjvlQOBUfYzqZ
         JW91wHiCH/bZ2CIBsl6Qgd9EGOmroOdXQLNphUko5sTWT9CzlTjPUVEIYrWr2r5l31w2
         yzLqdvEtl73+fF9z5Uzg0ecR/XCeVwrDOtNhQkEOJHHJ4X/9jKatThPotku3Agu3WybN
         i5yaO4wsQieTNx4kJS9WDpPeEvWji9jmCkQs9MGwAMLiPR0Y8yOujEsFLHtNr5YZ9iyh
         HwshaRwv+skmd0wf1PZKQKlVtd6RNcmzfMDL6eQR13eejPIC9i6xqzTwpt5i71p6GXQD
         h05w==
X-Gm-Message-State: AOJu0YzpicNf+0bmI5VH9044qeq804rOXwVpC8FXipT2e1LbdkS4z3kP
	/V0flYBHhqeOQmSQtZmWlIquizBBgOBuylMdxbvTb4Om4vqJJU1h1BrU
X-Gm-Gg: AR+sD12z2nmqTqTf9iuxBUWDIKq24vESBMBvJ4B/6yNFsVcGAfVVoeXttN2UPZQE56d
	RGrVjSHNwYgw5O3dkseB5B7ZG7H/RYAAffJvYg6JxVdmIoD6aVMonoL9nQuHfkOGPGGjHqTpWEP
	L4qkryFpyQlMclUWGB39HIEUnWhhV+w4Oq+QRoZg3ILl3rs6EvRCLdWO1U2ms/LUR81RUioc1dp
	/6j4Y/boPs37tMf3FRgHCF22rA5pj/tvXiNm4niJQ0E0jN/dpqsLAkeRsPUoA6Klul1QRienPyf
	a7SP3y84D9/PQxgMN/yJ3wqfLifB8+VPcB8kkrkhaALI5zDyMFG8jWY6p4i+wStvTbUBPHYy9xg
	by9Pt3AhlHuu2uPe6Fxd1RBBWgYaYZ5V0jTMbylwLcXbmzZ2MwbWOqWacXH6eZXs21OxbIMqnif
	E0ai7LxCsYGQjVefo1zT6a4IjFSIRnKWeth86/fyQCawn6nn3r8HjRex9NAsSEJHCql9/7Jd/l3
	JIWPsFEPpih6S5NsCHT
X-Received: by 2002:a05:6830:348a:b0:7f3:a8ac:45f7 with SMTP id 46e09a7af769-7f3de565798mr7439607a34.3.1786756114170;
        Fri, 14 Aug 2026 18:08:34 -0700 (PDT)
Received: from shiv-machina.. (174-16-201-18.hlrn.qwest.net. [174.16.201.18])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3e86282fesm2232153a34.14.2026.08.14.18.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 18:08:33 -0700 (PDT)
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
Subject: [PATCH iwl-net 1/2] igb: Fix race condition in PTP tx code
Date: Sat, 15 Aug 2026 01:08:26 +0000
Message-Id: <20260815010827.91912-2-shivani07g@gmail.com>
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

igb stores one outstanding hardware Tx timestamp request in ptp_tx_skb.
The state bit used for admission is atomic, but ptp_tx_skb and
ptp_tx_start are accessed without common synchronization by the
transmit path, timestamp worker, watchdog, error cleanup, and suspend
path.

The watchdog can run after the transmit path sets the state bit and
stores the skb but before it refreshes ptp_tx_start. If the previous
request is older than IGB_PTP_TX_TIMEOUT, the watchdog treats the new
request as timed out and releases its timestamp reference. A later
hardware latch can then be associated with another request.

Add ptp_tx_lock and use it for all accesses to the request pointer and
start time. Initialize the lock during software setup, before
register_netdev() can expose the watchdog and transmit paths. The
pointer itself now provides admission control, so remove
__IGB_PTP_TX_IN_PROGRESS.

The worker and watchdog share a lock-held timeout helper. The watchdog
no longer calls cancel_work_sync(), which would deadlock while holding
the new lock and is unnecessary because the worker rechecks the pointer
under that lock.

Also remove cancel_work_sync() from the ndo_start_xmit error path, where
sleeping is not allowed. Clear the slot only if it still belongs to the
skb whose transmit failed, so a completed request cannot make error
cleanup discard a replacement request. Suspend retains synchronous
cancellation outside the lock before freeing the pending reference.

This follows the locking model introduced for igc by commit
9c50e2b150c8 ("igc: Fix race condition in PTP tx code"), with the
additional 82576 polling and transmit-error paths required by igb.

Fixes: e5f36ad14c93 ("igb: check for Tx timestamp timeouts during watchdog")
Fixes: 74344e32fcc0 ("igb: avoid permanent lock of *_PTP_TX_IN_PROGRESS")
Signed-off-by: Shivani Gupta <shivani07g@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb.h      |   3 +-
 drivers/net/ethernet/intel/igb/igb_main.c |  25 ++++--
 drivers/net/ethernet/intel/igb/igb_ptp.c  | 104 +++++++++++++---------
 3 files changed, 83 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 0fff1df81b7b..ecd284f51d3e 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -625,6 +625,8 @@ struct igb_adapter {
 	struct ptp_clock_info ptp_caps;
 	struct delayed_work ptp_overflow_work;
 	struct work_struct ptp_tx_work;
+	/* Access to ptp_tx_skb and ptp_tx_start is protected by ptp_tx_lock. */
+	spinlock_t ptp_tx_lock;
 	struct sk_buff *ptp_tx_skb;
 	struct kernel_hwtstamp_config tstamp_config;
 	unsigned long ptp_tx_start;
@@ -714,7 +716,6 @@ enum e1000_state_t {
 	__IGB_TESTING,
 	__IGB_RESETTING,
 	__IGB_DOWN,
-	__IGB_PTP_TX_IN_PROGRESS,
 };
 
 enum igb_boards {
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a1e89a375744..fc70f7aa4ce0 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4062,6 +4062,8 @@ static int igb_sw_init(struct igb_adapter *adapter)
 	adapter->max_frame_size = netdev->mtu + IGB_ETH_PKT_HDR_PAD;
 	adapter->min_frame_size = ETH_ZLEN + ETH_FCS_LEN;
 
+	/* The netdev watchdog can run as soon as the device is registered. */
+	spin_lock_init(&adapter->ptp_tx_lock);
 	spin_lock_init(&adapter->nfc_lock);
 	spin_lock_init(&adapter->stats64_lock);
 
@@ -6561,10 +6563,11 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 		struct igb_adapter *adapter = netdev_priv(tx_ring->netdev);
+		unsigned long flags;
 
+		spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
-		    !test_and_set_bit_lock(__IGB_PTP_TX_IN_PROGRESS,
-					   &adapter->state)) {
+		    !adapter->ptp_tx_skb) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			tx_flags |= IGB_TX_FLAGS_TSTAMP;
 
@@ -6575,6 +6578,7 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 		} else {
 			adapter->tx_hwtstamp_skipped++;
 		}
+		spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 	}
 
 	if (skb_vlan_tag_present(skb)) {
@@ -6603,12 +6607,19 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 cleanup_tx_tstamp:
 	if (unlikely(tx_flags & IGB_TX_FLAGS_TSTAMP)) {
 		struct igb_adapter *adapter = netdev_priv(tx_ring->netdev);
+		unsigned long flags;
 
-		dev_kfree_skb_any(adapter->ptp_tx_skb);
-		adapter->ptp_tx_skb = NULL;
-		if (adapter->hw.mac.type == e1000_82576)
-			cancel_work_sync(&adapter->ptp_tx_work);
-		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
+		/* ndo_start_xmit runs in atomic context, so the scheduled
+		 * ptp_tx_work cannot be cancelled here. It checks
+		 * ptp_tx_skb under ptp_tx_lock and does nothing once the
+		 * pending timestamp request is cleared.
+		 */
+		spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
+		if (adapter->ptp_tx_skb == skb) {
+			dev_kfree_skb_any(adapter->ptp_tx_skb);
+			adapter->ptp_tx_skb = NULL;
+		}
+		spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 	}
 
 	return NETDEV_TX_OK;
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 638d8242b66b..3cc05f9198f8 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -796,6 +796,21 @@ static int igb_ptp_verify_pin(struct ptp_clock_info *ptp, unsigned int pin,
 	return 0;
 }
 
+/* Requires adapter->ptp_tx_lock held by caller. */
+static void igb_ptp_tx_timeout(struct igb_adapter *adapter)
+{
+	struct e1000_hw *hw = &adapter->hw;
+
+	dev_kfree_skb_any(adapter->ptp_tx_skb);
+	adapter->ptp_tx_skb = NULL;
+	adapter->tx_hwtstamp_timeouts++;
+	/* Clear the tx valid bit in TSYNCTXCTL register to enable
+	 * interrupt
+	 */
+	rd32(E1000_TXSTMPH);
+	dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
+}
+
 /**
  * igb_ptp_tx_work
  * @work: pointer to work struct
@@ -808,23 +823,18 @@ static void igb_ptp_tx_work(struct work_struct *work)
 	struct igb_adapter *adapter = container_of(work, struct igb_adapter,
 						   ptp_tx_work);
 	struct e1000_hw *hw = &adapter->hw;
+	unsigned long flags;
 	u32 tsynctxctl;
 
+	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
+
 	if (!adapter->ptp_tx_skb)
-		return;
+		goto unlock;
 
 	if (time_is_before_jiffies(adapter->ptp_tx_start +
 				   IGB_PTP_TX_TIMEOUT)) {
-		dev_kfree_skb_any(adapter->ptp_tx_skb);
-		adapter->ptp_tx_skb = NULL;
-		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
-		adapter->tx_hwtstamp_timeouts++;
-		/* Clear the tx valid bit in TSYNCTXCTL register to enable
-		 * interrupt
-		 */
-		rd32(E1000_TXSTMPH);
-		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
-		return;
+		igb_ptp_tx_timeout(adapter);
+		goto unlock;
 	}
 
 	tsynctxctl = rd32(E1000_TSYNCTXCTL);
@@ -833,6 +843,9 @@ static void igb_ptp_tx_work(struct work_struct *work)
 	else
 		/* reschedule to check later */
 		schedule_work(&adapter->ptp_tx_work);
+
+unlock:
+	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 }
 
 static void igb_ptp_overflow_check(struct work_struct *work)
@@ -897,32 +910,45 @@ void igb_ptp_rx_hang(struct igb_adapter *adapter)
  */
 void igb_ptp_tx_hang(struct igb_adapter *adapter)
 {
-	struct e1000_hw *hw = &adapter->hw;
-	bool timeout = time_is_before_jiffies(adapter->ptp_tx_start +
-					      IGB_PTP_TX_TIMEOUT);
+	unsigned long flags;
+
+	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 
 	if (!adapter->ptp_tx_skb)
-		return;
+		goto unlock;
 
-	if (!test_bit(__IGB_PTP_TX_IN_PROGRESS, &adapter->state))
-		return;
+	if (time_is_after_jiffies(adapter->ptp_tx_start + IGB_PTP_TX_TIMEOUT))
+		goto unlock;
 
 	/* If we haven't received a timestamp within the timeout, it is
 	 * reasonable to assume that it will never occur, so we can unlock the
 	 * timestamp bit when this occurs.
 	 */
-	if (timeout) {
-		cancel_work_sync(&adapter->ptp_tx_work);
-		dev_kfree_skb_any(adapter->ptp_tx_skb);
-		adapter->ptp_tx_skb = NULL;
-		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
-		adapter->tx_hwtstamp_timeouts++;
-		/* Clear the tx valid bit in TSYNCTXCTL register to enable
-		 * interrupt
-		 */
-		rd32(E1000_TXSTMPH);
-		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
-	}
+	igb_ptp_tx_timeout(adapter);
+
+unlock:
+	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
+}
+
+/**
+ * igb_ptp_clear_tx_tstamp - drop a pending Tx timestamp request
+ * @adapter: private network adapter structure
+ *
+ * Cancel the timestamp retrieval work and free a pending timestamp skb.
+ *
+ * Context: Must be called in sleepable context with ptp_tx_lock not held;
+ *          cancel_work_sync() waits for igb_ptp_tx_work() which takes it.
+ */
+static void igb_ptp_clear_tx_tstamp(struct igb_adapter *adapter)
+{
+	unsigned long flags;
+
+	cancel_work_sync(&adapter->ptp_tx_work);
+
+	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
+	dev_kfree_skb_any(adapter->ptp_tx_skb);
+	adapter->ptp_tx_skb = NULL;
+	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 }
 
 /**
@@ -932,6 +958,8 @@ void igb_ptp_tx_hang(struct igb_adapter *adapter)
  * If we were asked to do hardware stamping and such a time stamp is
  * available, then it must have been for this skb here because we only
  * allow only one such packet into the queue.
+ *
+ * Context: Expects adapter->ptp_tx_lock to be held by caller.
  **/
 static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter)
 {
@@ -963,15 +991,14 @@ static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter)
 	shhwtstamps.hwtstamp =
 		ktime_add_ns(shhwtstamps.hwtstamp, adjust);
 
-	/* Clear the lock early before calling skb_tstamp_tx so that
-	 * applications are not woken up before the lock bit is clear. We use
-	 * a copy of the skb pointer to ensure other threads can't change it
-	 * while we're notifying the stack.
+	/* Clear the pending request before calling skb_tstamp_tx so that
+	 * a new timestamp request can be accepted. We use a copy of the skb
+	 * pointer to ensure other threads can't change it while we're
+	 * notifying the stack.
 	 */
 	adapter->ptp_tx_skb = NULL;
-	clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
 
-	/* Notify the stack and free the skb after we've unlocked */
+	/* Notify the stack and free the skb */
 	skb_tstamp_tx(skb, &shhwtstamps);
 	dev_kfree_skb_any(skb);
 }
@@ -1434,12 +1461,7 @@ void igb_ptp_suspend(struct igb_adapter *adapter)
 	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
 		cancel_delayed_work_sync(&adapter->ptp_overflow_work);
 
-	cancel_work_sync(&adapter->ptp_tx_work);
-	if (adapter->ptp_tx_skb) {
-		dev_kfree_skb_any(adapter->ptp_tx_skb);
-		adapter->ptp_tx_skb = NULL;
-		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
-	}
+	igb_ptp_clear_tx_tstamp(adapter);
 }
 
 /**
