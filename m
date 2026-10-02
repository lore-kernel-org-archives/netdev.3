Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A644F5DF0;
	Fri,  2 Oct 2026 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962648; cv=none; b=qnuwVNmERQjm4+AvwV/dBkuzvVDcJfjh2lKkWKYHm7GYDWBzAguF/BmuKeeR+YeQ/sV6uaXgP5y2gOP3sO13EzkrTGdIwcbgz7nZVyVLvpelsaXmouCLakefcYEWqibjbHEMCZsbxmqp7TmTwhajQpm353A//Rh+0ApHPi9ld5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962648; c=relaxed/simple;
	bh=Or3xnQhquSLUrI4Vmnn9kRa9c2PML7hfcBy5kMF06do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=duxGJ70j0aTs6UPZmbF2CDGqUnj5pnVLaq7Otkf5agADysGB6YLVc3ROeoWEobkNzD3dWtbd65SlBKIAzgULa9f3ORqf9Y3TZkvj97ptErKxeSNoBzbHt9FfdKA2sUxicUheGaD2nTXgZujd+OCMheMRRCshIn10sAkpw/pnObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1521054|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.204836-0.00141997-0.793744;FP=9472783457164373632|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jTk7nTk_1790962636;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jTk7nTk_1790962636 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 03 Oct 2026 01:37:17 +0800
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
Subject: [PATCH net-next v11 5/7] net: dsa: motorcomm: move mib stop from remove() to teardown()
Date: Sat,  3 Oct 2026 01:37:04 +0800
Message-Id: <20261002173706.1225502-6-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261002173706.1225502-1-kyle.switch@motor-comm.com>
References: <20261002173706.1225502-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change ensures symmetry with the MIB start operation,
which is already invoked in the setup(). Additionally, it
consolidates per-switch operation into the appropriate DSA ops,
improving code organization and maintainability.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index c7cfaf244274..9380d74d79ba 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -3924,6 +3924,12 @@ static void yt921x_dsa_teardown(struct dsa_switch *ds)
 
 	yt921x_leds_remove(priv);
 #endif
+
+	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
+		struct yt921x_port *pp = &priv->ports[i];
+
+		disable_delayed_work_sync(&pp->mib_read);
+	}
 }
 
 static int yt921x_chip_detect(struct yt921x_priv *priv)
@@ -4483,12 +4489,6 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
-	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
-		struct yt921x_port *pp = &priv->ports[i];
-
-		disable_delayed_work_sync(&pp->mib_read);
-	}
-
 	dsa_unregister_switch(&priv->ds);
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(priv->acl_blks); i++) {
-- 
2.25.1

