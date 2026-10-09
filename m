Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4A91FBEA6
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 00:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791507445; cv=none; b=M205KS179CDZ1JxtzkUH7+L70mdUqQy64qTJqDlzZcgvtQYuV2tqRte0GsaJxXilMlbzKD0uVsQq884vBjiOz3QUhanvUi3jR2l2aqjjr0aLPXRPYW08AeHW4CrwP5/CpQ2ggsF7c4D1lW8DMRqx0eUyRYXiw0dKrfoc2oo/+kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791507445; c=relaxed/simple;
	bh=CjNYu265Gtz+X7qBnb/UogVrXDtYACULQPTjz9Jr16c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d66bn2UrL7ZTVXW/MeWpVIbaOMwNM7eEO0zIVKeVG2OuDWVOyHq3yO5ma6Ldmhmjv8TlP/dBRDQssAncHeNOWUm6PDSjAumlIzIruvKydJB52kO0QFJdBOuTeDGnSiYFNehJGGTQYF+UfAjxS2iLf35NtaIbF9BFp/5Vdz/U7x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eer1K1dH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eer1K1dH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1688d7769so36839175e9.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 17:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791507442; x=1792112242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vHBweLHo3kgYXnvznsE/p6q6nh/cKN7XIUKJAQEgHHs=;
        b=Eer1K1dHzs1amf2lzjoyeub9OcdxOLBdrZhhx+0CSFKCHpVwJ5D53ztzKjmkQfKozl
         BBGEUweMGOl7Lrye6ibdBhAfzFu/OzSPGpmMPETEqYoOJI8hlM2tylvdmhq6/TjgZLPM
         RdkiwnldD/jqTGu600rqpEskDKM4aDjk68AhYdXzSTICH4+FAlavY95GRCpXhQIvi/6L
         vGMZPp98/XkN93zNVHHn5enNvS9oNLZ5+Ba9mkzpVQ1rGizxa8+pZ8vfxlx+FGilG0nQ
         iKBskNMkAjTl5/ia8h7K6ZHFOL8N6I0L+QKOMqijBZO5kftOSwiV0rjKXd9N0jnzQ/gh
         YoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791507442; x=1792112242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vHBweLHo3kgYXnvznsE/p6q6nh/cKN7XIUKJAQEgHHs=;
        b=LrtYxTfpOAJqng6OF1/rVE6EXGJrYpUfJcSPlT8FFq8yPFr9hw0pfgN63P4SNCwVwM
         O5cH8xKevCkTI3lurQfVFIFCop1kD8ZgGFv313fyrxQ3bUlNJ5diyVJ8cmCcMIAZStEL
         EfMlmFdz9pk81i4h7tXT8JF2oxAYA7LEqPhj+hpb5n5d+xA6hv4SMCvA4h64hPKJWO26
         9+5MzIGFXkuAs1Rest9LQ1vm1sqIN6wiAAtWbcEBExyEibTO9YBgkJwO9lo77q1f1hXB
         ADwOfxlM+cUlxEXIpoxFKYNStQfyVmzuBTUj9nOdim6z3TLnV9ZdOL89FstHFKGAu2uo
         hyAg==
X-Gm-Message-State: AFuF++mWixHIq2vyMBmbHattyTj+uTfUzsEMk+qTz7b/E4evm0oZQXMj
	fdGZuRtrpuWEGvJOxBjnsbsr5ZUmbageoRtjcztKcB33HS9AuDvVnWQUSv1CDz6B
X-Gm-Gg: AYBFou0Z4OVSS4dhx8GEuHtGHsM77CvjwQ65Epbw9hyUOUrBNtvJGhbzyEHJJos6b+S
	DN6TVasFqhmbRDgwJlv1T3NXUDjK00AmAaJLVu8FO8Id5TN7UXt/JP8y5m3loSNX0zcJ4RsoOK7
	QHaP5h3LB2iLzbFWjuPmZqQxHiFrtHHlW5youqipGhZCqlDUX1aoIomWBi9kLoHaViN05BfwIz5
	g+S2bjCVV1uW0XRuO7q0N0BNu5dvFUvIDI+iqd1SK3irDW386YGjSdFJDaC8A8neBTy4Qzht+KE
	vpSroYb/TAtrvCGsRXe8Idx4GL9ctirm+oC1PbIg2qQ+pSu8cfyVHYl7YIF3FsCalL85+9UDWgz
	FPfolbJ63rtWMi8Acp0p9pJIJJ/KwwsPcLtNEP59UAdTvhqAlb/y7YqXoT3/ZvqILerZZLf4Vab
	Sbiu1CKoLv81hbFH6YLas7kRLWm8+0g0DvhMkSdMISSDkuIijTwoo0ibpZE3UAe9o4x4dF7UhXj
	OPnwHvzF7CTNzUVKai6bUy4ydscyYW6uQdF8g2yAMJnC9ZVRLFy8w==
X-Received: by 2002:a05:600c:8b09:b0:4a1:6f78:842f with SMTP id 5b1f17b1804b1-4a18e4987b8mr4207445e9.11.1791507441595;
        Thu, 08 Oct 2026 17:57:21 -0700 (PDT)
Received: from fedora.fritz.box ([93.93.22.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be8c5e7sm30700305e9.4.2026.10.08.17.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 17:57:21 -0700 (PDT)
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
Subject: [PATCH net] net: usb: lan78xx: reject invalid EEPROM write requests
Date: Fri,  9 Oct 2026 02:57:02 +0200
Message-ID: <20261009005702.164936-1-stefanomunari.sm@gmail.com>
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
---
Tested on a Raspberry Pi 3 Model B+ with the onboard Ethernet
controller, using raspberrypi/linux commit bba53a117a4a on the
rpi-6.6.y branch as the baseline.

  ethtool -E eth0 magic 0 offset 0 length 1 value 0

The command succeeds without the patch and reports "Invalid argument"
with the patch applied.
---
 drivers/net/usb/lan78xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5655941f1478..7ac263454d45 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1719,6 +1719,8 @@ static int lan78xx_ethtool_set_eeprom(struct net_device *netdev,
 		 (ee->len == 512) &&
 		 (data[0] == OTP_INDICATOR_1))
 		ret = lan78xx_write_raw_otp(dev, ee->offset, ee->len, data);
+	else
+		ret = -EINVAL;
 
 	usb_autopm_put_interface(dev->intf);
 
-- 
2.55.0

