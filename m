Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D80175A5;
	Thu,  6 Aug 2026 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996422; cv=none; b=nX02NXXK2eUUe9Ia7feIlcjsBNywFHYpTgekldhEMfYNHxrhp8t2Niqe9u5lqwAbV+6XLoMT6N6hkAq3vu4Grgw9CeyYOad/QnRY7Ilbp/eaKE8wJgE1/m0SVwYokprwmBxE5ZrGuaxGHkMu+3UvrDuJixhsgFmjPO8B6x0DfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996422; c=relaxed/simple;
	bh=cgdjW+MZSSh34CCTRR/C5ZkFvF8tn2fI8RO7WeSPGPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nyx5krSBTRv4huQmEMiRhQHoMLuJwSd6SqELWeh7p/hGuTcarXdzj4od4+JsynTj87WktfQnyIe60k2ai+OzIv+RYJvy/EoziE+zWPv/gbNTwq5Z/7CBDMsWOHapc61Ki54UVRsCm1m3PVi9VCKFEPheebY+ffQQoeicvi5LtFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=fETvGALt; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="fETvGALt"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 48fb94a33;
	Thu, 6 Aug 2026 14:06:55 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] net: wwan: qcom_bam_dmux: fix TX DMA channel use-after-free
Date: Thu,  6 Aug 2026 14:06:42 +0800
Message-ID: <20260806060642.1281-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fd5ae82e603a1kunmdd09a832289390
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHUhCVhkdS0tCTR9PQhlDSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fETvGALtoIo72cooiaR/FzKGyWMc6M0KsMW7Y2ogTVorlty+7SpWZiBp8HDldIoHQniAWF/8dp7tBrUKiiOKPaJM5EO0Y5RD7PP5/gUe9MHTsOaheBXbmqW+AfdJBXMnMKVKzg2COyCNeRE+1zrXDAmnGUS5svUSmfdZjWnO2nc=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=h4VR9GvsId49kJ4OwMgJNUhnVRvYJVrYNyl2glI56kY=;
	h=date:mime-version:subject:message-id:from;

The modem-driven power-control IRQ can release the TX DMA channel
independently of the runtime PM callbacks. It can therefore race with the
command, netdev transmit, and wakeup-work paths while they prepare and
submit descriptors through dmux->tx. A runtime PM reference prevents
runtime suspend, but does not serialize those paths with the external IRQ.

Protect TX channel users with SRCU. Clear the published channel pointer and
wait for existing readers before terminating and releasing the channel.
Serialize channel replacement and power transitions with a mutex, and
discard deferred packets if the channel disappears after runtime resume.

Fixes: 21a0ffd9b38c ("net: wwan: Add Qualcomm BAM-DMUX WWAN network driver")
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/net/wwan/qcom_bam_dmux.c | 143 ++++++++++++++++++++++++-------
 1 file changed, 114 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
index cc6ace8d6437..95a2c427323c 100644
--- a/drivers/net/wwan/qcom_bam_dmux.c
+++ b/drivers/net/wwan/qcom_bam_dmux.c
@@ -12,11 +12,13 @@
 #include <linux/if_arp.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/soc/qcom/smem_state.h>
 #include <linux/spinlock.h>
+#include <linux/srcu.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <net/pkt_sched.h>
@@ -73,8 +75,11 @@ struct bam_dmux {
 	u32 pc_mask, pc_ack_mask;
 	wait_queue_head_t pc_wait;
 	struct completion pc_ack_completion;
+	struct mutex power_lock; /* Protect power state and TX replacement */
 
-	struct dma_chan *rx, *tx;
+	struct dma_chan *rx;
+	struct dma_chan __rcu *tx;
+	struct srcu_struct tx_srcu;
 	struct bam_dmux_skb_dma rx_skbs[BAM_DMUX_NUM_SKB];
 	struct bam_dmux_skb_dma tx_skbs[BAM_DMUX_NUM_SKB];
 	spinlock_t tx_lock; /* Protect tx_skbs, tx_next_skb */
@@ -106,6 +111,23 @@ static void bam_dmux_pc_ack(struct bam_dmux *dmux)
 	dmux->pc_ack_state = !dmux->pc_ack_state;
 }
 
