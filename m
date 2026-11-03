Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743417;
	b=n6LwcZHZb7iD7DTiFCAXa7VON8DUIFYaqfP1POBPz6UGSyDms5/actLt1bDbl7zEOP01
	 2xyjpPjE3lprTpFLW2asoSawTsVnI+M8K2C/O4QUBGr0plChEQqnZcKjbbR3u4wUBM1iL
	 KVpQDm2sLPu8wzhyhitUt4+pNbAUwMHx0owfCRHvLgLFDkKkYAwYS6ZlaX/RsNrpSK2yk
	 Nid2+Ceurc/cI2gCAMjuZtx9rJElnl7yfR19QI6TaatWKjOdVkhSjl8OjNRjwYeIEeVwo
	 ax6lGcDe6tqFOcB5UydeGRBYdfgPzV8zmNXp8ud0NhafgFPsz6rcU1s2rElbCntfmzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743417;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=F3cx05ZtubPDkSq0whu2ARJ3LjNuVkF9QXbZmD6nM9Q=;
	b=5e/yX7mxEh2vvclUBfolSLIqxlI2gERvVmuVMEEmqCYsaDJutYp4XkIEvB+tPKFqdPhk
	 sic2ubHWXtTe7kuKTzG5QWHU2naD7MIrCggdw1S26CjEQzOJ8UAjIv/AU9rsUIeF//V0U
	 zCj9RvWQ9nCdoodUM0U8XJtoYjdq8Cd2g+kCF1E2lu/uo/GmHw6x58otGRPvaGTk3sM5u
	 ng69XyejDNr1wC/eeDwuWf8277HX6njjza3EWPMSLF7F6OfuL58wgnDWR7uyPYo4MeL4M
	 +9mmOZ2v6SWL6GSpoxRIRNKYWVZJStwnhWfZhfIp/vFGACGZxn7sv4t91q5Fzz2HIgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jonasjelonek.de;
	spf=pass smtp.mailfrom=jonasjelonek.de;
	dkim=pass header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=e7Sut6US;
	arc=none smtp.remote-ip=212.227.126.134
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F1D606D83A;
	Tue,  3 Nov 2026 22:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92F1D606D83A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=e7Sut6US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jonasjelonek.de;
	s=s1-ionos; t=1793743403; x=1794348203; i=jonas@jonasjelonek.de;
	bh=F3cx05ZtubPDkSq0whu2ARJ3LjNuVkF9QXbZmD6nM9Q=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=e7Sut6USZD1c8g99dYDGXumu8OAPmEK+ug1tRcDXfWPWMo4ewwEplVha1VbK/sij
	 6oUznZoD9Qdr+c8M/cVPkPV80FKaxY2UiqXxg4aJCQ3Y11nkCjdnGObwpCnBCN2X7
	 1poXdTzqWjRhBny07GESFgWirT/E95ZqpSwnYHR7fCe8cfME7hwzAzDVZhbMiqP6Y
	 lriYGc1GHoXRUwH7CFYDOCzX3GNa+J0rjCytQBgTtUcsfXI0um1gK/NAFmEcyYGbK
	 ka0DwGHFA8J5RCO2SyEML8rQeSKMJxXT4Qc+NhZVaSPiUXH8wQSPEh2u0CVjJ0Pig
	 erpjoWoqauutvSaFZw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue010
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1M5wgF-1xQGHI1QVv-00EaSc; Tue, 03
 Nov 2026 23:03:23 +0100
From: Jonas Jelonek <jonas@jonasjelonek.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Sander Vanheule <sander@svanheule.net>,
	Russell Senior <russell@personaltelco.net>,
	Jonas Jelonek <jonas@jonasjelonek.de>
Subject: [PATCH net-next 1/4] net: pse-pd: realtek-pse-mcu: ensure MCU does dynamic power management
Date: Tue,  3 Nov 2026 22:03:09 +0000
Message-ID: <20261103220312.860629-2-jonas@jonasjelonek.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103220312.860629-1-jonas@jonasjelonek.de>
References: <20261103220312.860629-1-jonas@jonasjelonek.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wvzMAiBJW6753VRCX+JjnmfJZs66fs+l/Bwt7UnHASnp2BUA1i+
 FFuIMmkbgvHUwHUjrWzf3m2myDvGM2FmcdiIvuitFo+u4bsapi7RbKYZzZIrshaRWk5ELEv
 qUmpdLCSbPpGPgMJ7ADmV3TW5q6dsENned+etzWZlYe44acji3il+Ui/8QhYY6exgZgCsBz
 /KgbYHOaeIAcEFWD6bsYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s3TNunU2s8o=;o8yMxUUfeyCl8Ufj+YEzAjth2Hj
 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

From: Russell Senior <russell@personaltelco.net>

The MCU may have any power management mode configuration by default
but the driver should ensure that the MCU performs dynamic power
management with priorities as advertised. On certain devices, the
default MCU configuration ships with another default, possibly
preventing any power delivery.

Select the mode before deasserting the hardware port gate, so a failure
to establish the management policy does not ungate the ports.

