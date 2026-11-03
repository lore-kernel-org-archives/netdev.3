Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743415;
	b=VpQzbuXQXjPEPDelllW9zdZXHJUsio+qpD1XWuxI6nr9OHCzRTnd5S/18jM5vply4cMX
	 9tuwBqyJFPR+xzOlQ4i3ccAjlI7DUGPMZ/E6jq65APjyPcKpowgjY6Mq9zEWSaYSZm7Ua
	 Saz+AgxVZrwo7d3GIgMUUf5yoGs/z0pljqZjxB1h8UBGnGEgjS5cnypdgytjHlUWoxVJP
	 cQxBBLi6x0X+WDgXALuV/SubkCx8Sqx4dAZyiMUlwNL6KdNTMDRApemu3SGAhm/SxzOOU
	 RHe8PD0woj7tfxbIiNe1IbeYSHLtmJX61FLaVsGOSJ/HtPwe+Jat7PxtPLjKrMTXhkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743415;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=gq/zpSuLTn3KidqHlvcIOPCkCd5AfWCtDrjfoEhZYkU=;
	b=P4Pb/tj9pJMRqGevs9AKau6xBcyMisLHKS9lLHmvnfEca0RM9bEGkPmS+Mqp1eOiFeBZ
	 Dmp8kYcbrdRf1MhuACOnie0iJcdk4QJOsBdC1w9dh2/pxExSA/GC0s3IHziths2gsr0Ds
	 Hi1ySft6PjHVjEIZIRQ02OvHaL/q+w/UapQY4KlvOKiN7SXb3kBRinCX7zshHp0uGNEhd
	 ikDtlzva6gGw+EG0y84AOlXm3ehQZSbiDmEdsOAOctQVI5lGOFPXNWN72AVTFsIWUCPJC
	 CxnvYscmi4K/SiOS/UFaqnXBNiGHnIQ1m4CSGolk5Rh3AmPZAdbg8ZU3skrJzagKlkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jonasjelonek.de;
	spf=pass smtp.mailfrom=jonasjelonek.de;
	dkim=pass header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=E26Rajfg;
	arc=none smtp.remote-ip=212.227.126.135
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0367E606A326;
	Tue,  3 Nov 2026 22:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0367E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=E26Rajfg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jonasjelonek.de;
	s=s1-ionos; t=1793743405; x=1794348205; i=jonas@jonasjelonek.de;
	bh=gq/zpSuLTn3KidqHlvcIOPCkCd5AfWCtDrjfoEhZYkU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E26RajfgigFhr2H3EYYA/uQI/5xgM3QFjh4I3BXuPExKS/If2qFgMh1uyfhDwZcy
	 r1HKZ4jy1BmO641kgSi0jXzrVs60sPNk0bjDPd65TfyhXNaZJ77Oqd01un5fH41p3
	 UU/W6+cuSkq1qosGXY+jLD16L/q2WnDD/enk2IklkQeblSQCnS0/5p9Ir68rcdt47
	 3nZHb5XSPMYIqpZyxZJGNVaJGy72HyddcK+CkVhWHxMeXkL2gLONxGGuGgVFddnug
	 8pWpiTl3B+T+TRz1SpMwF8dRvAb+N+ENtCPksBq5A4O0WU2bfToegCa291g0UqQAu
	 VOkhSF9OGydjiwTQAA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue010
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1M3UlW-1xNoMx0Xpa-00C7UN; Tue, 03
 Nov 2026 23:03:25 +0100
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
Subject: [PATCH net-next 3/4] net: pse-pd: realtek-pse-mcu: configure global power budget
Date: Tue,  3 Nov 2026 22:03:11 +0000
Message-ID: <20261103220312.860629-4-jonas@jonasjelonek.de>
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
X-Provags-ID: V03:K1:paINqcWZJ5Cqrv3GyoIu5vl2KuKTNaWyb8zy6JuI+F3/gUfgr8g
 /+VliYhLxBcElwwjVB0vPJ/6ulmrzO3CSxEL4kncNt4TEKz/ux5A5zZdJ2PAHLDJopovGvN
 N4+YnjXhgsJusdtZjQfsZUUpuzl3W2D/CbjeYt0RQ6JKa8p+zsAD1ecFPWz6IXoS17IxyKh
 FhsCYpVfNbYPKw9WOgGDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bc1QGgxbPoE=;qZJcgkUo9xLAOYjalRIkXfhGw+X
 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
 Iuyk8J7f8ax3ICWtBnzWM3SMII6jlw==

