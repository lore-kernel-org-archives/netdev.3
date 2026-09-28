Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062DB45FFA7
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581387; cv=none; b=cJjqV1ptyqEFWTK24E/CZyZSgfSI6YnZm6jz6UWnxXD2z5nmSYP9H9EQtR6i8FP5Z2ciIyFclgBS/lvK4XiN6SRr8nvbl8OdO6lTNM+p6bc3DAClr5AukEWONhry2/sqvvabFDD6qNm9sOE4sgY2zetYylMI2QYtaNXgqJfNmrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581387; c=relaxed/simple;
	bh=zIseMialRAIP5msDcZwe8wtbMcXGt98E5kq4ccyMaf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHBfuHUU0RhcxPiplt+0ep5Vkpjm7uMv9ofl3b638z14XFAflYdeNGKwhhhyrTrPDtQo3sGFNVEUPLTfpu8n3lfAqtMSSxY2yjv2EdObDmvJ8nS0eoJWQ5kXHFGn2By0ytIast6P/M8LXBNxztlbyUDxMdpv7PnEJXmCVXxd/cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDVGQ7kh; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDVGQ7kh"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a9edfc851so329670866b.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 00:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790581384; x=1791186184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=evTcyLTV/DIVnWXmZiMlgrVrf4ZyYkEgFr0T8VwAZ/U=;
        b=QDVGQ7khKQLaY30FsSzYFE3yCA8BC5bohueF5gtbDmyYwP+NPL9E7Tb67mT3fZKq+b
         deLWUgmw/NJ40NfuwKgf0/b2FnOhNmsSO9IOD5ZO4oDvfsgLCRidBP84kZTVgjIKFxud
         mumM8isPEV6xYymT4nE3gz7YxL6d3PJDD+W4dUN1RW5GPBOEJgSqvRXGrfgbnf9eTk4D
         BiHX8wVO1/cBmvWJxufbRpOvvRz+wHV1JgUyfzRODqMhsD/ItvF1XAGSIVYITnIrKOhN
         s5+JkALvelMHs19+1ZsuWDKe7T+LWKsr36/pCVcvDbhY8PJk3bjldsolewIivbPV0viW
         cNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581384; x=1791186184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=evTcyLTV/DIVnWXmZiMlgrVrf4ZyYkEgFr0T8VwAZ/U=;
        b=TSugTddzux6EzdGJXgZNlnZHlyPa2EGrxBA27DIhY9WKjFI+EH+XGGgBfdxzjuSLdj
         Z/IEzUs6M9IpA2FRrvLSLQayN7kFfILJRpux5O3p1ojQuaFcAi4LPk3LokaXkLvUdKYN
         3oBKGUL9eh8Oj1MbIvBwPkXVv1Wrrp6CxMFtC735e9ktYkj5X53GSAz0Cp5gJGY+RHJb
         WL08cnctq8M5h+mnY4WphHOMPv8MIlv5mPyilyuF5bJhiAExTDtUjdFgWshxgg35o9OS
         yPBhYaAaauLC852EqjZqi/YmbF6Gq36jGWuhybJqmlDCozLqLw0So2jynjAmndcsBCF2
         SpFg==
X-Gm-Message-State: AFuF++nDi8En7+6zp0aKqYz+/AFTHHdw0hMtmhqKeaglSPSi6YCZ5Ork
	5w8czmcx6yoI3PU1QSCwTn9P3W6oBrBj/nj4SZo9xSV3CpncTZq1+quhZX8IP0MU
