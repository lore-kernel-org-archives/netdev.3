Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F724FC344
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738357; cv=none; b=WSWdzwwx1cwrkgxON/85SuQX6ZtWOxbW61vBnkyT6N66eiQQXIov1v0VgqO5KP+J2Tus+2H4TJCpOrIb2D0ENynG76dclCcub7+WqeVIHkFgDlDVwftyGJYUW2pHUK9UIGfvYFjrKxowNjbisio90lyw9fcP2dIiOwDAbSPNfo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738357; c=relaxed/simple;
	bh=1dBpP7l681zRShb+b4zwZU2Rzf69nl3mp5ML8CPf9qI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9xiSRrebjWKUMATIIk0kEYPX13RX5HX+1K/Tys/DHgMVHOt02J60F9xqgJyG6gMri5EkIVcytxqZvJx+aqJOOXE6FqQRe18HG3SmusN9B8uEZIKDRTBFjutWQpAABCb6ukjNMyZv7NVTbp2zeQEprCHfnheBAXmzM7p7gH4x7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INixMQl2; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INixMQl2"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469d20963so514118b3a.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 06:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789738355; x=1790343155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2V5XTy73tYiUK954Gg8bkkUQBuh9HGa8ceTDdFzo0Bo=;
        b=INixMQl2rdRF85x4vys5MotCViefXiFywMQTx/NVYMVZ0h1RZ5jln4xjaQaBdrhEjO
         xLabpu2r7MODtTdTk49tm/qf7YK465CVGrXJbIGHlMtKWTS6Ug2MFEWiBP4vBzd0jW1c
         n6qNIzF/0sWGVor/zkU8ltuO9XCXywSoKkn2KFSA6Yypbr9KTsw30YrLtmgDTbxrerB1
         E2cJD2VbymsAiVKINMP2DLNKm5gLAmSako6S6KSYt4p8c1nJEiqf4Eepvcizh40kaPx1
         EXM1f1ji6I7Nog8oU7Du3D00E5cDtoQhC/41hFJSr5ZnPOD/oSr4Kslme63KKe6Cu8Ri
         zEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789738355; x=1790343155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2V5XTy73tYiUK954Gg8bkkUQBuh9HGa8ceTDdFzo0Bo=;
        b=CkwJGiHPwPyQXTYdAOEGVrCy8Yeb6plLXXW6Bu6lgc9UUc1dE6ezzWKQ6bfa65iiqy
         u6R5c70T3V3AImyz+ScXK/JHHGZwuOdE0n2xMRwAAPnOwW4lddZ17eMK8uHQiqQTf02a
         G2ARXdAoiUFg+2ExaGrkWRUTOEwF4ffyI0xesiRzsf/TZUcNvzhhM3LMKb82aLna814a
         Zz7VBwW5PuS7QMCwJe85DiciLkyTzDZNxp2P0K8jXVPlZ5R+0WBFIYYZTNkspeGsNyew
         bRiQcYi+55oHJncfglGKVAMDTKgmrkufKmoPEGnQK5DtsQrQR/J+PD2ZT4nKm9yqP+EW
         93Hg==
X-Forwarded-Encrypted: i=1; AKwUvBx5y1lJCpTu1uHSwo3iwA7cAXLZ03e1AhGLHzqOKj2r2UVqePRGNVPCqA/VF7zQ2ojX1ueMPeU=@vger.kernel.org
X-Gm-Message-State: AFuF++nWXf8xALbbRyCBATV53SfJkU33H+d/1KKG+F3Q5fYhNswW4dUH
	+BMeB/mDohGw6unnMSREWxMyF2GJzFhXXCW2gTCncDTZ9yJfyZab2NH9
X-Gm-Gg: AYBFou0yJirCrewEkix1O7ZzJuGxLJzslzJbh9fR1SlgO+xZfZDh+S+zGm6oFL3BGoG
	MUPel3WVVMdl2PjzTJU2G+tT+R85rjC3B4egnO/X47b/ZMzdvAusnHpBdS9nf5QoFV58LkOJgQI
	EMD+0yvU2wIGiXhnxjpnjshVsFDvMMKJ5ldfgh3Q6FijeFLH0dvAQGgVhyswpeEnr8jMVnsklsi
	2KhwluYOQjFJzfYYeuL9ZS7mJRnHAm8hbgtRbvgOeRx3ZHRhZHn+j2uq/F/5MgMfv67FmhuobbZ
	USbdcARjZjQL0Cf8QSU0y8Uzh5yyawk8ntAUCxuXvIdiWCvqC7xKbV6UcqmboZHZt4RK5gqOEq/
	tlskqmE8fHqquVpmu1ioGSv6ISqtb3/WMwzYVCiJfuEptIc2NbEtJ5Ia7Lrh/tqWRvJg5H7JJmd
	nlKqAQABUudzUnVRLE6Ba6mFzwBXQKgz+920DAQoXtLsj93y7+tRXuklh79OkMjNEaYKmUQO+fb
	A==
X-Received: by 2002:a05:6a00:2e26:b0:847:99bb:b6d0 with SMTP id d2e1a72fcca58-874dcbf2693mr4878215b3a.15.1789738355341;
        Fri, 18 Sep 2026 06:32:35 -0700 (PDT)
Received: from G15-5520 ([103.206.144.105])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-875dd8ddd57sm817797b3a.48.2026.09.18.06.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:32:34 -0700 (PDT)
From: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:AMD XGBE DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: [PATCH] amd-xgbe: use str_yes_no() helper in xgbe_get_all_hw_features()
Date: Fri, 18 Sep 2026 13:32:18 +0000
Message-ID: <20260918133218.39778-1-lalitshankarch@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prefer the str_yes_no() helper function over ternary operators
with hardcoded strings.

