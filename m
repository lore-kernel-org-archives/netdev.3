Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4688637756E
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 06:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407039; cv=none; b=jf4AsjUNFnbpZ1w/FszQLF2dVQzxgkgj8OhQovS+uAu7GH5YT161PMVQTmnkNhiqYS39AvJePWxRpQVKZo0ZO1nEdCmBjMvIL5M8+GGSO0Uz/ZmExFWvLjHo+kGhfWtkqWxPLxhC2LUhb0334Mev5P1QoVT4ywvPudo998H28nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407039; c=relaxed/simple;
	bh=mVtBwVZyArQ0bhCJCcWF3zOmScZQqVquoXNBpOG3HVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7wGGAqGRC3cqetSLixaJO7scYE5fETe6adhbXx6GJ3uLF5lZjS1eD3f6T6saPJvZlgdPMWiXuaSSQAV9tf6PD5xUNWvrRppQo8I1cyTEJCJ7Mi1Q6KfqQUuYPRoekZ/5bjuWbnWU5qBeRDATnx202CBViQAB5WBNXRLS+9adcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2eGx7qz; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2eGx7qz"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-382a3fe0d28so3023671a91.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 23:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783407035; x=1784011835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgwoXYPeH8zLNs0z7+G37QoZ0VyUG0HqO/r1pL5e7z8=;
        b=c2eGx7qz0wuR3YDpAu5IKUm7tWaLUrbbCJ1woozZIYAWl90/6vk3kELN9pXUlj1Lpg
         EPXjL0CFiOoNijvg7dtBlElqjMe9lsczr6Rp6pa/5Q6tSVHp/V/BBHRg3Ac9i490YIYH
         Aak8BLUB6jqBREyMvRgBrixtjj5NfGNbxgSUT0VfOwCHzqc+Pl9wHeA1GrSwoC2uajno
         bSDFg6uttSBwXmEgffCQDGZpW4dBjYu36vKNHKafTXjJkhytRJ9WUltuSHc/u3z6calH
         3AWb9guNJ/c7Y1kXzuenyVP34KRoHLBtrSPXTfWfFKCjQcbTuEB/ing+HbY2/gE9+sR7
         NMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783407035; x=1784011835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qgwoXYPeH8zLNs0z7+G37QoZ0VyUG0HqO/r1pL5e7z8=;
        b=p0MKXw6nSBt1xA+dOXNaLoM22rp254VMFeKNhA1drZuAxxEt8wWyEP7cMMKGILM97y
         wLgnZin3ax3yr42O09hmSgTz00+BQP5YxLD7XX92J7N7zp0KtxsSD89QJNHroA8IZdNm
         8YOSqOcMPhuBRXymBEqRdGRLXonsFtmCqCckOpid8MAmvlP7QqSsUmSYFKkSf+r9gcLr
         8FYhyw3QyXZmtFvLmGsM9HAvcb5gMUR5O1VwgTv2hAYKLxS4e6WCBzbl4h4fydLU8L3r
         1R6gd0fy/Z3ISwrbgij9Sl042TIypfvu+0uI5DBfEnLGLxFG5skk2znaN0Xp3FJaGV0P
         Fzsw==
X-Gm-Message-State: AOJu0YxCNV4zfxDsD20qdAC0tMVzAYWGkzWLeigN6ztiyGM/QXcjeAfP
	QIs0g46UNpXSSeaVbElEqN0fTohn+fj2NthfTB5TTJa+7wNV7Wmqpv/FLRwOo+CM
X-Gm-Gg: AfdE7ckdWPXoOoijFKNAbzWQy3lTbplVcnEJmgdeblkjpAeG0D5iJ/8ItwjOe21/2/R
	mAsnEwX61ZwpyLKC6eZ1Ys5OXF6CNOVgK89L9DqWdVvZWa2rleLZm3YbfvUbDn1fqdtCC3YcC0i
	QiKTzIauYE7BM4KIU9Du0f6VRl2kyiYTC9xLSEJgTgtOzFbNzYveK8dF5Y2nb/Hpqd38RlLvOAO
	nbV0KskW2nseO4Zg/hGjFv+fkxFNU0yV4bga8VAz6awBk3pLCEwq+nXfQp23s7fuCH3ezVAiGUc
	xry3zvC7ns+IXbtk9WGzQIseYLhd7kp8z3Bero2fhDeFiAEbz8VUSmkJ+yAqh6a2ztuX6jaN2V5
	8/kk8uf/PDbAv5EUk88755dxbUPShcrVg1y8EiFbo+ddXCWW6BY5pGRiQVpcquPBdbBYjyq74+F
	nU+6tFifFkxvXU7oP2oy62FXH3FNqcq1w7HHSkK16wGf3k2qpJmWS98gu/lAcA4A==
X-Received: by 2002:a17:90b:2dd0:b0:387:e0bb:57f7 with SMTP id 98e67ed59e1d1-387e0bb5b61mr1705727a91.40.1783407034538;
        Mon, 06 Jul 2026 23:50:34 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.215.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d17e9ff3sm540698a91.7.2026.07.06.23.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:50:34 -0700 (PDT)
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
Subject: [PATCH net-next v5 1/3] net: dsa: motorcomm: Move to subdirectory
Date: Tue,  7 Jul 2026 14:47:48 +0800
Message-ID: <20260707064752.1030345-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707064752.1030345-1-mmyangfl@gmail.com>
References: <20260707064752.1030345-1-mmyangfl@gmail.com>
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
index 06df1171f4cf..b007f20b2763 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18039,7 +18039,7 @@ M:	David Yang <mmyangfl@gmail.com>
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

