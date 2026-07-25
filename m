Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4697F363C77
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 04:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784955021; cv=none; b=Ewqbyk/8wzogAsYo4iVPaM6dlvCUxHIW3NWC1N7pL/pcA1PAEtcqehWsX2ovOpb+lpgQI1LkO7noj8iH29YPV2VwNOXGoyMurQg0Im1a3VZT8RFCP8R2lzjYPE8C1wTyIlbE9Tc9vOnOUHn68TF5K1VCvJl9/dOcc23A4RX1Q/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784955021; c=relaxed/simple;
	bh=McFU1XltoOSqBDcmK96/ryw62MaV/SdEaqjTRl+RoU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tj3Lkog9xqE2WdL+0PKb3ZhnO53dDoyTMullcNc6s5HMVhyDwsAdIKoUewOpHjRLlxPkwIFiiIjALn4CJlfH1PD573GeYrc7etMqPA+q4SvEMiGrKBSADKHcw+RcsRbSPIcaBG/oXlQlvUyt0W1KuSITWjPzsvwjagPxHglbEp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HItz4P5B; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HItz4P5B"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso1501551a91.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784955019; x=1785559819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VFime+jpUxMcK0mqw+QAAv/xUM3UMh+qIFSPscbYWqE=;
        b=HItz4P5Bxng2xGPuu5uyHMemNMYkAEMR9oV1WyBt3ZBTy2sl9lnPuhXj2B3n5w4ym1
         aP8jAB4lNGTR6EezpLQBS5G5ezbpkb/+pgw6eMxwAdREra0Y1WiHLzfIm3vq+QTmwEt/
         wsppUfQpJLQ2NipvTBsqRyArg1onimcDLy2asTH0R+1vQZfnAGin4hT9PcHSHOXMYPoB
         qVBbsSbcDg0bHHdJmln1t5AcdgspCUUNrdB55I6h9z4jiDyWlawgE3pa+6Z7bkRzSrPA
         CZbMPa+FJg50yTYBH+13KFIJeMDRxRDjLlweQEPNk8udHlVwudvQntzF9qc/vajkF7Ob
         oV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784955019; x=1785559819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VFime+jpUxMcK0mqw+QAAv/xUM3UMh+qIFSPscbYWqE=;
        b=Lt0KKI6trAwSsZcPZuKJGhDmr9QHkhTBC039kwV1nSM8N4MCFWB+4aourHBixvD2TF
         mBYGBhCp7OeNY5oF5Vcf581MRqYHQUZV0sgwGRufnEB4DnW7WCVFr+Gd2C2YbF9fV0R5
         E3OdEwvo+KED5pdqQK3vrRhqy7c6t36Wc5a/sMtrjgWvcdOfhiCPk/uQsFBeVgFDgG++
         RINEIkreTxOmGZNZtOW82Zkk6OX3Rv1ngril4usAMS/qcS2INwZo5NAJe7Jw09hQ850o
         oeWr1w66/fUmL36gFDhlQ/iA+p3ApT6HGLh2OOMl2ONm0kur0xmnepexueI0UDCjQWBS
         knmA==
X-Gm-Message-State: AOJu0YxIPa3MO4/Gw+Sn4ZBPthW28m1gGYgiyPVUkxsuxA92gxQKdT80
	Jstm7ekDQ4yaN8CSca+qSjfhm8XykAxfYmz59OyHQg0D+5nOnp9OifIRUQGGquV6
X-Gm-Gg: AR+sD11H/ksoK6bkwD7DthN4v7hQSMcFhBCGbkGB0Z+q69DoAX8otbC8QkBxUysrzjI
	sZ3G9/gMx71xikNftp99Dns8P1bk7WvWQdaoxJ5ChTBd+nzoJ+ivmc0udWaEz1vJiebLt36mQYT
	dR7ccsVrWb61nbF7Ufi04HbxgUbQoTi4P0QhENV5yMHjx9Ro+5xuyWXg0zWtRj9lfcgl3w0prK+
	mo1EZB02KYX3r9Yyf7mqtgvQ0nQYshSxEQ/Va6oa56UFAN/hvcyUsG1TsX2c8eH6YGLoEAa9CTZ
	CiO2mXz87HbvVwttbIfX9xXaPqtzY36pg+4TXyJCSvsO00Vj8pjzfI/nx3bXiA2491vUTXmx0WX
	HSm9GtOua8Nf57Pj2Fk/Mw/oN5BXTCiNNQcHQPV1Hg29uriSiULw9spger7SAWXuJz8JQ2mE1Kk
	shz4k3bs/2MUeothE9znSTiKfyLDtlH6F4KGtlFwM=
X-Received: by 2002:a17:90b:184e:b0:38e:6c37:d95a with SMTP id 98e67ed59e1d1-38f29529b2amr1242707a91.19.1784955018650;
        Fri, 24 Jul 2026 21:50:18 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:5c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f090b0c9dsm1204155a91.4.2026.07.24.21.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 21:50:18 -0700 (PDT)
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
Subject: [PATCH net-next v8 1/3] net: dsa: motorcomm: Move to subdirectory
Date: Sat, 25 Jul 2026 12:50:03 +0800
Message-ID: <20260725045008.858692-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260725045008.858692-1-mmyangfl@gmail.com>
References: <20260725045008.858692-1-mmyangfl@gmail.com>
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
index 60cff00953dc..f512467753bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18249,7 +18249,7 @@ M:	David Yang <mmyangfl@gmail.com>
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

