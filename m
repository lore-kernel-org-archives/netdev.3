Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2839A7E0
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908953; cv=none; b=l1AzZPoLCVHFBtbQh1w9YTQ99fpev4DE1qoGp2Dk5JpcEViou8J8GOsk5jizYxHFFceeT8983iAp3M0N9gByYjlCluYHWE2IqKl4zsDV1i+NJfQENzJ0q8hQiAm4ehmPKHbfHaI5YD/44x0fwbFxQa8mToxj2DB+ETzywKD482g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908953; c=relaxed/simple;
	bh=vKv+GXIuyE2hiDyG1h0rqn+IWb8EjWtNu3co1fIZfgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxiknNcTk8kDroKbLmoSnkRQ6xhhUdydnQAiArlhg8cKNG6Wa7DtWYclf75NV7E4+laZ5JiWIiF2gJCHcOBda/E8HRAhuieOW62Z5JiaCOBW3IADr9CSthZEhQk7Hn0ta9uHC5oL3u1l0F4LvzVZUvB8s18VBkEKcUfQnVhcDAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iit.org.ua; spf=pass smtp.mailfrom=iit.org.ua; dkim=pass (2048-bit key) header.d=iit.org.ua header.i=@iit.org.ua header.b=DDTS9OOX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iit.org.ua
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iit.org.ua
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iit.org.ua header.i=@iit.org.ua header.b="DDTS9OOX"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so7154855e9.1
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iit.org.ua; s=google; t=1787908950; x=1788513750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0x/pbKOdcSa5MoWBFxRhYpy2xSpaLcp53m9A0z28vvY=;
        b=DDTS9OOXn+lrk6KjPYI9W6NUP/WSwm3MtZ9alYLT6yf1Bv+amY4vE6Hzq+WKEiHpLq
         FVudTki8wpSko7pPuS3D8fAEUpx/4OJ4H/q6Lynz4ODGJOaj+VdReTsRXO5nLbagoKDM
         1g25VUfeI/Vyh5fhuz9zWRpzQFwEurzLvQLVVmyZs6P6rLKOUwl37NGfys/ExNGMn7oD
         3WaV6sKBPIzke42aCALa8RJs3afXZNvRhtJmCQ9IM7Wk2xVMR/Kq/fhKV1Jd6TZdILhy
         ak2d/sQJsOK4d2onIh17QGiX4eX+8Vj6U1wIJMb1ocqSZAh8w5H7XRmr1CFsEygXKiMo
         txvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787908950; x=1788513750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0x/pbKOdcSa5MoWBFxRhYpy2xSpaLcp53m9A0z28vvY=;
        b=b2EZN3RO0YGcfHO0Uepw7NfsKUbuz6kp4EbDrvQ5FMApy+phuam1qcTzSiNZ/z1S3Y
         c1LEJTfd4fGX5b9seDpXNcSL1tOiZvdf9ewqgGBbCYhPMobWCvniXB4l1SjP90bLv1Vw
         aVtnf2BmD08XPuoG+O0JV79ubtBD9DVWLvlajaa9OXVC6mUEkgw/gNyuXXgMF9p5P3sy
         YrHvkOiSMo+dhULsS+t/leBfYa9AFxCTjXwjfU7KoL8BhqGOZJ7uMLv/wHamP3o99kRf
         N+FHtGz4eT0+tm9wYPAjA8Oop2l0ckJR+HfxAYtNHRq9DwwzNCfWY0dCEsZySOYHbsIF
         V3zw==
X-Forwarded-Encrypted: i=1; AHgh+Rq6/1y4Jtf9kKf/Ojy/cOg1k1j/7HKvMcy2+JkCAkJk2C2FNUuodig29aY7RuKbZqu9dFOqxH0=@vger.kernel.org
X-Gm-Message-State: AFuF++kqxI6kUXOZqPDnkcO88RWxAIyaK8+Uq3AX6DmfH3Rq45+SvB+f
	lZu+ZlqdGkrpSffRNMRmY2xfE4y7D45JbXnf1bns4hPBOsBPRLzYsTdeOTcrxhDKw1A8ws+WQYl
	p7E22PgabrA==
