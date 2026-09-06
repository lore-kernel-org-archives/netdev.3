Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ACE3A5438
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 03:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666051; cv=none; b=rR+k5GEE9PwB3QuCdnKX37P0Ch+86FWM5R9+6vUxx7OR/O8SLooWzjmzC3d5xKbXyqpFAndW3VfnLGbvcSVc3xiPbnkrxgho64qcHNzDMuGKJJwdvcSpEcDq9NwmKh7kUPKQVJ9aXL0ZRtAGFO9B02CJlpm2Lku493P3eqtScuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666051; c=relaxed/simple;
	bh=/8M0tegxRt4HmKQN/LPB34a28YCNaa39wlzYTA1fjKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=luvJxn1XS0Qf5LZiMfiTVf3/DWKKubhUqlWCk8exzVvUgUDYEqWzsPSsc9vJosFcbbm/W8LCitSFhKfJ4TQOV84eIMpcfjJ+baWUeO+LM/rsxPNpi1H10a3YKyRNBIjM7vV2BRZy7O5a3Qqz4NQCETZ8uG2HxavkneGPJ00QptY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKgZ5+2O; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKgZ5+2O"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-38fd9408220so617085a91.1
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 20:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788666049; x=1789270849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IKdp+HR5KTqwNHJfV8ToQcuLLzhKcZ0RoFebWPsbOCw=;
        b=LKgZ5+2OZF1Bg3SZwzR74iP4/p6JPiKDsOD+f/3bjmLZeTQtsg6O6Dyop5qS5dE/qI
         1wXOtSII2pL2b+wpIXJICVINwkdpZZxOwsaWaZTeSrini4CHN+3dLcjm1wEqbEdTFEh8
         N4cEoYVRoYGEP1B0gLEcCkv6srGyms0CrsrRBuVEk3gFxXXG1AaNCBvLkmSH6BpGiUYm
         kfdbKZTPNHtm/xpuBiAy+iwQe0L1eIwLPYSCiRJtLRV5zLhG7KNDYdFjyggPDbc6++6I
         M4o2oE8reBp9R4Bu8nGrTzIN3u+rZArpF+4PFe/T+Ey6pvYgELkO1A/L57IjDqfM0Hdc
         ZUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788666049; x=1789270849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IKdp+HR5KTqwNHJfV8ToQcuLLzhKcZ0RoFebWPsbOCw=;
        b=S6RN8iLJFJVhuaf/HjUMK1HapOjehYV5Zel5gr9z0/YIAjwaKEd3OnBW7zWQ7E8/0t
         M1Qew4ZKqZN/1zE9Z5BwPt0o4gvpC8zgJOVKTyGv3oKNi6X6eHShGjor30b9Av8mGPcC
         xdvPCcmCC1hkNZFXaer2wgGOXdHhv/eKiT17m1DDfsk//kAlne15u0ls0XVfbkrMjiC3
         1Ynalhjtc2IGrRFXQzvRxWtrUOimJEAIZ+uqwltWZSaLUk1BqZh2ShrrbKJKXYbiuSDQ
         KM3L8hyhcscvBS6S0gRrb1TZuNcVFixP6f0B5ytffVKGX0meMKHifHm+kRr7eeunvpX7
         YarA==
X-Forwarded-Encrypted: i=1; AKwUvBx3Di7ewLab+AN2KDJ1hMmdap6U6/Rdlgd+62YgNEzs6juypEroefR23qHZYzuvvscsTmUY1/M=@vger.kernel.org
X-Gm-Message-State: AFuF++m84oFTJd29/Emb5PS4luJ+PDd9F7yZjOW+ZJYXw4bo1O5uQTbW
	eN1Tw7juskyU760rAorlIzLg1207lsnhYlU5IJU8BUbWWv7yRLT41GMp
X-Gm-Gg: AYBFou0JWukTmCjwSz56OISx/c9UPYxqyw+/ZRFW1LeD19HCxF87fUb+elptt82owTs
	h0P1loxXi3j5cmXIPhp5NunvHY11Js3A8YEFWA5v2ED4zCutISCmsA3VfqzySxl9s9IH9qkH3Ts
	Hzt8kq8aYETl2wI8Ac8Khepd9o9hmCmQbzBnI8+yNzWHOtgb6tc72u5ABpqAC2gQ045OYcR1OK9
	pa3y6gFzcg8G2aCfIoOAg12xIqFRq8BdMzrFpD1MyS8AhS4MefwUlZ3N8p8rmIs8JsuHN0aKJx0
	Eq4OLlpkGOTbq0LOlde0+lwdb1UTcSsHvK0W26x7TsS9oLHNjoKRHP/BuPXJDz2czfPez1A0/qa
	MoeXtRL6hpCd1tBqN+1m3/UImomCF1Uo2UlyQU9u1h0wI3USUz83CJheUeqpPXzt/XcRNjZFC8O
	ESfVb7SZvx+qxdC1W57UIdXTZsa5yTwT9UhSyBvZlD5G7pNiQ+pn8+kyKfCfdHN1TncQpg1D9je
	dUsTibojkNsl0fy1CCO/upyrJIio9u0q9RYL7Hzz/B0lO3q2xA0tQmUMr8G4jnqEO1MbtPxTDiy
	pk2chrkEQVDaMJVoprb2gvnHsKz3WuSkgs6nKOtZthos/1/mGn/YrGI=
