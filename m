Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746CC403B18;
	Mon, 31 Aug 2026 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179807; cv=none; b=PwSmqYY6ZVOHrP5z6BfG44x04qSDbay3kToN8Kwg9Yp0mUFYeOZ69rSnlU4XU9iUDG+vE85RyKVP7X0D3ZRVeRZzkW5Iuls21rv7mgRe1mX2xNErEwkWKRNCUthp7/y8Efkt7x//qf7HdvlpP0xD/xOjdH2FpkN8MKbLMBGtHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179807; c=relaxed/simple;
	bh=bWZYzoUkeCVFaOw6aIX8ZrlgzHm9ShTXB7JuQWG74XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5e02P3hmYqSfbfOwMtD4TeYsvU+1Jaz6EYoPkKAy4R6LaSs971AXd8O47jOqL99QwRrDdecMreTq83KHltD903gdQ8pWAKVlIoJWd6wg9v4gIgIKvFHfJh9vla8wRDd9f9UHHPnKCQmIUfPh5DGJLWnRvevUhabIL1kBkk9ukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 490E4202476;
	Mon, 31 Aug 2026 14:36:38 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1x11Fe-004G6Z-0Z;
	Mon, 31 Aug 2026 14:36:38 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1x11Fe-00000002nON-0PFS;
	Mon, 31 Aug 2026 14:36:38 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v3 2/3] net: dsa: realtek: rtl83xx: add support for enabling supplies
Date: Mon, 31 Aug 2026 14:36:36 +0200
Message-ID: <20260831123637.666457-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831123637.666457-1-o.rempel@pengutronix.de>
References: <20260831123637.666457-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

The power supplies powering the IC may not necessarily be enabled by the
time the driver probes.  The binding describes the power rails, so enable
them at probe with devm_regulator_bulk_get_enable(), before the reset line
is requested and driven, so the chip is powered before its pins are driven.

Boards that do not describe these supplies fall back to dummy regulators
(with a "supply not found" warning) and keep working as before.

A board that describes supplies but no reset line still needs to wait for
the chip to boot before the first register access, so apply the existing
start delay in that case too.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
Anticipated reviewer questions:

Q: Why devm_regulator_bulk_get_enable() rather than a per-supply loop over
   devm_regulator_get_enable_optional()?
A: regulator_get_optional() must only be used for supplies that may be
   physically absent; these rails are always physically present, so the
   normal (non-optional) get is the correct API.  Boards that do not
   describe the rails fall back to dummy regulators - a dummy-supply
   message, not a functional change or a regression; many systems boot
   with such messages.  Hiding the message with a per-supply _optional
   loop would be a buggy use of the API.

Q: On unbind or probe failure the devres unwind disables the rails after
   the reset GPIO/control have been released, leaving the chip unpowered
   with its reset pin still driven by the SoC - back-powering.  Should a
   devm_add_action_or_reset() assert reset before the rails drop?
