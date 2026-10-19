Received: from out28-218.mail.aliyun.com (out28-218.mail.aliyun.com [115.124.28.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FD449B5B4;
	Mon, 19 Oct 2026 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407962; cv=none; b=FchkTLjmGlklM8HEF4KboKnOj+x0XNFjd9JAzgjUQqFlETNE9s9MU8JhGhFIIEGEB8T4K27nxWyyHfjxUfCRWs9W7nwP3vuVgMNOPHd7igMfpGXeEHLx5Q4SllrtywRkZlptedufWGLXy+y96A1DEz0zN3LgnS8Vuvle66qMALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407962; c=relaxed/simple;
	bh=IMFnUMwQo6bCEi7w5DI0YTVJh20CrxwJD+WGRXHX+Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ijLI1NiZRnIJDVDaXJ/eyqzYBV2xVrEnNXd3d1HUoexwJ8TKy/DHgPOpJ2El9ojR6eu4HoYdZjTPd5QpRiMCe3cGeNNLmCz/Rwrvaq/weQU3mamFmGs0FnMomAwhgatsMBjO25h9p7iN3hZjbrOyi+22shve5KfZ+wNR2McZ2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3026178|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0277549-0.000560708-0.971684;FP=12495209668214968212|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jkUvDOZ_1792407951;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jkUvDOZ_1792407951 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 19 Oct 2026 19:05:51 +0800
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
Subject: [PATCH net-next v15 3/5] net: dsa: motorcomm: use fixed-width GENMASK_U*() helpers
Date: Mon, 19 Oct 2026 19:05:41 +0800
Message-Id: <20261019110543.2999419-4-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261019110543.2999419-1-kyle.switch@motor-comm.com>
References: <20261019110543.2999419-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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

