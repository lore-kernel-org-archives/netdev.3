Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146207;
	b=bWY8qtv1/KL40wZqhPtbapss3b5mGPA3qccT9pFoUsFj7Mqc40NLgHb3JHYr46DBm3HV
	 o0Qb28ru+x0RwUMVD2XH5T3AajG/FAPuPBfm5GdGXNDWMOpWV+4AO3JqFT7DZJrEUXShE
	 wHrg076+b6/luBCOjrskV94JheN93SrfOwHiAoEHR6bGm6uNxBrG4UOCI3Sie6cULV61q
	 TUvaJ2CuBFquTa0IAGvUxq23VmgGZKJVnEoNNFz8IbdgP+Q1yeznWkBqUu9abWakEZtn5
	 slY/4f2G8uYHAwqYb35rea3bBu/kl5bl98/wS7lcF1/+TTsRXXlAiNvOhZLucjmMi6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146207;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=ofMWakNioGH7vCKJ3imiIU6N74XvaMdKJ5ShmRfXWNY=;
	b=5T+IXEvaBYtsKKSQe7SA/yvThgT0w9YuR+PQENOXmgBi1KpdzlF6wr0jD4mT4nnK4J8C
	 cHnNEgTKbvoJ7iMtCK9q4FZl7RgGEJVlT4cKz77gpA4IywxGnDPPaz02sz08Z8IVCf+jt
	 IOsw3oOiDiNCA+9wRJ6bwV64ODA0Yx5Hv/eUBau+D4ZmRqJUIQikyhEHzfWVGV/q8EpD1
	 Yf8W/Y2W9TfoqVrFJwyuy3MQ5QwR1UBCUb0Y38aWoutlz/Jj9XcA5AoFKuKFoxN0l8i3T
	 zRr4Uua+PMvp8UWyI+avapeZQZ5VCmfjh7ahOTkHuAvn8pRHeOK2dQVSARHGZtbESmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KakoMyeL;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0590C606A322
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 00:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0590C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KakoMyeL
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so186712a91.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 17:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793146205; x=1793751005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ofMWakNioGH7vCKJ3imiIU6N74XvaMdKJ5ShmRfXWNY=;
        b=thP7Y3gL/xZjtyvPw7I5Q+ATVLDE/PT1+cQ2oGZTxAsQq6K7RPGRAvv9/4FWD9MK+V
         +5Smuq9gCyLXCwPiKyjCpt/AXerSgztVH8UtD5OeHP8UKHWc9/TxR5LGHlGQLAe5ywhO
         f09+0r2BQSNq/NNCDpm1FWfmur8ZRXXpECklGx87lfyMY3oL1z93nK5h+rd+m9FwG567
         1nOwLiuNtySmfyJRNlxdeV1oKtESklLvwXQAar37aT2evRqiOGuQaTHdacouiymyKunj
         MY5QMHnR2y53mHX4r4zJhu91shXR+XG3ds1/u1wzAbBGS5X/nRXCfqhwacnG1guuvf/Z
         HYNQ==
X-Gm-Message-State: AFq9FYLnCYcxWyFygxQG8tDD3f94cbQAqG3kqybfg1GAFyBMBtemQg4a
	u7+tO5zxELFOwRUDPmhKlStCJoDMadepJ5h4JGm2vZ7jk9eOrdVuKn+uOclt7CaBEeQvI4jHbNI
	76XQ2Y4aM5BfX+NkheqxZRzglXzo0xtUu3eEUre8EUgS1STkljsMo+k2rfHAjxsgIFNYuQMwdcA
	8aZQfLr1Javp46aBsA2K859vkmoRcBegjY3GzxvHAuzkRNVwGajePuBb43N6pHe3dTJ9i0sS6Uv
	nquClIWLi0LlyvTK8Y=
X-Gm-Gg: AYBFou1jn78KCqY4MVn+Z2o1wlCJ6vc3TB1KBr2W21YKwQmJYdbfGUyVYJd4jrS3FXV
	PDu5QwmeprJkNhb8Hxb7GeQjWO/37DYUKF9H3QyLB5YfMifyRc4IPQrI6sz+5HYA1MMtQnfDlmA
	JvtKtWXiYPf9wnjGfWCLdgs+AAGw2A4db/VL9k5DoHWcUR9yNWa8ZsEmmvBqsI/haah4Xu6QgDB
	8jZM1NjXQvs53yxnJfqRqCFdHdJknpnqXHSaodfsksSq4uVoMwZ0yy0wLhYMOarTK3dzrUsrbuj
	/EH89DiP8QqRC9SNAmudVnOkGyvByLtGU0+l/8fg5FtmYnDLjIUUXdo0tgEmI2vsFERe/aNm/n2
	KmVRXRRTREtGGHeVoPVmKDCpROPCtoKevZGYICQB4SYXEmOHa+fdmatnJ93DOhYn1cTuvrkIObv
	b4pxT2DdFl4WZPV4nYHL68+2IRqP8LU502R57nOf19
