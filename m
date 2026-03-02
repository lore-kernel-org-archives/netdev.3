Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F98430BBA;
	Mon,  2 Mar 2026 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772433184; cv=none; b=BqS9Y6puJJi3sNtr9NoJfTfBQdptX10pl0f6nmIkTRIWapkZ9V/e8bTx2PSvtpqQGDJ9J3v+LFV2LhMhFn+FDcyc1CJO1vRtDD05dMwLbwTfsYLkiVlglkdKB7x57HtxJVWVKFogcjFotmI+A9HND0hVVzl/5Of2GHz6Sk8E1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772433184; c=relaxed/simple;
	bh=AmiDiX3u2FvFSV1ewjNpDCbkSNCwqJ/S6aRddquk3Ak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwCnf6hdHrss+17u59TdT1364pSlv8YPZDr3Tn8PIbOAWc71CNERI4o7Yu+ZoESOeYTVGmtanz3MmBGRu5r1/pY2W9lkRKjdBCpgnpDI/Z+oc5foAm47RZVrICXs9jIBaZaYx56rPPO8D1teNXqv8Mme3G+Ea3lxWxhSUdYR01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=TXMPF4JV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="TXMPF4JV"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6226WXHc82520776, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1772433154;
	bh=YcvsglXAjNM65+Z3dMzq1amg2E3Wn5iUDNgM8l581C8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=TXMPF4JVRiyQDl0X+J0zbKvH7wmhI/AyLmpjU+ubPfds5GyNx+wccSKg5fGN+Y+Z8
	 WDHSOI20cFxIHxF8Be8ln5Qo4eZ0oufdchgL0p9X70wPTYFR4FqZFkQwwxut1zSAK7
	 r6k2OR1sJUbIbcT4zTV6DcTLpdU6fVaBF+4apnfr/9oSDNDM96H/kTaW+3qTb/q+6n
	 K8PehJkBn4tSSYCVX4PvlbNawZjmvZX39O+RrcQDZCJ0gnX8r3p9D3GhceOeDrJ2/D
	 CmsGnsD0L7hF/9T5wX8sbWmISTkv9v+tEuoONBNjkM3gH3Fo+DiZSOtxH8kjbqa6vF
	 7VRw6m+Seg6gA==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6226WXHc82520776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Mar 2026 14:32:33 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 2 Mar 2026 14:32:33 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 2 Mar 2026 14:32:33 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 4/4] r8169: enable system enter c10 with RTL8116af
Date: Mon, 2 Mar 2026 14:32:14 +0800
Message-ID: <20260302063215.1790-5-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260302063215.1790-1-javen_xu@realsil.com.cn>
References: <20260302063215.1790-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

RTL8116af is a multi function chip. Function 1 is load with r8169
driver. Function 0 is bmc virual driver which is used for power
management. This patch set Function 2 to 7 into d3 state when config
hw_config. This helps the whole system enter c10.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 95 +++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 787859b0ab68..d8ffc76186b2 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1121,6 +1121,100 @@ DECLARE_RTL_COND(rtl_ocp_gphy_cond)
 	return RTL_R32(tp, GPHY_OCP) & OCPAR_FLAG;
 }
 
+static u32 rtl_other_csi_read(struct rtl8169_private *tp, u8 multi_fun_sel_bit, int addr)
+{
+	RTL_W32(tp, CSIAR, (addr & CSIAR_ADDR_MASK) | multi_fun_sel_bit << 16 |
+		CSIAR_BYTE_ENABLE);
+
+	return rtl_loop_wait_high(tp, &rtl_csiar_cond, 10, 100) ?
+		RTL_R32(tp, CSIDR) : ~0;
+}
+
+static void rtl_other_csi_write(struct rtl8169_private *tp,
+				u8 multi_fun_sel_bit,
+				int addr,
+				int value)
+{
+	RTL_W32(tp, CSIDR, value);
+	RTL_W32(tp, CSIAR, CSIAR_WRITE_CMD | (addr & CSIAR_ADDR_MASK) |
+		CSIAR_BYTE_ENABLE | multi_fun_sel_bit << 16);
+
+	rtl_loop_wait_low(tp, &rtl_csiar_cond, 10, 100);
+}
+
+static void rtl8168_clear_and_set_other_fun_pci_bit(struct rtl8169_private *tp,
+						    u8 multi_fun_sel_bit,
+						    u32 addr,
+						    u32 clearmask,
+						    u32 setmask)
+{
+	u32 val;
+
+	val = rtl_other_csi_read(tp, multi_fun_sel_bit, addr);
+	val &= ~clearmask;
+	val |= setmask;
+	rtl_other_csi_write(tp, multi_fun_sel_bit, addr, val);
+}
+
+static void rtl8168_other_fun_dev_pci_setting(struct rtl8169_private *tp,
+					      u32 addr,
+					      u32 clearmask,
+					      u32 setmask,
+					      u8 multi_fun_sel_bit)
+{
+	u32 val;
+	u8 i;
+	u8 FunBit;
+	/* 0: BMC, 1: NIC, 2: TCR, 3: VGA/PCIE_TO_USB, 4: EHCI, 5: WIFI, 6: WIFI, 7: KCS */
+	for (i = 0; i < 8; i++) {
+		FunBit = (1 << i);
+		if (FunBit & multi_fun_sel_bit) {
+			u8 set_other_fun = true;
+
+			if (i == 0) {
+				set_other_fun = true;
+			} else if (i == 5 || i == 6) {
+				if (tp->dash_enabled) {
+					val = rtl_eri_read(tp, 0x184);
+					if (val & BIT(26))
+						set_other_fun = false;
+					else
+						set_other_fun = true;
+				}
+			} else {
+				val = rtl_other_csi_read(tp, i, 0x00);
+				if (val == 0xffffffff)
+					set_other_fun = true;
+				else
+					set_other_fun = false;
+			}
+			if (set_other_fun)
+				rtl8168_clear_and_set_other_fun_pci_bit(tp, i, addr,
+									clearmask, setmask);
+		}
+	}
+}
+
+static void rtl8168_set_dash_other_fun_dev_state_change(struct rtl8169_private *tp,
+							u8 dev_state,
+							u8 multi_fun_sel_bit)
+{
+	u32 clearmask;
+	u32 setmask;
+
+	if (dev_state == 0) {
+		clearmask = (BIT(0) | BIT(1));
+		setmask = 0;
+		rtl8168_other_fun_dev_pci_setting(tp, 0x44, clearmask,
+						  setmask, multi_fun_sel_bit);
+	} else {
+		clearmask = 0;
+		setmask = (BIT(0) | BIT(1));
+		rtl8168_other_fun_dev_pci_setting(tp, 0x44, clearmask,
+						  setmask, multi_fun_sel_bit);
+	}
+}
+
 static void r8168_phy_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
 {
 	if (rtl_ocp_reg_failure(reg))
@@ -3785,6 +3879,7 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
 	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
 	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
 
+	rtl8168_set_dash_other_fun_dev_state_change(tp, 3, 0xfc);
 	/* firmware is for MAC only */
 	r8169_apply_firmware(tp);
 }
-- 
2.43.0

