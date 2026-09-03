Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6A4FECD8
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458454; cv=none; b=NJHl7VBeKlLV6w6UOhUgD9LIXN8oJWuH46GsgfUeU4bW27IP46YRnliSeXdaNuF735wrHxzzVMOyQwIqpq02Xb7JMkmp+wNXaOSsd3oqejM2K5+AT6m0WAwDNIjlzcxJAiZLwEnhbtIeKFbnurq7gWJ/l+3DWrBSbX/wkaRsfVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458454; c=relaxed/simple;
	bh=FUL13PMBpdVmvGH7sOikoOUHQ3Zugr8TJXZNx3GBI6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KxmOdqDyhieZUNyxNhmf8GDquJmlhZLjXos50k8C7AZTch1aaY5oCKWHz1UKTmRRF84TcjLpHwTHihKuYtuoxl4ESoy3VtbfMznyV2guMeGnqtJOsN2v3jjiCbXhe9sy+7o0llW/GtYG7BlO44INlSmhI72CtmmLJfLdN7Qm4p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJB+oWgj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJB+oWgj"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c255c58156bso11807366b.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788458450; x=1789063250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FwSW+L2fi24nBq8MzlES78JQKLNoN9Kx8+uKI7PoLRM=;
        b=PJB+oWgjkgFPu6bTH4bxHFU52RTzVBCFb6CuWD5H0XiSgy7na1GNnjn1tj3eATJpxX
         +XkgKishLg906MVxB3MrlKqF4CoLTzLNnhIcV9LMDYpFii2M9KN+lSvcE3CzBLuAo+90
         b/j0SbXktVeCQWUkv+AYYICRREzQF0XiNEN4q8O44pZBzZ81PcpKae4uf51wdafQxH0s
         qHMjVcm+ZlNPtRc07KAPx80fxFMtuDkdwiD8G0faM25qmusQ2XBYFSTkS7FV1vxxrwIn
         r5q4UugsZMOH4wswaUxvgeSooVjVy9lyAqTSG8Z4ByzE7Lu0eU4qs3nqjAz6mlhy09jX
         sTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788458450; x=1789063250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FwSW+L2fi24nBq8MzlES78JQKLNoN9Kx8+uKI7PoLRM=;
        b=iCtp/tqGZIqJznE7PtDGT86cnu986TNVazIUmEgqU4oDGBZ3/WIlq3/D+tVECS3Rgz
         yLgCDckYHlb6pYXCS8V3zJLyf8IHYHBoJL6jSSKxyBJaaLPA0Ir1JS7OQM1xQrAcckx8
         KPxK0jL7IribI+0fJNwe9+QLVe364vq1+cDgGhPkObz95n0TvkQMBE7d2AdZxswZR+3o
         xYjNgvdLAMUfH6eB+VJ/hW0EnCzyOYPK1uJeAvXcS+yfvM8MRp593E27KyWEfz6d/l2/
         KhEL4pE9sdz+HqhvZ0POuw6gWcx/TUUE/S8rX6baQZXLD9XvQ7nUdrB2i0gtQTDE5l0o
         YOHw==
X-Forwarded-Encrypted: i=1; AKwUvBxXZlxQ8PXpQjlk5XRzGzbACLuZmSKAyGGH9ZsDR8jNie0uBe1H3HJ4pGtk/iKrr9P+YhZDH8I=@vger.kernel.org
X-Gm-Message-State: AFuF++nnHKtygTagjTrenIzPjithu3kMRyf+r8slX2/xbjWhyzXqXqwS
	WRCk4rH8JpiDWqVDanF3wZyXAX8kZYk9vebcEEsdJruVy0QqoALnZXzz
X-Gm-Gg: AYBFou31O94FRO3taESmYvrPFLiFjTTZo0ZjSkJ1z0k0akSOKOA7iHyn2bWkc/MtrNW
	j3HBzV1g4yK9wN7R78VakwmugwWj/ZfRd8v2KNhrHSUOZQC+qwKpiSs7KAJt/AKJdYWj4dOZMro
	dyzrWXTsIUx7YcU7Zd9XUXKnyQs6m2bI6u8u7ScYU5tyl1fLWCRvNYYhvW9VOOKFLtDjNamyUGV
	ZaYfpucvlcQbygES2qILZUZdCpKr3+oSKJICR3B5dt4g/Mnh0sYCgrPoMMs0KyPKgs1VZDp0YCM
	GbP1KABi1Bo/Wv4yFkkyWpXMagcqA4t9wZ/Df59Atj+xbbMrHReGEqyP5tYgxNS/VSxHndC+WBE
	uLlVI65pOhDGJmaPGTqu7PYSbNWgKtl9FxpYXiy+a73qjXb9aY2L7YV3e95IevvvCoSeuTxg6xw
	XMW1/koGBuc3NxNC0SE4Os3m246zXRLBmLS/+wHKCIlLaDhnP8+3jnPENDrTiZGCHUD0peYA6TW
	ICOByo+21Ft2Abj3IoisTiaP9YljZH/tNsrCgyo23y+l4tnTrwZ2vsu7gG8gJP3CA==
X-Received: by 2002:a17:907:7a89:b0:c21:8c6a:c680 with SMTP id a640c23a62f3a-c260ca21e53mr28157066b.22.1788458449738;
        Thu, 03 Sep 2026 11:00:49 -0700 (PDT)
Received: from localhost.localdomain (185-130-167-72.kund.ip-osteraker.se. [185.130.167.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d581f51sm3362166b.42.2026.09.03.11.00.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 11:00:47 -0700 (PDT)
From: Sebastian Sjoholm <sebastian.sjoholm@gmail.com>
To: bjorn@mork.no,
	andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Sjoholm <sebastian.sjoholm@gmail.com>
Subject: [PATCH net] net: usb: qmi_wwan: add Quectel RG660QB
Date: Thu,  3 Sep 2026 20:00:44 +0200
Message-ID: <20260903180044.6179-1-sebastian.sjoholm@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Quectel RG660QB 5G module (USB ID 2c7c:013d).
Its QMI interface (interface 4) uses class/subclass/protocol ff/ff/ff
like the other recent Quectel modules, so match it the same way.

The remaining interfaces are handled by the option driver.

Tested with an early sample of the module on a Quectel 5G EVB connected
over USB 3 to a Raspberry Pi 5: qmicli talks to the module via
/dev/cdc-wdm0.

Assisted-by: LLM
Signed-off-by: Sebastian Sjoholm <sebastian.sjoholm@gmail.com>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 8178a8758..c940af5b0 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1084,6 +1084,7 @@ static const struct usb_device_id products[] = {
 	},
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0122)},	/* Quectel RG650V */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0125)},	/* Quectel EC25, EC20 R2.0  Mini PCIe */
+	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x013d)},	/* Quectel RG660QB */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0306)},	/* Quectel EP06/EG06/EM06 */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0512)},	/* Quectel EG12/EM12 */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0620)},	/* Quectel EM160R-GL */
-- 
2.43.0

