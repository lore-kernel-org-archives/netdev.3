Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A4C38F639
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790494733; cv=none; b=taa11D2ktTt/XHxw+Hl1mdi9ikVCv0KZQ1FKPJIm+qbAPpBaDB3MlLLPT7PK946cfEP+dPsU/7JBCbfx1LcCm7HPALz+vW7LlN4i3K5zTlcC2rolAHmx2WFKC9606BKhfEteslGo3+aGJ2VAQ4cR+voPH/QDJl3ni3OdZfK/HDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790494733; c=relaxed/simple;
	bh=oS/hxtDdfAnq+kT6UwXfVb0j2bHr/6DfMGbKaV0D1z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TT1ttVlS9SO67ow37L4qDpmoFCqGR1nqoXM3YuVvsqbsPsgGDaZ/UdgX3sush+A5fVGEKq5iaaQsO1DB917wblCrs0C0DA/q1ST5pfoYQP6bFTqMlLyG6jE3R1xm+3KAW1l7FOf5HKNMMkz9PkLo3hMTdCPH2o3xiXSqK/hclcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOpvo+it; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOpvo+it"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-488811c9ebaso881153f8f.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 00:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790494730; x=1791099530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJzd0LKEzHLehrBQJyeu7/EYASGXnEd4/UF72Q6oKr4=;
        b=VOpvo+itYC/BGUi8oGUINMttyBIbvPsFN0YCWpvADXxwVkIN4R/fr0Tgs2pVMi1qtH
         dlfgiOeARyPjO7H69b1Y/bWP7hcHUuf224oIg43ZXzRkImltuOyONuzvCB4K7C024OKK
         PyJG7Q0SfX9kbYmCKenl6UT8ulUF4M2rr00uVB2SiYzRx75QIJdFEFJIYFdCYpfJ47Tl
         yBKygD68U3atmYKK/uSrHDCYMJKMoYSZcKD95X/obVAFIb1LkUI3lt5/DWojRUmprGV9
         HzsKIsZwu+mTE7af/5DF6fbDbC7o7S3Sa2UUNKWjl8K1EjJiqO1yQ6N9ZyNXLR5rUl+7
         kyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790494730; x=1791099530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hJzd0LKEzHLehrBQJyeu7/EYASGXnEd4/UF72Q6oKr4=;
        b=ZRMuRCRp//GJtD9cs6IQNVCApaMuJL/A1Co0H4u86+EXToFDKlu1p61dRz6thM9i4V
         x6oFz4hUowOvM83YoRlWllbZfyI/B6PEz4puPxp017wVv/tPYcfBw3wuNmVcCrfdjQ/P
         Mw+PuBi/NCoH9jHl9aUor5aPAPRV/XPh2q1UAb6DnuRvu9UW7Z3XsbLrqxUwq6GZA9f5
         JcCVbTcQai/hPiXI2etswRE/phsk0me4eP0k2+uwu0C/hW01S562SRice/4+ozli+w+t
         4fHQrzgOIWYSM+LJ3ca4JZIYcJCUJiN1TyRStaV1HJq5uVTmpKoQuHNqSocQZYkYWXL6
         TiSw==
X-Gm-Message-State: AFuF++m4PsB+J62HQxEuCunNC/aZV45vVvg+gyqBqT0NFiJ4ksi56Ssh
	Zizg/rMVjfdzMA//CW33EQUIIMhCk2J8jJfWC+hc5uNaAZ5EEr+aNs3cmilhAPJs
