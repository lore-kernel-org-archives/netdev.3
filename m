Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FBE377579;
	Mon, 20 Apr 2026 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651657; cv=none; b=PxPtIi8Kl+BXAMMGD1YPJiNbZgE4oMDTKXbamyYbeSF/fINPgcMA9RKe90njhmOx4+GIqjExSMiUFyGhF3kLeaBG01fIKDatn4JPNJAp4YA2EvhHz61UztVznPYg51VgMDEwU4NARbL7+5KuS7E9yuWFXwpAwl+wAQCgXXjZrqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651657; c=relaxed/simple;
	bh=0MQ114wC8eOAw7NUpEjTS13PtJ63qar0k1jaxXAjyWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuIm2r/HpVX/1/RDL923SrasxvZWcxBozG3mzDmftH46NqMZjfiGfDIy6qeJGSTzopZ4n/2fYVb/QeOoqu5z7Bq1svL4EduaJVqsdLqkWhRp0E1bwkTngGBNupZCD78ZA1HphvcKMqzKw83fP2rjuHs6+FvlgOF9GurwbyFfn/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=vySU4PXW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="vySU4PXW"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K2KFBl8277433, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1776651615;
	bh=Gsk7mzSm2HhUX3oQrymdkV6N6yErhy7ZgenuOBqhUHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=vySU4PXWRTl87DtdDt9+6g0d9ufYAtZiT3ZnBxCISB3Py5LFGFU4yQM9hCIzSBePO
	 611kecv0O2gjqwSw1xRRXUeI9MI9ytTvwl37GwLtCa/1pkRGvd46FTu06nRQ8IJ5CB
	 /XcqX3QZ/2dpVgG6v+RXtslod2IF/dFbdcQms/oea2+eED/RmOBs/NzecKRRY/yuF8
	 6NSQXyTpUB77lphJXe16baOmI2sDPYczqjiRuJuFG39uBw9a4LMz6N3PKgfKfk5ZP2
	 pdM6FQurPuXeTeuMAEHgilxy1lhc+zCoiLNoPM5Ytyk9FSVrLCLis9HzZS9NFce8tj
	 XOc9yhcEyINww==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K2KFBl8277433
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Apr 2026 10:20:15 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 20 Apr 2026 10:20:14 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 20 Apr 2026 10:20:14 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [RFC Patch net-next v1 6/9] r8169: enable msix for RTL8127
Date: Mon, 20 Apr 2026 10:19:54 +0800
Message-ID: <20260420021957.1756-7-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260420021957.1756-1-javen_xu@realsil.com.cn>
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This patch enables msix for RTL8127.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 7d493342ab4b..622ee8905a05 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4102,6 +4102,16 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
 	return r8168_mac_ocp_read(tp, 0xe00e) & BIT(13);
 }
 
+
+static void rtl8125_hw_set_interrupt_type(struct rtl8169_private *tp)
+{
+	u8 tmp;
+
+	tmp = RTL_R8(tp, INT_CFG0_8125);
+	tmp |= INT_CFG0_ENABLE_8125;
+	RTL_W8(tp, INT_CFG0_8125, tmp);
+}
+
 static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 {
 	rtl_pcie_state_l2l3_disable(tp);
@@ -4110,6 +4120,9 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	RTL_W32(tp, RSS_CTRL_8125, 0);
 	RTL_W16(tp, Q_NUM_CTRL_8125, 0);
 
+	if (tp->features & RTL_FEATURE_MSIX)
+		rtl8125_hw_set_interrupt_type(tp);
+
 	/* disable UPS */
 	r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);
 
-- 
2.43.0

