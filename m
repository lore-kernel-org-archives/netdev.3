Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394998;
	b=XGnAqioyUf3rQEqLGWfIlHeeqwBHcCHEREYxVvREchE0XqErJdVPX+YdcoQRopfCMisM
	 z7I5fTGIkWDAc2JcoNUkX1Ux1rOPc8SsetmY6KWOuhO0j29G2yqZCE8Qylsh22kfVBQrf
	 xWO+Cy2ZITGd1ZuDd8lN/fx4LwPp5yyKSa9/mz78mAOR/Jp8bEGoBluvA4Isou0tD+eBB
	 1Fuc5pGGOcqbK/UUMtjZWTOjwDkhmWXRHzeoEyVOEOpQlaVhdbCQxSKgePeUlWDGbsold
	 bRcmceeltdNgiwj62sL1ZtgnHE7JNIW83Q695W1agmZRQLSI0m90QVINBJQMbaLXokQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394998;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=5pFLRxCJ/yA1VIBBqBPBGRLvkDsq4oo9CE4KjMa/p5I=;
	b=RdlrTDji1o7rzQFvdSmsWIYfJDEs8Z8ylk4KF/vq+5CzHzjUIvCZRZHflbpj7dZnqnzE
	 ikQMu8RSLF/NB91zAlmp26cmH/9sclOM2OM7IODO4HE4CA8+ks2dVhLZf7B5mADWMHlZi
	 QjRXGm6XTE8XKmN4QS5+ud1EK6I0dC906ltwnbGrz5Bl5mqxQwFoF51Jb4qhNcvygeTVJ
	 YGpkaAbe7LXzxBwlYW4Dy7D1ZZTigrSXsQrixGCm/NcqtnOG0u5wbnkcFVlPWYwL4MAQ5
	 pm9H3HLUGbxcZC1IF98bu3HCkRsTH+x/KqraRN7b9MIenpTCs4Diq6V8iJHDZ2oWHEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IiiPrFOe;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA94606A33D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CA94606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IiiPrFOe
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so1008178a91.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394997; x=1793999797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pFLRxCJ/yA1VIBBqBPBGRLvkDsq4oo9CE4KjMa/p5I=;
        b=AzJuVeKENNPCa9JHddar6NfmUMyBcxYXrafdZzaXNopZRn946xusbpDbLzXJLuws1O
         MYKHdqC+OLQI880wE0Sf7N8i4IH3fqCZsNo45dCfYzBrnc4moaY7T5fU64mU9jaWSRXR
         3SxRtvgcYS5seTHvVmVlsCjoLDl+DlBvKeflkOCIveJYrCwIBGsQCAiRpK4ghNpi8BIW
         PZIRMGcMBGLbhva0qtp8dH1BGQt+7Pheu4H+6htJaW+qTryiC3PUyKC+t9heUgnIwtI8
         bD5R35fuC/4jGvh2py7v5s38sjy2nlJVJun5w2LQqGTraWEgNsu1tWzCpr8UJNNruS4j
         EDYA==
X-Gm-Message-State: AFq9FYJe7nzXMk9JrvROdMfMxjPPe82bX2WYRgacHlew/iao2ffEDK4W
	Aucb8fsLe4cTEIeANdqfriMYEBTpEWjrAa8vct7q3seepxx5DrXMUA2NX3rMXFDSkGTE/YK35jy
	9vsa0QciE2pq37BlsJZkCxg+i0aKNcvDDgdGaeCAs8MjnArqUmhV8CBz1B6ES/ge7I9piAd26F1
	VGYnwh+uWkKR7/AgBoa/sqS+Oaa7OotkZKH9nW3TEsN58VBQbJYCM+EzAC2qnT2gln9NPR7U1k3
	UbEcH3cC2xH+ur93aQ=
