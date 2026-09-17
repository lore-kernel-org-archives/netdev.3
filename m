Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813273D9522;
	Thu, 17 Sep 2026 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633377; cv=none; b=uYRnF79cnbP0i6LsLTB8NrmYsJhKA0JeUlEjVaWfl8y57QjYzRD0yv2IRvXrVffEGgpg5NWiSriRNF85EZi9zfjrtljrKZadS1cCtMfqjAo4XsvhSi1popGKeOizXP0+TSeuqYN4g7tR+EQZtWNvWg9OVvCHU4YRjgwjaQxAJa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633377; c=relaxed/simple;
	bh=WeNUryqENxUdN0/GJ8JSQ9740c7W4KbTzDQXGBuy2rM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cU1mUrU/UNujOqu56+AnxxNdNzKWGfoKpFfL4YhWnYhTmA7kdF8K2slo8S4GVdc7BmpWFQ1wf8JWzwyOZohSUnN8AsdiKWjXo/AHRRjg6g7nRq35G/KASKwC8BPvp7zelkeJF79x8nPd5qr/oylD6YgorvAafa0fjx+IP6Yt9uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09768533|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0201756-0.000204846-0.97962;FP=12282503508463752868|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jFhn6-._1789633364;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jFhn6-._1789633364 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 16:22:45 +0800
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
Subject: [PATCH net-next v8 3/6] net: dsa: motorcomm: move mib start from probe() to dsa_setup()
Date: Thu, 17 Sep 2026 16:22:33 +0800
Message-Id: <20260917082236.3427168-4-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260917082236.3427168-1-kyle.switch@motor-comm.com>
References: <20260917082236.3427168-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the delayed work initialization of the per-port MIB polling
from yt921x_mdio_probe() into the DSA .setup() callback, changing
its lifetime from once per probe() to once per DSA .setup().

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 2156230a78aa..167b20835771 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -4553,6 +4553,14 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 	struct device_node *child;
 	int res;
 
+	/* mib polling init */
+	for (size_t i = 0; i < ARRAY_SIZE(priv->ports); i++) {
+		struct yt921x_port *pp = &priv->ports[i];
+
+		pp->index = i;
+		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
+	}
+
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_chip_reset(priv);
 	mutex_unlock(&priv->reg_lock);
@@ -4805,13 +4813,6 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 	priv->reg_ops = &yt921x_reg_ops_mdio;
 	priv->reg_ctx = mdio;
 
-	for (size_t i = 0; i < ARRAY_SIZE(priv->ports); i++) {
-		struct yt921x_port *pp = &priv->ports[i];
-
-		pp->index = i;
-		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
-	}
-
 	ds = &priv->ds;
 	ds->dev = dev;
 	ds->priv = priv;
-- 
2.25.1

