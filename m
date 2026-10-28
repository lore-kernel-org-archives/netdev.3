Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231480;
	b=fAMd0XAsWC10b+bS2878F9YgH+bJASV4YWla57/FQWhiI7GW8wdBDyOKcZiIJV3lMvRs
	 4Fjp79ctMtm+rJoaZXP+5wz0LTz52FgClhedGgCIU7IObP3OGKrlQXzXP4v6KqrpEExL+
	 GCOD7kzhtDv/v1umPFhjFqcmBLyf/etIkLPcHxkUXjWsq3Bnj9T6vc6YdPE0Y6I0tjhdh
	 PIrNzVega7dUU/gToQT5ISCZ0omkxjDMVB89HGAVrKFX2ErPGz1EAOgdUHmrbwJpTwZBQ
	 yXws9TeBEBcltHxZ7K1iOZnfQ7UaApsR8gc6n5m8kseOqRdRtFbAHRFlv8Sbkun460Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231480;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=VXSAHnvRrdjdq7C11KhgAqObZZKQ4MrHs0PWN7JbC5o=;
	b=P2ZuUxU24atAl+AxsbCfRyOyvstYGshsCTSFdFoGUMZn8ZknA8lwNXkbps8dgudIBj2n
	 frQ8p/VF/2if86iZKVJvJ9axqb9VbYe2N98AXV1IfpKGqQo3Rx/xjoJSHAl6QQ9JfrF9R
	 OwYCwEHxJz9xU2pXoY5gfzq32171D+EsR9J3CITkdkV/4GPTlY4ZZDVr20aLg/Wh1LDR5
	 ng3vaNR9JSj/l1QiVPKaH+op4u07sBfF+cXfBZQQ3Wcjzb4SHpMtBNxvq8OoksVlN/xVP
	 vTtwcPb/UlQkAerYUFfc1fY+nwpvh2KqQdCVxzMOG/Hxv11Fe9xUrhCrBrkCtfJoDBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="R3MFy/yF";
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05250606A33A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 23:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05250606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=R3MFy/yF
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so88011a91.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793231479; x=1793836279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXSAHnvRrdjdq7C11KhgAqObZZKQ4MrHs0PWN7JbC5o=;
        b=tmx+ZERi1ViUPEfGCf5awxb81YAWLFVBC4R1yrz3LcxDtQ+ZScTXO1ISodaqtxQKHl
         u9ULq8XEydVBPdk9eawb8kv4WbkMuPjV8U1mVnNB/uJDgnWBcqrHM+72ADe4lDkKiejb
         o51A9LTkZiNdz+ydSAuy20E7/gfBfSBvP1YE4/X+3POASjp+OMfFi9AtSbgBVb1oNlst
         3fCsgEMhI/aYiCi8Dq4BRvdLTBSR2qWBvnQW+6pUfocQGQPuRCW4KxLowREKtLrqCXh2
         pSBZNFWIoMzjXKCnBAw45w1Vs1rLnAPEtJAJGyBZzxEUv/iI+uCEsj6GMV7ZTscLlRmy
         bPVA==
X-Gm-Message-State: AFq9FYIxGO49mIHhOA/BJHMb/8ReofGfrQzGruqBMfJ1iXuh2AZvqeOv
	CTMWgALQ+Jtz0xitvWAInDFLNvn1xyyNR5ZPoJ13DH8VvhGfFUy/5VdpZoWwdluIo5qxpTRIt1+
	VyOPOXI/Ogq7mTVtA6btYHPLAejGHT2rOBtXwMtgAjFSyGeVwJ917FP6/D+3YNsTiDHp18nNHi0
	b7XNbdt8UefI1pO7DFHPaQR/Z9lbFTC5er156iFJnjJzsO/eXDze/su9VtdNDsd1ZUDM/+WME47
	jWgTQB2hgToMhVT
X-Gm-Gg: AYBFou39Jt7zPeG5PHjSE4MA2IlG18rQTh9n/q0G39jEvN19k76KE83WNi6Ri3wn21i
	K7KW4dTNxbzKEJTMuj4pT+QhF5jFTBdDUTCHs0YNHf5WyUWN8EW7UcgAbge1LZ0vwFAYmOydObw
	TwMV0/8OBdLOlN2svjTvakZ1T2q/6CbUy2p7j/Wtkki7E0lhZWIWU0M9HGyAS7l7H6QWNeq2Ea+
	IMDCxhmglOo1wi679wUpRatH5tbCf9ZzAreYZVR9Osgtu57JVtD5qw9j8hgGpfvy+SnnsQwvbHt
	uEH0ncLM0YfMwbsVQqKY2F67vvciectjQOC7voLYMA99HX6LIvoKBqWiIj4sN2c8OPA9ZRVIKoD
	Fseav8jieRWUsUHbN2Jv1qlIMXj/tb75FPVLSyEf7Uzu3W1OnHIQKelVoxOI0IT/AK0Lx6mbHoI
	oa5wbh6/hWBUTkQdcUwFzzYUnNtYD8051ktLNlYJex
