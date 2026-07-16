Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721D41BA8F
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201915; cv=none; b=i4qfYcW9LpZK/COLzA3VbQDMChCnTM51VbeJldY8nPtMqzDtJuqPwc6NEuqBbBjEqmiLLiTmX06MVGDdi+qJ3xgiyp1wkW+3TCX5PK/KqcXCEbURKvGC6hRkfchObS0mYvSsMKffkoXKwChL9yv/+97eiGB7iwRXqSycBryT+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201915; c=relaxed/simple;
	bh=+uX6VH4MaeXqyIpWtKttc+U15n9sP7oiB7CQo4sViY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3PrQVB3jjRju1/uQWF8WycUAiJQ9JzgsdrAJjeQT96wWKAlfNuODeHh0+ULqIH5rL3a6jlr46Bnk5PQHqSY6CK6Xnr1veXLUGxBqybVn3eDAAXqGduykntlgusFbky/qmgwsjugacFyRfoSDZMexIteEkxn0L53zFKJkSxzIII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZATraUNL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZATraUNL"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4728c12ba97so3077931f8f.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 04:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784201909; x=1784806709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pH6sjVLA7RFqUAztfLCPtY5QoA0xWGEeQAwcgmyd0L8=;
        b=ZATraUNL4VfN5cdVnTjnOak7qeOp6ymm8QgKH5O+V6AcqnkRnNW4yu2XKOoudNehUo
         POcHKur1dBEipSnYfesFfhkFzW7HU2WCFDX9Qk3R2upsaR+C4yvaFEU4SafP1LAgx9ec
         7BHHZCPwGR7rplyv8lPP9y69RNSvlecnw3EOUdJP1M0nU44W0lzKAvCJKN2+vVVR09F7
         sCIGjYGR/AsgGXzo2ehf5AyHXP+2Ffh+iMVPVxHeLdiAHTl2Jrg9OuSO6dfnndcr4pzy
         YKjVtyboxx/FaJ5y+EOGzh0QLnl2p5wiq2PRbp3az6E0gQ3+mZV/HT4Q43i+Q3d0I/tt
         NXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784201909; x=1784806709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pH6sjVLA7RFqUAztfLCPtY5QoA0xWGEeQAwcgmyd0L8=;
        b=mVpNbFEnnTtMix8hb+0PQvfxZynzyOscU2zvtVGx3dwNk2f7c/U29ZhYW7w7g8fnqN
         X3rdskBXSbQotj0fF+rlkRLRICoevOl+aJRJB8IMFCxC2U8j9amJaioT8CX+XuiaZj8n
         ORpKeEsoXXO6GLByQ0OTE023xe5y0spIu3QNTa6j6ViDCWAsv430329xhj9q+32m+iu5
         muCwEqYbzPoOlX0r62TrbB70mQwCiKrWWa/r67LpliM/hMeob7AGHsOrr7PMLbGMbYby
         uppSOULa8C7IjKl/NaNiQk9EIaI06OM4498H9VFvTRp64JcRAWr9ETIeVXR9mMuaDjMq
         Um2Q==
X-Gm-Message-State: AOJu0YyiDFRnKnHTsIaXOZi+bEWu7caOMS88x02Ly2I+zlpSE2cwgd5Q
	6dAn8JK9EYBv87hbt8CyGR+Kl3oDZq/iKD8lRguroFaseha7O3DH9gF3LtB1yA==
X-Gm-Gg: AfdE7ckZxDsSxKG0QqDDjR+h1EuO0sXk3AQD8rGpf0qXkjht6qgmSCgBAnM0V1oAbnR
	TEtB+TfbbSwUQajaJp+hIFn8G9ME9PzAHnpAmxjgoxMFqXnfh++NBIH9jlUs51atdfn6Bm6XFJP
	vLiFNLJrqmDkNxlnN6GdB1SjOnzv+DiPNHwWEhRUM+FmaJ8aivm8fv8ZR/RiDKdBG4+vYZYfToP
	NxTNSHWdS3R+OjKZJzZDLbPZxJThTPQM3LyMbrlSbMqqZj4SP9OS7sm75zlgGmhyfamynAe8SB2
	TI4zFvlCvq7w9hViwYhRsHz6aqhitKkcdRKA4hIjCq67p5XJBAa8zuWVtmVSjQdkoLVyXQLx55w
	UHmuFHjWQ8yNj7kmw+MFUfPnvKf7Pw6dX7mzzDi+L8KSoohqEuXOOE7H4GCPsv20hNTaEi9rtmW
	IOXojvNGi/HhQRszqdyI4=
