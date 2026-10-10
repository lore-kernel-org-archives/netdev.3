Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4918C356767
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791667996; cv=none; b=gpHQD/7dKWW/u5hoSjOOAcK4C3TssiBnsnHwlTG/MsgVqYPP0CQffOrSqvgHmwXOwBYGN73KAkv6OkSmt6UxNbpSNM87l3shtRP6x+3QOyKtJWuU5qZ4NseoMdelnVJQs/s88Af44fcgeAJgumQk1rZCQlKfMKHCVS+pchmOleY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791667996; c=relaxed/simple;
	bh=a+sF6iYdqiPAe5xoRZQHhVMgKfMsfaYDg6ekcwVE8eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFtzzcfhe538GEdzcMjTaU0gXiHIhUwnzoMpDrcIxp7/eQcwgF1qykpvVAZXE3vMfQ9ScRzkOcz3Gn1I8S/jJF/YVeLnb+j+irl4prwMvXA1HKtybDsW0vcWnLXmkVS+Op5AtuxUBx5P4hyQXTnQpBZJtaQzpxiOWHjxdda8G2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBdS8jok; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBdS8jok"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so8126415e9.0
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 14:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791667993; x=1792272793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eCrolD5DkHotxeUAvn9zDJ/yLsmWYGf/l2LTc4XvAY0=;
        b=gBdS8jokxcMph9iewasZUR31XmXgdbSGK/8E38TgilaaXtu/nGo5PUyNUIAi8lv1xu
         CyAUCLoTQqiEnizfkkJLkp5e0uCJjzfFDoni7oRxygNvaP4GRHWO2KEgJKfyvwEgYgCT
         l/j3sO1GloDGjzUV4BcVLPEs/jFmd/u1p3cXPC/CnQdWLbl1uqulhxDs02nGDFaeN+8J
         2BA6riTo8lrE6PteAjsHJ3veVI3X2yqbNODCf/YAj0qiXjxaPFz06pTyLHfzCsQRWTZm
         n3SID242nKBhG1/M4Fjp2AxTt0ZQre2DV6VQXJCt/nPYCUR3jM/DTcN8/BwWcc7YI4TG
         pLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791667993; x=1792272793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eCrolD5DkHotxeUAvn9zDJ/yLsmWYGf/l2LTc4XvAY0=;
        b=qtX592iPTIxfSEJ3V9S5q2PRYdH2ZuCPjppylg38CaKa2u9O0CdWgedziPCSXYD813
         /VCev+W8AtniSceUvi/2PgxsB0OxPfzp444npA8yfxRzMQ9LAx7fMVH41iTyEmT8/LSN
         /b2ag8FarYbD2ifz/v/7hUiA+Rxg6QnnLR31TXs+AYoImelxj4snhB9UdJy/OkzITw4G
         MtVrrg6abjg1Nl7g1++3DgxKv09dOf9X3/WGj4xNyJbZekzJnQZjOGzfIf4l98EJ13zH
         mjIo1TKJIj1tX8r4zciMglnCOWp/4xGZyIEYZ2gItNZ2pwRUHvPLm7isCUYl+Y9vspCt
         l+1w==
X-Gm-Message-State: AFq9FYIJzJkWUiH1JobrnNQjLJWsoZlfCIjJVkwjWTzJX+kJV4RvnHb1
	PYu4Ls03DQhZ2LQ/yATqgBlMDpm54bidp0EEybsmAs356XseGNPAC8mHh7/JfGpM
