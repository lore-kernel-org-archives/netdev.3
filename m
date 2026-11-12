Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472677;
	b=zkH6kUlZe89ygnGM3OqwA0+wPl575YmqwGJBBLRelUjHnJyuDTnn6K5oK4EHAWC3XBGG
	 XxBAyMYMzGNxpc0fNvpIWctdPsTmCMx+0YUvPFWOT9d1wcBIz0wGFs2n2TyzP6aNccQYi
	 NdqZhA2f16LUCvIDcDx+4uMkDIJnOCMegcFC8D7dA0ezjIjGT90uUc3puXbNaEVd9FC9n
	 NK/QEdQzqUnY3qzAwAWBB09IYUjCtQgeWraO/x39OEBigfIwd4CY1yIakV04R3ovuS0zm
	 lGx0d8SMW/8iV5c2c2hAMov0JcQgGzv1UfDNMFV9oP8VVMmeYA8Af7GbfUY4ml3gfjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472677;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=jC9c6LkMym15AEkB1ECUvRiuZK+RQD+M0yuFjSaKyCk=;
	b=QaxzcRlijpZ04SVPsMOjpMjdSgo44M6jgEDhMNAH5oHZyGAz5+GHkSOHIgo2vRG6ufq/
	 qErXYz08P1ImZ5lrfVAltty+/LJvY3VhDtzVw1Mce35gx1ZKIfkarDub4j5QHC5DEealo
	 /ylW/2FIP8LlYF3pzi9M+MbEGR/PQF9BKeTbXfRCwqqBuAnlVReB8ncmAVPaEUzJiFM4B
	 WOIV/1Yez9nL1jm3sIArolNy1fhqC+oOkvet8+KE6Ovaqq5yjzcXs4Zhw30OWO1PS2Lc7
	 kGice662s2rs8JqzPcxBD29Zg7pEeAXgRRKW0bU9WTts4X3O75/YACGvuayPa0zxyAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aE3Ebg0h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750F607079F;
	Thu, 12 Nov 2026 08:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7750F607079F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aE3Ebg0h
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 98FDA2058D6;
	Thu, 12 Nov 2026 09:37:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jC9c6LkMym15AEkB1ECUvRiuZK+RQD+M0yuFjSaKyCk=;
	b=aE3Ebg0h6TFQiTzZoy3x4W6/nRoyAjYB+y1P+mgEe+AOdJNZtk5iT8PmIpdiaDpnIyw0oP
	Ro0pchV+cIw3YXt3B1HPZ9csgbD918EtN5s3wgJHBLFL6No5pNvOJ+ViSEC0H6UneV/IfE
	osbDNOcmXUgDZP/ZwtZycWYGjqJYCl51FfX24PdI6od6gRprQyiXz/kcjngfpcRgEfvNQ9
	k1/djtTmgDA216B65I9smQE3IldYG8GYuvJUXBAFARe2JfdTcROUqSdXICcGTWzdz0GowS
	cVrg/+Y6OOXZHllBxpjANnIJ/yiMwpNQHCI+1D7L10LER/RkwD68im1uR5uYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jC9c6LkMym15AEkB1ECUvRiuZK+RQD+M0yuFjSaKyCk=;
	b=g3nE3URI7TWqzGKmfY9ofiwLLsJcl1km1NcZiWeULmGK29qIgA+MKzdKjCagTOgdkgwtVP
	nVSV+w4dQ8MXneSpgbPpM+wM7P5kit0MMlNmccc+1lPb/F+qhQku+aC6u+ZfNL+mc7joLT
	I1/X6Z7tWibX3ZJySbYXI2je/HpQ1FlvbqlITp+f59Ng1cDpBr1FIlQMhwuk0jUUt7Mgry
	iVGKYl73ToRaXq8TWvst6E+3B4aA7BDhpmvCa9OCoLGWkEBccoGevaKKYYQ25Ou/9camE9
	i9UOE9rnMttx43P6nejK1097rPLJOQb1zv51hGiWqgX1HPsOt2rXed6qeVOyZQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794472671; a=rsa-sha256;
	cv=none;
	b=F+k3//k17sE5AKdJsKkm/NWGi/bNhzUQGXTGblzXqWtVo04HhOf6xGCp4SlOywRNWi8yCc
	LT33CYhPRYWnh+5HNfUf/zx957fR+xS16NWAs2zp6rXNuO3be4I8OoCh44vDnua9SCbfMA
	Cm6g6uyvSNNpLG827jVc0LfXopb8FOfEDwfslVjBevmzSqDrGgeigI4j3pSMba3mdoOOR1
	YRdgxRgc+c2pSds+am4uc1qqXF91Vu+Z7hvq1ScY/kR6ccd6Ai6MwpwvyFcXwKgU0SYJbk
	OozJxEjnPc2JnobQpIshduV74rJbBboTswAE+Ljam6P/jpX7LySgseYUoYS3rg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 60341381DD5; Thu, 12 Nov 2026 09:37:51 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Thu, 12 Nov 2026 09:37:51 +0100
