Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127FB332637
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116042; cv=none; b=iioSwLJ2ui+LIEv7z0wKv6vQGPG9ESxxaN9lF9JP3nW+k+6TZXZNycIDf0R5W8IJ14k2X6vgyIH4zsEQfVud93OObDYTipgXzPPO7SztgN7M5nAfBBCZIocal4MIRRIGe0pFjnUg5/yrPUjpixI7QNtFGYWKr8bKYJt7cA+vEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116042; c=relaxed/simple;
	bh=VulW9CILuegVmww3RssOPbu+bMH+gjnGMIzwfevS5NA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLpMDHXFvW485laNpCt9Y5o8DlBF030iTlV9Nva6cnVQiv9RB+s5CxZU9cypzIPX1lKqZqDY9baWZKfvr6qbRIrMcTkpyTt8kVwQ4B4GeEGkLPEdOEHoihAUKoyHyUtcwVNJvSb9WHeUKSo9wqLsCWXx5Jik8jJgP8FCFSt68QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6VEngAW; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6VEngAW"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-930c0f9c1b1so625595985a.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792116040; x=1792720840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JLgG8C3R1LRH8a/xCn/z2rdj50h5ikXCY/F9rYop04I=;
        b=j6VEngAWcpts9VLs3Lg8fqCQtrasWKEYkznKGYbA74IU9tsz4rcfzOxS7SR7J6bBso
         ozlazMO+DAi3qeZrZQCK17c11LCRVZaMParh7TC2g7I4B0IyljlbIosi7+ClS8qIDOCy
         U9jv0O85Vstz+/Kt8p/KEHwfU87qggjguMcgdzvv6I3ORbm1xacRotp9R1YZiqfft/2o
         mENcQYWlb+5vLyNKq1batAg+OHAmuVCcZuX2060meu6FsnAoLZ8MG1cHWLq9ljlGv/le
         ikQnaXz2MgiRF/pZruLV0Bgaa7E3OCSuGpdRmusguCGLFIyaSCLiH1Nth6XcC7nZ1RJ8
         nkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116040; x=1792720840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JLgG8C3R1LRH8a/xCn/z2rdj50h5ikXCY/F9rYop04I=;
        b=rWxLCpTzMS/trUSKI6DLTYz107fRwGL+IihLLTEefHfGp1WlA1BYKQsGeugO+KvIUk
         KuWiPh2V7qnu3skv1Ai55DXt8YHleGgq+h6nhpD53r7LqZlPAvIjPPF+JUFQjq/YorSA
         kBRUDSP7H9xj7YQgnnjq2YD3bfbmCLtT/y3m0qti4pxiiBQ9VcaWREaPO+UaOnbykoLm
         tIq7B6I7cqAwqo4LUSlWOaHhzQbi+p4ciKI/n0Xm/v0/aO58EDPvey9pwQN1QRg1Fy5h
         qoSeE+y1rC18yVmf862mA5mwjyEhpnw5mB6uzslJY2dG0pG8H405Jgzu3TP5s+co4m/F
         0msg==
X-Gm-Message-State: AFq9FYILY/49wT/nxtSfgu8BqGuIKUJrONvuqZCHcqtDA3e8x41hisCs
	Zs7VxsVVHT2eKXtsGNZyjU3FeXD15XQ58wuOj2MHedpPVYv3WbA+vac=
X-Gm-Gg: AYBFou3bNsdI36kUTQ+IzNEN5WuS8UJPwmdjnbsGL8MJPbFqsgcY6bwdvnuDpb/LBmH
	c8dob0pEla530q7ktEVQ2wvk0A0zhBnfUotK0cdmwjlQAPnuZhXX4y1JLB/ND8lD6lmduLOX0gS
	ggO8sgrGwtIDroVzKCZgATJhhLZ5hfFMXVh/NKEeprx798GjH2JoP16EErI0Y9Erfe9dXq4OL+z
	nhzv5wEmB+UMPEvSfptwWWrn63yDcpSqS5Ip1zSs8czb4LzYvieAK/hTbvsRKLaqyHV9f2tmCnK
	AQ9/jCeTP4jvVzqzbRctKUipZSTMi0HO094c+kP150bsmbgrsauYLeyD1GYBc9w7d1MEvDlaAWl
	29Sm1VY3BKqOGOFm2bhiuFfQTPGHuVQ0oTSsfiSE4xZ7M4poRxQveoE3cc9nDX9R2adTWKQCysT
	MhvvbcTqbAKcfVAkzI78b6TmigKiH4J2i8u735gGxiP3oj5WCgeBd40mXIfICdschaLvnB1skfW
	SnBc3Z98mTAvgGZQT5gt4KqUPUPI/XhDd2nCit7A61J0c+MrqAPO0u8r+xo3XmX41VimmPHDV9K
	M6J4LK4yvOvxVEDDcWflZUefcOes
