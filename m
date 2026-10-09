Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC8C4DE729;
	Fri,  9 Oct 2026 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548945; cv=none; b=IbE3Xy382lBbdDJlT9NAhUwqdTH1eglqSDDnIFRXzdZ8+RDeDrOZA55nqG16ITikn9HZj/17QkAy82Ly+qRM9YBVNISUktI5Fj3IqGKSfWbl9KkMENIak7Yy1M+dA8qdK4TzEL72UQXZvkX0boEYRvIIw46aAQHyC7/ryA2eRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548945; c=relaxed/simple;
	bh=wRH8iPiGNGHVJcoy6D+CL8HTOtzMp948dKj9Yr57zbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S1cTMHS0gFeJM0hJ7W09Mq9yYjSIJkNfIceEm/K+vJvNN1EuHcC/HGP7/qV1+O3MiTnamrXaHAhUizIG4H5XCptG/z8Kma8VEeT2wbDjxFnJU7Gw14u66xy0JiQXKQpbOA2eskiW2ESpI8GMzebMcK40AxEAqFPksrm7u6Po+EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2200168|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00928265-0.000186091-0.990531;FP=12062864084650561172|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jXj4ZzF_1791548924;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jXj4ZzF_1791548924 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 09 Oct 2026 20:28:45 +0800
From: Kyle Switch <kyle.switch@motor-comm.com>
To: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mmyangfl@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com,
	sijia.huang@gl-inet.com
Subject: [PATCH net-next v12 3/5] net: dsa: motorcomm: use fixed-width GENMASK_U*() helpers
Date: Fri,  9 Oct 2026 20:28:34 +0800
Message-Id: <20261009122836.1534400-4-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261009122836.1534400-1-kyle.switch@motor-comm.com>
References: <20261009122836.1534400-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some masks assigned to u16 and u32 fields are defined with
GENMASK(),which is an unsigned long constant and wider than
the field type on 64-bit builds. Convert the affected
internal_mask entries in chip.c and the YT921X_MBUS_CTRL_*
masks used by mdio_bus.c to fixed-width helpers.

This is a type cleanup only, with no functional change.  Other
GENMASK() uses in the driver are intentionally left untouched.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c     | 12 ++++++------
 drivers/net/dsa/motorcomm/mdio_bus.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 76bf68af8915..dbf9d20782a3 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -36,19 +36,19 @@
 static const struct yt921x_info yt921x_infos[] = {
 	{
 		"YT9215SC", YT9215_MAJOR, 1, 0,
-		GENMASK(4, 0),
+		GENMASK_U16(4, 0),
 		BIT(9),
 		BIT(8) | BIT(9),
 	},
 	{
 		"YT9215S", YT9215_MAJOR, 2, 0,
-		GENMASK(4, 0),
+		GENMASK_U16(4, 0),
 		BIT(9),
 		BIT(8),
 	},
 	{
 		"YT9215RB", YT9215_MAJOR, 3, 0,
-		GENMASK(4, 0),
+		GENMASK_U16(4, 0),
 		BIT(8) | BIT(9),
 		0,
 	},
@@ -66,13 +66,13 @@ static const struct yt921x_info yt921x_infos[] = {
 	},
 	{
 		"YT9218N", YT9218_MAJOR, 0, 0,
-		GENMASK(7, 0),
+		GENMASK_U16(7, 0),
 		0,
 		0,
 	},
 	{
 		"YT9218MB", YT9218_MAJOR, 1, 0,
-		GENMASK(7, 0),
+		GENMASK_U16(7, 0),
 		BIT(8) | BIT(9),
 		BIT(8) | BIT(9),
 	},
@@ -3741,7 +3741,7 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
-	ctrl = GENMASK(10, 0);
+	ctrl = GENMASK_U32(10, 0);
 	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
 	if (res)
 		return res;
diff --git a/drivers/net/dsa/motorcomm/mdio_bus.c b/drivers/net/dsa/motorcomm/mdio_bus.c
index 83f0212551ff..3aa1111efaa4 100644
--- a/drivers/net/dsa/motorcomm/mdio_bus.c
+++ b/drivers/net/dsa/motorcomm/mdio_bus.c
@@ -159,7 +159,7 @@ int yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
 	mbus->write = yt921x_mbus_int_write;
 	mbus->parent = dev;
 	max_ports = priv->series->max_ports;
-	mbus->phy_mask = (u32)~GENMASK(max_ports - 1, 0);
+	mbus->phy_mask = ~GENMASK_U32(max_ports - 1, 0);
 
 	res = devm_of_mdiobus_register(dev, mbus, mnp);
 	if (res)
-- 
2.25.1

