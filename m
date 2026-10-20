Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527357;
	b=WpOjWAQ2VFY9d5OvJ8nSdY9i/fgWZwDH4gZZ8W36Rmt2gIsehOSstszVd5vJzRz/3MJN
	 A5eM0/mTA68YVPPlYI3TFpkjAe+/0u2rzEJj3EQIkeui4MMZOJYHiylH/RfCBhvSbLOut
	 jMtLu+L87f7ahsx4zjf/w977AceukuS9bFQ0k3dl3ocD0sVVcDAQ/lDFvWM0gPwb9vX80
	 IlzzQWbdXXv+1CxFMmPrXT0dlc+9tJMIlIooAbDonwu0kb2G2d0wYF5dyToGmxy4F0TvO
	 NUVRQvrof+3aPhORynkweYtUo2FUR5yT5GqhygJCZ0X+zYTGl4t1904AVaefezVL3cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UskgvncvUpPt8ituFGdb7oQlhxbaiJTmOeLamQsyhQ4=;
	b=GAzGz0JVMb68ZzHA2Do+nnrhBnPAzi9UkJ7dcWLs4pnZFYGMnl88MqHhAhFIfu20QXLt
	 ymIdJhGhBuPtfL8l2CfYkAWL1ccWHHg+fQJdRd8Fbwe8PX6w8X1Hki2ag5Z1ob6h/H3ET
	 VJ5qDchNHqdaFVM6/56CtrfgHZFmU7Y147RDpuIq2TLhPZWYSGanvCwEl3N/4PdDPiok6
	 0pokG92Mp0yrh2T4yUW+9lViKCtDmkOnPab3nu5wvFOtc2I0mt5oupHpcCYtsOa5OpNNz
	 2v/yd8qfdsD7SwFfWTekJS7W1LVL4DYmjXYC3JV4/+ifxQLCrMWV8S7ZoydxOI37qgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KkNdjM2W;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CA2606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92CA2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KkNdjM2W
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35ef6b49813so6629358eec.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792527357; x=1793132157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UskgvncvUpPt8ituFGdb7oQlhxbaiJTmOeLamQsyhQ4=;
        b=KkNdjM2WRZU+wtKJ20+0ZHo+LXraciSWuqpBXt5e/UQEE+V4xzsXI3Id6rPaiAGRyQ
         CXEyWrM7f69l5W9gPlKigwzJeHTPrbIhoF6mfAV4H8CLRkd4D06fy1++xizx6k7eywkI
         x/iv0fwdq7wYnY7gFPho1cskbXZU0NEY7YG7Px0sBEuAdiX7LYh3GsncfFewaoJgYWoU
         bwtIoBJkRK+sQa5UypDB4uf7uw4E0JvQEm1uJftKT2FpKmmtV4HZHGRwlzKb4SMNNzwU
         xwUQYANdC9z2JAMhXLY+j++o5bXVw5epvsUM/clkemu/U8TmkDXDnom4X+ZTW4XLR4fs
         Zk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792527357; x=1793132157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UskgvncvUpPt8ituFGdb7oQlhxbaiJTmOeLamQsyhQ4=;
        b=lrTgBD4YxptF2jUN0Pa987co1xG8ir8c/U+NLWSOGzROJ0bweu54H2mrhBcku1TmEm
         o23fEBnQgddodCr/0Cmzbhwq2053bnFXk5swdzx+LRTtOKiCyb9PmldqJiYrDzoFlPfH
         oy46+5E7bUeAcs+TR2hIyfP/qhWSQhx6zGRaJfpdRzTDp73aP8896N1Jt5je7cptS9JG
         4ixOvLAbeL3+OeoV7pB9h9pvIpNPoKSnCyasG9XZNnjthNxm3a1paVrJLdJmoJkNe2Oq
         YhYp7qYk2u1Dj6kCPFD5xfT/DmM9kn9YOBb4bNDc21rvekV2UG7a7Q4CElMCB/wdwOL/
         1bhA==
X-Gm-Message-State: AFq9FYLuS2UKnQ3oAJ2rPtwHMeAWsRFyi3v28GUSsnzx7r6Gzg3gVLVr
	4yJeAigvpAZbAmjey9HfCY2rkES04ObTiccPbejgmR0A6YZCltq8JYBVFEn/tw==
