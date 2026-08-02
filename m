Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0712A28643A
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 06:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785652180; cv=none; b=tDyj2VnOsERHnRE8W9o91HHpwdTZNZMnW0OuD41B2SNvCzTwndOTGU4pZO5jVnw6ISpn8t0diB3Sz8nGgqpdfrYXmA4ogFDccyCj5iwjNAcnLAGmAR5azd/ZUXhEC67J2d5lweMLZxbjuvSJ/5gtBOh4kFAlc/z2eBd6wpMFc2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785652180; c=relaxed/simple;
	bh=W2h+lQJkGidGNrRAMME1It/pdjA7OM5p9qeNYRTFJl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZUjwg9rcO5J0djXhULBxqoaK3GaOf/bMMsdmqaP6ckzqkp+UVImZZpRXwTQa8z7o893dTK121LzJMu0OFn7tRPtWS6xkyW44ERu6z95mHYlK9nmwm4SGdKKCUJD3N92rqIOwvtVmwCxoXQAe9VFVhiSNLGw14P6eEY4GkmlN/vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hl5VLjWY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl5VLjWY"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cacb8416a1so22866545ad.1
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 23:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785652178; x=1786256978; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n9MAKt4rWHUHzsXYDtBo+1j3/AQOYJvXcXJiTFW0dqg=;
        b=Hl5VLjWYlUSjTSSITYtLHuBSL2O6ejXzl/oNTfIXqzKSMpAlZKWFWpRVTubAMexbeo
         /6gvJAKOSg8Kk7itucZTHoH9ojqc8vosAiJIqP0x9FzKsgbSDkARlkZViq48rEk+mvup
         P+JcbMd+FL1HB8HKvrzDhlHT+LY/zOc+1zXaj4LIV4IhUAfmvUSCHirUwrbDqyNEJgz4
         52p8eyznKg068tiwTbSpeDNsYZzV+wGxbpogRFLwcvYh1h/1iryjd/Sn8F+fgQlXNb29
         84u8ALUKa6EVGOEtQoAnlIOjzNqLalKZde+5azsxHgybUePbK2rF5nzJ3hg79pZZPY9Y
         YBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785652178; x=1786256978;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n9MAKt4rWHUHzsXYDtBo+1j3/AQOYJvXcXJiTFW0dqg=;
        b=i2yn2T12wvkDPWkAuQm0C+2zi+FiJ6QBqd0WJ0PKp1ISXR1bz5kwNkluAK2P7F7nxF
         r+2Bubk7qX9Q2g/SflcbzpUWs7pPzXO/clrzUFTwwfsB7i0geBThfNXxiQfE3Q31Qnrg
         2gkP+8xttUpalYjeXeCZKrY2WEKcBhaYfHzrE/lJg01GPY3XaXLfM9o3YQkWpxrHQuqU
         sOJwzCkYEA9PBu7kLau/pCnnAsHetfYzQdYLoWZYfbdX+4N4HWXpjM1Xrpr3Qoa7Keuu
         2FsHY9OJuWiUUZ8GvhtDuoDhLoOQQenneQL5hOAZ8H5e+MMCIZ3oAlEan9+hoJg9BVdF
         bYmg==
X-Forwarded-Encrypted: i=1; AHgh+Rr8lrMl53+opOQsE/bDP6zvScXlzpWN5qNJj9BUk4X7mj6ZLD9Ts6nuI4+ZC9QDlSXC4kJTOOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR5YxCyLRAujcdadPxomiIZWUu+RNMLEvPldDfOpHFiAEx1K5I
	t0IFKH/Wu8nq4mwutc1HC+r9f4zbMSOiRbltatQEFOrLJEWm7mrpfP8F