Signed-off-by: Russell Senior <russell@personaltelco.net>
[jonas@jonasjelonek.de: adjust commit message, macro naming and comment;
 change error handling and select the mode before ungating ports]
Signed-off-by: Jonas Jelonek <jonas@jonasjelonek.de>
=2D--
 drivers/net/pse-pd/realtek-pse-mcu-core.c | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/pse-pd/realtek-pse-mcu-core.c b/drivers/net/pse-p=
d/realtek-pse-mcu-core.c
index c70b09ca2012..f3fc67fe29d3 100644
=2D-- a/drivers/net/pse-pd/realtek-pse-mcu-core.c
+++ b/drivers/net/pse-pd/realtek-pse-mcu-core.c
@@ -68,10 +68,14 @@
 /* Nominal PSE rail; 802.3at/bt operating range. */
 #define RTPSE_MCU_PSE_VOLTAGE_UV		54000000
=20
+/* RTPSE_MCU_CMD_SET_POWER_MANAGEMENT_MODE values */
+#define RTPSE_MCU_POWER_MGMT_DYNAMIC_PRIO	0x02	/* dynamic, with port prio=
rity */
+
 enum rtpse_mcu_cmd {
 	RTPSE_MCU_CMD_SET_GLOBAL_STATE,
 	RTPSE_MCU_CMD_GET_SYSTEM_INFO,
 	RTPSE_MCU_CMD_GET_EXT_CONFIG,
+	RTPSE_MCU_CMD_SET_POWER_MANAGEMENT_MODE,
=20
 	RTPSE_MCU_CMD_PORT_ENABLE,
 	RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_TYPE,
@@ -369,6 +373,26 @@ static int rtpse_mcu_set_global_state(struct rtpse_mc=
u_ctrl *pse, bool enable)
 	return (resp.payload[0] =3D=3D 0x0) ? 0 : -EIO;
 }
=20
+static int rtpse_mcu_set_power_management_mode(struct rtpse_mcu_ctrl *pse=
, u8 value)
+{
+	struct rtpse_mcu_msg req, resp;
+	const struct rtpse_mcu_opcode *opc;
+	int ret;
+
+	opc =3D &pse->dialect->opcode[RTPSE_MCU_CMD_SET_POWER_MANAGEMENT_MODE];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	rtpse_mcu_msg_init(&req, opc->op);
+	req.payload[0] =3D value;
+
+	ret =3D rtpse_mcu_do_xfer(pse, &req, &resp);
+	if (ret)
+		return ret;
+
+	return (resp.payload[0] =3D=3D 0x0) ? 0 : -EIO;
+}
+
 /* Port operations */
=20
 static int rtpse_mcu_port_get_status(struct rtpse_mcu_ctrl *pse, unsigned=
 int port,
@@ -826,6 +850,12 @@ int rtpse_mcu_register(struct rtpse_mcu_ctrl *pse)
 	if (ret)
 		return ret;
=20
+	/* ensure the MCU does dynamic power management with priorities */
+	ret =3D rtpse_mcu_set_power_management_mode(pse, RTPSE_MCU_POWER_MGMT_DY=
NAMIC_PRIO);
+	if (ret)
+		return dev_err_probe(pse->dev, ret,
+				     "failed to set power management mode\n");
+
 	/*
 	 * Some boards gate all ports through a hardware line; deassert it only
 	 * after the MCU is confirmed, so a discover failure never ungates the
@@ -944,6 +974,7 @@ static const struct rtpse_mcu_dialect rtpse_mcu_dialec=
t_gen2 =3D {
 		[RTPSE_MCU_CMD_SET_GLOBAL_STATE]	=3D RTPSE_MCU_OP(0x00),
 		[RTPSE_MCU_CMD_GET_SYSTEM_INFO]		=3D RTPSE_MCU_OP(0x40),
 		[RTPSE_MCU_CMD_GET_EXT_CONFIG]		=3D RTPSE_MCU_OP(0x4a),
+		[RTPSE_MCU_CMD_SET_POWER_MANAGEMENT_MODE] =3D RTPSE_MCU_OP(0x10),
=20
 		[RTPSE_MCU_CMD_PORT_ENABLE]		=3D RTPSE_MCU_OP(0x01),
 		[RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_TYPE] =3D RTPSE_MCU_OP(0x12),
@@ -964,6 +995,7 @@ static const struct rtpse_mcu_dialect rtpse_mcu_dialec=
t_gen1 =3D {
 	.opcode =3D {
 		[RTPSE_MCU_CMD_GET_SYSTEM_INFO]		=3D RTPSE_MCU_OP(0x20),
 		[RTPSE_MCU_CMD_GET_EXT_CONFIG]		=3D RTPSE_MCU_OP(0x2b),
+		[RTPSE_MCU_CMD_SET_POWER_MANAGEMENT_MODE] =3D RTPSE_MCU_OP(0x17),
=20
 		[RTPSE_MCU_CMD_PORT_ENABLE]		=3D RTPSE_MCU_OP(0x00),
 		[RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_TYPE] =3D RTPSE_MCU_OP(0x15),
=2D-=20
2.53.0

