Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8296B4D8CE
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784393841; cv=none; b=O3zDfODoeQbBnQbs8g2XNbhYID9GyjoPrTNOBmN9XPFy4fsHS2rGbHx0hhBe4zKhgDTBPizi8vG1t20El7J28QZgIRM58tEbKzjjWLPH4cJ+W42JO0eVDTD1yqpMMQJiZ+QppnZj9xoLDd32BmGUQTUHm0cDvpFJAvDN20d7t6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784393841; c=relaxed/simple;
	bh=kt3K33l30KtxbRme/CbUVHy7G6sQmnff56xenuaUKq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tqGtgw8f/mSUDWEwiIcIeUptrREJqiK2z5zal3xaFoSYBPMNVVclADTZT4gWMAOe6DsmcuwlbBWXFaO8xnLdyUhYHWISoPRaieOPIyAa0LkGtvmFaTbb0nukpTQEAksMl04YCgaxcT7ZnTHb05fE1Ey3HWs+pT/9ueeXSV/oR/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTbBIfBA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTbBIfBA"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69c7c8accffso13100177a12.2
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 09:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784393838; x=1784998638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CsnJtqNCcYIxOQeyroi0AxeK7dRAVN05DqE4BmgloCA=;
        b=CTbBIfBA8elnId65TJI37zLvQ1GesPe1Bj7YqVeECdHi2IWDzS+ilnqg2A3r4FakV7
         qBy7LM8RnGyp6sAVTqzZof6+8UVZTOED++1VY7msemZjVa9Bd1gCrL+GaSjz8PnhTvdv
         V9mpQAepkLvd/LzJYnoN3dWwqzRcFeYAgA5nxVN0ABHiSXYZQn1w4HETehHeGO1cfvkW
         LecVvhFjnzfyLH6+9qaDEU3fzxv1iDL6SCxfVyi1SUww92Jr09Vm1ZWNhAnmYTAj9e74
         SVrLdM6NCymIE5l/IIsgezXyHE1TgfFmGVfSmyHJYaaqeuXVsp/10Fh8wiqHybemGPk2
         5c8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784393838; x=1784998638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CsnJtqNCcYIxOQeyroi0AxeK7dRAVN05DqE4BmgloCA=;
        b=F3gwRXCLLM/FnWShAEQMELF0/Umgdb1ZqiZCokW/vFZ7rd5S7wZSEUvh3eQjlFwptM
         NDxUkGMRtz+z/ClFErNh9FIDCL9UZWmKBvaYBhJIuEHNUXj4xjTvLgjRI1SJDFweMSci
         cJhvHlsOrWzeACY+vgYIOimpF6ZwhwmeXkokISRTUVEMGHwpWZKmf8zsaCOFk+2g/6mv
         7wRxr6qGJtnu/4xsP8oRlx9ZYs7xChQoAQOIwYMxgNMikK4kLU2SXxfZAYMQPggZKQUc
         3Mvhez3lg4ffngoZCJTWhsuKdW5LJ/7JBs7DxxCMxy79B4duBId39i+74i/TTadnCKJz
         AHhA==
X-Gm-Message-State: AOJu0YwW5gzliU3pbTL1YLT7Jov9OMPmHa4HwBz9+7H7pHhPF64I5U9W
	QPxx0pk8U+BHaW3dRnKF/KU1ZJiHMQ2WEhtKnlSRdeAfcT0Lk8W5sY6iMwjc9fIg
X-Gm-Gg: AfdE7cnz5VkWgG5IGlgzYQzkKTIm/NVHXzn2GrwnMDUrRKqgxGWpXDZzRJPDZmAO9G+
	7P8IcsCsHZBkGuiX5DXH6+OkNu9reyk3ho4TjuiPVYe6dtL72uCCc+reDbNKfD8pOu45d59n2cD
	rHu2r5CwZtKwMHN9kOdegKyvgejsDMQ3dgeI92bFdnMr/IPUGBWJLZpMS9XJOEk3BJm8lVFfhfM
	EtuwwOizU2sjq3AvMNjkfoZolRy8xK58SoJf/FmQmHP21TzmIzXMETZwOf0HbLPdNfnAnuLJVwe
	MvdvoBnWi9QQBdQJaNxEzzaOUMp/uw59peQLgd9rP/eMCvqbfn6C99NGDbf7UpfJ5e09Tx/SBNJ
	d1qiG4OSDhgFdzxykTdYiYLKsMqrp4B3TxN6uxP7ENG5Bn+k5PDbuh5IqgOUzgi+FKs0nvQ621P
	nAnK+RukpiRxdv/+dgwsjp5KORnIU=
