Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231474;
	b=gDsg1F8/cba2/uWogfgcQ50j0dNIyddK0GDjitFyFdUBPsMyiifL9dukvThqpXoEsANn
	 T0KpY/y3SP5pbLEpDEtJffqHjcvvJNFoZrK2yTIWVpZV58ACIQMNqnEvkoMtjQDrbEaU+
	 Q1ZgtqdtFZEqfsrWTX6vH6PC58Rcx9t314NiNpQaZvHIhDnmfdfiKA3G8KCAtZ/SEoMl6
	 3X2nVee47qWddzVecSGppkKkHJAuUobY/3wiqiZXLs2kXS9iHKgWDDK58w7+Pqs3Y5kAW
	 NePKcrOo7PhzDV/vTimcXdUsCqCQ7gJgDpbnTXMfe5Xk06xeUJ+5j/8QKpje8TOJfjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231474;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=qE+gdncUYmDtaXPwhKS4SBqJ3puL8SPS2UeBXaanCbk=;
	b=zCt52FYJ7knQ+7UyrnSOzDMGkjkUDSq6d4t/WPcQmDsgZYMEZAu+szmx+wybabPUDf5R
	 ykfze490iSpd1E/87BlvE2S24iGKN5Mt6wPEQN6UFYDJ7tfqpJx17taDWBzvYaEM7NeUi
	 hl70z89m+2Gp/TtFbQcO8cBcmj6BiXIj5KJgpWBpdDnMayQVEomeyJjokMQWbcDzTqjlw
	 mXa7qxuQiaD+VbfO6R6eSKIK2JBHTyNKD/FgoRrlKtqpRVBbQnxJ3KNpMofxitx+ezrmX
	 MUoGmnf2p9oCjMaL5fKhWzC98nMAbIBqwo88EanPY9gVr5OW+GTnkLhetHEUcl1xzPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EdM5uZYy;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40A8606A33B
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 23:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F40A8606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EdM5uZYy
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1290866a91.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793231473; x=1793836273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qE+gdncUYmDtaXPwhKS4SBqJ3puL8SPS2UeBXaanCbk=;
        b=RONPQrFuUo/XnwKkgn2iN8xFrXWqkBFNSbJ5QuqO/OTJcbvwDSWgV/aAKnZUQlO69C
         2w35AznUhwNggtrAojYmkJjTi/yc/9oR3u7HVeNQe08JCtGDeHg/BuRTQmITpXTmKI+n
         r6ZxJ4kC3wyjs39LhBMG96xjWBtIPQS0o5ejqUJc6ToJmLl+dtkvLpMs1OC+t4h+2lCm
         ygUG+BWKcGilfrhxGik4s4fcGWf5jNaN1ESmJBKe4yJi9JiMtDtgtUJcqlBV9o3hGhef
         Z+uy3oo+CFnfLu8Ets3sardD/YaFE8kYfrfDcsAnLWCA7bNtAD6OAsXEmS1xBvHwuCWi
         sAuA==
X-Gm-Message-State: AFq9FYKVzhriJ8aVZAZQYMD78PtlP9OSSDe80KG/yNPT/1sUXpj10r/H
	AlzAdTqFDqM9V9ndhhGQk6ohsTCtKQdytmJkoB2nUtOq2VCM3GJAxVnWeUhPpZFjl6lTLx/iLGU
	7Z6SZNSZtHWaKMAKJNtwUnr4BqYy1FwP4QbyV/XplCQvMzWN00yNRw4gYwgZODOHh0AfWIoRUnn
	gXnjw0e+dMrK43NkbLXLKEka+ONg7o2Y2MjEi/Qcc/Ff5VEnJmgXSV0vOxqTZTCt8jihSobhyHH
	SgLBo5mHe+LnqPF
X-Gm-Gg: AYBFou2giVvRQfZRVMJ1nuii5URsiQ1m6fnD+owO40yRUSwDcUtC4K5e5rUwqJJhDwB
	XGu/nqtRF4n7naCUQbR1cc0cn6E81FtwJ/gyQTn8eVIWYiZQGgJvvDEOjQGm428Q6q4hbT5SfxN
	NY4UsX9oiBQaPqckm3yjKxiLfkZ9ZkX7obMUU6pGQyqXLFjjv4+5FsVzYxvzRqIHvBakK3U1PuH
	Q37Zx1QrNDrYu4d3Pi3Oh/f+aWattW3wO8NNuZZM3bcJFoFe76cTGgC15ZBoBsdcLPz1bd1kXHj
	C773h3RmXdSfQMR5R0ZD9+SJsN6uloVXfKiGR5L9z1Oj2TSyQu4gtuAsaXWHy108DVH1WHpqrKd
	bEUnTEstgxzPPr3/ju0fllk134cEbuRRTpwTL4uP3zcdyhsMJJ0HBZa5EobXRLxYGZUCaaSMul7
	hFO5gWoG5k7JlUE3OFgTW6hJiqRndduGewDo5zED+M6dI=
