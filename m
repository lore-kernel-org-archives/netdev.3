Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506645;
	b=apUkAhmqv3JZB/UFvmmF/PnsygXiN/eaKDqiUweYBQHoeEDWQCJxDYxhrq4M5vvsw9Lm
	 SEfMqD2PCGB5SwbU6VNFQnQFc2z/I3tVjGD8ggRmEOXN38eS0U0ftMqHUc4dpsV84xzFG
	 MWYE21W8mwkDMWy/BNcm8YyMqHy0a0dqsnKIFik5U2G6L6v/6T1bmMfd7GqbEMs6ALvgc
	 jfxdPoOs0ixBRrA4WRAIBhZuZWlhYV3AanzS7RavWBbg/kOkLwZws30GPjnjIcDpLRLss
	 Mqq6oC4LKq96kbLlLFGbNRmj7x9BlQO3uboAM8C0lMD3f5W3HTXWlbRhOlf97B1Y6Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506645;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=LzeYtQeHYIVthg2hHB9w5Dkr2DnAfEy/jz5r4BF+vDg=;
	b=bCPXVL4WyM3qXvS6wplDr4PHoAp62mcNJKgb7+pasUhU9xPSZT4Oa7KfYEQZpXkcnd/1
	 1awHfPiTKbEAvsJ9W0yftPT49Q7SYciTPUVzwpPt/McTdC/ijpQdradgHCsyzwvt8rCvE
	 VIFzBT5mmD3CGeYvkw7VoOLIM6eHzrHxf7K4osdS71alNWRu9AOqGJ284+Mmn/CXYdmKN
	 uayVS7KMaEI9tw2YJe/ifBueCSe5TW+dY6FAuX9K6hvbLQmMEd1AzvD5cZqmEgwCBuHgu
	 4QYxBrVOfmlqVT6y6JsD+vLOYYTJbpDUyoU+w+Sc2EJVkHlqYGOgeEy2GwKckPHU9hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hcDIt0Ch;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5249760A5BC4
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5249760A5BC4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hcDIt0Ch
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cdb684859cbso88611a12.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794506644; x=1795111444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LzeYtQeHYIVthg2hHB9w5Dkr2DnAfEy/jz5r4BF+vDg=;
        b=Bfu7uwsePt55C1FWUuZv3NpVJp9ZKB8qd76IkzeokgxwuvNPq62bfvaatH8ddk4uu7
         Gl9Cz8d3u50ldVaBebcRfiX3hf5G67XkUMKNh9YDfLF9E3Vxlye1B3ftyGmNfN/mBa7v
         pry53ZrlWlw+NKqR2Dj+bhZzWefbb7j3OmRU14aiNMLauPphhLshicAP010fGB3pAOJv
         nUQs64rqTInMsPxMqTl0QhSYgJjJu3A1CCOGCVkqOnbhUTGMfSWCyH90iKT0aWcSrOWR
         s5cRFX8noBUIP4PqAtWM4vZumufvi5gKMh4934hq6y6eLI8Hz7BPjW21R12QgfLRsOuT
         Q/RA==
X-Gm-Message-State: APuU4Z+Vuzfasp1S81ozBAMjbeiGw8h0bP5K+D23n5R++UUMfu/+VVTo
	sXpmMkZilnh1idbFP6fJMaO+N1+D+fgQgQgqNkHxsClapFhnx3dJEOhnDn2UIO/u95b/hoGwMGe
	oSduLs112xoRnyXR04s+dBPdbww0MKjSGdloyvbgnSQmT4boYzegGwcSvak43TzKQE3vNJOYuwJ
	Oi47Sk1NBHi1ClQHmIu9QTLeXYTlatrrtKr1FZ+yReVhpoA7TWG2FqYUrvwNp64v+U6P3/EoxgX
	GQ0AlWTRrgv/a26
X-Gm-Gg: AYBFou1mxB1NTzvx+FZJBb2NkoQoIe3rxrhmg959PfODxPXwjqs9eCirbMED30Rjgq/
	/OreE5sxN0h0jP156FVoqilRqvB/I/78dKt5m+vnduy+4vGyZbn0njdsEkE8k1INJV+z/15xzlE
	EbHbLdWutgzcvzzd8ilo2K9s5PIDe5+IQEDOiFzwmuaJwMoLeP2ExTOZLAOVtcVdYr8HJ5oEp4x
	sR8o5bsSeFr07f1FhaPjOKfDPLblcqao3K9OoyPnE4taQYQxpmzY17ZUVumhjOFMqaEdSlWE1Db
	/bfOwaQhlbsQGZ5G3K2FEQ37VJ+Wbmi6QEs5k6RjzhSbA9vNJo8U0XZdDLYUC2x6PfdrtOvtGqG
	6E75tUj5nK+vdVNIVE6GIsnkTUzFpLaZlZDxJbip9x5+OrL17JT3rGUkaLT7LADqQoxL6zkOKGh
	S0WikdwXHpR4nEfwNi3vcTYMo3Gy/oLW8sjJSzXORa
