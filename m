Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472677;
	b=sdAoPJe3DTakowRjDb4VNK1Cuokul2Vg9K+0iR/Jx4OaZ9PRK9UtUOIWs2VqreheGjA2
	 20O8VsH3G3Od5JrNehc9gml+lenoLa2j0s9JwlIH1WXqzhqe/vOmBls7WVtIIBjV8MNhB
	 1C/cvxtc2LRaFd+px3kH3DlezWwd5jjWotvMMSCHwuaLsZzq32phOZtXL7Gt24Kdqieem
	 NdxQ4VUUdGmWeAA9Yi6L0ThmHEXUOgKiy5wGjdqbd+cRQ+HaPBsVpy8sM6RXN+CcJIhRy
	 FAAIZMLQ/c6FhJP7OnR5jlD7ISOwiWJ+d/Q2hC1T5w3MglfVjLAD+ZGAYG7gl25HwIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472677;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=XXMGwQsYizNLnUe2v/zGi4EH5z9PqXTWn118mziKXJk=;
	b=OdijprcMTYdM6sI+IZ0w3BD763JdnGENMCezM/lweicfjo/Fu4wvO1JThD4cF14paabo
	 svwlQ1KLC0chIrYD9wf5s9nN7MQBStGyHxkPusCWQLyLaeEUD2tNY0gcI13MVsxwDa7HL
	 LPbEcxRTY44yoTnqN0StZxJjDYYHJybPX1zkvHXme6T7QFhjf7y+wKdPpH11kewX6dcQj
	 rhO2Nhxmzzqd0ML3VBXOIl7Ild7efqRV6aSozcLcujadxJOxkOd/oxi1lq3M1E20Xw2qk
	 O2Jaf6uS/PUqmhZOwhJZRlihZJeiMq9Q+LeFAwYK9/yNluvyIXQFG4Z/aJ8H1lCrvxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="bncrrTM/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7764060707A0;
	Thu, 12 Nov 2026 08:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7764060707A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=bncrrTM/
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7E3F1202C8B;
	Thu, 12 Nov 2026 09:37:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXMGwQsYizNLnUe2v/zGi4EH5z9PqXTWn118mziKXJk=;
	b=bncrrTM/tpkzk1y5xzhzH3bqguL+PJYyKFD4W9OUOLh093rfhBAFz47FJ82pOqdk717wae
	05ZyFqa9RgABjStP1D8okRbR3Xi1xdKCtbSrEwF7Lqf7to1eEHw7xzV/oGFas4LJYVTZNo
	QgySP+iFyc3RWtveGOoxq+Ppj+K2nDbdPd0Op3W9vG1ZFKEFrkAdg1eBqfcOqj1cqfdgpv
	8rZtAq6ULDokFPRQGnHJazF8NlTt4vf74yKsb3uJryF3mEAhip54W0PuX/JFX5XD6SR+0i
	JcnqCUSXwIGlAYO5C2hJA1Mk4HTZZ6qxTvGPWXay+cnHJnzGxB4+ZkAJdcw4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXMGwQsYizNLnUe2v/zGi4EH5z9PqXTWn118mziKXJk=;
	b=das9aUNZvt+bERafWGB+rRgz/EUorxFmDiCXba67n0/ttaAA3jCH1bIDeFGAZY4MyAVm6B
	rvI253yzxlq1/Q4egTHkuieEjvXa9gsmG01w4ZDLnKLnWqoxzXJiJGLqyRTuSU0ep6OXAB
	78Osi8TClZhtLXPKRNHZ0GNsyFxjSfzYJn/raXeQzCVO3BRWDos4zVMZFtpVMaPTZ7uhXg
	4t6EWPHD6IUnkcYb9VPMqbAveijNPbtZHNgZHWqjQWfCgWDK927o5R5IntEOux2CQkasuS
	NkXW//7RfYmwi6HiPtPgg1zXNNHGnkcYUSBMcVw2FfgliUUeiwFfWbqhIHAFog==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794472671; a=rsa-sha256;
	cv=none;
	b=d+h9MYBqeP+CmrdIZ7DI4C4sJ2JwDhPG8UpfhSOpdUxVTpvgTEECkRRaRxElAf8dd8/XMV
	kLQ2haIKFtUxdwFssUTml4Zi01PMiE02qNnz9rjwF/H2fJofkQ6TxhEeJDZjQc0vLfcWdK
	YJXDksOESo78tQq72NTcElt6LOrLlQrXzZHT/01OuiwHmA8AcAV67hiFXZAI+7awsqzJHo
	Myorwh06hTGYSnXlc+deOwWWg8NLGL5/3S8AaAuEqqjO0KwLCPr5oMHZYEIKZ9BUTf31xM
	Y8LtPjYEQcRLv8CeInxcOqriLj3zmHVHnmIRPHQrkKAuaOYjn8sDH8htOjYu9Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 5A7EF3814A3; Thu, 12 Nov 2026 09:37:51 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Thu, 12 Nov 2026 09:37:48 +0100
Subject: [PATCH net-next v2 05/10] net: dsa: realtek: rtl8365mb: describe
 the ports of each chip
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
Message-Id: <20261112-rtl8365mb-dcb-ingress-v2-5-f8e6fbdf8c99@pengutronix.de>
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