X-Received: by 2002:a17:90b:2e8e:b0:3ae:3b3d:c617 with SMTP id 98e67ed59e1d1-3ae6ed69b65mr561839a91.29.1793231479220;
        Wed, 28 Oct 2026 16:51:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae55a6cfdfsm1242706a91.0.2026.10.28.16.51.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 16:51:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91c938148eeso4190046d6.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793231477; x=1793836277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VXSAHnvRrdjdq7C11KhgAqObZZKQ4MrHs0PWN7JbC5o=;
        b=R3MFy/yFotiuXHlmGGYlxVcG6yZIJKAIjI+3GTkGsFvN1JSks6Xnw/VjGuM90A8sju
         2j+3stqvWFvJRRa+iPD/CJGbrOsE5BrrtHr/rwgwJO6VyMhi/mYZ84HMElfAk5XCgU/X
         n/EpgQn4gXwG0dHd8Wy3mZ7YC3VyBxGwUYoqQ=
X-Received: by 2002:ad4:596c:0:b0:91b:b26a:9793 with SMTP id 6a1803df08f44-91c9089912dmr18287116d6.35.1793231477068;
        Wed, 28 Oct 2026 16:51:17 -0700 (PDT)
X-Received: by 2002:ad4:596c:0:b0:91b:b26a:9793 with SMTP id 6a1803df08f44-91c9089912dmr18286786d6.35.1793231476540;
        Wed, 28 Oct 2026 16:51:16 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c84ca44e3sm23074216d6.10.2026.10.28.16.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 16:51:12 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] net: dsa: b53: Enable legacy IGMP snooping controls
Date: Wed, 28 Oct 2026 16:51:00 -0700
Message-ID: <20261028235100.3892374-3-florian.fainelli@broadcom.com>
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

The older switches do not implement the high-level protocol control
register used by newer devices, so they are currently skipped when
setting up multicast control packet delivery to the CPU.

Enable the IP-layer IGMP classifier in the 8-bit global management
configuration register on BCM5325E, BCM5365, BCM5389, BCM5397/5398 and
BCM63xx. Their manuals place this control at bit 3 of page 0x02, offset
0x00. Preserve the other management fields and propagate access errors.
Clear the separate IGMP redirection enable on BCM6318 and BCM63268 to
use snooping mode, as documented in 6318-PR100-R and 63X68-PR201-R.

These legacy classifiers have fixed forwarding behavior, including
query flooding which excludes the IMP on BCM5397/5398 and BCM63xx.
They do not provide the newer per-message IGMP/MLD controls. This change
only enables the documented legacy IGMP handling; it does not add MLD
classification.

Keep BCM5325M and unidentified BCM5325 variants excluded. The BCM5325M
manual reserves the global management IGMP bit and instead describes
snooping through the shared mirroring engine, requiring a different
implementation and coordination with port mirroring.

Fixes: 5d65b64a3d97 ("net: dsa: b53: Add support for MDB")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 23 ++++++++++++++++++++---
 drivers/net/dsa/b53/b53_regs.h   |  2 ++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index e54f6d4d1f7b..957a1501d3f4 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -841,12 +841,29 @@ int b53_enable_mcast_snooping(struct b53_device *dev)
 	u16 val16;
 	u32 val;
 	int ret;
+	u8 val8;
 
-	/* Older switches use different IGMP controls, not HL_PRTC_CTRL. */
-	if (is5325(dev) || is5365(dev) || dev->chip_id == BCM5389_DEVICE_ID ||
-	    is5397_98(dev) || is63xx(dev))
+	/* BCM5325M snooping uses the mirroring engine instead. */
+	if (is5325(dev) && !is5325e(dev))
 		return 0;
 
+	/* Older switches classify IGMP in the global management register.
+	 * They do not provide the separate MLD controls of newer switches.
+	 */
+	if (is5325e(dev) || is5365(dev) ||
+	    dev->chip_id == BCM5389_DEVICE_ID || is5397_98(dev) || is63xx(dev)) {
+		ret = b53_read8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, &val8);
+		if (ret)
+			return ret;
+
+		val8 |= GC_IGMP_IP_EN;
+		/* Disable the separate IGMP redirection mode on BCM6318/63268. */
+		if (is6318_268(dev))
+			val8 &= ~GC_IGMP_RED_EN_6318_268;
+
+		return b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, val8);
+	}
+
 	/* IGMPv2 and MLDv1 reports use the group's destination MAC. Once
 	 * the first listener is offloaded, ordinary multicast forwarding
 	 * can keep subsequent reports from reaching the bridge CPU.
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index cfdb5ed38326..e994d3a188c7 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -217,6 +217,8 @@
 #define B53_GLOBAL_CONFIG		0x00
 #define   GC_RESET_MIB			0x01
 #define   GC_RX_BPDU_EN			0x02
+#define   GC_IGMP_IP_EN			BIT(3)
+#define   GC_IGMP_RED_EN_6318_268		BIT(4)
 #define   GC_MIB_AC_HDR_EN		0x10
 #define   GC_MIB_AC_EN			0x20
 #define   GC_FRM_MGMT_PORT_M		0xC0
-- 
2.53.0

