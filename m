Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA383E3C5A;
	Thu, 24 Sep 2026 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242929; cv=none; b=GtAxEUrnqm6Ja0L3EhX+uJtLfP9GME8msQcBdSJxvx9JyvQd+bbKOv4b5DjKyvQyW2D6hPNtNL+rVsVP6Ys5zBKyjESemPAC9Q65HtGaxMtnZ4ik0v5h1EDPCYy1uf3feXDzCIw3P/WHK9hoDe1QhFYoo7rNmG1sTT1Xj2XF/M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242929; c=relaxed/simple;
	bh=CNx5AsOeLO6DFVyrio28yJS8BGeoXp/T+wVkvZZILKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iawiv16xHMv6uqCBw1Yuit26g9mYyW6MjoniS1YKi29WgpCPlgxNPmaibYLLab9JiHNkTtqhhNdQ/o0DD0HS05ZPmHryx0Oo39cRtuP+v3svMv6o3CTy+uy7KF+gLP/RPtpe8qvLR6dZZXkr31KDPbonBHnUaKjcbpL0qHGiQsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08651552|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00731352-9.94324e-05-0.992587;FP=11779083846059454102|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032062159;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jM7KJd2_1790242913;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jM7KJd2_1790242913 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Sep 2026 17:41:54 +0800
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
Subject: [PATCH net-next v9 2/7] net: dsa: motorcomm: use max_ports in series for port bounds checking
Date: Thu, 24 Sep 2026 17:41:41 +0800
Message-Id: <20260924094146.4128703-3-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260924094146.4128703-1-kyle.switch@motor-comm.com>
References: <20260924094146.4128703-1-kyle.switch@motor-comm.com>
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
index d4a565994940..b95f3c355511 100644
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

