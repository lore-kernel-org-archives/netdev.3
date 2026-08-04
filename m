Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A573546C0
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843339; cv=none; b=mcRzPKtVMrcW/Lq6t2DebXz0yuZRr8V/6bL9ERvJc/qe3qkuB4x1Im8ouSOYBOQFr+e1U63A5vD3kvXzlHnP3JgmrumUNRKzgwpPYqJZA5HtN35z7LWOt13flLIh0OV6sfzN+5m1QOgjwl0nEMafWDbupb8Uyg9ksizOZgWmibE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843339; c=relaxed/simple;
	bh=eG0RFUZjcwUsngo8jMc0RSRwUDp+/m+lU3rnsR26qXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Io1cGh/0xf8Ak4vWDZXDPAPJ667WWmy++3JfCkD/ANlYu+4yqnQdcU0o9axVMtpspfrNqKxaBfKjGFrXG5RUdx5IcQeOEp9pGBgeCNPAdrtrac+M3+jeg1nQn0pwGGohMFafQtiVsTm7Uyfg2FT5+xLDM52KfAONKqwHkpA2/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKs1Woo5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKs1Woo5"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cacf197759so65994445ad.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 04:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785843337; x=1786448137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uNVTFfdfEZG90+jAE3BzNE+piQiVWzc95vgbhLXgILA=;
        b=BKs1Woo5URfJ5kDfQ+z9YbJslopDx79/r+BcbYYD/dQPqz95ZTZL73ys300wr6nBh/
         Ma8Zlz4u4C5fIdt2qkiOtDMngAP+e0szg+KNxoQ+NwEVn3JwhixRIzxcV4yJDlHpvlPQ
         aPnh5/RvvF8U9snS8IRvGm6SCZyqYlRttgb0x9vEWlYZBaenu5+ySTEfDyoiAn3HF6GL
         WaHy7eRx2zdmp787lO+18bbuEZwJseJO6ZuK9FVwO9H+6xh5z1EmjCxHzzXwkobjfuUx
         b8VXeVMeVc/+3rA6CX7Rq+mhyzTRzqurD3KEcXbdnrYdC4uvwm77V8/Ld2lcLYG7CDdR
         zHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785843337; x=1786448137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uNVTFfdfEZG90+jAE3BzNE+piQiVWzc95vgbhLXgILA=;
        b=Hxa/9OvUimslSneZNsYIrqcmQw06cfV8SRMql1CbYVFH7aWAtgomYRLm3kmL0wl4+r
         XhHxSGv/1APqOvIoMPWqAaGhJjI2ykoZkxqZHYvgcTAnkXbqL9Sv7LFbJzq5K8LpD2m3
         UmfJy3czH3LMExiAYF3nITi5goJFPXgYwsup2KBKRaws4oaobJr65F41bEIPv6Tki/h5
         ttgW/JA2uh7xU/ucUMGEC69G5TQpl0aq+vy/U+xCV8J85UU/athJLvxlIt59FKsX8mxn
         gjIV+baPEB2+IjmzDXjYBqI6YahFLuttSCO5/CWFXOhzWjpvpz8Kp64qAlevms2BNlwZ
         I+Ow==
X-Gm-Message-State: AOJu0YzJQwBvgWfJiewjsQ0e66VkX6DC5xecJg7D2jQLLMjBNLspX0u1
	t1sMmx+1C8ak7QInO0R5HrNRQ1sSdl3TpaPsQik3BGwYfeemlmiA/g1TsUjLo6VA
X-Gm-Gg: AR+sD12adnkbF9b7vwdwsXCVIaPkvu8tjoN0yPN9T5lPv3c9B+ZGeEqUV43jTh6wmAF
	6d+/1KGbfzbD7k/SP4OP0kpyEZj6Cm2KA6jrQNeM3NWxvpQYG4qx0qaUj9trMSCNs0ebLlqQ7Jl
	17EUbt4ZY0OYY0/5pP3Tl9QoLbXwZwqq2WrappZ7ivVDkXQ5ZiecbfdBkwn7pcDVnQ1hmqQ9hnr
	L3JCczcPQf3uUdccu0lWjHPSSLOTd0u6e41oiT4FLmYdPkRkOLAAhwTJpW8/6szGPz/Y4/yzJri
	LwmbSs/jBJWc9jzUw3vNU+GDStZRiFXv5Jj89aWvareGHy6GeFknNt3W39YjMtqvv27ALqqCeaQ
	uRHfLivpgMYC5nlaE/v/vT7TKEf7L7NCONuTZKpfmds2m8hzJQGzXbzvsrhyuiSGF8jE3lrVmxV
	TbYEmPPfHVddhX13PrxIdfNwPn0DmIMFv3D4vmTS7NKgwKByKO0xTJMZWP1e/oJ6cc1wwJ
