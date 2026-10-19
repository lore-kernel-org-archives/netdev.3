Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438598;
	b=oZ8BVb173pDDEDGb8QUjmCUBhPrMAUo6VtoYtQQql8Ae0eSVoFGHk/+uKetStuHv7NRJ
	 2yt8lHvj+8yEv2cGSzywMTxkOhgiRChTmDQCdqmDGXNCK0V6RNKcKO7zl1wVSVOhfwYvP
	 PBojDKin5Lq5HVPrlTK8TRvbdbyM8VZGr0nSnQdtoMgOn34DixBjjccbdKWFmfqgrMbDC
	 18kP3FLYtV0SFjWiqKJXFnFjn/tDo+7vsJR5r5eYmCOG0UQ1n1VJ6cZcI94/cr5VFjhsc
	 ltMmPiam9z3rsnnp73p1+DZGn3J5DEgpIWjZVBUQcAJpWv2hxn7TNeuUqawsaBC7b1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lf4sMTZrdesRxg1xBJVdHHtuRLabPGu8I9i65QyzjrY=;
	b=GAeeqLMMLqLm+WQtWSfrKEVvChM4XKNKXO2FrCyOxXh8/uQ8Xhd/b3iBAsxYC4P9RFA2
	 wKBBa8hTmelwHGXbBzj04BK4K35BdvJ2F2JxAWWw4J6W0x9fx61Y0fi6Sg/4iP7Gv4yt2
	 4Zzqcnez5gGdPkQEPdqxGC6EROlYYjBTXhVdpbpivhlalU7S2LeORDiYhI9ikJSRymI6X
	 4kWGRmdjJQCt9YxaQc08/V19YvKqw4wTlFBVS5eAyWJpO/FhZAyLBkVtnPmqOb+UzHDg1
	 S/vVt6TwlwhgGb2Myppo6Wetcqdf+q95zX0fbzixBdmVHcuNIkxJf24obWwjpqytb2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="U/HBN0Bv";
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE4606A31B
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 19:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3CE4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U/HBN0Bv
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-16079d54c17so5386725c88.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792438597; x=1793043397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lf4sMTZrdesRxg1xBJVdHHtuRLabPGu8I9i65QyzjrY=;
        b=U/HBN0BvWaU1F04M4ZB7fuHGeLstE3cH6i0i5Aff7kz0wTWGyy5VcjCxVeN+FcVwY/
         0a9Uoum5pqXCy3XtG25YcaRgjpn4mgzCfrAglTlaaw7Pd2Dt7Mwxz4FXuhiFnO3S9rZz
         SJiCOuxfJSKtYvUw7VgdGfuLJnENtR4Rtw4pDs4XRbiiUBEgcggE7tnK+TAOx7xiZM6n
         40nyE2ib7dk5POoxMsllDkb1JTihXAYzaHEMv941n8uLrsLkMuM+lWDq49eRUvkfGKrJ
         vAvp7fkVntt2Ds1JE67qoPTdV2HtZPWKsUi7m3fqQVueaDo4fLxqQ4l6dTpK/0keyFHT
         PMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792438597; x=1793043397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lf4sMTZrdesRxg1xBJVdHHtuRLabPGu8I9i65QyzjrY=;
        b=1pJwIj37ASI0nyMg01HcDjOrIi+2FFW129fJ7z+mYWn21lZFP+mags7EmxauL0N52z
         p2y899FJALj5GAuD7gp8i8GZB2DKdeKdAWk0J45mJl/RWMFUmokQKtrnUDFlJHYt5o/N
         QVNeDxyMtONRBza+3Yteivu4uvHvoxUXQCrPcso4lQWfAxAN8SiLYtJYWU8H7+Itynig
         mtodFYcH7rbbu4Od4K1f5G++UweC99wyZsOo3IkKmuPRWJyKmYsLNv68JlmTod6JdrHb
         7PklhvWmt9E5Tq5kuaKTtPMj6KW0YHjsLltxUp8Cgh09kvpR6OI/pwtSxkDgdmZ3Dpmi
         7CMQ==
