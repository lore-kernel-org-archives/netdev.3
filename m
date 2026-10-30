Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394995;
	b=mAIbaFSzl6lUeKH7OrEUUxaQqCSu7U9wZD9kvNGT7TfATJ4BvC7/1RdfmZHBJLnoEJA5
	 236HOTN1UnUpn/qYyBMgO4JlfCWyWItwtt2IHqHPQsXesVcOZ67veIs+1AwLfvPrmoUxC
	 +PHkWetTX62CvqI6rMtizzP7fJU7RThDdpyWOLeQdyy8D3vdKc23vOCUSfHtarA4Tg5Ou
	 F3yVRRcGY6rS++X8bqjxo+bQxj8R0bSLzaFLUF8etKxGMQxeoa9oLcMu4j02GKhCYJzTR
	 hd23WP3C4QJY5snIRjql46CBhJ0bEPT7cKeIEvPKupGBRvnrpsubGVm0KObt4wym9JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394995;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=ElKf65BHYwDdwvUulRpr0xWtFKIs0F3G1kb/zWor7V0=;
	b=g7v7M1ze2riLTUdW1MouFpvvtVvsHU3kyyFFDHExp0ILdwcES6Cf4nm3OORSekQOC69q
	 ttIh83b3+Ieiqp0SaCOUsbnwU6x0oBUV6g5q3H15NG3L9GLmPnEGfHtzFCKAzQoJDlamZ
	 rhzOIBRwTRI+Sg6VnvR91PbnS0MXBNKIBDshzpSfN1go+Prc6v4qCX9WGdgFQfHQmBfO1
	 UjBB3QUKtj6ECxqULxQb3KmTX21bobNrsYx9bDO1ZdctkgldUTW0uCXwwtqHr9wJXSUs1
	 Ppgf0oLlfchoSb3nzVz0263zkIsLrgqUiRMw8ReClVEtuvcd54BOOuYYrVjYNjw3Y5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="dqDkOY/h";
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E960A3808
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 553E960A3808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=dqDkOY/h
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso803548a91.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394995; x=1793999795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ElKf65BHYwDdwvUulRpr0xWtFKIs0F3G1kb/zWor7V0=;
        b=dX+m3F+5HT03dMSfX9pfqPcMchv4rAPb4HH/x7xJTrUONPZz/EMPBdDl8WpOzitA3a
         KuCb8CAa4E8eo3zwd36WzJt2h7RsDHCTZ/nSlZgMRhB/59WvEEq6fSqIQPCjrvIjW1pS
         l/MNykHSCb4e5V31DPWx9w3TtEOxh3+yW6OcaydFovSWqljTVzyGJKmzc8s+90rhN5wr
         /6SwwwujieSHVvuQ/cvT/5Bnm3I03YcnW0BB/6Dom6oQrL+hJ6rHUYvpxi4A0Vyqzt66
         GAbMwg1Uh28fmDsORH8hDZPTGTpalP/kK9of7YuUPMVuhdwycTEFCcFQod/RdooGJocH
         6c/A==
X-Gm-Message-State: AFq9FYKd/EtW8NI6vhju8ul73BhPvlsrwtZeCJQJrpP+aL3u3eijREKW
	sR4LLGj4cLUkVIxdNxHorHIQpjsOeBZ7doHkrOcwXBw6wLOPhS7wBOOACbbBmd0jbw5knzoLw/z
	GswcR3U209glZS12ehzfECtbcK8Muyp4YFjbrwlFKZu29mQDm915bEv6j6N3p52z1vWh+qbk/WH
	P2p/iIsrtGTtn+ycbEJPu6SGIYPA9/K49C3Rb0/yuCWKlhTuv0STaBN2Ha+IoJnFmxJ6u+Un0/W
	45CsAF84/UXZsUCwh4=
X-Gm-Gg: AYBFou0NKnyv5RjTYumeJP3kuhDBKXBWGqBHrPzEJqmWSMxPCqN0EFo4gq/Mduj7QKX
	Lom/VriivNlPXTh0aXg4zDR0cF/WpAbkVeaNwzfavaSvtfQ2YNB3dOofn5wEoq2XHpq/ZwXazoU
	oOMgZ+LT95IUYw91SUtA0+i+nb6Amu/e7iR6l6uHtGOzuSM90MjZsC5RouGnI001QNelXcLozE0
	dRfprJtZeLgS7cwUjAgkMMm8uUVDEICTTFyIpcLRA3VzWpQDq+MUdZEXAFncNWTFo6cIRzC9JhB
	G0/y4KqbjuCeT3mEQLbOm9Xs7+wpd6iMaVa3jJ6BSnhnSZ7w5df0ZIEa1Xb8i1/w/ECAQw3cw9g
	udDLNl3erIctb+2M0UjHR1J8ZEIQHZ5wQiAJjE0tAtZahivls+U0xJrl/GoZ7vEkk+RWJBVn9Rc
	Zeuzcyt0BbMmjNoiUtmrQLlTKxYy8OsNyYPvwuC8+G
X-Received: by 2002:a17:90b:440d:b0:3ad:1b31:92d8 with SMTP id 98e67ed59e1d1-3ae89829890mr2874913a91.60.1793394994693;
        Fri, 30 Oct 2026 14:16:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae845f21dasm2638820a91.8.2026.10.30.14.16.33
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:16:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so2144993eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394992; x=1793999792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ElKf65BHYwDdwvUulRpr0xWtFKIs0F3G1kb/zWor7V0=;
        b=dqDkOY/hAcz3r+w+R9uL+EHlUhnohPS83FFXd3tGPX5P4BDnnHtRff0iouySzEs4P4
         uZYo82MjBGQi32gVkxuNkb3iN9quvYD3VBr/NMzaCkWjCsJWLniDhzkju/nd49rtr42U
         LtvbuAI2TZ+GZSXVwhORmQiFRjKNKQ0HWE8eI=
X-Received: by 2002:a05:7301:6193:10b0:369:a162:af96 with SMTP id 5a478bee46e88-36a4238974bmr4897056eec.17.1793394992278;
        Fri, 30 Oct 2026 14:16:32 -0700 (PDT)
X-Received: by 2002:a05:7301:6193:10b0:369:a162:af96 with SMTP id 5a478bee46e88-36a4238974bmr4896996eec.17.1793394991319;
        Fri, 30 Oct 2026 14:16:31 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm13513535eec.16.2026.10.30.14.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:16:30 -0700 (PDT)
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
Subject: [PATCH net v3 6/8] net: dsa: b53: reference count shared mirror source bits
Date: Fri, 30 Oct 2026 14:16:15 -0700
Message-ID: <20261030211617.288562-7-florian.fainelli@broadcom.com>
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