X-Gm-Gg: AYBFou2qhd9N0WIoNi1PZCDxSHtvhct++xy90kxH0k23L1CuR1Rg99i+Fhwbi6FBu4A
	r65L0ArmiGOrFFRmd6DB3M0oRKgIVQyKHi52p9hJO+M/uEwLqotRu6YIJMhmB/m36Rr1ItEHqRc
	zZ6BUH1eQePKFEFia4VXeJOSrdqXR7RBj1lT7OlXfdk6QzYsD3r7w7LIE+WAtbL9soQeoqaVe/D
	09sqFCm8Pz50WdifpR3V3UG/vj9h54Or6ZSXNgS9Bo5Q12bYit8ucZJ2KtlL3YrF/QSPAYPb+AB
	41A66ol+4y8LeVuwRNU88GGghSAS7TKJNROkxQ/CrqLLpNBIZ+ASr93KQuh3CTs1jr8Bsns43mX
	CwyQ1oOXEEheu5FZ3cmphlPJ9MtbvBfhgYJHqZYksiDpwbuw/Q+z3KJ5HTXzCKZR5/7R544mE8U
	wGKAbpEY9nVSmMhqey/V3QppPn3vKnFnonQOeRquP3L103JWVIPZB8oWWPfrXQWVrwPhpg32XmZ
	cBEdJ78nJ2gyhQm2d6+3+yvDjOwthTHoRezUo5joBHI2lwDLTK11Q==
X-Received: by 2002:a05:600c:3f0c:b0:4a1:85d9:13be with SMTP id 5b1f17b1804b1-4a18e498471mr117737605e9.20.1791667993167;
        Sat, 10 Oct 2026 14:33:13 -0700 (PDT)
Received: from fedora.fritz.box ([93.93.22.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a190c49d5csm202787435e9.3.2026.10.10.14.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 14:33:12 -0700 (PDT)
From: Stefano Munari <stefanomunari.sm@gmail.com>
To: netdev@vger.kernel.org
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nisar Sayed <Nisar.Sayed@microchip.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: usb: lan78xx: reject invalid EEPROM write requests
Date: Sat, 10 Oct 2026 23:32:48 +0200
Message-ID: <20261010213248.15938-1-stefanomunari.sm@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The runtime PM handling removed the -EINVAL return for invalid
EEPROM/OTP write requests. These requests now return zero from a
successful usb_autopm_get_interface() call, even though no data is
written.

Set ret to -EINVAL for invalid requests while preserving the runtime
PM reference release.

Fixes: 8a7ffeb795f8 ("lan78xx: Fix for eeprom read/write when device auto suspend")
Signed-off-by: Stefano Munari <stefanomunari.sm@gmail.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de> # Raspberry Pi 3B+ (LAN7515)
---
Changes in v2:
- Add braces to all branches of the if/else chain as suggested by Andrew.
- Add Nicolai's Reviewed-by and Tested-by tags.

v1: https://lore.kernel.org/r/20261009005702.164936-1-stefanomunari.sm@gmail.com

Tested on a Raspberry Pi 3 Model B+ with the onboard Ethernet
controller, using raspberrypi/linux commit bba53a117a4a on the
rpi-6.6.y branch as the baseline.

  ethtool -E eth0 magic 0 offset 0 length 1 value 0

The command succeeds without the patch and reports "Invalid argument"
with the patch applied.
---
 drivers/net/usb/lan78xx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5655941f1478..2fed938fc7f4 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1712,13 +1712,16 @@ static int lan78xx_ethtool_set_eeprom(struct net_device *netdev,
 	/* Invalid EEPROM_INDICATOR at offset zero will result in a failure
 	 * to load data from EEPROM
 	 */
-	if (ee->magic == LAN78XX_EEPROM_MAGIC)
+	if (ee->magic == LAN78XX_EEPROM_MAGIC) {
 		ret = lan78xx_write_raw_eeprom(dev, ee->offset, ee->len, data);
-	else if ((ee->magic == LAN78XX_OTP_MAGIC) &&
+	} else if ((ee->magic == LAN78XX_OTP_MAGIC) &&
 		 (ee->offset == 0) &&
 		 (ee->len == 512) &&
-		 (data[0] == OTP_INDICATOR_1))
+		 (data[0] == OTP_INDICATOR_1)) {
 		ret = lan78xx_write_raw_otp(dev, ee->offset, ee->len, data);
+	} else {
+		ret = -EINVAL;
+	}
 
 	usb_autopm_put_interface(dev->intf);
 
-- 
2.55.0