X-Gm-Gg: AR+sD10inkGQNBZUfqqggozGYGef8xGlpEx35whWNZVavXIwOr+x9VSky0A1MBgN92G
	4lzkG0gMeR4CDJZknKcRzMeE43HjFOhyfIq52wd3a7LERQ0p+0bOgaiFNaZpot0VC8ngNvanQ4Q
	KTwohEAVj8bzBSOAlXINb+5Pm+Sr92Ks5InxrfkReTWT/91icPgJR/6UQuoMRwOmEQeIz2UXbc9
	ey01vs6TuA2e4a0xmO4/yYx+xBa0Dhu8a80y4GtT1JUzzwy6Q1bxywfNjnS9MmnyaYngTunUPG3
	xewZyHy9MhfsMDTjXw9vkthGY5p6/yL3qvw4C87sYyx/higy8Yy+K2nfwvzP0WX0kxjZLt4NCHX
	4E2ZOYrqm2NZeKHVbaVvSdxJ4TgPk7605dSecDDUXpZAm4bdHt92OTnP6NqjcswGaWbx2EggpVd
	c4gO+zAxX4kfcm7qFe9HObZv1cE+9AGKae0Nd+1SUCQT23+RzOCWZPe89AhQ7WMHfJm8QF+kmR1
	A==
X-Received: by 2002:a05:6a20:7f82:b0:3c1:d78:6457 with SMTP id adf61e73a8af0-3c92a796742mr5995213637.32.1785652178272;
        Sat, 01 Aug 2026 23:29:38 -0700 (PDT)
Received: from [127.0.1.1] ([2404:f801:8028:1:1e00:d9cc:7c6a:c60f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e1886e7sm26969346eec.26.2026.08.01.23.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 23:29:37 -0700 (PDT)
From: Subasri S <subasris1210@gmail.com>
Date: Sun, 02 Aug 2026 11:59:24 +0530
Subject: [PATCH] usb: atm: ueagle-atm: fix array-index-out-of-bounds in
 uea_bind()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-usb-ueagble-atm-v1-1-340f085b04aa@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMPjbmoC/x3MTQqAIBBA4avErBuwISK7SrTQnGygPzQjiO6et
 PwW7z0QOQhH6IoHAl8SZd8yqrKAcTabZxSXDaSoUa0iTNFiYuPtwmjOFUdD2pF1ddVqyNUReJL
 7P/bD+37oDALyYQAAAA==
To: Matthieu CASTET <castet.matthieu@free.fr>, 
 Stanislaw Gruszka <stf_xl@wp.pl>, Chas Williams <3chas3@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Morton <akpm@osdl.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+92f5bf49bf4ac75223ca@syzkaller.appspotmail.com, 
 Subasri S <subasris1210@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785652174; l=1353;
 i=subasris1210@gmail.com; s=20260709; h=from:subject:message-id;
 bh=W2h+lQJkGidGNrRAMME1It/pdjA7OM5p9qeNYRTFJl0=;
 b=bYH0tFfdO3Yg0q0KTykVH5y6JfEaEjoGUvyjOG5ioIBHfBp8wBtf0vM/WXDyfGyZMDbFevx7/
 kqY08IvHH/YDxLbqMEqH6EiR08J5sZtr9KstuRZaClgOkyM+k9kAdka
X-Developer-Key: i=subasris1210@gmail.com; a=ed25519;
 pk=6C4wavGFy/OsR8yQQKNWuDXoYPHp2L3sfgNfyzTruTk=

Add a bounds check on the global variable modem_index before
using it as an index in sync_wait[] array whose size is NB_MODEM.

Reported-by: syzbot+92f5bf49bf4ac75223ca@syzkaller.appspotmail.com
Tested-by: syzbot+92f5bf49bf4ac75223ca@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=92f5bf49bf4ac75223ca
Fixes: b72458a80c75 ("[PATCH] USB: Eagle and ADI 930 usb adsl modem driver")
Signed-off-by: Subasri S <subasris1210@gmail.com>
---
 drivers/usb/atm/ueagle-atm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
index 4266a0cb7e3b..61723e7ab351 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -2463,7 +2463,8 @@ static int uea_bind(struct usbatm_data *usbatm, struct usb_interface *intf,
 	if (ifnum != UEA_INTR_IFACE_NO)
 		return -ENODEV;
 
-	usbatm->flags = (sync_wait[modem_index] ? 0 : UDSL_SKIP_HEAVY_INIT);
+	usbatm->flags = (modem_index < NB_MODEM && sync_wait[modem_index]) ?
+			 0 : UDSL_SKIP_HEAVY_INIT;
 
 	/* interface 1 is for outbound traffic */
 	ret = claim_interface(usb, usbatm, UEA_US_IFACE_NO);

---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260802-usb-ueagble-atm-ca29d2bd4189

Best regards,
-- 
Subasri S <subasris1210@gmail.com>

