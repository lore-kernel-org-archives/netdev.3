Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB19427FBF;
	Mon, 21 Sep 2026 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007565; cv=none; b=onDsgu9bqIwlCqT0bSe0sIsyntUuNJldLBbtljeQnV+NiSkEWIXtM0AVVfVxaQoU8yle/utN2svJEgnKS+t9+xo9Jj9S7oJxX3dUk+NWLrtj3DZN0dXXR6ReMjhLnXG0ek5IfjTQEn4F4uZNvugr7hRNeHb1dRoRxxD8KVrPet4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007565; c=relaxed/simple;
	bh=oeCO+v7fNM5KTV5sAaLeGlTHPLLd/AV5Bs9zK/WDLVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVMd9wstj+WQa2h5jJdoRFUbGUdm0FlZC6+E4B5iUnV/e/XdsZWn+0alrmsY5IsgaT+LK89R0OoXEQbWNJ5gXQrjL+qTen2eW+ixQT6U3/XK5aOY7t/PPQr7klep8p+mTntG4RyjX/AUdjUKhxXbzYw3R1hWViikKKq/avFzHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SGYJK5B6; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SGYJK5B6"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hpT2J1cR7zMlGJ;
	Mon, 21 Sep 2026 18:19:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790007560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsVGfcwq8Q6m8URuxO/CCkmwXeLUMEyKJp/gAc4kZEc=;
	b=SGYJK5B6Al38O6s3vdB/qL59Le1F3uWGCLOz+v//dSYqdtxkidh4ukqAMI3ZYmMiFOzDZq
	Zg8MxmQ7fM1Azi3vxQkR2bxewWqTnXGjM/i5vSDQG+1c2uwRFcRyn3VOlmesDvkyVIl05E
	5sqeEEnuu1O841i6gb23/El13uyr0PDfrm62oq6xB324VtTmH9wP1VyPWlMQ2qfSkCK9lr
	vtlWIxeF4uUdRQEqeZgSesEzmH7Z7q7ZF6BO3l/ZKPPC7JEH2GXSHMACYfTRJpvhIksxZO
	nTZ22QgLk8X+2F31iAIBuNfq5ZEsjtezEesVx4Zyh7Vocu0nic6UblfuUVNMbQ==
From: Simon Polack <spolack+git@mailbox.org>
To: andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: f.fainelli@gmail.com,
	javen_xu@realsil.com.cn,
	chad@monroe.io,
	vladimir.oltean@nxp.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] net: phy: realtek: add LED support for RTL8261C/D
Date: Mon, 21 Sep 2026 18:18:17 +0200
Message-ID: <20260921161817.565185-4-spolack+git@mailbox.org>
In-Reply-To: <20260921161817.565185-1-spolack+git@mailbox.org>
References: <20260921161817.565185-1-spolack+git@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6ohhx57ocn7is86qpo9q4b513styo75c
X-MBO-RS-ID: 9a657350ea5382c8198

From: Chad Monroe <chad@monroe.io>

The RTL8261C/D use the same LED register block as the RTL8221B: one
control register per LED at VEND2 0xd032 + 2 * index selecting the link
speeds that light it, activity blink bits in LCR6 and per-LED polarity
and enable bits in LCR7. Compared to the RTL8221B there are four LEDs
instead of three, and two more speed bits for 5G and 10G.

Reuse the existing RTL822X_VND2_* definitions and add the two speed bits
and the enable bit. The callbacks follow rtl822xb_led_*() closely, with
two additions:

 - led_polarity_set() honours active-low LEDs. The polarity bit in LCR7
   doubles as the manual on/off level in led_brightness_set(), so the
   configured polarity is cached in the private data and restored by
   led_hw_control_set().

 - led_hw_control_set() and led_brightness_set() set the output enable
   bit, which firmware normally leaves set already.

The callbacks duplicate most of rtl822xb_led_*(), differing only in the
LED count, the speed mask and the LCR7 handling. Making the RTL8221B code
table-driven and sharing it would be the right end state, but that
touches a working driver and wants testing on an RTL8221B, so it is left
for a follow-up series.

