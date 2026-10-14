Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43E03C2B80
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791949030; cv=none; b=j8RFOu+N5sW1TE/XRYpUCM+ghjK3sR+XryRLbzdxH2SGV+ZTo6gZ1G/6u5d4Oce05LId1KVZwxY0hGZY57M2dtFfCyXeFdEcl53tsMtsqqU9GTkp3KsIhhPDaR2Wlj2xgrLidKrSaLWKZzQA8IuFnwhFIDIO4+XCpQIvg0jl1pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791949030; c=relaxed/simple;
	bh=n8IRbG2adU+JHRw1Weh0pyhEWzLZHxglbxo0UHmAemo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D1MDV0/Uw+c9JLAeeD1pbLF3vsCndcL1n21v9IflBgmtYggCsaxCp7D8+nlJZJNV/ViItcXAMDf+2FhOiOMkfMzPypnrROFp2Hh/Sf1YYGVF4Lwjqy4AUpdVNnsqS45LrwB5n3C5YCeR0ZsAQCZhUcMbbWKE72A/kY4SjNLfR34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gn4WCkAl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn4WCkAl"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48c4649b35bso3341486f8f.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791949026; x=1792553826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Erqpv2udLqd8NtJ/EiJJ9aOeRqNutr8eZmBOOfX9tK8=;
        b=gn4WCkAlALhlezF9t0NC0YMHVPbIt1UyEz6nWMEe/HmbPlLpTDVve4LAUttxzcRWtj
         /l/BLQuxWo5IRgV5kar8NOWtBrpmXk6vgg7dtwOx172+vm4ghzKSn3KVrX7wow0LmQHR
         wIU/IdRqnfKXPLkNgqEUZBX6qP9Wfe23/Ih91rV9H/z7YwzxMU2Q1f+ZEA8YlLOrDUI7
         ldYNMyQXZiutUeAfYC95CLO5o+VpJeQU2fAheyjPddLZebEzTKt48ydNT/cTlgwl8xrs
         IwPtT2K9zzxYFF7SR1PIxIDolc2Nn5QBHF2iiA1om7Tus8rSwvAa1WXSqIFbJkWhAA18
         GTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791949026; x=1792553826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Erqpv2udLqd8NtJ/EiJJ9aOeRqNutr8eZmBOOfX9tK8=;
        b=RbIicN7gbBy5GZ2HcOj2oz6JPPa3Bpeawjwa0K3DtUBLBEMx+ZarV19u0rCj643wis
         4ibfnivYFQQOkw/FL6szx4kuk5z8bCDkObbtNk1JXQGmmKJ/bhCQjoXWNgwu1yobXrg0
         atRXNmIZLXROywVCc4uGa9IfAuuI4kLh2oy8gEmXKMTsgvrb+i9euv3H8PBgs2pa+kKM
         Mx810PywbONaJu3kjsh69dfaOnuo2dyA75PEPZZDjC4n5bDkhqWS0W9/N/3C76hfTN/6
         88W8lBLmx4Uj1RrYe+gVgueVDRBIkyOdGRKN6Y1OEtST3FCo230QOJztOBLhwzW8/hqU
         yQxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUYVxzjwTp+F91ZjH0tIk07i+vynzYWn3IRyvhEZ0V3xnF7zJ2iWx5rDP7NZdghg//kSqxewo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDHPfQINA8NqRXPKwVsaHivi4dGBK7BGh54tHJkxpARjaKgeqI
	MUM4RtLZctZi+lHV3Hjz0d45j0OTME6CqAJJLpxRXiJopOQP7VWTp9d9ys9akfzw
