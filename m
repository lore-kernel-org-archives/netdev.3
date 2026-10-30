Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394847;
	b=n8hYn6ft//6Qu5AqSWJxEuEtStefWp4r26bmebNeH0PmnCbqiBsg8H81jfk+NNFkYj2e
	 ywFFh/ebHNH5TKoeCE5uq/uPxdIXII0/AGf5Bxezvit3X5I0RMFSbSA95BoYsKhXHyMFq
	 QU24yADFfYGG6ut7D70jnz2tW5Z91xlLKmoeErp7E4lG+2QrUzlJR5zHGQ4tqQNhfcY6Z
	 6WnD10gnx8B2cUaBvql2zS+BbNP1pecMnmIl/GIvsPGlLTR89+rMrBdfBa+zk+pBGYvp+
	 CcgMtE8PSVkFhzpgHL2eJHVqkWkDtu7mmMWn9XhUo4xlu2nLUuzutz76KbN7hgvcfKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394847;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=BMM/lKLw4x9WcDyTwN7IVkv5KR6mnIRrBacIydwUBoc=;
	b=Y24ruhOJ+1XnoJcQng1xTmm3Z0VyXZnW+4OLIFuIRNdGHe1/70hF+3f7QGsQowPu+Yti
	 rdUiI/rSl3wY1B0Qv00Li+/a/omZ1U+WtoifeezUOS4Vtd23dldGS8YOBaKFicNQhj8if
	 Eaxw3ZvoMcql+vrsD0Cp/Ls0RvYNQoydaQAOra+oGW5KiA2msL0uB0c7XP2XlWPLcda7F
	 T0iIfgKBKb+NbUiocBh8XIvm4eo6SqOypfAA+6KQkxsRlhmFk9phq25jQW2opTZQp7Qbl
	 Os8slTonSZ0rMp0/OCsTwfC9KMOHvDEpgqIyRQCLzXMYG0FVkHjYB8YAArAsial/kkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="el/T2PL2";
	arc=none smtp.remote-ip=209.85.217.98
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C33B60A3807
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C33B60A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=el/T2PL2
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-7cc013095d4so327984137.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394846; x=1793999646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BMM/lKLw4x9WcDyTwN7IVkv5KR6mnIRrBacIydwUBoc=;
        b=cKrVfdi623BgqXu69YUCiGaOihJceAerdy6VrNej4jtM0cv5m3dnOvrumgwqXMEGFN
         qpwuJJ3X4DiOld+U3n/zKvjuWVOBjtXy0ubyRomdAqa8kus0MDcZNfg/hQtEksVMwvOi
         1nO9L8HH1xrGG3/7VTnYq2FGScNb0Fw3vtl57+QT8Wt6Xu9LPnb0RzWrCPRQ/EiEoNtM
         ZxfMzLbQoH+XnG/9tg9U5fZIaO6aGHUEaA6pXy7N8sHWuMBZh9QiftxZOxV9BYhJMUUV
         g5fALVvTqRH5dDYs3tKVLV5p4ZcK+lolSAu73biYiqaN+y2VLtOEwWgf7d7aVWtG3Gxr
         7tVw==
X-Forwarded-Encrypted: i=1; AKwUvBxgCphZEF7s+Jbiq4aBk7NixRX2zVmSQG7iHIFXfxAuGYfP6nBWfcayh37astoQOqVOTXPrY4k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjuHM+d+TGFY0AdhUaDQP3+M0WTkthZePOmFtoOBuEFovH2RbH
	ObTkuHjWqelXw/tf3K60goxvnuiKKfcNj8L1LOxhXMCblY5sJ4eaXMzxuZHt3/4pJa75lejhf75
	pME7U5qLuF4FkRy7G8bhnEwsgzL5rEG2SR53yMi+9LCU0yuxhLygbHwri3YmistCJr+BKld36DU
	53kaqV2ecHH04Cmww5k7Ql0+yvdq3tDVFYH44Q0rsBRnz/s45a8LeR4ZfYdEYdZYEWhJJvoto2+
	K0vtYSzotXUigSD9GY=
X-Gm-Gg: AYBFou1dfjPM6eY/dkfRYI9yXR6MfTkoJfwsULkG3Ko1v698preAxKFdgJ0E0sQ60sz
	1DYRgMhvj0+zWCl1tgCg6s5/PVcM9Xlde7wnuNkq4fX60AXyO7AWA1usDMwJcSbKXzAznxVm3HB
	lymjANhJZe07iTel27IeZT7hB5ewDijO0aHJ8QnLKgkqDhhKk6MA6wDN1SVIa01iBrlau9k2IY0
	8RBoeCyZKNRgbxrgqZtJOLKfXUWeMcxIiGmSL7fAN3AtVPW0M2mxb0DIZlKdzW4s+Ma/9jhrC0y
	p4Z+7EickBy6Ap4/JslpWsnWsl4Q6JIXOW8F1qcMmEfeHgMa3iThASJCvBa0bJKnRCDUH5GxA/o
	s79Cuk95+jwwiOVO/e3wHMWM+rVYKaCx2dj0vutv0q1Za3Tdhe738G0Fhh5WR5TV/I1D5NhlSCL
	i8w5N+lqRDI2+g8jE7OBhHSNaFu48fjYBJMBbTAmud
