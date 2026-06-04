Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295EC3D6CDB;
	Thu,  4 Jun 2026 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568883; cv=none; b=cdvGczgE7Zp+aUbqTpQSvB0FBy+f6QSowkSNXGsxLCJ/wsdMSPngjU0p/8goML6+j2EHcfHS9aVgN8TQqaKdklOVSDnRtMISqv1w/poWzvfTEV17dDoBbQYA4ndUmoi35uoZUT6kMgTJF/ECpV8hmWK0HEJxdfWWc6SFwTwbpnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568883; c=relaxed/simple;
	bh=rYAw6159oheg+nH4cGJcK95R4/mkk/NYBHiCSKTnBCU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMIZLxV4J7Xjuw6wTx/GyP2c0Wt3OfsmhKE2KjMYBx11OLuQvq07UH+EPqKQF0Pbvn+Z0KLGejbPiofmnjizH6d3I8Nib4IBjwLfSmziPp5rasZ1SmjsHFVUmBmxgP5IQceWgkfBxBbfrVViBu9quymhxhoXTFLbd6IFqP1P9nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=EsBIjOmb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="EsBIjOmb"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 654ARa622272242, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780568856;
	bh=x1nFGHu126pSqs43OEXyxZh3Xes1NWcDX9fIgTGuIow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=EsBIjOmb94kwtPc6kkjlI6DxOQ1g4IZfH/+Dk5ZUH/2Nduy+WaH1hZ6aYEDq70ye3
	 PEzy0J7dHVGZ/SZze8k5UoGB34ykuV3HfEocFVuQQois7dCpj4mU0U6IVt5Doy7aaQ
	 SXiTrYFUYMKdo+5REKyES7OdfCUwAnjpg8ztGdWS+4fDS8iRk9JGLNwAubGJnLU3m9
	 DW9g91Ku65Nh6WsQcSnxBAJpkUA+mBUO3CEGIcpncGD/gk5VGI9kvwfdUkEBNTAcVv
	 FqkD7MdL3crBXz307nt5JfDKuMDjfKqCKZogJBWqiHKWhM3sfCdigPZHEhEvEis7m+
	 dmV7FQK/wzTuA==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 654ARa622272242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 18:27:36 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 18:27:36 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 4 Jun 2026 18:27:36 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v7 4/7] r8169: enable new interrupt mapping
Date: Thu, 4 Jun 2026 18:27:30 +0800
Message-ID: <20260604102733.1582-5-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260604102733.1582-1-javen_xu@realsil.com.cn>
References: <20260604102733.1582-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This patch enables new interrupt mapping for RTL8127.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes

Changes in v3:
 - no changes

Changes in v4:
 - no changes

Changes in v5:
 - no changes

Changes in v6:
 - no changes

Changes in v7:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index a416d482aa86..44dfdd3d4d75 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3945,6 +3945,15 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
 	return r8168_mac_ocp_read(tp, 0xe00e) & BIT(13);
 }
 
+static void rtl8169_hw_enable_vec_mapping(struct rtl8169_private *tp)
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
@@ -3953,6 +3962,9 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	RTL_W32(tp, RSS_CTRL_8125, 0);
 	RTL_W16(tp, Q_NUM_CTRL_8125, 0);
 
+	if (tp->irq_nvecs > 1)
+		rtl8169_hw_enable_vec_mapping(tp);
+
 	/* disable UPS */
 	r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);
 
-- 
2.43.0

