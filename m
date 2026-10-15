Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF1D3D7D6A
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 02:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792031203; cv=none; b=ju0kOzXD2bM6Zsl2yp8Qtb6IcPluo32zlZWTWq+ErpVlZT2LlcxrZBakdVMHBgG0simYKG76DbckcxdNB9OI0a0W8ugJK3UMDeR5495yj5ouRJwwAlOCKWq+mYXpXDRosidHH9rBCLf9xE3x5SngwurWRuu3r0AGlbn8PUpWPLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792031203; c=relaxed/simple;
	bh=FZStNsMs2iriGK7e9KujuhmKPVMrb/FMjjGfoQ39NjI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aPIubxaTooGhDnd+hQCaMnhccJIZgQ3WDMdhk++xoGnhYCLE76dGlWwt7kphP74fXKbuZCPRNy7KqCDOogy5Kag8i3Gzso0T3TBCeGlTevGOWiWi74Garwnx6LpOGeauUN42IUVc/J0zQsEqcKhAKt3reOVoMdZJs+/rI9JbH+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAzxYuyd; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAzxYuyd"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e441e14a1so76932885a.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 19:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792031201; x=1792636001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DFplvxZRSsha+wXsqtuuqXSDkXUdJ1l1AD0B2sqIS80=;
        b=WAzxYuydGkUkcyg6QI6kBVCZQE5Bz8pgSio209WYOxISag5wvirMNuP0M/zGeOgJD1
         mne9DWK71ftn9xFWpC8ZSjufHDU1STWbPJjGpDdvLfY9+gxeww7VtL2o+ULW7Q7jiyAy
         oLAeFgq6juTk0FlqGJlAzO0/IrcE0ANQVTieDc+HKbjKWRkYAThMjB8HlrJhPkl5n969
         pvLqZ7zjG8d+/6fnpNH/5Zjlr6RxJyujKyRrXjIn8X9Gmly9N0SHEz8mBoiEaEit/TD1
         /sQBLlGV0fuJ+1GtHYIkwAw7ToprffuAqzlW1hU7NCuHV3oxVBOOpUcGUHYR/3Tedcfz
         sGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792031201; x=1792636001;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DFplvxZRSsha+wXsqtuuqXSDkXUdJ1l1AD0B2sqIS80=;
        b=fMCITi91ouDFML4F22ej/EkD+/Mejf0EOn0BhnnfZIpPfEz/R9no89neit4cGnbJ8h
         fuW1yOvLQHPLweAKAQim31WduEMrFxOWNcC5Uq7A/3OiIuIAjj2W67+ihBw7R1PdChWG
         7dLCZeksszt3+j1LAq2l0GP73ZGJE9nH+IIOsomUFxjJnAQuUkKAVKLcdRQx17MCOhxN
         MMmv+SCHM0HLPJnig5P9nmKeaDydeyu+U1cJgxcYNEMU741EXLIJAOoBpX2Wgur2G117
         C2pihGsmTX/N1PzIX6LsWMZEGf64GHMCZmI5Shge1hzmdxAFRN2RRfblTYlFKzR5XnZX
         yJyQ==
X-Gm-Message-State: AFq9FYIrrvoxCmA2W0OtuG9nOAL2pckBgQadJy8T3WBS/ZIvIlf+spQD
	vaUVltKCFX9qFIlAzfu/AABBGmUSxIqVjl9Difc29t+3hvufRWNJL7M=
