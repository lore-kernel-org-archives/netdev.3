Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793132568;
	b=gPCGVSiEoX9QhWSOka7RFuK25XcDLwBE9GKaqtQqb96uzI3WLGubSm2tFhHdz6j/yHCL
	 T+974rF+WCg3ZIG6g9LgghxQS3ktU23QuWRN7X8i7scLNKXRWE7Um65mzTmZjHYRKC0bd
	 wTo0JKVu2YgCKiRDfXQgZgKOieHgVOAhY5tC3guwxUIiEmccijvf2Ct4yEwheZT2pZ2Xe
	 zcphOp9MN34LhQDGE1YBBkTMj5XDrC7Mf+OkkQRoUMhSlENio/E3heqjn6RgWhK/VhBeW
	 d8nBvDqprmFxNxXUKwIa3iYBn3AWWIu74MJYFHf7+LW2o4THdhFs+kXl8n2uDUddPdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132568;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=A1z57LQ4iJ82Q3o0NAIzq1pzrjN6qyO1yQuZ6UD77pU=;
	b=wU/4MWmFhpbqwh+D5vpk5IxMD2aeEu9bIo6OQyifQilknh7LadBg7KzcdzHFB6SYHD/q
	 T+uZX6LoJTlfBePUJQdnDyKNiGGgYc2atNiwDl6SbTYNgzsq1yPFc9LhpnJwdlVWeTJ/t
	 ogXW40nrFzT4WtP/KpuU2UXqZD9pySBlYUt4y17ofAYV4ynSXnX8Y6thrDd1g5VS2x4Xj
	 cVQGpHx31O41AUE1LPSdwjXPcS5ZRWgJB57gYrucb+d9DQRnlkRnaUGQ3Sqlyxb2YhFbw
	 9h3lyFuxXR/1jVPZ4TsS4uag2etbUX1tgletqwhHY8rEJ35im8h2nmawcWlTjg9dBGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=e2UIeYQf;
	arc=none smtp.remote-ip=209.85.222.225
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0F3606D72E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 20:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F0F3606D72E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=e2UIeYQf
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-93f1ca4132bso18597885a.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793132567; x=1793737367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A1z57LQ4iJ82Q3o0NAIzq1pzrjN6qyO1yQuZ6UD77pU=;
        b=IEquDeQXarQ4z4xxlRyL2SySLO0C3ZKSrRm0BuDJ0Y7DZdmiIpa70kaQgVUBcgMA0o
         a8/hqrJdg/4vC19f3J1QKzhasJF/VxI686se9as49JoruiMSYW1Dgruheis5v6ZQjK5Z
         uCLqPCDk8SnV5wT7crO2mJHf0datqziq62TiRtbwDB258P4PkUeyho4HgEbvOvE+oTmP
         JIUHkFMy1G+5MvGExOc3AocuHEpfyQ9AKkauQHC+37xFndbibMjSd9Qu1hqAUmf/xmJ1
         6Fr0rZFD+atXk0bt5QyQvzbQouAUoGwi2D/wdUSdG3kidPmt7p74yC8kHfxxznrJTa6V
         WeBA==
X-Gm-Message-State: AFq9FYLEPFBGjMLmrwqQVVrE3MY7Uv2P0BYAXWORZAaU+NoWy3ejJi97
	i49Z5DSfbaTGyxEHPJ41ByLrfq8Ub8pQSC+6ZlKOW+oNaJgiGM+6+G7ljekO6Ki40ePkRqegP/H
	Da6rPQ4rS1gJ5xlL1aqtbU3l/hNzcnc9OLkqMt6YMTlsCj4aK+b2sGSoKtFOIlJh/T2e9byyHdO
	rmEt/X/Y8n+yQ1fVtihVVovl4uRZ9VvOsXm8LwnN08ldHocx2Kty7ZwxXwTsa/Jw3+lWVqrn23s
	Ue2Q0+c+N2I4vzeEmw=
X-Gm-Gg: AYBFou2rLIrvJwD75M8oty+TFYW8j9NGogdhUzWohTAZrkDTxROmDalBa8w6LYvh2hx
	aGUg1KXMt4RO9gz4j7hdT+fG7KfjXXS+DTr3XJ3Ta0/4gvlmQFdO+CxfORZHq3FDcySuGBa4VDT
	sbCCytj25+/jRHDlN/k7OTXWoAXSNI0um9VDcfQ7lm4XckaUHye9X/cnp9pm9wnJnwyhRfbNCbu
	rxSCFkwav1pcmLH8AJ6TmR4R0R9KPj+Dkj8rSGx4h9UEQ2riXKMp1mzryz6a4vyr+GbpOAaDBow
	uSkvj8jf40/wdoAFiID6faaIvPb4LYz2BeAKPWcIcP/dvTcOKNx+ptt+u4bktEPGDCZAk0gxkXh
	xEKuuthPtFFzbi435haCttg0p6HvLrRCBxfPW+qUzK4XtuGpNbhdST8sus30PLfVgd3oCO6fYo5
	EAc+vqSEXHSqVTV4xR6xQuN1CuJQar9B75IFP8hSQB
X-Received: by 2002:a05:620a:440f:b0:944:192:85f1 with SMTP id af79cd13be357-94408a927f8mr12203285a.48.1793132567058;
        Tue, 27 Oct 2026 13:22:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-940f06747besm158686585a.8.2026.10.27.13.22.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 13:22:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3addd73e66bso237905a91.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793132566; x=1793737366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A1z57LQ4iJ82Q3o0NAIzq1pzrjN6qyO1yQuZ6UD77pU=;
        b=e2UIeYQfpzS6nvef3KCq/0QHzUPB2h7NqR8+iQhIQ8fBhETTrDUpUKfLFQlsWFFp/+
         /8x7RiaXGPKZriWbQ+Q1RLNmuqHeZXepG8FQRdzHwp/eQEebBYEfRWKm6tjRO7CakI/j
         xB3Xjae4RCvYDGXVPSL36DyF42h37ME1p24tg=
X-Received: by 2002:a17:90b:4fc1:b0:3ac:ffb8:1809 with SMTP id 98e67ed59e1d1-3ae58155cc9mr115449a91.39.1793132565700;
        Tue, 27 Oct 2026 13:22:45 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc1:b0:3ac:ffb8:1809 with SMTP id 98e67ed59e1d1-3ae58155cc9mr115421a91.39.1793132565199;
        Tue, 27 Oct 2026 13:22:45 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d1650csm275486a91.1.2026.10.27.13.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 13:22:43 -0700 (PDT)
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
Subject: [PATCH net 4/5] net: dsa: b53: reject conflicting mirror destinations
Date: Tue, 27 Oct 2026 13:22:29 -0700
Message-ID: <20261027202230.3539646-5-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027202230.3539646-1-florian.fainelli@broadcom.com>
References: <20261027202230.3539646-1-florian.fainelli@broadcom.com>
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
rule can select a new destination.

Fixes: ed3af5fd08eb ("net: dsa: b53: Add support for port mirroring")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0871a10d8cbc..b8a7b380bac8 100644
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

