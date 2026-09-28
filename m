Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65852456296
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581386; cv=none; b=AIW9kHX+FX/H+zeOuJ41703QiRLDnba3rnZTdVMdj/nwcHTXTc4aYh7afXv2toXAS2I29QCVxgL/LmDIeAJw3Kr9KFocWKUXZdsYgJWqdN4LM9IlTZSTcTLw8toDAoKModpres222z9EMoFavO7v5+sABeaQAfB7iv22vKX4En8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581386; c=relaxed/simple;
	bh=/maAuU2cXcoFwqqh1i1IM9+QsiGNydJTSLLtQ4YaIVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aw201EDpbRSrPes5o5FW9dcxtRMfu0LmoK7LxzqnTgUFgrcsY8frUWK4yk7woHiqgVRBl/BP8sbdzp9sThqijkdgBC7VprTuoUAOSJD8qG94F8fwHvQceD4PZ0eTh++pVYitO5a9awCU8lXqhTwUToWY/GUwo8X8KjOvhZaeOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUR5AGA+; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUR5AGA+"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2bca99f463so116408266b.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790581383; x=1791186183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qVqZK+W1DXYcQ0YoEfl36Lg8eRThXM+jLhpeG8h+ECI=;
        b=cUR5AGA+miLrEE2G/6NFvPGarixvkqyRitS4D1Vov57qRy18esCGwFXUN6vCCbXuhy
         VF2ZHdWW7rQGDUSWp2uRSEc3uAVaZUaf8Yx9uJj+VepT92YZ+ScPot9lbGpGoeDVexmo
         eU/cg/TdhsRoy0VbW1l0s7let4w/zgMTo9Dz+ylREKmUXl26N/VxjzJ/7vAfgPD2FiFz
         lxYhsoZxd1LNNdCj4e83LpQtZZB8kIDRdABD4rvBdKiDj4wxqAzXxyLWQgVQOgiRgjJa
         nDeNtZmbBHvQaBIZXe2uYgHZty38wXMU0fMiSimIXuFYbq7O3kPmR0fLkax8Y3kzb4gJ
         PvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581383; x=1791186183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qVqZK+W1DXYcQ0YoEfl36Lg8eRThXM+jLhpeG8h+ECI=;
        b=FO5PDCsxybw8vSNiOIptqZNdPSg1FS8N8Ku9DV81uORQKDrGA/Y06NKIMo/qcIHbZh
         nidyRmQ9pr7INBBEJmhKO5FcycKfL4lX82R2C5uyhBLpkOw2jyG8Vu48m/a1kkUqhM4Y
         bRMsLtfLVDHo/zWDRzmr8T3K+tTZeNh90VSo8vUoODAxhCrcScCYX0P66XuNKUQFn2Dk
         4fOHAfezGvqpslAviXyDMTdKK3EZDSQIFuRerj2Ynh+TPQk15ooLEi345mZyMbq1BXfr
         pRPUmia1sRVk8COA18RcUgUEpswCcZzH0ZtIFMXaluPY8kMbu7qSJkDYz+Qr9CuOBXZM
         64WA==
X-Gm-Message-State: AFuF++k6inhBZds8eAZ94k6WXvtYCNabXMAi9fJV0stRHHlm2c3IpSUJ
	gvoxZOYQSXJJ9N/eX8udGeTRFYgdLS2+865x76sIza3XrLChgUX+Ohj74pKKydez