X-Received: by 2002:a05:620a:a199:20b0:93f:1e3c:4a31 with SMTP id af79cd13be357-93f1e3c4bacmr18408685a.61.1792116039610;
        Thu, 15 Oct 2026 19:00:39 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a185ea6sm84899885a.21.2026.10.15.19.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:00:38 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: hns: retire service work before releasing device resources
Date: Thu, 15 Oct 2026 22:00:35 -0400
Message-ID: <20261016020035.3621768-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The remove path releases ring, PHY and accelerator resources before
canceling service work, allowing use-after-free. A pending worker can
also reinitialize the device or publish linkwatch events after
unregister.

Set REMOVING, synchronize an in-flight TX timeout, then shut down the
service timer and drain work before unregister invokes ndo_stop.
Serialize reset and link-update state checks and operations with
unregister under RTNL.

Compile-tested with Clang 22.1.2 (W=1); not tested on hardware.

This issue was identified as part of our ongoing research while
reviewing kernel code.

Fixes: b5996f11ea54 ("net: add Hisilicon Network Subsystem basic ethernet support")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 37 ++++++++++++++-----
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index e905f10b894e..977f054b00c3 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -2024,21 +2024,22 @@ static void hns_nic_reset_subtask(struct hns_nic_priv *priv)
 		return;
 	clear_bit(NIC_STATE2_RESET_REQUESTED, &priv->state);
 
-	/* If we're already down, removing or resetting, just bail */
+	rtnl_lock();
+	/* Serialize the reset decision with ndo_stop and unregister. */
 	if (test_bit(NIC_STATE_DOWN, &priv->state) ||
 	    test_bit(NIC_STATE_REMOVING, &priv->state) ||
 	    test_bit(NIC_STATE_RESETTING, &priv->state))
-		return;
+		goto out;
 
 	hns_nic_dump(priv);
 	netdev_info(priv->netdev, "try to reset %s port!\n",
 		    (type == HNAE_PORT_DEBUG ? "debug" : "service"));
 
-	rtnl_lock();
 	/* put off any impending NetWatchDogTimeout */
 	netif_trans_update(priv->netdev);
 	hns_nic_net_reinit(priv->netdev);
 
+out:
 	rtnl_unlock();
 }
 
@@ -2058,7 +2059,14 @@ static void hns_nic_service_task(struct work_struct *work)
 	struct hnae_handle *h = priv->ae_handle;
 
 	hns_nic_reset_subtask(priv);
-	hns_nic_update_link_status(priv->netdev);
+
+	rtnl_lock();
+	/* Keep linkwatch events within the netdev's registered lifetime. */
+	if (!test_bit(NIC_STATE_DOWN, &priv->state) &&
+	    !test_bit(NIC_STATE_REMOVING, &priv->state))
+		hns_nic_update_link_status(priv->netdev);
+	rtnl_unlock();
+
 	h->dev->ops->update_led_status(h);
 	hns_nic_update_stats(priv->netdev);
 
@@ -2398,6 +2406,21 @@ static void hns_nic_dev_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct hns_nic_priv *priv = netdev_priv(ndev);
 
+	set_bit(NIC_STATE_REMOVING, &priv->state);
+	if (priv->notifier_block.notifier_call)
+		hnae_unregister_notifier(&priv->notifier_block);
+	priv->notifier_block.notifier_call = NULL;
+
+	/* Join a TX timeout that passed the REMOVING check before work drain. */
+	if (ndev->reg_state != NETREG_UNINITIALIZED) {
+		netif_tx_lock_bh(ndev);
+		netif_tx_unlock_bh(ndev);
+	}
+
+	/* Stop the timer and drain work before ndo_stop touches the hardware. */
+	timer_shutdown_sync(&priv->service_timer);
+	cancel_work_sync(&priv->service_task);
+
 	if (ndev->reg_state != NETREG_UNINITIALIZED)
 		unregister_netdev(ndev);
 
@@ -2411,12 +2434,6 @@ static void hns_nic_dev_remove(struct platform_device *pdev)
 	if (!IS_ERR_OR_NULL(priv->ae_handle))
 		hnae_put_handle(priv->ae_handle);
 	priv->ae_handle = NULL;
-	if (priv->notifier_block.notifier_call)
-		hnae_unregister_notifier(&priv->notifier_block);
-	priv->notifier_block.notifier_call = NULL;
-
-	set_bit(NIC_STATE_REMOVING, &priv->state);
-	(void)cancel_work_sync(&priv->service_task);
 
 	/* safe for ACPI FW */
 	of_node_put(to_of_node(priv->fwnode));
