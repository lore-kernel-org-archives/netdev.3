Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.19.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964404;
	b=QJgJklU9ReiK52TfDuQZuW9RyzTEYzDdw47forYqS5tSj9rv5i87FS1cbROlWe23kpEI
	 6I5e5c+RoMgv+UUSGbx34XfxFLxHhV0zL7LRRChe/Mx6HbJvOEE+M0+S0SooY5B+zJTXW
	 H3C40eOkCkgwmoDa4qS7HQcgrniveXdg7MmUQCjq8qPuGzI4eyTmM+Ougeg/pmbeUU/2B
	 TpCop1nIpbiO8Dxso6/tQv9hkjb68HKnbC0XPwmtLEKF5ilf8CpxiRVQXmYVfKFHK1hJ3
	 09BoSWGWHhDE0AyemF4fU0jAYTVmksPkCb26BSVVS9irUkeN9VVZOOuwzD1By3mI8ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964404;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=+gta5EN2fM/NtSA3eiTVF9V46oJChoU+U0/lL1FLCRk=;
	b=1zv61T0naxsqoIPfmAsicKvkFaun6GyXXjyWR5RlSOgK6XeaiAni+eERXoEwnwWCFFMT
	 n/F6/qG+dnyqDZjuUDGdZ4DHYcaYkooHpHNk2eWUhWWi6wDpLjV6X4sfQpC4cFJDq9jGr
	 rRFiGtD1J5eBfgsS7zIDwwUgJk6Gphl48t/SC5pgGzYmeZdHDlsFAECB8eUhWQv4gGU2E
	 v96r4bH/Fm0fxWGUDgMgMglFtB2SJUmLqompYIyGnv+rTSp+jtNaCPQmvX1k7B+9IlJfy
	 6alvZ3Bpsm2IztUb2Xk0qqceluBzFxMJ12+uOb/xQGJ1XDOd+PHoJ2eOyVIXepUYxsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mucse.com;
	spf=pass smtp.mailfrom=mucse.com;
	arc=none smtp.remote-ip=54.207.19.206
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90895606A330;
	Fri,  6 Nov 2026 11:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90895606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz15t1793964338tde4a41f2
X-QQ-Originating-IP: Pmyjwc9SYn8IlwJdzKhC0IPAKsDzhQu6VThi4+ZOcsQ=
Received: from nic-Precision-5820-Tower.tail7b ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Nov 2026 19:25:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18325714602759019196
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
Subject: [PATCH net-next 3/5] net: rnpgbe: Support copper link configuration
Date: Fri,  6 Nov 2026 19:25:33 +0800
Message-ID: <D2E577671FEE0E12+20261106112533.44065-1-dong100@mucse.com>
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
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MCHGquX4Y4ho9h+FulnUNVIOgDOeCrRrlLSMFScG1jRGi5vfzYH5G9/+
	Gr+OK5huknZ7+BMFUF01eX4UZosuAbEvN7NqzYPvxqesRbXI2OAeSEdBl8UViADOEG7dIv3
	/V52yEOX6DMoQs2SpSpmp4b1Z7Mv3REuKToAr4+PutoiYmHZQUCj4Ko3dFdn53JAWV1UtuQ
	7PsJuf2c6AYnqBon4CTmsbJSwHZj8nygkFHqakM+z7jIiwhlVWnx7ClvsDz2ZdLV9eYQMGq
	GP62IuR73+vyIvigDdn7cNtVdG9HQgAaUsoWwGzOBJ15mOAd+gM42ffZXBFzNrWN0J/5GMp
	/tWMftu2SplQaPx+3XjvWvjKSlqle4IMcuKgT4JjzDmHU4W8pmvZjMMVJxagN3S4u4qM+bn
	8JnUvV8o9WS8REOxRyzqNBmq0FB1Fy79zoF7q4L88tK0IzQRCqYmxUDHKWN8cdnUjIWqkz8
	PmL7qMln3bwnuEzHkP1ot9i9a45gWmogoYtib55c45P01cK9tPlwMbVBedn4chyfQcwlkUx
	m4Dg4ZtY9TBpupKv1nUKv4SHit4mpCnQMRxm/ShIUkMYLxN5+Qrkv+WH2x6mWtijY4m9e74
	F2O61+h2LhmZUsvNr7Ed2kjRFKAZFpY5uKs3SNwj6WhjN06YjQaWtgdvIo/sIGuSYxS5qhA
	8F4azKgGDSjNjPrpsdV6QrEl/jNRKQxkJ/SmpdibPfBDcscdW0Q92mWd1VfZ8YzsXIucFiQ
	6q6SDoMEyZzU7CX2bUx8cdBA3lcHmhKlb6nvN5uf7V6RYUNXOtX3B85LTof3IsaqBMqEWE0
	bMZl8hKlRWn3WZwUt4mRIIDTQRHUQ1Sf0r3VV4dL+xAoyUfxp7oVM6I3FkPGdEuwJAks+Gn
	mzJ2T62VJHxf2WI6P4F/LNk8A6N7uDYk5Y6/VASSZMdXmQfek7HbfKsTDIJ/pAG2ynIffXY
	z4qvO6sMiVWlw0H3q7dYsPEfXu3gn2xBvR1SBvuLyVOKaXo8iHkIULzQhFnXAp3kjWlOVOc
	g8ynf4ivb2aHJvKaZ3quk6imwTe6+BwULBrukgcQE86IC62w42D1eQPnrrg0Teo/vWNowy5
	PtS2Pgg0t9jNtXXmJnSSvUfGs96+f4G4VDZa3ZQ8jbX
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Add set_link_ksettings support for copper ports to configure
autonegotiation, advertised link modes, forced 10/100 Mb/s speed and
duplex, and automatic or manual MDI/MDI-X selection.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 .../ethernet/mucse/rnpgbe/rnpgbe_ethtool.c    | 88 +++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  2 +-
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_ethtool.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_ethtool.c
index 3ff01a15961e..cd3cca1474ec 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_ethtool.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_ethtool.c
@@ -131,6 +131,93 @@ static int rnpgbe_get_link_ksettings(struct net_device *netdev,
 	return 0;
 }
 
