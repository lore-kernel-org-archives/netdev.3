Received: from out198-6.us.a.mail.aliyun.com (out198-6.us.a.mail.aliyun.com [47.90.198.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1EC34A78E;
	Sat, 13 Jun 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781341418; cv=none; b=mflq/gb+powO1j6p2e8ukQ31qC9MaATHmWxBvbdw9WzR1x6MTG5V5sqH9CyXtrUAWMYvU6P+XFzX8scX3Pnu3AX4ThGpbyWQ1eQSEDXMx8W6LzBsmi98+UIhzJ/9yW2hSN0nj38kh3X3ro3svty2J9B5bUcHAete5uauQPCceU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781341418; c=relaxed/simple;
	bh=+1DA1L0d0ZQaUEn6MpFfOibUMXgSZQsBcriR6mki+vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eP8wNUtBgAYDqKIWMz6sDFIJwvBzvEZSRAV6Cn/A6kfuMBnqz4WEoW+KyVMUo50SK10jWIt80Q6GwrXk/rZi4H9tCW+9re0BohdaXDjI0Dp95mF9Q4jE0g0LRXRew0FlllfSfhLaaMhGKCsDx+6OhItCx218BVso5PgxWiFMngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn; spf=pass smtp.mailfrom=edatec.cn; arc=none smtp.client-ip=47.90.198.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edatec.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.4962601|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.176659-0.00160023-0.82174;FP=7628090403777439464|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=zjzhao@edatec.cn;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.hxCTUHx_1781341318;
Received: from lists.debian.org(mailfrom:zjzhao@edatec.cn fp:SMTPD_---.hxCTUHx_1781341318 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 13 Jun 2026 17:03:12 +0800
From: zjzhao@edatec.cn
To: hayeswang@realtek.com
Cc: andrew+netdev@lunn.ch,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zjzhao-eda <zjzhao@edatec.cn>
Subject: [PATCH] r8152: add vendor/device ID for CoreChips SR9900
Date: Sat, 13 Jun 2026 17:01:54 +0800
Message-Id: <20260613090154.1975753-1-zjzhao@edatec.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zjzhao-eda <zjzhao@edatec.cn>

The CoreChips SR9900 (0x0fe6:0x9900) is a USB 2.0 10/100
Ethernet adapter. Testing shows it works correctly with the
r8152 driver, reaching wire speed (94 Mbps) with zero packet
loss on both TCP and UDP.

Tested on Raspberry Pi, including hotplug and extended data
transfer.

Signed-off-by: zjzhao-eda <zjzhao@edatec.cn>
---
 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index d61074178279..ea1733e3619c 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10062,6 +10062,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_DELL,    0xb097) },
 	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
 	{ USB_DEVICE(VENDOR_ID_TRENDNET, 0xe02b) },
+	{ USB_DEVICE(0x0fe6, 0x9900) },
 	{}
 };
 
-- 
2.34.1

