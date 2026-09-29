Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA10254705C;
	Tue, 29 Sep 2026 02:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650477; cv=none; b=XCZnLHGE1YHeEQ7iGOVvMxC0N6o9B93Z3S7DMwHsfcHVXY6nF4TwiDY7vphn40ZLThKWF2SAqR3sasQJowdZ5fs6z9ucHR3urDTskzYEL5vMxIU9pAKJmuyNHD/FFzCHG8FwbCvtQFs/03T8tDK9o8KBQCNAEoLvPgUhxFYgLJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650477; c=relaxed/simple;
	bh=DOLO0uX9WGdaY1FjjJdFkrlrWODLZIZRx/ZNH9pNVAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0yP46/djqAHD2ebyN10co38pcuM74KYUUWp8LhR63m5KEHV4AgHPKwiUfHJC7LxZRXqMBtTqprfXj/DjReHB13CyULwDIHdJbY/ZPPFJHpJssJtyD1EaRRh/PWByfsl9e0S6P8GWOLu/iq0EWHv9aKdpfBZwoNqPROhWOQq/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09636042|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0239052-0.000216778-0.975878;FP=12282643696196294308|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jQghbu4_1790650469;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jQghbu4_1790650469 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 10:54:29 +0800
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
Subject: [PATCH net-next v10 4/7] net: dsa: motorcomm: move mib start from probe() to dsa_setup()
Date: Tue, 29 Sep 2026 10:54:11 +0800
Message-Id: <20260929025414.313641-6-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260929025414.313641-1-kyle.switch@motor-comm.com>
References: <20260929025414.313641-1-kyle.switch@motor-comm.com>
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
index 13fc286d4194..c7cfaf244274 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -4251,6 +4251,14 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 	int port;
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
@@ -4525,13 +4533,6 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
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

