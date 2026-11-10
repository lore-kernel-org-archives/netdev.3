Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282637;
	b=0phq2gBqo8c4zNoA7NwMXkMKfWhUzAIn1Ue7DiVxOYclR4o2txhztqZe/+VtkGf5NdEH
	 9N9kgkBx/fTGx+tgre2xrm2NzNXMQq4LoEi8Vmc6gPc/dBhuron1pD3BsMNRableHj6d2
	 9ZPDBPC2y7qL2+QyCRkdWaRtcDB8eFXVLwI2vUihkyYSAbPIr858fQLr0O1NCP1iN2G5+
	 WPvJAFOCpc0BKJJIi+XCJUGJO4PBRBBHi6Msr+/IWgLFALqTp66EBX46roV3vkP7zbnSa
	 i0cBBbY+zEFjgaLz0cNGX/GWTEgMU3YmoPMyFKYEUrc04iD5W4nO5ElaYegUNrlSqoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282637;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=ViXjqbT3KRWfvHNHJYyPeRSyMlk/teSxYJxUWIJYwOc=;
	b=SKOAgoi2cw/dw+M04zW5MoPuiV9mmmj/3qQTZtsFPSRpyal5opC7TH12svhPZyrSy0YJ
	 IHKHigc1qb2pCcKeiAJ73x2QbHRLyJolCceEhxhuebXy1xWo2JFusEgTcPUCUSxXA4aIW
	 T6Bg4CuKnw99mCyJWPByIe3IILWiRjbHWHtPosABe0TfvIC2LZFR2d3hoolWy5SP9fWw6
	 Q/vchMTfvBhEoEmsErtFdKBs/pV7uQRnYd0nuSz0wSGmSujYgHxAfPI4a55Y1njCddYGQ
	 XwZ3a892Hf7bwnA8lEmRuSB/OEKTiKHTFJIPhM7PGwo/S22+juGLu2a9WfX6waf1u1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MvwoizyX;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86E160A3811
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B86E160A3811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MvwoizyX
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso869256a91.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:50:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794282636; x=1794887436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ViXjqbT3KRWfvHNHJYyPeRSyMlk/teSxYJxUWIJYwOc=;
        b=P/5ZHmIBynWGTLC3jt+hWKgcedNQvVV7Oj94FNlqKZXGfOaHxAqKKCjXrfwp4nlVXS
         YVy7c8jRV0IbIP5LRR4U/na7qZIMnGAjLvaEdstabysDqWMGAb7pxPDOkDxIMVDm40rc
         bFH5rElkK9Nu/ibAD3rcFTw+Ngn4gGz7CWC8clfWOAaM78lXNN/Fw8kDfEaLfXW99E/p
         NmxnDV/XgO05F+SJkLSUMPOjyCpoHo4GjG0jm9Ex1gzCh5mfPpURljxSR4j6tGVm4JEk
         mdythMA4uKktXomY0s8pWQLau56dCfYZ5bd96P0rkwRvEaB5oQJ6gOUq2cyGOR+BePDS
         zZZg==
X-Gm-Message-State: APuU4Z8ZPZiLfq3elQLQ1wjZCHko7CLtnfQvePZWI0SsjG5R5tcueP09
	mXIDtdgYJQoIBh2y1Tu4HQOgpso7jqpjriVkUhu6wZ2rGqJGpo+UghuyvRvsjyECH4T4IuRlMK4
	/aPzV+yB22jkSAX0IkvZRnptQQ/XO3oTCjAolIDQ1mD3y1zr7ykd52PNouS4gjGBTjeItSsnsDc
	XmE7PYqYj7j/tUEk4wRiUpe9jsOfIdmNEn40rdfN4zbDo569LlMbl1IQAIQBvO7ODrlbZWoAa/z
	mxsz7Jypl9rXxNG
X-Gm-Gg: AYBFou3spYTC68IYOqMM0sy2rAkoM0Cc+v+wgGtM+/ctEDOKNclo969vf3OW0BAmp4G
	rpKKVFWsPzXJWRDBBO+iF9yIPzuYWQjfVk6/qX97+IO/vJWwkh8VpcOPWnDDQOLNZFDewRFx0jD
	nTvRQYb05Uus3StrRjPmf45fC2Kegw5SJRfWD4FEozUgZ1iOvmKZQ+TQuOKEyaPHna4QTkRQ6l8
	dtZxOdmOb/aG0+eSiCmznJFw/PZXtbDXxYoaAZpf4hTSeTp8WbLcRCb1XpbeoVkFNhuxfV8lD9T
	MpdL4O3Id1eLTEvmsCUoI5dT9MXtRcEOkm1uA9VwdGJDx3GMu+dN1QlCW7+un83rcPVrXGAPqGi
	snkpGbPVAYZ94tnyoLdeBPwH29fF+dlC0yXPeKVKPtv364k/UJN02jZMYQ2IPlLLFyk+mB0vO59
	WG8ws+fbjTft9KAC94A5JdeMWTQeabIOzllKd9Zqx/
X-Received: by 2002:a17:90a:e7cf:b0:3b0:9bfa:72ac with SMTP id 98e67ed59e1d1-3b16797cd8dmr1122284a91.21.1794282636043;
        Mon, 09 Nov 2026 19:50:36 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b168acb09csm449294a91.0.2026.11.09.19.50.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 19:50:36 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-54af6c38073so37250441cf.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794282635; x=1794887435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ViXjqbT3KRWfvHNHJYyPeRSyMlk/teSxYJxUWIJYwOc=;
        b=MvwoizyXKfMO4Db+T9062xwYWax8x5jC/M0086Eq8wj8ZcyPsT3uRYDsfeP2b92XwY
         RaOm9T4eIbNa9n4VFjfHbyyFRutbq8qOtWKUWytZxQJWhrxH863CpVOier7Y0SvGjiSO
         No01ojc5nx0WQWWxUwE5BLztgRgZ41SGksJXI=
X-Received: by 2002:ac8:5a51:0:b0:535:ba01:d95 with SMTP id d75a77b69052e-55519b63639mr23961261cf.19.1794282634741;
        Mon, 09 Nov 2026 19:50:34 -0800 (PST)
X-Received: by 2002:ac8:5a51:0:b0:535:ba01:d95 with SMTP id d75a77b69052e-55519b63639mr23961011cf.19.1794282634197;
        Mon, 09 Nov 2026 19:50:34 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550af612dfsm13740951cf.8.2026.11.09.19.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:50:33 -0800 (PST)
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
Subject: [PATCH net v4 4/8] net: dsa: b53: reject conflicting mirror destinations
Date: Mon,  9 Nov 2026 19:50:14 -0800
Message-ID: <20261110035018.2169370-5-florian.fainelli@broadcom.com>
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