X-Received: by 2002:a17:90b:1dc3:b0:398:d6f4:c61a with SMTP id 98e67ed59e1d1-39b26207ee4mr24439031a91.17.1788666048184;
        Sat, 05 Sep 2026 20:40:48 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243a9388sm16121651c88.10.2026.09.05.20.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 20:40:47 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	netdev@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>
Subject: [PATCH] zorro: use module_driver() to avoid repeated boilerplate code
Date: Sat,  5 Sep 2026 20:40:19 -0700
Message-ID: <20260906034037.81379-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many Zorro drivers have module_init and module_exit functions that only
call zorro_register_driver() and zorro_unregister_driver(). The
module_driver() macro automatically generates these functions given the
register and unregister functions. Switch to it to simplify the code.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/8390/hydra.c     | 13 +------------
 drivers/net/ethernet/8390/zorro8390.c | 13 +------------
 drivers/net/ethernet/amd/a2065.c      | 13 +------------
 drivers/net/ethernet/amd/ariadne.c    | 13 +------------
 drivers/scsi/a2091.c                  | 12 +-----------
 drivers/scsi/gvp11.c                  | 12 +-----------
 drivers/scsi/zorro7xx.c               | 13 +------------
 drivers/scsi/zorro_esp.c              | 13 +------------
 8 files changed, 8 insertions(+), 94 deletions(-)

diff --git a/drivers/net/ethernet/8390/hydra.c b/drivers/net/ethernet/8390/hydra.c
index 9a59915436d2..2edf97e500df 100644
--- a/drivers/net/ethernet/8390/hydra.c
+++ b/drivers/net/ethernet/8390/hydra.c
@@ -257,18 +257,7 @@ static void hydra_remove_one(struct zorro_dev *z)
     free_netdev(dev);
 }
 
