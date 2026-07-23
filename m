Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006C3B71C7
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836431; cv=none; b=atzpmvKtogu6/0oHDF14HWcqE1a7eC8StUBFDTUhrBo9q9/RNNZuYJFI7x9O4NI3yvlJhZsxUwww8Qd7IPBiOzCMSnCOFUHrzAzjnOR4TZhi4QLJBrbvm8TMIzGDPeBgcLa+aJFNJDIVkQ2+3Sc/nAgA/sNWDgtEEFHjWpgdCVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836431; c=relaxed/simple;
	bh=446eQVmWNqj5YmkZE5Gn3CZgTxR/CxFnRnjNliN559c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egIlWw6YdRMA+QMBpWBFrMnEDUq2uNCHklpBIaTVt3VMkNIc6veFFjnIWFt60PAiLAgMvpGFu/uzoHWtVVBvEQQRdJqCQjsQu6QodvfKRVE++As1XM7DRbAc7vGihYoIMYp7mbh4pLf/n3PfQu87Gk0GdpaPOOSCcN2rylV2kZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MROWBerp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MROWBerp"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceaf8a1265so13484405ad.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 12:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784836429; x=1785441229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5BIdz36PjgYcAb053ISHszQWOmkFf0UUYxlT7CgSK5s=;
        b=MROWBerpaw8MUPcPPZnaJfKtWtiajW8cxPdzVK2DRHa9IU400gOqSqQ8Hr9sfgsj/E
         2eBDxscRX5NTGc/e+wWG+wED/ZTEZvQeqQaXclb6VJw3pQ6Zxl5TZhaKAWyG/n45UMQ/
         AZr6BXuN9qzpiAfldPe8CAuf6yr9sFznr5wWee2Aycq57DJASxxxEcQ11EuPUOHMh9/T
         3pjfRbA3piVijirxoF4wXm3pmTkKXMxemRCa376B8OJKNJrvErHc3+4LTcbN/GnzQssP
         /jUU3wEL5X7BLIHTgQ4iRMxEjpWHT0rCKMiIQ27+amDVLj8xbsGgO9AaCGVc5gKT/jhb
         KWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784836429; x=1785441229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5BIdz36PjgYcAb053ISHszQWOmkFf0UUYxlT7CgSK5s=;
        b=cFn3waHWgVLlelFz8wsxV6sdIfYD6NfzJAISbgQQsMqWqnRu2U7WmtwoTntWHGHH9P
         TWBso8D7C9Wxf+aPkqpNcQcfsEzcHD8sjWrcLNJ5M2ctg6rQDASIcyqaIlQkoc9u4KwT
         NejxkntEGPgollr3hvsTvl4Q/zDqxb+oDBA/UDdgY/+fsoy1jXSmKpoRAUcjOs2GWOBJ
         7j4b6hgiTbJSorq4Tcp3+4/iqQOV/KliNCOEq+2Z91oVAyp3GZEDGY3v3S3U6WSCBmct
         KRHCTYDUUhz50AF44xUw87MauEKy+QdqafIikOQhEjuIFCMTule0wxq8K28U0wO6Mg+Y
         gqWg==
X-Gm-Message-State: AOJu0YyNSc+O5Slup3a4+90DaOtTgaW7fsnkt8Bbc6sA5N3zLJoXxvhJ
	PjRVp4hURhmpki0NVVasW3GHuzxzmIJiMOtBldkr4bXFQ+bSduZGjSrbWd6BjaSv
X-Gm-Gg: AR+sD10Onff09y1zSBm5qwhOUAVx4RVdeIINpjK8fK9WvkQUxkqkHXVWfxUpzRFo8Ky
	vsenvV/dMBRFWBLpmCYdN8jcLq5xIPl2CL5fXU2BLEU0G6NnQocaUF6ME+UU3M6FMdoQNr7jSFV
	jjsOvnrPbTAOfE3b8BMtNlmA1eypDPcCKtAzVp2BWHAg1hwTP3WKViRnrilY96W197qMvvJ1/5z
	WxdhIndJnBS9NDwRTaPoRsrrzCxCaQkuK/NSWMhHeb0OVMWe92nu7gM/HxzQN5Q7wYIFCPa3RHW
	rq823trJ5BZOTA8gTHPyY0uLw1t+8hEc0oDrUdLTTFH4sLjW4aC2MzQSFjHy56YzSjGC3x+fvXe
	PUMe7sUbzAOEZIppt9zWx0AVye/s5QEdGV4xgLTrSb7Ua666GaZwQ02mcTpY637lOeI/dSuXqab
	HnNYSta652mluNmhDiPEM9SSiSEqVo
