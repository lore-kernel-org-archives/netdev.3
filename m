Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709953CA8F
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200766; cv=none; b=CmxXFcMO0iqosctdUsKCCPOpcxSavgDKjKFTuuzT4DDJTd0YjStlzG/k3qVVhsw//z7RaRZRzO/gbpT5Ir1AOAUcNZ/UoTb4klvXghVwuJ7WWAfY63x5cJgKTAtAqDD9T97JRB9z0MymQf5Gzfo1jQOMsJ/DV58EaSUXTw/C69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200766; c=relaxed/simple;
	bh=5gfHs0DE0zfd7koAyevGbDjumRWOd7Hr1A4BH4Aj7+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbJyHwiuAAcv1L05x7LAN43NvaYv8jjYSMEizp+K+JYDSXXPknvC7309Seo1xaesFMRdgVWGf9OW3Tc0R6YRC58VhTDiFrNhDP4jfAEhuktXSe07TK5ckdRGVKNaYM2PYhGkAgt4mbmyuwdgarSIDGefMiQfUPwkWQHK/iXrzYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DB4/hywe; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DB4/hywe"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f7db0so169565766b.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790200759; x=1790805559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P92jem68mkwNA6iweEzefBInf0j+gtff7Zos5mplzR0=;
        b=DB4/hyweUK1SrGssMlSBjUIoL9fRTPlSYAnJxkjjn+hgSYjX6RjCvUQrGlgb0XllAC
         Vb0OkOhiRQv5mS48qeApgXeWyPGi2BOewED0XiBcMLHvzKfpB80wLWC5Rp9JwQ9NBuVc
         iG4gJI+d5ZivzvjBWI0NJq+Zjjx3XnlfdzWobWzFNmJP/o45IR6stcYYDOJkDAzH4PbM
         rSt/hNp1XDDivsvyzMqWE62eaIRHMj8R9xlAMlzf44IX2iVzJE3LWXh01yBESsN2xFpC
         Rh27KpSDJX/GeyBb/MAz+ZPUzhC8vPjB7BQzNu+gxstga6UdmI1xd7DyObnZ/KpZkUDi
         21pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200759; x=1790805559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P92jem68mkwNA6iweEzefBInf0j+gtff7Zos5mplzR0=;
        b=iumSkWbk9Q1DGw7LoVjboAm+fqert9RJ+k0lgyeDk33mBihEeQzW3aE/m7s7q/w6Xn
         ORpOOHiMGa25QyRj5Z2egBLcCU3MYRZ8+U8+zEnvOOMVOdegEPXm9xrbmLKNXD9UEq/Y
         SfPj1Kr9vnD03hNglcJGIpMdquRI8pdrS9x3Ch7a11eIG5cngCRtVOih06bly0niiTVm
         ZMBab0coibJIVOLp8inDPaGUIaJqQukvd3OTDla3kCD+5Csn7L7v/lhHtCzn9wBWmUo5
         LTLFNOtamJWrHAFou4Mv/PRvVLTP2g1s4BwStlSkbQcbh1NxNKldzzTHTCM8GH3robR+
         KFHg==
X-Gm-Message-State: AFuF++kLmM5btJWEdEl/rli/TXoinOI6zLy6Oc4CPVnut+04qbN/GLPR
	baR7pNH+zaU1FvpydO7nQTqiUFxONiHWGY5WXdIQ0KYXxzINWtDbuigupWVoyyMB/Ne13w==
X-Gm-Gg: AYBFou32f2yyC8GR9jILx7Q/e5tBWMB2P5Nd6cdVpfaGMum/lz3suCdnU0pyWwp+vq1
	g+WwivC/ehvMHxhM8/tSIthDlMjQEnBbX+6ZhqQrSlimLfaKbuDUe2N8IJX9Vj0p6RYHxcKxfuT
	RvB9fNIyiiMotqSVoZOzxuQj49TR3SM8yf2uVS4k4Ur0AVraqOUroG2+qK6Zrrguy9e9nlDyg90
	glcqI9NJXRQApAz/VuySS8ywHa2nrI+y7xAYyljz7g8nLnhD6Ixy9BAbSv90sSNH4D1qFzkENe3
	Cfe4TTR3cxRcWp0nbl8y0lbGZMHUPkxQ3XqOOJ/zAaRJEahNggDBYXtPi5tMVDfzj5Z/NA9BmQC
	vjlFnu0PTdXtlWzGvHtKoZ84lOsfH05doft9kslG6CEWganJu52ufLIc120eSY/TK6XpMR2/vCL
	0x5B4tWNgc9iSIoEszFs4JLVoHNvrEBMvgdLFn5Rlj0W5/L+5nNqlcRlICZ2QNJGT18/mN4OxM5
	8uOnZ63zyXbsB94i9fjz1YPCkZTwAgc8rPfatOwoTN4MwPzMXlAwxFmPNCcorQ7v6xaQCzQMA5J
	P4cfjzyfv1TdBKeZWTPG
