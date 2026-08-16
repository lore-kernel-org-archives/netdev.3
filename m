Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC6F3CAA4F
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786909182; cv=none; b=PIGaQ+WgOg0JsgI0OG51Ok2D86L4Qyr9RdhUqWWtsSsNrfaeKl6/Y4twuZJ22Mj9C1tKbvGHrQLpgOi49goL0H+1lpCk2ip3NGoCG6VxKDQ1jRoTNuRUGxEtNGmvz3Fffn7PkbASFIq0pqX7xitQ1Cu8GRZD7/OC+NRsBJEyKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786909182; c=relaxed/simple;
	bh=3pCFJIQOEu9d96vXOMLd4lwrCzD6ScI84FNbite1h+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1M3qDTN9DSdAiMVQZlbfy+ElRAtUGiG0+KKkdlP0bul/fteaOOPATQOdjfBBmHbHwgORaJa3zrqGVVatuD6PIVjYBXSyfX0qm/zcFa+AJugx9KkStTsDdKXcxPPHnjf6boQPErCSEELHRu+cGwxhMVLmTC/MpUOaMvoIMqrRd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2/42HVG; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2/42HVG"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so2592533a12.0
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 12:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786909180; x=1787513980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WZYHIFroVmV+7VlNpb25EE1plVrmMIM2jzBfwjtS3Q8=;
        b=F2/42HVG00p7KPzqIMw+5VUcOh9JIOHYFGQGzE/SLIxmn0lc1By+vRvtvPy58rDtF7
         sPV1Cenu/aNq7HMBgJDlus7sSYXAvBdmhcvYfXrMcMILRamkCWunREcvTNpF0CZmRf1Y
         O6EpCwWiGsrtP04+Yfz5WlBi/4l8J9Ayk0sD5tIR8NFdOFI+kLVbieR8beqg6iLFwQOg
         mbkipcPuoF5q6ykqtO7rClAyZLXY+fOfVGDb7PYq8dPLZtNxWdi9YHigc5YBsIQaC/9E
         5BInzyss/CpRWOj08UGK/0RICyddCc5mL0y6mkwu58e6N0eAxpX4/OsdynJk2M3mrpW0
         gb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786909180; x=1787513980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WZYHIFroVmV+7VlNpb25EE1plVrmMIM2jzBfwjtS3Q8=;
        b=Yr8zywifCa0yPsERMRNK+i4aH7CFXB5j8EM5KqoYq0ozpkzUkyLWijeaep34m0hA81
         t1+M006WB8RyjHcLpFCGN3xsvagEh1NSKon6TxtM3cpkm3vgcmj20jYyV7slek9J2Eoe
         K+BhO4EYcRL/WPHecMvSt4/8V3hXFLXOj//PixFjS3iVTdbLc/2kkyuR17F7PiXXTe/1
         BX8lKax9KEM3dgnFAMEFIkRFu/vs07YjBe9pd8QJKGnRsqNrsl6pC+kvT8ziR3Z5lc0M
         ZYNGjkmiXR+cviHY8r4paItk/+35vUzF3L2nN40Mk53ws9+CG+SHnHc38J/nkRVGZypV
         w3bg==
X-Gm-Message-State: AOJu0Yxvq0cpZs+ZJ8rnchlNbcnzCgosY5WQO9d/J8ufm4bceque4vWb
	IiUQxUwVecyIZi9rIEOECgfOm8nog6T4eI7A4VSYsXm7/Dd+kd7QfL+pPdDGYA==
X-Gm-Gg: AR+sD10dbA6/Dr5U/e1zj236sY25lQKkUzkd50aWJsInukoUYOKPdKa4eovdwjMZU0u
	b0E46GWJ4bXTd0J6i+cyZab4nXOQd08UWwix2RtQlYwry1eAb/yghrBnrN1czzEOXW4YOJExqs0
	G6KMPBCKvSBndq/W2lSXscqZIJuTiREPyxNw7G/46RGGY0RcURsFA/pf6md1bbaTvpIPOOFOc7G
	7BLVOK99FifWbx9JzeuZUgaacyyG52rNMYNNU0v1GvioRJZRwBpRn0tRY0fBZ0NZK7terYrZzUu
	PZwwTxFy2fv3Xb8gfZ5uvpImoLceNgnoMsYwzgDBap+rW+i0PB4RatkNFmwjjuLjnSYN2Dk4zCd
	2ru2ebDAqOoz9/3cScgbmAlVuzfmcLoKEO5vEzXqJExSb29/syfpzPSL2CXd2nRdCMq1+0w7odE
	5X32TGoVxovNU2AX6Q+r0kuUTqL8FxgPNgcOIWfL5PpNfJeEQT1NS/zWr8PSrsDePLjozKaAgLV
	xttBN0JsAZgoVpe5sbBFjFc
X-Received: by 2002:a17:90b:1d01:b0:38e:7f22:f674 with SMTP id 98e67ed59e1d1-3933b09e9e2mr14971429a91.11.1786909179611;
        Sun, 16 Aug 2026 12:39:39 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:1a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e10d9fsm2244065a91.3.2026.08.16.12.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 12:39:39 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v10 1/4] net: dsa: motorcomm: Move to subdirectory
Date: Mon, 17 Aug 2026 03:38:56 +0800
Message-ID: <20260816193905.218112-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816193905.218112-1-mmyangfl@gmail.com>
References: <20260816193905.218112-1-mmyangfl@gmail.com>
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
index 991460050da7..55cc5ac0e86f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18256,7 +18256,7 @@ M:	David Yang <mmyangfl@gmail.com>
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