Subject: [PATCH net-next v2 08/10] net: dsa: realtek: rtl8365mb: program
 the PCP of untagged frames
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-rtl8365mb-dcb-ingress-v2-8-f8e6fbdf8c99@pengutronix.de>
References: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de>
In-Reply-To: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de
X-Mailer: b4 0.14.2

Program the PCP that the switch gives to untagged frames whenever the
port default priority is set.

With PCP trust, the switch classifies an untagged frame by this value.
The value is 0 after reset, so untagged frames would be Best Effort
whatever the port default priority is. PCP trust is added by "net: dsa:
realtek: rtl8365mb: offload DCB apptrust".

The switch also puts this value into the tag it adds on egress. So far,
an untagged frame that left a VLAN-tagged port carried PCP 0. With a
default priority set, it now carries that priority as its PCP. The
standards require this:

IEEE 802.1AC-2016, 13.1: "The priority parameter of the
M_UNITDATA.indication shall take the value of the Default Priority
parameter for the SAP on which the MA_DATA.indication was received."

IEEE 802.1Q-2022, 6.9.4: "For untagged frames, the priority parameter
signaled in the corresponding M_UNITDATA.indication is taken to be the
received priority."

IEEE 802.1Q-2022, 6.9.3: "The priority and drop_eligible parameters
are encoded in the PCP field of the VLAN tag using the Priority Code
Point Encoding Table for the Port". With the default priority
regeneration (Table 6-4) and the 8P0D encoding (Table 6-2), the PCP
equals the Default Priority.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Changes in v2:
- New in v2. PCP trust needs it, or untagged frames would be Best
  Effort.
---
 drivers/net/dsa/realtek/realtek.h       |  6 +++++-
 drivers/net/dsa/realtek/rtl8365mb_qos.c | 18 +++++++++++++++++-
 drivers/net/dsa/realtek/rtl8365mb_qos.h |  3 ++-
 drivers/net/dsa/realtek/rtl83xx-qos.c   | 14 ++++++++++----
 4 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 9a7906331cbdeef03c59cb4859c32c6fef2020d9..a9bdadbea3cbe19eeef0f33762318f022881e75f 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -165,8 +165,12 @@ struct realtek_ops {
 	 * priority. A *_prio getter returns an iprio or a negative errno.
 	 */
 	int	(*qos_get_port_prio)(struct realtek_priv *priv, int port);
+	/* Set the priority of @port to @iprio, and make @untag_pcp the PCP
+	 * given to untagged frames on @port. @untag_pcp is an 802.1p
+	 * priority, not an iprio.
+	 */
 	int	(*qos_set_port_prio)(struct realtek_priv *priv, int port,
-				     u8 iprio);
+				     u8 iprio, u8 untag_pcp);
 	int	(*qos_set_pcp_prio)(struct realtek_priv *priv, u8 pcp, u8 iprio);
 	int	(*qos_set_dscp_prio)(struct realtek_priv *priv, u8 dscp,
 				     u8 iprio);
diff --git a/drivers/net/dsa/realtek/rtl8365mb_qos.c b/drivers/net/dsa/realtek/rtl8365mb_qos.c
index 378cd6ed7fe6447cc7508fef90dec4c5332cf3e1..2a849d0e4898a712d8f4babd5cdd03fe8e207814 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_qos.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_qos.c
@@ -64,6 +64,14 @@ static_assert(RTL8365MB_QOS_QMAP_DEFAULT < RTL8365MB_QOS_NUM_QMAPS);
 #define RTL8365MB_QOS_1Q_REMAP_REG(_pcp) \
 	(0x0865 + (_pcp) / RTL8365MB_QOS_SELS_PER_REG)
 
+/* PCP given to untagged frames, one 3-bit field per port */
+#define RTL8365MB_QOS_PORT_UNTAG_PCP_REG(_p) \
+	(0x0851 + (_p) / RTL8365MB_QOS_SELS_PER_REG)
+
+/* Ports 0..7 fit in 0x0851..0x0852 */
+static_assert(RTL8365MB_QOS_PORT_UNTAG_PCP_REG(RTL8365MB_QOS_MAX_PORTS - 1) <=
+	      0x0852);
+
 /* Port-based (default) priority, one select per port */
 #define RTL8365MB_QOS_PORT_PRI_REG(_p) \
 	(0x0877 + (_p) / RTL8365MB_QOS_SELS_PER_REG)
