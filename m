Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474643D51D
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611200; cv=none; b=WsuI1MR76ijr7+Ggbhlu1bqs6uOl0j34LB5kAmcol40XG1V2OskbGlR3EArN63nzA6XwPYqiVzCHb+YbcZqy7Q1A90Lbpriqz+ByXgrIf03k2Esu44lnIFFCvJ/CqiPbGxV5vtUG2SXFnDla9WlOYvH16n2n3U4MikSZF2+dzCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611200; c=relaxed/simple;
	bh=DYUbdvenDke6Pecf7dDg4dsBO1m0sYEZ71/2/zui9Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A2iuRozW4dAu33ZHzDWyY3b7m0CweCSvKxEiUefKE3BTn/Um4F4Q9OUSEUw4a0t/tWj1yhjd9Fga0MNbKDRBoihXiz4drsC5wHfpef9JTtp2/u4CNMqZBpnYbAdp0AnH1AO2awWPCfHstJv6J/HaxKfkezemADMDh/ORQtow5Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTIDxqxy; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTIDxqxy"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c858cc9870aso2063184a12.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 04:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781611199; x=1782215999; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Hfd7o4l5KeyggBUdRXVUs9FUkJAGIoK0YPViSvNbm4=;
        b=TTIDxqxyQIIyKMRG7lF5sNLs6fEmTiBBlL0kEAabjtLgZ8t3owGEofMxQAu9j0wcEw
         RJIxUIxmyhWsjheElObH5h38sKR0VTWvvJapuAa5QBHUc9NFWbRrneNX5T0rrmGOrw2W
         R0Qs4Gc/Kp4+6roZyyBpMpKrPnw3x/bPbRT0pOJIPfQwdsLolfW5GZqkGlPCuhK0vpOC
         9lfiVezky9Icgy4FT/zpzkRG3YWKekWSCd535pzoYV4BlPqYHCxwYc9Bk+rhZ3gX7Uim
         ussz8w2nn6N0w1Ra375Zh3e+sFCbW7CROJv2tP1a4TKQAVIkRou157nZgB16s4Oyqv5J
         EW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781611199; x=1782215999;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Hfd7o4l5KeyggBUdRXVUs9FUkJAGIoK0YPViSvNbm4=;
        b=NiIw1ffV6x2r1EjV+xJW7rNW4lewmX0SGuHZhePgsNwP9D8zcRLH4EjSBdYYT8cT5f
         ucjoleSAJfhzYsKTgiwaTBUu9frgzoutYZq0wF8xfsB4zyzM1pDEtaWbP25knYo8GdnX
         xqTMLYCmyS6/1U7GMO86RwNFy6YtfDvrxoVI+xD2RixKVyXFIwIzUwJiNk6WjEQUixZf
         AUd5MRpzuLXjkrtOf0ULs0KUxBSuTkKgelCiob4E38Vw/GeR2PD++s+/+ov+eXsvh38x
         Dp5CIdz8s6GFxXY1S8zxpXSEs8QzKvWgCSWMCxpkbbhC5NEXE/V9CeZAfqy3nPsWrvFq
         00cA==
X-Gm-Message-State: AOJu0YxxW/lnTAFPVc0pl7OFpstlUsbKyQIO1rFHCAMs9c5yWq/VyZ54
	13O6xdCCgXPtV4L101SndTTJsEjL2i6+Da6tGnPlAAa1nWgLlXvwF3s42+fB6ZNznLa3Ig==
X-Gm-Gg: Acq92OF7Dl7e5plcbbMSSP9MKJcgmO8KAwaaCnMVLfDvmEs9Iz8dvAQvbOQI8HrK6MM
	BYhveCfQP3n0lFWbP/Ssz4E8I2SJLUsrs0YVuknFwqlbp7U9Dc8WQUg4kRxrlJPM2ptzwE88qX5
	GWgnKfjcgLxC7t91NO7sDvv1q5L/k6LvMn/kn/DPgwPk73qgK46cMsA3nPERzB6rJGNbruxpEnJ
	3xci6JYrPgGPJIBO2sH9RW6rp/5GTHsKSjbqquHQFbrHcrZ+9UjpXD6GwSRsJ/JJiEEROao+KK4
	6MkuXyq0a1+bkpJCmhSpQlFfD1ocs40oq0pEGEQoBx+b/rw7CUpKm/KEp4TSCo6HoLgOwcq/3gh
	0o9UCDvVYBVZbSH6olqVaEdfmhLsUX69GQ1IrNxTQKOpk+6+zZ1zOmW/lAL6TNpmVXZ7e0ETh9z
	n4jjSuLSN/T1Ie9WSK
X-Received: by 2002:a17:903:1b6c:b0:2bf:13af:b077 with SMTP id d9443c01a7336-2c699b03448mr27431115ad.14.1781611198834;
        Tue, 16 Jun 2026 04:59:58 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433369c8asm133468595ad.73.2026.06.16.04.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:59:58 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2] [net] net: airoha: fix foe_check_time allocation size
Date: Tue, 16 Jun 2026 19:52:36 +0800
Message-ID: <178161119471.2163752.14373384830691569758@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

foe_check_time is declared as u16 pointer but was allocated with
only ppe_num_entries bytes instead of ppe_num_entries * sizeof(u16).

When airoha_ppe_foe_verify_entry() is called with hash >= ppe_num_entries/2,
it writes beyond the allocated buffer, causing heap buffer overflow and
potential kernel crash.

Fixes: 6d5b601d52a2 ("net: airoha: ppe: Dynamically allocate foe_check_time array in airoha_ppe struct")
Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 5c9dff6bcc..8fb8ecf909 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1578,7 +1578,8 @@ int airoha_ppe_init(struct airoha_eth *eth)
 			return -ENOMEM;
 	}
 
-	ppe->foe_check_time = devm_kzalloc(eth->dev, ppe_num_entries,
+	ppe->foe_check_time = devm_kzalloc(eth->dev,
+					   ppe_num_entries * sizeof(*ppe->foe_check_time),
 					   GFP_KERNEL);
 	if (!ppe->foe_check_time)
 		return -ENOMEM;
-- 
2.51.0


