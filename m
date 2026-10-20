Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519988;
	b=Y2o579XY4xLxywPLMX+BRejgjvBFyZinA7rH6A4sf3wNdLf4plxWUdaexeT23v9/NGol
	 sg7rznxKEP4iv6WEyKnOT+M6pEZV9lOTr/qgVfv4hOaQk1McfJCO7U8UNERh8f9zEPqvK
	 nnDAf9+37Q765AUx0a8+jvMAmmkklEcK7gLR26qVVn+yT7UDaKAS9F6SBnvb1rsnNh/nm
	 SRd1jlKQBi0yByR72WLSR1t64uxooq3tyYf+l5+npT+vCZa8eLHnn432BE4h4NwG/J+qU
	 v6UgJsnlWq1CtSs8is65Dq9AvbTWbEPS8AH3TAnrAMzf/ZNor+fNpaVA9/Q6+8W6w9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7Wx9GyoHHfawHRnV0Cg3i7Hst1BvQl6Kp0zfGCvvP3g=;
	b=5tI3ab2vFDUYlXwtkqyE72+n7A0yjrkD/FSZV2Jye94Wn9jAB/Yv4d1sU1O6Q9+/NMCD
	 o10t8gcsF5Xmd4B71t0UoRHFUX8UQSqxoCuVEcaZX+arX8kcrVF0zg+0U81GZqwu6QSTk
	 mj+MHDEW1zecafPynQQKP0GtvoY3GRs89BtN9ZZjh1Q+0coHi6ShA1xb1jqF4HRO3vQM7
	 WRCU2PfsYM9rqTuGs6+pCCrne3AsOHn8NFaAHYU8ZlC0Hs19P+sk8IPurNUrwGZBz+lDF
	 scvh2gjHJbB0djj8WLjJo+S8WEjU6xZBalmR0wZcVJrw6/PMRsVGSdiTVbBxqFGJEJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dd3axunV;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7081F606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 18:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7081F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dd3axunV
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-354ba08cfd1so6393009eec.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792519988; x=1793124788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Wx9GyoHHfawHRnV0Cg3i7Hst1BvQl6Kp0zfGCvvP3g=;
        b=dd3axunVuUqRuGrGGRSfLkb1V8FvMQ424d9Mzy0sC6Mk8rBd+qmiIfOpd9wkRXU7N3
         QazkkiHhdfGV8qnqKWXHIO5Lv0Vvx0yb5h6EpRB2UVGv3OKrHmY3bkfnj4t9rd7ZtEGN
         6Vp4P2VDjhHXjYOsALXNwbWhaKKxCeEfPDdaYlgcQWig4aYrjgYIh9ci+avYY7wjWGo6
         CnTgsiURhUCBlzMHXSe88xGlEHv2YRSYUZXIIuknz4iQFOIkW8LvTzZJ/qTMlb3JQ4Jk
         bQfhlGSfHvH1y9OviUtBf/sty6IPXxG6urYRWk2bpT0ic4WSTe+lV4ZDa3X8bwbS1Kvl
         2Xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519988; x=1793124788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Wx9GyoHHfawHRnV0Cg3i7Hst1BvQl6Kp0zfGCvvP3g=;
        b=SDXGMu2KKJciVxaDZf8CEVkJff9BwURnpmo2KwIQ6XTUfiFDPbAo7ADfmgrUY/JquP
         3Z34MH4120zgaV/pddhg6pU0grUrRZLN+StsOrfNhBrqz0o0Chi3ABUxH+W3djDKaCq3
         P063pFql7v2hee/nmTGEzmuLeNst2OnnH0f1goa+NFic2khMgSyZ6SWp8sh4VlnhPx1E
         8/gkuEw3xDhipXE3/nPKs2IB5y4yEIyd25WKY3yvXSaP9n0b9oGEWurZpqIU08vbZGiX
         KlPrNzsNiDugFOU6+lGgqWrUoSMMuwxlgMcgkJ2YRAKvtMP4LDMVkNfCywKJbzW6bYpm
         y7eA==
