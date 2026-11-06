Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964410;
	b=iLTFKwzxXNAVTD053qSOEIwZRYlvrSqO/K2vS98gdll0wxABjqLrpnFUZ8+DNAq/M10o
	 ZcZn8PeybfIocRRZfXARimsFjqJQb04ppHhlOMwnudmjBcSdr1zVPLBX+qkIOBpD0zdXj
	 48VaYLLhc9twOpA2R0PNGfLhcFwgCgRNkv2oHqyLTP5BfyiSBxjph7z3VyqvcsXAezgzM
	 mm12G2mT1J9QDLz9MaWxde5j3mjOcE077tHdQpXdnPzjhE14LIc+MNAW8PKDoxcsfTtda
	 DE3BJmnSv9oOxNj+QPB8QkmCPhlKNT/V1/CdyrCtXUkPhG28uNhc8FrgbqTc//me0hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964410;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=9Y5UCOxLcLONgfwtiMJ07v4FP7zoH8CIbsF7+Rutog4=;
	b=tX62739in+ku5asZnvQ8gq0ZQTkM3z/hlR/FnkAgIVHaIP0gv6YTQ1FCLLmLj7Hx2cob
	 4bLi3Jg8x5mGmBkTwRNyDVlgt+BGb65p648gm9eXcFvIXhEATUdpVHQW8du+NbGc2rG8c
	 rOEpcWCdE09NAiBuEBVOnEJMxQg3pEpq43dax4WNtrYN5MYmDBGhKMKOvDbF09Mt8r3Bu
	 RtuTqHyjvaAWhMCcUZgoe5vfK2FAVmKd1Xp/175KP79344DKQ4HgibEa805ymSu+R+VPD
	 Aj9o879CsSP3cNXwT9NjTfFQI3PmUDo27kYfzjGIL7bRT8qu7kvXKREHyfgqafC+YmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mucse.com;
	spf=pass smtp.mailfrom=mucse.com;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF75606A32C;
	Fri,  6 Nov 2026 11:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EF75606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz5t1793964315t52e0d7e1
X-QQ-Originating-IP: HbpLPuSBpSt8G7ucbMe4zna7FtrYB05hN8lhjNLwNfc=
Received: from nic-Precision-5820-Tower.tail7b ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Nov 2026 19:25:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12139747150019972212
EX-QQ-RecipientCnt: 10
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next 1/5] net: rnpgbe: Add basic ethtool support
Date: Fri,  6 Nov 2026 19:25:10 +0800
Message-ID: <3637FA23D47B2459+20261106112510.43809-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <FB722C2F25FE9005+20261106112420.43050-1-dong100@mucse.com>
References: <FB722C2F25FE9005+20261106112420.43050-1-dong100@mucse.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: Nt9LS5Tya5fqZsGAt1P9ZR53SWirSB5JbQdrsCBzg2S0MdAbRPzcm76p
	fpesBhYawXdFRRp/38Tc2CBwNU049KCCk5ykPo6HNTB/fZqL5u4xKK5BlUHv4S/Oinb3iPn
	7ZWfCeMjP6AVDtFmLtPt5i8Sg3U/6+x1oNd+Ac2rGUMBJ/q4FlOChDQN1zj9QpvmQ4GdCmi
	x67BZSj6y1vvN4n3mLQdTufwXZ4NroBvbrlZVZx476W7C0lkqebfkBOIfR3xfu5y77RENTB
	EUX+dzcEZR7To8+wE/CDfCaZKPTxV7TpZ1469EUaMJR4/pKfR0DqL7eUh9y7AzQdw/1DXFO
	tPrGG4oilty6l6YRW1cOeCoL5RkHL72K19J25B6kjDOKs8SHAarGqxRq8NFNsVDbi8wrHXb
	HNYSEeIj693pFDwOt0sjK8Pig1jWw/yV2N7IbwJnUgSZTb2JHjn4bUhX8+8Tj/tA04UZ8IW
	9xtcSsPX3fw375pJrBmQixxFZu/qtCkIiQqVgKQjeUVyGlUQUz5VwBx2/XNULNDzUTu2mqx
	QgBKOfXr9Q0IOSSG9Q4giKoE99s7ebz8+jE4w4zLPbva4VXl7N3KpEw1zwR1I4UeKtii9AI
	vhgXWQg3k4vMrjosFOEi6BTxeTDG9gBJpnYtz8evBKgoQa0TuIOKFCNRguMFOSMWmk/kbZS
	ykcgeNtKCTciGbjW8vymZKsDRQyeDm14rZuFWrF21w8luWy6tR/8XHNtX7fjnoZm3WknT7P
	SS7RUEhASA6DN6He23lvzwNb8czuKojYHecax2Sp2N80iqxwl8UZ64e9wB2q1LpybdB68ne
	dFwJKvincsIOKJyJa7Y7z125HYBJQ4YEwqPodc502uoIiljZLgffrDg1hLfZztUrVEay4TV
	kfsuo0/8NhxJrIY9pN38t+77Ek+K5343lesr+w5y4zO5obuU9N2+4glUvbtox6x2QORm5WA
	9+JJUBkgt/37gnYollHhBb9rihtGn2fTNEfErNe4o67d5Krk63E6UcFvAq/lSAvXWtcM0kW
	KpdsJTivxZmbMBMrQ/VPotzxJexRF2lPkGiIuzbQ/5G/U8Lypa/sM+NLzeT9iGIpwfiO2kJ
	w==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Add get_drvinfo and get_link callbacks to report the driver name,
