Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56F47DD66
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218285; cv=none; b=PwibEwrtDEhAcQc8itbJk76A3BZ0wB9f9l7M1vb3NL0rWhV1Jo82AXhyW4pJ8KwhZNZKcb8TPolgmKDgYh5UiEYkuQbUkuBBdtryhYE5m5sBgxiXmvPLIGiUVh2Q7N8hgT69Gf3IrfgdkqDoI7vJPLCt6BT7E5tpNcMZ8Vz/54w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218285; c=relaxed/simple;
	bh=mzH/5XaUhv6NQCYgufBy5oWC9jpITM+/znfPg5sAlv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phFy/Pk/DXuWfreAxeRgzYgKSggKOmfEV792Nzhv0OkPrFVn54926kfbMNembZ/38UHPIhvorDOCYNmnuvkLebEXiSjkua6ip/v9SL/DBiah9L5X5bGM1AER+SSMQi73jU8yz9Ykd3w5ekFvBaSqDkgdrScznCAQ7UoNnEXwVq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=NBliq2ix; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="NBliq2ix"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b965570d7so23079545e9.0
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 06:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789218279; x=1789823079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YfiP06w66PJnEqo2UKKQtS6GK/rrfhVqIhL6B6Ho9XA=;
        b=NBliq2ixrN3Ov7S5s54bPA15I9ggBI9nUKZCinbE7ysbkYMtvr6nScr6lTjsGun9dC
         LIJ46fT52goShsnzgDnZ2sF3EMlm0LuG5FFFZh40ZfkL0bUQ6+uaGfrr0LJT1eov1Xwq
         qGPV3xTlP5VMzMhhD/mGENdGUdBjNPhG5n6zOwNJ65C1xkRGocFMTpSnBE5BYgl7WxdV
         Cb5pXuK7GuQSCfilsJmuPJIMrllpAdraQ9r2nJLACdswUDC6U0jclASzQvKV6yjQh1Z9
         shSWwo2MzUKtz8vZ6Li/kefY+phZBRTQUUnxlcyAy+LbXclCXZMRtXDoHopxAh1MDz9p
         d88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789218279; x=1789823079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YfiP06w66PJnEqo2UKKQtS6GK/rrfhVqIhL6B6Ho9XA=;
        b=m4ftn5G+DkKNc7WAz7A08wrj4P4yxlX1NzUKQK6IIKXYuJZFwSSLwbM6kLUTUZDCPw
         1NqE5scp2euJmIOeiWhtP3HP8mR4oaXTMS1sgmmftNemh/QBj8LGrYjgJAmJDURav3Jy
         2aTOtuZJnV6pgZZjZtHTM3gOtfThlhf7tpAFOPWOcKp1eXj3MUf4rjkjDOau4OYGI03R
         DPwgDZBSkQ8qLBRCq/DhuftUdiNgHiayResduSQ4GQIuA7AtynTFgrlkqBbEwIBjGjo4
         NrrtF5YEkh4sG/rMhBU9AKg+QWydRi3HDfbevpZJbxaG6kONq8MCQXsrVtEPc75evPL8
         012A==
X-Forwarded-Encrypted: i=1; AKwUvBx3UW/gBBSwiLcnvwQhDcqTJI1ukLIFmyU9QDKr11xl51c6dWr3m7LfsDAZVCM9QhzuHqI9hPk=@vger.kernel.org
X-Gm-Message-State: AFuF++kJRvrfNfR6J5FlAKOl8cjgM5KAhSRD5J/U4rajCbPRYVhTFnag
	562rlgULzQJdYLUnN0+lk158Mk7ZWG0QaUBZUfFngH+ds+eIBrHMdvGHq4awj0FSrx8=
X-Gm-Gg: AYBFou1j01rhDCxY07xePdz7yGUgfgQvN6id0u00RPSWMzwDGeNbRL5cCjuDLsRlnLI
	rqChrgSi/70OuQJJNLJfQzww5x43abLHuMgeoC0o9Y41+TxDuJ42j5eVHtXs7Oq1HOhqBHu3wBQ
	POj7LsbpjDUw/uhsrTqalddaGltRUIMEXoRrh2yU3lVp33qXZMF8XiXzSsHBUAPvGCK+EexIwzX
	Oj6c8Mf9NT70aHudH4758ntbJt2OHpe/7IQ1PZpapn4JOKy0/PN3R8rWytl4MMgyHN85bSZSqhS
	xCbonrdQDn5whQOR1fhRuX9I2AP9ZjFYIvVXuTlnQcuQCbIxhM5EBm5T9TQ4LRQcxevfHPkGag0
	x1HwXijf7DgotpD7Y4QvRx1F0y8KZb6RULe66vXFDzVmswM4sH47sxh5ebzC+ps+tsHjwqFI+PG
	BmPU/vRJqPBI3a/y2MHbw53jeODej4AdrQt9lnBuc70Jb0VvOawg==
