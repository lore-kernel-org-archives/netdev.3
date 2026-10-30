Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394996;
	b=HEqchlm5EpbCfm/r4UIcsLuiz6Et91HPy2IAWYn0Ypf1PL4PtqcUNMoEInMO+HBVw1YC
	 b0h2ArtAiq6GGXMr6knOfxd8IPKN6hPsMYNtRHi+rUoR1FFtLwTEhAno+9lneZihILnzW
	 Hp3kIFMU+hr5oU/91M+njMocQs3NQODtOG7EOs6j2Co1mkwEbdMskCZpbe2JXonnEOIg0
	 e31Bl6fDQl0gvoWjUqtv2G7n52KcW7xY+729qiTq7pAUW/5j3aoEYkuQD6ytDihywzumP
	 DDQpctPMEmQOJB6xec0hoD1X1zJhLeUOD28YXzZ4HcqCidD6/p0fRY0A0WcWAydVpTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394996;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=b5hKSSPqLOErsxv3U30fZpQLPSnwl4d2gi3NrK5GmXM=;
	b=mgZvR524a36DFV1TX133C6bHzet83tnkqIvisJGmGGSvULSjYvYfI6OGYB1DTzhTbv2W
	 5CyyEG+cZyHnIHiL96oQ9h1XGVjygCffPyUuBC9A/dDV17+4XDtUXGFgA7TPVPuMGeoEC
	 nUw44qbS2wrFGjzeRdUoj2nEmTTbAkpsINYdZSRsiKTKMkFUdlE4yU3JqQ61q1JLO+/cK
	 53mtDlsVCYXC6zulQwSogw62YFqGDfnzMY7Gc8FcvDdZrtT8EZg0awxquh/0SPuclRHqK
	 JKSlQsWp4qe1kF9GcoHktZ0/vggz4eWBtvf4gTkUWsZ+oB3IL1Fn2lCjR0D4mW6ughA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bbyQyL9i;
	arc=none smtp.remote-ip=209.85.222.99
Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355E4606A326
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 355E4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bbyQyL9i
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-9851592ada1so320521241.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394995; x=1793999795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b5hKSSPqLOErsxv3U30fZpQLPSnwl4d2gi3NrK5GmXM=;
        b=HNAsWmtFeso23LVGkCYHrLeFiYZipXUm6oX3S5GJoWp1e8zL2EuKk1E7OhU5EZknnz
         JECme9Vx1aPppr3p8MyfYJncuKcwsorao3+j5lJu5bDZdHgsPt57x3mSzxHEjOEPRG8A
         WopZk4BcUJ1voXQ85lKs/OHXN43ySDu2jn96lxt1rQ6+wnUsUxGP3/nHc02zB5xcBuZu
         D8NC4WVrFqm9PTQkF2IEmTkXTT6MQZhUIlH5GIUczlswP8Rg0MjVP6Doa6bz2MGot9WO
         hqYOWtB+xJwgFana6a889tyYkJDbagHm36bSrIpWrtBnUMaMNTt4I3XpnVjVnaYx/iQj
         GkGg==
X-Gm-Message-State: AFq9FYJDlHjmTAVga4kEe/aeZMjzJQlUFoc1xzoJJjycMcofRsv6VrVB
	B83+eWNmWXjgsp1BqdYm78DtMAyDNiYfBc0Rjtyk6LFJasqhpHE5+0MOcDh3LnzgDJ5I75U3ANl
	bPrmOQR2LITimZM4Jw4v2+ER3pAFfw5gbYpC0edfDdaeO5oDFnxv33SIDew8otcVrULIvFa0NCW
	8n/ZfiDmXlvQQ98xrY+7xsQYs9bD9itONJloheuoFUH8D4Wvtt/6AGTpfKjXlSg3ZUDYktNfQC+
	oRsJrlVsu0/XTiqRTA=
X-Gm-Gg: AYBFou2wlZqv5qHYkM6fOudLnW+CFsyggGmQYawBSMRfolJOyFlT0t7D8czM7IKmWj+
	w+zlgcTppLd7KxCtqdH8Hv0eXZ5mhSU3kxe5oGcHpCbPpwJXJr3bEzm67Mn83ZXhc/OthbdiDah
	fNFgpoRbVfW5C+BZtmtFzGursjRG/EvEi0dXciNiBM5SFR8YT0QnkN9hsjjaRBG2QIYsUHHwISr
	PC6hLdTjgTUW+MGz2Rb3sbK+/rPLwpzhy6A8vxHIjka75ue6Y0o9mXjZyyDBEtfvRVp+Vbf98of
	dTPsT5GFrDhDzQvRg2YfFRAAKsMsVPJlDg2477mA3Njiz1V6yxIHojl5SiTmtgK/wcBFisdDHiL
	reiEX1JQetuRmo142c7YpLwl2ykjRUqGQo20O30/W9Oj9lyVzUpWyQFRTzRqFWyQhQWGDOsQ+VA
	E9nStiszc46DRcBCIkOity2CMYf//Z1/OMXIRiQtDf