X-Gm-Gg: AYBFou1ofOZCmR4rPExfTvb1INb9gw0ghcucIfA5YzGtWZXvCn86nDi9oks4sMcL9Lg
	oWYu34QZow/gdwIRKLBrKLyzjk2dIwZ5veDCqYgNzmj5KVuWMYPG0ee5rNkLOF+K44qrDfggPIN
	vUdsDkcosI/JgFiV7J5lmdOaC5bAzeyfO1/KXFIBKPtcYs10EqAMgzTcuzAGjPRVJ4I6iW2YP/V
	Mk1kjdePTjwD4eoY8ky9D/PJAEd4jtkQrH/VnOZTeg6uz1DcgngEnoDoQ8IcrpXRYoLVDIEr2mP
	HiUEHdamm3CT0XexODQGq4/80VQ0sqacwa8qAsbMzDGfLLg5AJLiHvzDA3O9K4o00ks1MLeabke
	M0lTHbvb0ocmiLGdGDVBdVjuyqZA2XUCKxY8i7+gdWKTARhPN8DWiKOGDGBM/zuNgDbpOsuGeAx
	1nzxu1v1cdcytIG5oHF5T6GrvneZmM6t0jTAHtgbii4X/CtBdsj8SG0PBNtuezT8cr+FQKaRM5Z
	o7UyedsLn0/MHdQrHcgSP31KDPje2Mty5xao19V
X-Received: by 2002:a17:907:6c17:b0:c24:6382:2648 with SMTP id a640c23a62f3a-c2ac21f98famr1081946266b.5.1790581382548;
        Mon, 28 Sep 2026 00:43:02 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae76ac760sm419415166b.39.2026.09.28.00.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 00:43:02 -0700 (PDT)
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
	richardcochran@gmail.com,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net-next v2 1/2] net: axienet: use device_property and fwnode APIs for probe-time config
Date: Mon, 28 Sep 2026 10:42:55 +0300
Message-ID: <20260928074256.462345-2-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260928074256.462345-1-maimon.sagi@gmail.com>
References: <20260928074256.462345-1-maimon.sagi@gmail.com>
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

Convert only the lookups such a caller needs: "xlnx,rxmem", which probe
requires; "phy-mode"; the MAC address; and the PHY connection, which is
where phylink finds a "fixed-link" child.  On a device tree this is a
no-op: device_property_read_u32() dispatches to the of_* implementation
when dev->fwnode is an OF node, phylink_of_phy_connect() is a wrapper
around phylink_fwnode_phy_connect(), and device_get_phy_mode() and
device_get_mac_address() are thin fwnode wrappers around the same
lookups.  device_get_mac_address() also keeps the "mac-address" nvmem
cell fallback that of_get_mac_address() has.

Note that device_get_phy_mode() returns the mode as a positive value
rather than through an out parameter, so the error test changes from
"if (ret)" to "if (ret < 0)".

Everything else stays on the OF API.  "xlnx,txcsum", "xlnx,rxcsum" and
"xlnx,switch-x-sgmii" are optional, and "xlnx,phy-type" is deprecated in
favour of "phy-mode".  Without an OF node each of those lookups finds
nothing, exactly as for a device tree node that leaves them out: no
checksum offload, no runtime SGMII/1000BASE-X switching and a
fall-through to "phy-mode".  The "dmas" test likewise selects the
built-in AXI DMA engine.  The "axistream-connected", "pcs-handle" and
"phy-handle" phandle lookups stay too: a caller without an OF node takes
neither branch, getting its DMA registers from its own platform
resources, and it cannot use the SGMII and 1000BASE-X modes, which need
a PCS.

No functional change intended.

Tested on the X2 with a local ptp_ocp change, with CONFIG_OF disabled
and enabled: the interface probes with its configuration read from the
software node and passes traffic.  No device tree board was available,
so the claim that this is a no-op for device tree users rests on the
dispatch described above.

Assisted-by: LLM sparse
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 782f903d318f..0f2170af9b10 100644
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
@@ -2898,7 +2899,7 @@ static int axienet_probe(struct platform_device *pdev)
 	 * Here we check for memory allocated for Rx/Tx in the hardware from
 	 * the device-tree and accordingly set flags.
 	 */
-	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,rxmem", &lp->rxmem);
+	ret = device_property_read_u32(&pdev->dev, "xlnx,rxmem", &lp->rxmem);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to read xlnx,rxmem property\n");
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