PCI bus address, firmware version and carrier state through ethtool.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |  1 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  3 +++
 .../ethernet/mucse/rnpgbe/rnpgbe_ethtool.c    | 25 +++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  4 ++-
 5 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_ethtool.c

diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
index 17574cad392a..4d768324a82c 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -9,4 +9,5 @@ rnpgbe-objs := rnpgbe_main.o\
 	       rnpgbe_chip.o\
 	       rnpgbe_mbx.o\
 	       rnpgbe_mbx_fw.o\
+	       rnpgbe_ethtool.o\
 	       rnpgbe_lib.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 4e9776b28bfb..2fe76c95da7c 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -46,6 +46,7 @@ struct mucse_hw {
 	struct mucse_mbx_info mbx;
 	int port;
 	int speed;
+	u32 fw_version;
 	bool link;
 	u16 cycles_per_us;
 	u8 pfvfnum;
@@ -257,6 +258,8 @@ int rnpgbe_set_rx_mode(struct net_device *netdev,
 		       struct netdev_hw_addr_list *mc);
 void rnpgbe_set_link(struct mucse_hw *hw, bool linkup);
 
+extern const struct ethtool_ops rnpgbe_ethtool_ops;
+
 /* Device IDs */
 #define PCI_VENDOR_ID_MUCSE               0x8848
 #define RNPGBE_DEVICE_ID_N500_QUAD_PORT   0x8308
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_ethtool.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_ethtool.c
new file mode 100644
index 000000000000..506233f62698
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_ethtool.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 - 2026 Mucse Corporation. */
+
+#include <linux/ethtool.h>
+#include <linux/pci.h>
+
+#include "rnpgbe.h"
+
+static void rnpgbe_get_drvinfo(struct net_device *netdev,
+			       struct ethtool_drvinfo *info)
+{
+	struct mucse *mucse = netdev_priv(netdev);
+	u32 version = mucse->hw.fw_version;
+
+	strscpy(info->driver, KBUILD_MODNAME);
+	strscpy(info->bus_info, pci_name(mucse->pdev));
+	snprintf(info->fw_version, sizeof(info->fw_version), "%u.%u.%u.%u",
+		 version >> 24, (version >> 16) & 0xff,
+		 (version >> 8) & 0xff, version & 0xff);
+}
+
+const struct ethtool_ops rnpgbe_ethtool_ops = {
+	.get_drvinfo = rnpgbe_get_drvinfo,
+	.get_link = ethtool_op_get_link,
+};
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 708a7297233e..46981ef2542a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -250,6 +250,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	}
 
 	netdev->netdev_ops = &rnpgbe_netdev_ops;
+	netdev->ethtool_ops = &rnpgbe_ethtool_ops;
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	rnpgbe_sw_init(mucse);
 	err = rnpgbe_reset_hw(hw);
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index c6ce9dbee3d0..4a1893792751 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -72,9 +72,11 @@ static int mucse_mbx_get_info(struct mucse_hw *hw)
 	int err;
 
 	err = mucse_fw_send_cmd_wait_resp(hw, &req, &reply);
-	if (!err)
+	if (!err) {
 		hw->pfvfnum = FIELD_GET(GENMASK_U16(7, 0),
 					le16_to_cpu(reply.r.hw_info.pfnum));
+		hw->fw_version = le32_to_cpu(reply.r.hw_info.fw_version);
+	}
 
 	return err;
 }
-- 
2.50.1

