Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20E2438493;
	Mon, 14 Sep 2026 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381828; cv=none; b=JI1DMANMWF8N6tFDJDD+o9qRb1qnMmKXeqc2it/O5gizddS2SuDB1Dv4Y3e7QjZz7bC06GPsZq3Bd935TRPhwb2uph2w7bvw4IarIQ5w2Pz+TNT6sJAFsWl4wQQW3GLYfXc5TF9FKvE/vQL7NSR8zHHViAd5aiAQhH+YZHprIwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381828; c=relaxed/simple;
	bh=0rTLb1g6wyCCpNc+mbOO+/sX93Z+xvX5PIU7M0k8o3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p2R1V5k7chwNmYVJD2In+4MdiYbXc05ZOkrPDcQECQYCjSWVeqnE2gk7oXglRvHZRr7+TfAz4EjHCXZUhdRwekeA1GcXmKUk1dvZRd+CH4Hk0xPYujDJygO7K9BE8UYX2oXzIRpwh07w8WmxX1r3hTkiLC0TbzafHavTOpS4vO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1159184|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0201756-0.000204846-0.97962;FP=11706605139178063524|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jDMP.jl_1789381816;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jDMP.jl_1789381816 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 18:30:17 +0800
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
Subject: [PATCH net-next v7 3/6] net: dsa: motorcomm: move mib start from probe() to dsa_setup()
Date: Mon, 14 Sep 2026 18:30:06 +0800
Message-Id: <20260914103009.3007019-4-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260914103009.3007019-1-kyle.switch@motor-comm.com>
References: <20260914103009.3007019-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move MIB polling start from probe() to dsa_setup().so that it can
be enabled based on the actual switch family support.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 4479bb1c3c2b..49729db9993b 100644
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
@@ -4803,13 +4811,6 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
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