Record which ports each chip has, report one more than its highest
port to DSA as the port count, and reject a devicetree port the chip
does not have. Lower the family maximum to 8 to match.

Commit ca5ecd4246d4 ("net: dsa: realtek: rtl8365mb: correct the max
number of ports") raised the port count of all chips to 11, but no
supported chip has a port above 7.

Since commit 51a4a22301b0 ("net: dsa: realtek: rtl8365mb: use dsa
helpers for port iteration"), setup also programs unused ports, so
every probe writes per-port registers of ports 8..10. Their learn-limit
writes go to 0x0A28..0x0A2A, above the learn-limit registers of ports
0..7. We have not seen a visible effect from these writes.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Changes in v2:
- New in v2. The QoS patches after it handle ports 0..7 only.
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index da06f952a053d1497647a2c6f15a861fc21860f9..1e6cdc61f6bd3b3f74e422dbbcfdcb67cc0532a7 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -115,7 +115,7 @@
 #define RTL8365MB_PHYADDRMAX		7
 #define RTL8365MB_NUM_PHYREGS		32
 #define RTL8365MB_PHYREGMAX		(RTL8365MB_NUM_PHYREGS - 1)
-#define RTL8365MB_MAX_NUM_PORTS		11
+#define RTL8365MB_MAX_NUM_PORTS		8
 /* Valid for the whole family except RTL8370B, which has 4160 entries.
  * RTL8370B is mentioned in vendor code but it might not even belong
  * to the same RTL8367C family.
@@ -707,6 +707,7 @@ struct rtl8365mb_extint {
  * @name: human-readable chip name
  * @chip_id: chip identifier
  * @chip_ver: chip silicon revision
+ * @port_mask: ports the chip has
  * @extints: available external interfaces
  * @jam_table: chip-specific initialization jam table
  * @jam_size: size of the chip's jam table
@@ -719,6 +720,7 @@ struct rtl8365mb_chip_info {
 	const char *name;
 	u32 chip_id;
 	u32 chip_ver;
+	u32 port_mask;
 	const struct rtl8365mb_extint extints[RTL8365MB_MAX_NUM_EXTINTS];
 	const struct rtl8365mb_jam_tbl_entry *jam_table;
 	size_t jam_size;
@@ -726,11 +728,20 @@ struct rtl8365mb_chip_info {
 
 /* Chip info for each supported switch in the family */
 #define PHY_INTF(_mode) (RTL8365MB_PHY_INTERFACE_MODE_ ## _mode)
+#define PORT_MASK(_m) \
+	((_m) + \
+	 BUILD_BUG_ON_ZERO((_m) & ~GENMASK(RTL8365MB_MAX_NUM_PORTS - 1, 0)))
+
+/* Copper ports are 0..3 on the RTL8365MB-VC and 0..4 on the others. Extension
+ * interfaces are port 6 on the VC and ports 6 and 7 on the others, as the
+ * extints rows show.
+ */
 static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 	{
 		.name = "RTL8365MB-VC",
 		.chip_id = 0x6367,
 		.chip_ver = 0x0040,
+		.port_mask = PORT_MASK(GENMASK(3, 0) | BIT(6)),
 		.extints = {
 			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) },
@@ -742,6 +753,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.name = "RTL8367S",
 		.chip_id = 0x6367,
 		.chip_ver = 0x00A0,
+		.port_mask = PORT_MASK(GENMASK(4, 0) | BIT(6) | BIT(7)),
 		.extints = {
 			{ 6, 1, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
 			{ 7, 2, PHY_INTF(MII) | PHY_INTF(TMII) |
@@ -754,6 +766,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.name = "RTL8367SB",
 		.chip_id = 0x6367,
 		.chip_ver = 0x0010,
+		.port_mask = PORT_MASK(GENMASK(4, 0) | BIT(6) | BIT(7)),
 		.extints = {
 			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) |
@@ -768,6 +781,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.name = "RTL8367RB-VB",
 		.chip_id = 0x6367,
 		.chip_ver = 0x0020,
+		.port_mask = PORT_MASK(GENMASK(4, 0) | BIT(6) | BIT(7)),
 		.extints = {
 			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) },
@@ -3140,6 +3154,16 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		dev_info(priv->dev, "no interrupt support\n");
 
 	dsa_switch_for_each_port(dp, ds) {
+		if (dsa_port_is_unused(dp))
+			continue;
+
+		if (!(mb->chip_info->port_mask & BIT(dp->index))) {
+			dev_err(priv->dev, "port %d does not exist on %s\n",
+				dp->index, mb->chip_info->name);
+			ret = -EINVAL;
+			goto out_teardown_irq;
+		}
+
 		/* Cascading (DSA links) is not supported yet.
 		 * Historically, the driver has always been broken
 		 * without a dedicated CPU port because CPU tagging
@@ -3349,7 +3373,7 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 
 	dev_info(priv->dev, "found an %s switch\n", mb->chip_info->name);
 
-	priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
+	priv->num_ports = fls(mb->chip_info->port_mask);
 	mb->priv = priv;
 	mb->cpu.trap_port = RTL8365MB_MAX_NUM_PORTS;
 	mb->cpu.insert = RTL8365MB_CPU_INSERT_TO_ALL;

-- 
2.47.3

