Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016EC41A553
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476964; cv=pass; b=qRQ+9XVHuRqPv71dQY/Gt1OuKkVml3fTSutg9Gy6aHka/BI0NChH2t+KIH4j7lbP+3QK8aRS5J3llF05hkA6I3tlZTFcMpre5NZ+OE14T1g7J5VJB7atGkJbieWg+5QHK0vy+FJonDZk/91f9ihlU8A6ERu+Y6BkaQyFAczj3Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476964; c=relaxed/simple;
	bh=I2kRlTRZg0bEl3icPSe8s8bUHSLeWU6zAjiDuwK3f3U=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=g85gINUF0XtSrQxyoeIcv2gTRHsXPByQIdwXVN6MjSxLdDfT2G58bE7NF5NMRZkerNjNhrOj22xE6FuNcGPz94qQRBt8G5Ye2uctpFU0ax90QW/l8v4x4NgxgfeWjsY/c2r18Ne+gzQbiG/EulIMlWpvh+cOPh0DRNCrVPXEJGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZuRoL3E; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZuRoL3E"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843172bff4so1580551f8f.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789476961; cv=none;
        d=google.com; s=arc-20260327;
        b=Bhp0UoSN8AqfxkdLk2SD3Pvp566AOXRSlR51DzXlprxDOL+cmS17lwWXhQItrOANzE
         gYEzMwKqsEiHfA7QulDj8m6afLXKBolDVYosZlbgA8XllFzDWpTXXyYlyLbXTFQ/79/H
         zJQOadI+WuUiPncXrDloqktFDfd9VMuh7IOjxXP6DQSO0SVa1G5oFIAmPT0r/GZ+LHS6
         vsnRdmj6UzAPMfSuenwVox6UXYsb6cwIAbhOyV3HfJE33wbz/vGAYOzMc9kJlemoeihz
         zQPUFxMqeb+S/a6OoXLyGPKb3pYI3HHGukolfeFtVVoEYoOnaEdMjFRDRr4vcXsedVza
         OFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=tLVTqjGWpSmXmNCVuxru/Lg1s9xlcHQ1XVDEoRCeuC4=;
        fh=+uRx9wHbJO+BcmExYxTpXeoZGVVGgMx6wLcyB30woHc=;
        b=gVevzKDCwxJJJnkm4BLY8ZRJH+5gDTGACYJGVxMoLYRPj/wCsCwxdfhZCkIwokFpuO
         ZguB95yZuEYsvLC7sYH66rvQN/59WP48RwicRyWzdUjAR0ew0M18uSAv0hiVHmJn5Taa
         XQRhzfId7y0otXv5j6LAtsJTfnlV7DIjqVGYV1Xculw3k68sRvscmEapGyRPbcZ85rjY
         liwJNggkzSWJS16pBc6cEqkN9NvOLE505Scc8YhrAJsPj5oRezVNMY+N4m81QqRsfCoL
         A+7gIVClC+xD5vbWzEh0PJFZl6umbDdyLrwIMLrVdYwVMUdpuJe26bxLS3yarViENrTN
         bJdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789476961; x=1790081761; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tLVTqjGWpSmXmNCVuxru/Lg1s9xlcHQ1XVDEoRCeuC4=;
        b=kZuRoL3EpICYuRLlSgv7m+4Gewwjr8dOQmwgXY8AKhvEUlTptG4KeuN/54njr+W4Hs
         S+QkRAOzpmSvADFmJWMclVAee2y8JmUp4UJxxJ0SMfvKCONq/LlmcDz4S1yjLTKcXqki
         7pHhR6/IaSFqhF3ypJ5JHyTQeAQlQ4hMKehjLb8+k4ETrLVYhrQ/UG8QudPy6OEfp2dY
         LjgMr9+fUCdbECdG/Jp1Zv4KhYlO4ChZIWBNmBXcsToN9+/6fHyiAYtGLtOzAkpwp1VE
         +CmLsSCkk3tImwYUTcM0Fuj24NFmuITH+5uv0YZxhpv/ZQ9zv1kzBjjtAkRnSDo39+P2
         YUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476961; x=1790081761;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tLVTqjGWpSmXmNCVuxru/Lg1s9xlcHQ1XVDEoRCeuC4=;
        b=ckMUX1hzOUiJQWzVB1jV7nUbEqBIUHzY6e/I3xosi55Fq9XESs8X+jkqGqK1O29JFl
         hwAGyq0x6Sa4bOdzXbDCvNC2rUSmRMKVZvwwS7xbjPTw9tkYUM9q6e3BfD/78UfSsi6f
         F5SxXMgNlYoY+E6aCpqbwyoRBC1rZq78q7OX1LMzwYYJsnBfDQzQOZX9WQyzMIB6ZfHY
         keLeYwoOVdHWujjlMaJSv6pQ2trjPaA8sGmpywPCQM2PrJmdSXs0gHPx4v4KmMKmlmPD
         P4hNyaXYT2g0f8aYOXyHoP5xpY41u3zXazDNeWE2BECgu/XxiiN6JdrQxd2E+IWGRxyg
         4qtA==