X-Gm-Gg: AYBFou1UsrA4NERsYj7kPaBHm+re1Tj0nlzmigP6zrIdcVZAS+n4RV/dX6eh8zceT1z
	hwjOSyAl7W8jEH294c6yAtzpDEbxx07S4K7iZzmvjXJ0b0Aec5qM6k4K6skOIP7b6bMxuGXUlAn
	tSJdTugB9GwZ3HE0UYBTt2Bk5YfF8xhKyAlQsdJmg2OeG1rNtX07JN+SXiFjEK/s6aLhaNhdIoZ
	GjVgi4wiEaLfux1goobr1PD0GRV+uahT2Bc/97JSh8HUn8+L0OPiJGBw5T1hHugEVXMVbbNt7KQ
	HyVqC6eHaPTHApRW4HrXa4ug1+iy8x8QfUgQpTblNwEkAi87EB4wwB0DWOezqhptxFlbnIqZbsE
	SYCruvkxyJGRwsB8ZzM7RBX+DrCDHFJvs+a17gKUJK4DaMKGok7mNHCJHuXJP4AkaNTncWhmua+
	5wirMP94F1Ue9M3bQGRVb7IKo+QIGTWoCc3JSGmEbe0a5IW8Gkl4zwmQR0pqRprIHSEK4jo7NkD
	ZzCvw+LSZs6XwQes4M6EnEI9Q1OhuJplZqja4OE3h7hDL0iSD9B54ztJjL2ssG5zbGw/UphojYM
	S2brIUe8OQjLR/xlJ0jlPgH1PudR
X-Received: by 2002:a05:620a:270d:b0:93e:7939:43f0 with SMTP id af79cd13be357-93ebd247f8dmr2978360585a.32.1792031200865;
        Wed, 14 Oct 2026 19:26:40 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef502608bsm652354085a.25.2026.10.14.19.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:26:39 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: hix5hd2: serialize timeout recovery with interface teardown
Date: Wed, 14 Oct 2026 22:26:35 -0400
Message-ID: <179203116093.2621539.3718842986255459438.G202@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The timeout worker calls the driver's close and open methods without
RTNL or a running-state check. A timeout queued before an interface is
closed can call close again after ndo_stop has disabled NAPI. The second
napi_disable() can then wait indefinitely. The worker can also race with
an ongoing close.

Take RTNL and skip recovery when the interface is no longer running.
Use the netdev core close and open helpers so a failed reopen leaves the
interface down, rather than leaving it marked running with NAPI disabled.

After unregister_netdev() has stopped the watchdog, drain the worker
before releasing its MDIO and descriptor resources. This wait is outside
RTNL, allowing an already queued worker to take RTNL, observe the down
state, and finish.

This issue was identified as part of our ongoing research while
reviewing kernel code.

Fixes: 57c5bc9ad7d7 ("net: hisilicon: add hix5hd2 mac driver")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Compile-tested with GCC, W=1 (arm64). No runtime testing.

Related remove-path change (devres-managed netdev lifetime):
https://lkml.iu.edu/2610.0/05627.html

 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
index 02282dc..12a5657 100644
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -12,6 +12,7 @@
 #include <linux/of_net.h>
 #include <linux/of_mdio.h>
 #include <linux/reset.h>
+#include <linux/rtnetlink.h>
 #include <linux/clk.h>
 #include <linux/circ_buf.h>
 
@@ -890,8 +891,13 @@ static void hix5hd2_tx_timeout_task(struct work_struct *work)
 	struct hix5hd2_priv *priv;
 
 	priv = container_of(work, struct hix5hd2_priv, tx_timeout_task);
-	hix5hd2_net_close(priv->netdev);
-	hix5hd2_net_open(priv->netdev);
+
+	rtnl_lock();
+	if (netif_running(priv->netdev)) {
+		dev_close(priv->netdev);
+		dev_open(priv->netdev, NULL);
+	}
+	rtnl_unlock();
 }
 
 static void hix5hd2_net_timeout(struct net_device *dev, unsigned int txqueue)
@@ -1283,6 +1289,7 @@ static void hix5hd2_dev_remove(struct platform_device *pdev)
 	struct hix5hd2_priv *priv = netdev_priv(ndev);
 
 	unregister_netdev(ndev);
+	cancel_work_sync(&priv->tx_timeout_task);
 	mdiobus_unregister(priv->bus);
 	mdiobus_free(priv->bus);
 
@@ -1290,7 +1297,6 @@ static void hix5hd2_dev_remove(struct platform_device *pdev)
 		hix5hd2_destroy_sg_desc_queue(priv);
 	hix5hd2_destroy_hw_desc_queue(priv);
 	of_node_put(priv->phy_node);
-	cancel_work_sync(&priv->tx_timeout_task);
 	free_netdev(ndev);
 }
 