X-Gm-Gg: AYBFou0Rkfe467dIF+ncF9gsh8AbIgVxeaZL183trYrEJAaqDsfUKth3YYcbIF1+OkB
	fb472WDe5rRfZkaDVrJwCdlPp2Mxm1M91h+h6F/2u/UiDDyfgdmWZpb2BFPhlpxpEGQHOYmbwPR
	nwFuWFBu15FL65HoKM9qfvaDrKfc0Qmk8KGL5k1b+f5QZWjM8timpWv34tZbibXC0yjinnop6vJ
	+5Yu1J3FLLv6mrtgD4PcRsN98jxdFsYOpzNLnnksicbR4WdjxMfpZ0SRMtj/2gM1EWSkJjeL4UA
	BdMfyUOZK46VU/sXeLQfy+VxvI/d8YPmubzPwMayuM5zyY6XjkphmMn/RpbcAh6JjG2/AJD/iuV
	WK0ePNg5L5bihYErpEBGyf94WmPOSYDUNgf8OOu3DrrmiZ9CiYnbOJqGdQ3yr6IQb+E/oV6nUPG
	24zXUfgMJOBBngq4ry9RNbe5UVHa1HPXw1GIswKIgi
X-Received: by 2002:a17:90b:380c:b0:3ac:7556:8ee6 with SMTP id 98e67ed59e1d1-3ae897eada9mr2727213a91.16.1793394997471;
        Fri, 30 Oct 2026 14:16:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae845878b5sm2823907a91.4.2026.10.30.14.16.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:16:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso2082957eec.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394996; x=1793999796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5pFLRxCJ/yA1VIBBqBPBGRLvkDsq4oo9CE4KjMa/p5I=;
        b=IiiPrFOeY9SPHKlauCBrZcciTkUSHN/I5/MhwczVe9wcaP5D/uq0d/1jZT7wGzoKaR
         Jp0lKwOw/Efk0eUAl4qYQ4S0+GP4oqn0YfBw+h2W1t7iWBPuQ/N69fUsY79A0g8GvYFQ
         BdmN+C9xlggTCty3i4mbH3mVbj5mpjQzASNLU=
X-Received: by 2002:a05:7300:7b81:b0:351:7ec1:a92c with SMTP id 5a478bee46e88-36a42431768mr7245440eec.28.1793394995358;
        Fri, 30 Oct 2026 14:16:35 -0700 (PDT)
X-Received: by 2002:a05:7300:7b81:b0:351:7ec1:a92c with SMTP id 5a478bee46e88-36a42431768mr7245363eec.28.1793394994513;
        Fri, 30 Oct 2026 14:16:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm13513535eec.16.2026.10.30.14.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:16:33 -0700 (PDT)
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
Subject: [PATCH net v3 8/8] net: dsa: b53: fix mirror port encoding on BCM5325 and BCM5365
Date: Fri, 30 Oct 2026 14:16:17 -0700
Message-ID: <20261030211617.288562-9-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030211617.288562-1-florian.fainelli@broadcom.com>
References: <20261030211617.288562-1-florian.fainelli@broadcom.com>
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

BCM5325 and BCM5365 use an 11-bit bitmap for the mirror capture port,
whereas newer switches use a four-bit port ID. Programming the port
number directly can select no destination or the wrong destination, and
can select multiple destinations. For example, port 2 requires BIT(2),
but writing 2 selects port 1 instead.

Use the bitmap encoding on BCM5325 and BCM5365, including translating
logical CPU port 5 to hardware bit 8. Apply the corresponding field mask
when checking for a conflicting destination, replacing the destination,
and clearing it after the last mirror source is removed. Keep the port ID
encoding for newer switches.

The ingress and egress mirror source masks use the same layout on these
switches, with the CPU port at bit 8 and bits 5-7 reserved, so apply the
same translation when setting and clearing a source port bit.

