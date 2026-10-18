Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B6B379C35
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792336731; cv=none; b=PaljNCVaIgDMdbtwAO2Hv90EL97oiyPd/GsL3MgTHpmTHem0rfPwDlbfYbAShHobJi6lUQxLr9zFRVXYEyQ7fiwDv1Jr01loPOc8NuGxslU8Fe6hxy9xvV+A//dTtyJvar5OoCtXpBzq7qyg6KZmalfdBWfgdckheLP0MNYt4yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792336731; c=relaxed/simple;
	bh=qx/4nlszNIOvSXPbFdqTk76/GDOMD94CXfm2Y2LGsRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDcURFG2YcPbTntNikyPqibL+n/AYzrJAYzJ9WcxWclrA4haIZwMpJw8RJp4l12Q7MjDTF1H1Q7wot2ul0fSPTFrE1fjjkc8QK/eer0Qqfj1Zi/V33c52R3n6gu8q/YzGRAZyVgGODnr94l9e9jDIfdpyycg4oS0UOX1/1M2P8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0Svhqul; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0Svhqul"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3282db206d3so1602708eec.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 08:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792336730; x=1792941530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kLB6J+RYOkmZpaUfT4tBXxcs2uf2yhVuzsyRosaJUtw=;
        b=U0Svhqul9F8ETvSPTspsXInpDr0KyTkIS6tFpQEfn91qE/qUR3jRzvwL6A1cmZ089B
         hn+PGWIG0aimANuy/jNQw/RGiMh5dIy4EGgBKFY7B+x06Btsj4EbBnXYbOH3PDPhlDW3
         5lE/EyOHHkTJlmrpfNvHXRL1iUa1uqiL7plPUFFEsB87aIg7TPuJWP6EVE2eA3KwwuHv
         1yQKZfX9kLtgPGDBBB6qT6DBERNFivEOEOaiJii6xumzIzWLxepFJxGhzVxaRFhVVjOi
         pkScfWkHstkmf9TCmMhx6ZGSyQY1t5jBuXSvxnuQBP1R7T5u5BIEwaIbsvexV0h1KDIT
         uYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792336730; x=1792941530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLB6J+RYOkmZpaUfT4tBXxcs2uf2yhVuzsyRosaJUtw=;
        b=V2zak9Loa5G4kSfzVpojdXqXSytun3gMNl2OlX2247LHhAPcsgdGESFuEFmun3Zwr9
         em0mEeJiaPZnhrmRlY5exUEZlWKc/HHpa4R4POmHJmcVSlYvkxtpiX7YQCZVlEMybgY0
         rg9ppoUqBnIn0gzgVwh+fKistn515DLzW4ATrte0/uMfHwYiiOnObI2+FA1mfYhqXsLm
         JhbVnoDe6vdJM/2bgZ3GVzXVdGyUIdnkSaNvJgv0PXpm9WhDUdsmSJ4Ua0gp//3KKtXL
         Ohlxpw+oa1gdyRf1hqzNhm2pt4yUfkzU8QaXvt2HkKJyVGn3cWRT1d9jEfm3gRKaA4m6
         u6FQ==
X-Gm-Message-State: AFq9FYLQi++kJyxy7fw46brFdO5FoBIVExPzWI8tYxaGA36mn0fVDWC2
	+AiTbWZKj7tMsg0FWY9oD9JT7PijrcXscDdnibH7/HptLt0NmmzhqCca8Or5CDOE/KE=
X-Gm-Gg: AYBFou1RmbtTTfHfqsM3iuUbKoqDftQxUlekNM71XN1atAQv2ZI2kbvl0+sbUn8UYA+
	XbxQpO1w8/35/ZDMPEo3q0Iy0N8pyCfs2XaeKOXBPnHdCyCOUzbU2WZz/fZKAZ7VqequL65qlbd
	qjW1h1YqGisQzCOoYNnxPLeYv5jagidE1UuNTEvaaqiNsaATBR2abaRpu6ue7URqOBnwe0ylqVp
	XLg2qmerI/cFysYpR2vW0QsZ2LPpiNTTqOK39v3P7E+xkhwE6MyBl2VD4siEPkg7bf7uRQEM9bb
	FaIFJu30uVuI9oQAlYj+ywm5gvTOWsbfsmxIUQm5XN+wR41bCPAhrTWTYzsiEWmcp5wUIEZiDOy
	ULsiFdmHN2VB5c9GNed5a0NYgGCWZoOJlHFghaeJqzB8pWJ8Oz0orokWVM/rcAHSr7NM/wi3abZ
	YBKZ1olD0QvdU6Y/pjlBy2aCcXuuMa0BI3s48IlT8EN4IDmripYFlMLF5wPDy7N380yYYZjmbQt
	BPPezbowLTqboUbU8sf6w==
X-Received: by 2002:a05:693c:88d0:10b0:339:7b3b:236d with SMTP id 5a478bee46e88-361a1f5575bmr7760238eec.15.1792336729527;
        Sun, 18 Oct 2026 08:18:49 -0700 (PDT)
Received: from arch.localdomain ([2401:4900:c259:a21:b203:ebb9:615d:d6bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608308a87csm41698209eec.28.2026.10.18.08.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:18:48 -0700 (PDT)
From: Prashant Sengar <prashantsengar25031@gmail.com>
To: netdev@vger.kernel.org
Cc: Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	linux-usb@vger.kernel.org
Subject: [PATCH net] net: usb: lan78xx: avoid NULL PHY dereference in WoL setup
Date: Sun, 18 Oct 2026 20:48:30 +0530
Message-ID: <20261018151830.643511-1-prashantsengar25031@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN7801 supports fixed-link configurations without an attached PHY.
However, lan78xx_set_wol() unconditionally passes netdev->phydev
to phy_ethtool_set_wol(), which dereferences the missing PHY.

Only call the PHY Wake-on-LAN helper when a PHY is attached.

The issue was reproduced with USB Raw Gadget and dummy_hcd in QEMU.
The unmodified driver triggered a NULL pointer dereference.
With this change, the same ioctl completes successfully.

Fixes: e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC management")

Signed-off-by: Prashant Sengar <prashantsengar25031@gmail.com>
---
 drivers/net/usb/lan78xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5655941f1478..0c19a8462352 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1804,8 +1804,8 @@ static int lan78xx_set_wol(struct net_device *netdev,
 	ret = device_set_wakeup_enable(&dev->udev->dev, (bool)wol->wolopts);
 	if (ret < 0)
 		goto exit_pm_put;
-
-	ret = phy_ethtool_set_wol(netdev->phydev, wol);
+	if (netdev->phydev)
+		ret = phy_ethtool_set_wol(netdev->phydev, wol);
 
 exit_pm_put:
 	usb_autopm_put_interface(dev->intf);
-- 
2.55.0

