Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6232D2D7D3A
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792260183; cv=none; b=UP/RyWS/msk1hsR4M8jcRGMRJ2gCY1hvLhSDCUH7LLchUyrpnTuO5A7dyhxQGGjZZTiK/UCIdafMHQB39AgbKm0laDYdgNoYeB3lEY4eafDxQ/4DZBdy9xoH0OzRjRL3HQf/Hxaco+R/zLJM6GjRHBYfdOWlXjER8ueXwnrvftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792260183; c=relaxed/simple;
	bh=fyhQNcY+O5G7vl1NEGv7JxiXP00rXza799Ipl+fms1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UgXfjO3PvE9oya5mm2cT9xO5VXI3nuvY3wvPoyqoUs4fefIjPZ4+X0bT/tagV2XnuGRnEWX+CZ/u1rkGN6pMqi0byCuDzGusZNqW69gCzEnUEdntZuzcFKrrmzHi2DSLvBfCnHnjzAnYu2gwte63iu7l90CyEynIyM7CIA3Eck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=SeG8D7GI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="SeG8D7GI"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so6607045e9.2
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 11:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1792260178; x=1792864978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rcAJPEIniOgY+Qw2nx+rUdjJyX0yTJI9L3h+ey6Xf+I=;
        b=SeG8D7GI3+6Jz5c5RrmJ55RYi//ggM210y37PnV2P/6gV5EWOnNGYjrSkmgA2ZRG9q
         SbaOZGTsm2UG/nc+fpIR6QKvsABeWzqp2x1N0A4msVB7aJoWCXxh8XDveGxBFW4DZ0CU
         bPMpgSbWXGdad62OF0qZePmzqgYUpKr2nnmr5eCizkSe2DfQpcn6PvkAW/z5H2a4eAsp
         Tg3D9Scp57BztAKDkffsFFVhjZKF2+7u/77tQ4WjWBrrgDrmiHVK+CEjX+6KuXsjCkFu
         Ee38bs5VEg61ZBkKUB99HwhQNv5ooPriDcySh78iOcR8qKVCj9pGmlX/TZzvDsXsm2wB
         WKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792260178; x=1792864978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rcAJPEIniOgY+Qw2nx+rUdjJyX0yTJI9L3h+ey6Xf+I=;
        b=okUo8DpLFGDWnqBaGXrkrWsoGOaYDLd86h0HSy1cj2k1ZeQMQgao60J4S5hQn3kMQf
         HOw0MPkVh8J3btN4jSwzBVt15u/uzY1kP5sDgOKzhYVSj5dMUnEDvjYX0bm6dy7uxra3
         UNDTW3qshEwUEDA5A8QOUxpL8GTEXnDTm+2tjitbzFGE6LBQRTNgbAEw8gcE/PRDdq+k
         2eukUXwZWDdekG1dO90tP8dlgCjVT+o+PgY1046LnfAq0Tl8fug77bUyjqAy8fOwDUwT
         0nEzgl/OKreMe3eOAEQAVEOkBVa9CjVcKegQOY9egp8ZXH0VwDGEMA7UlqxwojkHdGb/
         w2Hw==
X-Forwarded-Encrypted: i=1; AKwUvBxkGFUhLTmkJ/iNoyu8Gxng4W/3RGeH4OYVgBsYQW1CS/29mSTI2Gp4kE5hckAh8oIvk4Ym70M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGMHkSa4ohXX9A62syapk1H3M8o+7faJ4wviM5BEhazE8/zCoF
	7CXJk760obgeHklKOrsTrxGixNfvG9HBLIZPouePoYNdQ7yJXQIOi156LFwIhWC0pXY=
X-Gm-Gg: AYBFou2gWUVbtQBywghLx5GURmQNfu8dLW4UtVCendqW8rdWLheJFW5I1wkna3fMRnn
	gho2vkEMeZ52/5dNAZApKER3ki1KBzBV64zCVUXI95K1J0mSqCAmtyfrRsebpQMwnGps7qQVi9X
	A8AMa8g6X5LO4SoJojnyxqf88nezWYiuZScr/jM+ZywWAuCbo6TwXraID+ayAS3MakDT7Ep6DbL
	4A9K84kwRzS0eECNOhsb67sb3XUd9L2iVu0kR4krV3eAd+o6x+3xwsMs+wx7M+pSnH8LU+mQit3
	JSEKYZrVLhpNJ4iJxwI3WfQ1cxycK23waUn1sUPHHUlj/rZYyWneyp9dnJpuY2WZz+CU+tG8nIV
	potF4vnJtyaiBnpjCfKqo5+rFBIMwXNnq9U3MZICh8Vi4N1YnhRidXQ3Wqe/m/M9Drb7iVJW+t2
	JLndxvkRal/B3Ow7Y8Klel7B/wmtH5wp1Zfq9RsFHrWaNcLzbsnA==