X-Gm-Message-State: AFuF++ktjep3zUOS+bLfpjAaZJLn9+K8wOtnqPxA1miT4FosRoR+KnKU
	6FiOdaMd6jtFCd9aHDG0P6zUjTbNtMdogpBwb8qXFf9UnKgqvnuRQlZDf45047YGtjzJqz2LhdB
	3P2VskEU701iKcJN5J/N9mUrGhPI2qi+UHElIO26Q0t3o
X-Gm-Gg: AYBFou1wrPITnI+pa/QlFqyfHKpR9SmTn/IOSNrnO1CeTRE/jhsMOrTyStuOHX1UXW5
	VcGrhAmFE6rEeISDJISZb0k5b3574m2Zdi6iTXUQoXTz58B8BN4gbMQrMGPYZIjj0032XSHixAn
	DCoC8EgZsqZSBXIoqhdrPNWHs7gZKRx/cAFLmJX4vyP41HIri6eCaFJyfit7gSYvFo+C2rYxPWO
	5zPG0q2UFTEe3Ezf6Wq8m+8r4mNS2dBR4bfJC2q/b4IJ6vLPN8a0iJl6UwmvtmHdh5maYOqNjVX
	iCq139MJVlW2VNOZQJ1/4Ann/N5WMKR1NNyIcuhCX7TMSoOU9a4mng==
X-Received: by 2002:a05:6000:4024:b0:485:8a47:5b91 with SMTP id
 ffacd0b85a97d-48702b1fa63mr8463839f8f.46.1789476960937; Tue, 15 Sep 2026
 05:56:00 -0700 (PDT)
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:55:59 -0700
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:55:59 -0700
From: Ruslan Vagner <rusya92266@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 05:55:59 -0700
X-Gm-Features: AcwNN1VUvlxBmvxFGJf9LC8pwXKwTQXWD7gDpkyoFbeipeM-pCiinPVcm2F9R_Y
Message-ID: <CAF9RqJ5CgjDJNnQT-AKgGfWgJssBGBhs+S_O444dtcg96-Uixg@mail.gmail.com>
Subject: [PATCH] net: hns3: fix comment typo in hclge_tm.c
To: netdev@vger.kernel.org
Cc: shenjian15@huawei.com, shaojijie@huawei.com, 
	Ruslan Vagner <rusya92266@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Fix the spelling in comments. No functional change.

Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 00c3f2548bf6..bf533b8f46ae 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -35,7 +35,7 @@ enum hclge_shaper_level {
  * IR(Mbps) = -------------------------  *  CLOCK(1000Mbps)
  *		Tick * (2 ^ IR_s)
  *
- * @return: 0: calculate sucessful, negative: fail
+ * @return: 0: calculate successful, negative: fail
  */
 static int hclge_shaper_para_calc(u32 ir, u8 shaper_level,
 				  struct hclge_shaper_ir_para *ir_para,
-- 
2.54.0.windows.1
