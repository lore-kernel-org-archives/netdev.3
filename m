Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394852;
	b=e0/ahZB5/zvzyjlXFXj6Uvyc8WPN5pJjZEfHIRLKymlKtn+OrSiJCiQbegA7tGCeB3XU
	 VB1CX1zcOuqvw8Pn7YhcTWVgDxS3TxfERzlY996gb1WxIx1qHN91VSH5qoXITjnDGP7P6
	 KiKgQgvuOIiEIxat44bG6Z2pefF2ZViEkn+4YaGDsmGPGkcMEJmWR4dbFITs0YVALS+jp
	 hPYqmse4vKZVdNSnD4eFUJBDBNmDRmvpuEeswUQiuqBIwxsS0/aRJREcQgWYAyUOBAzEP
	 PnaF0Mo0KtJd6nWajUEKPDIi7zSIn2RrilRcVKnHP0dTQBMQ4iCw0700a7gV6IZ3xKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394852;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=ElKf65BHYwDdwvUulRpr0xWtFKIs0F3G1kb/zWor7V0=;
	b=CN+Wx66DzZamo/5ExEpzLQPiXshUqU2KYFznvVbO7aCeGLvVe8vVBRikHSsUThHI6mxD
	 8gYG3LyeQ1BgQcl+jwBF9mgKXTxON6SXvC5FVURTg5GtliB7BcoLttvgvbYdGvDvMRJya
	 I9XHHS3QE6LNQT2Z6028hUU4WzQOBdZSkTKYLL5JyCP1xsiy0+DyRb0cWkuJXf/cawsNx
	 lrsEXlhaeWQa+9h/vewNTuCrl+cTep5fb/KMe7McU32N9f9HXoWMT5TNBIOIxkKIA9mLK
	 aVGaTVMe5XyHARbjcmQLRuePieIPAxpi1q8Ozsh9+wJakbj6t940BKqJza69ao7Q0LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Cy75qxHI;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F27460A261B
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F27460A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Cy75qxHI
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso543711a91.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394852; x=1793999652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ElKf65BHYwDdwvUulRpr0xWtFKIs0F3G1kb/zWor7V0=;
        b=oLKy6/gTcIevxonF2OUXNKEVYKy3q1mLCToop23XCSRRvTRwmN/5GF2Vij2UT54LA5
         GvmvF7ncbDEpwibEZkrFZvmWNK+mJrmHRV7F1eTM8OtjkeWwNDXb7lA5URafMJu3STq3
         jSaCc9HjMBDAzEp3GkqPASNDwzWNWvFuB/1AdmoDkph/2Qy7wdLPPU9KVkQ6Thnok5vG
         xAwNWhOvsyvBVikVJhBm58Fp1MEAklZWY1nES5xpFweQHn1BselQKx3LuUbbxm4ptBax
         +dZoCzTkxBBMR/MfbwnnBLP/gKlZpuTiBwjBDUDHaquLv6QplJxxq6IP5aj6QumRY4Ol
         KrgA==
X-Forwarded-Encrypted: i=1; AKwUvBzLDqq2+X1XA/g0ayVK4CYhH283uKYfFx28FNoLf72FsGRXauzM+JbE4w9MiNfEhbBrz7LoRPk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQWHK3V7Zi32vflZZqrV036qk/uVeJzrZ/qUGy4HnHPlyBB0/i
	B1TigF6+huYjAjK4rVD52MDpZw4GbspSMXB8i45MqRQFCKtsFEdiLM/CGQsPKgWCM5yNrtYd3NS
	XJuUXkN9Xbs3ZimPy7i6L9fWxa9lDFE9QIhLhuHlmgZqmM5T9AzwEKDqQaFRQv2jpe6znZ4bK/Y
	sGHQ1wFbId9dfjlGVjP8osnxCdXhWnNo0fw/It6JVhuLPIGOTzsmlnyMsvlbLXJtw97UqZqZk7I
	IWTzmvvEMi8fZgYriw=
X-Gm-Gg: AYBFou3sKktutzmlBEXqwy0IElsUtA+wRssg4jkACyZlILtzSUOvyiqHvL3QT01XeBs
	ny7QGX05QOSMIoJ5K7HgVtfyYSs4uwM31slD+94W4hvXQPbCksnp+b88B5KlJsSnqektUu/YnXo
	teQw3jDWkbf8KSegCdcVLoaZeIxfl3vJznRv0j0BBKL1K44+S3qxsc0GO5MD6ICb/VZXZO0f0MI
	oXyLW7AVENhewlDVIJYpx9n1GHQaPe8964cZBMZ68i+0VBm+61i0+FTO6q/kBmMyd/nrgx0nI89
	rrRo6+MJCZT2NdTvztPToYtDMMpZ4MwIqmdOjqJyjMWgQdtfFTgkrK/25/5H3fNpJfwVUmx4S63
	/Yp/4gRQdO6XJ/HFhK/hFIOQ7LwtYPSDjMWIJGMGRTjzyx6ZW1zoSLcDjF9jHVdrNdCBR/JPeUj
	zi1lywOiQSemQcdTAfMv0TROD5K0yNWAvvaoc1EI4o