X-Received: by 2002:a17:90b:4b0c:b0:3b1:4eb6:b3a with SMTP id 98e67ed59e1d1-3b182defaedmr6138183a91.8.1794506644385;
        Thu, 12 Nov 2026 10:04:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1ae999e55sm333993a91.7.2026.11.12.10.04.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 10:04:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b191f8a9b3so53980a91.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794506642; x=1795111442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LzeYtQeHYIVthg2hHB9w5Dkr2DnAfEy/jz5r4BF+vDg=;
        b=hcDIt0Chs29LshaTx1MBFuNTfKinj20fv/i1REig4dkLgxjp+LiflBoA6lLqL8wK4A
         6DVvK/UBlqHOCjY53/apO7ZBnRk5AgeCDYwBZWWvMklBH3R1u+oMB3GO01ZVsUfediF3
         Mi5oQVxXx48oMTm4RUZvUUJ/xFPU2+l7zS1No=
X-Received: by 2002:a17:90a:e7cf:b0:3ad:13fe:41ba with SMTP id 98e67ed59e1d1-3b182f0d331mr6271084a91.52.1794506642343;
        Thu, 12 Nov 2026 10:04:02 -0800 (PST)
X-Received: by 2002:a17:90a:e7cf:b0:3ad:13fe:41ba with SMTP id 98e67ed59e1d1-3b182f0d331mr6271047a91.52.1794506641708;
        Thu, 12 Nov 2026 10:04:01 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18abc06sm95004a12.22.2026.11.12.10.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:03:59 -0800 (PST)
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
Subject: [PATCH net v5 8/8] net: dsa: b53: fix mirror port encoding on BCM5325 and BCM5365
Date: Thu, 12 Nov 2026 10:02:02 -0800
Message-ID: <20261112180202.324504-9-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112180202.324504-1-florian.fainelli@broadcom.com>
References: <20261112180202.324504-1-florian.fainelli@broadcom.com>
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
 drivers/net/dsa/b53/b53_common.c | 46 +++++++++++++++++++++++++-------
 drivers/net/dsa/b53/b53_regs.h   |  1 +
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index a2d46cceca47..5bdf9cf147b3 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2608,6 +2608,31 @@ enum dsa_tag_protocol b53_get_tag_protocol(struct dsa_switch *ds, int port,
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
@@ -2631,15 +2656,15 @@ int b53_mirror_init(struct dsa_switch *ds)
 	/* DSA retains matchall filters across suspend and resume. */
 	for (port = 0; port < dev->num_ports; port++) {
 		if (dev->ports[port].mirror_count[true])
-			ingress |= BIT(port);
+			ingress |= b53_mirror_port_mask(dev, port);
 		if (dev->ports[port].mirror_count[false])
-			egress |= BIT(port);
+			egress |= b53_mirror_port_mask(dev, port);
 	}
 
 	if (!(ingress | egress))
 		return 0;
 
-	cap_ctl = MIRROR_EN | dev->mirror_port;
+	cap_ctl = MIRROR_EN | b53_mirror_capture_port(dev, dev->mirror_port);
 	ret = b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, cap_ctl);
 	if (ret)
 		return ret;
@@ -2659,6 +2684,8 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 	struct b53_device *dev = ds->priv;
 	unsigned int *mirror_count = &dev->ports[port].mirror_count[ingress];
 	u16 reg, other_reg, loc, other_loc, cap_ctl;
+	u16 cap_mask = b53_mirror_capture_port_mask(dev);
+	u16 cap_port = b53_mirror_capture_port(dev, mirror->to_local_port);
 	int ret;
 
 	loc = ingress ? B53_IG_MIR_CTL : B53_EG_MIR_CTL;
@@ -2677,7 +2704,7 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 		return ret;
 
 	if (((reg | other_reg) & MIRROR_MASK) &&
-	    (cap_ctl & CAP_PORT_MASK) != mirror->to_local_port) {
+	    (cap_ctl & cap_mask) != cap_port) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Only one mirroring destination is supported");
 		return -EOPNOTSUPP;
@@ -2689,14 +2716,15 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
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
 
@@ -2730,7 +2758,7 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
 	if (ret)
 		goto err;
 
-	reg &= ~BIT(port);
+	reg &= ~b53_mirror_port_mask(dev, port);
 	ret = b53_write16(dev, B53_MGMT_PAGE, loc, reg);
 	if (ret)
 		goto err;
@@ -2749,7 +2777,7 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
 	if (ret)
 		goto err;
 
-	reg &= ~(MIRROR_EN | CAP_PORT_MASK);
+	reg &= ~(MIRROR_EN | b53_mirror_capture_port_mask(dev));
 	ret = b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);
 	if (ret)
 		goto err;
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index cfdb5ed38326..ee049927a63a 100644
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