X-Gm-Gg: AR+sD10uBysigsyGrEfDf7NgoUeJx6s3bMapmi56xx96tP1C1Q4Og3FKp86HWBq+46H
	cBQJJxpjufyAuXIMxVwI/OaG+Fya7vQ9YPflLtNPX/l4RWoJqWUj3aF0prmqMea/xvmPl5vZQ/d
	c9s/VBv3RilDE0IxZrPF0fpZ3XXOe9fvckiDnc30mKn/rpNppWHiM0+q8P0YRuE+u2wXb1VP/pn
	K3lLVrWhhjG8eQXl7BxYSShlddXzkEhaLv1OkH51VEWA2j/jAtjSxYkvU3mUs/nE/bg+vKjN4lJ
	c1KFejO1BqMcCrqUTB9QnmsgLmWSn3P19XrOuUPqvCA7cd2CMOcUHowkUudp0/83F1zAaiRmN5K
	qj6jtTAsPpPy4svxPWyoA8X/IrM+ih7PbaTjllV1NKe8Uy8Y/HtciNJBSMAXFpvv85lB6IdRnH4
	UqYoAubc2tB7cxCGE94fzaEbgLZu16l9U4ik91GHVUBTOYdnRczld5Ug==
X-Received: by 2002:a05:600c:5487:b0:495:7888:281c with SMTP id 5b1f17b1804b1-49b91bd1463mr61514445e9.0.1787908949656;
        Fri, 28 Aug 2026 02:22:29 -0700 (PDT)
Received: from archbtw ([212.1.106.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b497fa9c5sm111484255e9.4.2026.08.28.02.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 02:22:29 -0700 (PDT)
From: Stepan Svatenko <ssvatenko@iit.org.ua>
To: Raju.Rangoju@amd.com,
	PrashanthKumar.K.R@amd.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Svatenko <ssvatenko@iit.org.ua>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] amd-xgbe: fix comm_ownership mutex deadlock on SFP module removal
Date: Fri, 28 Aug 2026 12:20:22 +0300
Message-ID: <20260828092023.105405-2-ssvatenko@iit.org.ua>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828092023.105405-1-ssvatenko@iit.org.ua>
References: <20260828092023.105405-1-ssvatenko@iit.org.ua>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xgbe_phy_sfp_detect() acquires xgbe_phy_comm_lock (via
xgbe_phy_get_comm_ownership()) and holds it across calls that can end
up freeing the external PHY device:

  xgbe_phy_sfp_detect()
    xgbe_phy_get_comm_ownership()                  <- mutex_lock
    xgbe_phy_sfp_mod_absent() / xgbe_phy_sfp_read_eeprom() (SFP changed)
      xgbe_phy_free_phy_device()
        phy_detach()
          phy_suspend()
            genphy_suspend()
              xgbe_phy_mii_read_c22()               <- mii_bus->read
                xgbe_phy_get_comm_ownership()       <- mutex_lock again

xgbe_phy_comm_lock is a plain, non-recursive mutex. phy_detach() ends
up calling back into this driver's own MDIO bus callbacks
(xgbe_phy_mii_read_c22()/xgbe_phy_mii_write_c22(), reached via
genphy_suspend() during phy_detach()), which independently acquire the
same lock, so the second acquisition deadlocks the task tearing down
the SFP module.

This is reliably reproducible by removing an SFP module while an
external PHY is attached: the removal handler hangs forever inside
xgbe_phy_free_phy_device(), confirmed via /proc/<pid>/stack and the
kernel hung-task detector (blocked 368s+). Reproduced on a SolidRun
Bedrock V3000 (AMD Ryzen Embedded V3C48).

There were two call paths into xgbe_phy_free_phy_device() while the
mutex was held: the module-absent path, and a second one inside
xgbe_phy_sfp_read_eeprom() when the EEPROM contents change (e.g. a
module swap).

Fix this by never calling xgbe_phy_free_phy_device() (directly, or via
xgbe_phy_sfp_mod_absent()) while holding xgbe_phy_comm_lock.
xgbe_phy_sfp_read_eeprom() no longer frees the PHY device itself; it
only records that the SFP changed. xgbe_phy_sfp_detect() releases the
mutex before calling xgbe_phy_sfp_mod_absent() or
xgbe_phy_free_phy_device(), and re-acquires it only around the
remaining raw I2C access in xgbe_phy_sfp_external_phy(). Neither
xgbe_phy_sfp_mod_absent() nor xgbe_phy_sfp_parse_eeprom()/
xgbe_phy_sfp_phy_settings() touch hardware directly, so they don't
need the mutex held.

Fixes: abf0a1c2b26a ("amd-xgbe: Add support for SFP+ modules")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Svatenko <ssvatenko@iit.org.ua>
Assisted-by: Claude Code:claude-sonnet-5 [Bash] [Read] [Edit]
---
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 41 ++++++++++++++++-----
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 59a074ed312a..a264ec5bb085 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -1218,7 +1218,13 @@ static int xgbe_phy_sfp_read_eeprom(struct xgbe_prv_data *pdata)
 		goto put;
 	}
 