X-Received: by 2002:a17:902:ea10:b0:2ca:de3:15e1 with SMTP id d9443c01a7336-2cfa708e887mr50040375ad.31.1784836429185;
        Thu, 23 Jul 2026 12:53:49 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f310644sm39106625ad.55.2026.07.23.12.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:53:47 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 1/3] net: dsa: motorcomm: Move to subdirectory
Date: Fri, 24 Jul 2026 03:53:30 +0800
Message-ID: <20260723195335.806002-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723195335.806002-1-mmyangfl@gmail.com>
References: <20260723195335.806002-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

yt921x is already the longest single-file DSA driver, so it's time to
split it into parts.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 MAINTAINERS                                    |  2 +-
 drivers/net/dsa/Kconfig                        | 10 ++--------
 drivers/net/dsa/Makefile                       |  2 +-
 drivers/net/dsa/motorcomm/Kconfig              |  8 ++++++++
 drivers/net/dsa/motorcomm/Makefile             |  3 +++
 drivers/net/dsa/{yt921x.c => motorcomm/chip.c} |  2 +-
 drivers/net/dsa/{yt921x.h => motorcomm/chip.h} |  0
 7 files changed, 16 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/Kconfig
 create mode 100644 drivers/net/dsa/motorcomm/Makefile
 rename drivers/net/dsa/{yt921x.c => motorcomm/chip.c} (99%)
 rename drivers/net/dsa/{yt921x.h => motorcomm/chip.h} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f3218abefd0c..90c921e14a7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18231,7 +18231,7 @@ M:	David Yang <mmyangfl@gmail.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
-F:	drivers/net/dsa/yt921x.*
+F:	drivers/net/dsa/motorcomm/
 F:	net/dsa/tag_yt921x.c
 
 MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 4ab567c5bbaf..98e9bbe47de7 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -72,6 +72,8 @@ config NET_DSA_MV88E6060
 
 source "drivers/net/dsa/microchip/Kconfig"
 
+source "drivers/net/dsa/motorcomm/Kconfig"
+
 source "drivers/net/dsa/mv88e6xxx/Kconfig"
 
 source "drivers/net/dsa/mxl862xx/Kconfig"
@@ -158,12 +160,4 @@ config NET_DSA_VITESSE_VSC73XX_PLATFORM
 	  This enables support for the Vitesse VSC7385, VSC7388, VSC7395
 	  and VSC7398 SparX integrated ethernet switches, connected over
 	  a CPU-attached address bus and work in memory-mapped I/O mode.
-
-config NET_DSA_YT921X
-	tristate "Motorcomm YT9215 ethernet switch chip support"
-	select NET_DSA_TAG_YT921X
-	select NET_IEEE8021Q_HELPERS if DCB
-	help
-	  This enables support for the Motorcomm YT9215 ethernet switch
-	  chip.
 endmenu
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index d2975badffc0..138225baa4d5 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -14,11 +14,11 @@ obj-$(CONFIG_NET_DSA_SMSC_LAN9303_MDIO) += lan9303_mdio.o
 obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX) += vitesse-vsc73xx-core.o
 obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM) += vitesse-vsc73xx-platform.o
 obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX_SPI) += vitesse-vsc73xx-spi.o
-obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
 obj-y				+= b53/
 obj-y				+= hirschmann/
 obj-y				+= lantiq/
 obj-y				+= microchip/
+obj-y				+= motorcomm/
 obj-y				+= mv88e6xxx/
 obj-y				+= mxl862xx/
 obj-y				+= netc/
diff --git a/drivers/net/dsa/motorcomm/Kconfig b/drivers/net/dsa/motorcomm/Kconfig
new file mode 100644
index 000000000000..1fddd386f866
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: ISC
+config NET_DSA_YT921X
+	tristate "Motorcomm YT9215 ethernet switch chip support"
+	select NET_DSA_TAG_YT921X
+	select NET_IEEE8021Q_HELPERS if DCB
+	help
+	  This enables support for the Motorcomm YT9215 ethernet switch
+	  chip.
diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
new file mode 100644
index 000000000000..afd03be9fa35
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: ISC
+obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
+yt921x-objs := chip.o
diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/motorcomm/chip.c
similarity index 99%
rename from drivers/net/dsa/yt921x.c
rename to drivers/net/dsa/motorcomm/chip.c
index 159b16606f6c..f070732845eb 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -26,7 +26,7 @@
 #include <net/ieee8021q.h>
 #include <net/pkt_cls.h>
 
-#include "yt921x.h"
+#include "chip.h"
 
 struct yt921x_mib_desc {
 	unsigned int size;
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/motorcomm/chip.h
similarity index 100%
rename from drivers/net/dsa/yt921x.h
rename to drivers/net/dsa/motorcomm/chip.h
-- 
2.53.0

