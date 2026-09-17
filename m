Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216D39DBD4
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626671; cv=none; b=iJNpmLhZuOkfc3jXLeecvBFBP0Xs7gdIoHe0/DdLHIRUOZIrwot5NPzTqXvhZk0MA3NzSIMTBpoYnuwe5bVhMKgp9z2eoW9+SJvFnF7BvCxCIh82INehu6iEx5x0vkSdGgOWLZ7wmT5FmSxaxl6p61o+uzfPiVaGL1sHyQeuw+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626671; c=relaxed/simple;
	bh=JehPSF5TxlwvlmTjCN46peQR8ueBW5Q4c73ezLAcs3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ju+o3Gore9CbYPZr94esPE5TFPK1HzQa/oPaW4ONJ0mEQQrz77UCoqg15etm15tMBh8JiVC/45nit9pEDYt6G1PPGegVMUXuffwuENu1KipZQ18x8agjXxn6LpFzr1/grci2SYY94/cvEDaLigUXjcX6P6sPkQdB2o7cZZxAelI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bl1wrdmQ; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl1wrdmQ"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dcb8so320593f8f.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789626668; x=1790231468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tNbDRRbXjT+vvhz8XMb2s7oJBDClC1T3pAgXRXk1T9E=;
        b=Bl1wrdmQiD3IY2f5hNSa+2hKfSnYI2o3NTXG1gnl+DsjAmQ8sUdieQBzzf/T+hb7iM
         o9VatQih9QPqcty2z3+QlyEzpv39gXaCZKMsqLABpb9kAZAjjv0nhemzl/5EQUCAXh2E
         kdJ9w71fQhGNjKciUf5QSUyB9apWpejEj+MNYriHQisqqYX+w5qO60rYok2sb6f/nces
         DsBbVfxDuJbQhsNs1FAijLHhcYxAp613uiM5E1EdzKD6OlgGIF7ccz6oKHRSXgMcf5kO
         ZzVhN/voRR2GR0LQpN2POROT7u0C636XXLYNEab82rIA86YOtfP5rcJe8GNDbiM9lvln
         vAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789626668; x=1790231468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tNbDRRbXjT+vvhz8XMb2s7oJBDClC1T3pAgXRXk1T9E=;
        b=QXg0icHS4gpHd8rlHrHxmPMWu/7m06lsRfeYSrUv0yN1K0XsaUoy9P7Ev2WHOrDr9Y
         g1/73RtEIb3LTbRQ9XVLCELcQmk3SpcHFbn/5EsovIMCOVK41sxENvOQdIQMUa1vEmwI
         dF8uEZ19t8vIDxtx30SHSkEHX46tyDTso9756VWbNl5I7gkJXYAodiSqZ9zWDDxnCws/
         I2bciZ7vtWnM2QgqosNhcIImZue/h/ya1gR+RIFl1ULCflrZdA9lreVvptJy1dKEF5XF
         Xmy5koQdreBVyWOgYQslzDi8U1lDdBeRiOdkNwEHARDcqSAGwDAR6UgOCwLx1jGfq257
         OhJg==
X-Forwarded-Encrypted: i=1; AKwUvBxv3alKJcWp/e0FfZuqyo1ulohH2fPr77vklNSPkxx1tSY1PXMsqMGyI9lL/m68cJIbuArn+8g=@vger.kernel.org
X-Gm-Message-State: AFuF++m6J6hpBv8YcXOa3yIvOxAusNvCYJ1bgeR9Mzl/6uVvqX1Cq5KW
	nRAfIsA0FfCJvCJsLgoDyzER1UUdn1UzL0qaiMxKyGUKKxGfYFro3Bts
X-Gm-Gg: AYBFou1hj2hNr/GtZREfEKjQDgmbWujWLcWvdlkGPjVv2QHJYjguiMU9jk1EE1IvvQt
	mx83jIcJlrJO9mmssOU3d0/OJIh6I7kuGHY1KHs2GHWG5UNM4dnpHaXVooQiKmvH+LUdNbA6Sbs
	ZWYI3+uyNbBpX3Lv09uN3DQV4LVE9FIyMIe0ei53/p8lDzEMg9wKMO0h8S3DPLN3V2NjNsYfELf
	EFLvcckE0xbWmd9VBbPxeCJJx+LL0KjUQCCrO57vhHvrjOqrcFKKS47mSPXvxN1Ks/VPIQNOKNG
	HqeXCrPtwqzHxJc4m02WrL0IaduEjyyHNHgOoMEP8x+WpFCfo6G0zyBzH+fy8xd3Havj3c7eh28
	qZAZlHURZ518iAQTPl3iuI7cCHm0GBmSroUcrWDtzPFxvkLimKqYUSmrqXWM3sAkGTnCf7mAGkn
	6bcr8x5DwtOAWjsYDEvilAuVC5Kh/f4JG4d8XiVtNLltyL4v62/QSEwoiiT/2EblPclN1RpYf7Q
	9GPng2UPhVz94HR0pVZ4DAwaDnhrKVq7cNgbI11eImWf/ioOdsZUBwOINVNqext8Uw2WEfKa5pX
	JhdqpQ80mPf7nyGll4DJqarYl7Y3U4anDDpaAtOk1wbUhFMK8nEEoSF12dM/3RGLfmheG+d8h0v
	i
X-Received: by 2002:a05:600c:a14:b0:49d:433:c3b6 with SMTP id 5b1f17b1804b1-49ec053a640mr63989475e9.27.1789626667710;
        Wed, 16 Sep 2026 23:31:07 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9dc6-c001-54ee-4741-4927-0a28.310.pool.telefonica.de. [2a02:3100:9dc6:c001:54ee:4741:4927:a28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd232d5bsm47683165e9.12.2026.09.16.23.31.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 23:31:06 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: phy: Fix device_set_wakeup_enable() reference in kernel-doc
Date: Thu, 17 Sep 2026 08:30:51 +0200
Message-Id: <20260917063051.52727-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The phy_may_wakeup() documentation refers to
device_set_wakeup_enabled(), but the function is named
device_set_wakeup_enable(). Correct the reference.

Fixes: b344bfacf1de ("net: phy: add phy_may_wakeup()")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v2:
- Target net and add a Fixes tag (Andrew Lunn).
- No source changes from v1.

v1: https://lore.kernel.org/r/20260911204201.95270-1-kmehltretter@gmail.com/

 include/linux/phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5f8d65868e0ff558c163421cfea5a6f3bd73a53e..da2febc6425ed340248d9872dd8f2ef79b665168 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1697,7 +1697,7 @@ static inline bool phy_can_wakeup(struct phy_device *phydev)
  * phy_may_wakeup() - indicate whether PHY has wakeup enabled
  * @phydev: The phy_device struct
  *
- * Returns: true/false depending on the PHY driver's device_set_wakeup_enabled()
+ * Returns: true/false depending on the PHY driver's device_set_wakeup_enable()
  * setting if using the driver model, otherwise the legacy determination.
  */
 bool phy_may_wakeup(struct phy_device *phydev);