Use the optional VMAIN regulator power budget to configure the MCU's
aggregate PoE power limit during probe. Quantize the available budget to
the protocol's 100 mW units and reserve exactly that amount through the
regulator core.

The regulator budget represents the usable PoE allowance. Program zero
reserved power so the previous firmware guard band does not further reduce
that allowance.

Require a finite budget of at least one protocol unit when vmain-supply is
provided. Program the budget before selecting dynamic power management and
ungating the ports, so enforcement starts with the regulator-derived limit=
.

Enable VMAIN before hardware initialization and register one managed clean=
up
action to free any reserved budget and release the enable reference on pro=
be
failure and driver removal. Record each successful reservation immediately
so subsequent initialization failures are covered by this action.

Read the current budget index before programming the MCU. Retain the
programmed MCU limit on probe failure and driver removal, as reducing that
limit to zero would interrupt ongoing power delivery.

Boards without vmain-supply retain their existing firmware-managed
budget.

Signed-off-by: Jonas Jelonek <jonas@jonasjelonek.de>
=2D--
 drivers/net/pse-pd/realtek-pse-mcu-core.c | 129 +++++++++++++++++++++-
 drivers/net/pse-pd/realtek-pse-mcu.h      |   3 +
 2 files changed, 129 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/realtek-pse-mcu-core.c b/drivers/net/pse-p=
d/realtek-pse-mcu-core.c
index f3fc67fe29d3..a90e19fb90e0 100644
=2D-- a/drivers/net/pse-pd/realtek-pse-mcu-core.c
+++ b/drivers/net/pse-pd/realtek-pse-mcu-core.c
@@ -34,10 +34,12 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/jiffies.h>
+#include <linux/math.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/pse-pd/pse.h>
+#include <linux/regulator/consumer.h>
 #include <linux/unaligned.h>
=20
 #include "realtek-pse-mcu.h"
@@ -62,6 +64,8 @@
 #define RTPSE_MCU_MAX_PORTS			48
 #define RTPSE_MCU_PORT_MAX_PRIORITY		3
=20
+#define RTPSE_MCU_GLOBAL_BUDGET_LSB_MW		100
+
 /* Bounded resends when the MCU replies NOT_READY (busy). */
 #define RTPSE_MCU_NOT_READY_RETRIES		3
