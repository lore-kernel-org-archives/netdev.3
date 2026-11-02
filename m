Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656070;
	b=GhoaEhotsUNShIz0jSkjpcpLDyz2d5lCyma+z6VXLHSU/b4lZBGo0llXVwDRO9a3pkHk
	 rzDamk0HBFWAoDuDLvJBY0cii05c0hCa5xF3wNPN+HWVzCIYdVjzfHuw9MyMksbNn6p4X
	 /PWEd86+1sg8Gj5dd4Wl05bAyt9esqyp6adz65aZHxeU5H+OUPsA0rPkBN3crkotOt+/O
	 qgJNcyhfyEcnuhURMmuact5c0CIR45V0ReLVudPcJxoUy2T14/4wvrD38b/5B+HxvoPv5
	 gCnhh8MUOLk5VhaiXpkpxQ4XdIegTuvdES2BEQ35itgy9QdvzRQIsuhhq3Q0DF7KV4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cd5wWNullUB7y6awi0QqpF0THbdju3RxqFPzvSH65a0=;
	b=BkH5+MacAD+U/fEz9XbT+zQvJkuXaBCvbVajZ7d/oBZp8eWdTI80z1l8n3oJGl7dJrW7
	 cwKilctB7ZHgrapBHPajDzIq0tlWT62TGvhTZn50gAopTPVNV4yZjoa/qvKMmJaHJqi7d
	 GPtqb3t62Q/mrxdQVBJbWGdGZvK87xS8RuUA736EQZsquS2DawlmQx42XfIAcWRqQ9Wb8
	 Gf/uM7EkIVZfAtx6w+x8ajt7AWJntHNGcy4i1PmFtXjbLI7j+4PMurXraDhuU39zXEAY+
	 ORaJuuHA6mfBR6iHltZ2uVn/XM7oyUOFAJxT+tLpR6b4QfLhBaSMlKfj1aF/245Cysg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="BVJr3/NB";
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E91606A32E
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 21:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0E91606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BVJr3/NB
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso1569758a91.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 13:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793656069; x=1794260869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cd5wWNullUB7y6awi0QqpF0THbdju3RxqFPzvSH65a0=;
        b=BVJr3/NBC9SuLuasSslZeQLV+Y+8lCvDd/W53fZu/MgVJTrlXnrW5EoruW/yd2ALUp
         J64A7sfkFWWV4id6iyFgzXRTu+T1uWvyQrvUv9FOSyBW2lncIgzJD6NhSL0/w7gBMo3z
         CqxKvaehsA1+7tfDZDtGz5UWK3NO2pjOhPc6zFyJxL/B3NR+g9MxXXpugQxbHFD/MgCP
         KuzUXbkvODwj38V+VdDywQjBK6zFLUP6nSDIe2Q3JEkNs/t+EjDvFygVhAhs5I1TyYsD
         Z9dhvBs5Ui/NiYCXzxZ8kPkxTvjdqEO/sVEl2nSD0KaaTleYovwRt0RknSgm1QDxRP+P
         gwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793656069; x=1794260869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cd5wWNullUB7y6awi0QqpF0THbdju3RxqFPzvSH65a0=;
        b=Msw/3oRZX2GmCtGGVHc+YqqRJkfo7XUt1tsyVXZhdW9QKFRqZBPLMs/UYOklD3ywiD
         RA/1WqLFU+RnXMV/w8mUdFwMtmW3BZIo3aSO/UhPnOEHFQqY6yuiAIY7EuBtTVEBd7kS
         prX/ckdWXQFH4VjV2usdsNbLB91VaUB8FXMso0+aPWLf8ZMY9eEbVnvAW/8GHWue+rBU
         XUCvKAEzcqJjqUswT1Dumnd6E1x/+w5jj5dG3RqFT0eEm97EnCucBhfdEB6UbffxOdO8
         bp7263A4/1Ml46v0q5u3gntmngURjeVrTgq70SMaJXWwl5hP+GuAVUhr1HCLt2L2QrVk
         NoIg==
X-Gm-Message-State: APuU4Z+lXylJtvtuHA0qJs0HSpobtmCHlsaG6/q3DIFxFX0szr+qM/FB
	we1nsDhfmDdgbNq0B7x7eFgpyT8qDwsaVQwMRdu2UwtB+XZxHZ9gjiK9iaGzcg==
