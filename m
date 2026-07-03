Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F030AACD
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097575; cv=none; b=U+X0NtdKfc7cMyg2/cJJtpkH58xE5YDjBtczhOsswenvr1N2+KIgH/ESXXqsgnGPfspS3Z0c9QEuVpoC1qRNSDnbJ+9xd6h8CzifFI2e4RTObx/wm8Z3H06kbmA5K33dfitnWTZtvcyxO6JA1jmEm7rw5nryizxJfkVQtzszd04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097575; c=relaxed/simple;
	bh=mVtBwVZyArQ0bhCJCcWF3zOmScZQqVquoXNBpOG3HVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSjqQVHbBbQHdNuNBolncg9BbaSmvB3ZFBR0i7s5AT8F/bM5BmA3P19IjsH+asYskk03/tTD1FWuUodLzTHE2YOhGDcpwTB6JSDUq7m7WcPnZCSZ1UUo51ln9Fg17UK8GBDRmVPZ6TZLxwJ48ivYemNMIJTRdicGFhTQYjkMWQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPBkZo0g; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPBkZo0g"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-845c92bc464so538117b3a.2
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783097572; x=1783702372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qgwoXYPeH8zLNs0z7+G37QoZ0VyUG0HqO/r1pL5e7z8=;
        b=JPBkZo0g+ZyE0th0eL5mgaQTC6mPmMKKpxFt7d/LjGw8ivw3sJUoNNkNf4mYqH0Gib
         RIR1NwHpneiq8w5a4WUzmM5BhG6bWjN7A0G75g970/do4xHjs1xhhCoeovPsD6NzFNkb
         w+k/3Hi+5vyNWyv2WNHCR+S1UbncOKNxGmx6GutJ2QPMCNQ7SrXPVO49gSR1MzAKWcKV
         rGagAwRmu/skgxg2nSfGYhFG9Pc05pYhIQlVdieqRLFPNWkSpHlA6nm6s5efLtp37Isv
         dnhmAn/sulujZIKvGb8LcUa1TFVuo7veBhgjkkUREPcbUNvSHU+XR3wrkxSYS/NIEL3N
         RchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783097572; x=1783702372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qgwoXYPeH8zLNs0z7+G37QoZ0VyUG0HqO/r1pL5e7z8=;
        b=lhecjXzAuSwFFs3Xv0F8GXpey6hosSsVFlT2iJbgHClBwBCEGFudkCog4IFQwTibE/
         6Azl0Fdw1LDf1FyX+0vdTAi4iq9ulYewAqVuSegm8tq1+lGFMiG/FXL4JbeJXWsHKMFo
         2Tzj8p3wPRD6Rmf+6zVoUFl3hkG4Kragpm85iz2Z+ezx/jWseib6Oe3uFsrePyNDDHqE
         LQif4I+smsKtocvTOU+xYHuTOnnThxeCfI6bIIYdo6CVAZaJaAwihBOQ9fjqgoyC72SB
         Q0N2u3UiPcNuceebpG8pR6A2tJNEFdDGWY/XTZ2RdwWhvzQgKUtpUOBFglKd1Hj6vFVw
         fdPg==
X-Gm-Message-State: AOJu0YwgWUW+7F578jrBZ9DsEpFRLrMwZ8a7Gj2m6nuPdCEHZm5P+Npq
	61Hyt+Fb/9zsyV+4Sp19jxFj3oCWJ8xTKQem19mOevJHNy8q0AsY3J+PVg1Ad8Uq
X-Gm-Gg: AfdE7clKNWQrufBC1kMey6GXABFPRMgfJMOhccsBZxjAgYN30S0J2ipXsZCol/VhfyA
	u2d+RoTr/nAG8mdOv5mxmnSbeQYtg8+19/8UAI3ymndvsxsINxOR1i4Fzr5YlFOvy2h467M6fWe
	wu7bNciiB8EAGPmvWGbfaRaPT+AvNkyuXFkuDge1PWdHRlDsl+j0Xz1TPDMD9MYoGZYbk0/cb6D
	Mx7kmW85fhBOHyFMlQIx9ejmHGpEdMolbNQpx8Gpr9hWOXG+vjG6UsEnYrLkOnydEtwIm25zVbT
	XkUppACF640gtKwIsyNY9YsLSthcPFgzqEKquhS4EGBINDdwL2vqJGeGcRqficWjJ6x3X/vfqnc
	dHIEEeelreMM3bsRAnxexYNClVDv01poMZj2YqgMJ186oJzno3XoQZgBm8sZB9aN+5W6H3Fs9s2
	UbZnsv9vcPLkscvMCE6oX+BB6S/YzgwX8iFfF7jsSNuvPVmAuw5kw=
X-Received: by 2002:a05:6a00:92a5:b0:847:7fd5:aaaa with SMTP id d2e1a72fcca58-847f6dbfd4dmr294778b3a.17.1783097572274;
        Fri, 03 Jul 2026 09:52:52 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.215.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b609b8sm98267b3a.5.2026.07.03.09.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 09:52:52 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/3] net: dsa: motorcomm: Move to subdirectory
Date: Sat,  4 Jul 2026 00:51:45 +0800
Message-ID: <20260703165241.542195-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703165241.542195-1-mmyangfl@gmail.com>
References: <20260703165241.542195-1-mmyangfl@gmail.com>
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

