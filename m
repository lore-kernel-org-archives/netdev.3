Received: from mail-wr2-f43.google.com (mail-wr2-f43.google.com [74.125.225.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488ED52D2C8
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869419; cv=none; b=kYNoCLVik6O7HeO9xhD/F7G4RJdni2cdZQQBzx+oOe5894qHwbC4dwsfwmfTlbNds15NLTza8oQFviT5jFG9Nq4Zi0UOdGkEnFXJueDNpnC1xOvBDAI12A18y/j2WVa25XrAnLX+e4wvMZdt+28If6yKSjwttr9hX57uQbL2IR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869419; c=relaxed/simple;
	bh=QwvQmRrOx0xGCbxyidAP3RSuqxog4fXlNTd4xY4P0pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFcZABXwiX3UdFIm/Lt01OtiQKhCP+GDvvF6C6rV7DLlK5k4w+zZeZOLaqXX+0SG4mC0xBIJAJQD69nPpdhjdmgoLYBfsUzDeyUunBsdHDcq9Ih/rO0if/cGK7evqQJ+muwx785qxbrMT60Yr0MiFnOm6UVVXHpaoYNxYPmzdeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyiPQBJN; arc=none smtp.client-ip=74.125.225.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyiPQBJN"
Received: by mail-wr2-f43.google.com with SMTP id ffacd0b85a97d-48b024549a2so1538896f8f.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790869415; x=1791474215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YviOrpnvHXNI4WIDrnbbiAUcgeM2j2c2cC0XNpV+I+A=;
        b=EyiPQBJNdFUkL2G3g4/aq5D6u9U4wLYNxkESXUb88QwWvuI+oIqbjvYZQS+w9Vxc1Z
         nG1nbRdY/eY8cb74hIPgcS+ifE9HkSh11cuqIPvVepK5JTlr5LRnmTgWJrSfR2NFPGHA
         iqkbtHypbb31pyBKKeUGEc41/dAbwKaLXJ17RULFkm4ZHJfWGAqdaPPuBAy3wNKNLdm1
         3txc3ALz6rVwRR866BojfzLyBWRhHTM793d+rIYlOKarzHhCJ5/LdEzpC2GcMeUJ2Rak
         dOWodkcZ7b0b3JO07mIzr/AIJ98AC8iIrRt0VWHAgivi6tCu4zu7vh5Jj1fiX5gvHfIp
         GL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869415; x=1791474215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YviOrpnvHXNI4WIDrnbbiAUcgeM2j2c2cC0XNpV+I+A=;
        b=Lq2UiUKgkfTyrVRcrzyfXXyoJ/8jee8nN0OK1zUyFC6N55acK69gSP9YF5IXNGEJNO
         4nvG7rDUm9RxJRZF9aAstgHyfCltCnBvuSDi4ub0xbLZ1dzTouHw8dCA+DNxdN2LI1k6
         cW1LcPhXAxErldGPQbR5/ypaVR4S9JqLwU0UVpOXDc/gcENf3mJ5ri8tgQeCCGugQBM1
         9hAgIFTe2GC+Kb3r9mvQ7qTx5RMTzJ+p63amUCAAV5oPCzcoxqDGJDqh/SSTd+xeF3TG
         sx+tNH3F0UZWWRAbXTXhrRO85ZDAk9QA6MMKys95IdJXIjmRq/tZTeIin6Hy+BSYUIyX
         P7LQ==
X-Forwarded-Encrypted: i=1; AKwUvByfLotrGcxFRtVn/Ih1nBUSICBXaDOp8vcypS+IzlTKeLyCfJ70SE1CmuyNFKBgD/Ju5pTJcL0=@vger.kernel.org
X-Gm-Message-State: AFuF++nSyXtV+WGAZH5SoWEWomeMFK+HJxPcREkjtcSqDWaSOQ9EYTH1
	AXoVctqZOg3+RrS3bIc3sI4Zco3/Gr1Hj5lA3EHfLkrGRWa66XbTi1ev
X-Gm-Gg: AYBFou05fAKrEVXgouiw/y2sbC0+em1ZU5OvM/JeU+VMexrAtChz3sPbippVIhLRpkO
	Wi+3QBkAxPWD5lneBLDYHaHmkfgX1bMfYMrsfy2zVKY5NAD8VMtrELM6iV5YnsGC+zKUFXvPuHJ
	HUpO5y/LYrlH3/aM5942K6N+k3/QAGqpgof+9Kg63sNumLM4RbeD5zzfKwwrI0Op9PRUkiLD143
	sPPmh+bYWV3kj6+JZ3G2/UKkwx2smHxmVpJjdlDxbP5obGkmYRzcSp+RTpFTi2zpwyMsPBPcp6s
	2qvAUVQadzAf1DAQMipzr61//lXqdK9IpX8wzajc6PfHs7Un9vFLGlHmLleNzMaAJV7eFUFKEX6
	bYW+W4Wi1JnIhTnDkf5m33dEXQRDodkgb5j3i/Rykao5bFbTerXej6IV6mt8SBW0sbGXe7c/vwX
	0R0b5WCZGmTB9I1+aPVWKd7KYA52lWAB8wlA3LOncGj+8Go9yoN1Ld6bvGxz4bZafv5muEUxzdK
	WuSsbMChvDCmUD0JQ//RGYJAEIBnY8g8hvND/2BcXaWR95jDcGU5R56DfwRQp84OhVsKHVoKaDj
	a6mcqKCW
X-Received: by 2002:a05:600c:3501:b0:49c:fc6e:8cbb with SMTP id 5b1f17b1804b1-4a02758ed05mr254625e9.31.1790869415275;
        Thu, 01 Oct 2026 08:43:35 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:1be5:ad57:d5e0:f854])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f6db98fsm65195615e9.0.2026.10.01.08.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:43:34 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v2 02/12] net: dsa: tag_rzn1_a5psw: Add RZ/T2H ETHSW tag protocol support