X-Gm-Gg: AYBFou0UBXV4pvrTn+ojcElFVQb1YBQ3R7fzFDuw2NESJO/kc11ACg/BtpAABQlD5Pv
	ooHB/saezqbbz480vPqKri4/nEAQzy+WWsYTsCG9F6IqaHFH/Yzw0kxbemU3E2tQttXzcKmKfgY
	NeBemiibJSlS0t2ZVMBGbsy2KCKQ273KXOENiBMngFNlWbK4BvYTlrFHNBQWpsv3mpCkOGoXIui
	+YW25qWZqVnRzZBUMBSASEP8QVvvZy+6qaDJojRK1Em5EYUaTF3QnSiGhaoCl/eoDCmRWSHLCVx
	ycgxLvgmACLmSdp4djG4BdyI6SiAGFUzS7iUqRWwayUBRgvbg0qQkjQaH201v/j9kMYLSKM1yQA
	xF25iB5yiIElQVD/Yq6XvpUlejEus/4vtPreenYf4wQ86TKr7Y6L7RCfhEwNG6LVVTcXyIEFr+b
	EetIhIDcXc4fKyYm6hf6qxSjg1pl22y79Ly5zMoksTuDCVvmcbNswwxLdenN2vkhBWljdQiAsAe
	U4/VFgBwnJuThu2AUNO+JHQPjmUHsBZ41AoIeHuveUZpg5FEbP16+8OOivFcSkC4tfOu1WUzW79
	T6Bk4AfiW9mIiptVKBIVn9Pf4a2tEnPO7fr65vpIlX9NyW6MZZBSI5kRJcqD+rqce0vQ7zKRQel
	8j4ECgx9uYBIejsKOyKn7HmIyZsoRtyx8WvEHgB+dADhzGlxb+EDjeCbJXrQeaOiVT0zSfsQIo9
	rmOA==
X-Received: by 2002:a17:90b:1644:b0:3ac:17c:6e85 with SMTP id 98e67ed59e1d1-3ae897c94ddmr9363563a91.47.1793656069127;
        Mon, 02 Nov 2026 13:47:49 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6b3493sm990553a91.13.2026.11.02.13.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:47:48 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: bgmac: keep the maximum RX frame within one RX buffer
Date: Mon,  2 Nov 2026 13:47:46 -0800
Message-ID: <20261102214746.9274-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Each RX descriptor holds at most BGMAC_RX_MAX_FRAME_SIZE (1536) bytes of
frame data. The MAC, however, is programmed to accept up to
32 + ETHER_MAX_LEN = 1550 bytes in bgmac_chip_init(), and up to
32 + mtu = 1564 bytes after bgmac_change_mtu(). max_mtu is set to
BGMAC_RX_MAX_FRAME_SIZE - ETH_FCS_LEN, which leaves out the Ethernet
header and any VLAN tag, so a frame at max_mtu does not fit in one buffer
either.

The DMA engine is the same dma64 engine used by b43 and brcmsmac, which
continue a frame that does not fit into the next descriptor's buffer.
bgmac_dma_rx_read() does not handle that: it consumes only the first
descriptor and parses the continuation buffer as a new frame, taking its
RX header from frame data the sender controls.

Program UMAC_MAX_FRAME_LEN from the MTU plus a VLAN tagged Ethernet header
and the FCS, as bcmgenet does for the same UniMAC register, and limit
max_mtu so that the resulting frame fits in one RX buffer. At the default
MTU of 1500 this gives 1522 bytes. A DSA conduit carrying a 4 byte
Broadcom tag (MTU 1504) gives 1526 bytes. max_mtu drops from 1532 to 1514.

bgmac_chip_init() runs on every ndo_open and used to reset the limit to
the fixed default. Use the current MTU instead.

bgmac_change_mtu() also never updated net_dev->mtu. When a driver
provides ndo_change_mtu, the core leaves that to the driver, so the MTU
seen by the stack never changed. Set it.

Only compile tested. Not tested on hardware. Found with a review on a
different commit by Sashiko.

