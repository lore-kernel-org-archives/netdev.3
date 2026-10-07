Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D13EE1EA
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394595; cv=none; b=ad4tTZmc62aP+wiyga2Ku5CdI7vBM+oLgylYXXdTlnBcA7IG49tLEoNW0TC6uNVHdIBzfX0l4gP67V8Ws4BDclXNAqJiobD80c1RnH9Db4bkw61axF3+eQGjfiO8vodDWcsrcfKjGacG5VkbDZAMK0WlGWoedJc+vxQB0vKE7ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394595; c=relaxed/simple;
	bh=xTc6+Pt0HIOzphR1+634CVvLaokHVF/vgtj5j9M3IHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PeJlGFeB6Lq+pQXDC67bRE62Ed/saNdZfaoOUqnoUKaXpEvimVvXdhPdQdzVDMSWXXgLv+j0calU37E5S/Nsa9acip36DvvctVn+u7QpQhdJLhDeZK//4rwce6hRJjSY9vCqI1IyMinl9nJt58zzTacx8u8gLL35XrKM9DE8e2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8dBWjfE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8dBWjfE"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8714288dd3bso1190366b3a.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791394592; x=1791999392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T2dKA+grcHjFFGSBsQQkVj014EQjGGZzyE9asz2HkMk=;
        b=J8dBWjfE5B020XVjlX8BspkAUj3w8hVNiAhZWPR4jRN8YFr8HhkiY2TOfJ4MtInlHe
         78bKqUUDqLZYjZJYNJ/pJDqAhqE+HvO8Px+UsAg9DEumsiapY2WYtZ7lKphc7ktXfiWe
         VTAB+OT9dxhPwewgiGdfMyfjy6FTlVyrOd8geGkChNEyVty1+SgaG/qHS0dPAxFkIidv
         VpBXMXHsNphexQ3xGEUHg+TYOj5Uk13qtWrXK6CvBQXEkiyjOvnl5//w5/LnTNi1zRT6
         Rlmefxe+bheUBZf0/VW/o2qFWEfG5q7Rc4aDJ9MmfQEAP4z50+LzrTmr/B/gGOwZ+AwJ
         RF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394592; x=1791999392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T2dKA+grcHjFFGSBsQQkVj014EQjGGZzyE9asz2HkMk=;
        b=eawYwdhtbrH6YGhUKNsn8BRUf8jmlLkydL+pjOMWkh57DQYuyMuysPxBgBBCk7VCpz
         058t/D/0vIY9eNrpqhe3t82g9Izaf63lv2KBlty/U3ZsruD7TZa6PP4LTbmntaWnqyqC
         3bEltIZQZqWjTSevYhrT0tV1GTG8Rqudw1EME6oClzUCITaB8mDB5jwaA+HBS9mGPpCB
         ngro6CpzU4h4ZOUGgv76B1Am9Nv2MRer0Is/QKDtzo2gUekrwkFKBJAJDs+a5zvxbNFC
         ejJUxp20cm0GyAPuiZtS3ivCpPgX7ry0Ddqc+T4R9EixNlNYISmU7XV+t5CsmuJQCVkP
         H10g==
X-Gm-Message-State: AFuF++kFkv3gCVFQmZlHcEXQDilCFFevIEeOoYfxnyn3trgbWPVob8c6
	qsJiBAYa1bxZ6y+6DnVSXvwCdWO0mci/bgKhrp1oicHefsLzViCVuJm/U8mKvp74
X-Gm-Gg: AYBFou1MX8Vs6PxcVsIWfRuHRGFEjhegtqkk5sFHcOVc/4uPc+EQQUX+G/7rg5nO9w5
	RPvjFd2P7Zu7frmt5/GPII9G2+YgetTwld1/ljRbP/Axvd+dwHfXO+wpQ9M6eiqoRkkQSH3nsF5
	Lp5KCeaUFPaGSEx9tqqkBICNA61y5idE/dR6eaJ4u8EwvNLt/Xw+32qYc2j9Fh9nMDtQ0xkPzQG
	UTEV46/qaoegRBRUWYcojtc4gfxUHKvFxtX/m286brPXyfp6u7QHgD+cUm5B8KSmN3r2ppNq4Nn
	J+PGmILkaP7IHyhsg0ID3qECyM5zbTWshHOHRccePoYlewZhHtKSY+TR/Ej5oySfrUx3lXAUuXo
	WhNJ8+dAeRblRGjQ82HI2s+6NItPhPWz/0Xgl9ZcKp0/9Bs8UCQ0lrggHd67a9w2c/5WmGFAgSE
	2m4FVjWwpZLB65/oJXeaTmW6HFKiKBxo2OSLaa7s56vUSa4GbZoqYbKk2mjXp/Qph/UKwuvWHc5
	4cxfrngt+8tLZsH0EExvri6SFAYGajIiUcJvHdWhKGlIy8BHtPbWLPs/kTQPy+0m/IxzEeTv/ed
	mai0+uqIuIUlJZQztEHfI06+uQY5wFOF5H42MvecEI11TmqjpzOVv5vQBPA=
X-Received: by 2002:a05:6a00:4394:b0:881:e626:74a6 with SMTP id d2e1a72fcca58-891b0f9246cmr2650565b3a.12.1791394591619;
        Wed, 07 Oct 2026 10:36:31 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892bbd8823bsm665809b3a.51.2026.10.07.10.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:36:30 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2] net: ag71xx: Use default NAPI weight
Date: Wed,  7 Oct 2026 10:36:28 -0700
Message-ID: <20261007173628.657527-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the custom NAPI weight and let netif_napi_add() use the core
default.

The old comment claimed larger weights wasted cycles and cache, but
recent RX and TX path changes altered those tradeoffs. Keep the driver
on the standard default unless measurements show a device-specific value
is needed.

iperf3:

Before:

[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec   327 MBytes   274 Mbits/sec   31            sender
[  5][TX-C]   0.00-10.00  sec   325 MBytes   273 Mbits/sec                  receiver
[  7][RX-C]   0.00-10.00  sec   170 MBytes   143 Mbits/sec    0            sender
[  7][RX-C]   0.00-10.00  sec   170 MBytes   143 Mbits/sec                  receiver

After:

[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec   341 MBytes   286 Mbits/sec   30            sender
[  5][TX-C]   0.00-10.00  sec   338 MBytes   284 Mbits/sec                  receiver
[  7][RX-C]   0.00-10.00  sec   184 MBytes   154 Mbits/sec    0            sender
[  7][RX-C]   0.00-10.00  sec   184 MBytes   154 Mbits/sec                  receiver

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: move out of patchset
 drivers/net/ethernet/atheros/ag71xx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 4e4794c4dfdc..8a3c689f6825 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -40,11 +40,6 @@
 #include <linux/io.h>
 #include <net/selftests.h>
 
-/* For our NAPI weight bigger does *NOT* mean better - it means more
- * D-cache misses and lots more wasted cycles than we'll ever
- * possibly gain from saving instructions.
- */
-#define AG71XX_NAPI_WEIGHT	32
 #define AG71XX_OOM_REFILL	(1 + HZ / 10)
 
 #define AG71XX_INT_ERR	(AG71XX_INT_RX_BE | AG71XX_INT_TX_BE)
@@ -1913,8 +1908,7 @@ static int ag71xx_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	netif_napi_add_weight(ndev, &ag->napi, ag71xx_poll,
-			      AG71XX_NAPI_WEIGHT);
+	netif_napi_add(ndev, &ag->napi, ag71xx_poll);
 
 	ag71xx_wr(ag, AG71XX_REG_MAC_CFG1, 0);
 
-- 
2.56.0

