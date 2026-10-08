Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDD3347C6;
	Thu,  8 Oct 2026 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791442993; cv=none; b=A1qZ9Em/IL1HJwzWZmZAt/gx7UUWb7l0kOto+gNs+tBQNoZBifj3cd6D+GLg11BZf2gG204GHtA5LFVFK/TEqMYywZVrzkiKVexqzhG3Lq0+1tIV3RZ5a6c4UTKlpo98C7XbnDQvGIl01nbmrzSKc+gnD8WLyYArDgTQB+FwZBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791442993; c=relaxed/simple;
	bh=Cdyw1hTiLU37GgEJ3SHHwIUbg2hy2ux1Fk03H9yysqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrL5TQkGR4EoNEbncuNMBq6gX1AVapEyoFBV5EnKbf1dK8nwtOZ+SxKYYm1+is2fJxnHH6sn5LaeLPDzbG7p5jWSSWwaj+z6sl4qavGQkXaRI/TlCATMq3sQhs9jb4leKwUDfD0OD3WdLWcc9Nz3dHnktgjDRPkFpIviZ9vtv5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=M6YOd5jD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="M6YOd5jD"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6986vRPT1281951, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1791442647;
	bh=LZ6cNLA2XSFAhEEMraHLx/4pOo60AzCLnS3bC055tIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=M6YOd5jDo71AV5bNcanNkEX7XMwkF31nZdEENJLICN++qJhh0azUVSoI7R+Om6fro
	 fv6ywwL55RM1MDU2gE0q8M4wpEzOpLUA7g2W7E037Y58JHVvsph0oKUDTF5vGlzgBk
	 QJ32ksmZeyRael8nZlvbEWjvM6iuznj65C2kwZb5xL5QYl5bpC00jKSiXpc4GWVuDX
	 W1rOZnPn0O7ep50+GrcIrXmocBmkwnaUocghfLI2/hGfbZpG6OFJI48Gk6R7U8ISaI
	 WjW7qLitQCUVzRKqbxUeKxYff30JNpqSq+PuHfi/aGpnjV5Q4B0JU3G9HB/WAC/wtj
	 8Ix+7AahmkUlQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6986vRPT1281951
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Oct 2026 14:57:27 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:57:26 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 14:57:26 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@armlinux.org.uk>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v16 7/7] r8169: add get_channel support for ethtool
Date: Thu, 8 Oct 2026 14:57:22 +0800
Message-ID: <20261008065722.1026-8-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261008065722.1026-1-javen_xu@realsil.com.cn>
References: <20261008065722.1026-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

Add get_channel support for ethtool.

In multi-vector mode, it reports the active RX channel count and a
single TX channel. Additionly, it reports one other channel to account
for the dedicated link-change interrupt vector.

In single-vector mode, where RX, TX, link-change events share the same
interrupt, it reports a single combined channel.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v11:
 - new file, no change

Changes in v12:
 - no changes

Changes in v13:
 - no changes

Changes in v14:
 - no changes

Changes in v15:
 - no changes

Changes in v16:
 - modify commit message
 - add other msix count in get_channel function
---
 drivers/net/ethernet/realtek/r8169_main.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index de0c860328ba..88354e7570f0 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -6741,6 +6741,24 @@ static void r8169_init_napi(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl8169_get_channels(struct net_device *dev,
+				 struct ethtool_channels *ch)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	if (tp->irq_nvecs > 1) {
+		ch->max_rx = tp->hw_supp_num_rx_queues;
+		ch->max_tx = 1;
+		ch->max_other = 1;
+		ch->rx_count = tp->num_rx_rings;
+		ch->tx_count = 1;
+		ch->other_count = 1;
+	} else {
+		ch->max_combined = 1;
+		ch->combined_count = 1;
+	}
+}
+
 static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -6759,6 +6777,7 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.nway_reset		= rtl8169_nway_reset,
 	.get_eee		= rtl8169_get_eee,
 	.set_eee		= rtl8169_set_eee,
+	.get_channels		= rtl8169_get_channels,
 	.get_link_ksettings	= rtl8169_get_link_ksettings,
 	.set_link_ksettings	= rtl8169_set_link_ksettings,
 	.get_ringparam		= rtl8169_get_ringparam,
-- 
2.43.0

