Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCF2238C36
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 04:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785903891; cv=none; b=kRFeAbHS1iVGzrJ4X8Nac36T+J9QdiS9iksDM0eN2l+q+IcZqXb5l1GaFB8ijC8YrP02byUXqJ6Zz2muaXYvuSq57Rth+9VBaoCWujJHSwLk9619WMcH2PrTzGr+QNhmXIXC5WA+7ARpXGLPEJtf291DGZq7VJykcOmRZ016v4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785903891; c=relaxed/simple;
	bh=BkKPJmVHyb+jgnlH6d6TKR0RXMa70aeLG+hWcgoOaWs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D9C9qZJwHToBbCDDqZJqIPcGECrhEBngSUnSVkL1gIQgR+mdmtMzAG1joY81btsNqxF9CUhKgl61vBW54KVao32mLsPuHnzsalRJHRmxnklSzX1eGsMIKDR2oiY8ov5dBHaES4oJiDeS5jzJopWr70TcnnSUpflQP4kL0xR6Uhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhiAaKEO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhiAaKEO"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caea3f742bso8588335ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 21:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785903887; x=1786508687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cwRdoBc/EmK1WOPOfn5hh+h3aMhUdxfVRSZXe1BrYw8=;
        b=VhiAaKEO5+W8XeFiGGsAoJSEdRAYFavmXNNXoV9J0MHoip5tQixuDgSEy9iW94Z+SZ
         OF594leeUS8sH5FKiOEumNkemApXZs0qA1RIAm4NRBVZL5ADEeJeGKGjj0h9XBlu0HsG
         YI3cnWlxuzCf5usIm5Fb60glAwr4M//aYsUTu50TOZEhREACdinHqr+EQjWLqGFpENdG
         s0+99sK1a5fy35pXiHolhFhIaoUo+20bcupBM8aSHaxMHAVuIgWno3hb40GvNkZV11+w
         JIpWGTXuyQDHjs6+ka9gBYAzHbeQ4lU4HEZVgtQR6g8YwmmMXaSwqfQGHRjfbkjNozzY
         SkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785903887; x=1786508687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cwRdoBc/EmK1WOPOfn5hh+h3aMhUdxfVRSZXe1BrYw8=;
        b=Xcc/quvU80oDGPK+ZcMaLbZLT4xNKVUWF1N1TlpFVa/5CT4wMJUPLx6YrBD+LzWFiU
         8sgZgpKJt9kBXKwCLUJCue1F2rS5GfmzuVb7gSdLrsTBq2o7BtCZyBfxjj58R/mYCbEK
         3+NztzbeInk6sqJczFQjZFFL5FxM6FfY0qW0tOfmXRU2fAGQVZnrbTeufXFGd5qL5DPX
         lV6wyN0aZRMUl0vt7vUwpEYfXiBUWF7+/F6h0DRGkFgR7w41sHQt1Ih+4/xyqA3LJRaL
         jOkaRkj0S5gXsrb/yzVapQr1uxlGVU0YPJ27Tw0ngv3+eXBRjKNhpnjV907lOiYq7AfP
         S6iQ==
X-Forwarded-Encrypted: i=1; AHgh+RrC+smVtAbZaZhun7k1Ix/nkEougCR0U7T28okF6N2kP+FJzchIvo3Kz7gnt6WgLHEMx8YxRFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWAUKVT1gVMuP/DoiCZ31jtNLhfJJzvw6SP/i/bzW326sDlt0e
	xtrKvzKRjbQJA+VoIrJijHEww5bxV8vA+C6GzEjk50ON3TMEhjhdmL+B
X-Gm-Gg: AR+sD101qZ6fp3KclsWvdSurbe+Q+In/GxYXzopF02rARCidUwsVPI98/W+ujDvxPwm
	/XbLJv5ibHWfJsiBlmbQvYE4JTGPiybUz1NlUU5RABMUhth9sL4hW9yv7TmeIj8rGWL4h/HqUPC
	yZhYF6OcuuHOoged3daPjJfoJMxWQjRbaxIG+MqeUasfJNdxXcWrMnW5Qp3MCrX91E3j+UkAyr1
	OjKPNMvenaKcSolCSPrRVY7nV8A4kwVhRRcV8t4Z0uyleJsRRDTYuK6n/7XslVUfrSFgyDEs+Ax
	wJRgGu3H8IsyS/zZ3WGZFVXYBk15IY12Lq9aiXIoXpAtIVDO3gXfGJ/2nsInMwwbMe/6dfEPFKV
	YI2ViP/t4HYeKinjinFwRx9moV1GcHth3ECapo4q2BGFZHPX5pr4ssvhylyaOfQ5bRE494/XMxg
	OO0D9BagRO2Oas+ZzJQSDKv0cj3GXnXOW0rkACK8+t+Xdgnxt6xbQZwt8IAA2eHy6HxhZdNPucr
	/StbUdzHRN3jYnBR0L8jOuc7yA=
X-Received: by 2002:a05:6a21:50b:b0:3c3:8aa8:6caf with SMTP id adf61e73a8af0-3cb85efb72bmr4598957637.27.1785903887193;
        Tue, 04 Aug 2026 21:24:47 -0700 (PDT)
Received: from localhost.localdomain ([152.59.182.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673b7f4sm11815957eec.17.2026.08.04.21.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 21:24:46 -0700 (PDT)
From: Krishan Singh <krishanmohan298@gmail.com>
To: linux@armlinux.org.uk
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishan Singh <krishanmohan298@gmail.com>
Subject: [PATCH] net: sfp: Fix memory leak of hwmon_name on hwmon registration failure
Date: Wed,  5 Aug 2026 09:54:35 +0530
Message-Id: <20260805042435.194101-1-krishanmohan298@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hwmon_sanitize_name() allocates sfp->hwmon_name before
hwmon_device_register_with_info() is called. If the registration
fails, sfp->hwmon_dev is left as an error pointer while
sfp->hwmon_name remains allocated.

Later, when the SFP module is removed, sfp_hwmon_remove() is still
called. However, it frees sfp->hwmon_name only when
!IS_ERR_OR_NULL(sfp->hwmon_dev) is true. Since sfp->hwmon_dev is an
error pointer in the failure case, the cleanup block is skipped and
hwmon_name is leaked.

Fix this by cleaning up hwmon_name independently of hwmon_dev.
Continue to unregister the hwmon device only when hwmon_dev is valid,
but free hwmon_name whenever it is a valid allocated pointer.

Fixes: 3f118c449c8e ("net: sfp: use hwmon_sanitize_name()")
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Krishan Singh <krishanmohan298@gmail.com>
---
 drivers/net/phy/sfp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f52020673..f605fb399 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1895,9 +1895,13 @@ static void sfp_hwmon_probe(struct work_struct *work)
 							 sfp->hwmon_name, sfp,
 							 &sfp_hwmon_chip_info,
 							 NULL);
-	if (IS_ERR(sfp->hwmon_dev))
+	if (IS_ERR(sfp->hwmon_dev)) {
 		dev_err(sfp->dev, "failed to register hwmon device: %ld\n",
 			PTR_ERR(sfp->hwmon_dev));
+		kfree(sfp->hwmon_name);
+		sfp->hwmon_name = NULL;
+		sfp->hwmon_dev  = NULL;
+	 }
 }
 
 static int sfp_hwmon_insert(struct sfp *sfp)
-- 
2.34.1

