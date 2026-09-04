Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B2A42376F
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548605; cv=none; b=s4AtmvsJPE7CXvJq7Qfcpl+uYRNKl0VrKIc7io/7hTOO2y0/9HUS2dfDGrvb0cCrcITj15ei4BEYx8Iwkzb668IZ/NHS2qmTSAoN/oVw4r9ZkAWb9P8OBKwbCBg7PhyNcMkv0BD+yqKq3jMtkPQQNHxxt6VBOmHLZjX05i6uO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548605; c=relaxed/simple;
	bh=tvwBi/oKJVRvzD1Ea9uSmVR/d+BAWrIijfyOV4a7Zv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6xtl5+50X2bYS73VJRo/KE1H8nJ/y1XMmkb/OdZdxrbHZTPFwtL+Zj5Tptn/gIv+nLqd2GAyWqLMS43Gy6kfV0Q6PNQGtUJx2gl9O22ELjUqaPN58FPcG1vLNawIXImqKL+D3OvUZMtoWK9vDYTyKHuTs6CfcD/vkXB5gqSOwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=IwvbzE9r; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="IwvbzE9r"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49cf4f81d86so10617815e9.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 12:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788548595; x=1789153395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=spwFfBNp0tsbFO0MbVx5HsS6oEJ6iTQA15tu/YnOvzo=;
        b=IwvbzE9rh4h+G5V7of0i08GFEZX9/r3kyfdE0hnv8/Ren4+JE0V9ThGqh8mUTMEvxH
         75FDQOWkY2n9jz1RPk56SHbWiE9xNy4wLfbwO9GhOoTuAiTWSpwJigb0gn1GlWUHuhH2
         YB2CQXxyQPaoDCfkR5EbPD/ZSQsg7mG6BGMsxd/HvmCf6HudZudAidtL4gATW7E/Y5Yg
         P5RYd83dmqs6HIzRgRGja3mIXO2tl5xqTFUJGfN5yFH+SndgvgQoELYg7nup4Sd4jThC
         Z9iYepDQzTso+ltf+FRn1sgnT0fbWHkiczi4c64So+Tsfpzbg/V6YjQD8Z1C24DRcRn1
         oQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788548595; x=1789153395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=spwFfBNp0tsbFO0MbVx5HsS6oEJ6iTQA15tu/YnOvzo=;
        b=gCZVR7QRelcHyF/9wzWlw/fgA6sNG77R6HG7IfMkLcgg5iKgh6N2UVtCNxhOHAW7rC
         kNphgDeTts/vZsQwi5/kcrEJZB3I2dHzPfsrQP1G2jQhX400hUdbI7tUppCuXX8rcMsD
         KmUgkFLTIs74NtRB69EYPmLM0FScspvrtv57FjThoPC2+/gtPkIJBSU7KLGAnI5lYLLs
         UlqlUH1rGRnzlJW+YFOG+O5Z/MH6x5Su9UeZhmfpi5V2+xPAZXHVrm5zwyTJhEwC1MCn
         9lcdt7qtMSFlU6smOmZSR27KH/KxVQBjemaZHR36cKF1wlpBfawzxDqYJah64yBB6g0u
         jgqA==
X-Forwarded-Encrypted: i=1; AKwUvBxzLhWCfn0wb4E2oz/zsrNCgXg2IAPLIZxr3S1seOQbEXqiKjeJ+qnn8SO27CH76/vXkwHVkq4=@vger.kernel.org
X-Gm-Message-State: AFuF++k4TCsg1X7et6xyP2D0meV4ftQGdr45vMJXMG0jCYw+kMrALBKG
	wHvTy9DNlP2pBEWAT3VuGCjbCW0vnQyxO5mcDohbAcJeKAlOxxzuZPlwVe4UTlNiwGQ=
X-Gm-Gg: AYBFou2/msHvkRqedHQ/u8wpcxQT2IKGMr5CC0CH/m0aynr5IrwIMjcilg12jHVk+eA
	OWo+wrXY+lf5X/dyaNuOojGKzh/+wvZDyIna5fwz2kYHcgh247O8KrL+/Q3vJcaeP7OmZRc7Lt+
	3VudxJSGZowJnHKvIrPIeu93z4j6dYgrhXx7ADaYwkUagdKZnzwbl72O7p3tYESFfoJdBF+IHC8
	JiHxix213LdtDok+fDJ6v0Jo/+S2Ht28XLtr4pd1ixlyUDW16cSX6TmWc8NPCBKBfEiw6Zx3a8g
	n9ycQA2r1zwrPdy6cqFYtRz9l9Q7IGNXKPYPg5Hon51DKYBNxDztOCymWcObn47wrP3D0Wi3pli
	cxo7qCQydO1c149vu75vo+tm0KiGIa5xsUKk+4QYJ8/k1oawZIawqKitVdche/sBRmcQk1oCKG8
	9nHfbM4lAPVuxf6uPN2JgvmE/9RS4lMw5fhbFCNX+jxArE6BW7ntU=
