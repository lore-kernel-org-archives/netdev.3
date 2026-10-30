Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394994;
	b=knXhmp8MTWovVjyhf/ehvIFzFSn4LCqeVebdU65A8+Y3sAGZBcZ5i+EWSPs81GC8PMkh
	 NP7iKg0mI5OnK3qexE8dGAJ1h5vyTheWZW3C01I80gy/L7ZsVJMcVQl+qTS4xlfmzG8Ms
	 xbGOqs45RVhDlzGJKSlSNRsTDm58qz+4xId295D+kdZeZNFGwV4gV0OsrIP+5RnXduQx1
	 Mr71ClR2/3yEC0dordWxRhNJIksHYf4LyqkkuRvJc8L1cqnlcJuUVFBMfgJjZCdMQV3RK
	 oFMiDxI2/GXOFntrWwkJC8eVDbZu+06t4fzVyUzU6UmT1nfkBYIoCg/kd143Gg0zgXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394994;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=zKHpOqN7el/iBi24fQQZSjZZJgwztQp4IyGIqG/dArc=;
	b=OLG0FbVK5sMxOqleXlhBpRhqSNFSJNbXmOm3xNRiypnjN8Uw2sZWOXDhg9BVWOSmAJkL
	 RGXkVXDMFYXvPilSunm5LLqxC1iEJl298JxsXgZGVxVoiE0uCyKrhkkRZNbo0oOlK+0aO
	 aiu/4bKV62+5SnhhqS/6YIt0tG3XrqjVDna3HLCB4/jEYBt/0fdOrF5DuVu7sujDiqGOo
	 it9xT0Ka5eBE3dNRfK0q/2yX2wMZyWe5/F0WIEaq61yLcX4BBXz0ydEVInVrL7AyE/uB+
	 ifI7cLOAtQh/JjVDKuU8UxcQpS0XCql7+WriAtzmzJEFxYhc/h3zZ2f6yYQJrKBLSpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=P0PJQoin;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B2860A2634
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02B2860A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=P0PJQoin
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3aded3c6103so574137a91.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394993; x=1793999793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zKHpOqN7el/iBi24fQQZSjZZJgwztQp4IyGIqG/dArc=;
        b=ErhWi3wdWYHVruItW4RNFck/rAj0n30Thu+a9ILDF6Ej1E8SUZqVS6NnLiZmLtTtAa
         KSHb2M+d3xMzOk2mN7I9B+g4y785/sPLQXuqnAIDv6foxQDrLqjbKCyo3GAYnYM1b8HS
         XCSlw+3tq3mO85t4LZJsnoVTlVAQuc1GKdnj4Sge1IwyOxS+1sw2eJo9Tun/+aEEOWxD
         s4iUnYKI4SPU0E4G5IR4EzSPtIxGTlMbJUVDlsUBI16s0BJL3D23LWnlHPwy8ebSA22Y
         IF+QNKvTtsUQ9dnm9wM2Fuy/D60RGArnIFeh1VLEtQTpMecyfd5LdKOwUzl31KGSyXLH
         bmBA==
X-Gm-Message-State: AFq9FYLSRMDvC1sb7iD+Qg4FixC06lLDKqxXU+HYIRgmAWunCz8H+kUu
	0a3HcM7Iit2V2Tpaw1OglkNJaxNbrnys+iKRxjtdqnjdelIt73iSSzubm+x/kC0WPO8QkbnVrH4
	1kWVboEy4PWrJUW3RnLEt4JyztH2slC8998mwt8oCoKm5LFqcNLehY8/KPrl6BWCcB9v198UU5i
	Hx2htAV1hVTkPDW1hn1Du59wLMbAAJ6yvN2csJPuuLmU9dHohtJmbSq1pmfjmaxHvX+wmTFH/1U
	DYFB4oVfpl3Q7+8eXk=