X-Gm-Gg: AYBFou1HRf9Ks8x5BGcGryFUYXV0038ci6fOy/U7cY7iDz8otLWG5FKe7xHfc12iX4+
	jzuvpOq1Pny2aOMgRcgY+JxozT1GP2qUVBAfFAXdTjg6U1QRCuwaRCP6XDxdszOUv2KuePjiILf
	kfXNhaVTW1iIZWZ742psS3zjrQtTBbeOiUuauyZnteESPMWULdgI+aPYoTPyoR9bM92FBwqn07f
	xIQYVx1btYaCT34B+aa3Nfzt4kP8E7Bc7G8wFVv5r8Ui/yV3z9cp7NfUWh54wYyjVmsrYIdH15h
	CSukmVvwEhrqmI63qaN0QhmIqz7zAc38YsPqSjTCxx1O46RdzrTRsjX542awOJOMLtOVBPgGFhS
	g6liq1djQ4IktXX1NTzAa+Li6TS+cy4Ju+qwRFu31yatrzHYGsgi3HquV/qdOXHXC2QZnA/m8RY
	NbwkqPxvsl8kw6l544Njod0At+T3/uEMNgK9WLLYz/3wOJ7DIWc8bgIM6wjqoGbV/R6cbKW5eWF
	NzjkS/8u6jy7ioRJrYp/WScNOJTK9aFzXusq7VyyA==
X-Received: by 2002:a05:600c:3b12:b0:49f:ce73:5e95 with SMTP id 5b1f17b1804b1-49fe670cacdmr176623005e9.35.1790494730079;
        Sun, 27 Sep 2026 00:38:50 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a35607bsm17210652f8f.16.2026.09.27.00.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 00:38:49 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org
Cc: radhey.shyam.pandey@amd.com,
	michal.simek@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	vadim.fedorenko@linux.dev,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net-next 1/2] net: axienet: use device_property and fwnode APIs for probe-time config
Date: Sun, 27 Sep 2026 10:38:42 +0300
Message-ID: <20260927073843.346910-2-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260927073843.346910-1-maimon.sagi@gmail.com>
References: <20260927073843.346910-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

axienet_probe() reads its configuration exclusively through the of_*
API, so the driver can only be instantiated from a device tree node.

The ADVA TimeCard X2 is a PCIe timing card, driven by ptp_ocp, whose
FPGA contains an AXI Ethernet MAC with an AXI DMA engine.  ptp_ocp is
going to register the MAC as a child platform device described by a
software node, so that this driver runs it rather than a copy in
ptp_ocp.  That needs the probe-time configuration to be readable from a
software node.

The of_property_read_*(), of_get_phy_mode(), of_get_mac_address() and
phylink_of_phy_connect() calls used here all have fwnode-based
equivalents that resolve identically for a DT-backed device, and
additionally work for a device described by a software node.

Convert them.  On a device tree this is a no-op: device_property_*()
dispatches to the of_* implementation when dev->fwnode is an OF node,
and device_get_phy_mode()/device_get_mac_address() are thin fwnode
wrappers around the same lookups.  device_get_mac_address() also keeps
the "mac-address" nvmem cell fallback that of_get_mac_address() has.

Note that device_get_phy_mode() returns the mode as a positive value
rather than through an out parameter, so the error test changes from
"if (ret)" to "if (ret < 0)".

Not everything is converted.  The "axistream-connected" lookup stays on
the OF API because its result is passed to of_address_to_resource(),
which has no fwnode counterpart.  The "pcs-handle" and "phy-handle"
lookups could use fwnode_find_reference() and fwnode_mdio_find_device(),
but they refer to MDIO devices that only a device tree describes - the
bus axienet_mdio_setup() registers goes through of_mdiobus_register() -
so converting them would not let a caller without a device tree use
them.  Such a caller takes neither branch: it gets its DMA registers
from its own platform resources, and it cannot use the SGMII and
1000BASE-X modes, which need a PCS.

No functional change intended.

Tested on the X2 with a local ptp_ocp change, with CONFIG_OF disabled
and enabled: the interface probes with its configuration read from the
software node and passes traffic.  No device tree board was available,
so the claim that this is a no-op for device tree users rests on the
dispatch described above.

Assisted-by: LLM sparse
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 782f903d318f..cfef8ad75909 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -33,6 +33,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/skbuff.h>
 #include <linux/math64.h>
 #include <linux/phy.h>
