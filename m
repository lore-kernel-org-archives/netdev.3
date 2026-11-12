Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472677;
	b=bvWzI30IH75eaCcAelPnMmQGpshmlAE4iUaY0urJPkABrDSHS2Vvu5frs5SY67CpqFRl
	 cGmkOTysEdBikWL4w0icokJgRzajN6NQAf28RCtg/GLrWmZ9hvh9z+ZDdiOPMLxvb85EB
	 6y0TAT0Q6IUHoCdHdWiha+NvcmTEpJ5xg5f/AVLQ+5jSe7sgM/Ab6Eb2L7ZMja5s8FDzn
	 je76d3CusDTluMuJiwV3JTU7lZik4WWSNEyP/obhuaGDjzTcZFEMD1JwwmHHMeIQx+/4s
	 AVOuGmWmKFZwuIpGZKpr+A/hxzrZ0sANoqdKCQ4YGl9PcIcNDjz9vfLzGz8r+WOsxdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472677;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=kRI4WsBi3xbIAUAaP4bW07lW5LiltFJqKkHpCiletDE=;
	b=3BSvRynHX8+8qjOImjcA2H1i9rXmiwrLMCAzR1fSyIMFVjq44SW4tT6GV2l1JIeXfG+9
	 94K5qblRTk24gFSeXnPr9sLH9mxVT3iFKsMhgfMOjw3qvTtAPLaBRvLgzgGi8l4E6cbIb
	 mgOekaIj3/Xa+RrqmHFZi1Hy4byucTywcDUWoH8tYVEyh2WjnMtFPk84yyhle8RqNxfc3
	 FgcMmqWngH+Kwd1lIXRQqOquk3TuVSMrVscJxTsUpS0/5BRJkhzGu5UZ0zQt+WcDv8OlA
	 GLduCi2socIbdCoB6m2BF4PJFuF7EigEqSolSFMcC++KL81BvuecavSVxN/u9sxU/7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ey9tu5oN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BFC607079D;
	Thu, 12 Nov 2026 08:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73BFC607079D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ey9tu5oN
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 975E92058D5;
	Thu, 12 Nov 2026 09:37:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRI4WsBi3xbIAUAaP4bW07lW5LiltFJqKkHpCiletDE=;
	b=ey9tu5oNmQiYSz1hBBPKoFV/SsaEX0TUjDybOjuiL9pfQcAgWhrNsO0b9RffuC50GR5dzD
	hxuNZsSZSIZ9i1R8T9jtF39R1epWOYqqPwcYUP1KfZOWuhLPUHRdCli9JCXP0Yxur0d8B1
	YD4Na2eLn7GdZHKAvwiTOpx6nx1VmLSUFIge73yRrGuP5oUMUXPDGl+AK+7qHTTIO8cryf
	pcC8y/ji4jeVWUQR0HkoV259GZQPT/uB/45wg+GHbhVlZrCMusD6/UNCjyljas07bzEkHl
	TYvTwXEbjByBTIyPLsBOo+27KvlQtC+dqLQB8Tc4fDrsA6bBWAzIzPCOuaFxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRI4WsBi3xbIAUAaP4bW07lW5LiltFJqKkHpCiletDE=;
	b=Y7pJ8eBhAvKBSJyn9N7DQk3ko+q9LYNRiB8itOO009GX7ulJWMIyRghrF1A+wTP+dtzdGe
	a6AjVVCQ8NVAst9Y5vG41dfjb2Zk6uyyUlJNrjpEDzx0OnjcWNJKEtsC5O4Oq89sZmjF7l
	RoI4pkhINaToSMJFUfaFzfXra1JfvVhrH795ZKAXpXFOBCN966wzyLNN4PrCSRFf015xst
	2DMazboTzCTuzeLyb9achYl9xYwzlCdmXWIybWyN/WnLrIeuEZ7coq5Ha3mcPozZg59+TB
	I/8VLdWPQXuK7C9jmnU3SMKxHrZnMDb8rmyFdI17FQ5UXOkC/CssIFms+R6Rlw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794472671; a=rsa-sha256;
	cv=none;
	b=bhhtZmAhl8Yq7eMLRVG2/QYGpoaYphWCHNxGumxfA0y6OkNPnd3uTDpZX54eacDAwxnNGp
	UfPUCsW91ohJwaZZnSfxgzoC94V3HM1Ynjr8yzuDEB9Q5ZQi4PlOjj2APCHTa3u2140lB/
	DcNnbq0IWvMygRXOczwdpbszpiJB6YdL9b0wPVVkxVcc/ApfqdnHoLPG5lYcCuxdi+Ic77
	YpZBo0KP03hCuyJVUbPPL9S5YMl+k6nHOXKh5vFwaP90EvuweEsdCZ7/LXsJAn32gLTvwx
	9O08gVBc5jXWld3501pVsx+eBsmCVH1BS6LRIzwU1f+4OW6y8HaB0tWMxojYiw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 63A19381E59; Thu, 12 Nov 2026 09:37:51 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Thu, 12 Nov 2026 09:37:53 +0100
