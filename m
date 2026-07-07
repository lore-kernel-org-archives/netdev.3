Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0478D395D8F;
	Tue,  7 Jul 2026 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416165; cv=none; b=YTsjCNmplo4NdHek6WzP6Eh09+yPTe7dkk+lVGQplP2tdUCsGEaa96m4Y6usUgd1rf7dUGNCWDydbjOYYVOoGTqdgzZHHihSjA5foKiXUfpirOK8oTW3uUr8ZTXh2pOQimk3K9e4XJgzSJATtG57Z6GpUg38dNjEsVnKuGO5U00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416165; c=relaxed/simple;
	bh=4UqR88eeSTcy0bHGxaWiCbtxnkomqN1fr5FJRTHFsjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oaa/McOPb+UoayleHx78IYB9B5HUR8KSXf6bwrUDgBtAgkgzEbrHVI5LS7TnwsIbz8XyTXzAGhXKPBXiJ9KCUUL9eEtenXvFMrHFnNSPYRmyf1h+S/CSzpxH+c9B0MKGJvTffqxWDFZpNZZlqfZwMHe6RHhD3MHfww4cPUNbN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=S49W9Mgs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="S49W9Mgs"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6679GeoxE1361138, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783415801;
	bh=dev6kTehcq6RUN35aoSrqcuWuHfKJ9UoOzsU2X1US9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=S49W9MgsyN4cnEsCj1DuNJZWs+bpMVUkNZKZPCH1IUTGO5m38Cp0N1ZnBoTJ8/e/Y
	 oX02SZATmoIFKZVwKVwu3fenLiy3iSaFjEli/D4xOs6Ia3y23z49gmnv/LPY4YSApJ
	 is/Te4WvthVejj0E00yaddPlAe3xGOekB6XKaX5dmK+qIpL0B61TbGxANCVdDCteKi
	 u6xccKA5tGIUjYUEYZ5fq8S2Sup0HWxcMFl1oa0/LiVr3lm/e8XJzZHkUv1itlFICl
	 6hECH8jYBxnVkO4vZAgNrCJD+PUeBNejN3Tp9scFxFsRxEhtGl5BQk0Ejw8vbVBt47
	 yY3aikrkSH2rA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6679GeoxE1361138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jul 2026 17:16:40 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:16:40 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Jul 2026 17:16:40 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
	<daniel@thingy.jp>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v5 6/8] r8169: fix RTL8116af can not enter s0idle and c10
Date: Tue, 7 Jul 2026 17:16:34 +0800
Message-ID: <20260707091637.371-7-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260707091637.371-1-javen_xu@realsil.com.cn>
References: <20260707091637.371-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

RTL8116AF is a multi-function device. Functions 2 to 7 are hidden from
the PCI core and return an all-ones response when their vendor ID is read,
so they are not enumerated as normal PCI functions.

However, these hidden functions can still affect platform power
management. If they are left in D0 or keep ASPM disabled, the platform may
fail to enter the low-power s0ix state and the CPU package may fail to
enter Package C10.

Put functions 2 to 7 into D3hot and enable ASPM on their PCIe link control
register. Since these functions are hidden, access their configuration
space through pci_bus_read_config_dword() / pci_bus_write_config_dword()
using the same slot and the target function numbers.

Ignore functions that return a PCI error response when reading their
configuration space.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes

Changes in v3:
 - no changes

Changes in v4:
 - add gate for rtl_lowpower_hidden_functions, only for RTL8116af

Changes in v5:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 57 ++++++++++++++++++-----
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 1548453d484d..e9b9246380e8 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -97,17 +97,20 @@
 #define JUMBO_9K	(9 * SZ_1K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define JUMBO_16K	(SZ_16K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 
-#define OCP_SDS_ADDR_REG	0xEB10
-#define OCP_SDS_CMD_REG		0xEB0E
-#define OCP_SDS_DATA_REG	0xEB14
-#define SDS_CMD_READ		0x0001
-#define RTL_SDS_C22_BASE	0x40
-#define RTL_PKG_DETECT		0xdc00
-#define RTL_PKG_DETECT_MASK	0x0078
-#define RTL_PKG_DETECT_8116AF	0x0030
-#define RTL_INT_HW_ID		0xd006
-#define RTL_INT_HW_ID_MASK	0x00ff
-#define RTL_INT_HW_ID_8116AF	0x0000
+#define OCP_SDS_ADDR_REG		0xEB10
+#define OCP_SDS_CMD_REG			0xEB0E
+#define OCP_SDS_DATA_REG		0xEB14
+#define SDS_CMD_READ			0x0001
+#define RTL_SDS_C22_BASE		0x40
+#define RTL_PKG_DETECT			0xdc00
+#define RTL_PKG_DETECT_MASK		0x0078
+#define RTL_PKG_DETECT_8116AF		0x0030
+#define RTL_INT_HW_ID			0xd006
+#define RTL_INT_HW_ID_MASK		0x00ff
+#define RTL_INT_HW_ID_8116AF		0x0000
+#define RTL8116AF_FUNC_PM_CSR		0x80
+#define RTL8116AF_FUNC_EXP_LNKCTL	0x44
+#define RTL_PM_D3HOT			GENMASK(1, 0)
 
 static const struct rtl_chip_info {
 	u32 mask;
@@ -3734,6 +3737,35 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
 	r8168_mac_ocp_modify(tp, 0xe860, 0x0000, 0x0080);
 }
 
+static void rtl_lowpower_hidden_functions(struct pci_dev *pdev)
+{
+	unsigned int slot = PCI_SLOT(pdev->devfn);
+	struct pci_bus *bus = pdev->bus;
+	unsigned int devfn;
+	int func;
+	int ret;
+	u32 val;
+
+	for (func = 2; func < 8; func++) {
+		devfn = PCI_DEVFN(slot, func);
+
+		ret = pci_bus_read_config_dword(bus, devfn, RTL8116AF_FUNC_PM_CSR, &val);
+		if (!ret && !PCI_POSSIBLE_ERROR(val)) {
+			val &= ~PCI_PM_CTRL_PME_STATUS;
+			val &= ~(PCI_PM_CTRL_STATE_MASK | PCI_PM_CTRL_PME_ENABLE);
+			val |= (RTL_PM_D3HOT | PCI_PM_CTRL_PME_ENABLE);
+			pci_bus_write_config_dword(bus, devfn, RTL8116AF_FUNC_PM_CSR, val);
+		}
+
+		ret = pci_bus_read_config_dword(bus, devfn, RTL8116AF_FUNC_EXP_LNKCTL, &val);
+		if (!ret && !PCI_POSSIBLE_ERROR(val)) {
+			val &= ~((PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS) << 16);
+			val |= PCI_EXP_LNKCTL_ASPMC;
+			pci_bus_write_config_dword(bus, devfn, RTL8116AF_FUNC_EXP_LNKCTL, val);
+		}
+	}
+}
+
 static void rtl_hw_start_8117(struct rtl8169_private *tp)
 {
 	static const struct ephy_info e_info_8117[] = {
@@ -3790,6 +3822,9 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
 	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
 	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
 
+	if (rtl_is_8116af(tp))
+		rtl_lowpower_hidden_functions(tp->pci_dev);
+
 	/* firmware is for MAC only */
 	r8169_apply_firmware(tp);
 }
-- 
2.43.0