X-Received: by 2002:a05:6102:578c:b0:7cc:1f46:65bd with SMTP id ada2fe7eead31-7d072c22993mr1801045137.19.1793394846306;
        Fri, 30 Oct 2026 14:14:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-992ee3b1f0dsm120259241.9.2026.10.30.14.14.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:14:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35c3c370b17so1922766eec.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394845; x=1793999645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BMM/lKLw4x9WcDyTwN7IVkv5KR6mnIRrBacIydwUBoc=;
        b=el/T2PL2HomCZPffzNnABTgxutKRKzF8N5SOmwTc9I5YIJPsfKAG+ejniPHH/+khTW
         v/kKjez5v5mt1NhNrMV5pP4W7z0RWoXej0QJVQFXkOqSO1xEUR7IczqvC30OjV8Ctp9/
         nwMA34RDwhjpEAtXz9AMYN9Wi87nUorqxCYac=
X-Forwarded-Encrypted: i=1; AKwUvBzRGtLq4Z0gNev8Z0Qf8Wg9Ry5mYp5eL05esZ1HcgeTWwHGicW/vmncDei82Fkqp+vyl+oU2Wo=@vger.kernel.org
X-Received: by 2002:a05:7300:5988:b0:369:ef92:bd7b with SMTP id 5a478bee46e88-36a42426236mr4904969eec.41.1793394844856;
        Fri, 30 Oct 2026 14:14:04 -0700 (PDT)
X-Received: by 2002:a05:7300:5988:b0:369:ef92:bd7b with SMTP id 5a478bee46e88-36a42426236mr4904932eec.41.1793394844236;
        Fri, 30 Oct 2026 14:14:04 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42669128sm10574595eec.3.2026.10.30.14.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:14:03 -0700 (PDT)
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
Subject: [PATCH net v3 4/8] net: dsa: b53: reject conflicting mirror destinations
Date: Fri, 30 Oct 2026 14:13:46 -0700
Message-ID: <20261030211350.287566-5-florian.fainelli@broadcom.com>
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

The mirror capture control register selects one destination for all
ingress and egress mirror sources. Adding a rule for a different capture
port currently overwrites that field and silently redirects all existing
mirror rules.

Read the capture control before changing any source masks and reject a
different destination while mirroring is enabled. Return an extack which
describes the hardware limitation, and propagate a failed capture-control
read rather than making the decision from uninitialized data.

Clear the capture-port field when the final source is removed so a later
rule can select a new destination. This also fixes b53_mirror_del(),
which tried to clear the destination with ~mirror->to_local_port. That
only cleared the bits set in the port number, so a stale capture port
could remain after the last source was removed.

Fixes: ed3af5fd08eb ("net: dsa: b53: Add support for port mirroring")
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index c38e8c5838bd..378f47e7250c 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2543,7 +2543,19 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 		   struct netlink_ext_ack *extack)
 {
 	struct b53_device *dev = ds->priv;
-	u16 reg, loc;
+	u16 reg, loc, cap_ctl;
+	int ret;
+
+	ret = b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &cap_ctl);
+	if (ret)
+		return ret;
+
+	if ((cap_ctl & MIRROR_EN) &&
+	    (cap_ctl & CAP_PORT_MASK) != mirror->to_local_port) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only one mirroring destination is supported");
+		return -EOPNOTSUPP;
+	}
 
 	if (ingress)
 		loc = B53_IG_MIR_CTL;
@@ -2554,11 +2566,10 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 	reg |= BIT(port);
 	b53_write16(dev, B53_MGMT_PAGE, loc, reg);
 
-	b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);
-	reg &= ~CAP_PORT_MASK;
-	reg |= mirror->to_local_port;
-	reg |= MIRROR_EN;
-	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);
+	cap_ctl &= ~CAP_PORT_MASK;
+	cap_ctl |= mirror->to_local_port;
+	cap_ctl |= MIRROR_EN;
+	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, cap_ctl);
 
 	return 0;
 }
@@ -2595,10 +2606,8 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
 
 	b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);
 	/* Both no longer have ports, let's disable mirroring */
-	if (loc_disable && other_loc_disable) {
-		reg &= ~MIRROR_EN;
-		reg &= ~mirror->to_local_port;
-	}
+	if (loc_disable && other_loc_disable)
+		reg &= ~(MIRROR_EN | CAP_PORT_MASK);
 	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);
 }
 EXPORT_SYMBOL(b53_mirror_del);
-- 
2.53.0

