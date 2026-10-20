Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494693;
	b=0r1+j++oG62azYiyUSD9sPqfCw0BU/DyCLgpWJVIgQ8WrF2HtJTswJByMfkZ+3WfyO6V
	 pWvfWiTvLDu5z/uxreqUl/mirnGryI+ND444toWdcCYoah7NcvKMe6xMOOwuZrjcCk1ZY
	 2SKI5ul7KeKfmun08xdZxnKThKtwM2ZEAylmz/96HEHzRaHElQnO3NPXbSsMUPSrO3M9L
	 aShxKrk1hmjExb4fydUMc+8a5PyYlzKWL6f9R/KfWSC1q/4Qh4dQjnQzamJisMxQZO6PJ
	 Qwn8wqkPQQ8uT976cBDDsq7GJm7TteGh22k/g4Zc+maobzErUn/dJGDedSQTih6dt7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494693;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P8oDPR9qTgswwNnzz/MrmQ7nQxlBnKmG5VhWIblWtrs=;
	b=1ZAaIekZFiLVJETd0wqnIZcwhK6cgS0ebr0h7BtHYJBvpIyavkU+lQpbgXiKoIz0mC5g
	 4TiuYBc8Psbm4tS4DPlNIviMBSTN51I9FvlVc2NgsD2r2rFixV5u1kQ5EN+fu0MOWBaQA
	 pwijXOMSsXZlYDQZuNa4PstgnkjqCpCCRSjLSKQu00zJCIEXbeIcoTKGzfp2CVeqHrK8w
	 An8eRlOBqXxXXRQpjGpymEOkO/BEE1cu2u8u5MmW+yxd6VcxiXFUNfQYVCAGfqCO6mYHY
	 A6YgqSYOvXyMI8y5peZpat49yaCrJB4AcGu+DF+7+OrD7xd7oWT4dSZ0zWA6Duebluw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=motor-comm.com;
	spf=pass smtp.mailfrom=motor-comm.com;
	arc=none smtp.remote-ip=115.124.28.4
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F24606A337;
	Tue, 20 Oct 2026 11:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79F24606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2934129|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0277549-0.000560708-0.971684;FP=11918766508097589140|14|2|17|0|-1|-1|-1;HT=maildocker-contentspam033037034017;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jlqQH4g_1792494682;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jlqQH4g_1792494682 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 19:11:23 +0800
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
Subject: [PATCH net-next v16 3/5] net: dsa: motorcomm: use fixed-width GENMASK_U*() helpers
Date: Tue, 20 Oct 2026 19:11:13 +0800
Message-Id: <20261020111115.3072180-4-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261020111115.3072180-1-kyle.switch@motor-comm.com>
References: <20261020111115.3072180-1-kyle.switch@motor-comm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some masks assigned to u16 and u32 fields are defined with
GENMASK(),which is an unsigned long constant and wider than
the field type on 64-bit builds. Convert the YT921X_MBUS_CTRL_*
masks used by mdio_bus.c to fixed-width helpers.

This is a type cleanup only, with no functional change. Other
GENMASK() uses in the driver are intentionally left untouched.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c     | 2 +-
 drivers/net/dsa/motorcomm/mdio_bus.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index ccb84f889dd2..bbb598e19a8d 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -2285,7 +2285,7 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
-	ctrl = GENMASK(10, 0);
+	ctrl = GENMASK_U32(10, 0);
 	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
 	if (res)
 		return res;
diff --git a/drivers/net/dsa/motorcomm/mdio_bus.c b/drivers/net/dsa/motorcomm/mdio_bus.c
index 83f0212551ff..3aa1111efaa4 100644
--- a/drivers/net/dsa/motorcomm/mdio_bus.c
+++ b/drivers/net/dsa/motorcomm/mdio_bus.c
@@ -159,7 +159,7 @@ int yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
 	mbus->write = yt921x_mbus_int_write;
 	mbus->parent = dev;
 	max_ports = priv->series->max_ports;
-	mbus->phy_mask = (u32)~GENMASK(max_ports - 1, 0);
+	mbus->phy_mask = ~GENMASK_U32(max_ports - 1, 0);
 
 	res = devm_of_mdiobus_register(dev, mbus, mnp);
 	if (res)
-- 
2.25.1

