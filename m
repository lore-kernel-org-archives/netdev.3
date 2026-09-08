Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C106583ADE
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883044; cv=none; b=c5PtlEv75UsHvAc/ki4u9DvM1IcDSX0llfF8i3On0oQ0GgWrAjV9yEH2sZIbrC+d8MywTOrUatFVgAmpGYZtFwKU7kotp/7oFTOYZKtXmKuA4fBOYfGJZmjBpPCv7AMGOY+e0tIVJNtRvEBqGvSfjVCTxAmn39arHG0fxYJVva8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883044; c=relaxed/simple;
	bh=R+trTOYlMixGurkSaokPqFVhZzEOyMehQzqZ+3h2vsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HU3rUfUdPN2O1bDgHsfHvmbbYgIoiKZ2eiek1RhPubqylvke+rZTM12MwdEC6ov7pkZVBI6SCnEzyKjGISlD1FXiG1n1iYHTjaJX5nhpTJaq/YiFnc5abjpgYgQaFgqnHwR1TWPRCp1BXujj/1PdGzMLYDk8F224FUaIj/LnFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=c0LVPc0d; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="c0LVPc0d"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49557167508so57112725e9.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788883038; x=1789487838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R61YL4bM9jY5pVzf4nxgHgxN6hURjg68AYKuV/uyHLo=;
        b=c0LVPc0dfNv6tKSwPGwQ7qtKI4ML2uEf1r5Z+cQawlNp85IHjIH8nWEYz1QTeJrnr+
         UnSJW+fUGu3Cj4xinumaJVEm28zDIKoVY6JkCjOJQQlxDldLeWDKGZaEGrEwlc45jCA4
         7WIunzhZUV+ejqUDH2ST/LRG+yQj8PJuwaF+eCYS37T44mrEK0o3UUZlbtESlVptc1Ex
         st5cqb3gWK1kAVK39/Jx0LpJI4OqA4hgV+pWrEFbKDkDIcFlVCwMW+fLjR9sf9c+w52U
         IcLRj/9HKmKERvxVX81bW0RX6eSAeeD2K4e0FJQGlmeKlWYl/UFehn+afEgEf+k5L4m4
         JnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883038; x=1789487838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R61YL4bM9jY5pVzf4nxgHgxN6hURjg68AYKuV/uyHLo=;
        b=gWRqb5KSXDUfxlxWPkl/nJQT4HzdzjE0bEz9SFkEpzd8TCU5UCMtjCZR1clkNtXos8
         LZaYdsSELMjm4xqDCB3+FB+KG2fPnHhT8ex6xb5L2nFXyCuL7/tRBJXazEXJkGGabqhn
         yOoS9ir1MlSByjfbeh0Vy2SnfPLpZhmRXTVXUA5l6O+8eV67KxY2O5BP8pd/pf4c8m53
         KHBETSfIXKVm5vSJ71w14PdSIcmfTWH9GFVErO8jM8YPRGP3eiUah/vKZp/Pa+pvuh06
         bkpGRwovhTa1ak3vjoiYhFr4e1nczTZvhJKAFknVRFt1LVWuLeO1odqDaXZg60m45dGU
         mKgA==
X-Forwarded-Encrypted: i=1; AKwUvBwIKU8tvftTb52KUH5yQ2mBVksDGaTJ7lYgMm0BuuzoIP4CBoayXtvmd7j7GE7jVpQDBUq1TuE=@vger.kernel.org
X-Gm-Message-State: AFuF++mL/NANR8TtnpBOlLoT8sKqXw+MhnjC3YJsV3e+k4J+O+q7IAUP
	9hCm+nqDfIAFOIpbHRavWqc3OpP6UByI+w50Qt8iwPG5kZ0r4dBETK3B6JMKovtUZfc=