X-Received: by 2002:a05:600c:4f92:b0:4a0:1b21:2628 with SMTP id 5b1f17b1804b1-4a1d76120c4mr71119715e9.23.1792260178181;
        Sat, 17 Oct 2026 11:02:58 -0700 (PDT)
Received: from remote-01 ([84.17.55.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8a56233sm121884115e9.0.2026.10.17.11.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 11:02:57 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: air_en8811h: use firmware loaded by the bootloader
Date: Sat, 17 Oct 2026 21:02:51 +0300
Message-ID: <20261017180251.3618606-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a Keenetic KN-1012 (MT7981) the EN8811H sits behind a port of an
MT7531 switch. The driver has to be built in there: as a module it loads
after DSA has validated the port against the generic PHY driver and
failed to set it up. Built in, it probes when the Ethernet MDIO bus is
registered, before the root filesystem is mounted, so
request_firmware_direct() fails with -ENOENT, the PHY stays without a
driver and the port never comes up, although the bootloader has already
loaded and started the MD32 firmware.

When the firmware files cannot be read and the MCU reports ready, keep
the running firmware and let the first .config_init() restart it, so the
PHY starts from a freshly started MCU as after a download rather than
from whatever state the bootloader left. Nothing changes when the files
are there. A board that relies on this must not give phylib a
reset-gpios line, as the pulse at registration stops the MCU. The
AN8811HB path is unchanged.

Tested on the KN-1012: with the bootloader load the PHY binds and links;
without it 0x8009 reads 0x0 and the probe fails as before; a rebind with
the files present downloads them as before.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
This replaces "net: phylink: wait for a PHY that probes after the MAC"
https://lore.kernel.org/netdev/20261006124731.1528963-1-f@lex.la/
following Andrew's suggestion in
https://lore.kernel.org/netdev/b175c750-104a-4859-a137-09de78a6d8bb@lunn.ch/

 drivers/net/phy/air_en8811h.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index a03d63dd4ac9..efe4e64d213a 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -518,6 +518,17 @@ static int an8811hb_load_firmware(struct phy_device *phydev)
 	return en8811h_wait_mcu_ready(phydev);
 }
 
+/* No firmware files, but the bootloader may have started the MCU */
+static int en8811h_use_running_fw(struct phy_device *phydev, int err)
+{
+	if (phy_read_mmd(phydev, MDIO_MMD_VEND1, EN8811H_PHY_FW_STATUS) !=
+	    EN8811H_PHY_READY)
+		return err;
+
+	en8811h_print_fw_version(phydev);
+	return 1;
+}
+
 static int en8811h_load_firmware(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -526,11 +537,13 @@ static int en8811h_load_firmware(struct phy_device *phydev)
 
 	ret = request_firmware_direct(&fw1, EN8811H_MD32_DM, dev);
 	if (ret < 0)
-		return ret;
+		return en8811h_use_running_fw(phydev, ret);
 
 	ret = request_firmware_direct(&fw2, EN8811H_MD32_DSP, dev);
-	if (ret < 0)
+	if (ret < 0) {
+		ret = en8811h_use_running_fw(phydev, ret);
 		goto en8811h_load_firmware_rel1;
+	}
 
 	ret = air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
 					 EN8811H_FW_CTRL_1_START);
@@ -1214,8 +1227,8 @@ static int en8811h_probe(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	/* mcu has just restarted after firmware load */
-	priv->mcu_needs_restart = false;
+	/* drop whatever state the bootloader left in a running mcu */
+	priv->mcu_needs_restart = ret > 0;
 
 	/* MDIO_DEVS1/2 empty, so set mmds_present bits here */
 	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
-- 
2.53.0

