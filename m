Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7603D090E
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785083267; cv=none; b=avBB+EkZZ55f9a8uFhYGZwmKn7xJCL65MWQdn/ygkMbbe2MFun97BbeVNsJIZpwthvqYIWjsTDmUVxMie/Am64ztq6VeTYQr+qdJSY0KudXzW6j+YU28icj8hVksIReFZsUhfF6EBwhfcsV4hrFAmLDY7+4qr0btA2FQh/5yY2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785083267; c=relaxed/simple;
	bh=McFU1XltoOSqBDcmK96/ryw62MaV/SdEaqjTRl+RoU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WizH3W0ebdzYEOM062ziYBpH/ST63KP6sbuMEm63moxnuVJMQ/wODIrnUjPrWYigA2K36qcyRDcq2PoKYN/DH7w3jijtmkKFBSyXVa+QA/OeF+qEBzhcrgS1WPDgoAtlaC1HsOOjLZEuT3cn+nB4Vw20a5RUE5EjVfhGRZKxKHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew0c7ZQh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew0c7ZQh"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cca0c5799eso17575335ad.0
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 09:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785083262; x=1785688062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VFime+jpUxMcK0mqw+QAAv/xUM3UMh+qIFSPscbYWqE=;
        b=ew0c7ZQh8cEsPdYboYPEuHZBevZ5xbrK9hJZom04h1Vkn9kG2FekMrmUVPBWkqBhMu
         oBUZp9TrYNw6hPNOyqqehlE6b6dno9AhYvMs+1TXAaFJt8cRdNzkedRYLXgbdwO3xzAc
         nWrmXxSeCfh018A9kCL6XebNSXSpIw0QJsHXIcGJ/hds70x6zIf3cwFu2142kdGkH3o+
         XgQT/OtUxbb5S7qiT/vo4oDgc4DJnWXGHOe5npr3RnoppK2t1UErIzQqyzEQF64+BCDF
         YCZDWMKuGgdQ93E8PhWJDk2v8Bmsv1WKq1f077doxX978FxSitAC1wjae81PcdQIk76h
         qBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785083262; x=1785688062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VFime+jpUxMcK0mqw+QAAv/xUM3UMh+qIFSPscbYWqE=;
        b=hQ8FhvQgR4OGlUPttxQhOctMP7Tyl6G8LXXgS0M02r+b4p7kbA1qSnP5Ir3BTVG/cP
         tnIB//eU/3OTQLK9m9MYmleOdOPts3GD2lIYHeozGqW5Jor1p/WPlC6m8rxCLxjXgt3Y
         Iw+fj+4K8/YsmuOnBtv/HJEKij9waYXJXiLn50D3zK5DKXGvW9tKX0l3agKyCUg8lXUf
         HOSM1+mVesfP6OU2GGBC734uZp3SDKZLRRIwtrhikAXcnG0ir0KvMZilZzdi3EsYnDE3
         5oKVPaJgZkGctk3h6eVw4QTSc2seWjFU54BHWAnuBfr4Ql8olS7NWDl1bl2qgPhxMb/+
         +aDg==
X-Gm-Message-State: AOJu0YyM7Yx8OAPmhl2zc7tdmpteVq2YIhwSolayfscEe3r8+6T8FfDq
	oB7rVaiGnQvS8Q+Ih5+85++VAo1O5gcr5jZzM0NsbXJ5wYEKd92TX/6FEUxhrwd2
X-Gm-Gg: AR+sD12c8YCGI7M4gwBgMqogtSp/5tpZQX9ESfaN97ve+DDc8w/Lp6vhTB05rIM2gtS
	0rjj5Nke5hsbAz4TUCUn2UmznyuV0FuaYAkvr36SuDUwduNshS3TN/qHntjuFVaanHxCG9q8OFc
	8/Yx2ZWfKdM9Eze/ib8MpzIILDBW0BYlGKvmY/iLk3TcegGXYy4nYD1kTyRpQyMeyJProtpmWoX
	6xuWnhrhK0CIiEdzKLfnmHJ1UN5HfTVFm1QvUIYWSVHJe0F5/C2px3DPoqIzQoLThE+e/6KkdxK
	Vby9bjvh6SdJeclrAwCs/Nc0+49VPdohxHg0NeEptWIrQmLg0JT8DWBlODhDMvmfYJ3xJJd3zcY
	GrvJMD7pq+D2xD+9UmXjlcmizePxccU8eW6BsnZji7B9V5VK+75ubBJfSbWHQb/ZN44XNtK0Lf1
	kus21BX18zntyakxO27iO4Ejy3GZRT
X-Received: by 2002:a17:903:2446:b0:2c9:97a8:afef with SMTP id d9443c01a7336-2cfde8673a4mr51459045ad.40.1785083262329;
        Sun, 26 Jul 2026 09:27:42 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bbdc2sm22124325ad.42.2026.07.26.09.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 09:27:42 -0700 (PDT)
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
Subject: [PATCH net-next v9 1/3] net: dsa: motorcomm: Move to subdirectory
Date: Mon, 27 Jul 2026 00:27:27 +0800
Message-ID: <20260726162731.1005803-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726162731.1005803-1-mmyangfl@gmail.com>
References: <20260726162731.1005803-1-mmyangfl@gmail.com>
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