X-Received: by 2002:a05:600c:a07:b0:49c:fc6e:8cb1 with SMTP id 5b1f17b1804b1-49e619bbcefmr96203785e9.21.1789218279377;
        Sat, 12 Sep 2026 06:04:39 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6a06cfb8sm80985785e9.5.2026.09.12.06.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:04:39 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: ericwouds@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [RFC PATCH net-next v3 2/6] net: phy: air: type the buckpbus core on the mdio device
Date: Sat, 12 Sep 2026 16:04:26 +0300
Message-ID: <20260912130430.2246285-3-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912130430.2246285-1-f@lex.la>
References: <20260912130430.2246285-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The buckpbus accessors only need an MDIO device, but they take a
phy_device, which ties them to a probed PHY. An upcoming MDIO device
driver needs the same register access before any phy_device exists,
since it runs precisely to make the PHY presentable.

Retype the internal helpers onto an mdio_device and keep the exported
phy_device API as page-selecting wrappers that pass &phydev->mdio. The
EN8811H driver already reaches the AN8811HB pbus through an
mdio_device, so this follows an existing direction rather than opening
a new one.

No functional change.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/phy/air_phy_lib.c | 80 ++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/net/phy/air_phy_lib.c b/drivers/net/phy/air_phy_lib.c
index 5141db19fa5e..e314717843ae 100644
--- a/drivers/net/phy/air_phy_lib.c
+++ b/drivers/net/phy/air_phy_lib.c
@@ -14,31 +14,32 @@
 
 #include "air_phy_lib.h"
 
-static int __air_buckpbus_reg_read(struct phy_device *phydev,
+static int __air_buckpbus_reg_read(struct mdio_device *mdiodev,
 				   u32 pbus_address, u32 *pbus_data)
 {
 	int pbus_data_low, pbus_data_high;
 	int ret;
 
-	ret = __phy_write(phydev, AIR_BPBUS_MODE, AIR_BPBUS_MODE_ADDR_FIXED);
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_MODE,
+			      AIR_BPBUS_MODE_ADDR_FIXED);
 	if (ret < 0)
 		return ret;
 
-	ret = __phy_write(phydev, AIR_BPBUS_RD_ADDR_HIGH,
-			  upper_16_bits(pbus_address));
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_RD_ADDR_HIGH,
+			      upper_16_bits(pbus_address));
 	if (ret < 0)
 		return ret;
 
-	ret = __phy_write(phydev, AIR_BPBUS_RD_ADDR_LOW,
-			  lower_16_bits(pbus_address));
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_RD_ADDR_LOW,
+			      lower_16_bits(pbus_address));
 	if (ret < 0)
 		return ret;
 
-	pbus_data_high = __phy_read(phydev, AIR_BPBUS_RD_DATA_HIGH);
+	pbus_data_high = __mdiodev_read(mdiodev, AIR_BPBUS_RD_DATA_HIGH);
 	if (pbus_data_high < 0)
 		return pbus_data_high;
 
-	pbus_data_low = __phy_read(phydev, AIR_BPBUS_RD_DATA_LOW);
+	pbus_data_low = __mdiodev_read(mdiodev, AIR_BPBUS_RD_DATA_LOW);
 	if (pbus_data_low < 0)
 		return pbus_data_low;
 
@@ -46,64 +47,66 @@ static int __air_buckpbus_reg_read(struct phy_device *phydev,
 	return 0;
 }
 
-static int __air_buckpbus_reg_write(struct phy_device *phydev,
+static int __air_buckpbus_reg_write(struct mdio_device *mdiodev,
 				    u32 pbus_address, u32 pbus_data)
 {
 	int ret;
 
-	ret = __phy_write(phydev, AIR_BPBUS_MODE, AIR_BPBUS_MODE_ADDR_FIXED);
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_MODE,
+			      AIR_BPBUS_MODE_ADDR_FIXED);
 	if (ret < 0)
 		return ret;
 
-	ret = __phy_write(phydev, AIR_BPBUS_WR_ADDR_HIGH,
-			  upper_16_bits(pbus_address));
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_WR_ADDR_HIGH,
+			      upper_16_bits(pbus_address));
 	if (ret < 0)
 		return ret;
 
-	ret = __phy_write(phydev, AIR_BPBUS_WR_ADDR_LOW,
-			  lower_16_bits(pbus_address));
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_WR_ADDR_LOW,
+			      lower_16_bits(pbus_address));
 	if (ret < 0)
 		return ret;
 
-	ret = __phy_write(phydev, AIR_BPBUS_WR_DATA_HIGH,
-			  upper_16_bits(pbus_data));
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_WR_DATA_HIGH,
+			      upper_16_bits(pbus_data));
 	if (ret < 0)
 		return ret;
 