X-Gm-Gg: AYBFou2jAOcXxRnaNcCtF5UA6/b6580L3lPBiay4GPbfwp0hC1MZUon54BytLSGX34S
	y8xvFurwnVfCkrkj/E3ZtI8aEdHgC2UCTbFL9qddExMG4+lm8YjGjj9IsUszak3rNjG8E+dtO6/
	8OdCBQv1W/GKxuKSIZluja49KeWg7fUYEc3FVAjp+Zr1TNgBZWK4bsqMQcYiI6ybnwsIAJchqtH
	Z5EuWrMJa3w7eevUlsu9XQdbxfTTeGkFv21GP57CL8WzHr1SU1p53GCgcvI9IcHQenhvUND/2Be
	dIgNG5d5eod/2Ls/B5OnK50rWlTVtMaq+7W+YHyh27x8owpb1pZi1wd+Ge8i4sljmTOgN/oMzHc
	K1GBouOGP6E6wAvv1Thq6qcqNypIvlfZq22PZ1/gRq3hfQRnvAZI/fxAytxzz/7wpHpqszkLIhK
	x62gcNDwlZwVeQ8xWP63L/+MSNDYQnUpXplmZes0HiELv55v6ygRe2gMxP8ZZEZE3Yrk/kfpr8T
	0gvO6wdJMrPnB19YI+0Auf0GQz3sZI6fQ==
X-Received: by 2002:a05:7300:c00b:20b0:35c:ba31:6fef with SMTP id 5a478bee46e88-3674f21af3amr445718eec.36.1792527356516;
        Tue, 20 Oct 2026 13:15:56 -0700 (PDT)
Received: from arch.iiitdmj.ac.in ([103.199.188.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc8c6dsm912580eec.12.2026.10.20.13.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:15:55 -0700 (PDT)
From: Prashant Sengar <prashantsengar25031@gmail.com>
To: netdev@vger.kernel.org
Cc: Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	linux-usb@vger.kernel.org
Subject: [PATCH net v4] net: usb: lan78xx: avoid NULL PHY dereference in WoL setup
Date: Wed, 21 Oct 2026 01:45:37 +0530
Message-ID: <20261020201537.2465655-1-prashantsengar25031@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN7801 supports fixed-link configurations without an attached PHY.
However, lan78xx_set_wol() unconditionally passes netdev->phydev
to phy_ethtool_set_wol(), causing a NULL pointer dereference when
a userspace WoL request reaches this path.

Report no WoL capabilities when no PHY is attached, and return
-EOPNOTSUPP from lan78xx_set_wol() before modifying the wakeup
configuration. Keep the existing phylib WoL handling for devices
with an attached PHY.

The issue was reproduced using USB Raw Gadget and dummy_hcd in QEMU.
An ETHTOOL_SWOL ioctl triggered a kernel Oops with the original
driver. With this change, the PHY-less configuration no longer
advertises unsupported WoL operations, avoiding the crash.

Fixes: e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC management")
Signed-off-by: Prashant Sengar <prashantsengar25031@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v4:
  - Remove the unrelated blank-line change noted in review.
  - Preserve the existing spacing in lan78xx_get_wol().

v3:
  - Report WoL as unsupported when no PHY is attached.
  - Keep the existing phylib WoL handling for attached PHYs.

v2:
  - Use the phylink API instead of calling phylib directly.

v1: https://lore.kernel.org/netdev/20261018151830.643511-1-prashantsengar25031@gmail.com/
 drivers/net/usb/lan78xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5655941f1478..4f100bec5b3a 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1764,6 +1764,12 @@ static void lan78xx_get_wol(struct net_device *netdev,
 	u32 buf;
 	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
 
+	if (!netdev->phydev) {
+		wol->supported = 0;
+		wol->wolopts = 0;
+		return;
+	}
+
 	if (usb_autopm_get_interface(dev->intf) < 0)
 		return;
 
@@ -1795,6 +1801,9 @@ static int lan78xx_set_wol(struct net_device *netdev,
 	if (wol->wolopts & ~WAKE_ALL)
 		return -EINVAL;
 
+	if (!netdev->phydev)
+		return -EOPNOTSUPP;
+
 	ret = usb_autopm_get_interface(dev->intf);
 	if (ret < 0)
 		return ret;
-- 
2.55.0

