Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74BE44606A
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235075; cv=none; b=gfgdG0fPFOY+1PKG/l8RGfvmPaX3t3glk1XnkEvovJveCPeEoT6xShODShCrwYWb8eBfSA4D1D22u+ouRYrHSIzCZPpPdq0RAi1YI+eeLJzYnh1qeKWhtUNkLBJCZP2XcG2DMegdh9pgIvZjZnr2U/v8PJ4hwns2X2YMfzj+6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235075; c=relaxed/simple;
	bh=metf2ewWaWZ0KpVLK8I17SpTkIQoS2trLjNMVLBctbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+rAooF8qxrOpLHx19yX0noz0pCalyOyBMFSIsvPDjSZehXWmgNyNJ7bOsplSpFysllviNZ0CUSYok/9SbGJRKWneLVwzD1RNQi4iCWj+BEakkos85Mwf/aiCvSG/BA0d2EfXKHcHlXoegisZUcJQJT68THUtyFH26wQ1L/fLh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffRgwING; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffRgwING"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cace91f112so22278295ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 07:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787235073; x=1787839873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1hpIbb+DTG55eyPgd22Z6RIQxrSuxt17lMHiQN1C9mU=;
        b=ffRgwINGaoTDX2gKAu2OVZHYTsnpRE2EgJFlViCahOSeI+sPuYGNzzf08TStoW9nBO
         4BbF/gTcb8BfJpdDoeqyCsoycplY3KxYIq7VRAXoGg4aa9/wtYzNCsEyymG+F6eMkBMS
         kNbpXjG/OQj6G8r7Ycf0e1x2ToHfvRBkRASpJQI5RkPa3fJAZv30iM7zEzDBzEbho138
         8vi8qNXhNsLbhXZTWOnA5Qzr/iKRS5ChdT8WceXHxT9aKNk7mVZbjH2vf14sRZdXJBR/
         aWywkd0TRP0CEBJ3BYh7bM8TJXiEQ8Yi9pr2BwCHX98jHUq//XYJMlMdrT25Ks5zFIrl
         S4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787235073; x=1787839873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1hpIbb+DTG55eyPgd22Z6RIQxrSuxt17lMHiQN1C9mU=;
        b=Bqs4jId3R3V442DxeWGD2x4OxNOL+l/oRqBWJmBL+nIHCzFph3ZzcfGUBYR1W2GvNH
         3VwKDCC14Jln5qxT3x8h3Sdny1QUlvRF4/uG33KylH3v+aoGzovjP7HQe1Ik2l3tX1xd
         xBL+IzqIeG0Fyosfl4X1YxW8R82aj5n8g9blYOYlmFIBB5y859zuDziE3AyU19Zg6jSm
         xRTJAc5hmVNk/5OwFyoBzBaHHKOtGy9FYlLeCVBFNSPzDRui0fSyO+Jd5EGZbG9qpmMD
         RbdnlX+RJlgGp3Y3h0pt11OwGlUiBstWLn2n7QdvwVEWUcXgA2eJADa7hsSRxs2M1b1Y
         Hejg==
X-Gm-Message-State: AFuF++lxFt6YnZBY4JCOrQvHAShU15EUR+pX+TwPAlnbfV/Guk9EdDOo
	Yoh94nPjlbjtxSUCd7b5F6SNPtWzbZcLdPySyD8Vj5xopKu36ebZhVMTA3u7PkYGTVh1uIGg
X-Gm-Gg: AR+sD123QLATgQZ4i5mrylabnorixPcHzRO7SyPiiG1ig3n8ZkFo6y3N/Rjvwx2/ifN
	bfBv/pwMW9gyIzG2/CBvTICbls0Ln3PeY9mbok+7uzvNGvRpL4yn1lIyB1UBprVmNiyaxOlIGJp
	B844MW3llgKvy1fn9RKraLV1rCgmlMrz6hMkvfjNC47XwcL5T1E5a5DQRqEqHfMdEoGTjw+Ks/Y
	IFX7S5OvO+dF8qgvEsGR22GyvpVSHcStPVQYvuF/KLVU6Z4bLIhRrhNDRdcYfRspzoOYZ42/t/D
	5GtgHR9PROe/Glz1Pq/kREWf9UfHuKKbnhyq5AtPF7rM+u5Xeq2mtteJcou32awQBVecrbGo/0j
	IEKivj33+gtYPrc095uQzbfBLI/V5eOljFVr19y85g+KjKBhUeajp3Ls7iLvvBMOFqSuMZBMn6W
	Esg0IdgMqLsKgnOgDTR31GM6vfplI5VXbk2htCRbdakb5H7W7I5Ahz8AUTRjjla/F7Q1L7C/RAL
	XVWnOuAtQ==
X-Received: by 2002:a17:902:ef43:b0:2c9:b8b7:5d27 with SMTP id d9443c01a7336-2d5fd5ff363mr253093705ad.1.1787235072883;
        Thu, 20 Aug 2026 07:11:12 -0700 (PDT)
Received: from DESKTOP-FD9BUFI.lan ([240e:3a1:925d:9350:d471:c081:b8c9:1eec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62d58a811sm7801075ad.25.2026.08.20.07.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:11:11 -0700 (PDT)
From: Ziyou Xu <xuziyougm@gmail.com>
To: netdev@vger.kernel.org
Cc: Ziyou Xu <xuziyougm@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: phy: air_en8811h: restore LED GPIO output after MCU restart
Date: Thu, 20 Aug 2026 22:10:34 +0800
Message-ID: <20260820141034.1400439-1-xuziyougm@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

en8811h_probe() enables the GPIO3/4/5 output bits after loading the
MD32 firmware, but a subsequent config_init() restarts the MCU, which
clears EN8811H_GPIO_OUTPUT[5:3]. The LED event registers survive the
restart, so the LEDs work during early boot and then go dark after the
MCU is restarted.

Move the GPIO output setup into config_init() so it is reapplied after
every MCU restart.

Tested with warm reboot, cold boot and cable unplug/replug. The failure
was confirmed by reading EN8811H_GPIO_OUTPUT as 0x00; setting only
EN8811H_GPIO_OUTPUT_345 was sufficient to restore the LEDs.

Fixes: 71e79430117d ("net: phy: air_en8811h: Add the Airoha EN8811H PHY driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ziyou Xu <xuziyougm@gmail.com>
---
 drivers/net/phy/air_en8811h.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index edd49c193..fbd87fc71 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -1173,13 +1173,6 @@ static int en8811h_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	/* Configure led gpio pins as output */
-	ret = air_phy_buckpbus_reg_modify(phydev, EN8811H_GPIO_OUTPUT,
-					  EN8811H_GPIO_OUTPUT_345,
-					  EN8811H_GPIO_OUTPUT_345);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
@@ -1317,6 +1310,16 @@ static int en8811h_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * Restarting MD32 clears the GPIO3/4/5 output enable bits. Restore
+	 * them after every restart, before enabling the corresponding LEDs.
+	 */
+	ret = air_phy_buckpbus_reg_modify(phydev, EN8811H_GPIO_OUTPUT,
+					  EN8811H_GPIO_OUTPUT_345,
+					  EN8811H_GPIO_OUTPUT_345);
+	if (ret < 0)
+		return ret;
+
 	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
 			    AIR_LED_MODE_USER_DEFINE);
 	if (ret < 0) {

base-commit: 564973a259ec76f2dad0853420e7034cc43994c4
-- 
2.43.0