X-Received: by 2002:a05:600c:8483:b0:493:c8a6:b517 with SMTP id 5b1f17b1804b1-4953c3944d9mr76318225e9.38.1784201908949;
        Thu, 16 Jul 2026 04:38:28 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e83bcbsm49217165e9.4.2026.07.16.04.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 04:38:28 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net: phy: add DAPU Telecom DAP8210R(I) Gigabit Ethernet PHY driver
Date: Thu, 16 Jul 2026 14:38:04 +0300
Message-ID: <20260716113805.593215-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716113805.593215-1-a.shimko.dev@gmail.com>
References: <20260716113805.593215-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new PHY driver for the DAPU Telecom DAP8211R(I) Gigabit
Ethernet PHY, which is commonly used in enterprise and industrial
networking applications.

The driver implements extended register access via indirect addressing
through corresponding registers, and provides comprehensive device tree
support for RGMII delay configuration. The rx-internal-delay-ps and
tx-internal-delay-ps properties allow precise tuning of clock delays in
150 ps steps from 0 to 2250 ps. Additionally, the optional
dapu,tx-inverted-clk flag enables 180-degree TX clock phase shift for
boards where signal integrity or MAC requirements necessitate clock
inversion.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/net/phy/Kconfig    |  10 ++
 drivers/net/phy/Makefile   |   1 +
 drivers/net/phy/dap8211r.c | 281 +++++++++++++++++++++++++++++++++++++
 3 files changed, 292 insertions(+)
 create mode 100644 drivers/net/phy/dap8211r.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 099f25dceabb..4576f707ac94 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -237,6 +237,16 @@ config DAVICOM_PHY
 	help
 	  Currently supports dm9161e and dm9131
 
+config DAP8211R_PHY
+	tristate "DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY"
+	depends on OF
+	help
+	  Support for the DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY.
+	  This PHY is designed for enterprise and industrial networking
+	  applications, supporting 10/100/1000 Mbps operation.
+	  RGMII with: configurable TX/RX clock delays, optional flag to enable
+	  180-degree TX clock phase shift and internal packet generator.
+
 config ICPLUS_PHY
 	tristate "ICPlus PHYs"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index de660ae94945..ad35733eb4bb 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_BROADCOM_PHY)	+= broadcom.o
 obj-$(CONFIG_CICADA_PHY)	+= cicada.o
 obj-$(CONFIG_CORTINA_PHY)	+= cortina.o
 obj-$(CONFIG_DAVICOM_PHY)	+= davicom.o
+obj-$(CONFIG_DAP8211R_PHY)	+= dap8211r.o
 obj-$(CONFIG_DP83640_PHY)	+= dp83640.o
 obj-$(CONFIG_DP83822_PHY)	+= dp83822.o
 obj-$(CONFIG_DP83848_PHY)	+= dp83848.o