@@ -1671,7 +1672,7 @@ static int axienet_open(struct net_device *ndev)
 	ret = axienet_device_reset(ndev);
 	axienet_unlock_mii(lp);
 
-	ret = phylink_of_phy_connect(lp->phylink, lp->dev->of_node, 0);
+	ret = phylink_fwnode_phy_connect(lp->phylink, dev_fwnode(lp->dev), 0);
 	if (ret) {
 		dev_err(lp->dev, "phylink_of_phy_connect() failed: %d\n", ret);
 		return ret;
@@ -2864,7 +2865,7 @@ static int axienet_probe(struct platform_device *pdev)
 	if (axienet_ior(lp, XAE_ABILITY_OFFSET) & XAE_ABILITY_STATS)
 		lp->features |= XAE_FEATURE_STATS;
 
-	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,txcsum", &value);
+	ret = device_property_read_u32(&pdev->dev, "xlnx,txcsum", &value);
 	if (!ret) {
 		switch (value) {
 		case 1:
@@ -2879,7 +2880,7 @@ static int axienet_probe(struct platform_device *pdev)
 			break;
 		}
 	}
-	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,rxcsum", &value);
+	ret = device_property_read_u32(&pdev->dev, "xlnx,rxcsum", &value);
 	if (!ret) {
 		switch (value) {
 		case 1:
@@ -2898,16 +2899,16 @@ static int axienet_probe(struct platform_device *pdev)
 	 * Here we check for memory allocated for Rx/Tx in the hardware from
 	 * the device-tree and accordingly set flags.
 	 */
-	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,rxmem", &lp->rxmem);
+	ret = device_property_read_u32(&pdev->dev, "xlnx,rxmem", &lp->rxmem);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to read xlnx,rxmem property\n");
 
-	lp->switch_x_sgmii = of_property_read_bool(pdev->dev.of_node,
-						   "xlnx,switch-x-sgmii");
+	lp->switch_x_sgmii = device_property_read_bool(&pdev->dev,
+						       "xlnx,switch-x-sgmii");
 
 	/* Start with the proprietary, and broken phy_type */
-	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,phy-type", &value);
+	ret = device_property_read_u32(&pdev->dev, "xlnx,phy-type", &value);
 	if (!ret) {
 		netdev_warn(ndev, "Please upgrade your device tree binary blob to use phy-mode");
 		switch (value) {
@@ -2930,9 +2931,10 @@ static int axienet_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 	} else {
-		ret = of_get_phy_mode(pdev->dev.of_node, &lp->phy_mode);
-		if (ret)
+		ret = device_get_phy_mode(&pdev->dev);
+		if (ret < 0)
 			return ret;
+		lp->phy_mode = ret;
 	}
 	if (lp->switch_x_sgmii && lp->phy_mode != PHY_INTERFACE_MODE_SGMII &&
 	    lp->phy_mode != PHY_INTERFACE_MODE_1000BASEX) {
@@ -2940,7 +2942,7 @@ static int axienet_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (!of_property_present(pdev->dev.of_node, "dmas")) {
+	if (!device_property_present(&pdev->dev, "dmas")) {
 		/* Find the DMA node, map the DMA registers, and decode the DMA IRQs */
 		np = of_parse_phandle(pdev->dev.of_node, "axistream-connected", 0);
 
@@ -3060,7 +3062,7 @@ static int axienet_probe(struct platform_device *pdev)
 		dev_info(&pdev->dev, "Ethernet core IRQ not defined\n");
 
 	/* Retrieve the MAC address */
-	ret = of_get_mac_address(pdev->dev.of_node, mac_addr);
+	ret = device_get_mac_address(&pdev->dev, mac_addr);
 	if (!ret) {
 		axienet_set_mac_address(ndev, mac_addr);
 	} else {
-- 
2.47.0