X-Received: by 2002:a05:6402:234f:b0:699:f957:d37f with SMTP id 4fb4d7f45d1cf-69e652ee745mr2756200a12.27.1784393837730;
        Sat, 18 Jul 2026 09:57:17 -0700 (PDT)
Received: from tempest2.110.lan (xt27d7.stansat.pl. [83.243.39.215])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffed537sm2328520a12.24.2026.07.18.09.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 09:57:16 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] igb: read SFP module EEPROM through igb_read_sfp_data_byte
Date: Sat, 18 Jul 2026 18:56:25 +0200
Message-ID: <20260718165637.3621784-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

igb_get_module_info() and igb_get_module_eeprom() use
igb_read_phy_reg_i2c(), which accesses the external PHY register space.
On designs with an external SGMII PHY this returns PHY register contents
instead of the SFP module EEPROM requested by ethtool -m.

Use igb_read_sfp_data_byte() for module EEPROM reads. The legacy
ethtool module EEPROM offset space maps directly to the I210 I2CCMD
module address space: offsets 0x000-0x0ff address the SFP base EEPROM
and offsets 0x100-0x1ff address the diagnostics EEPROM.

Assisted-by: Codex:GPT-5
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 40 ++++++--------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 65014a54a6d1..0fb15bd940d7 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3209,7 +3209,7 @@ static int igb_get_module_info(struct net_device *netdev,
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 	u32 status = 0;
-	u16 sff8472_rev, addr_mode;
+	u8 sff8472_rev, addr_mode;
 	bool page_swap = false;
 
 	if ((hw->phy.media_type == e1000_media_type_copper) ||
@@ -3217,22 +3217,26 @@ static int igb_get_module_info(struct net_device *netdev,
 		return -EOPNOTSUPP;
 
 	/* Check whether we support SFF-8472 or not */
-	status = igb_read_phy_reg_i2c(hw, IGB_SFF_8472_COMP, &sff8472_rev);
+	status = igb_read_sfp_data_byte(hw,
+					E1000_I2CCMD_SFP_DATA_ADDR(IGB_SFF_8472_COMP),
+					&sff8472_rev);
 	if (status)
 		return -EIO;
 
 	/* addressing mode is not supported */
-	status = igb_read_phy_reg_i2c(hw, IGB_SFF_8472_SWAP, &addr_mode);
+	status = igb_read_sfp_data_byte(hw,
+					E1000_I2CCMD_SFP_DATA_ADDR(IGB_SFF_8472_SWAP),
+					&addr_mode);
 	if (status)
 		return -EIO;
 
 	/* addressing mode is not supported */
-	if ((addr_mode & 0xFF) & IGB_SFF_ADDRESSING_MODE) {
+	if (addr_mode & IGB_SFF_ADDRESSING_MODE) {
 		hw_dbg("Address change required to access page 0xA2, but not supported. Please report the module type to the driver maintainers.\n");
 		page_swap = true;
 	}
 
-	if ((sff8472_rev & 0xFF) == IGB_SFF_8472_UNSUP || page_swap) {
+	if (sff8472_rev == IGB_SFF_8472_UNSUP || page_swap) {
 		/* We have an SFP, but it does not support SFF-8472 */
 		modinfo->type = ETH_MODULE_SFF_8079;
 		modinfo->eeprom_len = ETH_MODULE_SFF_8079_LEN;
@@ -3251,37 +3255,17 @@ static int igb_get_module_eeprom(struct net_device *netdev,
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 	u32 status = 0;
-	u16 *dataword;
-	u16 first_word, last_word;
 	int i = 0;
 
 	if (ee->len == 0)
 		return -EINVAL;
 
-	first_word = ee->offset >> 1;
-	last_word = (ee->offset + ee->len - 1) >> 1;
-
-	dataword = kmalloc_array(last_word - first_word + 1, sizeof(u16),
-				 GFP_KERNEL);
-	if (!dataword)
-		return -ENOMEM;
-
-	/* Read EEPROM block, SFF-8079/SFF-8472, word at a time */
-	for (i = 0; i < last_word - first_word + 1; i++) {
-		status = igb_read_phy_reg_i2c(hw, (first_word + i) * 2,
-					      &dataword[i]);
-		if (status) {
-			/* Error occurred while reading module */
-			kfree(dataword);
+	for (i = 0; i < ee->len; i++) {
+		status = igb_read_sfp_data_byte(hw, ee->offset + i, &data[i]);
+		if (status)
 			return -EIO;
-		}
-
-		be16_to_cpus(&dataword[i]);
 	}
 
-	memcpy(data, (u8 *)dataword + (ee->offset & 1), ee->len);
-	kfree(dataword);
-
 	return 0;
 }
 
-- 
2.43.0