Date: Thu,  1 Oct 2026 16:43:15 +0100
Message-ID: <20261001154326.754314-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add a distinct DSA tag protocol for the RZ/T2H ETHSW to separate its
semantics from the RZ/N1 A5PSW, even though both use the same tagged
frame structure. The on wire layout is identical, but the ControlData
bit assignments differ between the two switch families.

The common tagged frame format is:

  +----------------------+-------------------------------+
  | Field                | Size (octets)                 |
  +----------------------+-------------------------------+
  | Preamble             | 7                             |
  | SFD                  | 1                             |
  | Destination Address  | 6                             |
  | Source Address       | 6                             |
  | ControlTag (0xE001)  | 2                             |
  | ControlData          | 2                             |
  | ControlData2         | 4 (timestamp, portmask)       |
  | Type/Length          | 2                             |
  | Payload              | 0..1500 / 0..9000             |
  | Pad                  | 0..42                         |
  | FCS                  | 4                             |
  +----------------------+-------------------------------+

The differences arise in the ControlData interpretation:

  ControlData field (bits):
    +---------+-----------------------------+
    | SoC     | Meaning                     |
    +---------+-----------------------------+
    | RZ/N1   | [0-3]: ingress port         |
    |         | [4-15]: reserved            |
    +---------+-----------------------------+
    | RZ/T2H  | [0-3]: ingress port         |
    |         | [4]: timestamp timer select |
    |         | [5]: reserved               |
    |         | [6]: RED period indicator   |
    |         | [7-15]: reserved            |
    +---------+-----------------------------+

Because these semantics diverge, register a new
DSA_TAG_PROTO_RZT2H_ETHSW protocol and corresponding tag driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Updated commit message
---
 include/net/dsa.h             |  2 ++
 include/uapi/linux/if_ether.h |  2 +-
 net/dsa/tag_rzn1_a5psw.c      | 21 +++++++++++++++++++--
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 5d12191b6f6f..57143cf52f89 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -62,6 +62,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_KSZ8463_VALUE		34
 #define DSA_TAG_PROTO_MT7628_VALUE		35
 #define DSA_TAG_PROTO_KS8995_VALUE		36
+#define DSA_TAG_PROTO_RZT2H_ETHSW_VALUE		37
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -101,6 +102,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_KSZ8463		= DSA_TAG_PROTO_KSZ8463_VALUE,
 	DSA_TAG_PROTO_MT7628		= DSA_TAG_PROTO_MT7628_VALUE,
 	DSA_TAG_PROTO_KS8995		= DSA_TAG_PROTO_KS8995_VALUE,
+	DSA_TAG_PROTO_RZT2H_ETHSW	= DSA_TAG_PROTO_RZT2H_ETHSW_VALUE,
 };
 
 struct dsa_switch;
diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index 1ffac52c39df..9fd25c5d96c9 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -121,7 +121,7 @@
 #define ETH_P_YT921X	0x9988		/* Motorcomm YT921x DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_EDSA	0xDADA		/* Ethertype DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_DSA_8021Q	0xDADB		/* Fake VLAN Header for DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
-#define ETH_P_DSA_A5PSW	0xE001		/* A5PSW Tag Value [ NOT AN OFFICIALLY REGISTERED ID ] */
+#define ETH_P_DSA_A5PSW	0xE001		/* A5PSW/ETHSW Tag Value [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_IFE	0xED3E		/* ForCES inter-FE LFB type */
 #define ETH_P_AF_IUCV   0xFBFB		/* IBM af_iucv [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_NXP_NETC  0xFD3A		/* NXP NETC DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
diff --git a/net/dsa/tag_rzn1_a5psw.c b/net/dsa/tag_rzn1_a5psw.c
index aab0ec143c77..3dff661fa58c 100644
--- a/net/dsa/tag_rzn1_a5psw.c
+++ b/net/dsa/tag_rzn1_a5psw.c
@@ -23,6 +23,7 @@
  */
 
 #define A5PSW_NAME			"a5psw"
+#define ETHSW_NAME			"ethsw"
 
 #define A5PSW_TAG_LEN			8
 #define A5PSW_CTRL_DATA_FORCE_FORWARD	BIT(0)
@@ -111,8 +112,24 @@ static const struct dsa_device_ops a5psw_netdev_ops = {
 	.rcv	= a5psw_tag_rcv,
 	.needed_headroom = A5PSW_TAG_LEN,
 };
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_A5PSW, A5PSW_NAME);
+DSA_TAG_DRIVER(a5psw_netdev_ops);
+
+static const struct dsa_device_ops ethsw_netdev_ops = {
+	.name	= ETHSW_NAME,
+	.proto	= DSA_TAG_PROTO_RZT2H_ETHSW,
+	.xmit	= a5psw_tag_xmit,
+	.rcv	= a5psw_tag_rcv,
+	.needed_headroom = A5PSW_TAG_LEN,
+};
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_RZT2H_ETHSW, ETHSW_NAME);
+DSA_TAG_DRIVER(ethsw_netdev_ops);
+
+static struct dsa_tag_driver *dsa_tag_driver_array[] = {
+	&DSA_TAG_DRIVER_NAME(a5psw_netdev_ops),
+	&DSA_TAG_DRIVER_NAME(ethsw_netdev_ops),
+};
+module_dsa_tag_drivers(dsa_tag_driver_array);
 
 MODULE_DESCRIPTION("DSA tag driver for Renesas RZ/N1 A5PSW switch");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_A5PSW, A5PSW_NAME);
-module_dsa_tag_driver(a5psw_netdev_ops);
-- 
2.55.0

