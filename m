Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9812E4FD7A4;
	Fri,  2 Oct 2026 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962647; cv=none; b=hq1oVi8POBb8GkLGqWeg4jYMaDzaQ3EsUqgyIs2HgwsOeJ0RtobfCXVXyVD9AAKtJjSCaHIw91CVQFJH2TF7dS+hTYvglLBqVkEeo3gFC7fPM+honxrOJ/KYwyGJCr7QnzS94hUtD3e3V3pq7Jbs19UMmc8MscTYIT6moa/i0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962647; c=relaxed/simple;
	bh=IBDv8+BMy3dt9kr7KFiHxbSxPzp4r0YYk23asXZz7w8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EC/NHNRwS8BoyeIkWnLwUGlmN+KpBWuBMixpfGfnNNzmGoVQ316ghsYU5O5SDwyRZyrwvxgudiBwlklhWeV0YWapbI8LG2Gqwsv/r9vTgQA9otsm89RkzBPWRvefILv0eaExAziZMR9eh/XdVanoSp6mG6mn3GcjQY2FtEqYWfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1447878|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.011701-0.000248947-0.98805;FP=9756950124187750020|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jTk7nSD_1790962635;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jTk7nSD_1790962635 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 03 Oct 2026 01:37:15 +0800
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
Subject: [PATCH net-next v11 3/7] net: dsa: motorcomm: use fixed-width GENMASK_U*() helpers
Date: Sat,  3 Oct 2026 01:37:02 +0800
Message-Id: <20261002173706.1225502-4-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261002173706.1225502-1-kyle.switch@motor-comm.com>
References: <20261002173706.1225502-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the plain GENMASK() uses with the fixed-width GENMASK_U16()
and GENMASK_U32() variants.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c     | 12 ++++++------
 drivers/net/dsa/motorcomm/mdio_bus.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 79422def16ff..13fc286d4194 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -101,19 +101,19 @@ static const struct yt921x_mib_desc yt921x_mib_descs[] = {
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
@@ -131,13 +131,13 @@ static const struct yt921x_info yt921x_infos[] = {
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
@@ -4061,7 +4061,7 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
-	ctrl = GENMASK(10, 0);
+	ctrl = GENMASK_U32(10, 0);
 	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
 	if (res)
 		return res;
diff --git a/drivers/net/dsa/motorcomm/mdio_bus.c b/drivers/net/dsa/motorcomm/mdio_bus.c
index c5a0f1bc1e36..1ac6a94f4f9d 100644
--- a/drivers/net/dsa/motorcomm/mdio_bus.c
+++ b/drivers/net/dsa/motorcomm/mdio_bus.c
@@ -161,7 +161,7 @@ int yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
 	mbus->write = yt921x_mbus_int_write;
 	mbus->parent = dev;
 	max_ports = priv->series->max_ports;
-	mbus->phy_mask = (u32)~GENMASK(max_ports - 1, 0);
+	mbus->phy_mask = ~GENMASK_U32(max_ports - 1, 0);
 
 	res = devm_of_mdiobus_register(dev, mbus, mnp);
 	if (res)
-- 
2.25.1