A: Not in this patch.  Asserting reset on teardown reopens the decision of
   commit 4f580e9aced1 ("net: dsa: realtek: do not assert reset on
   remove"), which intentionally stopped doing it, and would have to be
   gated so rtl8366rb - the chip that commit was about - is not changed.
   It is also only a partial mitigation: the SoC keeps driving the
   MDIO/RGMII pins regardless of the reset state.  And these rails are
   usually fixed/always-on, so disabling them is a no-op; the window only
   exists on a design that genuinely gates them, where power-down
   sequencing is a board-level concern.  Teardown sequencing is out of
   scope here and, if needed, belongs in a separate, dedicated change.

Q: var->num_supplies is a per-variant constant (6 for every rtl8365mb), so
   the start delay also fires on boards that describe no rails and fall
   back to dummy regulators, where nothing was really powered.
A: Intentional.  After enabling the rails - real or dummy - the driver has
   no way to know the chip is ready, so it waits REALTEK_HW_START_DELAY
   before the first register access.  The delay is harmless and only
   closes a race; a variant that declares no supplies (num_supplies == 0)
   is unaffected.

Q: Why only rtl8365mb_variant, not rtl8366rb?
A: The rail list is taken from the RTL8365MB datasheet.  rtl8366rb has a
   different set and no in-tree board describes them, so it declares none
   (num_supplies stays 0) and its probe/teardown are unchanged.  The
   companion dt-bindings patch likewise restricts the *-supply properties
   to the realtek,rtl8365mb compatible.

Changes since v2:
- No change

Changes since v1:
- Enable the rails with devm_regulator_bulk_get_enable() instead of a
  per-supply loop over devm_regulator_get_enable_optional(); the optional
  API is only for physically-absent supplies (Mark Brown), and undescribed
  rails fall back to dummy regulators, which is expected rather than a
  regression.
- Describe the rails as a counted array (num_supplies) rather than a
  NULL-terminated list, matching the bulk API.
---
 drivers/net/dsa/realtek/realtek.h        |  3 +++
 drivers/net/dsa/realtek/rtl8365mb_main.c |  6 ++++++
 drivers/net/dsa/realtek/rtl83xx.c        | 17 ++++++++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 6e0148cee8d8..75a127545e5d 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -166,6 +166,9 @@ struct realtek_variant {
 	u8 cmd_read;
 	u8 cmd_write;
 	size_t chip_data_sz;
+	/* Regulator supplies to enable at probe, or NULL */
+	const char *const *supplies;
+	int num_supplies;
 };
 
 /* RTL8366 library helpers */
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 728231d8f94c..4c305756116c 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -3334,6 +3334,10 @@ static const struct realtek_ops rtl8365mb_ops = {
 	.phy_write = rtl8365mb_phy_write,
 };
 
+static const char *const rtl8365mb_supplies[] = {
+	"avddh", "avddl", "dvddio", "dvddio1", "dvddl", "pllvddl",
+};
+
 const struct realtek_variant rtl8365mb_variant = {
 	.ds_ops = &rtl8365mb_switch_ops,
 	.ops = &rtl8365mb_ops,
@@ -3342,6 +3346,8 @@ const struct realtek_variant rtl8365mb_variant = {
 	.cmd_read = 0xb9,
 	.cmd_write = 0xb8,
 	.chip_data_sz = sizeof(struct rtl8365mb),
+	.supplies = rtl8365mb_supplies,
+	.num_supplies = ARRAY_SIZE(rtl8365mb_supplies),
 };
 
 static const struct of_device_id rtl8365mb_of_match[] = {
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index a96beea72ef5..d6d243131fd2 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -2,6 +2,7 @@
 
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/of_mdio.h>
 #include <linux/if_bridge.h>
 #include <linux/etherdevice.h>
@@ -195,7 +196,16 @@ rtl83xx_probe(struct device *dev,
 	priv->leds_disabled = of_property_read_bool(dev->of_node,
 						    "realtek,disable-leds");
 
-	/* TODO: if power is software controlled, set up any regulators here */
+	/* Enable the supplies before the reset line is requested and driven,
+	 * so the chip is powered before its pins are driven.
+	 */
+	if (var->num_supplies) {
+		ret = devm_regulator_bulk_get_enable(dev, var->num_supplies,
+						     var->supplies);
+		if (ret)
+			return dev_err_ptr_probe(dev, ret, "failed to enable supplies\n");
+	}
+
 	priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
 	if (IS_ERR(priv->reset_ctl))
 		return dev_err_cast_probe(dev, priv->reset_ctl,
@@ -216,6 +226,11 @@ rtl83xx_probe(struct device *dev,
 		rtl83xx_reset_deassert(priv);
 		msleep(REALTEK_HW_START_DELAY);
 		dev_dbg(dev, "deasserted RESET\n");
+	} else if (var->num_supplies) {
+		/* Powered but no reset line: still wait for the chip to boot
+		 * before the first register access.
+		 */
+		msleep(REALTEK_HW_START_DELAY);
 	}
 
 	return priv;
-- 
2.47.3