The callbacks are wired to the RTL8261C_CG and RTL8261CE_CG entries,
which between them cover the parts this was tested on. RTL8261D_VM is
left out for lack of hardware.

Tested on a Gemtek W1700K (Airoha AN7581) with an RTL8261CE: index 2
drives a yellow and index 3 a green LED on each 10G port. Under hardware
control the link speed bits, the activity blink and the combined
TRIGGER_NETDEV_LINK all take effect and offloading is confirmed through
the netdev trigger. The polarity bit was verified to be active-high when
clear on that board. Also tested on AN7581 and MT7988A boards with an
RTL8261C and RTL8261D.

Signed-off-by: Chad Monroe <chad@monroe.io>
Co-developed-by: Simon Polack <spolack+git@mailbox.org>
Signed-off-by: Simon Polack <spolack+git@mailbox.org>
Assisted-by: LLM
---
 drivers/net/phy/realtek/realtek_main.c | 228 +++++++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 04d397f0a2d8..b1f020aa7760 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -183,12 +183,15 @@
 #define RTL822X_VND2_LCR_LINK_100		BIT(1)
 #define RTL822X_VND2_LCR_LINK_1000		BIT(2)
 #define RTL822X_VND2_LCR_LINK_2500		BIT(5)
+#define RTL822X_VND2_LCR_LINK_5000		BIT(6)
+#define RTL822X_VND2_LCR_LINK_10000		BIT(4)
 
 #define RTL822X_VND2_LCR6			0xd040
 #define RTL822X_VND2_LED_ACT(x)			BIT(x)
 
 #define RTL822X_VND2_LCR7			0xd044
 #define RTL822X_VND2_LED_POLAR(x)		BIT(x)
+#define RTL822X_VND2_LED_EN(x)			BIT((x) + 4)
 
 #define RTL8224_MII_RTCT			0x11
 #define RTL8224_MII_RTCT_ENABLE			BIT(0)
@@ -305,6 +308,7 @@
 #define FW_SUB_MAGIC_8261D		0x32363144
 #define RTL8261X_POLL_TIMEOUT_MS	100
 #define RTL8261X_MAX_MMD_DEV		31
+#define RTL8261X_LED_COUNT		4
 
 #define RTL8261C_CE_FW_NAME	"rtl_nic/rtl8261c.bin"
 #define RTL8261D_FW_NAME	"rtl_nic/rtl8261d.bin"
@@ -364,6 +368,11 @@ struct rtl8261x_priv {
 	const char *fw_name;
 	u32 fw_sub_magic;
 	bool fw_loaded;
+	/* LCR7's polarity bit doubles as the manual on/off level in
+	 * led_brightness_set(), so the configured polarity is kept here
+	 * to restore it whenever hardware control is set up again.
+	 */
+	u8 led_active_low;
 };
 
 static int rtl821x_read_page(struct phy_device *phydev)
@@ -2530,6 +2539,215 @@ static int rtl822xb_led_brightness_set(struct phy_device *phydev, u8 index,
 					  RTL822X_VND2_LED_POLAR(index));
 }
 