X-Received: by 2002:a17:90a:ec84:b0:3ad:c4e9:7beb with SMTP id 98e67ed59e1d1-3ae58299f81mr3011072a91.43.1793231472912;
        Wed, 28 Oct 2026 16:51:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae57b4c0d8sm1293707a91.3.2026.10.28.16.51.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 16:51:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91c85c9a756so28435246d6.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793231472; x=1793836272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qE+gdncUYmDtaXPwhKS4SBqJ3puL8SPS2UeBXaanCbk=;
        b=EdM5uZYyS0r+GAkwxx8JeK8c7vaySU1BZ4no7WThfG5gAnAuqrK9K4ZNyVV99YqPjb
         8FDGIotB+ZSFT4VHMkl+TOjCUyBbD1y3T2423bS38Ko6yuMKNcXT6w4iAMJOvR6kv7KK
         VKPmXTZBxfbBvC3NDqK9OjmKndQLhDHJR9nKA=
X-Received: by 2002:a05:6214:21e5:b0:91c:7542:c033 with SMTP id 6a1803df08f44-91c7d216a69mr64594266d6.42.1793231471595;
        Wed, 28 Oct 2026 16:51:11 -0700 (PDT)
X-Received: by 2002:a05:6214:21e5:b0:91c:7542:c033 with SMTP id 6a1803df08f44-91c7d216a69mr64593986d6.42.1793231470984;
        Wed, 28 Oct 2026 16:51:10 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c84ca44e3sm23074216d6.10.2026.10.28.16.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 16:51:10 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 1/2] net: dsa: b53: Enable IGMP and MLD control packet CPU copies
Date: Wed, 28 Oct 2026 16:50:59 -0700
Message-ID: <20261028235100.3892374-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028235100.3892374-1-florian.fainelli@broadcom.com>
References: <20261028235100.3892374-1-florian.fainelli@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

IGMPv2 reports and MLDv1 reports are addressed to the multicast group
itself. Once the first listener is installed in the ARL table, subsequent
reports can follow that entry without reaching the CPU. The bridge then
fails to learn additional listeners, although static MDB forwarding works.

Enable the high-level protocol classifiers so that IGMP and MLD control
packets are copied to the CPU independently of the multicast ARL lookup.
Retain normal L2 forwarding by clearing the CPU-only forwarding modes,
and preserve unrelated protocol-control fields.

Handle the BCM5395's 16-bit register and different classifier fields
separately from the 32-bit layout on the BCM531xx, BCM5301x and newer
integrated RoboSwitch families, including BCM7445, BCM7278 and BCM4908.
Export the helper and call it from bcm_sf2_sw_setup() as well, since SF2
uses its own setup operation instead of b53_setup(). This also restores
the classifiers after the switch reset on resume. Leave older devices
with different IGMP controls untouched, and propagate register access
failures during setup.

The SF2 setup integration and BCM4908 chip gate were updated with
assistance from OpenAI Codex in response to review feedback.

Fixes: 5d65b64a3d97 ("net: dsa: b53: Add support for MDB")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 57 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/b53/b53_priv.h   |  1 +
 drivers/net/dsa/b53/b53_regs.h   | 17 ++++++++++
 drivers/net/dsa/bcm_sf2.c        |  5 +++
 4 files changed, 80 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0880310c9ce3..e54f6d4d1f7b 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -836,6 +836,59 @@ void b53_brcm_hdr_setup(struct dsa_switch *ds, int port)
 }
 EXPORT_SYMBOL(b53_brcm_hdr_setup);
 