=20
@@ -76,6 +80,8 @@ enum rtpse_mcu_cmd {
 	RTPSE_MCU_CMD_GET_SYSTEM_INFO,
 	RTPSE_MCU_CMD_GET_EXT_CONFIG,
 	RTPSE_MCU_CMD_SET_POWER_MANAGEMENT_MODE,
+	RTPSE_MCU_CMD_GET_POWER_STATUS,
+	RTPSE_MCU_CMD_SET_GLOBAL_BUDGET,
=20
 	RTPSE_MCU_CMD_PORT_ENABLE,
 	RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_TYPE,
@@ -393,6 +399,84 @@ static int rtpse_mcu_set_power_management_mode(struct=
 rtpse_mcu_ctrl *pse, u8 va
 	return (resp.payload[0] =3D=3D 0x0) ? 0 : -EIO;
 }
=20
+static int rtpse_mcu_get_global_budget_idx(struct rtpse_mcu_ctrl *pse, u8=
 *budget_idx)
+{
+	struct rtpse_mcu_msg req, resp;
+	const struct rtpse_mcu_opcode *opc;
+	int ret;
+
+	opc =3D &pse->dialect->opcode[RTPSE_MCU_CMD_GET_POWER_STATUS];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	rtpse_mcu_msg_init(&req, opc->op);
+	ret =3D rtpse_mcu_do_xfer(pse, &req, &resp);
+	if (ret)
+		return ret;
+
+	if (resp.payload[4] > 0x7)
+		return -ERANGE;
+
+	*budget_idx =3D resp.payload[4];
+	return 0;
+}
+
+static int rtpse_mcu_set_global_budget(struct rtpse_mcu_ctrl *pse, u8 bud=
get_idx,
+				       u16 budget_raw)
+{
+	const struct rtpse_mcu_opcode *opc;
+	struct rtpse_mcu_msg req, resp;
+	int ret;
+
+	opc =3D &pse->dialect->opcode[RTPSE_MCU_CMD_SET_GLOBAL_BUDGET];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	rtpse_mcu_msg_init(&req, opc->op);
+	req.payload[0] =3D budget_idx;
+	put_unaligned_be16(budget_raw, &req.payload[1]);
+	put_unaligned_be16(0, &req.payload[3]);
+
+	ret =3D rtpse_mcu_do_xfer(pse, &req, &resp);
+	if (ret)
+		return ret;
+	if (resp.payload[0] !=3D budget_idx || resp.payload[1] !=3D 0)
+		return -EIO;
+
+	return 0;
+}
+
+static int rtpse_mcu_apply_global_budget(struct rtpse_mcu_ctrl *pse,
+					 struct regulator *vmain)
+{
+	int budget, ret;
+	u16 budget_raw;
+	u8 budget_idx;
+
+	budget =3D regulator_get_unclaimed_power_budget(vmain);
+	if (budget =3D=3D INT_MAX)
+		return -ENODATA;
+	if (budget < 0 || budget > U16_MAX * RTPSE_MCU_GLOBAL_BUDGET_LSB_MW)
+		return -ERANGE;
+
+	budget =3D rounddown(budget, RTPSE_MCU_GLOBAL_BUDGET_LSB_MW);
+	if (!budget)
+		return -ERANGE;
+	budget_raw =3D budget / RTPSE_MCU_GLOBAL_BUDGET_LSB_MW;
+
+	ret =3D regulator_request_power_budget(vmain, budget);
+	if (ret)
+		return ret;
+	pse->requested_budget_mW =3D budget;
+
+	ret =3D rtpse_mcu_get_global_budget_idx(pse, &budget_idx);
+	if (ret)
+		return ret;
+
+	/* Retain the programmed MCU limit even if later probe steps fail. */
+	return rtpse_mcu_set_global_budget(pse, budget_idx, budget_raw);
+}
+
 /* Port operations */
=20
 static int rtpse_mcu_port_get_status(struct rtpse_mcu_ctrl *pse, unsigned=
 int port,
@@ -801,6 +885,15 @@ static int rtpse_mcu_discover(struct rtpse_mcu_ctrl *=
pse, struct rtpse_mcu_info
 	return 0;
 }
=20
+static void rtpse_mcu_cleanup_vmain(void *data)
+{
+	struct rtpse_mcu_ctrl *pse =3D data;
+
+	if (pse->requested_budget_mW)
+		regulator_free_power_budget(pse->vmain, pse->requested_budget_mW);
+	regulator_disable(pse->vmain);
+}
+
 static void rtpse_mcu_global_disable(void *data)
 {
 	struct rtpse_mcu_ctrl *pse =3D data;
@@ -813,6 +906,7 @@ int rtpse_mcu_register(struct rtpse_mcu_ctrl *pse)
 	const struct rtpse_mcu_match_data *match;
 	struct rtpse_mcu_info info;
 	struct gpio_desc *gpiod;
+	struct regulator *vmain;
 	int ret;
=20
 	BUILD_BUG_ON(sizeof(struct rtpse_mcu_msg) !=3D RTPSE_MCU_MSG_SIZE);
@@ -837,6 +931,25 @@ int rtpse_mcu_register(struct rtpse_mcu_ctrl *pse)
 		return dev_err_probe(pse->dev, -EINVAL,
 				     "dialect for chip is incomplete\n");
=20
+	vmain =3D devm_regulator_get_optional(pse->dev, "vmain");
+	if (PTR_ERR(vmain) =3D=3D -ENODEV)
+		vmain =3D NULL;
+	else if (IS_ERR(vmain))
+		return dev_err_probe(pse->dev, PTR_ERR(vmain),
+				     "failed to get vmain supply\n");
+
+	if (vmain) {
+		ret =3D regulator_enable(vmain);
+		if (ret)
+			return dev_err_probe(pse->dev, ret,
+					     "failed to enable vmain supply\n");
+
+		pse->vmain =3D vmain;
+		ret =3D devm_add_action_or_reset(pse->dev, rtpse_mcu_cleanup_vmain, pse=
);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * Release the MCU from reset before the first transaction; the
 	 * boot-retry loop in discover() waits for it to answer.
@@ -850,6 +963,13 @@ int rtpse_mcu_register(struct rtpse_mcu_ctrl *pse)
 	if (ret)
 		return ret;
=20
+	if (vmain) {
+		ret =3D rtpse_mcu_apply_global_budget(pse, vmain);
+		if (ret)
+			return dev_err_probe(pse->dev, ret,
+					     "failed to apply global power budget\n");
+	}
+
 	/* ensure the MCU does dynamic power management with priorities */
 	ret =3D rtpse_mcu_set_power_management_mode(pse, RTPSE_MCU_POWER_MGMT_DY=
NAMIC_PRIO);
 	if (ret)
@@ -858,9 +978,8 @@ int rtpse_mcu_register(struct rtpse_mcu_ctrl *pse)
=20
 	/*
 	 * Some boards gate all ports through a hardware line; deassert it only
-	 * after the MCU is confirmed, so a discover failure never ungates the
-	 * ports. It is then left to the MCU - not re-gated on unbind or a later
-	 * probe error - so a driver reload doesn't black out PoE.
+	 * after discovery, budget setup and management-mode selection succeed.
+	 * Do not reassert it on unbind or a later probe error.
 	 */
 	gpiod =3D devm_gpiod_get_optional(pse->dev, "disable-ports", GPIOD_OUT_L=
OW);
 	if (IS_ERR(gpiod))
@@ -975,6 +1094,8 @@ static const struct rtpse_mcu_dialect rtpse_mcu_diale=
ct_gen2 =3D {
 		[RTPSE_MCU_CMD_GET_SYSTEM_INFO]		=3D RTPSE_MCU_OP(0x40),
 		[RTPSE_MCU_CMD_GET_EXT_CONFIG]		=3D RTPSE_MCU_OP(0x4a),
 		[RTPSE_MCU_CMD_SET_POWER_MANAGEMENT_MODE] =3D RTPSE_MCU_OP(0x10),
+		[RTPSE_MCU_CMD_GET_POWER_STATUS]	=3D RTPSE_MCU_OP(0x41),
+		[RTPSE_MCU_CMD_SET_GLOBAL_BUDGET]	=3D RTPSE_MCU_OP(0x04),
=20
 		[RTPSE_MCU_CMD_PORT_ENABLE]		=3D RTPSE_MCU_OP(0x01),
 		[RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_TYPE] =3D RTPSE_MCU_OP(0x12),
@@ -996,6 +1117,8 @@ static const struct rtpse_mcu_dialect rtpse_mcu_diale=
ct_gen1 =3D {
 		[RTPSE_MCU_CMD_GET_SYSTEM_INFO]		=3D RTPSE_MCU_OP(0x20),
 		[RTPSE_MCU_CMD_GET_EXT_CONFIG]		=3D RTPSE_MCU_OP(0x2b),
 		[RTPSE_MCU_CMD_SET_POWER_MANAGEMENT_MODE] =3D RTPSE_MCU_OP(0x17),
+		[RTPSE_MCU_CMD_GET_POWER_STATUS]	=3D RTPSE_MCU_OP(0x23),
+		[RTPSE_MCU_CMD_SET_GLOBAL_BUDGET]	=3D RTPSE_MCU_OP(0x18),
=20
 		[RTPSE_MCU_CMD_PORT_ENABLE]		=3D RTPSE_MCU_OP(0x00),
 		[RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_TYPE] =3D RTPSE_MCU_OP(0x15),
diff --git a/drivers/net/pse-pd/realtek-pse-mcu.h b/drivers/net/pse-pd/rea=
ltek-pse-mcu.h
index 5e31dd0993dd..56899ec4d76f 100644
=2D-- a/drivers/net/pse-pd/realtek-pse-mcu.h
+++ b/drivers/net/pse-pd/realtek-pse-mcu.h
@@ -62,6 +62,7 @@ static inline bool rtpse_mcu_resp_is_final(const struct =
rtpse_mcu_msg *req,
 struct rtpse_mcu_dialect;
 struct rtpse_mcu_chip_info;
 struct rtpse_mcu_ctrl;
+struct regulator;
=20
 /* Per-compatible match data (the of_match .data). */
 struct rtpse_mcu_match_data {
@@ -82,6 +83,8 @@ struct rtpse_mcu_ctrl {
 	const struct rtpse_mcu_dialect *dialect;
 	const struct rtpse_mcu_chip_info *chip;
 	const struct rtpse_mcu_transport_ops *transport;
+	struct regulator *vmain;
+	unsigned int requested_budget_mW;
 	u8 seq;			/* rolling request seq_num, echoed by the MCU */
 };
=20
=2D-=20
2.53.0