+static int rtl8261x_led_hw_is_supported(struct phy_device *phydev, u8 index,
+					unsigned long rules)
+{
+	const unsigned long act_mask = BIT(TRIGGER_NETDEV_RX) |
+				       BIT(TRIGGER_NETDEV_TX);
+	const unsigned long link_mask = BIT(TRIGGER_NETDEV_LINK) |
+					BIT(TRIGGER_NETDEV_LINK_10) |
+					BIT(TRIGGER_NETDEV_LINK_100) |
+					BIT(TRIGGER_NETDEV_LINK_1000) |
+					BIT(TRIGGER_NETDEV_LINK_2500) |
+					BIT(TRIGGER_NETDEV_LINK_5000) |
+					BIT(TRIGGER_NETDEV_LINK_10000);
+
+	if (index >= RTL8261X_LED_COUNT)
+		return -EINVAL;
+
+	/* Filter out any other unsupported triggers. */
+	if (rules & ~(link_mask | act_mask))
+		return -EOPNOTSUPP;
+
+	/* RX and TX are not differentiated, they are not possible
+	 * without combination with a link trigger.
+	 */
+	if ((rules & act_mask) && !(rules & link_mask))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int rtl8261x_led_hw_control_get(struct phy_device *phydev, u8 index,
+				       unsigned long *rules)
+{
+	const u16 all_links = RTL822X_VND2_LCR_LINK_10 |
+			      RTL822X_VND2_LCR_LINK_100 |
+			      RTL822X_VND2_LCR_LINK_1000 |
+			      RTL822X_VND2_LCR_LINK_2500 |
+			      RTL822X_VND2_LCR_LINK_5000 |
+			      RTL822X_VND2_LCR_LINK_10000;
+	int val;
+
+	if (index >= RTL8261X_LED_COUNT)
+		return -EINVAL;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LED(index));
+	if (val < 0)
+		return val;
+
+	if (val & RTL822X_VND2_LCR_LINK_10)
+		__set_bit(TRIGGER_NETDEV_LINK_10, rules);
+
+	if (val & RTL822X_VND2_LCR_LINK_100)
+		__set_bit(TRIGGER_NETDEV_LINK_100, rules);
+
+	if (val & RTL822X_VND2_LCR_LINK_1000)
+		__set_bit(TRIGGER_NETDEV_LINK_1000, rules);
+
+	if (val & RTL822X_VND2_LCR_LINK_2500)
+		__set_bit(TRIGGER_NETDEV_LINK_2500, rules);
+
+	if (val & RTL822X_VND2_LCR_LINK_5000)
+		__set_bit(TRIGGER_NETDEV_LINK_5000, rules);
+
+	if (val & RTL822X_VND2_LCR_LINK_10000)
+		__set_bit(TRIGGER_NETDEV_LINK_10000, rules);
+
+	if ((val & all_links) == all_links)
+		__set_bit(TRIGGER_NETDEV_LINK, rules);
+
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LCR6);
+	if (val < 0)
+		return val;
+
+	if (val & RTL822X_VND2_LED_ACT(index)) {
+		__set_bit(TRIGGER_NETDEV_RX, rules);
+		__set_bit(TRIGGER_NETDEV_TX, rules);
+	}
+
+	return 0;
+}
+
+static int rtl8261x_led_hw_control_set(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	struct rtl8261x_priv *priv = phydev->priv;
+	u16 lcr7 = RTL822X_VND2_LED_EN(index);
+	u16 val = 0;
+	bool act;
+	int ret;
+
+	if (index >= RTL8261X_LED_COUNT)
+		return -EINVAL;
+
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_10, &rules))
+		val |= RTL822X_VND2_LCR_LINK_10;
+
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_100, &rules))
+		val |= RTL822X_VND2_LCR_LINK_100;
+
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_1000, &rules))
+		val |= RTL822X_VND2_LCR_LINK_1000;
+
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_2500, &rules))
+		val |= RTL822X_VND2_LCR_LINK_2500;
+
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_5000, &rules))
+		val |= RTL822X_VND2_LCR_LINK_5000;
+
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_10000, &rules))
+		val |= RTL822X_VND2_LCR_LINK_10000;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+			    RTL822X_VND2_LED(index), val);
+	if (ret < 0)
+		return ret;
+
+	act = test_bit(TRIGGER_NETDEV_RX, &rules) ||
+	      test_bit(TRIGGER_NETDEV_TX, &rules);
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LCR6,
+			     RTL822X_VND2_LED_ACT(index), act ?
+			     RTL822X_VND2_LED_ACT(index) : 0);
+	if (ret < 0)
+		return ret;
+
+	/* Enable the output and restore the configured polarity, which
+	 * led_brightness_set() may have used as a level.
+	 */
+	if (priv->led_active_low & BIT(index))
+		lcr7 |= RTL822X_VND2_LED_POLAR(index);
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LCR7,
+			      RTL822X_VND2_LED_EN(index) |
+			      RTL822X_VND2_LED_POLAR(index), lcr7);
+}
+
+static int rtl8261x_led_brightness_set(struct phy_device *phydev, u8 index,
+				       enum led_brightness value)
+{
+	struct rtl8261x_priv *priv = phydev->priv;
+	u16 lcr7 = RTL822X_VND2_LED_EN(index);
+	bool active_low, on;
+	int ret;
+
+	if (index >= RTL8261X_LED_COUNT)
+		return -EINVAL;
+
+	/* clear HW LED setup */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+			    RTL822X_VND2_LED(index), 0);
+	if (ret < 0)
+		return ret;
+
+	/* clear HW LED blink */
+	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LCR6,
+				 RTL822X_VND2_LED_ACT(index));
+	if (ret < 0)
+		return ret;
+
+	/* With no link condition selected the output sits at its idle
+	 * level, so inverting the polarity turns the LED on.
+	 */
+	active_low = priv->led_active_low & BIT(index);
+	on = value != LED_OFF;
+	if (on != active_low)
+		lcr7 |= RTL822X_VND2_LED_POLAR(index);
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LCR7,
+			      RTL822X_VND2_LED_EN(index) |
+			      RTL822X_VND2_LED_POLAR(index), lcr7);
+}
+
+static int rtl8261x_led_polarity_set(struct phy_device *phydev, int index,
+				     unsigned long modes)
+{
+	struct rtl8261x_priv *priv = phydev->priv;
+	bool active_low = false;
+	u32 mode;
+
+	if (index >= RTL8261X_LED_COUNT)
+		return -EINVAL;
+
+	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
+		switch (mode) {
+		case PHY_LED_ACTIVE_LOW:
+			active_low = true;
+			break;
+		case PHY_LED_ACTIVE_HIGH:
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (active_low)
+		priv->led_active_low |= BIT(index);
+	else
+		priv->led_active_low &= ~BIT(index);
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LCR7,
+			      RTL822X_VND2_LED_POLAR(index),
+			      active_low ? RTL822X_VND2_LED_POLAR(index) : 0);
+}
+
 static int rtl822xb_led_hw_is_supported(struct phy_device *phydev, u8 index,
 					unsigned long rules)
 {
@@ -3494,6 +3712,11 @@ static struct phy_driver realtek_drvs[] = {
 		.soft_reset		= genphy_c45_pma_soft_reset,
 		.suspend		= genphy_c45_pma_suspend,
 		.resume			= genphy_c45_pma_resume,
+		.led_brightness_set	= rtl8261x_led_brightness_set,
+		.led_hw_is_supported	= rtl8261x_led_hw_is_supported,
+		.led_hw_control_get	= rtl8261x_led_hw_control_get,
+		.led_hw_control_set	= rtl8261x_led_hw_control_set,
+		.led_polarity_set	= rtl8261x_led_polarity_set,
 	}, {
 		PHY_ID_MATCH_EXACT(RTL_8261CE_CG),
 		.name			= "Realtek RTL8261CE 10Gbps PHY",
@@ -3507,6 +3730,11 @@ static struct phy_driver realtek_drvs[] = {
 		.soft_reset		= genphy_c45_pma_soft_reset,
 		.suspend		= genphy_c45_pma_suspend,
 		.resume			= genphy_c45_pma_resume,
+		.led_brightness_set	= rtl8261x_led_brightness_set,
+		.led_hw_is_supported	= rtl8261x_led_hw_is_supported,
+		.led_hw_control_get	= rtl8261x_led_hw_control_get,
+		.led_hw_control_set	= rtl8261x_led_hw_control_set,
+		.led_polarity_set	= rtl8261x_led_polarity_set,
 	}, {
 		PHY_ID_MATCH_EXACT(RTL_8261D_VM),
 		.name			= "Realtek RTL8261D_VM 10Gbps PHY",
-- 
2.55.0