X-Gm-Message-State: AFq9FYJcDzofBqm0Pq8TxxgdyyIFAOi0M3/vEgpRVyjxr5PDWuGQVyS3
	2Hrp0YbsG7HohCps5CZb1hol17i00CmYgmBkQQK4Z04oPCLMGlNK51xEqnAWRA==
X-Gm-Gg: AYBFou3rSfYEPZNs/wS/KhhVKLjKF+JTGJ6EU3+nHE6PdFOSEoAZT9JOid7x8ADJJrj
	wjY83HcSRZJy05zOqsqiJjj9+R5L8gfVm2ygQBtELIctJJJy99FS/UnEFLVk6nXCYa0+uKSOSsL
	oFH/pWBKEgkfs0qqMAV8quMd1uskVo41au/y5hSvqbCjwAR1wmGqQ1JMbfCt4E7xk6XaFhmOG50
	GH3UR2+ffopSKm+oRH+06SPIDsHnZ4IAPq+rUR7DVnVwiXwH+810tbTRSbkhS/eJlg5+BFuijZe
	G46ebuiIX20Vr6NskwkOi/TAexyyVprz3z6oEXLIeWqD/CUgs0UFP6CatyuIqZ4CI4TqqjnOY99
	V7kSHPWoZwycLJPjUBO+4VQ+66SacdLk3bdti3pbLxGVn55gTACsezg5ukZ0jnmPYZn8Hc+Taoy
	PtMQ0u1d6T24KEDlbswXUBUE0YR771NoIJfCG5DgJOOynkncRjLyZ/Lgfr0fhkvIpH5klPzfOw5
	wt4W2YlB98x5tpEpnih8g==
X-Received: by 2002:a05:693c:608b:b0:35c:ef18:6a78 with SMTP id 5a478bee46e88-3674a41869amr97000eec.2.1792519987538;
        Tue, 20 Oct 2026 11:13:07 -0700 (PDT)
Received: from arch.localdomain ([2401:4900:e005:334b:4504:532e:b7dc:d438])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367416a1fb9sm265873eec.20.2026.10.20.11.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:13:06 -0700 (PDT)
From: Prashant Sengar <prashantsengar25031@gmail.com>
To: netdev@vger.kernel.org
Cc: Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	linux-usb@vger.kernel.org
Subject: [PATCH net v3] net: usb: lan78xx: avoid NULL PHY dereference in WoL setup
Date: Tue, 20 Oct 2026 23:42:37 +0530
Message-ID: <20261020181237.2374075-1-prashantsengar25031@gmail.com>
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
---
v3:
  - Report no WoL capabilities when no PHY is attached.
  - Return -EOPNOTSUPP from set_wol() before updating wakeup state
    when no PHY is present.
  - Retain the original phylib WoL call for PHY-attached devices,
    following Andrew Lunn's review.
  - Leave fixed-link MAC WoL support for separate net-next work.

v2: https://lore.kernel.org/netdev/20261019193148.1381545-1-prashantsengar25031@gmail.com/
 drivers/net/usb/lan78xx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5655941f1478..612e1e46de6d 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1763,7 +1763,11 @@ static void lan78xx_get_wol(struct net_device *netdev,
 	int ret;
 	u32 buf;
 	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
-
+	if (!netdev->phydev) {
+		wol->supported = 0;
+		wol->wolopts = 0;
+		return;
+	}
 	if (usb_autopm_get_interface(dev->intf) < 0)
 		return;
 
@@ -1795,6 +1799,9 @@ static int lan78xx_set_wol(struct net_device *netdev,
 	if (wol->wolopts & ~WAKE_ALL)
 		return -EINVAL;
 
+	if (!netdev->phydev)
+		return -EOPNOTSUPP;
+
 	ret = usb_autopm_get_interface(dev->intf);
 	if (ret < 0)
 		return ret;
@@ -1807,6 +1814,7 @@ static int lan78xx_set_wol(struct net_device *netdev,
 
 	ret = phy_ethtool_set_wol(netdev->phydev, wol);
 
+
 exit_pm_put:
 	usb_autopm_put_interface(dev->intf);
 
-- 
2.55.0

