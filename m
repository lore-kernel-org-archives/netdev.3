Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A83C3F58
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 04:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788151758; cv=none; b=MkSPJeACDvNqqDFjKOWP4fALcWvRXpWvpggwc+cpDh+P1NqDgz0wKRHZVXvix0og8GGag1ifhTpG+mWA9vbuFnL08m3nxEmFH1oyMzEQsz49gognOaGZRTT88oTnPDKdtHKuhGjxKh+zeokFtjVkrDn/c6Tq7TM7Sa69uuTTwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788151758; c=relaxed/simple;
	bh=5Yj0dTnOwgQEMTB9mEhi4uj5BeVDhHGp8JAp3PNkZec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhEyf28qxxt2j5Pd34Vg4kn9tYOZXgznXfOzOAGCv0VLVivHLUCpNQa1EXOpLMCycG4aZzUMC9UHr9aI06vquiK13sUElX1OCS7NEIiT0ZfFDcgMzeG/4rXCXxsM/V8aQi1PVJDecs6raSTF+8/mwNpz//f4TqHuCOZBjrprdkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbiB/VpM; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbiB/VpM"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-382ef647e20so3002878a91.1
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 21:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788151756; x=1788756556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3xbEFmrs3C5dS+39TnbPAk00KsjGFMl07WADSPwTdM8=;
        b=ZbiB/VpMIsaky0w6Nf2XFvDf3YlxnImC6a7K1sYMeDLMvTW/clHRTaQ7ldBAzSH2OC
         khbx5fs6UJsjeA8bqKK0u/iNkznHH+ACNu95rRFMeq92Q798nVGTtvRIQVnAQPz45dGj
         9r5X2boNzZ+QQkb59UNzgfj9Jx8IfwvJ0X5WN9b9Q/8wxCIgCJbGhVGcQ9qOvUYzW6UB
         eQ9ovIl/YFkrKjn0SjYcRDU8rs99pJwHTiwR2XGZSFoWrt9hF5g0FZfB+8GqFhrEYSdJ
         C4iuuKIZTRpxWXugAsJ9WLi5gU1B9L2JKZ9iaBIBwBhvRj985pFDbGMebsF8cBZHPuuC
         k3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788151756; x=1788756556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3xbEFmrs3C5dS+39TnbPAk00KsjGFMl07WADSPwTdM8=;
        b=V4VunMtWrqyTvevBBfikceaNO2iY4dsqqHMNiDsGgyJz2tiBXUfKlkcSSqkmUkEd9+
         Vj0zy/uKuDpNKV3fyTeG7K3Wb0mgWYl1BUjxmCc4N3s8hsu/pXg0BUBi4fZkwmPSi/rz
         nSUsv+W+NxHEsiir9ssZQamTwoR7iJ19aEd+1RnzqJQmA3TRCwcYhiISr0NKuefrtRmr
         K2TaY7J0HG8Gq39zp1Dddz2D4W+g8DBxfQt2G8dMDSkSnkHAfg2796LFk5G5Hdkd0O2v
         Bra0YPrZ6UxB3oJkCQKGO6KmxAedV0U9gwIEynYORv4KyBAGNHWjpCd3ZPOtpdO7Qt5x
         hdKg==
X-Gm-Message-State: AFuF++ne2VZ0/jTZWcEbxMjkYsnQq2jI9Txjl6MRL4aVFbel79H5TiJG
	t1Ty83w76Y951Pw1NFHqX17kMGj3UhRipTGZNUWWp5r7WFOXk7BgmgmvXA3QoqN3+Z8=
X-Gm-Gg: AYBFou1aIZsBqvWMk7B9tT6W75MKHhdnxSEmk0YnLGhntRn+z0On7n42hKEzHTquOey
	BVf5iilXyBmexjs9z31fS8C3Hom3hfBl9w85K/FIWD4ubZRxkAhRQqwwnM8WADtt8Gs/3rgObuo
	1uBPzEYg/r79acpNBXBECb50QHeiIyOec4tjhrvhnXNznP7AzDMF1xWu7I45BtW4ebl9aFn9OfC
	2L5V3iYIzj4RJjWKsmEm2zMGtEFpaeYLpWO++8FKHRnGuNkxUcNuw8veTGMDkr4UNvy68IEjxdz
	m2Cuxethx/SjSLqFJwJnmH3VvI7hw8f78pJ8LU7+VGFxQVbjjdCi+oMHCTkRBWdk7sJugBDz4wo
	Jfp5XSP77Yqyuip/SqkVmMzqPVK6Gi5+tIcFXnRuQjzTfnILZ+/hMb1IAkCGPyqIsZaNa+fKnxx
	wK3fFU6+c7d37gc/vhnBanAtUgLZlUY4urxd0JhEd+f4K3vDV4t+WW+UV2gHnPkxK9e1GGmKvfI
	Uu0Fv/eS+11t5E=
X-Received: by 2002:a17:90b:5804:b0:398:9bd5:490f with SMTP id 98e67ed59e1d1-3989bd54c38mr22602838a91.22.1788151755928;
        Sun, 30 Aug 2026 21:49:15 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4cf:2e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd5c34sm19345763a91.8.2026.08.30.21.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 21:49:15 -0700 (PDT)
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
Subject: [PATCH net-next v11 2/5] net: dsa: motorcomm: Move to subdirectory
Date: Mon, 31 Aug 2026 12:38:55 +0800
Message-ID: <20260831044818.4103477-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831044818.4103477-1-mmyangfl@gmail.com>
References: <20260831044818.4103477-1-mmyangfl@gmail.com>
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
index 0b42e898f4d8..4b0254f62277 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18422,7 +18422,7 @@ M:	David Yang <mmyangfl@gmail.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
-F:	drivers/net/dsa/yt921x.*
+F:	drivers/net/dsa/motorcomm/
 F:	net/dsa/tag_yt921x.c
 
 MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 676fb7dffe14..8d8edcf89f10 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -82,6 +82,8 @@ config NET_DSA_MV88E6060
 
 source "drivers/net/dsa/microchip/Kconfig"
 
+source "drivers/net/dsa/motorcomm/Kconfig"
+
 source "drivers/net/dsa/mv88e6xxx/Kconfig"
 
 source "drivers/net/dsa/mxl862xx/Kconfig"
@@ -168,12 +170,4 @@ config NET_DSA_VITESSE_VSC73XX_PLATFORM
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
index 6ceb78a755d7..df849cd0e640 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -15,11 +15,11 @@ obj-$(CONFIG_NET_DSA_SMSC_LAN9303_MDIO) += lan9303_mdio.o
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
index 000000000000..64ff7d07a91b
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NET_DSA_YT921X
+	tristate "Motorcomm YT9215 ethernet switch chip support"
+	select NET_DSA_TAG_YT921X
+	select NET_IEEE8021Q_HELPERS if DCB
+	help
+	  This enables support for the Motorcomm YT9215 ethernet switch
+	  chip.
diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
new file mode 100644
index 000000000000..bf99feb4c454
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
+yt921x-objs := chip.o
diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/motorcomm/chip.c
similarity index 99%
rename from drivers/net/dsa/yt921x.c
rename to drivers/net/dsa/motorcomm/chip.c
index 44fcdd47ffb5..019b3a2d5d97 100644
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