@@ -184,7 +192,8 @@ int rtl8365mb_qos_get_port_prio(struct realtek_priv *priv, int port)
 					       rtl8365mb_qos_sel_mask(port));
 }
 
-int rtl8365mb_qos_set_port_prio(struct realtek_priv *priv, int port, u8 iprio)
+int rtl8365mb_qos_set_port_prio(struct realtek_priv *priv, int port, u8 iprio,
+				u8 untag_pcp)
 {
 	int ret;
 
@@ -192,6 +201,13 @@ int rtl8365mb_qos_set_port_prio(struct realtek_priv *priv, int port, u8 iprio)
 	if (ret)
 		return ret;
 
+	ret = rtl8365mb_qos_regmap_update_field(priv,
+						RTL8365MB_QOS_PORT_UNTAG_PCP_REG(port),
+						rtl8365mb_qos_sel_mask(port),
+						untag_pcp);
+	if (ret)
+		return ret;
+
 	return rtl8365mb_qos_regmap_update_field(priv,
 						 RTL8365MB_QOS_PORT_PRI_REG(port),
 						 rtl8365mb_qos_sel_mask(port),
diff --git a/drivers/net/dsa/realtek/rtl8365mb_qos.h b/drivers/net/dsa/realtek/rtl8365mb_qos.h
index a3568d47f6c6ee9566074af0ec493ff4bbdbf44b..71949ece4af8fae5c49cf105ddaa3db9bc622cf2 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_qos.h
+++ b/drivers/net/dsa/realtek/rtl8365mb_qos.h
@@ -20,7 +20,8 @@ struct realtek_priv;
 int rtl8365mb_qos_pridec_init(struct realtek_priv *priv);
 int rtl8365mb_qos_qmap_init(struct realtek_priv *priv);
 int rtl8365mb_qos_get_port_prio(struct realtek_priv *priv, int port);
-int rtl8365mb_qos_set_port_prio(struct realtek_priv *priv, int port, u8 iprio);
+int rtl8365mb_qos_set_port_prio(struct realtek_priv *priv, int port, u8 iprio,
+				u8 untag_pcp);
 int rtl8365mb_qos_set_pcp_prio(struct realtek_priv *priv, u8 pcp, u8 iprio);
 int rtl8365mb_qos_set_dscp_prio(struct realtek_priv *priv, u8 dscp, u8 iprio);
 
diff --git a/drivers/net/dsa/realtek/rtl83xx-qos.c b/drivers/net/dsa/realtek/rtl83xx-qos.c
index 0a02e6c4538a919e30e3c35594c7e7e7cdc3cf81..08091586901291e45ad1a2c64730cdcc30298b7a 100644
--- a/drivers/net/dsa/realtek/rtl83xx-qos.c
+++ b/drivers/net/dsa/realtek/rtl83xx-qos.c
@@ -5,7 +5,7 @@
  * is an 802.1Q traffic type. dcbnl uses 802.1p priorities. An 802.1p priority
  * equals the PCP value in the default PCP decoding (IEEE 802.1Q-2022 6.9.3).
  * This layer converts at its edges: every priority it hands a backend is an
- * internal priority.
+ * internal priority, except the 802.1p PCP given to untagged frames.
  *
  * The backend maps internal priorities to its egress queues itself.
  */
@@ -60,6 +60,7 @@ EXPORT_SYMBOL_NS_GPL(rtl83xx_qos_init, "REALTEK_DSA");
 int rtl83xx_qos_init_port(struct dsa_switch *ds, int port)
 {
 	struct realtek_priv *priv = ds->priv;
+	int untag_pcp;
 
 	if (!priv->ops->qos_set_port_prio)
 		return -EOPNOTSUPP;
@@ -68,8 +69,13 @@ int rtl83xx_qos_init_port(struct dsa_switch *ds, int port)
 	if (dsa_is_unused_port(ds, port))
 		return 0;
 
-	/* Best Effort, not internal priority 0, which is Background */
-	return priv->ops->qos_set_port_prio(priv, port, IEEE8021Q_TT_BE);
+	untag_pcp = ieee8021q_tt_to_pcp(IEEE8021Q_TT_BE);
+	if (untag_pcp < 0)
+		return untag_pcp;
+
+	/* iprio is Best Effort, not 0, which is Background */
+	return priv->ops->qos_set_port_prio(priv, port, IEEE8021Q_TT_BE,
+					    untag_pcp);
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_qos_init_port, "REALTEK_DSA");
 
@@ -104,6 +110,6 @@ int rtl83xx_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)
 	if (tt < 0)
 		return tt;
 
-	return priv->ops->qos_set_port_prio(priv, port, tt);
+	return priv->ops->qos_set_port_prio(priv, port, tt, prio);
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_port_set_default_prio, "REALTEK_DSA");

-- 
2.47.3

