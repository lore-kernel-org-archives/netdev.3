Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9392A3F44FC;
	Wed, 16 Sep 2026 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546562; cv=none; b=MqdCSrsBr27BxdCh4DULP0kIbf4szrPEGfDJJh4IBfTyIGZaGX6Lsh6AVfW8KUKOPNvDgZVZqwQH8InnwhmLUY6LQ+Wlah+vmL4n8H9TsAeBmutSGgPniEVChmrJgM+1qw/pam9OW0o2hqxQeRHeboPhMOs9JS+eJjDJOEE4HP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546562; c=relaxed/simple;
	bh=5BElwzIYg6S0lPTG3+GbIm3hiSMbPCPC5VuOV0LdoHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mY4Kor35UA+5JLAJdiSNVAPenSzNKVXdKJuY/s1zDcfpzd8eTAOPVq4RU45Nv+GKHZeAcCAGm/f7e34uNqDciwTXz9WkmMdIxbjfh+B1TJYO5s2W+ZW7QQ6ezbN+gUD3mgw0uCzSj/M/Qy4M82naoRdmPNadqgr4c7kmmNdHVeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=ebrhZeuU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="ebrhZeuU"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68G8ElRS22223080, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1789546487;
	bh=+NYKCMtg6AexNYG5UAUXyUwaYd3+HL4xC1XZfEXlLvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ebrhZeuUbNAGbrNa0MLWMy7M8gUZvr3JzSHkMPOprOvd6VizUHmfJKALrNSbj/4sa
	 N7ImkoKEYIDdtVtsQqvUWr9Mr8GJaYMM2PD/27VjwInflLasAWex5OVSnkrF/nXcUI
	 Xb/4pOL5Pj9unxGu9amrJiQJH/6cToYuy6Adt0ziAjaVxuVnb37uH7QpoF+ghnsJVQ
	 aZPZ8vQNnNgP62CvD9mERUqgepnC9MvdnOmaojocnQnI1u+ANkasWivpNvO765RyWM
	 ZXCG4EadD94SsHrpkNt3rQCcUkYXcvy5rg1KAmc/FrtVdKumB6bFE9lOJhkSD3i0ml
	 CWLAIQSky2tEw==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68G8ElRS22223080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 16:14:47 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 16 Sep 2026 16:14:46 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 16 Sep 2026 16:14:46 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 2/3] net: phy: realtek: add firmware for RTL8261D
Date: Wed, 16 Sep 2026 16:14:43 +0800
Message-ID: <20260916081444.497-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260916081444.497-1-javen_xu@realsil.com.cn>
References: <20260916081444.497-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

Add support for RTL8261D to load firmware.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/phy/realtek/realtek_main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index d0d09e8e8f5c..27051e2c7b5f 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -286,11 +286,15 @@
 
 #define FW_MAIN_MAGIC			0x52544C38
 #define FW_SUB_MAGIC_8261C		0x32363143
+#define FW_SUB_MAGIC_8261D		0x32363144
 #define RTL8261X_POLL_TIMEOUT_MS	100
 #define RTL8261X_MAX_MMD_DEV		31
 
 #define RTL8261C_CE_FW_NAME	"rtl_nic/rtl8261c.bin"
+#define RTL8261D_FW_NAME	"rtl_nic/rtl8261d.bin"
+
 MODULE_FIRMWARE(RTL8261C_CE_FW_NAME);
+MODULE_FIRMWARE(RTL8261D_FW_NAME);
 
 enum rtl8261x_fw_op {
 	OP_WRITE = 0x00,	/* Write */
@@ -341,6 +345,7 @@ struct rtl821x_priv {
 };
 
 struct rtl8261x_priv {
 	const char *fw_name;
+	u32 fw_sub_magic;
 	bool fw_loaded;
 };
@@ -411,10 +416,13 @@ static int rtl8261x_probe(struct phy_device *phydev)
 	switch (sub_phy_id) {
 	case RTL8261C_CE_MODEL:
 		priv->fw_name = RTL8261C_CE_FW_NAME;
+		priv->fw_sub_magic = FW_SUB_MAGIC_8261C;
 		phydev_info(phydev, "RTL8261C detected (sub_id 0x%02x)\n", sub_phy_id);
 		break;
 
 	case RTL8261D_MODEL:
+		priv->fw_name = RTL8261D_FW_NAME;
+		priv->fw_sub_magic = FW_SUB_MAGIC_8261D;
 		phydev_info(phydev, "RTL8261D detected (sub_id 0x%02x)\n", sub_phy_id);
 		break;
 
@@ -473,6 +481,7 @@ static int rtl8261x_read_status(struct phy_device *phydev)
 
 static int rtl8261x_verify_firmware(struct phy_device *phydev, const struct firmware *fw)
 {
+	struct rtl8261x_priv *priv = phydev->priv;
 	const struct rtl8261x_fw_header *hdr;
 	u32 main_magic, sub_magic;
 	u32 calc_crc, file_crc;
@@ -493,7 +502,7 @@ static int rtl8261x_verify_firmware(struct phy_device *phydev, const struct firm
 	}
 
 	sub_magic = le32_to_cpu(hdr->sub_magic);
-	if (sub_magic != FW_SUB_MAGIC_8261C) {
+	if (sub_magic != priv->fw_sub_magic) {
 		phydev_err(phydev, "Invalid sub magic: 0x%08x\n", sub_magic);
 		return -EINVAL;
 	}
-- 
2.43.0

