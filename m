Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3D73B71BE
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108849; cv=none; b=K7fZFq8UOZSCD9yFes7QzIvPPpWHzKDg+JyTfaTGyXTg9nG+hM24BFtQukXH/bsIlLYbbjdh7Wy+pimaU0HmvyVGOc2MGnl8XJ0nTyOA7U6Xtxn2xCWwK5nW+MtCVWaTdZ2oHThs6NTH8IF8KjnVTRrY2hs4isZ5dMKAIcih7IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108849; c=relaxed/simple;
	bh=rL8hh1j/i46+iBLY8P3MaAvF7mr1qzAgCCAvEg7yaEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVGHSXYTQ2mRg6eBphuW2yTmEez1iQRk5mBKuR4yvRueM5RH0i3bP9S16qp8QE/tN2HO2Iaf0VsfbL8r/1hLv4LiZRuRS5J3oYE1v1LmfivOB5d9/K9nZ2I1A03G9zA+5YI5rcPn7AIJfh75lXuJxmIMqxR93+Oeo6F373qfEUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5joOtiG; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5joOtiG"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a1f611461so15803766b.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790108831; x=1790713631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sKaQ4IuF3kh7EZ1Ye0LxST0pKnYBAC52bWRsRYBhFpo=;
        b=B5joOtiGJwcJeox7VD1qI9aSu4JetU3f6fLNlpkr7zQcj6RBW+zp+pfPez5QFKi/je
         DR+4w1MJYRKR2KROIpQVo0+uuQN89dkZwvRZi0BtQb5DnpqIvxWLmIGwjujqSAO9v8bi
         uISNBtVCdrx4Aq5KsiWeuXAtkS6p+SHZOyEVt6qZ4o3TRIs3eINDYA25nogsj2nTe1r/
         6PfXf9ECrm8nR2kMh21vtNJK2QTi0XKV7nyInonyJ6LbDdcKtrZsPHYGfxD5q/2Y7XN2
         L5OHFvVVl6Cn5PtFtjA30eQjWhXmeLxVa1EHhh1YDYGiE2T75tuFtfxOXFOQbtsdrvMk
         jT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108831; x=1790713631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sKaQ4IuF3kh7EZ1Ye0LxST0pKnYBAC52bWRsRYBhFpo=;
        b=fiH1vSCbSwGKfj1UeEue4u5ZiY5NTuX7MBQM2TssrADoYJ2bTlDy7ECX3NTDeV3OHv
         7ZmfNTONlMBGhKcSRcXCNXBSqYZYD7zg2DxG5TWWJ/G5O2E2vuwFvY0jRb/P1DaEhkQN
         +imiNsXqoE0FZ70awz60NBVPqqJ8/w1+kUlWA7YiijlVZFZq0KLaK6dso+PPKcfR2xR5
         DZPAXBxxdMI5TgAZbceev6926srlTIDSqND3yn5oV83y592VFA64i3+kHO1SxB5gnOVn
         nrnOqa3jaRYSkeUZvcXVNAIQq780pobGRZaun5cJhDsusjf8sRWQj6Yw1ihtBbLNe1VS
         jeRA==
X-Gm-Message-State: AFuF++k8DW/CT6P+xAujN+XmIEJbcv/ykxWxu2aTxRhkpSa0frzhNAdC
	d/c9RcxK5kHG9upg0QlXAK1S7n0OR4H4xZZsOb8oyvXeiOFhMBctcWok+IrJoQy62f4=
X-Gm-Gg: AYBFou0lfYjVefR8cYRALVWLI5TWBVFVk1MBwgjKWuSBZtPmTr+blprRuqYDNKygSha
	19IzE9tQk+hzsoeRFMQcoHpQe/rW0js6cpLhjHOgUgwNEYw7ULyB5JEXHYxBNccZr8jBksLxVq0
	gZVcuRkjN4WUVAFBQPeUxmmcOafFsF2VNiroTEsqBj/ol2yx/4XUI7VUQFFwUNQYcUSFNJ8r3IF
	hMu46QvgayjRlFpPEaiT+U322iBp15bpFtulHdhTmpYA5hdKv5Sx2Lg17YbimEgVAPQGQ1AEp0e
	NcWxUjM73oVj8jmfJ4JMjE8EHPP5zoT2DP1CoA7GQrcOGLbXgqzLUmb03TFPtGFiMFdi3Y+M8+B
	dYz91UGMXVBn0uzsYTyLE6auWq4wuXqC1PbJwy75pzzYy8lxljgnO4AD0bo/5vyiBckuk2QnOZA
	wMK+IeLWnf6VWouxNvj1G1WTs9/CJyiUuWgX+9vaWLmA6kVU5XwVKJtkRT7rjZB86dLsLF9edD3
	/6aYiUn7liUQ0djADErv5LHJ5nhVqxUhAu9E063EtXJEh2KvCHt/TbZUXv/7JLAyr/YwNdR1gy5
	IPacHNuKPzifsMIPNW5v
X-Received: by 2002:a17:906:9fcf:b0:c25:f7db:4be9 with SMTP id a640c23a62f3a-c2aacf66887mr55552266b.15.1790108830738;
        Tue, 22 Sep 2026 13:27:10 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-25.cust.bredband2.com. [83.233.130.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c6f5asm11080466b.15.2026.09.22.13.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:27:10 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	ansuelsmth@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	hzyitc@outlook.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Yongzhao Chen <yongzhao.derek@gmail.com>
Subject: [RFC PATCH net-next v2 4/5] net: dsa: qca8k: flag QCA8337 internal CPU PHYs for SmartSpeed
Date: Tue, 22 Sep 2026 22:26:52 +0200
Message-ID: <20260922202653.1153-5-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20260922202653.1153-1-yongzhao.derek@gmail.com>
References: <20260922202653.1153-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark QCA8337 internal PHYs used as CPU links for SmartSpeed suppression.
These links can wait for the conduit PHY during boot, causing SmartSpeed
to remove Gigabit advertisement before the conduit starts.

Use a shared switch-to-PHY flag definition, preserving the revision
bits already consumed by the PHY driver. Only QCA8337 CPU ports 1
through 5 receive the new flag; MAC-only ports and other roles do not.

Assisted-by: LLM
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
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
index 787f30495..4ed1ce660 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/phy.h>
+#include <linux/qca83xx.h>
 #include <linux/netdevice.h>
 #include <linux/bitfield.h>
 #include <linux/regmap.h>
@@ -1744,17 +1745,17 @@ qca8k_get_ethtool_stats_eth(struct dsa_switch *ds, int port, u64 *data)
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
+	flags = priv->switch_revision;
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
