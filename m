Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035503;
	b=MXBaPp5btvcEmjHZqcfPYcl9ZRCey+33o3aIPNv/20mvlAGTLpBPo2ReA5Q7QlIZ1zzS
	 GW4pqfHexkx1G4vaqUQzWWWqqouobd8uY6/c/mWl04ZrDmOO8m6PjGN/eD/FSzkedJtkv
	 Zl2Wpjt5Lx2E+mSZ8yoVA/kneHVHcNdncyeTQev9Nx4gdsLTvs5XP/tboKrctm09WxSQh
	 ZlfMnYg6yVxZqak+HuVPswQCbFeN7BIu1e3M9YUEU9BxARG/7y1AHw2ibrFnEXGzRGsJ3
	 8aC8RIP7NoXYEIVo3Q5Zk+jFUWJiza1XFQPs6w7pJ/G14FLp3u4QMvEu1AAPUCf0dVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035503;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=Anilyg+OpX1k2rbfizQdpMhmGXdFZZHHaE8PjcFsPBY=;
	b=bhDlbdefD4Q3FUGypSabLoy2mKRau5EyrxbGrMFzHDZ2MTKCCoRX9EEoCoxGvyBvumyQ
	 RXeMi3SUx0ciROBRcIZWW61sM7dvOn8MlQwesxGKUqXUXX3KeX6bwYR2nY5s4dlAryvTW
	 w1P5tDuqq2ZG3xzKctLcZbxSaYd21uUvttgw4/cvx4ba7dHbX76ppDatSpF9lwQa9lo84
	 ylSSu6LM0yxTLHCXPm15nk9vFixNNhDxmVymqdyA44XbtqKKbKP5amBbJWctnpUm9qp4x
	 KMPQR4vMZUWJClzPMPlNJNp+5AFLczcZHN2jQ+QiPftLBeAvWcs3XNAx1Rg//OEatOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="Qmwzn/Ch";
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD4606A327
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 17:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54AD4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Qmwzn/Ch
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so2186559a91.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 10:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793035502; x=1793640302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Anilyg+OpX1k2rbfizQdpMhmGXdFZZHHaE8PjcFsPBY=;
        b=NlgsmYe9crzehco2vQnkKp2/NdCHY1cEVZ63zqLJlKaQYLhcxFUFpRhN5pJEScW862
         Jjv//wAKVdvPllGNVDLblGidjskCryMSJluF5rgp/A6FMDXzLHl10VAQDLSK8bgXH9RH
         WUzeIlWwUMzl8ie7gbmY8NsPrFphHJNpAnugqnodIepCW+sq5llRZa2zpPng0+4/LHiI
         XPN/woF0GMX9rd/nR8AVlLIMItP5A0TVQKQFocuDaghlybHng7TIK+RZ5bXWvXDM1TD+
         2gcgUwIJjKyrjWSOd8B4siKxOeFUcAgBcWzaZtMIDyETBg+oCGOXtK8Q7FODeHdJcJto
         i5bg==
X-Gm-Message-State: AFq9FYKu5Xr55yR7p5Txu9kikuUvFwBMG9SFuyc4tZoydf5qjsBLYYbS
	ycSsTE2HrCKDuIuk6rEJVrnRI6EFnj4gM8mEgn2ZiEq51yCbSkVrs/rdfl9qZyjMw+jxJcTdTOV
	wOSvwVuH67QBQTUPjkOYHNaRdr7OdRtKhQ7x3xqRAc7uOq2QUk65a7KQbC4qoVMMadz3RvPicaH
	Nhm0SY7aGL6+lUw6mkUF1TXROCBa7bvdcGvxGYM1gyQE8FpHjB966sl29mYGCf37w9vw3/325GR
	UlfUqfainR/WC6d
