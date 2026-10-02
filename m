Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B316247ACC4;
	Fri,  2 Oct 2026 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945788; cv=none; b=esxfLON2isFTAIm4VRjAMuaHcY3xukp6XNca8I/QmGNpez9WtNlDyM/mMu9AFJDtOOwgZfCRiKsqir8TnLOpKFs0HTPHaaLs2ekxEIge8oQ/pKkBn9FH7rqTaAwqOU01J8uoTtLfByN9EHPRiXrJTP1Ya0EdSGCaKd8+zdPNoUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945788; c=relaxed/simple;
	bh=JjIBXYtG3twgn9les2QpRRnZOUpHc6H++tKDNPUZFso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+BA0iDi9zyVnFnDzYUscQi7MBEPm1OKeXwAPJJtKlOHaH781C+3pwI6eBPwFvEwPS/7gKs7uvSabBCOmy53c4iBTIa1ffE4DZuX2w2ow4w6YUEIyE3tPH5hngu/f6B+w9WquXAPLZEnp8cvUC9wS5xaila3sqwo0pmnsVZTDYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml+F3eRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml+F3eRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F001F00893;
	Fri,  2 Oct 2026 12:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790945787;
	bh=H6CbJk56XJn2rB65nnlreCSIwAnOQ3pSIcdlMg6BQKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ml+F3eRL14E5GOLWpXTHpo0yYnZOU4p9ZXwyBBWsfpFr53tY37nXjkK17cyDGHU1Z
	 e6YbZUHklqUTk+U9n7IOeQgQhLCze1rB4t7447bwgNjgDFvgDOpDI29gdeXvfqLWNZ
	 HRranwUd9+lzHshha+FV6qy6Svz8vu0g2z+BvxD+IMDNq5ToSGi8gCls+VfuIsHMsw
	 lragDF1Sfk+TzqiTKf699ujv7PWYKzqC+MZ1P1Hlih6hXAGSQnbGtRVvXigVFyXc/t
	 23wtTsAxwK6PCM26vkV1l73jyDOAFnmn3aBEvZ5Ph3oAxq3KKJ8+Prk9tWgu4KBtIP
	 c7dEZv5oKDu7Q==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com (reviewer:META ETHERNET DRIVERS),
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net v3 1/2] eth: fbnic: Preserve channels across resume
Date: Fri,  2 Oct 2026 14:56:14 +0200
Message-ID: <20261002125617.409447-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002125617.409447-1-bjorn@kernel.org>
References: <20261002125617.409447-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Suspend clears the configured NAPI count. Resume then reconstructs the
channel layout from queue counts, changing standalone channels into
combined ones or dropping combined queues despite unchanged IRQs.

Keep the selected NAPI count across suspend and reuse the layout on
resume. A failed recovery leaves no live NAPI vectors, so skip a
redundant stop rather than dereferencing them.

If fewer IRQs return, reopening still fails. Handle that separately.

Found by code inspection while reviewing the queue-count fix. The
layout change has not been reproduced on fbnic hardware.

Fixes: 3a481cc72673 ("eth: fbnic: support ring channel get and set while down")
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 11 +++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h |  3 ---
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c    |  9 ---------
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 10bf99be3f24..d1ed29312d54 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -86,6 +86,13 @@ static int fbnic_stop(struct net_device *netdev)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
 
+	/* Suspend frees NAPI vectors but keeps num_napi for resume.
+	 * If recovery fails, netif_running() remains set; a later stop
+	 * must not walk the freed vectors again.
+	 */
+	if (!fbn->napi[0])
+		return 0;
+
 	fbnic_mac_free_irq(fbn->fbd);
 	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));
 
@@ -702,8 +709,8 @@ static const struct netdev_stat_ops fbnic_stat_ops = {
 	.get_base_stats		= fbnic_get_base_stats,
 };
 
-void fbnic_reset_queues(struct fbnic_net *fbn,
-			unsigned int tx, unsigned int rx)
+static void fbnic_reset_queues(struct fbnic_net *fbn,
+			       unsigned int tx, unsigned int rx)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
 	unsigned int max_napis;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index eded20b0e9e4..ddf1b674737a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -86,9 +86,6 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd);
 void fbnic_netdev_free(struct fbnic_dev *fbd);
 int fbnic_netdev_register(struct net_device *netdev);
 void fbnic_netdev_unregister(struct net_device *netdev);
-void fbnic_reset_queues(struct fbnic_net *fbn,
-			unsigned int tx, unsigned int rx);
-
 void fbnic_set_ethtool_ops(struct net_device *dev);
 
 int fbnic_ptp_setup(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index c6698e3002a1..ec916c9f7faa 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -434,7 +434,6 @@ static int fbnic_pm_suspend(struct device *dev)
 {
 	struct fbnic_dev *fbd = dev_get_drvdata(dev);
 	struct net_device *netdev = fbd->netdev;
-	struct fbnic_net *fbn;
 
 	if (fbnic_init_failure(fbd))
 		goto null_uc_addr;
@@ -442,16 +441,11 @@ static int fbnic_pm_suspend(struct device *dev)
 	rtnl_lock();
 	netdev_lock(netdev);
 
-	fbn = netdev_priv(netdev);
-
 	netif_device_detach(netdev);
 
 	if (netif_running(netdev))
 		netdev->netdev_ops->ndo_stop(netdev);
 
-	/* The IRQs are about to be freed, so drop the napi vector count */
-	fbn->num_napi = 0;
-
 	netdev_unlock(netdev);
 	rtnl_unlock();
 
@@ -519,9 +513,6 @@ static int __fbnic_pm_resume(struct device *dev)
 
 	fbn = netdev_priv(netdev);
 
-	/* Reset the queues if needed */
-	fbnic_reset_queues(fbn, fbn->num_tx_queues, fbn->num_rx_queues);
-
 	if (netif_running(netdev)) {
 		err = __fbnic_open(fbn);
 		/* On failure the vectors are freed, so drop the count */
-- 
2.55.0