X-Received: by 2002:a05:6a21:3a47:b0:3c0:278c:6a31 with SMTP id adf61e73a8af0-3c92a51df73mr13770829637.11.1785843337304;
        Tue, 04 Aug 2026 04:35:37 -0700 (PDT)
Received: from DESKTOP-TIT0J8O.dm.ae ([49.47.198.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca63ce12sm3569493c88.5.2026.08.04.04.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 04:35:36 -0700 (PDT)
From: Ahmed Naseef <naseefkm@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ahmed Naseef <naseefkm@gmail.com>
Subject: [PATCH net] net: phy: mediatek: fix TX blink masks using the RX bits
Date: Tue,  4 Aug 2026 15:35:11 +0400
Message-Id: <20260804113511.3371248-1-naseefkm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MTK_GPHY_LED_TX_BLINK_SET and MTK_2P5GPHY_LED_TX_BLINK_SET are built
from the RX blink bits instead of the TX ones, so both TX masks are
identical to their RX counterparts. The TX bits they should be using,
MTK_PHY_LED_BLINK_{10,100,1000,2500}TX, are otherwise only referenced
by the per-speed branch of mtk_phy_led_hw_ctrl_set().

A TX trigger selected without a link trigger therefore programs the RX
blink bits, and the LED blinks on received traffic. The masks are also
used to decode the blink register in mtk_phy_led_hw_ctrl_get(), which
as a result cannot tell the two triggers apart: an RX-only
configuration reads back as RX and TX, and a TX-only configuration
reads back as neither.

Fixes: 7f9c320c98db ("net: phy: mediatek: Move LED helper functions into mtk phy lib")
Cc: stable@vger.kernel.org
Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>
---
 drivers/net/phy/mediatek/mtk.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk.h b/drivers/net/phy/mediatek/mtk.h
index 320f76ffa81f..79e09727b81b 100644
--- a/drivers/net/phy/mediatek/mtk.h
+++ b/drivers/net/phy/mediatek/mtk.h
@@ -53,15 +53,15 @@
 #define MTK_GPHY_LED_RX_BLINK_SET		(MTK_PHY_LED_BLINK_1000RX | \
 						 MTK_PHY_LED_BLINK_100RX | \
 						 MTK_PHY_LED_BLINK_10RX)
-#define MTK_GPHY_LED_TX_BLINK_SET		(MTK_PHY_LED_BLINK_1000RX | \
-						 MTK_PHY_LED_BLINK_100RX | \
-						 MTK_PHY_LED_BLINK_10RX)
+#define MTK_GPHY_LED_TX_BLINK_SET		(MTK_PHY_LED_BLINK_1000TX | \
+						 MTK_PHY_LED_BLINK_100TX | \
+						 MTK_PHY_LED_BLINK_10TX)
 
 #define MTK_2P5GPHY_LED_ON_SET			(MTK_PHY_LED_ON_LINK2500 | \
 						 MTK_GPHY_LED_ON_SET)
 #define MTK_2P5GPHY_LED_RX_BLINK_SET		(MTK_PHY_LED_BLINK_2500RX | \
 						 MTK_GPHY_LED_RX_BLINK_SET)
-#define MTK_2P5GPHY_LED_TX_BLINK_SET		(MTK_PHY_LED_BLINK_2500RX | \
+#define MTK_2P5GPHY_LED_TX_BLINK_SET		(MTK_PHY_LED_BLINK_2500TX | \
 						 MTK_GPHY_LED_TX_BLINK_SET)
 
 #define MTK_PHY_LED_STATE_FORCE_ON	0

base-commit: 1a35da325cac4d5bcad76a2aa943408a6f1d9000
-- 
2.34.1

