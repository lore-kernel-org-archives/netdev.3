Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848499;
	b=iIwPe8E20LaaAejyrlWJyMk9BE4GLf703f+WkRnNtcOpDGLv7nPqOEmrnDIO6NMqrBBA
	 Bzxelatm6oj2WjWs5jfKKtjEhtNku6P/6RM2VQ8X/T1fiuPh3EjShkxmgDcnkJGYz2rw2
	 zVifjyWLxpAuXQYHVunQSrTuMcO9SMfR8u6uy1Tz1JDdp147PazgpkXDF/96LUerV245j
	 X8fTMRfkoSe3Rp0TXcal2yo3AS7N57S5Rb0IU50Wpwl/HDAdvpgUHyIPMWzcKZ0qDwj+g
	 61bPr16bEevwdSBwSxaTWELdnirqT2LI5Z2UIUp50qxj31bJWBzY2Lp7Juy9SLD5gug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848499;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zOO21uz9MwUO2eNDkgr3BLnA+IJI4wMV/UkAs/11CkE=;
	b=2PC0uORXBjf/nmTif4J2LHHIrJ+TLqoPXyJjxPfbuxX35dvr/Fp/YyQwtUn+jvqMQYOP
	 1xHnr4AD64r9NxXjLQEe4S4NaymheZ9t8xwDybfEET1uoKQKGKDr2GVMkS29Wc0jzhdLu
	 WhnDcA9OUzJnsGv+Bb9RncWyrgw+BzjF76keO6eQhiyTvtGi9t4PMT1OR56KoUYFQ37aC
	 dHIG18A8ewlc27bO+u3IsT/rOK/CzFukncnEo56iWIRnBtF+sP5ueHcXVhFV5Sy6LykZF
	 MydqB1I/PWiDoLP2ymFaWXOF3LUAj0NcEK6KpiWaGO766ZWscqT3r7o5B8fmFJSKpOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=motor-comm.com;
	spf=pass smtp.mailfrom=motor-comm.com;
	arc=none smtp.remote-ip=115.124.28.172
Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C1A606A32E;
	Thu,  5 Nov 2026 03:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2C1A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07852332|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00587506-7.46963e-05-0.99405;FP=11562893469595389074|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033071099199;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jx7-i0o_1793848491;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jx7-i0o_1793848491 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 11:14:51 +0800
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
Subject: [PATCH net-next v17 2/5] net: dsa: motorcomm: use max_ports in series for port bounds checking
Date: Thu,  5 Nov 2026 11:14:39 +0800
Message-Id: <20261105031442.4164960-3-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261105031442.4164960-1-kyle.switch@motor-comm.com>
References: <20261105031442.4164960-1-kyle.switch@motor-comm.com>
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

