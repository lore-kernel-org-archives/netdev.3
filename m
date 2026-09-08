Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD1947D450;
	Tue,  8 Sep 2026 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856598; cv=none; b=ZWFzbm65y/jglIUztMxmwHNqFoTd89gSPBV4c7E7xccbf0FqfwdaEuSEJ/ylEx+5KVK8gdtiSeoyB80r0ugn+rMcF2d7Mf1iQST/6+nJ8BosSkUg7d39gXLi0njuQD6LUx72AU05NXVYvwc3sEa5791a2DwKTYZYBxK98c8FJ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856598; c=relaxed/simple;
	bh=6V6IazCTTLRXtDDeC869PPBPA0ym/IWF4PhYzjwPfVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YFpWApBzjr+pESmVqWSaP4FJ1c4fipS4V4nsUww9ONEPxh5l3+aXwXzUkEjUC5ocGF6p9GHc/DiUgm8LVsh6iuHAhQzxLJJoxknjmICM+Y1e0wWbPpHEBi5qQ81NO4n8FMQiqJjQhuntNUBiL+pZG3vSSnmOmJCX2kEs6uF1u8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1226109|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.220266-0.00123502-0.778499;FP=11778661651840679552|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.j8Z17x1_1788856591;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j8Z17x1_1788856591 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Sep 2026 16:36:31 +0800
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
Subject: [PATCH net-next v6 4/6] net: dsa: motorcomm: move mib stop from remove() to teardown()
Date: Tue,  8 Sep 2026 16:36:12 +0800
Message-Id: <20260908083614.2210505-5-kyle.switch@motor-comm.com>
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

This change ensures symmetry with the MIB start operation,
which is already invoked in the setup(). Additionally, it
consolidates per-switch operation into the appropriate DSA ops,
improving code organization and maintainability.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 3a70ff00c126..f960edabde2b 100644
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