X-Gm-Gg: AYBFou0Sc5WM1kYMHA7pJlxJH2aFw9iuypezZhxdV0Hj3SHyyvTaDWmbYcSZKTPh9hn
	B7OWyOwMxNWPYbpNQocfT4iAZLIyafFmzdlA++7d6KzdWENrnSgy+Yds0yZgTEbnsI2RLmMzc9y
	INNbufnEI1QrOU+JDUTLxJbtfHFLTXx/auFB/Z/kSyR/piuBT2HrDHXoRrrgEel6Zdju8VjNWhV
	FhsXE0Nwg8Y2hsAeoTaiVmocyz4rhXZUNn3tnkBwpyR4rY7c09alUWsxwOwGgFwkQ3STs2yf7jL
	LhxjKg1RuyiQhzGEUXDv7Iszl/hJWe9Tqf73X+FkF4090gXy04Mj9CrXJj9s5bibfYs0zNjoEbc
	4KcPqv58znNppzunKMaGItTSB1+hr9mk8wNDPXPku0tNB8eTTqbBh4zkDMXo4+8kIhzKHpOtSbO
	EpcIWLo4zyldCTmhNx0qoAxvWsCjn29xGYCBeQ5P/e
X-Received: by 2002:a17:90b:590d:b0:3ad:1da4:2ddf with SMTP id 98e67ed59e1d1-3ae8980ed29mr2690056a91.51.1793394992967;
        Fri, 30 Oct 2026 14:16:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e803953sm4841764a91.4.2026.10.30.14.16.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:16:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so2144946eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394991; x=1793999791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zKHpOqN7el/iBi24fQQZSjZZJgwztQp4IyGIqG/dArc=;
        b=P0PJQoinqSToZ/QHhM7C7x2+h1Q6FaeqalpppQp136mje+rkZAL83hUzK1iEJhFUvA
         nth0c4/dqrqTQhz5NTy8Ycgd1X/f3MYCfS8YPFQg6Kvp9xLR9kGR9sVA97dd7ylvL3Sw
         eWPnLebQ153toD6YiVyK5Wf+DeqMLDLJ6LZxA=
X-Received: by 2002:a05:7301:f8c:b0:36a:18a:e02f with SMTP id 5a478bee46e88-36a423c5c8cmr4398033eec.28.1793394990655;
        Fri, 30 Oct 2026 14:16:30 -0700 (PDT)
X-Received: by 2002:a05:7301:f8c:b0:36a:18a:e02f with SMTP id 5a478bee46e88-36a423c5c8cmr4397976eec.28.1793394989808;
        Fri, 30 Oct 2026 14:16:29 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm13513535eec.16.2026.10.30.14.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:16:28 -0700 (PDT)
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
Subject: [PATCH net v3 5/8] net: dsa: b53: use the correct override register 2 Gbps bit
Date: Fri, 30 Oct 2026 14:16:14 -0700
Message-ID: <20261030211617.288562-6-florian.fainelli@broadcom.com>
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

The IMP and per-port GMII override registers swap the override-enable and 2
Gbps speed bits. Using the IMP speed bit on a GMII port clears its override
enable and leaves any previous 2 Gbps selection intact. Select the speed
bit alongside the register and enable bit so lower speeds clear the correct
bit and 2 Gbps sets it.

Fixes: b6a8a5477fe9 ("net: dsa: b53: fix resetting speed and pause on forced link")
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 378f47e7250c..75033b28100e 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1370,17 +1370,19 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 				  int speed, int duplex,
 				  bool tx_pause, bool rx_pause)
 {
-	u8 reg, val, off;
+	u8 reg, val, off, speed2000;
 
 	/* Override the port settings */
 	if (port == dev->imp_port) {
 		off = B53_PORT_OVERRIDE_CTRL;
 		val = PORT_OVERRIDE_EN;
+		speed2000 = PORT_OVERRIDE_SPEED_2000M;
 	} else if (is5325(dev)) {
 		return;
 	} else {
 		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
 		val = GMII_PO_EN;
+		speed2000 = GMII_PO_SPEED_2000M;
 	}
 
 	b53_read8(dev, B53_CTRL_PAGE, off, &reg);
@@ -1392,11 +1394,11 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 
 	reg &= ~(0x3 << GMII_PO_SPEED_S);
 	if (is5301x(dev) || is58xx(dev))
-		reg &= ~PORT_OVERRIDE_SPEED_2000M;
+		reg &= ~speed2000;
 
 	switch (speed) {
 	case 2000:
-		reg |= PORT_OVERRIDE_SPEED_2000M;
+		reg |= speed2000;
 		fallthrough;
 	case SPEED_1000:
 		reg |= PORT_OVERRIDE_SPEED_1000M;
-- 
2.53.0