Subject: [PATCH net-next v2 10/10] net: dsa: realtek: rtl8365mb: report the
 DCB DSCP-to-priority map
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
Message-Id: <20261112-rtl8365mb-dcb-ingress-v2-10-f8e6fbdf8c99@pengutronix.de>
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

Report the DSCP-to-priority map through dcbnl, so that "dcb app show"
lists, on every port, the priority a DSCP value gets once the port
trusts DSCP.

The switch has one DSCP-to-priority table for all its ports, with
exactly one priority per DSCP value. dcbnl, in contrast, configures DSCP
priorities per port and allows several priorities for one DSCP value.
DSA could mirror a change to every port (dscp_prio_mapping_is_global),
but a request on one port would still change the classification of all
ports. Keep the map read-only. The QoS baseline seeds it with the
default mapping from ietf_dscp_to_ieee8021q_tt(). Requests to change a
DSCP entry fail with -EOPNOTSUPP.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Q: The v1 review (Linus) suggested DSCP get, add and delete callbacks
in the common code, and setting ds->dscp_prio_mapping_is_global when
registering DSCP offload. Why are add, delete and the flag gone in v2?
A: The DSCP get moved into the shared code as asked. Add and del were
dropped because the table is chip-wide, as the commit message explains.
Without add and del, nothing would use the flag, so it is not set.

Changes in v2:
- make the DSCP map read-only, as the table is shared by all ports of
  the chip and per-port remapping would change every port
- drop the DSCP add/del ops, whose delete path could leave the hardware
  out of step with the remaining APP entries (sashiko)
- do not set ds->dscp_prio_mapping_is_global; without DSCP add/del
  nothing needs its global set/del path (sashiko)
- retitled (was "offload DCB DSCP-to-priority")
- move the DSCP get handling into rtl83xx-qos.c behind a new
  qos_get_dscp_prio callback (Linus)
- DSCP table seeding moved to the baseline patch
- read the table entry through rtl8365mb_qos_regmap_read_field(), which
  uses field_get() (Luiz)
