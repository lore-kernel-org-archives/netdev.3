Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506638;
	b=p5KS1udBpxyg6ExRLh83+3T+9TLh1sXqlIlPa6GZnR5uwmUrm1rWD1aJtsSiWnfZpkD5
	 GVlGUvHMCj8qkW2hV4+R+vDDi41zAtB68owCoCrO5MdhWDT+gh4FHtVvYKdWToeP2NlBO
	 J1zrpGkKJ+vo2fiGDYij9JPW0Z1A6uIvlrAwoQGJZbU3C4zYOwSWkm0IV1PnQ2Q20XK+O
	 IbqqIJdh6fTtJBW60pqPHRE+k7UUEsTx0gPS7/qO6ElHUskfOiyVPG0BtKof5A7omFYCI
	 ujlV416ey1Y21PnZndYRpVJGq120gKjIEfDOe2WANzJe/n5HweMIIaoiCGKij1CSOjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506638;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=ViXjqbT3KRWfvHNHJYyPeRSyMlk/teSxYJxUWIJYwOc=;
	b=ASTZs4YP2Nx+qGpqPTOXBwYWDST4VsoOaqkSiAh9J0MuHsvduYKR74H9m/VITpHprC7D
	 /T0rEYShVujOHNggUVFlYP9eJC73TKAfs6ej4NbHkCrK0WGouj0C/E5XCjy9613gIENL/
	 a+t6yXGgFeDZCFH16M0iV78QgCgTU86e5N01RQVazIYLT2668sAMqFMl/vFtJGsSd5EKU
	 r5RkqC0m/2umpT6bD+IU13SjNf82hEwmgFEHnvukACp5dHqdhJ5g5lD9vFRjwV7HKLA+o
	 Xq+Sh9Vshzkmp3sD1UfL8YoKNjdF9iyYrITB6UVMjJiGBMcgbt0i7MICnxPfaUPRFWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=gtLqw9H9;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE160A262F
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ABE160A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=gtLqw9H9
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so22856a91.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794506636; x=1795111436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ViXjqbT3KRWfvHNHJYyPeRSyMlk/teSxYJxUWIJYwOc=;
        b=iDWAXT9/of8hKvRcw/vUT+Mluy5JrBaXm0Oi31LFQF7dy3Ll/Fx9mF+THzaAvHxuIW
         cuHqXCEU6RH9qTG22be5rQ/yaAqCIqi7yWxO0n94lc0p3O8EvtY4QTaOoqe73kZhPMr5
         JGaxN8n1lJ2bZ7zD0UfVzOCC0VFz0aPt67pePc7WUO5A3ZJXbw94aQ6vNO6JPQxudWac
         8OEAVTt7stL5xWUM/EI7dTM7oEkHeZts3mXOWFno0EgDlIer/t304P/n/Zb0nkY+PiqC
         nVc9vsZeeWPxb8hhTzbT7O6U+gU0LvweSOvE4uNW9b7rz/Vb00XQK1vHLPScs6jZavPS
         L21w==
X-Gm-Message-State: APuU4Z8/e5ciRnEPFIE4xI7C0RjRjstU9FUs3Q9LT71gpdB8zRif5jRH
	PFc2ILayVlN4eeAk4cHoe2RMMEyLTnDn5dOtu2xuA/mj3G5Av4d07cmPiKUDUceZEo76sxpKI6S
	FxJtvQGbXYmGmM4DqEN2v0Mqnxo/XNkLj00i1Ra1Ko9hPbtXmtqNiGYCvzF178w7YQUhwyQXdVh
	kanVu/4jqBMNQtUsYLja9UwALQPtSSzGI9f5DHCdTGBvJm9/gSTavMJhBqPcaBi+qq4rNA7Hv5K
	/ZxtiQe8N4QDYzy
X-Gm-Gg: AYBFou1vxgjS3xVthJQtIeYd5r3pMk6w4xZUZvUdEqylUYk/iU4htGftlQEK158HE+G
	nTjuX6IdNJVA9j+z7oyMKSIfDmcCiC+WJvzIlHaPWU6BKWvEIWwTmwRXiDgbAQce3hyrH47t+41
	y0/WSrXXPjkocvN5up5ehwF42JyUG/V74YRO4dSdIrOasTg55E74MKjKZNTsP2FVmfkOTTXrUFm
	aWH9JL9AQ1SAPJ3Qn/CmzDUVjUhV6f27CoC6pokky2o95OZc+HUvVloOm+S8L0EpNOgkJW3oCY4
	o0ADLV4iN6kFr/Z2y8lbU/WQjNDREPU9VrxmvhJg9oxlM3LAKCCnaBAYPA6JE75+4R7Z5B7y7r5
	FkzmdY/psu2mpnENRchyeyeE2dgd3010LdMuqMMNUNZFZ7Gtx/zlcl2QZeVnPehEx20rI5u7M+5
	Sn09q6mkrhj+TsvDGrU6IVQblnYLX1nCSCNzZZ2Zo3
X-Received: by 2002:a17:90b:388a:b0:3ac:6fcf:91d2 with SMTP id 98e67ed59e1d1-3b182e94544mr6322759a91.19.1794506636390;
        Thu, 12 Nov 2026 10:03:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b197c1a3e7sm3066412a91.2.2026.11.12.10.03.54
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 10:03:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cdd4dafdcf3so97590a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794506633; x=1795111433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ViXjqbT3KRWfvHNHJYyPeRSyMlk/teSxYJxUWIJYwOc=;
        b=gtLqw9H9hMD6UPk8eAiKRD/RYq49/uol/fIHOnLx+7m0TEsv+PgxjHORPTWMcxELFV
         RQeuxNzHpwCTUAu+6CVIh7Ebaapj61HS/SKuQR9py7NnSDTItljZQpC+/vkwcUEmNbTR
         jN3mX5+jvortH2QlQoEnFx+2YkfQrcKcuIkMs=
X-Received: by 2002:a05:6300:670b:b0:3dd:85aa:452d with SMTP id adf61e73a8af0-3f2fe0a3583mr7031161637.31.1794506633086;
        Thu, 12 Nov 2026 10:03:53 -0800 (PST)
X-Received: by 2002:a05:6300:670b:b0:3dd:85aa:452d with SMTP id adf61e73a8af0-3f2fe0a3583mr7031110637.31.1794506632485;
        Thu, 12 Nov 2026 10:03:52 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18abc06sm95004a12.22.2026.11.12.10.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:03:51 -0800 (PST)
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
Subject: [PATCH net v5 4/8] net: dsa: b53: reject conflicting mirror destinations
Date: Thu, 12 Nov 2026 10:01:58 -0800
Message-ID: <20261112180202.324504-5-florian.fainelli@broadcom.com>
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
index cc42b2a4870a..715a0969eacb 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2606,7 +2606,19 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
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
@@ -2617,11 +2629,10 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
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
@@ -2658,10 +2669,8 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
 
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

