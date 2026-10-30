Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394855;
	b=GJ4ffqmvAvBxWpvpImLmFn4n9Tku/rYloxiNbbhFJvov/ZrpWvvh6LkBM+gD+Lk/yrA1
	 etFcil1QGFlzWyUMrjaTOOUxe8H1l7ySdLb0FtblB4oaaLisu+k/rD29aNrUB1PhJcxmZ
	 cm3mXcVlk/LrQhSiNtkKfcuFNSme+M0fG0YzuubOOWclMO+5w3JIOW05DM26v1+kAq3gL
	 kX3th7Wor3Tmbe/BcwmscEaNTFl6xjbj7mlWqBDHUXf+MYC+64Pb2o0b7srqz4EGrkYCS
	 tVSSJxZrnNRuS822ppaHWSPhxIfL2cdVO0/Qr4FBqEZeRzsLE8ElkKhLgY5lZDtOHoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394855;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=b5hKSSPqLOErsxv3U30fZpQLPSnwl4d2gi3NrK5GmXM=;
	b=YZG14fgazd6qSx61t6bxNSMsXQDgh6eIgLTDL2ctLCVLRjElRbXYd1Jn5msgEwr0uutU
	 DX2ooZbLHoOf9vWoBGrKwZjebvsCyHnYVYgIUtwrGWtzSJl4u2w1uTzJjimTAOoo7N/L7
	 vQyrjdzz5aLAIk1Ntttl3K+HVdaoKliDMr9sT2Z8Ea+4OGx3A41bf/2k0ZLXpe1gGy4uF
	 0pQ91kkMSRrAJ0A8ESEnhdraqfPjp27sPRwbW0AggXl6a1jJ/foggGvOhqG+2NQUSQ3ha
	 p0RqbzqZxdooP2FcENYR42eQhpp8285MwezTn7cOmqW5Iw+1sG4lxL+Q6AlzfX84qCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Y4tRDSMX;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C9560A261B
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7C9560A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Y4tRDSMX
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so1006499a91.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394854; x=1793999654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b5hKSSPqLOErsxv3U30fZpQLPSnwl4d2gi3NrK5GmXM=;
        b=JGUWm+m1hayXVWFIMYmCNNcQb0u8ECpb7+eYYie8juyX5+dHX8zOFKECANBKnPbRCG
         bkfyDCE+tBoZhbAP57xZw50/g9ovgm4XBQrJcPO3wASrxX5uR0qtzlFgvakqsg3Ta73c
         QBrbGCE1pjb9R/1ow3dvabO6vn04xGpwdkNwLc85hHptzswXRR854Dut70jOEhVyFcJc
         mK4FZKXHXNM74XQk6vgn07wFkA19Q+cqCH31ZaZ7tDUxcjGPmgY4JoYfjBavtUW3z1jI
         mC3wlxefily73hOQRO13G18PcXK1L1WHQUdCfbsKHSyVYeyN0Mtet45YJe6tE1aHOF6p
         E3QQ==
X-Forwarded-Encrypted: i=1; AKwUvBwR+NRdNN2CkFIJUU0a2RIvTGaGGsmRc63J1ZxhCJyTp9Sz/3BdR8piu0T57BH1uxUmh+r/5S8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfg0rqBp5aeoAQO72AZrgGn3+/3P0IRLz52FxG/RqI9eg9lfRq
	JlLWZQdLh9Azu53s/DWpYYD6ZubEppNe3L9i2XiRUThRiPRlfdRN6UBULmqnyhCQ10BFUO6PRWP
	rjBl+R+uef5UrKcMdYgejSHGPMuiswz4ovimiApK0XLEWII4fgW3iG8OoAOONEEeOZonVPPeIqY
	9F1pPS6JA7U9dhEwKyEvj9DxMbRwVfsa9OXkBCEk/XkjrcVBJIlbwYSXcP4XWIS5QYwXUzELXKq
	XAjAqnC4tNrTv1kCZ0=
X-Gm-Gg: AYBFou32oPrskxdZ6uBfjJ0g+3bnXHSicHEkMuwXJ2FZUNtAIQjBYFZG834ECsINNcE
	RNkoudHiYljo0/RKUKYVWJDDYKXdvB7dUtA+SkLIDzAl3J1GuOFrsbp/Vm0VdVchsQJtFFBa/x0
	EotsbQ7AexdF3TYdPCelgH2eu5hX7zi56450vraLLkDPnQHjYgEvMRTbGROTxFHmS6r8Y267U2I
	qbPW4ER/iTipNuY0FzcgdBwqxr9m2hHnJnUqcPtvs0g5jlmf3x+ZhZhCmOkwdA/3aljz4o1qvIB
	LueQi+R+xNJ3l60gMuGaFef54JtlgeV6AtDbW5aIn/DO+39cYRwAsysUYMz2l/NfOlatXojl3gg
	wVMvaV5yDLY33PhSFoqyw8ljZJvTmJsjMF27IX6erZ84OGkO532IKFo6gjw4uZd5clmvcBAHIOW
	4JN5knvU6AO8/2A2c1YzmJnHvlFivY4hDEb/Pwpmmx
X-Received: by 2002:a17:90b:3c09:b0:3ab:2236:6b3d with SMTP id 98e67ed59e1d1-3ae89814a11mr2714537a91.27.1793394854158;
        Fri, 30 Oct 2026 14:14:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e803953sm4838913a91.4.2026.10.30.14.14.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:14:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2475781eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394852; x=1793999652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5hKSSPqLOErsxv3U30fZpQLPSnwl4d2gi3NrK5GmXM=;
        b=Y4tRDSMXoVFivlNJ9iI0Mn0a7u2r8NLMd9tsm33uPMDHhXMLckDWNK2mOMFIoFtrxE
         dE4a672xzzvguQCbY64CRUOKpQE3lmVNoa/fuVHZ2xqKscn2e1Z0Ssp0XpWElYVYsAm/
         iiXj3TJnOp5heokj7TzawcSXhwy8jbevCSfOA=
X-Forwarded-Encrypted: i=1; AKwUvBzVm4ntoyihemYfbJpXmYpzzE7s5OoaYjLaSjC5FpxFMnlto71V4Eod4GSvnswJDCC2Qr6/hZw=@vger.kernel.org
X-Received: by 2002:a05:693c:87cd:20b0:36a:32de:a239 with SMTP id 5a478bee46e88-36a420643f1mr4957562eec.0.1793394852000;
        Fri, 30 Oct 2026 14:14:12 -0700 (PDT)
X-Received: by 2002:a05:693c:87cd:20b0:36a:32de:a239 with SMTP id 5a478bee46e88-36a420643f1mr4957500eec.0.1793394851045;
        Fri, 30 Oct 2026 14:14:11 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42669128sm10574595eec.3.2026.10.30.14.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:14:09 -0700 (PDT)
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
Subject: [PATCH net v3 7/8] net: dsa: b53: harden mirror register programming
Date: Fri, 30 Oct 2026 14:13:49 -0700
Message-ID: <20261030211350.287566-8-florian.fainelli@broadcom.com>
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