-	/* Check for an added or changed SFP */
+	/* Check for an added or changed SFP. Freeing any existing external
+	 * PHY device is deferred to the caller: xgbe_phy_free_phy_device()
+	 * can end up calling back into this driver's MDIO read/write
+	 * routines (via phy_detach() -> phy_suspend()), which take the
+	 * comm ownership mutex themselves, and that mutex is held across
+	 * this call.
+	 */
 	if (memcmp(&phy_data->sfp_eeprom, &sfp_eeprom, sizeof(sfp_eeprom))) {
 		phy_data->sfp_changed = 1;
 
@@ -1226,8 +1232,6 @@ static int xgbe_phy_sfp_read_eeprom(struct xgbe_prv_data *pdata)
 			xgbe_phy_sfp_eeprom_info(pdata, &sfp_eeprom);
 
 		memcpy(&phy_data->sfp_eeprom, &sfp_eeprom, sizeof(sfp_eeprom));
-
-		xgbe_phy_free_phy_device(pdata);
 	} else {
 		phy_data->sfp_changed = 0;
 	}
@@ -1296,26 +1300,45 @@ static void xgbe_phy_sfp_detect(struct xgbe_prv_data *pdata)
 	/* Read the SFP signals and check for module presence */
 	xgbe_phy_sfp_signals(pdata);
 	if (phy_data->sfp_mod_absent) {
+		/* xgbe_phy_sfp_mod_absent() calls xgbe_phy_free_phy_device(),
+		 * which can call back into this driver's MDIO read/write
+		 * routines via phy_detach() -> phy_suspend(). Those routines
+		 * take the comm ownership mutex themselves, so it must be
+		 * released before making this call.
+		 */
+		xgbe_phy_put_comm_ownership(pdata);
 		xgbe_phy_sfp_mod_absent(pdata);
-		goto put;
+		goto settings;
 	}
 
 	ret = xgbe_phy_sfp_read_eeprom(pdata);
+	xgbe_phy_put_comm_ownership(pdata);
 	if (ret) {
 		/* Treat any error as if there isn't an SFP plugged in */
 		xgbe_phy_sfp_reset(phy_data);
 		xgbe_phy_sfp_mod_absent(pdata);
-		goto put;
+		goto settings;
 	}
 
+	/* Same reasoning as above: this must run without the comm
+	 * ownership mutex held.
+	 */
+	if (phy_data->sfp_changed)
+		xgbe_phy_free_phy_device(pdata);
+
 	xgbe_phy_sfp_parse_eeprom(pdata);
 
-	xgbe_phy_sfp_external_phy(pdata);
+	/* Re-acquire ownership for the external PHY access below; it talks
+	 * to the SFP over I2C directly and needs the mutex held again.
+	 */
+	ret = xgbe_phy_get_comm_ownership(pdata);
+	if (!ret) {
+		xgbe_phy_sfp_external_phy(pdata);
+		xgbe_phy_put_comm_ownership(pdata);
+	}
 
-put:
+settings:
 	xgbe_phy_sfp_phy_settings(pdata);
-
-	xgbe_phy_put_comm_ownership(pdata);
 }
 
 static int xgbe_phy_module_eeprom(struct xgbe_prv_data *pdata,
-- 
2.55.0

