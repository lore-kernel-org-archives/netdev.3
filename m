Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494693;
	b=Wn/l6LLPNgAtykXaNiDLwBR490e0ME6RBcHX6rSlNWDUklFrZdwQH8g7ALeOsbnRbGBM
	 BZ94upBIXb7M6PdwhflQZ+6vDI8jKLH1mxZL4Zj4vfHVwMdaERj/+IHPSwXnkRbUnsB2s
	 nIc9iQZKjsCL2HNv1EqYptZW5+sbVA60OYO3wqd1C8Zi1xaGZVynWOwpvNnBto8kgEbV0
	 50cKbQFlIb4LqEF2ImuetHCDfaNcdpWj9aTreMg6rBTrsIncwOwYKsWzTzP2X5F1rpPVJ
	 QQSuWx/wZCGHO3zMzisPhwmIWHtskppI7fE3czdU7wT9y2tpUXPwGqmabAgGox05WDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494693;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zOO21uz9MwUO2eNDkgr3BLnA+IJI4wMV/UkAs/11CkE=;
	b=PJnZ/1ujRN5WM0FKKrSCAam+0Igrw3G0yPi7CA4GJCvPtaYEaVmRRb5ZnXsCdizg7yUK
	 A4Hm60aBh8ugZiopyc5Hm+lSG9u+vebNI7p55rTMZOTCNK89CzIdgpazyyIATJSswxHyy
	 gdqbvEwBXy1G509iRaBBCK5XOoP1h6W5JrOBrCzNz4Vr11lFRke1Mhu/yhQVdrcUW11jt
	 wa1gRcHOI1bx0DfNGEpJQTZHX1tgxtPPAYGsfDhi3ooKX1HJoL7gFbcyHq5nXmUBdoejq
	 va+VaOE7UdPUzSebFO2EuF4ghwKzybGWrj1sajTZ+HBNj16ItYzvcVrj2V5ofbFZfkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=motor-comm.com;
	spf=pass smtp.mailfrom=motor-comm.com;
	arc=none smtp.remote-ip=115.124.28.74
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D893E606A332;
	Tue, 20 Oct 2026 11:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D893E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07858402|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00587506-7.46963e-05-0.99405;FP=11562894019367980694|14|2|17|0|-1|-1|-1;HT=maildocker-contentspam033045038069;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jlqQH3w_1792494681;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jlqQH3w_1792494681 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 19:11:22 +0800
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
Subject: [PATCH net-next v16 2/5] net: dsa: motorcomm: use max_ports in series for port bounds checking
Date: Tue, 20 Oct 2026 19:11:12 +0800
Message-Id: <20261020111115.3072180-3-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261020111115.3072180-1-kyle.switch@motor-comm.com>
References: <20261020111115.3072180-1-kyle.switch@motor-comm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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