X-Received: by 2002:a17:90b:380c:b0:3a7:250:333e with SMTP id 98e67ed59e1d1-3ae896f8315mr3109491a91.11.1793394851794;
        Fri, 30 Oct 2026 14:14:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae84587856sm2636902a91.3.2026.10.30.14.14.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:14:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36637676140so1682653eec.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394850; x=1793999650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ElKf65BHYwDdwvUulRpr0xWtFKIs0F3G1kb/zWor7V0=;
        b=Cy75qxHI4hJaXHHG1UQOf/JsSApX4RcwrAGFgLcUSCMM/DxHXCI1049PqOsJ2er02q
         5td6RkHGtRGqA5josKq8t2LCjemS/vI0CNHs+dQHZSONXLNAUZJW1/vHmCkWNJu6Zj6s
         ngukaa3I95/df2FT5SYVMRXWCgEBJXUDRtTdI=
X-Forwarded-Encrypted: i=1; AKwUvBxWfOECKVjohNyRXmBd2DC/9mUQwibTnSj8iYuarCQAZKdjPwQrr52c9f7cs/Qa4oFhe73dgIE=@vger.kernel.org
X-Received: by 2002:a05:693c:894f:20b0:369:d992:e3 with SMTP id 5a478bee46e88-36a4242b2ebmr4747161eec.32.1793394849702;
        Fri, 30 Oct 2026 14:14:09 -0700 (PDT)
X-Received: by 2002:a05:693c:894f:20b0:369:d992:e3 with SMTP id 5a478bee46e88-36a4242b2ebmr4747079eec.32.1793394848448;
        Fri, 30 Oct 2026 14:14:08 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42669128sm10574595eec.3.2026.10.30.14.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:14:07 -0700 (PDT)
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
Subject: [PATCH net v3 6/8] net: dsa: b53: reference count shared mirror source bits
Date: Fri, 30 Oct 2026 14:13:48 -0700
Message-ID: <20261030211350.287566-7-florian.fainelli@broadcom.com>
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

Multiple tc matchall filters can use the same source port, direction and
capture destination, but the hardware represents that source with one
mask bit. Removing any one filter currently clears the bit even when
another filter still needs it, and can also disable mirroring globally.

Track references to each port's ingress and egress source bits. Program
a bit for the first reference and retain it until the last reference is
removed. Keep the two directions independent and ignore a deletion with
no matching reference to avoid underflow. The tc callbacks serialize this
accounting under RTNL.

Fixes: ed3af5fd08eb ("net: dsa: b53: Add support for port mirroring")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 16 ++++++++++++++++
 drivers/net/dsa/b53/b53_priv.h   |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 75033b28100e..b16167c9510b 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2545,6 +2545,7 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 		   struct netlink_ext_ack *extack)
 {
 	struct b53_device *dev = ds->priv;
+	unsigned int *mirror_count = &dev->ports[port].mirror_count[ingress];
 	u16 reg, loc, cap_ctl;
 	int ret;
 
@@ -2559,6 +2560,11 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 		return -EOPNOTSUPP;
 	}
 
+	if (*mirror_count) {
+		(*mirror_count)++;
+		return 0;
+	}
+
 	if (ingress)
 		loc = B53_IG_MIR_CTL;
 	else
@@ -2573,6 +2579,8 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 	cap_ctl |= MIRROR_EN;
 	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, cap_ctl);
 
+	(*mirror_count)++;
+
 	return 0;
 }
 EXPORT_SYMBOL(b53_mirror_add);
@@ -2581,9 +2589,17 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
 		    struct dsa_mall_mirror_tc_entry *mirror)
 {
 	struct b53_device *dev = ds->priv;
+	unsigned int *mirror_count =
+		&dev->ports[port].mirror_count[mirror->ingress];
 	bool loc_disable = false, other_loc_disable = false;
 	u16 reg, loc;
 
+	if (!*mirror_count)
+		return;
+
+	if (--(*mirror_count))
+		return;
+
 	if (mirror->ingress)
 		loc = B53_IG_MIR_CTL;
 	else
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 29cca7945df7..910c71618d0b 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -121,6 +121,8 @@ struct b53_pcs {
 struct b53_port {
 	u16		vlan_ctl_mask;
 	u16		pvid;
+	/* References to each egress/ingress mirror source mask bit. */
+	unsigned int	mirror_count[2];
 	struct ethtool_keee eee;
 };
 
-- 
2.53.0