-static int __init hydra_init_module(void)
-{
-    return zorro_register_driver(&hydra_driver);
-}
-
-static void __exit hydra_cleanup_module(void)
-{
-    zorro_unregister_driver(&hydra_driver);
-}
-
-module_init(hydra_init_module);
-module_exit(hydra_cleanup_module);
+module_driver(hydra_driver, zorro_register_driver, zorro_unregister_driver);
 
 MODULE_DESCRIPTION("Zorro-II Hydra 8390 ethernet driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/8390/zorro8390.c b/drivers/net/ethernet/8390/zorro8390.c
index cb1d5ed20874..0f66f28e50b4 100644
--- a/drivers/net/ethernet/8390/zorro8390.c
+++ b/drivers/net/ethernet/8390/zorro8390.c
@@ -430,18 +430,7 @@ static struct zorro_driver zorro8390_driver = {
 	.remove		= zorro8390_remove_one,
 };
 
-static int __init zorro8390_init_module(void)
-{
-	return zorro_register_driver(&zorro8390_driver);
-}
-
-static void __exit zorro8390_cleanup_module(void)
-{
-	zorro_unregister_driver(&zorro8390_driver);
-}
-
-module_init(zorro8390_init_module);
-module_exit(zorro8390_cleanup_module);
+module_driver(zorro8390_driver, zorro_register_driver, zorro_unregister_driver);
 
 MODULE_DESCRIPTION("Zorro NS8390-based ethernet driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/amd/a2065.c b/drivers/net/ethernet/amd/a2065.c
index 672c4996b30e..93f2261f4bfe 100644
--- a/drivers/net/ethernet/amd/a2065.c
+++ b/drivers/net/ethernet/amd/a2065.c
@@ -768,18 +768,7 @@ static void a2065_remove_one(struct zorro_dev *z)
 	free_netdev(dev);
 }
 
-static int __init a2065_init_module(void)
-{
-	return zorro_register_driver(&a2065_driver);
-}
-
-static void __exit a2065_cleanup_module(void)
-{
-	zorro_unregister_driver(&a2065_driver);
-}
-
-module_init(a2065_init_module);
-module_exit(a2065_cleanup_module);
+module_driver(a2065_driver, zorro_register_driver, zorro_unregister_driver);
 
 MODULE_DESCRIPTION("Commodore A2065 Ethernet driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/amd/ariadne.c b/drivers/net/ethernet/amd/ariadne.c
index ec6e7e8c14fe..662eba9e8ffd 100644
--- a/drivers/net/ethernet/amd/ariadne.c
+++ b/drivers/net/ethernet/amd/ariadne.c
@@ -777,18 +777,7 @@ static struct zorro_driver ariadne_driver = {
 	.remove		= ariadne_remove_one,
 };
 
-static int __init ariadne_init_module(void)
-{
-	return zorro_register_driver(&ariadne_driver);
-}
-
-static void __exit ariadne_cleanup_module(void)
-{
-	zorro_unregister_driver(&ariadne_driver);
-}
-
-module_init(ariadne_init_module);
-module_exit(ariadne_cleanup_module);
+module_driver(ariadne_driver, zorro_register_driver, zorro_unregister_driver);
 
 MODULE_DESCRIPTION("Ariadne Ethernet Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/scsi/a2091.c b/drivers/scsi/a2091.c
index f81e53b53e20..421330a7b6a7 100644
--- a/drivers/scsi/a2091.c
+++ b/drivers/scsi/a2091.c
@@ -288,17 +288,7 @@ static struct zorro_driver a2091_driver = {
 	.remove		= a2091_remove,
 };
 
-static int __init a2091_init(void)
-{
-	return zorro_register_driver(&a2091_driver);
-}
-module_init(a2091_init);
-
-static void __exit a2091_exit(void)
-{
-	zorro_unregister_driver(&a2091_driver);
-}
-module_exit(a2091_exit);
+module_driver(a2091_driver, zorro_register_driver, zorro_unregister_driver);
 
 MODULE_DESCRIPTION("Commodore A2091/A590 SCSI");
 MODULE_LICENSE("GPL");
diff --git a/drivers/scsi/gvp11.c b/drivers/scsi/gvp11.c
index 79bd64e12adc..eba868ac355d 100644
--- a/drivers/scsi/gvp11.c
+++ b/drivers/scsi/gvp11.c
@@ -461,17 +461,7 @@ static struct zorro_driver gvp11_driver = {
 	.remove		= gvp11_remove,
 };
 
-static int __init gvp11_init(void)
-{
-	return zorro_register_driver(&gvp11_driver);
-}
-module_init(gvp11_init);
-
-static void __exit gvp11_exit(void)
-{
-	zorro_unregister_driver(&gvp11_driver);
-}
-module_exit(gvp11_exit);
+module_driver(gvp11_driver, zorro_register_driver, zorro_unregister_driver);
 
 MODULE_DESCRIPTION("GVP Series II SCSI");
 MODULE_LICENSE("GPL");
diff --git a/drivers/scsi/zorro7xx.c b/drivers/scsi/zorro7xx.c
index 21c769dc1ecb..80e156b04b99 100644
--- a/drivers/scsi/zorro7xx.c
+++ b/drivers/scsi/zorro7xx.c
@@ -173,15 +173,4 @@ static struct zorro_driver zorro7xx_driver = {
 	.remove	  = zorro7xx_remove_one,
 };
 
-static int __init zorro7xx_scsi_init(void)
-{
-	return zorro_register_driver(&zorro7xx_driver);
-}
-
-static void __exit zorro7xx_scsi_exit(void)
-{
-	zorro_unregister_driver(&zorro7xx_driver);
-}
-
-module_init(zorro7xx_scsi_init);
-module_exit(zorro7xx_scsi_exit);
+module_driver(zorro7xx_driver, zorro_register_driver, zorro_unregister_driver);
diff --git a/drivers/scsi/zorro_esp.c b/drivers/scsi/zorro_esp.c
index 178d46140674..121bcbbce52d 100644
--- a/drivers/scsi/zorro_esp.c
+++ b/drivers/scsi/zorro_esp.c
@@ -946,15 +946,4 @@ static struct zorro_driver zorro_esp_driver = {
 	.remove	  = zorro_esp_remove,
 };
 
-static int __init zorro_esp_scsi_init(void)
-{
-	return zorro_register_driver(&zorro_esp_driver);
-}
-
-static void __exit zorro_esp_scsi_exit(void)
-{
-	zorro_unregister_driver(&zorro_esp_driver);
-}
-
-module_init(zorro_esp_scsi_init);
-module_exit(zorro_esp_scsi_exit);
+module_driver(zorro_esp_driver, zorro_register_driver, zorro_unregister_driver);
-- 
2.43.0

