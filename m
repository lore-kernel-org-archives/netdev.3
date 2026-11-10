Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282646;
	b=DVfkDTyE2lBvUNP3eYgBMmeJIu5oDc4o/S7Q4Yn/F/vQTZbQzLdgLR9a36W6fXeN9/4U
	 FF8HXdn63DCd0cKElyhHQQaLzZgYdtKaSKx1e2IVC0mvtdj1mS840+paEi6mdEU+k35r5
	 9iTsyj5I+KZJk1I6LO8kaE6i60n69KViJsI75erzVXOJ51mY5mkieCvv7X6TgaWJb0X21
	 BUUxRjxzUwKlBbGSUWVP0EIhfLak+0+ojdI+ImbsRyEQQ51g6DYjObDPS8RDYtDIHV1gt
	 SZDqxHWcwbfoml2ZUmLJKP+FNXeJOcIyfK2tKu07I+R/n4Cv5CNz3tsfnAkzRcJDLHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282646;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=LzeYtQeHYIVthg2hHB9w5Dkr2DnAfEy/jz5r4BF+vDg=;
	b=iQqEgp0OqXPEN7W2G22M08rWKxJNENeluztC+USevfJmfpdGLlZhFwuDz+yirR7M8GZ9
	 uTL8SUJWA1H/UVPKGUWKzNYi+/pZBq/CzdqPcajlkku/WuD6b08XgUFNWeqxOYcoQTGnq
	 cxUNjrHBbdP6JWq+OSyLGhRbKK6qH/5L2EQawFPW1nPgKApqWFCTmS7zqeED6LtTExuP8
	 Yvx3gBM9xB8npEq2oLLQVLqGnwrQWm8cIe2QPVY8ycHwf+KLvkmIhTv9P3t6QxOyA5mB6
	 Y700azGQhW2ay8Fy9AOU1wZ2DJRj334tyt1bMfL/46fXrQ5IH5RhZmt//9hPISuoZ6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WToQpwPP;
	arc=none smtp.remote-ip=74.125.82.226
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C32760A6F50
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C32760A6F50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WToQpwPP
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2721950eec.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794282645; x=1794887445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LzeYtQeHYIVthg2hHB9w5Dkr2DnAfEy/jz5r4BF+vDg=;
        b=HDuHQgImDJX6mT860T9okkCyELYsmobq8YcOeLgSrrErUHFBWzUNBWpdMDppw/BJ+m
         Sa4fOoMweZ2nBPu6fZn4e6jrxlzYg+fTsDnIftOIiZ3uGFRa4wDxiZSIlPwkocNhWTx0
         TYuOHVsJnW5VaTzpCF++M/FF/QlXS3+6B2rid8CGBXRK4SIW+V6FlSyJ1atZ/7s4Us2j
         cXcUvsfjNSTkBwNphFoAWzd6pim1/L9xJFbHdPOK5nZJhkGrL+k/3Rs6MWC410AIt6Mj
         9f+U/xVVzl1KRibP1p6bDqKRjN9KYkIpZAdaXx1SdIO50um//RiNb10eQuZEipopIj5x
         Hz3g==
X-Gm-Message-State: APuU4Z9M1FPz6d26EpIg29JCX349qSAtsm7As09SE3Wmd+YwCBRDZSD9
	cSU4KFHcH9DPUM15ZXIEgerOynMYtCemnC9ChkUwBDsvYluvnzzWKHoKCjwSBR8Ijo5fYQeEb1O
	v8LocoG0XfknyfB/cNrKyxeuvH02S3vEuSQgl0Xx2MxFzhZDZmFmjNn0N6wurasB9M8g7s9TD3B
	RMfFiIAbU9briigciAQwbvorGhoFUTasbNJ8fj7+tOJzoZrv5OPU69CdIFcutUHZHMGdfBSnoeM
	B1jn0JTHdJm9XSx
X-Gm-Gg: AYBFou1iE6OWTp90vqPLSuzlncCr68wDxTmmLHSF3d80OtiuOSToTrjQOt056Z9TEpX
	KwJXil0p0KODeLeTEQXnWXPnX2Yscy30kt6tVHTIgc5gdelvpBHYmw0UYbUhwpdhUpRmG0NK1mQ
	qdCaFniMOZHERT8u42hG+VemiM22060dqu0JERrFSMGcPWKMhlwVHNwTX+6bGX9uYMdoTuvaWFG
	Gyp4Y6c4WiEIK/e9sHX2jA7XDTWvWZCZVNW995c6JmxU3jTdl2FCVxNFlRl339htoublF3pwguy
	Ujy2gUtgdoX01UvXhOKMHMYu9PCQuKWXZiiELveU7PABDgRxgUn5E7bM357TlP5mgXU2m55oM+F
	yX5YPgr/ln/tIheiJcuD+STWijxpnHawAtrEt1VlOVxwp9LsbIN0LFup+ZmHdCXZX0rNRvLI8mP
	ZMMjvb9n/bRIBJBuNSfpA7dxN38PAb7QFF3JDK917a
X-Received: by 2002:a05:693c:41d2:20b0:36b:d3dd:2e9d with SMTP id 5a478bee46e88-3751f078fd1mr1722037eec.19.1794282645319;
        Mon, 09 Nov 2026 19:50:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-375217c1c65sm13254eec.29.2026.11.09.19.50.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 19:50:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5383d650f2dso34113351cf.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794282644; x=1794887444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LzeYtQeHYIVthg2hHB9w5Dkr2DnAfEy/jz5r4BF+vDg=;
        b=WToQpwPPiE+bdCr3yitPpDfa0eiKHIu1fU0lw+6yCvs69aLaolrnNu1N/90aXUE+tT
         UcVfjGPNuAFlVsa4ehT/5Wyd6P8ezIJr9daMSh0Q9zmGT7vX62K8i8NmqAR4ucfWgzzX
         4ugksQc898E2LT0OpKiCL/zzzlJKDi+OIqzA8=
X-Received: by 2002:a05:622a:4d43:b0:535:a5fb:645b with SMTP id d75a77b69052e-5552a16cbcfmr20330581cf.70.1794282643825;
        Mon, 09 Nov 2026 19:50:43 -0800 (PST)
X-Received: by 2002:a05:622a:4d43:b0:535:a5fb:645b with SMTP id d75a77b69052e-5552a16cbcfmr20330281cf.70.1794282643171;
        Mon, 09 Nov 2026 19:50:43 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550af612dfsm13740951cf.8.2026.11.09.19.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:50:42 -0800 (PST)
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
Subject: [PATCH net v4 8/8] net: dsa: b53: fix mirror port encoding on BCM5325 and BCM5365
Date: Mon,  9 Nov 2026 19:50:18 -0800
Message-ID: <20261110035018.2169370-9-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110035018.2169370-1-florian.fainelli@broadcom.com>
References: <20261110035018.2169370-1-florian.fainelli@broadcom.com>
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