X-Received: by 2002:a05:600c:35c3:b0:49c:fc6c:be10 with SMTP id 5b1f17b1804b1-49cfc6cc055mr52700515e9.22.1788548594795;
        Fri, 04 Sep 2026 12:03:14 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d8a6sm172195485e9.10.2026.09.04.12.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:03:14 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next v2 06/10] net: phy: air: skip the download when the MD32 is already running
Date: Fri,  4 Sep 2026 19:03:00 +0000
Message-ID: <0eb669e919da337cbc456b7aecd06e6d9509ad17.1788548229.git.f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788548229.git.f@lex.la>
References: <cover.1788548229.git.f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The download is unconditional, so a chip whose firmware was loaded by
something else - a bootloader, an earlier bind of the PHY driver, or
an MDIO device serving the chip - is reprogrammed at 144KB per probe.

Read the status register the loader already polls for readiness and
skip the download when it reports ready, only picking up the running
firmware's version. Adopting is reported back distinctly from loading,
because nothing on that path touches FW_CTRL_1: the PHY driver must
leave the MCU restart to .config_init() rather than assume probe
already did it.

The image in RAM now wins over the files on disk. Where the PHY node
carries no reset-gpios nothing clears that RAM on unbind, so writing
new firmware files and rebinding keeps the old image running and
reports its version as the current one. A power cycle, or a reset line
on the PHY node for phy_detach() to assert, brings the reload back.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/phy/air_en8811h.c |  4 ++--
 drivers/net/phy/air_phy_lib.c | 17 +++++++++++++++++
 drivers/net/phy/air_phy_lib.h |  2 ++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 2f6ed30ba24d..51ff90e60c25 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -1019,8 +1019,8 @@ static int en8811h_probe(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	/* mcu has just restarted after firmware load */
-	priv->mcu_needs_restart = false;
+	/* Adopted firmware was never restarted here. */
+	priv->mcu_needs_restart = (ret == 1);
 
 	/* MDIO_DEVS1/2 empty, so set mmds_present bits here */
 	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
diff --git a/drivers/net/phy/air_phy_lib.c b/drivers/net/phy/air_phy_lib.c
index 2f3e5b71abac..fc596942eb65 100644
--- a/drivers/net/phy/air_phy_lib.c
+++ b/drivers/net/phy/air_phy_lib.c
@@ -368,6 +368,12 @@ static int air_mmd_status_read(struct mdio_device *mdiodev)
 	return ret;
 }
 
+bool air_en8811h_mcu_running(struct mdio_device *mdiodev)
+{
+	return air_mmd_status_read(mdiodev) == EN8811H_PHY_READY;
+}
+EXPORT_SYMBOL_GPL(air_en8811h_mcu_running);
+
 int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev)
 {
 	int ret, reg_value;
@@ -402,6 +408,17 @@ int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version)
 	struct device *dev = &mdiodev->dev;
 	int ret;
 
+	if (air_en8811h_mcu_running(mdiodev)) {
+		ret = air_mdio_buckpbus_reg_read(mdiodev, EN8811H_FW_VERSION,
+						 fw_version);
+		if (ret < 0)
+			return ret;
+
+		dev_info(dev, "MD32 already running, firmware %08x\n",
+			 *fw_version);
+		return 1;
+	}
+
 	ret = request_firmware_direct(&fw1, EN8811H_MD32_DM, dev);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/phy/air_phy_lib.h b/drivers/net/phy/air_phy_lib.h
index 2a4c156d6396..6823812c8fd5 100644
--- a/drivers/net/phy/air_phy_lib.h
+++ b/drivers/net/phy/air_phy_lib.h
@@ -59,7 +59,9 @@ struct firmware;
 
 int air_fw_write_buf(struct mdio_device *mdiodev, u32 address,
 		     const struct firmware *fw);
+bool air_en8811h_mcu_running(struct mdio_device *mdiodev);
 int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev);
+/* Returns 1 when it adopted firmware that was already running. */
 int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version);
 
 #endif /* __AIR_PHY_LIB_H */
-- 
2.53.0

