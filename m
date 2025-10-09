Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784CE23D7E9;
	Thu,  9 Oct 2025 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997364; cv=none; b=XAC7Wb0/2jH4LnrMpz2AdmpnP4CREENCUuuzVa0pwnOLvdIHQIWTlr6+2JQPxax14NVESgOGTGUccybcRU87yv6waZpPcj3gHrRGRsYiY2f+jzV3LJ209H5xYKloIw5DfvjhSmPyusw88DchMWvPXqTAzCKBP4RXzOBzOtpMPnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997364; c=relaxed/simple;
	bh=lDZY555VyG2ZqI0ZJVFWRw5xBqogAP/R7f0EKirM6L4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LyOvlOswJaH6CNFFBh+kYP9WjLht5h3PxAYOdondxOhjsN7ACAzuDC0kv99wa34Autqh84tLJcUe3VqFtEcEjKAP6nMK7rSgy7HBTmIwK5P53F/uuC0B8ANW4h0cgioI0t6CSwkcVYdBMkyY1euX+CKHYzOd7xx0KeRh20mp5Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=m2CMYy2J; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="m2CMYy2J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=iM
	PohwgpGN5xynczWnS8lPXMhQaSiI0oueolZwZG0kc=; b=m2CMYy2JHAzfv3E0uB
	le/6MAs1qno53PuVSFPFzVhUcJftOEYUgcORqfxBlF0qLNij4bZKJQjQg9cBR+Or
	KzyxLNaomA3pYeAUJYoWwca0Iyu4OpIip3x4Rxi6TJ+AfFipR055Swp2gHDezQwe
	SfHuFBigC2TDVEytpwYUw2e1A=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wC3J7Ara+doozAYDA--.51674S2;
	Thu, 09 Oct 2025 15:58:35 +0800 (CST)
From: yicongsrfy@163.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	oneukum@suse.com
Cc: kuba@kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: [PATCH] net: usb: r8152: add error handling in rtl8152_driver_init
Date: Thu,  9 Oct 2025 15:58:33 +0800
Message-Id: <20251009075833.103523-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3J7Ara+doozAYDA--.51674S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWrGFWfur1UXr13tFWDurg_yoWDAFbEkr
	yIqa47Xrn8uFyYkF15Wr4avrySkFs0vrs3Zr4xtasIgw47Xrn5Gr4UZr9xXr4UGryfZF9x
	Cw4UGFyxCry29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8LID7UUUUU==
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiLATh22jnYnTn8AABsd

From: Yi Cong <yicong@kylinos.cn>

rtl8152_driver_init missing error handling.
If cannot register rtl8152_driver, rtl8152_cfgselector_driver
should be deregistered.

Fixes: ec51fbd1b8a2 ("r8152: add USB device driver for config selection")
Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/net/usb/r8152.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 44cba7acfe7d..a64bcb744fad 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10122,7 +10122,14 @@ static int __init rtl8152_driver_init(void)
 	ret = usb_register_device_driver(&rtl8152_cfgselector_driver, THIS_MODULE);
 	if (ret)
 		return ret;
-	return usb_register(&rtl8152_driver);
+
+	ret = usb_register(&rtl8152_driver);
+	if (ret) {
+		usb_deregister_device_driver(&rtl8152_cfgselector_driver);
+		return ret;
+	}
+
+	return 0;
 }
 
 static void __exit rtl8152_driver_exit(void)
-- 
2.25.1