+int b53_enable_mcast_snooping(struct b53_device *dev)
+{
+	u16 val16;
+	u32 val;
+	int ret;
+
+	/* Older switches use different IGMP controls, not HL_PRTC_CTRL. */
+	if (is5325(dev) || is5365(dev) || dev->chip_id == BCM5389_DEVICE_ID ||
+	    is5397_98(dev) || is63xx(dev))
+		return 0;
+
+	/* IGMPv2 and MLDv1 reports use the group's destination MAC. Once
+	 * the first listener is offloaded, ordinary multicast forwarding
+	 * can keep subsequent reports from reaching the bridge CPU.
+	 */
+
+	/* BCM5395 has a narrower register and a single IGMP classifier.
+	 * Its ICMPv6 classifier also covers MLD.
+	 */
+	if (dev->chip_id == BCM5395_DEVICE_ID) {
+		ret = b53_read16(dev, B53_MGMT_PAGE, B53_HL_PRTC_CTRL, &val16);
+		if (ret)
+			return ret;
+
+		val16 |= HL_PRTC_IGMP_IP_EN_5395 | HL_PRTC_ICMPV6_EN;
+		/* Zero forwarding modes copy control traffic to the CPU
+		 * independently of the ARL lookup, retaining L2 forwarding.
+		 */
+		val16 &= ~(HL_PRTC_IGMP_FWD_MODE_5395 |
+			   HL_PRTC_ICMPV6_FWD_MODE);
+
+		return b53_write16(dev, B53_MGMT_PAGE, B53_HL_PRTC_CTRL,
+				   val16);
+	}
+
+	ret = b53_read32(dev, B53_MGMT_PAGE, B53_HL_PRTC_CTRL, &val);
+	if (ret)
+		return ret;
+
+	val |= HL_PRTC_IGMP_RPTLVE_EN | HL_PRTC_IGMP_QRY_EN |
+	       HL_PRTC_IGMP_UKN_EN | HL_PRTC_MLD_RPTDONE_EN |
+	       HL_PRTC_MLD_QRY_EN;
+	/* Zero forwarding modes copy control traffic to the CPU
+	 * independently of the ARL lookup, retaining L2 forwarding.
+	 */
+	val &= ~(HL_PRTC_IGMP_RPTLVE_FWD_MODE | HL_PRTC_IGMP_QRY_FWD_MODE |
+		 HL_PRTC_IGMP_UKN_FWD_MODE | HL_PRTC_MLD_RPTDONE_FWD_MODE |
+		 HL_PRTC_MLD_QRY_FWD_MODE);
+
+	return b53_write32(dev, B53_MGMT_PAGE, B53_HL_PRTC_CTRL, val);
+}
+EXPORT_SYMBOL(b53_enable_mcast_snooping);
+
 static void b53_enable_cpu_port(struct b53_device *dev, int port)
 {
 	u8 port_ctrl;
@@ -1334,6 +1387,10 @@ static int b53_setup(struct dsa_switch *ds)
 			b53_disable_port(ds, port);
 	}
 
+	ret = b53_enable_mcast_snooping(dev);
+	if (ret)
+		return ret;
+
 	return b53_setup_devlink_resources(ds);
 }
 
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 29cca7945df7..c4d2a41c714f 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -504,6 +504,7 @@ static inline struct gpio_desc *b53_switch_get_reset_gpio(struct b53_device *dev
 /* Exported functions towards other drivers */
 void b53_imp_vlan_setup(struct dsa_switch *ds, int cpu_port);
 int b53_configure_vlan(struct dsa_switch *ds);
+int b53_enable_mcast_snooping(struct b53_device *dev);
 void b53_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		     uint8_t *data);
 void b53_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data);
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 54a278db67c9..cfdb5ed38326 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -274,6 +274,23 @@
 /* Revision ID register (8 bit) */
 #define B53_REV_ID			0x40
 
+/* High-level protocol control (16 bit on BCM5395, otherwise 32 bit) */
+#define B53_HL_PRTC_CTRL			0x50
+#define   HL_PRTC_ICMPV6_EN		BIT(4)
+#define   HL_PRTC_ICMPV6_FWD_MODE		BIT(5)
+#define   HL_PRTC_IGMP_IP_EN_5395		BIT(6)
+#define   HL_PRTC_IGMP_FWD_MODE_5395	BIT(8)
+#define   HL_PRTC_IGMP_RPTLVE_EN		BIT(9)
+#define   HL_PRTC_IGMP_RPTLVE_FWD_MODE	BIT(10)
+#define   HL_PRTC_IGMP_QRY_EN		BIT(11)
+#define   HL_PRTC_IGMP_QRY_FWD_MODE	BIT(12)
+#define   HL_PRTC_IGMP_UKN_EN		BIT(13)
+#define   HL_PRTC_IGMP_UKN_FWD_MODE	BIT(14)
+#define   HL_PRTC_MLD_RPTDONE_EN		BIT(15)
+#define   HL_PRTC_MLD_RPTDONE_FWD_MODE	BIT(16)
+#define   HL_PRTC_MLD_QRY_EN		BIT(17)
+#define   HL_PRTC_MLD_QRY_FWD_MODE		BIT(18)
+
 /* Broadcom header RX control (16 bit) */
 #define B53_BRCM_HDR_RX_DIS		0x60
 
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 9e5713015187..1c846f6d7802 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1059,6 +1059,7 @@ static int bcm_sf2_sw_setup(struct dsa_switch *ds)
 {
 	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
 	unsigned int port;
+	int ret;
 
 	/* Enable all valid ports and disable those unused */
 	for (port = 0; port < priv->hw_params.num_ports; port++) {
@@ -1074,6 +1075,10 @@ static int bcm_sf2_sw_setup(struct dsa_switch *ds)
 	b53_configure_vlan(ds);
 	bcm_sf2_enable_acb(ds);
 
+	ret = b53_enable_mcast_snooping(priv->dev);
+	if (ret)
+		return ret;
+
 	return b53_setup_devlink_resources(ds);
 }
 
-- 
2.53.0