X-Gm-Gg: AYBFou3VjPrUe3rVT47h4l16WXeAEwgxkJczDP/HJq7I9aZOVQcgA8Prq9LqeT389yg
	4nm5yyqUAKP2Ht5OkTxDmui+IBKyWxL6KSb6ofUQLmWWEpIjCgP5mj1dt9fPn1vQT/0oKXlebAB
	9Ca36LsLgUB9CYEqTjKRZn2KSXmsZ/wzrqI5kTJyoJqIgvWhcv0/6m98bWkPjuwuW0LTkCf3ESL
	Y20VqnOxzdlvRhwmacaYU/PAlTr806GObT3tVPYPX+FB0oDwgjRVx7guxL8j8NzNEpLevGTU1/o
	UI2g8Uky2MXSajXEGRkgMdavzcY/8lN1ibHJ6DRw/6gqOY2+zSK9S7fK5cjCt9GJN2iGPrlqTmh
	CPRy6Ai/mi4ma9TNaJWMumVevHEzBGEk/UogCCF0OSCez5SLX9nuvyFhCATJ1gy576NQTym5VdN
	CRfwgkGOJCSUccxGc7b+1KuG+duEtt5y8u6ToLgagX
X-Received: by 2002:a17:90b:588d:b0:3ac:4e18:2390 with SMTP id 98e67ed59e1d1-3adea1ad729mr6986375a91.7.1793035500149;
        Mon, 26 Oct 2026 10:25:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae405f13ecsm150312a91.4.2026.10.26.10.24.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 10:25:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53664911d46so86197591cf.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793035499; x=1793640299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Anilyg+OpX1k2rbfizQdpMhmGXdFZZHHaE8PjcFsPBY=;
        b=Qmwzn/Chv+itwOSYWzSIKrAG2iZc/Uwy3NGlCQk/+fpNX6gwpRvJdf6LNwfZtKQWFm
         39NlJMniVxjJx8FrqF7tTGsCG//zZAOXMp/Ab7LigoThiIn2dQPkipPt3aUvvHGL0AGZ
         k9ncgkkgTVVx32FgsrFOFdV0zq18AA5sFy0rI=
X-Received: by 2002:a05:622a:298c:b0:535:a5f8:a5c7 with SMTP id d75a77b69052e-5383b63b340mr121782291cf.71.1793035498869;
        Mon, 26 Oct 2026 10:24:58 -0700 (PDT)
X-Received: by 2002:a05:622a:298c:b0:535:a5f8:a5c7 with SMTP id d75a77b69052e-5383b63b340mr121781601cf.71.1793035498304;
        Mon, 26 Oct 2026 10:24:58 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53839739ad5sm59689821cf.23.2026.10.26.10.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:24:57 -0700 (PDT)
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
	Vivien Didelot <vivien.didelot@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: dsa: b53: Enable IGMP and MLD control packet CPU copies
Date: Mon, 26 Oct 2026 10:24:52 -0700
Message-ID: <20261026172453.3152951-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
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
integrated RoboSwitch families. Leave older devices with different IGMP
controls untouched, and propagate register access failures during setup.

Fixes: 5d65b64a3d97 ("net: dsa: b53: Add support for MDB")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 50 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/b53/b53_regs.h   | 17 +++++++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0880310c9ce3..54844cfadf01 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -836,6 +836,52 @@ void b53_brcm_hdr_setup(struct dsa_switch *ds, int port)
 }
 EXPORT_SYMBOL(b53_brcm_hdr_setup);
 
+static int b53_enable_mcast_snooping(struct b53_device *dev)
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
+	if (!is531x5(dev) && !is5301x(dev) && !is58xx(dev))
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
+
 static void b53_enable_cpu_port(struct b53_device *dev, int port)
 {
 	u8 port_ctrl;
@@ -1334,6 +1380,10 @@ static int b53_setup(struct dsa_switch *ds)
 			b53_disable_port(ds, port);
 	}
 
+	ret = b53_enable_mcast_snooping(dev);
+	if (ret)
+		return ret;
+
 	return b53_setup_devlink_resources(ds);
 }
 
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
 
-- 
2.53.0