---
 drivers/net/dsa/realtek/realtek.h        |  1 +
 drivers/net/dsa/realtek/rtl8365mb_main.c |  2 ++
 drivers/net/dsa/realtek/rtl8365mb_qos.c  |  7 +++++++
 drivers/net/dsa/realtek/rtl8365mb_qos.h  |  1 +
 drivers/net/dsa/realtek/rtl83xx-qos.c    | 19 +++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx-qos.h    |  1 +
 6 files changed, 31 insertions(+)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 0008ba9681cccb521d85d9bfc97425ad1b777aa6..6f2bdeab703a7758e01f983b8907c9421c89fa52 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -181,6 +181,7 @@ struct realtek_ops {
 	int	(*qos_set_port_prio)(struct realtek_priv *priv, int port,
 				     u8 iprio, u8 untag_pcp);
 	int	(*qos_set_pcp_prio)(struct realtek_priv *priv, u8 pcp, u8 iprio);
+	int	(*qos_get_dscp_prio)(struct realtek_priv *priv, u8 dscp);
 	int	(*qos_set_dscp_prio)(struct realtek_priv *priv, u8 dscp,
 				     u8 iprio);
 	/* @trust is indexed by enum rtl83xx_apptrust_slot and has @n entries.
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index d16e7c99217bdc01d1bdf7dbbcb8e7ed1441e6a8..9377bdbae36c487cf11dc48e77f23ca9f78565dc 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -3483,6 +3483,7 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.port_set_default_prio = rtl83xx_port_set_default_prio,
 	.port_get_apptrust = rtl83xx_port_get_apptrust,
 	.port_set_apptrust = rtl83xx_port_set_apptrust,
+	.port_get_dscp_prio = rtl83xx_port_get_dscp_prio,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.port_fast_age = rtl83xx_port_fast_age,
 	.port_fdb_add = rtl83xx_port_fdb_add,
@@ -3528,6 +3529,7 @@ static const struct realtek_ops rtl8365mb_ops = {
 	.qos_get_port_prio = rtl8365mb_qos_get_port_prio,
 	.qos_set_port_prio = rtl8365mb_qos_set_port_prio,
 	.qos_set_pcp_prio = rtl8365mb_qos_set_pcp_prio,
+	.qos_get_dscp_prio = rtl8365mb_qos_get_dscp_prio,
 	.qos_set_dscp_prio = rtl8365mb_qos_set_dscp_prio,
 	.qos_set_apptrust = rtl8365mb_qos_set_apptrust,
 	.qos_get_apptrust = rtl8365mb_qos_get_apptrust,
diff --git a/drivers/net/dsa/realtek/rtl8365mb_qos.c b/drivers/net/dsa/realtek/rtl8365mb_qos.c
index c465d639ee5e527a604498fb064d6757aac1fda4..095f4a77bd1c666528b5fa9f57aa427114ebefb3 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_qos.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_qos.c
@@ -255,6 +255,13 @@ int rtl8365mb_qos_set_pcp_prio(struct realtek_priv *priv, u8 pcp, u8 iprio)
 						 iprio);
 }
 
+int rtl8365mb_qos_get_dscp_prio(struct realtek_priv *priv, u8 dscp)
+{
+	return rtl8365mb_qos_regmap_read_field(priv,
+					       RTL8365MB_QOS_DSCP_PRI_REG(dscp),
+					       rtl8365mb_qos_sel_mask(dscp));
+}
+
 int rtl8365mb_qos_set_dscp_prio(struct realtek_priv *priv, u8 dscp, u8 iprio)
 {
 	return rtl8365mb_qos_regmap_update_field(priv,
diff --git a/drivers/net/dsa/realtek/rtl8365mb_qos.h b/drivers/net/dsa/realtek/rtl8365mb_qos.h
index eed5ea5fa7f345ce6989e3e890d7cd755da9d0fc..9602807f7db5b9c5bf0202612e4cd77b85079cb7 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_qos.h
+++ b/drivers/net/dsa/realtek/rtl8365mb_qos.h
@@ -23,6 +23,7 @@ int rtl8365mb_qos_get_port_prio(struct realtek_priv *priv, int port);
 int rtl8365mb_qos_set_port_prio(struct realtek_priv *priv, int port, u8 iprio,
 				u8 untag_pcp);
 int rtl8365mb_qos_set_pcp_prio(struct realtek_priv *priv, u8 pcp, u8 iprio);
+int rtl8365mb_qos_get_dscp_prio(struct realtek_priv *priv, u8 dscp);
 int rtl8365mb_qos_set_dscp_prio(struct realtek_priv *priv, u8 dscp, u8 iprio);
 int rtl8365mb_qos_set_apptrust(struct realtek_priv *priv, int port,
 			       const bool *trust, unsigned int n);
diff --git a/drivers/net/dsa/realtek/rtl83xx-qos.c b/drivers/net/dsa/realtek/rtl83xx-qos.c
index b25a9dfb9138b5c2c176dbe68974cdd65e1643bb..f4b7866c7f70ba5ea74f5d8631a9b66afcf50728 100644
--- a/drivers/net/dsa/realtek/rtl83xx-qos.c
+++ b/drivers/net/dsa/realtek/rtl83xx-qos.c
@@ -134,6 +134,25 @@ int rtl83xx_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_port_set_default_prio, "REALTEK_DSA");
 
+int rtl83xx_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
+{
+	struct realtek_priv *priv = ds->priv;
+	int tt;
+
+	if (!priv->ops->qos_get_dscp_prio)
+		return -EOPNOTSUPP;
+
+	if (dscp >= DSCP_MAX)
+		return -EINVAL;
+
+	tt = priv->ops->qos_get_dscp_prio(priv, dscp);
+	if (tt < 0)
+		return tt;
+
+	return ieee8021q_tt_to_pcp(tt);
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_port_get_dscp_prio, "REALTEK_DSA");
+
 int rtl83xx_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel,
 			      int *nsel)
 {
diff --git a/drivers/net/dsa/realtek/rtl83xx-qos.h b/drivers/net/dsa/realtek/rtl83xx-qos.h
index fbddc7b7d9dd37918423afc5373b684596637a05..06dbfd24b1af5cced870f463f15b1b39eceb56ee 100644
--- a/drivers/net/dsa/realtek/rtl83xx-qos.h
+++ b/drivers/net/dsa/realtek/rtl83xx-qos.h
@@ -15,5 +15,6 @@ int rtl83xx_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel,
 			      int *nsel);
 int rtl83xx_port_set_apptrust(struct dsa_switch *ds, int port, const u8 *sel,
 			      int nsel);
+int rtl83xx_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp);
 
 #endif /* _RTL83XX_QOS_H */

-- 
2.47.3

