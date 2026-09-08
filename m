Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A028C49CF3E;
	Tue,  8 Sep 2026 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856603; cv=none; b=m8vkP7yhNHrZXve2cwfwhqenMRQoDXTU4zz2rmbz/J/wAFZI96Xnmaes6iNeCPYDYTlLCHI6npZLPk8+3Tn+MQS7FK6Om9GvvQMgpWGZ+JlJ7SIk3HRjhsVHuDE+rDSqRlrok9giaGY2UMDDiMISQbzNxpH6hYxG0Ldq5VPv7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856603; c=relaxed/simple;
	bh=ZbkRiwdIo+I8Bslq4L5HW/me5pi+Iw6cRCICsVygidI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iy7HgUEm1vqmcouAWKmA0g6ZR8xoxUY0C6Lm4CeHW+KiYFevHd5x1Ql80qK3HNpFx4/KwqmgVgNok8+2JJMFeZ8HH2cZmLcxRxv5L7U8stgoQagbW5gDrLvY87pikzsEwKKTVJlm9aqobCUEgk+IuUUJTZiqJbHj4tB1zmH9+GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08387864|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00731352-9.94324e-05-0.992587;FP=11778943108571098774|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.j8Z17ul_1788856589;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j8Z17ul_1788856589 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Sep 2026 16:36:29 +0800
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
Subject: [PATCH net-next v6 2/6] net: dsa: motorcomm: use max_ports in series for port bounds checking
Date: Tue,  8 Sep 2026 16:36:10 +0800
Message-Id: <20260908083614.2210505-3-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260908083614.2210505-1-kyle.switch@motor-comm.com>
References: <20260908083614.2210505-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the hardcoded YT921X_PORT_NUM macro with the per-series
max_ports field in port validation. This removes family-specific
constants from the common code path and simplifies adding new
switch families with different port counts.

No functional change for existing YT921X devices.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index ffed823f26a8..191a7aa3733e 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -357,7 +357,7 @@ static int yt921x_mbus_int_read(struct mii_bus *mbus, int port, int reg)
 	u16 val;
 	int res;
 
-	if (port >= YT921X_PORT_NUM)
+	if (port >= priv->series->max_ports)
 		return U16_MAX;
 
 	mutex_lock(&priv->reg_lock);
@@ -375,7 +375,7 @@ yt921x_mbus_int_write(struct mii_bus *mbus, int port, int reg, u16 data)
 	struct yt921x_priv *priv = mbus->priv;
 	int res;
 
-	if (port >= YT921X_PORT_NUM)
+	if (port >= priv->series->max_ports)
 		return -ENODEV;
 
 	mutex_lock(&priv->reg_lock);
@@ -390,6 +390,7 @@ yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
 {
 	struct device *dev = to_device(priv);
 	struct mii_bus *mbus;
+	u32 max_ports;
 	int res;
 
 	mbus = devm_mdiobus_alloc(dev);
@@ -402,7 +403,8 @@ yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
 	mbus->read = yt921x_mbus_int_read;
 	mbus->write = yt921x_mbus_int_write;
 	mbus->parent = dev;
-	mbus->phy_mask = (u32)~GENMASK(YT921X_PORT_NUM - 1, 0);
+	max_ports = priv->series->max_ports;
+	mbus->phy_mask = (u32)~GENMASK(max_ports - 1, 0);
 
 	res = devm_of_mdiobus_register(dev, mbus, mnp);
 	if (res)
-- 
2.25.1

