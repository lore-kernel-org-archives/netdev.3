Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394992;
	b=PTHHFCNNGLQyxtNiGKre1Z/avShKikHCL2kLElQe15u7SwLolAhdomXQlavltD8dPOAE
	 JwxWOZpJBZNNIlElgA5phtsPr0wx7hDG6q2QoCtYq+gSZ7UUFrs9lB062SXQgfBvW4lL2
	 IsmLOnezLZ+Jkztb72br0fmCL+Q7yQMPYglEvx3qbLogaWLiECjkywyFDGB33qoi4Xi5K
	 KZRxgEdYoMqyliAchqv64tF5Gu43kA+UoZ2r6O0RPiDY4o+lS85n+vZP4DT9sawGSiR0y
	 ZDz8OnndQ4rt2v7Cmncwfl/SKLkhc01ahQgxcyjaz6Doy/BlrDKFsiW8RHlThExlIFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394992;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=BMM/lKLw4x9WcDyTwN7IVkv5KR6mnIRrBacIydwUBoc=;
	b=ImtnX6J37I3oOjLKuXrirAyBNzXrIQ6a002nJIyfGM15k/ATOnz+kUTfUUGbiTXTUOTv
	 M24cbkLSnQi4ZMpY21S6nsFjs+2nTouiGL7ZQBl/Qi8E7jBNTlVZQRzD4M82WvtP9Cu8g
	 K54XJkTtqJYs5VtdVZI1W8r43IQ4T++Rfleu55YUJN3dfHfyd1bfTaOBEb0eNN4JAeZto
	 2i/Ps24TkgjPkRkXBprlKYdt4K0Y1101xZxvaW9F3tAGBkRz8wEgBPvN/Or3SIITPCAR1
	 hnacFfEdO0KyahJJZ4zncWR8KOOz2E3rArUc7f7SIY4L7dlJ8huvS+dvgAfXcbZ3UKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IQZkna+w;
	arc=none smtp.remote-ip=209.85.222.228
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECADA60A261C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECADA60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IQZkna+w
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-943e8d35f74so106472185a.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394991; x=1793999791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BMM/lKLw4x9WcDyTwN7IVkv5KR6mnIRrBacIydwUBoc=;
        b=lGwo4vYlIBzyZHO28ApBKpf69/VVyDQr1E6XFV53MchLNSIMHck5+Z0neeqGmmasHs
         ejYxFg2d7h5q8fy4LkFYgXAnfhYz9jcRqmcTs06WAI8pLM0Nm2X6pZxY6mbZsZwdC33Y
         XCZBA6DezH2blQcjPAG07iNylP+kPmC1bVeq/6qDVLTaacQEqX8yykNqhOp9S2rr99Pd
         rW45PzCKj7TmhYDU24lFdfXzDYU8jv0HejEP/xOnbFQ6L0ciazv8U6d+nZDTNAKlwcOh
         qwFoelPnGW4ZXR7/HbgAjs+n3Idqov8UXin4WPQh1LurrirhpNwtu8aQerIAGjDNrUro
         UtDA==
X-Gm-Message-State: AFq9FYJAB1NtjKMqMKCEWrEB8tLhnWwzJyFUREAF0ZjeUCbLweX6xRZ6
	PGctkaV4nXWLRuVf9kr8WpZfJz1+9O+7r3wC0d8TDyCQyw5M52PediFOvUrnuFyAe+TQ45z3jMu
	8HuFsNophB29j8rm3e3hO2QywdCFeJx5GrrWBmX+w/3JfCamq4tSJUFNHO1W1S7fDsAlB97Lawy
	z+eN258iBoKM5Lhc2c8Hkm4RF2+FcLi3Tf2ccv0ED7qUX2q19RrnPIBwBLA6fQ7DzjXNmVzwB6h
	I4Zp52/VZWUFFsthxY=
X-Gm-Gg: AYBFou3VSWHI5yjRuyaTSGlEm9KJz2FfU0SO1aAwdT7nSRrbb1I/K80L7gEuvPcEin+
	SnCI5SHz2UaOkNh2WYuEdKA53HwnVMpa5iT3yKmoU6LPnOJszY7bqjbmlTtXboXF5t1CHZD77wg
	HlyT3d/SxJ/tTBFBm45f/sUz3GMzIN3A57lJptutNmOD+Odueu+1NCA9CL0kCFZzC+UNq98y14A
	7T1aQkmcxQCzO96Csxa3+3PVam/pF7SfCl871CSesudargkfuBQfnyTsbmokPRDFf9VkFhSEbuW
	mczxO+8GK398IiIdRG/6+eZA9Jw/KLM0jf+71IUa/VbJCHcmOZfxqQWhP/MqmLG+ok7f1JBfqWH
	Xc6nGY7YisVI0Bwi9DeeAEJ/0jfn2Fo0WyuWvLuk5Kc50V96FbCIWSI8AWMpCTavkF/Hp+k0rM3
	dgz1qka+RuEanCrYy6N20PJ9pJ7Tn8cO3ue+yoKaWA
X-Received: by 2002:a05:620a:1a08:b0:93c:9d56:a860 with SMTP id af79cd13be357-944217439e4mr622933785a.19.1793394990806;
        Fri, 30 Oct 2026 14:16:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-944258515d2sm26421185a.17.2026.10.30.14.16.29
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:16:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2479409eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394989; x=1793999789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BMM/lKLw4x9WcDyTwN7IVkv5KR6mnIRrBacIydwUBoc=;
        b=IQZkna+wJYmCH5KhS2l4HAta9nz1lfKWpErk+6HwyDvJUMoi88j4ng5Xyxfheacity
         jQE234oDwEI+btv3V1UCUbzCggPnlli34HkzJCjmhpg3oDTTl8793wgVzb8cZJxAouCS
         552TgQ90Nx9leloWxaRqOj8I1FR5P8c+fVAwg=
X-Received: by 2002:a05:693c:69d2:b0:36a:1294:59e0 with SMTP id 5a478bee46e88-36a4241eda9mr5274256eec.24.1793394988503;
        Fri, 30 Oct 2026 14:16:28 -0700 (PDT)
X-Received: by 2002:a05:693c:69d2:b0:36a:1294:59e0 with SMTP id 5a478bee46e88-36a4241eda9mr5274156eec.24.1793394987481;
        Fri, 30 Oct 2026 14:16:27 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm13513535eec.16.2026.10.30.14.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:16:26 -0700 (PDT)
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
Subject: [PATCH net v3 4/8] net: dsa: b53: reject conflicting mirror destinations
Date: Fri, 30 Oct 2026 14:16:13 -0700
Message-ID: <20261030211617.288562-5-florian.fainelli@broadcom.com>
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