X-Gm-Message-State: AFq9FYId50/z7tsGGEOd/WODtJgddsL46q1ZMI7sNATIPDOMvsPkmdR1
	kUnGR8UUlE7rycBa5YPWuhgxL+Ka3Zl77rq2n0Mi/JGRbzhRC0KDco8tKBv5iKK1
X-Gm-Gg: AYBFou0gPCvnPtKHtSyD9mhe0ApyXAzNIRc5KFqNujLRGyRKa2iD6mJuW79WTEWtlgy
	lmNFV5QlxcFKNZ6rTKBRouJso8AWzpThqb+UCqOFAF47soBE8SrND+H8PyMPVEDwK6MjZ7aoCPz
	tRGeQ2QoKDbT5IhJbNzKn8SeFpJxgb+6CwgyAWAmMhxY2OQWKNyMnQONcUUJyIUxALBmKn6gmc6
	+ZfGuidXPXzyH3zpvL3MaUqoPHL7w9DyuZLc+H61zrE+FahLgvfbNq+oP3L6/kgIOJ5Tt1LRnud
	5EEgNje+vyWK01WHURH+wb+K1lIWeAMAkLjm67wkOn/T8sjD26gnxsSwNDi3yetr1dKl1zeyD8Z
	pQrcxky0G31ilYyz0dvFyhGAEl4X+sVuatCwbr5QDiEGVXgq9b24S/yH4Hj5/+gM/VchGpmTEXi
	Gbdreim1thpaPoZ3B2X/5Dyi9vYSkzHyxhAlnC/Tliv795Am5QrKfx1QBxrA/mlJZ5NFbrMMTP8
	teQeZHJftiPPAWTKUrfEVU=
X-Received: by 2002:a05:7022:b051:20b0:147:9ad0:cf10 with SMTP id a92af1059eb24-18514cf32d5mr13380836c88.47.1792438596542;
        Mon, 19 Oct 2026 12:36:36 -0700 (PDT)
Received: from arch.localdomain ([2401:4900:add5:70b2:7032:342a:ce70:6aba])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f58c2sm47260509c88.11.2026.10.19.12.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:36:35 -0700 (PDT)
From: Prashant Sengar <prashantsengar25031@gmail.com>
To: netdev@vger.kernel.org
Cc: Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	linux-usb@vger.kernel.org
Subject: [PATCH net v2] net: usb: lan78xx: avoid NULL PHY dereference in WoL setup
Date: Tue, 20 Oct 2026 01:01:48 +0530
Message-ID: <20261019193148.1381545-1-prashantsengar25031@gmail.com>
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

Use phylink_expects_phy() to skip PHY WoL configuration for fixed
links, and use phylink_ethtool_set_wol() for configurations that
expect a PHY. This avoids the NULL dereference while keeping PHY
operations within the phylink API.

The issue was reproduced using USB Raw Gadget and dummy_hcd in QEMU.
An ETHTOOL_SWOL ioctl triggered a kernel Oops with the original
driver. With this change, the same request completes successfully.

Fixes: e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC management")
Signed-off-by: Prashant Sengar <prashantsengar25031@gmail.com>
---
v2:
  - Use phylink_expects_phy() to avoid PHY WoL operations for
    fixed-link configurations.
  - Use phylink_ethtool_set_wol() instead of the direct PHY
    helper, addressing Andrew Lunn's review.
  - Preserve the existing controller WoL configuration order.
v1: https://lore.kernel.org/netdev/20261018151830.643511-1-prashantsengar25031@gmail.com/
 drivers/net/usb/lan78xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5655941f1478..1702f633d42e 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1805,7 +1805,9 @@ static int lan78xx_set_wol(struct net_device *netdev,
 	if (ret < 0)
 		goto exit_pm_put;
 
-	ret = phy_ethtool_set_wol(netdev->phydev, wol);
+	if (phylink_expects_phy(dev->phylink))
+		ret = phylink_ethtool_set_wol(dev->phylink, wol);
+
 
 exit_pm_put:
 	usb_autopm_put_interface(dev->intf);
-- 
2.55.0