+static u32 rnpgbe_fw_link_modes(const unsigned long *modes)
+{
+	u32 fw_modes = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rnpgbe_tp_modes); i++) {
+		if (linkmode_test_bit(rnpgbe_tp_modes[i].ethtool_mode, modes))
+			fw_modes |= rnpgbe_tp_modes[i].fw_mode;
+	}
+
+	return fw_modes;
+}
+
+static int rnpgbe_set_link_ksettings(struct net_device *netdev,
+				     const struct ethtool_link_ksettings *cmd)
+{
+	struct ethtool_link_ksettings settings = {};
+	struct mucse *mucse = netdev_priv(netdev);
+	u8 mdix = cmd->base.eth_tp_mdix_ctrl;
+	u32 advertising, mode, supported;
+	bool autoneg;
+	int err;
+
+	if (cmd->base.autoneg != AUTONEG_ENABLE &&
+	    cmd->base.autoneg != AUTONEG_DISABLE)
+		return -EINVAL;
+	autoneg = cmd->base.autoneg == AUTONEG_ENABLE;
+	if (!mdix)
+		mdix = mucse->hw.mdix_ctrl;
+	if (mdix != ETH_TP_MDI && mdix != ETH_TP_MDI_X &&
+	    mdix != ETH_TP_MDI_AUTO)
+		return -EINVAL;
+
+	err = rnpgbe_get_link_ksettings(netdev, &settings);
+	if (err)
+		return err;
+	if (settings.base.port != PORT_TP)
+		return -EOPNOTSUPP;
+
+	supported = rnpgbe_fw_link_modes(settings.link_modes.supported);
+	advertising = rnpgbe_fw_link_modes(settings.link_modes.advertising);
+	if (autoneg) {
+		if (!linkmode_subset(cmd->link_modes.advertising,
+				     settings.link_modes.supported))
+			return -EINVAL;
+		advertising = rnpgbe_fw_link_modes(cmd->link_modes.advertising);
+		if (!advertising)
+			return -EINVAL;
+	} else {
+		if (cmd->base.duplex != DUPLEX_FULL &&
+		    cmd->base.duplex != DUPLEX_HALF)
+			return -EINVAL;
+		switch (cmd->base.speed) {
+		case SPEED_10:
+			mode = cmd->base.duplex == DUPLEX_FULL ?
+				RNPGBE_FW_ADV_10_FULL : RNPGBE_FW_ADV_10_HALF;
+			break;
+		case SPEED_100:
+			mode = cmd->base.duplex == DUPLEX_FULL ?
+				RNPGBE_FW_ADV_100_FULL : RNPGBE_FW_ADV_100_HALF;
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (!(supported & mode))
+			return -EINVAL;
+	}
+
+	err = mucse_mbx_set_link(&mucse->hw, advertising, autoneg,
+				 autoneg ? 0 : cmd->base.speed,
+				 autoneg ? 0 : cmd->base.duplex, mdix);
+	if (!err) {
+		mucse->hw.mdix_ctrl = mdix;
+		mucse->hw.link_config.advertising = advertising;
+		mucse->hw.link_config.speed = autoneg ?
+			SPEED_UNKNOWN : cmd->base.speed;
+		mucse->hw.link_config.duplex = autoneg ?
+			DUPLEX_UNKNOWN : cmd->base.duplex;
+		if (autoneg)
+			mucse->hw.link_config.status |= MUCSE_LINK_AUTONEG;
+		else
+			mucse->hw.link_config.status &= ~MUCSE_LINK_AUTONEG;
+	}
+
+	return err;
+}
+
 static void rnpgbe_get_drvinfo(struct net_device *netdev,
 			       struct ethtool_drvinfo *info)
 {
@@ -148,4 +235,5 @@ const struct ethtool_ops rnpgbe_ethtool_ops = {
 	.get_drvinfo = rnpgbe_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_link_ksettings = rnpgbe_get_link_ksettings,
+	.set_link_ksettings = rnpgbe_set_link_ksettings,
 };
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index 469818b83d70..7af56fce2e22 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -236,7 +236,7 @@ int mucse_mbx_set_link(struct mucse_hw *hw, u32 advertising, bool autoneg,
 
 	len = le16_to_cpu(req.r.datalen);
 	mutex_lock(&hw->mbx.lock);
-	err = mucse_write_and_wait_ack_mbx(hw, req.dwords, len);
+	err = mucse_write_mbx_coalesce_event(hw, req.dwords, len);
 	mutex_unlock(&hw->mbx.lock);
 
 	return err;
-- 
2.50.1