X-Received: by 2002:a05:6102:8092:b0:7cc:9d82:61e2 with SMTP id ada2fe7eead31-7d0725cfd86mr1746479137.13.1793394994984;
        Fri, 30 Oct 2026 14:16:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-992ee3b1f0dsm120486241.9.2026.10.30.14.16.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:16:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36a223755e4so4499218eec.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394994; x=1793999794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5hKSSPqLOErsxv3U30fZpQLPSnwl4d2gi3NrK5GmXM=;
        b=bbyQyL9i9IzZ7W7SOdsN6jLvYET0a3+YT0pZss2E7bShkQyuYAQAtS0ximt9cHeXBs
         hu2m1ml/2fggYgGsMOat/USlvPSHy8jBTt/R19LZpqmzGlZwPWh4GjuUYVtlGEz3O5xI
         ASMx0bWQlfUw0yGKkTbELKDJ15k8KDU0kEFAM=
X-Received: by 2002:a05:693c:69c9:b0:36a:13df:749d with SMTP id 5a478bee46e88-36a423b3dffmr4319145eec.24.1793394993628;
        Fri, 30 Oct 2026 14:16:33 -0700 (PDT)
X-Received: by 2002:a05:693c:69c9:b0:36a:13df:749d with SMTP id 5a478bee46e88-36a423b3dffmr4319093eec.24.1793394992792;
        Fri, 30 Oct 2026 14:16:32 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm13513535eec.16.2026.10.30.14.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:16:32 -0700 (PDT)
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
Subject: [PATCH net v3 7/8] net: dsa: b53: harden mirror register programming
Date: Fri, 30 Oct 2026 14:16:16 -0700
Message-ID: <20261030211617.288562-8-florian.fainelli@broadcom.com>
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

The mirror destination check can reject a first rule when a bootloader or
previous kernel left mirroring enabled. Not all supported switches receive
a hardware reset during setup. Unchecked register accesses can also
corrupt mirror state or report an unsuccessful rule installation as
successful. Reference counting must not record a first source reference
until hardware programming has succeeded.

Clear capture control and both source-control registers during b53 and
bcm_sf2 setup, propagating initialization failures. Check all mirror
register reads and writes and only increment the source reference count
after successful programming. Log deletion failures because the DSA
callback cannot return an error.

Use the source masks to decide whether a destination is occupied. This
preserves the destination when a failed deletion leaves sources enabled,
and permits a new destination after the last source was removed even if
the final capture-control clear failed. Program the capture destination
before the new source so a failed destination write cannot leave a new
source enabled. Clearing the inactive capture-port field is cleanup.

Fixes: ed3af5fd08eb ("net: dsa: b53: Add support for port mirroring")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 109 +++++++++++++++++++++----------
 drivers/net/dsa/b53/b53_priv.h   |   1 +
 drivers/net/dsa/bcm_sf2.c        |   5 ++
 3 files changed, 81 insertions(+), 34 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index b16167c9510b..c2706c2e643f 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1307,6 +1307,10 @@ static int b53_setup(struct dsa_switch *ds)
 		return ret;
 	}
 
+	ret = b53_mirror_init(ds);
+	if (ret)
+		return ret;
+
 	/* setup default vlan for filtering mode */
 	pvid = b53_default_pvid(dev);
 	vl = &dev->vlans[pvid];
@@ -2540,20 +2544,49 @@ enum dsa_tag_protocol b53_get_tag_protocol(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL(b53_get_tag_protocol);
 
+int b53_mirror_init(struct dsa_switch *ds)
+{
+	struct b53_device *dev = ds->priv;
+	int ret;
+
+	/* A switch reset may leave the previous mirror configuration intact. */
+	ret = b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, 0);
+	if (ret)
+		return ret;
+
+	ret = b53_write16(dev, B53_MGMT_PAGE, B53_IG_MIR_CTL, 0);
+	if (ret)
+		return ret;
+
+	return b53_write16(dev, B53_MGMT_PAGE, B53_EG_MIR_CTL, 0);
+}
+EXPORT_SYMBOL(b53_mirror_init);
+
 int b53_mirror_add(struct dsa_switch *ds, int port,
 		   struct dsa_mall_mirror_tc_entry *mirror, bool ingress,
 		   struct netlink_ext_ack *extack)
 {
 	struct b53_device *dev = ds->priv;
 	unsigned int *mirror_count = &dev->ports[port].mirror_count[ingress];
-	u16 reg, loc, cap_ctl;
+	u16 reg, other_reg, loc, other_loc, cap_ctl;
 	int ret;
 
+	loc = ingress ? B53_IG_MIR_CTL : B53_EG_MIR_CTL;
+	other_loc = ingress ? B53_EG_MIR_CTL : B53_IG_MIR_CTL;
+
+	ret = b53_read16(dev, B53_MGMT_PAGE, loc, &reg);
+	if (ret)
+		return ret;
+
+	ret = b53_read16(dev, B53_MGMT_PAGE, other_loc, &other_reg);
+	if (ret)
+		return ret;
+
 	ret = b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &cap_ctl);
 	if (ret)
 		return ret;
 
