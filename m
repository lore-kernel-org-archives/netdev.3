Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A49E47B432;
	Tue,  8 Sep 2026 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856597; cv=none; b=PbMSMjsR2seUX9eX2CiGRW7LnwYLl6WNabArdnsBku5QJ/gpbRLYolCm7FVAWK0dAGkH9H1va5o2kSdR2hrs5NYXTXPtZy4Un0zEbmHJhtD50R1vfgdkk9N0zkYmmQ/NN5DFFgSRF/vn+T8so05a+qmz22OM5NHiSiKB3Z+LJIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856597; c=relaxed/simple;
	bh=YjxRUskLY0z6TMN8uIAPdwZc0chDsWJhincUyimo9GM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TYLselZQAEXNyRYdArbRyraHnY/DOsCq/J8df7fotrums6QZw47rhUTA7WZYSiQHvAdok13frVF9s6bGJrRJFyGNlqGxIID71gHYvAAgC4eeFCk50IAEn/jw+H6BQ8GXF2TPwHgm/iglZi+PYFiM8J0s/V8GLwKbPxaNuDKsJHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1035972|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0197986-0.000307085-0.979894;FP=11994835652634511012|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.j8Z17vm_1788856590;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j8Z17vm_1788856590 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Sep 2026 16:36:30 +0800
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
Subject: [PATCH net-next v6 3/6] net: dsa: motorcomm: move mib start from probe() to dsa_setup()
Date: Tue,  8 Sep 2026 16:36:11 +0800
Message-Id: <20260908083614.2210505-4-kyle.switch@motor-comm.com>
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

Move MIB polling start from probe() to dsa_setup().so that it can
be enabled based on the actual switch family support.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 191a7aa3733e..3a70ff00c126 100644
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
@@ -4810,13 +4818,6 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
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
 	res = yt92xx_register_switch(ds);
-- 
2.25.1

