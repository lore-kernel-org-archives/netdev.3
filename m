Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAC3339389;
	Tue, 13 Oct 2026 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853895; cv=none; b=V9aE8cQ0Gx4tphhY+E7Um69NrDa+UiOnOW/uvCV6OousV3QDbSS6eEXi6fAYmyiMkjlFvz0/NQDZw0l7GJD3HVRC7wr3NREb3m0VYYskVBBstfnQXrbWXnoIFj1ObuLHcOiUw5CDIGknCPECw3/MGsOSCv10AJ65Tr7L4iu9pI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853895; c=relaxed/simple;
	bh=MGJ0OTCxFGVmbf92zNCab8ppSblh9l9H3JItFIKGrWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qi+ZHozLWWyjB9TYv+RcAL8wUGxOY80XMTx0Fn5cSgNfCG0xuOjhBCNo1o1prtORS2n+C/C/5CATGsHXSmcGjuhHHfU9l+QhSv3FnoD+01dlnmoX8mq3Xb1p1QsL6wmBLLdSASfAI/oDa3L7KsZXplJQIEBdxJYaSf1/3vruHXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0789497|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00587506-7.46963e-05-0.99405;FP=11562893469595389590|14|2|17|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jatt1H5_1791853888;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jatt1H5_1791853888 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 13 Oct 2026 09:11:29 +0800
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
Subject: [PATCH net-next v14 2/5] net: dsa: motorcomm: use max_ports in series for port bounds checking
Date: Tue, 13 Oct 2026 09:11:19 +0800
Message-Id: <20261013011122.1889766-3-kyle.switch@motor-comm.com>
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

Replace the hardcoded YT921X_PORT_NUM macro with the per-series
max_ports field in port validation. This removes family-specific
constants from the common code path and simplifies adding new
switch families with different port counts.

No functional change for existing YT921X devices.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/mdio_bus.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/mdio_bus.c b/drivers/net/dsa/motorcomm/mdio_bus.c
index dd6c52f37bbf..83f0212551ff 100644
--- a/drivers/net/dsa/motorcomm/mdio_bus.c
+++ b/drivers/net/dsa/motorcomm/mdio_bus.c
@@ -113,7 +113,7 @@ static int yt921x_mbus_int_read(struct mii_bus *mbus, int port, int reg)
 	u16 val;
 	int res;
 
-	if (port >= YT921X_PORT_NUM)
+	if (port >= priv->series->max_ports)
 		return U16_MAX;
 
 	mutex_lock(&priv->reg_lock);
@@ -131,7 +131,7 @@ yt921x_mbus_int_write(struct mii_bus *mbus, int port, int reg, u16 data)
 	struct yt921x_priv *priv = mbus->priv;
 	int res;
 
-	if (port >= YT921X_PORT_NUM)
+	if (port >= priv->series->max_ports)
 		return -ENODEV;
 
 	mutex_lock(&priv->reg_lock);
@@ -145,6 +145,7 @@ int yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
 {
 	struct device *dev = yt921x_priv_to_device(priv);
 	struct mii_bus *mbus;
+	u32 max_ports;
 	int res;
 
 	mbus = devm_mdiobus_alloc(dev);
@@ -157,7 +158,8 @@ int yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
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

