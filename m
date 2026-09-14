Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277EA439F98;
	Mon, 14 Sep 2026 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381830; cv=none; b=LdGLXOckI9O+lkk6NlunfkKyFU+3bI/iBEgPQ+WXrVW/hgVAlaE2s2LSYO2lVb0Pe9qFm+ypVhoHbGnDl47KYGGKZdNLcu9W/1OXsPmrchRu3DHb1w9C4WRgDM/PZB3pe36LVOVteDzX5TmjVMD7FRtBjyv8Mu2dgR1n7B6xi1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381830; c=relaxed/simple;
	bh=ckVaGW28ZIIYhmeR1PVp3/ImlxvhY5AwYYvOxljlUjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYxobQyIXmVd/eqsfG6DkVms2ZiLbbuEaHvJIuyqehDmRv5h3hegAlVDxm5yNWdTvsHKjk/iCRNDoP+6HIArNXCXsnFgO4ezXijjjM3xpaeCBlXyapLKVmdkHsE++3fZNtO+lBOxa4lnxXV61wE3oQL/58M1o+igszxqUsmdK1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1265506|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.220266-0.00123502-0.778499;FP=11814690448842735232|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jDMP.ku_1789381817;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jDMP.ku_1789381817 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 18:30:18 +0800
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
Subject: [PATCH net-next v7 4/6] net: dsa: motorcomm: move mib stop from remove() to teardown()
Date: Mon, 14 Sep 2026 18:30:07 +0800
Message-Id: <20260914103009.3007019-5-kyle.switch@motor-comm.com>
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

This change ensures symmetry with the MIB start operation,
which is already invoked in the setup(). Additionally, it
consolidates per-switch operation into the appropriate DSA ops,
improving code organization and maintainability.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 49729db9993b..3f56d60da8ea 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -4233,6 +4233,11 @@ static void yt921x_dsa_teardown(struct dsa_switch *ds)
 #if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
 	yt921x_leds_remove(priv);
 #endif
+	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
+		struct yt921x_port *pp = &priv->ports[i];
+
+		disable_delayed_work_sync(&pp->mib_read);
+	}
 }
 
 static int yt921x_chip_detect(struct yt921x_priv *priv)
@@ -4761,12 +4766,6 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
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