-	if ((cap_ctl & MIRROR_EN) &&
+	if (((reg | other_reg) & MIRROR_MASK) &&
 	    (cap_ctl & CAP_PORT_MASK) != mirror->to_local_port) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Only one mirroring destination is supported");
@@ -2565,19 +2598,17 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 		return 0;
 	}
 
-	if (ingress)
-		loc = B53_IG_MIR_CTL;
-	else
-		loc = B53_EG_MIR_CTL;
-
-	b53_read16(dev, B53_MGMT_PAGE, loc, &reg);
-	reg |= BIT(port);
-	b53_write16(dev, B53_MGMT_PAGE, loc, reg);
-
+	/* Select the destination before enabling the new source. */
 	cap_ctl &= ~CAP_PORT_MASK;
 	cap_ctl |= mirror->to_local_port;
 	cap_ctl |= MIRROR_EN;
-	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, cap_ctl);
+	ret = b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, cap_ctl);
+	if (ret)
+		return ret;
+
+	ret = b53_write16(dev, B53_MGMT_PAGE, loc, reg | BIT(port));
+	if (ret)
+		return ret;
 
 	(*mirror_count)++;
 
@@ -2591,8 +2622,8 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
 	struct b53_device *dev = ds->priv;
 	unsigned int *mirror_count =
 		&dev->ports[port].mirror_count[mirror->ingress];
-	bool loc_disable = false, other_loc_disable = false;
-	u16 reg, loc;
+	u16 reg, other_reg, loc, other_loc;
+	int ret;
 
 	if (!*mirror_count)
 		return;
@@ -2600,33 +2631,43 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
 	if (--(*mirror_count))
 		return;
 
-	if (mirror->ingress)
-		loc = B53_IG_MIR_CTL;
-	else
-		loc = B53_EG_MIR_CTL;
+	loc = mirror->ingress ? B53_IG_MIR_CTL : B53_EG_MIR_CTL;
+	other_loc = mirror->ingress ? B53_EG_MIR_CTL : B53_IG_MIR_CTL;
 
 	/* Update the desired ingress/egress register */
-	b53_read16(dev, B53_MGMT_PAGE, loc, &reg);
+	ret = b53_read16(dev, B53_MGMT_PAGE, loc, &reg);
+	if (ret)
+		goto err;
+
 	reg &= ~BIT(port);
-	if (!(reg & MIRROR_MASK))
-		loc_disable = true;
-	b53_write16(dev, B53_MGMT_PAGE, loc, reg);
+	ret = b53_write16(dev, B53_MGMT_PAGE, loc, reg);
+	if (ret)
+		goto err;
 
 	/* Now look at the other one to know if we can disable mirroring
 	 * entirely
 	 */
-	if (mirror->ingress)
-		b53_read16(dev, B53_MGMT_PAGE, B53_EG_MIR_CTL, &reg);
-	else
-		b53_read16(dev, B53_MGMT_PAGE, B53_IG_MIR_CTL, &reg);
-	if (!(reg & MIRROR_MASK))
-		other_loc_disable = true;
-
-	b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);
-	/* Both no longer have ports, let's disable mirroring */
-	if (loc_disable && other_loc_disable)
-		reg &= ~(MIRROR_EN | CAP_PORT_MASK);
-	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);
+	ret = b53_read16(dev, B53_MGMT_PAGE, other_loc, &other_reg);
+	if (ret)
+		goto err;
+
+	if ((reg | other_reg) & MIRROR_MASK)
+		return;
+
+	ret = b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);
+	if (ret)
+		goto err;
+
+	reg &= ~(MIRROR_EN | CAP_PORT_MASK);
+	ret = b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);
+	if (ret)
+		goto err;
+
+	return;
+
+err:
+	dev_err(dev->dev, "Failed to delete mirror rule for port %d: %d\n",
+		port, ret);
 }
 EXPORT_SYMBOL(b53_mirror_del);
 
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 910c71618d0b..b871a82cbb23 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -546,6 +546,7 @@ int b53_mdb_add(struct dsa_switch *ds, int port,
 int b53_mdb_del(struct dsa_switch *ds, int port,
 		const struct switchdev_obj_port_mdb *mdb,
 		struct dsa_db db);
+int b53_mirror_init(struct dsa_switch *ds);
 int b53_mirror_add(struct dsa_switch *ds, int port,
 		   struct dsa_mall_mirror_tc_entry *mirror, bool ingress,
 		   struct netlink_ext_ack *extack);
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 9e5713015187..9f54cd414c18 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1059,6 +1059,11 @@ static int bcm_sf2_sw_setup(struct dsa_switch *ds)
 {
 	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
 	unsigned int port;
+	int ret;
+
+	ret = b53_mirror_init(ds);
+	if (ret)
+		return ret;
 
 	/* Enable all valid ports and disable those unused */
 	for (port = 0; port < priv->hw_params.num_ports; port++) {
-- 
2.53.0

