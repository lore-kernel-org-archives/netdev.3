Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015383B14B8;
	Mon, 31 Aug 2026 05:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155026; cv=none; b=uxK6vzrAo+PxY+va6OwOpn+MB/1u7XCLeo2mFO7kZfJ1ED3PzNgcSnel4Wis6quji64DkMLVJEi0A0JBsU2347UqGhgOYHY3ejtG5gbUhdpnDC0mCk2vEeKSp3suNRzY+X7wSRPCe8gZsD0X7BpB06ISQuxYq4e1mZNRR2rCceI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155026; c=relaxed/simple;
	bh=3ij2rWS0zMRWdIdEtFzprPLAv9/orRyQnTA36g17YGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ov4IZIYsAR87xS4exZNwhTbaXdsnBAh4A1pOXiGMTmDzFvQGxg7+kJ89Cx9mrOy7HqSoHKXAb1wD0wEGSbm/xSmMI6VaQf7H24firONU2hBL57SuPfJ1ucbkBXhl08pNsMxhZo9SgCs2J4sjrRqD7rbL0j8Kg5nrUxqKLIJXASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=ssCXBGYy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="ssCXBGYy"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67V5bqdtF479105, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1788154672;
	bh=YCGS4+4Al+24TZmPT0eJ+xAn+9cYk32NJGtPZCxVrz0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ssCXBGYyXpQ/DaobLtWXjPSHPMKOHBVtMGQWMqnKmSLUHVsNk4YRdXIOyd5oOv086
	 BSAsvndaVy75uMfZOtDHUH1Up2FzcLP1LmzNoaSaU8+VIsmrs9OQTGgq3jqmHpazTQ
	 z09FHwXfglvdkDDwzYd/gFj0jX8f0/nxQ6N7WusWjMietgJsKOBSHxHgHATufDN7Dq
	 8STob4axuYWqg9SmZYbEtYmuo2AzqqUHaZYU9zsmGIVAZq8pFXGvjjKk1Xeljw+srn
	 Ch2M8wM/edKgPqTJ3B+b9YOXViYTTa8fmLSOSFN0TlkyoYql36YjKhbieaBjQgxMMA
	 o9cV59FWcksAQ==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67V5bqdtF479105
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 13:37:52 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 31 Aug 2026 13:37:51 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Mon, 31 Aug 2026 13:37:51 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
	<daniel@thingy.jp>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v9 7/7] r8169: fix RTL8116af can not enter s0idle and c10
Date: Mon, 31 Aug 2026 13:37:45 +0800
Message-ID: <20260831053745.1197-8-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260831053745.1197-1-javen_xu@realsil.com.cn>
References: <20260831053745.1197-1-javen_xu@realsil.com.cn>
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

Changes in v6:
 - no changes

Changes in v7:
 - replace PCI_D3HOT with RTL_PM_CTRL_D3HOT, PCI_D3HOT has type
   restricted pci_power_t, but we only need unsigned int type

Changes in v8:
 - no changes

Changes in v9:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 42 +++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5dbbc3a48c09..5415ff62a286 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -114,6 +114,7 @@
 #define RTL_INT_HW_ID		0xd006
 #define RTL_INT_HW_ID_MASK	0x00ff
 #define RTL_INT_HW_ID_8116AF	0x0000
+#define RTL_PM_CTRL_D3HOT	0x03
 
 static const struct rtl_chip_info {
 	u32 mask;
@@ -3773,6 +3774,41 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
 	r8168_mac_ocp_modify(tp, 0xe860, 0x0000, 0x0080);
 }
 
+static void rtl_lowpower_hidden_functions(struct pci_dev *pdev)
+{
+	unsigned int slot = PCI_SLOT(pdev->devfn);
+	struct pci_bus *bus = pdev->bus;
+	int func, pos;
+	u16 val;
+
+	for (func = 2; func < 8; func++) {
+		unsigned int devfn = PCI_DEVFN(slot, func);
+
+		pos = pci_bus_find_capability(bus, devfn, PCI_CAP_ID_EXP);
+		if (pos) {
+			pci_bus_read_config_word(bus, devfn, pos + PCI_EXP_LNKCTL, &val);
+
+			if (PCI_POSSIBLE_ERROR(val))
+				continue;
+
+			val |= (PCI_EXP_LNKCTL_ASPMC | PCI_EXP_LNKCTL_CLKREQ_EN);
+			pci_bus_write_config_word(bus, devfn, pos + PCI_EXP_LNKCTL, val);
+		}
+
+		pos = pci_bus_find_capability(bus, devfn, PCI_CAP_ID_PM);
+		if (pos) {
+			pci_bus_read_config_word(bus, devfn, pos + PCI_PM_CTRL, &val);
+
+			if (PCI_POSSIBLE_ERROR(val))
+				continue;
+
+			val &= ~PCI_PM_CTRL_STATE_MASK;
+			val |= (RTL_PM_CTRL_D3HOT | PCI_PM_CTRL_PME_STATUS);
+			pci_bus_write_config_word(bus, devfn, pos + PCI_PM_CTRL, val);
+		}
+	}
+}
+
 static void rtl_hw_start_8117(struct rtl8169_private *tp)
 {
 	static const struct ephy_info e_info_8117[] = {
@@ -5326,6 +5362,9 @@ static int rtl8169_resume(struct device *device)
 	/* Some chip versions may truncate packets without this initialization */
 	rtl_init_rxcfg(tp);
 
+	if (rtl_is_8116af(tp))
+		rtl_lowpower_hidden_functions(tp->pci_dev);
+
 	return rtl8169_runtime_resume(device);
 }
 
@@ -6190,6 +6229,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		rtl8168_driver_start(tp);
 	}
 
+	if (rtl_is_8116af(tp))
+		rtl_lowpower_hidden_functions(tp->pci_dev);
+
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_put_sync(&pdev->dev);
 
-- 
2.43.0