+static struct dma_chan *bam_dmux_tx_get(struct bam_dmux *dmux, int *srcu_idx)
+{
+	*srcu_idx = srcu_read_lock(&dmux->tx_srcu);
+	return srcu_dereference(dmux->tx, &dmux->tx_srcu);
+}
+
+static void bam_dmux_tx_put(struct bam_dmux *dmux, int srcu_idx)
+{
+	srcu_read_unlock(&dmux->tx_srcu, srcu_idx);
+}
+
+static struct dma_chan *bam_dmux_tx_locked(struct bam_dmux *dmux)
+{
+	lockdep_assert_held(&dmux->power_lock);
+	return rcu_dereference_protected(dmux->tx, 1);
+}
+
 static bool bam_dmux_skb_dma_map(struct bam_dmux_skb_dma *skb_dma,
 				 enum dma_data_direction dir)
 {
@@ -182,12 +204,13 @@ static void bam_dmux_tx_callback(void *data)
 	dev_consume_skb_any(skb);
 }
 
-static bool bam_dmux_skb_dma_submit_tx(struct bam_dmux_skb_dma *skb_dma)
+static bool bam_dmux_skb_dma_submit_tx(struct bam_dmux_skb_dma *skb_dma,
+				       struct dma_chan *tx)
 {
 	struct bam_dmux *dmux = skb_dma->dmux;
 	struct dma_async_tx_descriptor *desc;
 
-	desc = dmaengine_prep_slave_single(dmux->tx, skb_dma->addr,
+	desc = dmaengine_prep_slave_single(tx, skb_dma->addr,
 					   skb_dma->skb->len, DMA_MEM_TO_DEV,
 					   DMA_PREP_INTERRUPT);
 	if (!desc) {
@@ -229,9 +252,10 @@ static int bam_dmux_send_cmd(struct bam_dmux_netdev *bndev, u8 cmd)
 {
 	struct bam_dmux *dmux = bndev->dmux;
 	struct bam_dmux_skb_dma *skb_dma;
+	struct dma_chan *tx;
 	struct bam_dmux_hdr *hdr;
 	struct sk_buff *skb;
-	int ret;
+	int ret, srcu_idx;
 
 	skb = alloc_skb(sizeof(*hdr), GFP_KERNEL);
 	if (!skb)
@@ -257,14 +281,23 @@ static int bam_dmux_send_cmd(struct bam_dmux_netdev *bndev, u8 cmd)
 		goto tx_fail;
 	}
 
-	if (!bam_dmux_skb_dma_submit_tx(skb_dma)) {
+	tx = bam_dmux_tx_get(dmux, &srcu_idx);
+	if (!tx) {
+		ret = -ENODEV;
+		goto tx_put_fail;
+	}
+
+	if (!bam_dmux_skb_dma_submit_tx(skb_dma, tx)) {
 		ret = -EIO;
-		goto tx_fail;
+		goto tx_put_fail;
 	}
 
-	dma_async_issue_pending(dmux->tx);
+	dma_async_issue_pending(tx);
+	bam_dmux_tx_put(dmux, srcu_idx);
 	return 0;
 
+tx_put_fail:
+	bam_dmux_tx_put(dmux, srcu_idx);
 tx_fail:
 	bam_dmux_tx_done(skb_dma);
 free_skb:
@@ -335,7 +368,8 @@ static netdev_tx_t bam_dmux_netdev_start_xmit(struct sk_buff *skb,
 	struct bam_dmux_netdev *bndev = netdev_priv(netdev);
 	struct bam_dmux *dmux = bndev->dmux;
 	struct bam_dmux_skb_dma *skb_dma;
-	int active, ret;
+	struct dma_chan *tx;
+	int active, ret, srcu_idx;
 
 	skb_dma = bam_dmux_tx_queue(dmux, skb);
 	if (!skb_dma)
@@ -360,12 +394,16 @@ static netdev_tx_t bam_dmux_netdev_start_xmit(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 	}
 
-	if (!bam_dmux_skb_dma_submit_tx(skb_dma))
-		goto drop;
+	tx = bam_dmux_tx_get(dmux, &srcu_idx);
+	if (!tx || !bam_dmux_skb_dma_submit_tx(skb_dma, tx))
+		goto tx_put_drop;
 
-	dma_async_issue_pending(dmux->tx);
+	dma_async_issue_pending(tx);
+	bam_dmux_tx_put(dmux, srcu_idx);
 	return NETDEV_TX_OK;
 
+tx_put_drop:
+	bam_dmux_tx_put(dmux, srcu_idx);
 drop:
 	bam_dmux_tx_done(skb_dma);
 	dev_kfree_skb_any(skb);
@@ -375,8 +413,9 @@ static netdev_tx_t bam_dmux_netdev_start_xmit(struct sk_buff *skb,
 static void bam_dmux_tx_wakeup_work(struct work_struct *work)
 {
 	struct bam_dmux *dmux = container_of(work, struct bam_dmux, tx_wakeup_work);
+	struct dma_chan *tx;
 	unsigned long pending;
-	int ret, i;
+	int ret, i, srcu_idx;
 
 	ret = pm_runtime_resume_and_get(dmux->dev);
 	if (ret < 0) {
@@ -389,10 +428,24 @@ static void bam_dmux_tx_wakeup_work(struct work_struct *work)
 		goto out;
 
 	dev_dbg(dmux->dev, "pending skbs after wakeup: %#lx\n", pending);
+	tx = bam_dmux_tx_get(dmux, &srcu_idx);
+	if (!tx) {
+		bam_dmux_tx_put(dmux, srcu_idx);
+		for_each_set_bit(i, &pending, BAM_DMUX_NUM_SKB) {
+			struct bam_dmux_skb_dma *skb_dma = &dmux->tx_skbs[i];
+			struct sk_buff *skb = skb_dma->skb;
+
+			bam_dmux_tx_done(skb_dma);
+			dev_kfree_skb_any(skb);
+		}
+		goto out;
+	}
+
 	for_each_set_bit(i, &pending, BAM_DMUX_NUM_SKB) {
-		bam_dmux_skb_dma_submit_tx(&dmux->tx_skbs[i]);
+		bam_dmux_skb_dma_submit_tx(&dmux->tx_skbs[i], tx);
 	}
-	dma_async_issue_pending(dmux->tx);
+	dma_async_issue_pending(tx);
+	bam_dmux_tx_put(dmux, srcu_idx);
 
 out:
 	pm_runtime_put_autosuspend(dmux->dev);
@@ -655,10 +708,16 @@ static void bam_dmux_free_skbs(struct bam_dmux_skb_dma skbs[],
 
 static void bam_dmux_power_off(struct bam_dmux *dmux)
 {
-	if (dmux->tx) {
-		dmaengine_terminate_sync(dmux->tx);
-		dma_release_channel(dmux->tx);
-		dmux->tx = NULL;
+	struct dma_chan *tx;
+
+	lockdep_assert_held(&dmux->power_lock);
+
+	tx = bam_dmux_tx_locked(dmux);
+	RCU_INIT_POINTER(dmux->tx, NULL);
+	synchronize_srcu(&dmux->tx_srcu);
+	if (tx) {
+		dmaengine_terminate_sync(tx);
+		dma_release_channel(tx);
 	}
 
 	if (dmux->rx) {
@@ -673,7 +732,10 @@ static void bam_dmux_power_off(struct bam_dmux *dmux)
 static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
 {
 	struct bam_dmux *dmux = data;
-	bool new_state = !dmux->pc_state;
+	bool new_state;
+
+	mutex_lock(&dmux->power_lock);
+	new_state = !dmux->pc_state;
 
 	dev_dbg(dmux->dev, "pc: %u\n", new_state);
 
@@ -687,7 +749,8 @@ static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
 		bam_dmux_pc_ack(dmux);
 	}
 
-	dmux->pc_state = new_state;
+	WRITE_ONCE(dmux->pc_state, new_state);
+	mutex_unlock(&dmux->power_lock);
 	wake_up_all(&dmux->pc_wait);
 
 	return IRQ_HANDLED;
@@ -716,6 +779,7 @@ static int bam_dmux_runtime_suspend(struct device *dev)
 static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
 {
 	struct bam_dmux *dmux = dev_get_drvdata(dev);
+	struct dma_chan *tx;
 
 	dev_dbg(dev, "runtime resume\n");
 
@@ -735,29 +799,37 @@ static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
 	}
 
 	/* Wait until we're up */
-	if (!wait_event_timeout(dmux->pc_wait, dmux->pc_state,
+	if (!wait_event_timeout(dmux->pc_wait, READ_ONCE(dmux->pc_state),
 				BAM_DMUX_REMOTE_TIMEOUT)) {
 		bam_dmux_pc_vote(dmux, false);
 		return -ETIMEDOUT;
 	}
 
+	mutex_lock(&dmux->power_lock);
+
 	/* Ensure that we actually initialized successfully */
-	if (!dmux->rx) {
+	if (!dmux->pc_state || !dmux->rx) {
+		mutex_unlock(&dmux->power_lock);
 		bam_dmux_pc_vote(dmux, false);
 		return -ENXIO;
 	}
 
 	/* Request TX channel if necessary */
-	if (dmux->tx)
+	tx = bam_dmux_tx_locked(dmux);
+	if (tx) {
+		mutex_unlock(&dmux->power_lock);
 		return 0;
+	}
 
-	dmux->tx = dma_request_chan(dev, "tx");
-	if (IS_ERR(dmux->tx)) {
-		dev_err(dev, "Failed to request TX DMA channel: %pe\n", dmux->tx);
-		dmux->tx = NULL;
+	tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(tx)) {
+		dev_err(dev, "Failed to request TX DMA channel: %pe\n", tx);
+		mutex_unlock(&dmux->power_lock);
 		bam_dmux_runtime_suspend(dev);
 		return -ENXIO;
 	}
+	rcu_assign_pointer(dmux->tx, tx);
+	mutex_unlock(&dmux->power_lock);
 
 	return 0;
 }
@@ -799,6 +871,7 @@ static int bam_dmux_probe(struct platform_device *pdev)
 	init_waitqueue_head(&dmux->pc_wait);
 	init_completion(&dmux->pc_ack_completion);
 	complete_all(&dmux->pc_ack_completion);
+	mutex_init(&dmux->power_lock);
 
 	spin_lock_init(&dmux->tx_lock);
 	INIT_WORK(&dmux->tx_wakeup_work, bam_dmux_tx_wakeup_work);
@@ -808,6 +881,9 @@ static int bam_dmux_probe(struct platform_device *pdev)
 		dmux->rx_skbs[i].dmux = dmux;
 		dmux->tx_skbs[i].dmux = dmux;
 	}
+	ret = init_srcu_struct(&dmux->tx_srcu);
+	if (ret)
+		return ret;
 
 	/* Runtime PM manages our own power vote.
 	 * Note that the RX path may be active even if we are runtime suspended,
@@ -827,10 +903,11 @@ static int bam_dmux_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_disable_pm;
 
+	mutex_lock(&dmux->power_lock);
 	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
 				    &dmux->pc_state);
 	if (ret)
-		goto err_disable_pm;
+		goto err_unlock_power;
 
 	/* Check if remote finished initialization before us */
 	if (dmux->pc_state) {
@@ -839,12 +916,16 @@ static int bam_dmux_probe(struct platform_device *pdev)
 		else
 			bam_dmux_power_off(dmux);
 	}
+	mutex_unlock(&dmux->power_lock);
 
 	return 0;
 
+err_unlock_power:
+	mutex_unlock(&dmux->power_lock);
 err_disable_pm:
 	pm_runtime_disable(dev);
 	pm_runtime_dont_use_autosuspend(dev);
+	cleanup_srcu_struct(&dmux->tx_srcu);
 	return ret;
 }
 
@@ -872,13 +953,17 @@ static void bam_dmux_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(dev);
 
 	/* Try to wait for remote side to drop power vote */
-	if (!wait_event_timeout(dmux->pc_wait, !dmux->rx, BAM_DMUX_REMOTE_TIMEOUT))
+	if (!wait_event_timeout(dmux->pc_wait, !READ_ONCE(dmux->rx),
+				BAM_DMUX_REMOTE_TIMEOUT))
 		dev_err(dev, "Timed out waiting for remote side to suspend\n");
 
 	/* Make sure everything is cleaned up before we return */
 	disable_irq(dmux->pc_irq);
+	mutex_lock(&dmux->power_lock);
 	bam_dmux_power_off(dmux);
+	mutex_unlock(&dmux->power_lock);
 	bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
+	cleanup_srcu_struct(&dmux->tx_srcu);
 }
 
 static const struct dev_pm_ops bam_dmux_pm_ops = {
-- 
2.50.1.windows.1

