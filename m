Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5837A3BB110;
	Thu, 24 Sep 2026 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242929; cv=none; b=VZ0aAncT9g478ctpvh0ZM4a2M4OC/wjSK8jAJJKbYuZWrqP85grE0Kx7sm8+HkpwwPfb8hMJ0/JVO+9TTOVxW27j1cItdcgber4UUZIu/xTtF3znuSYR97rsh+S7hmHa6C8MZ7tJxJTlzTraTgGiTPB9FJ/ukmqHhz/I9MCdt5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242929; c=relaxed/simple;
	bh=c2S9tst3k3gXMwpqJ3tsbrWYVYFTcd/dDNcjdgIA5UQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lJr/6+esvlxLJJKGQwn1Ce2ETEac099S9cjX/gELvcDHtzpm+mpe++6s4hjpJA8PQ5V2AF+F/vZdrfHsO9o97q7IrWdQ7KYSRgdivy5aJxaGHdLTShnFKP6B8Yr0fxzWWfp3cDd7mHbRLppLdTTUMSGFP/faDh2YUNMtRPgL8P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1377493|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0276114-0.000514482-0.971874;FP=12643665711016332948|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jM7KJeO_1790242914;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jM7KJeO_1790242914 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Sep 2026 17:41:55 +0800
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
Subject: [PATCH net-next v9 3/7] net: dsa: motorcomm: use fixed-width GENMASK_U*() helpers
Date: Thu, 24 Sep 2026 17:41:42 +0800
Message-Id: <20260924094146.4128703-4-kyle.switch@motor-comm.com>
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

Replace the plain GENMASK() uses with the fixed-width GENMASK_U16()
and GENMASK_U32() variants.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index b95f3c355511..6f2606fd7807 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -109,7 +109,7 @@ struct yt921x_info {
 };
 
 #define YT921X_PORT_MASK_INTn(port)	BIT(port)
-#define YT921X_PORT_MASK_INT0_n(n)	GENMASK((n) - 1, 0)
+#define YT921X_PORT_MASK_INT0_n(n)	GENMASK_U16((n) - 1, 0)
 #define YT921X_PORT_MASK_EXT0		BIT(8)
 #define YT921X_PORT_MASK_EXT1		BIT(9)
 
@@ -404,7 +404,7 @@ yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
 	mbus->write = yt921x_mbus_int_write;
 	mbus->parent = dev;
 	max_ports = priv->series->max_ports;
-	mbus->phy_mask = (u32)~GENMASK(max_ports - 1, 0);
+	mbus->phy_mask = ~GENMASK_U32(max_ports - 1, 0);
 
 	res = devm_of_mdiobus_register(dev, mbus, mnp);
 	if (res)
@@ -4370,7 +4370,7 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
-	ctrl = GENMASK(10, 0);
+	ctrl = GENMASK_U32(10, 0);
 	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
 	if (res)
 		return res;
-- 
2.25.1