X-Received: by 2002:a17:907:a68b:b0:c29:6400:ef8e with SMTP id a640c23a62f3a-c2ac262e026mr32247666b.42.1790200759039;
        Wed, 23 Sep 2026 14:59:19 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-25.cust.bredband2.com. [83.233.130.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6dcf0dsm197647666b.61.2026.09.23.14.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:59:18 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [RFC PATCH net-next v3 4/5] net: dsa: qca8k: flag QCA8337 internal CPU PHYs for SmartSpeed
Date: Wed, 23 Sep 2026 23:58:56 +0200
Message-ID: <20260923215858.1653-5-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20260923215858.1653-1-yongzhao.derek@gmail.com>
References: <20260923215858.1653-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flag QCA8337 internal PHYs used as CPU links for SmartSpeed suppression.
SmartSpeed is the Qualcomm PHY driver downshift feature configured in
register 0x14. Its enable and bypass-timer bits are cleared by a
subsequent patch prior to software reset.

In a diagnostic boot on one RA74, PHY4 initially advertised 1000BASE-T
full duplex, but a later read showed that advertisement cleared.
Clearing SmartSpeed before the initial reset preserved the 1 Gb/s link
on that board. This observation does not establish the root cause of the
advertisement loss or prove that a delayed conduit PHY caused it.

Define a shared switch-to-PHY flag while preserving the hardware
revision bits consumed by the PHY driver. Mask the revision before
setting the flag to prevent revision values from mistakenly enabling the
quirk on user ports. Only QCA8337 internal CPU ports 1 through 5 receive
this flag. The hardware test covered PHY4 on one RA74; the other ports
and boards selected by this code have not been validated.

Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
Assisted-by: LLM
---
 MAINTAINERS                      |  1 +
 drivers/net/dsa/qca/qca8k-8xxx.c | 19 ++++++++++---------
 drivers/net/phy/qcom/qca83xx.c   |  3 +--
 include/linux/qca83xx.h          | 11 +++++++++++
 4 files changed, 23 insertions(+), 11 deletions(-)
 create mode 100644 include/linux/qca83xx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index df8ab9b82..fa1da8031 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22336,6 +22336,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/qca8k.yaml
 F:	drivers/net/dsa/qca/qca8k*
+F:	include/linux/qca83xx.h
 F:	net/dsa/tag_qca.c
 
 QUALCOMM ATHEROS QCA7K ETHERNET DRIVER
diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 07640ce4a..cd7adb2d9 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/phy.h>
+#include <linux/qca83xx.h>
 #include <linux/netdevice.h>
 #include <linux/bitfield.h>
 #include <linux/regmap.h>
@@ -1754,17 +1755,17 @@ qca8k_get_ethtool_stats_eth(struct dsa_switch *ds, int port, u64 *data)
 static u32 qca8k_get_phy_flags(struct dsa_switch *ds, int port)
 {
 	struct qca8k_priv *priv = ds->priv;
+	u32 flags;
 
-	/* Communicate to the phy internal driver the switch revision.
-	 * Based on the switch revision different values needs to be
-	 * set to the dbg and mmd reg on the phy.
-	 * The first 2 bit are used to communicate the switch revision
-	 * to the phy driver.
-	 */
-	if (port > 0 && port < 6)
-		return priv->switch_revision;
+	if (port <= 0 || port >= 6)
+		return 0;
 
-	return 0;
+	/* The PHY driver uses the switch revision for analog initialization. */
+	flags = priv->switch_revision & QCA8K_DEVFLAGS_REVISION_MASK;
+	if (priv->switch_id == QCA8K_ID_QCA8337 && dsa_is_cpu_port(ds, port))
+		flags |= QCA8K_DEVFLAGS_NO_SMARTSPEED;
+
+	return flags;
 }
 
 static enum dsa_tag_protocol
diff --git a/drivers/net/phy/qcom/qca83xx.c b/drivers/net/phy/qcom/qca83xx.c
index bc70ed8ef..0f484cdfe 100644
--- a/drivers/net/phy/qcom/qca83xx.c
+++ b/drivers/net/phy/qcom/qca83xx.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/phy.h>
+#include <linux/qca83xx.h>
 #include <linux/module.h>
 
 #include "qcom.h"
@@ -16,8 +17,6 @@
 #define QCA8327_B_PHY_ID			0x004dd034
 #define QCA8337_PHY_ID				0x004dd036
 
-#define QCA8K_DEVFLAGS_REVISION_MASK		GENMASK(2, 0)
-
 static struct at803x_hw_stat qca83xx_hw_stats[] = {
 	{ "phy_idle_errors", 0xa, GENMASK(7, 0), PHY},
 	{ "phy_receive_errors", 0x15, GENMASK(15, 0), PHY},
diff --git a/include/linux/qca83xx.h b/include/linux/qca83xx.h
new file mode 100644
index 000000000..f90ed80fb
--- /dev/null
+++ b/include/linux/qca83xx.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_QCA83XX_H
+#define _LINUX_QCA83XX_H
+
+#include <linux/bits.h>
+
+/* QCA8K switch-to-PHY flags, carried through phy_device::dev_flags. */
+#define QCA8K_DEVFLAGS_REVISION_MASK	GENMASK(2, 0)
+#define QCA8K_DEVFLAGS_NO_SMARTSPEED	BIT(3)
+
+#endif
-- 
2.43.0