No functional change.

Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 39 ++++++++++++------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 2d6d00e3689b..fa7909cff75b 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -14,6 +14,7 @@
 #include <linux/if_ether.h>
 #include <linux/net_tstamp.h>
 #include <linux/phy.h>
+#include <linux/string_choices.h>
 #include <net/vxlan.h>
 
 #include "xgbe.h"
@@ -807,27 +808,27 @@ void xgbe_get_all_hw_features(struct xgbe_prv_data *pdata)
 
 		/* Hardware feature register 0 */
 		dev_dbg(pdata->dev, "  1GbE support              : %s\n",
-			hw_feat->gmii ? "yes" : "no");
+			str_yes_no(hw_feat->gmii));
 		dev_dbg(pdata->dev, "  VLAN hash filter          : %s\n",
-			hw_feat->vlhash ? "yes" : "no");
+			str_yes_no(hw_feat->vlhash));
 		dev_dbg(pdata->dev, "  MDIO interface            : %s\n",
-			hw_feat->sma ? "yes" : "no");
+			str_yes_no(hw_feat->sma));
 		dev_dbg(pdata->dev, "  Wake-up packet support    : %s\n",
-			hw_feat->rwk ? "yes" : "no");
+			str_yes_no(hw_feat->rwk));
 		dev_dbg(pdata->dev, "  Magic packet support      : %s\n",
-			hw_feat->mgk ? "yes" : "no");
+			str_yes_no(hw_feat->mgk));
 		dev_dbg(pdata->dev, "  Management counters       : %s\n",
-			hw_feat->mmc ? "yes" : "no");
+			str_yes_no(hw_feat->mmc));
 		dev_dbg(pdata->dev, "  ARP offload               : %s\n",
-			hw_feat->aoe ? "yes" : "no");
+			str_yes_no(hw_feat->aoe));
 		dev_dbg(pdata->dev, "  IEEE 1588-2008 Timestamp  : %s\n",
-			hw_feat->ts ? "yes" : "no");
+			str_yes_no(hw_feat->ts));
 		dev_dbg(pdata->dev, "  Energy Efficient Ethernet : %s\n",
-			hw_feat->eee ? "yes" : "no");
+			str_yes_no(hw_feat->eee));
 		dev_dbg(pdata->dev, "  TX checksum offload       : %s\n",
-			hw_feat->tx_coe ? "yes" : "no");
+			str_yes_no(hw_feat->tx_coe));
 		dev_dbg(pdata->dev, "  RX checksum offload       : %s\n",
-			hw_feat->rx_coe ? "yes" : "no");
+			str_yes_no(hw_feat->rx_coe));
 		dev_dbg(pdata->dev, "  Additional MAC addresses  : %u\n",
 			hw_feat->addn_mac);
 		dev_dbg(pdata->dev, "  Timestamp source          : %s\n",
@@ -835,9 +836,9 @@ void xgbe_get_all_hw_features(struct xgbe_prv_data *pdata)
 			(hw_feat->ts_src == 2) ? "external" :
 			(hw_feat->ts_src == 3) ? "internal/external" : "n/a");
 		dev_dbg(pdata->dev, "  SA/VLAN insertion         : %s\n",
-			hw_feat->sa_vlan_ins ? "yes" : "no");
+			str_yes_no(hw_feat->sa_vlan_ins));
 		dev_dbg(pdata->dev, "  VXLAN/NVGRE support       : %s\n",
-			hw_feat->vxn ? "yes" : "no");
+			str_yes_no(hw_feat->vxn));
 
 		/* Hardware feature register 1 */
 		dev_dbg(pdata->dev, "  RX fifo size              : %u\n",
@@ -845,19 +846,19 @@ void xgbe_get_all_hw_features(struct xgbe_prv_data *pdata)
 		dev_dbg(pdata->dev, "  TX fifo size              : %u\n",
 			hw_feat->tx_fifo_size);
 		dev_dbg(pdata->dev, "  IEEE 1588 high word       : %s\n",
-			hw_feat->adv_ts_hi ? "yes" : "no");
+			str_yes_no(hw_feat->adv_ts_hi));
 		dev_dbg(pdata->dev, "  DMA width                 : %u\n",
 			hw_feat->dma_width);
 		dev_dbg(pdata->dev, "  Data Center Bridging      : %s\n",
-			hw_feat->dcb ? "yes" : "no");
+			str_yes_no(hw_feat->dcb));
 		dev_dbg(pdata->dev, "  Split header              : %s\n",
-			hw_feat->sph ? "yes" : "no");
+			str_yes_no(hw_feat->sph));
 		dev_dbg(pdata->dev, "  TCP Segmentation Offload  : %s\n",
-			hw_feat->tso ? "yes" : "no");
+			str_yes_no(hw_feat->tso));
 		dev_dbg(pdata->dev, "  Debug memory interface    : %s\n",
-			hw_feat->dma_debug ? "yes" : "no");
+			str_yes_no(hw_feat->dma_debug));
 		dev_dbg(pdata->dev, "  Receive Side Scaling      : %s\n",
-			hw_feat->rss ? "yes" : "no");
+			str_yes_no(hw_feat->rss));
 		dev_dbg(pdata->dev, "  Traffic Class count       : %u\n",
 			hw_feat->tc_cnt);
 		dev_dbg(pdata->dev, "  Hash table size           : %u\n",
-- 
2.53.0