Fixes: dd4544f05469 ("bgmac: driver for GBit MAC core on BCMA bus")
Fixes: 752e5fcc2e77 ("bgmac: reduce max frame size to support just MTU 1500")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/broadcom/bgmac.c | 15 +++++++++++----
 drivers/net/ethernet/broadcom/bgmac.h |  6 ++++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 669eb7ce7d40..f29568a4190a 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1110,6 +1110,13 @@ static void bgmac_enable(struct bgmac *bgmac)
 	}
 }
 
+/* The MAC counts the FCS in the maximum frame length. */
+static void bgmac_set_max_frame_len(struct bgmac *bgmac, int mtu)
+{
+	bgmac_umac_write(bgmac, UMAC_MAX_FRAME_LEN,
+			 mtu + VLAN_ETH_HLEN + ETH_FCS_LEN);
+}
+
 /* http://bcm-v4.sipsolutions.net/mac-gbit/gmac/chipinit */
 static void bgmac_chip_init(struct bgmac *bgmac)
 {
@@ -1131,7 +1138,7 @@ static void bgmac_chip_init(struct bgmac *bgmac)
 	else
 		bgmac_umac_cmd_maskset(bgmac, ~CMD_LCL_LOOP_EN, 0, false);
 
-	bgmac_umac_write(bgmac, UMAC_MAX_FRAME_LEN, 32 + ETHER_MAX_LEN);
+	bgmac_set_max_frame_len(bgmac, bgmac->net_dev->mtu);
 
 	bgmac_chip_intrs_on(bgmac);
 
@@ -1267,7 +1274,8 @@ static int bgmac_change_mtu(struct net_device *net_dev, int mtu)
 {
 	struct bgmac *bgmac = netdev_priv(net_dev);
 
-	bgmac_umac_write(bgmac, UMAC_MAX_FRAME_LEN, 32 + mtu);
+	bgmac_set_max_frame_len(bgmac, mtu);
+	WRITE_ONCE(net_dev->mtu, mtu);
 	return 0;
 }
 
@@ -1555,8 +1563,7 @@ int bgmac_enet_probe(struct bgmac *bgmac)
 	net_dev->hw_features = net_dev->features;
 	net_dev->vlan_features = net_dev->features;
 
-	/* Omit FCS from max MTU size */
-	net_dev->max_mtu = BGMAC_RX_MAX_FRAME_SIZE - ETH_FCS_LEN;
+	net_dev->max_mtu = BGMAC_RX_MAX_MTU;
 
 	bgmac->in_init = false;
 
diff --git a/drivers/net/ethernet/broadcom/bgmac.h b/drivers/net/ethernet/broadcom/bgmac.h
index 6fee9a41839c..ace65789289f 100644
--- a/drivers/net/ethernet/broadcom/bgmac.h
+++ b/drivers/net/ethernet/broadcom/bgmac.h
@@ -2,6 +2,7 @@
 #ifndef _BGMAC_H
 #define _BGMAC_H
 
+#include <linux/if_vlan.h>
 #include <linux/netdevice.h>
 
 #include "unimac.h"
@@ -330,6 +331,9 @@
 						 BGMAC_RX_FRAME_OFFSET)
 #define BGMAC_RX_MAX_FRAME_SIZE			1536
 #define BGMAC_RX_BUF_SIZE			(BGMAC_RX_FRAME_OFFSET + BGMAC_RX_MAX_FRAME_SIZE)
+/* Largest MTU whose VLAN tagged frames, FCS included, fit in one RX buffer */
+#define BGMAC_RX_MAX_MTU			(BGMAC_RX_MAX_FRAME_SIZE - VLAN_ETH_HLEN - \
+						 ETH_FCS_LEN)
 #define BGMAC_RX_ALLOC_SIZE			(SKB_DATA_ALIGN(BGMAC_RX_BUF_SIZE + BGMAC_RX_BUF_OFFSET) + \
 						 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
@@ -363,8 +367,6 @@
 #define BGMAC_CHIPCTL_7_IF_TYPE_MII		0x00000040
 #define BGMAC_CHIPCTL_7_IF_TYPE_RGMII		0x00000080
 
-#define ETHER_MAX_LEN	(ETH_FRAME_LEN + ETH_FCS_LEN)
-
 /* Feature Flags */
 #define BGMAC_FEAT_TX_MASK_SETUP	BIT(0)
 #define BGMAC_FEAT_RX_MASK_SETUP	BIT(1)
-- 
2.56.0