-	ret = __phy_write(phydev, AIR_BPBUS_WR_DATA_LOW,
-			  lower_16_bits(pbus_data));
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_WR_DATA_LOW,
+			      lower_16_bits(pbus_data));
 	if (ret < 0)
 		return ret;
 
 	return 0;
 }
 
-static int __air_buckpbus_reg_modify(struct phy_device *phydev,
+static int __air_buckpbus_reg_modify(struct mdio_device *mdiodev,
 				     u32 pbus_address, u32 mask, u32 set)
 {
 	int pbus_data_low, pbus_data_high;
 	u32 pbus_data_old, pbus_data_new;
 	int ret;
 
-	ret = __phy_write(phydev, AIR_BPBUS_MODE, AIR_BPBUS_MODE_ADDR_FIXED);
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_MODE,
+			      AIR_BPBUS_MODE_ADDR_FIXED);
 	if (ret < 0)
 		return ret;
 
-	ret = __phy_write(phydev, AIR_BPBUS_RD_ADDR_HIGH,
-			  upper_16_bits(pbus_address));
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_RD_ADDR_HIGH,
+			      upper_16_bits(pbus_address));
 	if (ret < 0)
 		return ret;
 
-	ret = __phy_write(phydev, AIR_BPBUS_RD_ADDR_LOW,
-			  lower_16_bits(pbus_address));
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_RD_ADDR_LOW,
+			      lower_16_bits(pbus_address));
 	if (ret < 0)
 		return ret;
 
-	pbus_data_high = __phy_read(phydev, AIR_BPBUS_RD_DATA_HIGH);
+	pbus_data_high = __mdiodev_read(mdiodev, AIR_BPBUS_RD_DATA_HIGH);
 	if (pbus_data_high < 0)
 		return pbus_data_high;
 
-	pbus_data_low = __phy_read(phydev, AIR_BPBUS_RD_DATA_LOW);
+	pbus_data_low = __mdiodev_read(mdiodev, AIR_BPBUS_RD_DATA_LOW);
 	if (pbus_data_low < 0)
 		return pbus_data_low;
 
@@ -112,23 +115,23 @@ static int __air_buckpbus_reg_modify(struct phy_device *phydev,
 	if (pbus_data_new == pbus_data_old)
 		return 0;
 
-	ret = __phy_write(phydev, AIR_BPBUS_WR_ADDR_HIGH,
-			  upper_16_bits(pbus_address));
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_WR_ADDR_HIGH,
+			      upper_16_bits(pbus_address));
 	if (ret < 0)
 		return ret;
 
-	ret = __phy_write(phydev, AIR_BPBUS_WR_ADDR_LOW,
-			  lower_16_bits(pbus_address));
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_WR_ADDR_LOW,
+			      lower_16_bits(pbus_address));
 	if (ret < 0)
 		return ret;
 
-	ret = __phy_write(phydev, AIR_BPBUS_WR_DATA_HIGH,
-			  upper_16_bits(pbus_data_new));
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_WR_DATA_HIGH,
+			      upper_16_bits(pbus_data_new));
 	if (ret < 0)
 		return ret;
 
-	ret = __phy_write(phydev, AIR_BPBUS_WR_DATA_LOW,
-			  lower_16_bits(pbus_data_new));
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_WR_DATA_LOW,
+			      lower_16_bits(pbus_data_new));
 	if (ret < 0)
 		return ret;
 
@@ -144,7 +147,8 @@ int air_phy_buckpbus_reg_read(struct phy_device *phydev, u32 pbus_address,
 	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
 
 	if (saved_page >= 0) {
-		ret = __air_buckpbus_reg_read(phydev, pbus_address, pbus_data);
+		ret = __air_buckpbus_reg_read(&phydev->mdio, pbus_address,
+					      pbus_data);
 		if (ret < 0)
 			phydev_err(phydev, "%s 0x%08x failed: %d\n", __func__,
 				   pbus_address, ret);
@@ -163,7 +167,7 @@ int air_phy_buckpbus_reg_write(struct phy_device *phydev, u32 pbus_address,
 	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
 
 	if (saved_page >= 0) {
-		ret = __air_buckpbus_reg_write(phydev, pbus_address,
+		ret = __air_buckpbus_reg_write(&phydev->mdio, pbus_address,
 					       pbus_data);
 		if (ret < 0)
 			phydev_err(phydev, "%s 0x%08x failed: %d\n", __func__,
@@ -183,8 +187,8 @@ int air_phy_buckpbus_reg_modify(struct phy_device *phydev, u32 pbus_address,
 	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
 
 	if (saved_page >= 0) {
-		ret = __air_buckpbus_reg_modify(phydev, pbus_address, mask,
-						set);
+		ret = __air_buckpbus_reg_modify(&phydev->mdio, pbus_address,
+						mask, set);
 		if (ret < 0)
 			phydev_err(phydev, "%s 0x%08x failed: %d\n", __func__,
 				   pbus_address, ret);
-- 
2.53.0

