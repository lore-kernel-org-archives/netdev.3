Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816476;
	b=Z8kWlo9BLdC81MQzxeQoDixNb1Hy3BJLuv+ekiKhgmC0cZPT9NEWSSb7Xz31k4itinFD
	 sU/TMo+V7Ph9d5aELFsflPzogXiuOGQPHxgTUOkDWmRE0xePsKhIDXGpDtF9SxOx8Gyuf
	 fr32oLZt8kexTCNRSuQ0R4N2bNOSeCubfSxZ17mSvMb7jif3JCjNgTtUHm7a/9LmNNTzh
	 pWv12rwA5mMzKhpJx8zv/15iBB2nlEOgixdCG8UA6jZMCSZcKbLPdmOUFrhxNprmdeure
	 pM+DwPD+mPTvTAPCA/+qTVS9F88d6Tf+rh93ismTcWKpwpsYlcZsA00hNXuUNfWtJ9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Sv7soWA+8vLeAn0vUqDVEp1NS4DBCssklLnyMqiia/U=;
	b=EHevBhRD9KMdCdtHnl5Yy0iQ2y4ce+2UXEZZwu3/4FdjJj3EvlUzl3a7p4GHr9HfcM6L
	 xrG3oWxofyIefpioF+s7uyhpzw43h+Q+kkZ93FfjSOf2KJrI5YH34Lcq+IRkclpq0hNIN
	 iv2dimf2AeIfUAiC0ZkbkvXnl+w1d/+4ydbuyini26IC/7fLIOXL50Iecdy/Loj80brVX
	 LsZ+y7lpZpGD12m2cswVo2k9lLJJDiKX4R+S6J2vNQc67pxM9MOWKbjX7XtwIgrVOydnT
	 19bijBWWTuEbpnH6TU0Ist3r5nP9hbxGloEAGyNMBwfFRmue7TCNHQEqmakYBhIWeVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O3Sohw3y;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEF8606EEA4
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AEF8606EEA4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O3Sohw3y
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso4989745e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816473; x=1794421273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sv7soWA+8vLeAn0vUqDVEp1NS4DBCssklLnyMqiia/U=;
        b=O3Sohw3yzUnp1cPk11pPogSUPf+c4hJme185SYfrLMi+sl3AKe6jlw9KxOarWHn0Gx
         hpPslQKPEdIIc2QgtL1Y4lg5jllxWaVf4qIXQnXY4D1TBcy6zWXfWeuTSiNrhV6BY5AW
         qrdJUP4yoc/gIb95ngj+ec6RkTqDDhgNIVQUZeIB8Z9bAbaKuqcINPdw8E7V6abveKXA
         RGLLSJSsEJROukYT0znjZEPnAPkfA9R1dTL3vn4rBIOCph11YqOpkTFzxfGAszmdPdpQ
         sbiH1tnJDfekZmBtIeSrJGaoAz3vP+MoMtR9u+8laFqXjk3a3JfMPcJcImIGP+/2ZTIK
         grYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816473; x=1794421273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sv7soWA+8vLeAn0vUqDVEp1NS4DBCssklLnyMqiia/U=;
        b=dCXcttQcS/DPqX6PPHJHXv1Tenx0jFehy3HuDd0GNwfUxR0ZynVGyBB8QJT+nJWqIG
         gFjBlggBiTavrQdofzx3jZ0ki3CaBe2j6o/01TvNqRLQcH/rrO+b6Iv7pZFYs5f9g0j6
         OW7lKBMNyZJ7zujBMU2gG0DGWc5WMfiK3gkxebMed9dCzkt0de0pBmP3cxlv95qfXJxp
         0xPdEdLrGo0ptAo1jx+VxKxGVFlOS/4twmBHfevdlcskrW6dkz4CNXCh4JVjDHyeNeZH
         VI3wh5+MQOFoF6wA41GpkUYh0tVwXPyfXmVXrIUFXXSEig5SMUdPegl4SmRdxcNEgluA
         s/9w==
X-Forwarded-Encrypted: i=1; AKwUvBzz4Qd/SK8ATPqy0+G6H/KXMABCBsDL9ua3jQDMx/DoM+ghBHHXXsQyQme5ZXwXXSpQ9+yp/jI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9K8c7ayDDlVwKUZ0BOe4zzUqBYFXorURwourCI1BmQ4MX/FvXl
	BFFF7ucriE3hmxz52NUVaM4Yn3ojuLOKTQHsl5ooJS0Q1f4ZGFwW7NGH
X-Gm-Gg: AYBFou0jUSQYVHeNisy2gEnvyEp0+T8yvQegjPzFeWiFoYl/6QyvxSWZ7nzQIbKnDSH
	LY1DiPa2Kd8/1EFUIoVtfldlzfyZw+QbTTNudJ55JfaEhXmInKe8rJ67+liqCnFk+lrn9Ct319j
	su2vybMRIm1evMTOtUWWeETeJI7Xqshwg1pMKCDBr796SpmTIyLaKgy/NHaWvqzGa6MWlpngcf9
	xovbVJoKmwFkorIm4d+i3JRllspKtW8T3xO7enqaG8U2pOOZ4PBs7A8TvZg64ClUvZcxczigzbk
	tqRLhlpOQd8gmJtVpmsycMpXk+e2bkvYQNQrMu6N7nW26WcnEVC9JP26d9r/vy9eHVUP3hBMTDl
	ZB7FvrV3HrPPrvbUODj+s3+HylsMsL10eGRxbEAubybvCOIJlnvsSUGTjUd+XKTnhi7xjqgsEjF
	lPd/+uPkJycJ1Sqf3d0YNl/ZXo7gImaAWsd2YftL1IjHCcN55wfEF5ieFHknlhWRETny3EqWiBr
	xkBVnCBIz+GDnm8fFJIvZciNf9W8Xd4LNGmzRioHS5PohMecCTYB7+vw1YafIC+IRoYmia73GqF
	Iuc9Ofl42w87E9Ml40yITpOjdgr6Z0fk7/p1ZNvguzBTv1NH6+nkjxN//ufne/VgKBXfZKpSZvO
	aU7yMWWYflfc5FyCgkL6lfEEt8qzaRhq98Ua+MRXNt+JX8MpMyq1abSj7xLA=
X-Received: by 2002:a05:600c:a012:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4ac17b2ce18mr370321105e9.27.1793816473362;
        Wed, 04 Nov 2026 10:21:13 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:b079:a2f1:caf7:b446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844e2sm4073202f8f.28.2026.11.04.10.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:21:12 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
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
Subject: [PATCH net-next v4 02/14] net: dsa: tag_rzn1_a5psw: Add RZ/T2H ETHSW tag protocol support
Date: Wed,  4 Nov 2026 18:20:50 +0000
Message-ID: <20261104182105.1102555-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v3->v4:
- No change

v2->v3:
- No change

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
2.56.0

