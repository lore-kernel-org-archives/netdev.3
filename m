Received: from out198-19.us.a.mail.aliyun.com (out198-19.us.a.mail.aliyun.com [47.90.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6DB39D6F2;
	Tue, 13 Oct 2026 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853912; cv=none; b=oVAgROwJXVHG8VYIcISA0DhDY2nEzYiEKzG+/uddrU4RFYWk2Ru92ml7WCJ1Pou1sSUptzUit3OdNYl8NdcA4uC8iPeOeur57VkOsNi4mYM2pVSzFvJ+9IHe+SJevTBIQZZFyh1n7cr+O5hFBtXua/VepP3CUUcbIB15z8te8eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853912; c=relaxed/simple;
	bh=RCZ0zIFHLIo18pbU4RRWP6Ed3IhwfvFryWI37R1U4E4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UgT78QRQmMCtsCxHL8Wv+vPhn+iHc1KqjCVJEbo1Ay6oo1GCu4e4Z/DFO4D9XOnlhLQBrp0h0E9Eahd95K6x/qsLUfuIinpc2q3nwX/GfqTelLmuKN/VCallN2IP5iPoDZyt2xdgPYDhckapcch9eFPjVqaM3uAgIb0OcZc/zdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2044381|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00928265-0.000186091-0.990531;FP=12062864084113723030|14|2|17|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jatt1I7_1791853889;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jatt1I7_1791853889 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 13 Oct 2026 09:11:30 +0800
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
Subject: [PATCH net-next v14 3/5] net: dsa: motorcomm: use fixed-width GENMASK_U*() helpers
Date: Tue, 13 Oct 2026 09:11:20 +0800
Message-Id: <20261013011122.1889766-4-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261013011122.1889766-1-kyle.switch@motor-comm.com>
References: <20261013011122.1889766-1-kyle.switch@motor-comm.com>
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c     | 12 ++++++------
 drivers/net/dsa/motorcomm/mdio_bus.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index d4c20658216a..ba988e121d68 100644
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