X-Gm-Gg: AYBFou0y9Wq0uy8VQgNMk/n2jAGWNXbRwUAdV50pzTu/xsOmaYLJOYxAOoDcFRSuNX+
	jeQyWNVKAor7B4ogSshQqW3X+kn490ufd3C7Chio5Tk3EUzdHQuSobmEVW+6l83ox6lig6+hTkf
	+Kcux9T+ALxYa4mbTXIvJODil7aWQLo3L6fDjzBvstcnm6OYyYizRDtyf+hN4siQLThno2p/TGw
	iPeMF2+nATNpy+raVp1cYrGsnMRscgNr9i4C9AUJahZI2JtB9f0eJmCiiXyeKOsuvh2rNnMcLpm
	MCFVCAvreWK1AxUWpPOPiuuW/qA3cS4xiAkOXdqNoYLRHF5Rx6K1GaMPGVl5B5LKkGoToxeTUDe
	me/fqznpzfD5EVbgm5xwweanMv6RMhcjAqTQeFEW2QJytc5bxXhYD5Y9et67mv2lAtMauUGZp0f
	b11LIrOEWJKP+/LWYvefTqDy986Gzf2zgDRwGH4HLxl714xWavZvKlBnUoVERHzF36uE1b17SON
	/sOszjBMA1LmV6xC2jNwFLuaKVqDxr0yWMgAuYf
X-Received: by 2002:a17:907:db02:b0:c26:19de:9acd with SMTP id a640c23a62f3a-c2aea0622b1mr662289866b.37.1790581384140;
        Mon, 28 Sep 2026 00:43:04 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae76ac760sm419415166b.39.2026.09.28.00.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 00:43:03 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org
Cc: radhey.shyam.pandey@amd.com,
	michal.simek@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net-next v2 2/2] net: axienet: add a MODULE_ALIAS for platform instantiation
Date: Mon, 28 Sep 2026 10:42:56 +0300
Message-ID: <20260928074256.462345-3-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260928074256.462345-1-maimon.sagi@gmail.com>
References: <20260928074256.462345-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module is built as xilinx_emac.ko while the platform driver it
registers is named xilinx_axienet.  For a device tree instantiation that
mismatch does not matter, because the OF match table supplies the
modalias udev uses to load the module.

A device registered by name from another driver has no OF node and so no
OF modalias.  It advertises platform:xilinx_axienet, which matches
nothing, and the device is created but never bound.  ptp_ocp is going to
register the AXI Ethernet MAC of the ADVA TimeCard X2 this way, as a
child platform device described by a software node.

Add the corresponding MODULE_ALIAS so name-based instantiation can
autoload the driver, and give the name a define now that it is used in
more than one place.

Tested on the X2 with a local ptp_ocp change: with this patch the module
is loaded and binds when ptp_ocp registers the device; without it the
device stays unbound until xilinx_emac is loaded by hand.

Assisted-by: LLM sparse
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 0f2170af9b10..ae8ed4495ea0 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -48,6 +48,7 @@
 #include "xilinx_axienet.h"
 
 /* Descriptors defines for Tx and Rx DMA */
+#define AXIENET_DRIVER_NAME		"xilinx_axienet"
 #define TX_BD_NUM_DEFAULT		128
 #define RX_BD_NUM_DEFAULT		1024
 #define TX_BD_NUM_MIN			(MAX_SKB_FRAGS + 1)
@@ -3223,7 +3224,7 @@ static struct platform_driver axienet_driver = {
 	.remove = axienet_remove,
 	.shutdown = axienet_shutdown,
 	.driver = {
-		 .name = "xilinx_axienet",
+		 .name = AXIENET_DRIVER_NAME,
 		 .pm = &axienet_pm_ops,
 		 .of_match_table = axienet_of_match,
 	},
@@ -3231,6 +3232,13 @@ static struct platform_driver axienet_driver = {
 
 module_platform_driver(axienet_driver);
 
+/* The module is named xilinx_emac, the platform driver xilinx_axienet.  A
+ * device registered by name rather than from firmware advertises a
+ * platform:xilinx_axienet modalias, which without this matches no module:
+ * udev cannot autoload the driver and the device stays unbound.
+ */
+MODULE_ALIAS("platform:" AXIENET_DRIVER_NAME);
+
 MODULE_DESCRIPTION("Xilinx Axi Ethernet driver");
 MODULE_AUTHOR("Xilinx");
 MODULE_LICENSE("GPL");
-- 
2.47.0

