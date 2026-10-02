Received: from mail-pj2-f23.google.com (mail-pj2-f23.google.com [74.125.227.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBAD33A9E9
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790905629; cv=none; b=RFTJgk6ZrFNC27BPr4X79oWD8t281xn7s4tU1mWMecLAAUC1D+0nIojNqeljNmjKlMYrDJgxcrXAv18OdIpw38qRc72qkFI8xpSITRw2JCXZgfzNPWC2PhbztijVSX2ZI+MyOyTvqewEU4gN15nbppIIGVvPbaDYxdfymKV8aEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790905629; c=relaxed/simple;
	bh=GaMLwgtTFGLtqk2INYorMZnw3K0LXBvesYtvWm+jlFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEf583d5akSIKUGPS0dVSXg5uOPkGyMFoVbbmCFNEaXprKA+qeiuB7UBq84fuMizu26YwCoZ6WzvfFDHwlNC5A28kFHHA9B3xXX7n+8veqOYPm5MKgwiqeBOmvhgCu1kQjEj1Qt7yrVS2dIGD2s2PlyxxTne+IaP8slUAWEpnIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyo+IOSD; arc=none smtp.client-ip=74.125.227.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyo+IOSD"
Received: by mail-pj2-f23.google.com with SMTP id d9443c01a7336-2d747f066d8so19279465ad.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 18:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790905627; x=1791510427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qInUu6Q5elqtREvYKCSrshjaCoLFeFsWCB8TcWcUQpc=;
        b=gyo+IOSDY0dHQPuouILhmzkptlU48AgVR8NRuyaKasiWVVUeFtq1jc4vJsD8PSXT1x
         bgf43DrKCibuMGK5FInvbW2l983UUFlYwGGFzR4TXY7XArEqfiD/+B3Pu7FCoqV/NX0Q
         M0cosAJOEY1wrD6mw4o+A5fDIdbXhJMaCH9etrvgDiN9+WqfxCeXOpiaAvo9A748Nt2t
         8FmMMLh6LFL+kVz+ZHJG9ac+s0Wpzq0o2DVhsUf6GVVhIB67U1rRDj6888HfI99en/N/
         aSrmfzG+0iGpUa8lofIO8D5NUMQXAnvyQhmCNVSnq7wfSM8OtGO7nH1ZtEUhzMaQXGvY
         TYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790905627; x=1791510427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qInUu6Q5elqtREvYKCSrshjaCoLFeFsWCB8TcWcUQpc=;
        b=xVaDIDj8MD8ea4+E1xeevwSzhkKibVsRfoSYAS+D1ayCyWy7EP/UpYUUREbRnMd7sj
         BCRCrnPJcpOfatgCk1KYlKjWFaiv7kjxDQsVjxFYHlbZzPvpGh2w8isdAd83bQskrFXW
         c0Gd5aTYnCTp9N9CMW63pA+wrU9/FQJxKNR56W2nOYVEpCqa+5EL2WyS65vOL5v5OrVh
         ZoXDx+34fnTb/LVWIaOC6tftCb0ih571pojGZF29LjX0IFpkKBO4eQIvD2AM0tkzPefD
         P3uxn1+eWonY2XHgxeCE4KCQBh9M9rC9yTo1xrWrDeESMgAAkDbDWh+Jgz4fG6AmDx2D
         DcKg==
X-Gm-Message-State: AFq9FYIr6GKFK9PYcJEjHtOjh2t+Orfe2Oq8+bcCAI2WTkpanT5Nlyhe
	IecZEeKDhHqfNg1WVmzZfHvWPQp8n/XnJXV+CbCF5AYzMDInqPJwxGNIgrLHWbd+
X-Gm-Gg: AYBFou07a40HOPDqW1+wMjXPKZSKp8wazSr75HL6QHT3IUhEhKYCi2XOVArhlp0xiRE
	GpU2JxhU6PwEh1lStbRp84TTwaUkYgLFex6MbCVKJnveWsVlRQTCLyLEUv3X0hOmaXkiJWzafeB
	MWLAyuvbi0Wn3PYiu7a1Ef3F2nfKifjaCGL9SNDEGFr8x3qCTsEOBUbcKxs3KWai6KIOPhUZzDL
	pvLF1FEG8/pO4JKp21C50n3LMRvu+0Rs/OLtl+NG+PxPhIePQfSRfY8TnLeTbczlShSetX2gGkR
	8hfVkz0sQq7BZ/7iRzM3WQ7CF3uZvZA1NFZv0UIy90Dd5UtmE3NXyFPN9OzxlnooDLxeTSu6wHX
	pPiWlRLj3mCqqtgP/FRGvDVLgbwFXfdMESOcQw78woVOdUOEgpwe28Q8cNBeg4Psh6A/o0K6Qjp
	rsg23/Hz46M3jq6bQXk2a9trpXE1BkHIb1Nfyh2sOpt/Xvpj6VfNs2TYTi0+ucu/s1Uo5q7laCj
	rJPVTwcVdAzu7nvM1MG
X-Received: by 2002:a17:903:41c9:b0:2da:fa62:4aee with SMTP id d9443c01a7336-2e499f09e2fmr8049475ad.1.1790905626983;
        Thu, 01 Oct 2026 18:47:06 -0700 (PDT)
Received: from u.. (61-222-64-201.hinet-ip.hinet.net. [61.222.64.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6ceaedsm2675645ad.49.2026.10.01.18.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 18:47:06 -0700 (PDT)
From: Tim JH Chen <tim770802@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johannes@sipsolutions.net,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	chandrashekar.devegowda@intel.com,
	haijun.liu@mediatek.com,
	ricardo.martinez@linux.intel.com,
	linux-kernel@vger.kernel.org,
	tim.jh.chen@wnc.com.tw,
	Chih.Hung.Huang@wnc.com.tw,
	Tim JH Chen <tim770802@gmail.com>
Subject: [PATCH net v6 3/4] net: wwan: t7xx: fix race between TX/RX data path and system PM suspend
Date: Fri,  2 Oct 2026 09:46:37 +0800
Message-ID: <20261002014638.47981-4-tim770802@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002014638.47981-1-tim770802@gmail.com>
References: <20261002014638.47981-1-tim770802@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several DPMAIF data-plane contexts call pm_runtime_resume_and_get() and
then access hardware registers. System suspend ignores the runtime PM
reference they hold, so with ASPM L1 enabled and repeated suspend/resume
cycles they can touch the device while the suspend callback tears it
down, ending in a CPU soft lockup:

  watchdog: BUG: soft lockup - CPU#N stuck for 26s! [dpmaif_tx_hw_pu]
    __pm_runtime_resume+0x5b/0x80
    t7xx_dpmaif_tx_hw_push_thread+0xc4 [mtk_t7xx]

Runtime suspend is already safe: while any of these contexts holds its PM
reference the runtime suspend callback cannot run. Only system suspend,
which ignores that reference, is exposed.

Quiesce the DPMAIF data-plane contexts across system suspend:

 - Make the TX push kthread freezable (set_freezable(),
   wait_event_freezable(), kthread_freezable_should_stop()) so the PM
   freezer parks it before dpm_suspend() runs the device suspend
   callbacks. kthread_freezable_should_stop() also lets a concurrent
   kthread_stop() proceed while the thread is frozen, and a
   freezing(current) bail-out in the DRB-ring-full retry loop keeps the
   thread from looping there under sustained TX.

 - The suspend callback masks interrupts and drains the TX-done workers
   (cancel_work_sync(); their producer irq_tx_done is masked and
   cancel_work_sync() also blocks a self-requeue). It then calls
   t7xx_dpmaif_rx_stop(), which clears que_started and waits for the
   in-flight NAPI RX poll to finish, so that poll -- which writes
   registers via t7xx_dpmaif_clr_ip_busy_sts() /
   t7xx_dpmaif_dlq_unmask_rx_done() -- cannot run after the hardware is
   torn down. bat_release_work is cancelled only after rx_stop(), since
   its sole producer is that NAPI poll.

The data-plane workqueues are intentionally left non-freezable: marking
them WQ_FREEZABLE would let a flush_work()/cancel_work_sync() from a
context the freezer does not freeze (the FSM kthread, or an unbind
holding device_lock) block until thaw_workqueues(), which can hang the
suspend. Draining them from the suspend callback avoids that.

This covers the DPMAIF data path that produces the observed soft lockup;
the CLDMA control path uses a different mechanism and is out of scope.

Tested with 500+ suspend/resume cycles, SIM registered and ASPM L1
enabled.

Fixes: 46e8f49ed7b3 ("net: wwan: t7xx: Introduce power management")
Signed-off-by: Tim JH Chen <tim770802@gmail.com>
---
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c    | 24 +++++++++++++++--
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c | 30 ++++++++++++++++++----
 2 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
index 7ff33c1d6ac7..b5a857e940b7 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
@@ -410,12 +410,32 @@ static int t7xx_dpmaif_stop(struct dpmaif_ctrl *dpmaif_ctrl)
 static int t7xx_dpmaif_suspend(struct t7xx_pci_dev *t7xx_dev, void *param)
 {
 	struct dpmaif_ctrl *dpmaif_ctrl = param;
+	unsigned int i;
 
+	/* Stop new TX and mask interrupts first, so nothing re-arms the
+	 * contexts drained below.
+	 */
 	t7xx_dpmaif_tx_stop(dpmaif_ctrl);
-	t7xx_dpmaif_hw_stop_all_txq(&dpmaif_ctrl->hw_info);
-	t7xx_dpmaif_hw_stop_all_rxq(&dpmaif_ctrl->hw_info);
 	t7xx_dpmaif_disable_irq(dpmaif_ctrl);
+
+	/* irq_tx_done is masked now and cancel_work_sync() also blocks a
+	 * self-requeue, so the TX-done workers can be drained here.
+	 */
+	for (i = 0; i < DPMAIF_TXQ_NUM; i++)
+		cancel_work_sync(&dpmaif_ctrl->txq[i].dpmaif_tx_work);
+
+	/* t7xx_dpmaif_rx_stop() clears que_started and waits for the
+	 * in-flight NAPI poll (rx_processing) to finish, so no poll issues
+	 * MMIO after this point. It is also the sole producer of
+	 * bat_release_work, so cancel that work only after rx_stop();
+	 * otherwise a residual poll re-queues it and it runs against
+	 * torn-down hardware.
+	 */
 	t7xx_dpmaif_rx_stop(dpmaif_ctrl);
+	cancel_work_sync(&dpmaif_ctrl->bat_release_work);
+
+	t7xx_dpmaif_hw_stop_all_txq(&dpmaif_ctrl->hw_info);
+	t7xx_dpmaif_hw_stop_all_rxq(&dpmaif_ctrl->hw_info);
 	return 0;
 }
 
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
index 2a405bc74312..450e030fc696 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
@@ -22,6 +22,7 @@
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
+#include <linux/freezer.h>
 #include <linux/gfp.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
@@ -426,6 +427,12 @@ static void t7xx_do_tx_hw_push(struct dpmaif_ctrl *dpmaif_ctrl)
 
 		drb_send_cnt = t7xx_txq_burst_send_skb(txq);
 		if (drb_send_cnt <= 0) {
+			/* Bail out promptly on a pending freeze so the caller can
+			 * drop its runtime-PM reference and this thread can reach
+			 * the freeze point instead of looping here under load.
+			 */
+			if (freezing(current))
+				return;
 			usleep_range(10, 20);
 			cond_resched();
 			continue;
@@ -457,19 +464,30 @@ static int t7xx_dpmaif_tx_hw_push_thread(void *arg)
 	struct dpmaif_ctrl *dpmaif_ctrl = arg;
 	int ret;
 
+	set_freezable();
+
 	while (!kthread_should_stop()) {
 		if (t7xx_tx_lists_are_all_empty(dpmaif_ctrl) ||
 		    dpmaif_ctrl->state != DPMAIF_STATE_PWRON) {
-			if (wait_event_interruptible(dpmaif_ctrl->tx_wq,
-						     (!t7xx_tx_lists_are_all_empty(dpmaif_ctrl) &&
-						     dpmaif_ctrl->state == DPMAIF_STATE_PWRON) ||
-						     kthread_should_stop()))
+			if (wait_event_freezable(dpmaif_ctrl->tx_wq,
+						 (!t7xx_tx_lists_are_all_empty(dpmaif_ctrl) &&
+						  dpmaif_ctrl->state == DPMAIF_STATE_PWRON) ||
+						 kthread_should_stop()))
 				continue;
 
 			if (kthread_should_stop())
 				break;
 		}
 
+		/* Park on a pending freeze here, outside the runtime-PM and MMIO
+		 * section below, so the PM freezer quiesces this thread before
+		 * dpm_suspend() runs the device suspend callbacks.
+		 * kthread_freezable_should_stop() also honours a concurrent
+		 * kthread_stop() while the thread is frozen.
+		 */
+		if (kthread_freezable_should_stop(NULL))
+			break;
+
 		ret = pm_runtime_resume_and_get(dpmaif_ctrl->dev);
 		if (ret < 0 && ret != -EACCES) {
 			/* Do not exit the thread: dpmaif_ctrl->tx_thread still
@@ -478,7 +496,9 @@ static int t7xx_dpmaif_tx_hw_push_thread(void *arg)
 			 */
 			dev_err_ratelimited(dpmaif_ctrl->dev,
 					    "Failed to resume for TX push: %d\n", ret);
-			msleep_interruptible(DPMAIF_TX_RESUME_RETRY_MS);
+			wait_event_freezable_timeout(dpmaif_ctrl->tx_wq,
+						     kthread_should_stop(),
+						     msecs_to_jiffies(DPMAIF_TX_RESUME_RETRY_MS));
 			continue;
 		}
 
-- 
2.43.0

