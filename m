Received: from smtpcmd01-g.aruba.it (smtpcmd01-g.aruba.it [62.149.158.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E744BB5DE
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949465; cv=none; b=IYUv0SoqVnkl7rsnCQIXspwypiUvp7BHX5KPJyMS4/4HSPFY8+HhEJJND7v0cnHM0C7DM0Yh9sQb4h/UNJEkmglUVdgDK8njFN0vw4LCgjDz03xTGykPi6Eva88cgdGvSq8B+4uTTHd8UgC8iHEmrE0QQw5r/xRI30qGr0dyEI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949465; c=relaxed/simple;
	bh=7xam+ZyB49q2ZEKs5JCzAXEruXTclx3T1bG4VT0LcNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUA31sNYfMy08Y8uKRo1nhu2RejAvCEoMgyLJLru/F0aewxuv1Yh0w9H6ETo3yJU0i6uBx0BXHea98elXywhECWTdyTmPBopuTWdA5D+mtLinxYZAO+aLGArHzAxqs3s4IjRWlnjBErmfkv5hA8QaK8IX/HiftUx1cxSJgfewiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=YPKNKSVC; arc=none smtp.client-ip=62.149.158.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="YPKNKSVC"
Received: from polimar.tail4f75e6.ts.net ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id CdlZxDen1LUMUCdlbxwrEY; Fri, 02 Oct 2026 15:57:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790949460; bh=7xam+ZyB49q2ZEKs5JCzAXEruXTclx3T1bG4VT0LcNA=;
	h=From:To:Subject:Date:MIME-Version;
	b=YPKNKSVC4wBuBGh3cEbeOS7twAU7LMLkncP7AZh92IbDE4yFzElqpbSEJEClLkyDr
	 8L6Q0x11+kzLHJCcPTUwutLV1stDnwCugbdcu3/J5FkS0tTgqFVxqdAxqmgqytBvmB
	 70ufG9jO+BGUYywSr5ooGctmIdPO7CCe40QDa4PxTQ/k/hN4fhevm19LVKjGReyohX
	 ijNLtsGXccZK2G+KRbrwiwddaL+xXmkDojjbFSxirop6YkJfk6+lnGeyuN4RYLDyei
	 8sj99Bvjlb47vMvjK9gRvwpsUcUMBhtM+7yQm4eRoq6ozFHmgNAfhp4S4+rqBEg6PQ
	 pDYcVcvzCw1IA==
From: Rodolfo Giometti <giometti@enneenne.com>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Marek Vasut <marex@denx.de>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rodolfo Giometti <giometti@enneenne.com>
Subject: [PATCH net-next 2/2] net: dsa: microchip: take the reset timings from the device tree
Date: Fri,  2 Oct 2026 15:55:42 +0200
Message-ID: <20261002135542.359756-3-giometti@enneenne.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002135542.359756-1-giometti@enneenne.com>
References: <20261002135542.359756-1-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEP3+bGNc7b0EvyYV8HWkMncoBcil0sHjzeMjnsG8mWjjTi3V7YyLEGei6sth5ymYfP42Z2iKcGj6U1sfnIku8HtkoTy0y+MjrrbZcBcADTtqfOi52hY
 mvzzumtP2lat4j0ZaSCRX7W2xHvpgDskHPJjtRXNUOXtpfAhIAWvFRau17DeiiL0B6zH5Cx5GmJMNFQICENSLiWCbLVwHNBXQWqkigz2g4YPf3vefL1RBsjm
 +vrx2WW7mn+YhdMRhbIIF1XbwUVlU1LQX9ganzVnf+kyeAJB6FbtddnFlg0EoevMcCEHmedIr3V4OsruEAbjmlqYLJscI5w+UQO3Jbw8oh9fh/oCytpPh2ka
 uWlUNPNuPwFQ3M3CDoqTHJDYREbWR+h7YRK0pzuGxOshjHD7jcjtStx3xpPpfdKyTaz8LPs3t/hkr3DQrjZJL30AXnoLBzK4aJfxHXmSzQVpYzVqKjDe2Qoj
 /FnRssQ3/NArZKYon7Iv3YrohcH0Pp32UiFQkrb+Tem5tqCOzWT+5OsJTH3DOsKn37jzg/N9GRy5484O0Z8Zl4Z3h7/bEOuk5c9uN6UpdbX8gyzcyD3mris/
 2XVGDu/v36w/GUHQ/a613EB9xtgO17ANLgp9Un96yRQSVSgxWxrNhe3CtXeqReKG0TXfEI731XkF9Xt/QetBoSLU

ksz_switch_register() holds the reset line asserted for 10ms and then
waits a fixed 100ms before reading the chip ID. On an i.MX93 board
fitted with a KSZ9897 the switch starts answering 95-120ms after a
10ms reset pulse, and about 160ms after a 1s one, so the read can
return all ones, and the probe then gives up:

  ksz-switch spi0.0: unsupported switch detected ffffff00)

The same part on another board of the same family answers well within
the 100ms, which makes the wait a property of the board rather than of
the driver.

Take reset-assert-us and reset-deassert-us from the device tree, keeping
the current timings as the defaults so nothing changes for the boards
that do not set them. The delays are now free to span the ranges of the
different sleep helpers, so let fsleep() pick.

Assisted-by: LLM
Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 767c8fe8e819..365a804eee31 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -23,6 +23,7 @@
 #include <linux/of_net.h>
 #include <linux/micrel_phy.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/property.h>
 #include <net/dsa.h>
 #include <net/ieee8021q.h>
 #include <net/pkt_cls.h>
@@ -3990,6 +3991,8 @@ int ksz_switch_register(struct ksz_device *dev)
 	const struct ksz_chip_data *info;
 	struct device_node *ports;
 	phy_interface_t interface;
+	u32 deassert_us = 100000;
+	u32 assert_us = 10000;
 	unsigned int port_num;
 	u32 lookup_chip_id;
 	int ret;
@@ -4001,6 +4004,19 @@ int ksz_switch_register(struct ksz_device *dev)
 		return PTR_ERR(dev->reset_gpio);
 
 	if (dev->reset_gpio) {
+		/*
+		 * How long the switch takes to answer on the management bus
+		 * after the reset is released is a property of the board, not
+		 * of the driver: about 160ms has been measured on one of
+		 * them. The values above are only the historical default,
+		 * so a board that needs more states its own timing with the
+		 * properties MDIO devices already use for the same purpose.
+		 */
+		device_property_read_u32(dev->dev, "reset-assert-us",
+					 &assert_us);
+		device_property_read_u32(dev->dev, "reset-deassert-us",
+					 &deassert_us);
+
 		if (of_device_is_compatible(dev->dev->of_node, "microchip,ksz8463")) {
 			ret = ksz8463_configure_straps_spi(dev);
 			if (ret)
@@ -4008,9 +4024,9 @@ int ksz_switch_register(struct ksz_device *dev)
 		}
 
 		gpiod_set_value_cansleep(dev->reset_gpio, 1);
-		usleep_range(10000, 12000);
+		fsleep(assert_us);
 		gpiod_set_value_cansleep(dev->reset_gpio, 0);
-		msleep(100);
+		fsleep(deassert_us);
 
 		if (of_device_is_compatible(dev->dev->of_node, "microchip,ksz8463")) {
 			ret = ksz8463_release_straps_spi(dev);
-- 
2.43.0