X-Gm-Gg: AYBFou01ztLbhbF5SamHHDdcIjAmtRO4PKz3PJ4OgUcg/evWSTmjASl9r101pRXiLHJ
	C8lFdBz6wEGcH2Twc+yspF6pIEuy7VWBRCSAMElU5W90sp+NI7/HTGNUFggvcxy7UpXJU0kUOGD
	smo6Ytg4G2LgvfGuXEmQXYyHxbTX6QcxJ3YIbBppfs2QF+8nPxY6k8a6Er04okvrds+O6SOIw1/
	G7Evk0qK1q7MP9LXOt+/qlrj0QC1dVDXx6qOvAW3RfaJAXtunLRhpW20Y62IAFSX1d88uHGeAjF
	lieIIvxw6myKKN9qHO6jn9EloTikyjusPPFqst6ZKYnvm+/eun/TgVF4pnTHp8Qv8SNfiGgPh0a
	WDKnx6Jbh5LOKzjkPjHIB/M8p4d+kvBZBr14k+PCncUCuvc9tMEkWsr3W5FzbQOV9f8YjDOzPq3
	35JOehBok2Eq1CCfmJ2w4jJFM6VYdFd4HenTND/gpqJ3cwh6UizQ==
X-Received: by 2002:a05:600c:8715:b0:49d:17d4:aff2 with SMTP id 5b1f17b1804b1-49d17d4b01dmr147455505e9.1.1788883037684;
        Tue, 08 Sep 2026 08:57:17 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be709sm37345704f8f.21.2026.09.08.08.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:57:17 -0700 (PDT)
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
Subject: [RFC PATCH net-next v2 5/7] net: phy: air: skip the download when the MD32 is already running
Date: Tue,  8 Sep 2026 15:57:05 +0000
Message-ID: <20260908155707.4164559-6-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908155707.4164559-1-f@lex.la>
References: <20260908155707.4164559-1-f@lex.la>
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
 drivers/net/phy/air_phy_lib.c | 26 ++++++++++++++++++++++++++
 drivers/net/phy/air_phy_lib.h |  3 +++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 6822774d9ae3..d1c7c472f0e9 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -1024,8 +1024,8 @@ static int en8811h_probe(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	/* mcu has just restarted after firmware load */
-	priv->mcu_needs_restart = false;
+	/* Adopted firmware was never restarted here. */
+	priv->mcu_needs_restart = (ret == 1);
 
 	/* MDIO_DEVS1/2 empty, so set mmds_present bits here */
 	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
diff --git a/drivers/net/phy/air_phy_lib.c b/drivers/net/phy/air_phy_lib.c
index 5b7427e0d977..a5b6b3606bec 100644
--- a/drivers/net/phy/air_phy_lib.c
+++ b/drivers/net/phy/air_phy_lib.c
@@ -410,6 +410,17 @@ static int air_mmd_status_read(struct mdio_device *mdiodev)
 	return ret;
 }
 
+int air_en8811h_mcu_running(struct mdio_device *mdiodev)
+{
+	int ret = air_mmd_status_read(mdiodev);
+
+	if (ret < 0)
+		return ret;
+
+	return ret == EN8811H_PHY_READY;
+}
+EXPORT_SYMBOL_GPL(air_en8811h_mcu_running);
+
 int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev)
 {
 	int ret, reg_value;
@@ -443,6 +454,21 @@ int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version)
 	struct device *dev = &mdiodev->dev;
 	int ret;
 
+	ret = air_en8811h_mcu_running(mdiodev);
+	if (ret < 0)
+		return ret;
+
+	if (ret) {
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
index 70c8ba66bd73..226dc9f2eb07 100644
--- a/drivers/net/phy/air_phy_lib.h
+++ b/drivers/net/phy/air_phy_lib.h
@@ -64,7 +64,10 @@ struct firmware;
 
 int air_fw_write_buf(struct mdio_device *mdiodev, u32 address,
 		     const struct firmware *fw);
+/* Returns 1 running, 0 dormant, negative on a failed status read. */
+int air_en8811h_mcu_running(struct mdio_device *mdiodev);
 int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev);
+/* Returns 1 when it adopted firmware that was already running. */
 int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version);
 
 #endif /* __AIR_PHY_LIB_H */
-- 
2.53.0