diff --git a/drivers/net/phy/dap8211r.c b/drivers/net/phy/dap8211r.c
new file mode 100644
index 000000000000..e1e6a322ef0c
--- /dev/null
+++ b/drivers/net/phy/dap8211r.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL
+/*
+ * Driver for the DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY.
+ *
+ * Specifications:
+ *   - IEEE 802.3 10BASE-Te, 100BASE-TX, 1000BASE-T
+ *   - IEEE 802.3az-2010 Energy Efficient Ethernet
+ *   - IEEE 1588 SyncE support
+ *   - RGMII
+ *
+ * Author: Artem Shimko <a.shimko.dev@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/errno.h>
+#include <linux/ethtool.h>
+#include <linux/kernel.h>
+#include <linux/mii.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+
+#define DAP8211R_PHY_ID			0x0008011B
+#define DAP8211R_PHY_ID_MASK		0xFFFFFFFF
+
+#define DAP8211R_EXT_ADD		0x1E
+#define DAP8211R_EXT_DATA		0x1F
+
+#define DAP8211R_PHY_CON		0xA001
+#define DAP8211R_PHY_SW_RST		BIT(15)
+
+#define DAP8211R_RGMII_CON		0xA003
+#define DAP8211R_RGMII_TX_DEL_MASK	GENMASK(3, 0)
+#define DAP8211R_RGMII_RX_DEL_MASK	GENMASK(13, 10)
+#define DAP8211R_RGMII_CLK_INVERT	BIT(14)
+
+/* Default RGMII delay: 13 * 150 == 1.95ns */
+#define DAP8211R_DEFAULT_DELAY_SEL	0xD
+
+struct dap8211r_delay_config {
+	u32 ps;
+	u8 sel;
+};
+
+static const struct dap8211r_delay_config delay_config[] = {
+	{   0, 0},
+	{ 150, 1},
+	{ 300, 2},
+	{ 450, 3},
+	{ 600, 4},
+	{ 750, 5},
+	{ 900, 6},
+	{1050, 7},
+	{1200, 8},
+	{1350, 9},
+	{1500, 10},
+	{1650, 11},
+	{1800, 12},
+	{1950, 13},
+	{2100, 14},
+	{2250, 15},
+};
+
+#define DAP8211R_DELAY_COUNT	ARRAY_SIZE(delay_config)
+
+/**
+ * dap8211r_delay_ps_to_sel() - Convert ps to register value (exact match only)
+ * @ps: Delay in picoseconds
+ *
+ * Converts a delay value in picoseconds to the corresponding register value
+ * for RGMII delay configuration. The PHY supports specific values from
+ * 0 to 2250 ps in 150 ps steps.
+ *
+ * Return: Register value (0-15) on success, -EINVAL if @ps is not supported.
+ */
+
+static int dap8211r_delay_ps_to_sel(u32 ps)
+{
+	for (int i = 0; i < DAP8211R_DELAY_COUNT; i++)
+		if (ps == delay_config[i].ps)
+			return delay_config[i].sel;
+
+	return -EINVAL;
+}
+
+/**
+ * dap8211r_read_ext() - Read extended register
+ * @phydev: PHY device structure
+ * @reg: Extended register address
+ *
+ * Reads a PHY extended register using the indirect access method.
+ * The caller must hold the MDIO bus lock.
+ *
+ * Return: Register value on success, or negative error code
+ */
+static int dap8211r_read_ext(struct phy_device *phydev, u16 reg)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = __phy_write(phydev, DAP8211R_EXT_ADD, reg);
+	if (ret < 0)
+		goto out;
+
+	ret = __phy_read(phydev, DAP8211R_EXT_DATA);
+out:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
+/**
+ * dap8211r_modify_ext() - Modify extended register bits
+ * @phydev: PHY device structure
+ * @reg: Extended register address
+ * @mask: Bit mask of bits to clear
+ * @set: Bit mask of bits to set
+ *
+ * Modifies a PHY extended register using the indirect access method.
+ * New value = (old value & ~mask) | set.
+ * The caller must hold the MDIO bus lock.
+ *
+ * Return: 0 on success, or negative error code
+ */
+static int dap8211r_modify_ext(struct phy_device *phydev, u16 reg, u16 mask, u16 set)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = __phy_write(phydev, DAP8211R_EXT_ADD, reg);
+	if (ret < 0)
+		goto out;
+
+	ret = __phy_modify(phydev, DAP8211R_EXT_DATA, mask, set);
+out:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
+/**
+ * dap8211r_get_rgmii_delay() - Get RGMII delay from DT
+ * @phydev: PHY device
+ * @prop_name: DT property name
+ * @is_id: If phy mode is PHY_INTERFACE_MODE_RGMII_[TXID,RXID,ID]
+ *
+ * Reads the RGMII delay from the device tree. If the property is not
+ * specified, the default delay (1950ps) is used.
+ *
+ * Return: Register value (0-15) on success, negative error code on failure.
+ *	   -EINVAL: Property not specified and is_id is false.
+ */
+static int dap8211r_get_rgmii_delay(struct phy_device *phydev, const char *prop_name, bool is_id)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	u32 ps = 0;
+	int ret;
+
+	ret = of_property_read_u32(np, prop_name, &ps);
+	if (ret == -EINVAL)
+		return (is_id) ? DAP8211R_DEFAULT_DELAY_SEL : ret;
+	if (ret < 0)
+		return ret;
+
+	return dap8211r_delay_ps_to_sel(ps);
+}
+
+/**
+ * dap8211r_config_init() - Initialize PHY
+ * @phydev: PHY device structure
+ *
+ * Configures the PHY during initialization:
+ * - RGMII delays based on interface mode
+ * - TX clock invertion
+ * - Software reset to apply settings (low active, self clear)
+ *
+ * Return: 0 on success, or negative error code
+ */
+static int dap8211r_config_init(struct phy_device *phydev)
+{
+	struct device_node *phydev_node = phydev->mdio.dev.of_node;
+	u16 mask = 0, set = 0;
+	int ret, retries = 10;
+
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+		ret = dap8211r_get_rgmii_delay(phydev, "rx-internal-delay-ps", false);
+		if (ret >= 0) {
+			set = FIELD_PREP(DAP8211R_RGMII_RX_DEL_MASK, ret);
+			mask = DAP8211R_RGMII_RX_DEL_MASK;
+		} else if ((ret < 0) && (ret != -EINVAL)) {
+			return ret;
+		}
+
+		ret = dap8211r_get_rgmii_delay(phydev, "tx-internal-delay-ps", false);
+		if (ret >= 0) {
+			set |= FIELD_PREP(DAP8211R_RGMII_TX_DEL_MASK, ret);
+			mask |= DAP8211R_RGMII_TX_DEL_MASK;
+		} else if ((ret < 0) && (ret != -EINVAL)) {
+			return ret;
+		}
+		break;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		ret = dap8211r_get_rgmii_delay(phydev, "rx-internal-delay-ps", true);
+		if (ret < 0)
+			return ret;
+
+		set = FIELD_PREP(DAP8211R_RGMII_RX_DEL_MASK, ret);
+		mask = DAP8211R_RGMII_RX_DEL_MASK;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		ret = dap8211r_get_rgmii_delay(phydev, "rx-internal-delay-ps", true);
+		if (ret < 0)
+			return ret;
+
+		set = FIELD_PREP(DAP8211R_RGMII_RX_DEL_MASK, ret);
+		mask = DAP8211R_RGMII_RX_DEL_MASK;
+		fallthrough;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		ret = dap8211r_get_rgmii_delay(phydev, "tx-internal-delay-ps", true);
+		if (ret < 0)
+			return ret;
+
+		set |= FIELD_PREP(DAP8211R_RGMII_TX_DEL_MASK, ret);
+		mask |= DAP8211R_RGMII_TX_DEL_MASK;
+		break;
+	default:
+		phydev_err(phydev, "Unsupported interface: %d\n",
+			   phydev->interface);
+		return -EINVAL;
+	}
+
+	if (of_property_read_bool(phydev_node, "dapu,tx-inverted-clk"))
+		set |= DAP8211R_RGMII_CLK_INVERT;
+
+	mask |= DAP8211R_RGMII_CLK_INVERT;
+
+	ret = dap8211r_modify_ext(phydev, DAP8211R_PHY_CON, DAP8211R_PHY_SW_RST, 0);
+	if (ret)
+		return ret;
+
+	/* Wait for reset self-clear */
+	do {
+		fsleep(20);
+		ret = dap8211r_read_ext(phydev, DAP8211R_PHY_CON);
+		if (ret < 0)
+			return ret;
+	} while (!(ret & DAP8211R_PHY_SW_RST) && --retries);
+
+	if (!retries)
+		return -ETIMEDOUT;
+
+	ret = dap8211r_modify_ext(phydev, DAP8211R_RGMII_CON, mask, set);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct phy_driver dap8211r_driver[] = {
+	{
+		PHY_ID_MATCH_EXACT(DAP8211R_PHY_ID),
+		.name		= "DAP8211R Gigabit Ethernet",
+		.config_init	= dap8211r_config_init,
+		.read_status	= genphy_read_status,
+		.set_loopback	= genphy_loopback,
+		.config_aneg	= genphy_config_aneg,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+	},
+};
+module_phy_driver(dap8211r_driver);
+
+MODULE_DESCRIPTION("DAP8211R Gigabit Ethernet PHY driver");
+MODULE_AUTHOR("Artem Shimko <a.shimko.dev@gmail.com>");
+MODULE_LICENSE("GPL");
+
+static const struct mdio_device_id __maybe_unused dap8211r_tb[] = {
+	{ DAP8211R_PHY_ID, DAP8211R_PHY_ID_MASK },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(mdio, dap8211r_tb);
-- 
2.43.0

