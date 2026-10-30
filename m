Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394856;
	b=a3Oscd1oDKnJSboDPdu+9vGjwPI86Y5JUnCbVMRMewFN8ENwxG8c02rTpEinpwoDQ2z+
	 dlJnU8UbvI+4CVMY951Lx8GJEI5CUlzRuO/Go66uOQo/v9Wje/E9alsJ9Os2Rt8XLTI40
	 HA+vGyyQnxsX7IjMrk01k0yIr1hLLceNBOiZ2o98EVPJxDU8M/VcvYkG3XL2CY69WN3RG
	 uB/jG11PVJPRgE+TPwfkQMpbnjwc1aAMybUVxC88BU0xIdu9PCXdJn8IaDPo6C3uFiJTG
	 9IBB1EQxy/8EOxwefH9bIr7JEVt49qIrzEqWw/Efep5ZK0c1ETeHnUzgAc9tK3CDiDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394856;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=5pFLRxCJ/yA1VIBBqBPBGRLvkDsq4oo9CE4KjMa/p5I=;
	b=WgO+IP3xWIcoJJ/raKAX24I6b8w9Db/mF/805LPukqOutFF/Dwe+g69RJM7vrCtGlRhw
	 tVOF1Vxx073JwjV2NvbFuRjjtM2hAaSKIRwH+/ngrGuqZrz++FEsoFjOHQcYZ+X1TTpQp
	 v7QdyCiSGoU1iucLzdS+KQUfoXeNgoe5k51sMzp7Vd0dW3q8k2h3LmjLLDF/dVNeHmHS/
	 BsaTkFaK1PrgnbZ9o33A3m2KcegYRJkTTmhVmlytWVVWvBqnA7a4LdUiSm0AJPI06VjMN
	 Dd/ROIGvVQIAv4gjYW4QhUJI9IMsKxXL+fYFdGUkCqcGIZnQ3CiSwNRhsGXNamb4mtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HW5InC7m;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1CB606A31E
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E1CB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HW5InC7m
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso805020a91.3
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394856; x=1793999656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pFLRxCJ/yA1VIBBqBPBGRLvkDsq4oo9CE4KjMa/p5I=;
        b=kuATNJeBfeVGjNduvjJj4nz+AHjbZU3F59H0CsJYFb/jUKsA6USdcMcdET1qjhsl3r
         nnBgzhBDRXxwsR1j2xBtFjszvn69/rY6MtVOYBizFarNRWNEJbVX6En1/11ugOrXAn3g
         gGen1b9mRSh6mHgnLcNQrxYWTiPYHFwP2XbjUlWxgOAg70so0f5LGSi0bCHm13Dg2NXb
         kl4WZ96Cb+g7odEsPFsSTuz7rv4TPEZuKSdAOjPI0CSAOsut/uTkzSwas0j3qM9NoUIQ
         tlQdWzp1q0hux9KjFXWxtNBbm1WDht7vMrFT/VL0xuob+NwIYwZHiRy7jHeOIqPtKx0Y
         Z5eA==
X-Forwarded-Encrypted: i=1; AKwUvBzjIDtfQCc+LVCqKzFRUaJDTzAnG1KLy58e2QZuLBDUoW4UJy4AH+IgelsVL53zQaAbdBBCLo0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaqQBcVL6xif0pPSCSOV+n/O8tJJfFNPFhWEWOA+KiWp8oS1mG
	/TVKuheg1sh8wp3XiN7hF3lq0EXZ0aeJg044S63hZ7BMV0pTn1f+nfyZKXXg4UO6+GfSmPDd2mC
	9X+3AwrOtVKc8nX2EkwmD5BL4xG2dS+y7SHfCFHgSKiWHODJi7y2TpB1rIxiNi6SokzrdEU8hR4
	q5iIWXcYHds/Tk9x3CwGIKv57DJermNeuXnKkl94iN3677DUMkU5xz8lU2WmePsTdCSLhE6sp0M
	kLG/NVSVBhC+08L
X-Gm-Gg: AYBFou3CZpNO4Nas/pCpb23WDBq/VUL9xnfePUNUvDkhrMUw4GzsQlLOaRiGrY6f68m
	bDV8VPNPf7CLViloKx0e0a+hKZbk9Q0vqc95YWUKSbvZx8VsvxXDv/1qmNl0h65qo9xmwwZLNaj
	IOMvXIlSv6fUIPfTLz3FH4aoXgWDqO8eFfPKO+gbk5tgHJgSw80Ij4+rsjfSLFF7+/QJHXe0/X1
	/f6gTxO3Xavd/roAUoYCFDj8N6FtfMpcxAk2cVfbbRJmt/guN51GlHGWhFOLD3C0/iwgm2Qtu/B
	n4jr9TnbVNg6DrrXsqqOW2q1WSbpiNh9BN0lGP/RRx+cWd3mSyBV3B4/a+jGn6LQvxhk4oTMLOW
	LLzYtQ+xNl1Ki84nsgCLHqRDAPHrcue1oO3U9XbIJWl64U/bxhV54v2eePYIpuWmMXPQLuAHklG
	kIjADv1MOIRDg6kbcTWJrH37RCXpYM51jVTHQ6AzxX
X-Received: by 2002:a17:90b:5485:b0:3ad:c482:ae9a with SMTP id 98e67ed59e1d1-3ae8957cc71mr2902955a91.1.1793394855565;
        Fri, 30 Oct 2026 14:14:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e84adc9sm4635201a91.5.2026.10.30.14.14.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:14:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3692c5b061bso3040071eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394854; x=1793999654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5pFLRxCJ/yA1VIBBqBPBGRLvkDsq4oo9CE4KjMa/p5I=;
        b=HW5InC7m/3RNELA5uTBoQBpmT4vDugbK/tTEc3yLRuaM00sGFk7XCC+bg4xFZEvABP
         x335J1I8Wtk8xdBHWGruNkEvztLFCln2PEl2HcotkgGYyNxqqxqpMM9HpT+tYvB7vlgu
         YFwa7LfHGjrVcqnE4+xQV62FmisrTFLTpZFKY=
X-Forwarded-Encrypted: i=1; AKwUvByBiNRId2ekjVD9wZc1XJA6+B4V+Rt+Hdg6FypzQMT/g3s86Ls0lPlSSeuiwc7A5sWiiYQgLC4=@vger.kernel.org
X-Received: by 2002:a05:693c:88c9:20b0:36a:18e2:64c with SMTP id 5a478bee46e88-36a4232bf0fmr5036683eec.11.1793394853378;
        Fri, 30 Oct 2026 14:14:13 -0700 (PDT)
X-Received: by 2002:a05:693c:88c9:20b0:36a:18e2:64c with SMTP id 5a478bee46e88-36a4232bf0fmr5036630eec.11.1793394852487;
        Fri, 30 Oct 2026 14:14:12 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42669128sm10574595eec.3.2026.10.30.14.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:14:11 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netde@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	netdev@vger.kernel.org (open list:BROADCOM B53/SF2 ETHERNET SWITCH DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 8/8] net: dsa: b53: fix mirror port encoding on BCM5325 and BCM5365
Date: Fri, 30 Oct 2026 14:13:50 -0700
Message-ID: <20261030211350.287566-9-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030211350.287566-1-florian.fainelli@broadcom.com>
References: <20261030211350.287566-1-florian.fainelli@broadcom.com>
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