X-Gm-Gg: AYBFou0fEqrAG6Poj8PBIteERNhBtW3bbXAK88s1Oqtm84WbolSdaeuc3XrGRB7PE0P
	cIJvhPrzoQiW8yHb5EQhmFRqqE0w5umFM5goaqI/6vjVen0uSQRCh0ETNZNAfPC89tr+60lrI6G
	eiOkooVHM52bXsQHe1V2lfe39LRUwSX2ILFrwA9WCMbshCZB5pSEEFM1VlDICvmOP+W+h1lBQRn
	tfOb/Pxp/r70ueZhixVD4SxcIOssxeReDJOg9SiBZ8Ub+7zf44XrmO59wI/WZMrQX4FGW2+TG4G
	QNPAAshP2ie6GpvDQZByu03ahuBiUBXUTg47RWOb6hLX12jkWbCOUDatseoVWniDOFFnVkuXUJb
	E3B1rg0MrtF1fxN9tcYhLDxCdfIuWvYwaKgXbX2rh6rRrZ+aD01yDzsaPeUMuni+K/ndnxbzsvS
	c9sgROlm8d3n62Y7wy1UYJiB1scKOE0afcqffzIdUArMuq8ChBNG9kKDJD75+kDT5UR4hP7G4Fi
	pobQ+hAf3ENTUMLMXu3GiVfeioMqF37GZq8/kSYrnmg6XHYF9OxgjhbB//V6OvSqROFvjY5Ki3n
	mwnIiZ9LPJ3gXNJTM1LZpZJAnQtYN1/3FJyP9X3AL0XrXl6KVWxnvDV0QUca/Cm+yYUk6Iimh6R
	+ejhOOJCcgMM=
X-Received: by 2002:a05:6000:420b:b0:48c:a08:5858 with SMTP id ffacd0b85a97d-48dbaae6fa0mr26214747f8f.23.1791949025961;
        Tue, 13 Oct 2026 20:37:05 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0fb-5301-0850-863e-3c16-90b7.310.pool.telefonica.de. [2a02:3100:a0fb:5301:850:863e:3c16:90b7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc6b82sm9066614f8f.51.2026.10.13.20.37.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 20:37:04 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: phy: realtek: restore RTL8211F RGMII delays on resume
Date: Wed, 14 Oct 2026 05:36:59 +0200
Message-Id: <20261014033659.95196-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RTL8211F-VD loses the RGMII TX and RX delay enable bits across a
software power-down. rtl8211f_config_init() programs these bits from the
PHY interface mode, but rtl821x_resume() only clears BMCR_PDOWN and waits
for the receive clock to stabilize.

On a BeagleV Ahead configured for rgmii-id, carrier and the negotiated
speed return after an interface close/open, but the receive path does not
work. At 100 Mbit/s no frames were received. At 1000 Mbit/s all 11
observed frames had CRC errors.

Program the delays again after the existing resume delay. rtl821x_resume()
handles RTL8211F and RTL8211F-VD, both of which use
rtl8211f_config_rgmii_delay() during initialization.

Tested on a BeagleV Ahead with an RTL8211F-VD at 100 and 1000 Mbit/s,
including close/open without a link partner.

Fixes: bb726b753f75 ("net: phy: realtek: add support for RTL8211F(D)(I)-VD-CG")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Hardware test results on BeagleV Ahead (RTL8211F-VD, rgmii-id):

                               baseline          patched
 100 Mbit/s close/open         RX silent         pass
 1000 Mbit/s close/open        11/11 CRC errors  pass
 no-link close/open, reconnect 15/15 CRC errors  pass

The patched kernel also passed bidirectional 1 MiB SHA-256 transfers at
100 and 1000 Mbit/s and eight consecutive 1000 Mbit/s close/open cycles,
all without RX CRC errors. An s2idle suspend/resume test passed on both
kernels and did not reproduce the bug.

Built with ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- LLVM=1.

 drivers/net/phy/realtek/realtek_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 177b62a7b..c867e5213 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1375,7 +1375,7 @@ static int rtl821x_resume(struct phy_device *phydev)
 
 	msleep(20);
 
-	return 0;
+	return rtl8211f_config_rgmii_delay(phydev);
 }
 
 static int rtl8211f_resume(struct phy_device *phydev)
-- 
2.54.0