Fixes: ed3af5fd08eb ("net: dsa: b53: Add support for port mirroring")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 40 +++++++++++++++++++++++++++-----
 drivers/net/dsa/b53/b53_regs.h   |  1 +
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index c2706c2e643f..c320f53b41cd 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2544,6 +2544,31 @@ enum dsa_tag_protocol b53_get_tag_protocol(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL(b53_get_tag_protocol);
 
+static u16 b53_mirror_capture_port_mask(struct b53_device *dev)
+{
+	if (is5325(dev) || is5365(dev))
+		return CAP_PORT_MASK_25;
+
+	return CAP_PORT_MASK;
+}
+
+static u16 b53_mirror_port_mask(struct b53_device *dev, int port)
+{
+	/* These switches use a bitmap with the CPU port at bit 8. */
+	if ((is5325(dev) || is5365(dev)) && port == B53_CPU_PORT_25)
+		port = B53_CPU_PORT;
+
+	return BIT(port);
+}
+
+static u16 b53_mirror_capture_port(struct b53_device *dev, int port)
+{
+	if (is5325(dev) || is5365(dev))
+		return b53_mirror_port_mask(dev, port);
+
+	return port;
+}
+
 int b53_mirror_init(struct dsa_switch *ds)
 {
 	struct b53_device *dev = ds->priv;
@@ -2569,6 +2594,8 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 	struct b53_device *dev = ds->priv;
 	unsigned int *mirror_count = &dev->ports[port].mirror_count[ingress];
 	u16 reg, other_reg, loc, other_loc, cap_ctl;
+	u16 cap_mask = b53_mirror_capture_port_mask(dev);
+	u16 cap_port = b53_mirror_capture_port(dev, mirror->to_local_port);
 	int ret;
 
 	loc = ingress ? B53_IG_MIR_CTL : B53_EG_MIR_CTL;
@@ -2587,7 +2614,7 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 		return ret;
 
 	if (((reg | other_reg) & MIRROR_MASK) &&
-	    (cap_ctl & CAP_PORT_MASK) != mirror->to_local_port) {
+	    (cap_ctl & cap_mask) != cap_port) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Only one mirroring destination is supported");
 		return -EOPNOTSUPP;
@@ -2599,14 +2626,15 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 	}
 
 	/* Select the destination before enabling the new source. */
-	cap_ctl &= ~CAP_PORT_MASK;
-	cap_ctl |= mirror->to_local_port;
+	cap_ctl &= ~cap_mask;
+	cap_ctl |= cap_port;
 	cap_ctl |= MIRROR_EN;
 	ret = b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, cap_ctl);
 	if (ret)
 		return ret;
 
-	ret = b53_write16(dev, B53_MGMT_PAGE, loc, reg | BIT(port));
+	ret = b53_write16(dev, B53_MGMT_PAGE, loc,
+			  reg | b53_mirror_port_mask(dev, port));
 	if (ret)
 		return ret;
 
@@ -2639,7 +2667,7 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
 	if (ret)
 		goto err;
 
-	reg &= ~BIT(port);
+	reg &= ~b53_mirror_port_mask(dev, port);
 	ret = b53_write16(dev, B53_MGMT_PAGE, loc, reg);
 	if (ret)
 		goto err;
@@ -2658,7 +2686,7 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
 	if (ret)
 		goto err;
 
-	reg &= ~(MIRROR_EN | CAP_PORT_MASK);
+	reg &= ~(MIRROR_EN | b53_mirror_capture_port_mask(dev));
 	ret = b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);
 	if (ret)
 		goto err;
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 54a278db67c9..821ac74777f2 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -239,6 +239,7 @@
 /* Mirror capture control register (16 bit) */
 #define B53_MIR_CAP_CTL			0x10
 #define  CAP_PORT_MASK			0xf
+#define  CAP_PORT_MASK_25		0x7ff
 #define  BLK_NOT_MIR			BIT(14)
 #define  MIRROR_EN			BIT(15)
 
-- 
2.53.0

