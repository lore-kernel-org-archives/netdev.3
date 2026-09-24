Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F412B3E0758;
	Thu, 24 Sep 2026 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242928; cv=none; b=Ita7/pBbR1i/QiHW4B5WW7mq99Uwp+VG7eyvIH3pjo8WgLASoiDMdNmV2pxonCFapnsj+mnUnPiOIqvticXu064YjG0YlQ4GB/KLtJU0d+JGC1+6Y/lWPUyIA9SebSsTiPgL+f8sQ72k9ZlprZl27EPJ5l8FNPoUlmjaapf2rOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242928; c=relaxed/simple;
	bh=/HQuaBr4l27eSp+rNSKTVtuPmHpCdlun0JGi5IhlXxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YiaXJRga9itS85f3GrzFazNMXZI2H1oLnnoeNMBd0jKUDI7gMlafu3/0ZPtMT1FtLmrAn1/Xl6l5otfgnfZb8ByXH0tOucbVX38jfJvyQHNjG6MeoNkkoApF9ICRjkGvnT55N+DTkwOq1v/52WJypb5YFhPlfTC1l/8hBfV27Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1400594|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.215432-0.00133947-0.783229;FP=9472783457164373632|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jM7KJgl_1790242916;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jM7KJgl_1790242916 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Sep 2026 17:41:56 +0800
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
Subject: [PATCH net-next v9 5/7] net: dsa: motorcomm: move mib stop from remove() to teardown()
Date: Thu, 24 Sep 2026 17:41:44 +0800
Message-Id: <20260924094146.4128703-6-kyle.switch@motor-comm.com>
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

This change ensures symmetry with the MIB start operation,
which is already invoked in the setup(). Additionally, it
consolidates per-switch operation into the appropriate DSA ops,
improving code organization and maintainability.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index d9d73bb7cb23..46f7b94469ea 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -4233,6 +4233,11 @@ static void yt921x_dsa_teardown(struct dsa_switch *ds)
 
 	yt921x_leds_remove(priv);
 #endif
+	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
+		struct yt921x_port *pp = &priv->ports[i];
+
+		disable_delayed_work_sync(&pp->mib_read);
+	}
 }
 
 static int yt921x_chip_detect(struct yt921x_priv *priv)
@@ -4768,12 +4773,6 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
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