X-Received: by 2002:a17:90a:ec90:b0:3ae:2961:14db with SMTP id 98e67ed59e1d1-3ae580af9aamr485788a91.21.1793146205108;
        Tue, 27 Oct 2026 17:10:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae5ac3b58bsm251122a91.7.2026.10.27.17.10.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 17:10:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so719191eec.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 17:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793146203; x=1793751003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ofMWakNioGH7vCKJ3imiIU6N74XvaMdKJ5ShmRfXWNY=;
        b=KakoMyeLxmDqDr9DuGw4E0hDWWTBR1ngKiWaQ2ro2hYXilZGCIIAC4Qepsamq3jLJ4
         uHegGHP5uPowlwktvaHzaX1NBmVMisQjD2Q8UbatTzHBRVZtREktMNo0FZTfO+zjbPVz
         UvU/psd1ZWw7f9vO74iVXxO6bIOQyyxSBiLQI=
X-Received: by 2002:a05:693c:41c8:20b0:351:5cb5:53f7 with SMTP id 5a478bee46e88-36a2027e717mr1630551eec.3.1793146203300;
        Tue, 27 Oct 2026 17:10:03 -0700 (PDT)
X-Received: by 2002:a05:693c:41c8:20b0:351:5cb5:53f7 with SMTP id 5a478bee46e88-36a2027e717mr1630494eec.3.1793146202477;
        Tue, 27 Oct 2026 17:10:02 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239a56e9sm288486eec.27.2026.10.27.17.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:10:01 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] net: dsa: b53: Enable IGMP and MLD control packet CPU copies
Date: Tue, 27 Oct 2026 17:09:11 -0700
Message-Id: <20261028000912.2081659-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
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
Changes in v2:

- export the helper and call it from bcm_sf2.c as well as spotted by
  Sashiko

 drivers/net/dsa/b53/b53_common.c | 52 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/b53/b53_priv.h   |  1 +
 drivers/net/dsa/b53/b53_regs.h   | 17 +++++++++++
 drivers/net/dsa/bcm_sf2.c        |  5 +++
 4 files changed, 75 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0880310c9ce3..51784432d266 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -836,6 +836,54 @@ void b53_brcm_hdr_setup(struct dsa_switch *ds, int port)
 }
 EXPORT_SYMBOL(b53_brcm_hdr_setup);
 
+int b53_enable_mcast_snooping(struct b53_device *dev)
+{
+	u32 val;
+	u16 val16;
+	int ret;
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
+		val16 &= ~(HL_PRTC_IGMP_FWD_MODE_5395 |
+			   HL_PRTC_ICMPV6_FWD_MODE);
+
+		return b53_write16(dev, B53_MGMT_PAGE, B53_HL_PRTC_CTRL,
+				   val16);
+	}
+
+	/* Older switches use different IGMP controls, not HL_PRTC_CTRL. */
+	if (!is531x5(dev) && !is5301x(dev) && !is58xx(dev) &&
+	    dev->chip_id != BCM4908_DEVICE_ID)
+		return 0;
+
+	ret = b53_read32(dev, B53_MGMT_PAGE, B53_HL_PRTC_CTRL, &val);
+	if (ret)
+		return ret;
+
+	/* IGMPv2 and MLDv1 reports use the group's destination MAC. Once
+	 * the first listener is offloaded, ordinary multicast forwarding
+	 * can keep subsequent reports from reaching the bridge CPU.
+	 * Copy control traffic to the CPU independently of the ARL lookup,
+	 * retaining L2 forwarding rather than selecting CPU-only traps.
+	 */
+	val |= HL_PRTC_IGMP_RPTLVE_EN | HL_PRTC_IGMP_QRY_EN |
+	       HL_PRTC_IGMP_UKN_EN | HL_PRTC_MLD_RPTDONE_EN |
+	       HL_PRTC_MLD_QRY_EN;
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
@@ -1334,6 +1382,10 @@ static int b53_setup(struct dsa_switch *ds)
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
2.34.1

