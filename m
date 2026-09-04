Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A98445AF6;
	Fri,  4 Sep 2026 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515684; cv=none; b=mJ2vfzzb/dx50KwlBB7trfxWIHFomOjxdznDgTcAw4KEMrsTF1zVibzPLDzTfu9Ci5vnw0OpSO348owLhg9ZFa9ptXZdBoAcTXKeSzKo8IyQ48GgsA1Tckn9i9+pev4wgMCHTm14vlRFmJdEIQ7JwEqijhNg0AliXK0HGd8ObFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515684; c=relaxed/simple;
	bh=vEeYSsNcN2Lvw37nitJT4BkThkCD4BFWr/LGOpbLdK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B2P82W4a9oxbfTHIAQIDT7PsMB+g+bBANHd6sMAgz41dVls13uXMEvYfscU+W1NRqw7Au6R2fRqvv+MKTa14AhFJWK5Xo67M6xWigKRH4PavoqZvcsCHM2ySgsn3zYsPlibH0Rkm9thd7GG+5jtzlpEL4UgLeCmSy3PS6QGb3k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1124942|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0199316-0.000303438-0.979765;FP=2483233239762241188|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.j5Qgq54_1788515676;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j5Qgq54_1788515676 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 04 Sep 2026 17:54:36 +0800
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
Subject: [PATCH net-next v5 3/6] net: dsa: motorcomm: relocate MIB polling initialization to dsa_setup()
Date: Fri,  4 Sep 2026 17:54:13 +0800
Message-Id: <20260904095416.1692962-3-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move MIB polling start from probe() to dsa_setup() so that it can
be conditionally enabled based on the actual switch family support,
avoiding attempts to enable it on unsupported switch families.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 7ae48e6636a0..f74a44048fb1 100644
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

