Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3A349B0D
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785117417; cv=none; b=RDluHgUF+WRoVWNS9i77Opqwyfil4fQ0PuvMXIQwI2AM8r1ZOQwTMTp9CfmLmHGzmHIWUHzxVrnETnOGRGEoHnfSE4sun8YQXwKzxvjA9G+Sv2W3X2ZkfRb0NbrahuniFYuG/rE9+PhrAQOkrn0HLri03CydPciOdpQg3/6j6k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785117417; c=relaxed/simple;
	bh=EszWALJhinVIZObxCFPaUy794kjqgasQm0waxDhK8VM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=seV+qwB3KgkX0gCGDT0+drKxbs+K1qbu2895i5F0Ta7veJOexuvPHKkcSVMaWK+AIDrBT3ml06DaE+Hzq+kWPq7PW6I3Ue28zyFVBx77rUPZnPsDmocBtIvImh4p4i9/CDC6rsizS0oJU4ml4dHCxKrsJeF1QKY16PQM+Cv/5Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9BHaaKd; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9BHaaKd"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-976ea28c65fso1234343241.1
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 18:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785117415; x=1785722215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NOayYCwfC+5qskftl9LJRPws5FfAU5LWClR050fKiVg=;
        b=q9BHaaKdfDvcCSyRKGVFnvLOpUuIyHzeUTXGMgwJ3LSrSeKO2DuwRAWY5Oo1EXoRjK
         ZmFqPfqG6miSiEFHYtwAJoD7qy4fJsfh8NXZ1ZIC8Gc1HneYapP86E/L+89jEPUW2Lmg
         z2dmN2xQXnYk26nf7GVAHGRijY6nKVLqr3K+oGhQSPIDHvvZu9ft6pke+sv9FF42R/6h
         GC6vGp2e/ML7rrUAZfHlgyTXyB4RvFu96fRHu/MtWHtxQrHXxEpJJqoBE/asV6QWCDVT
         5FRdXIeeImI+V7uc0WnBwEIZBrmepBWp5etr+kFlZkgl8nRnZ93ZlXtyaKy2yE0kLwGx
         A/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785117415; x=1785722215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NOayYCwfC+5qskftl9LJRPws5FfAU5LWClR050fKiVg=;
        b=PEPdxtMaZZTh+Ixk+k0h2yJTu+TWlyZ2b6Uz4d8MqjNh8CoZmD/8IYmuxaBFkBVs6e
         Y0F54SbItclh05v0Mg6cEveUT0CaHn7/EVzsi926knRWuC+3DUaSB3ctom30g3zyywsW
         Dwl4z5A1xc8QxQG/XMb501onZl6XZahoTYpw0q01W7NwYP1NjVJnu50ZIH6KhT2X9lnV
         cRCgweaRGEtJU3DNuI7gkQ1+GjlwHHJvDtL7hrcyzo4IfEpGe9BKP1mo0TqGqx0fsasW
         xyurknBSzRAuMhn90AgUeYKnwvxqvWpNtiTGZa78Rf7bmvCKuOIuDyeG1OpP5vv0EdLu
         Liew==
X-Forwarded-Encrypted: i=1; AHgh+Rp9W7Im1ZJzudWoWqPT9iTUEfFtA3G7a8Jy2cEzbp6xP90wBnHIuv6wCw6i5gebJxGPuOd8No0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxHkK7Z/F2y3rfPBanafUZ231uwdFw3hwGnL1umm3MWJJncuG
	kyABIneRui5SmVX0rccWCTau19qqgA3Ec2eANpMgr2vKZ/0JgsfTS8at
X-Gm-Gg: AR+sD13aMlpUKjtrJ6PvZR15CeTu0ldrxbkDYKPwUhOuQO4B3MiuVMu5zj11lCXILN8
	I7ylaQljJLsCCe22LpES1nUaYe32I7/zUfltwPmI9/sJ6mMuEjG7t6zae1v8qDj47o94cqAZ10Y
	Zda7wyKM8ucklhmWvrO6eNHuD3DKNFLVlWr0f0vRUdwIyQoCmVF1d9p/vKpyiU8R1lGZxrbhaXx
	z/uN/bwrSP9wzrDQW9cn+kcqITVe28EeAm1rbMg+5NzUiwk4TuGFg+GvEG5AfN4l4t/5bJ7h7zp
	i71QUqLq3F4giFVSUeRsjFKBCbM8GewnQWm+JTrUa0JmYCDMPqhVU2DAMBZnVAuOmQXONNLL4Qe
	7or5WR9KIoiTrQ8UQjtP/17GYdFBXxZJ7XjGPtUqbH//RJOpqMnXfyKAbH2haeTL3hoOb1LxiXZ
	s3aV2s7P+l8lVggkT48Q==
X-Received: by 2002:a05:6102:3ec8:b0:738:bf0f:d0c6 with SMTP id ada2fe7eead31-7503acf2e29mr4640443137.0.1785117414758;
        Sun, 26 Jul 2026 18:56:54 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-75036705086sm4545306137.12.2026.07.26.18.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 18:56:53 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 26 Jul 2026 22:56:11 -0300
Subject: [PATCH net v2 4/4] net: dsa: realtek: use devm_mutex_init for
 l2_lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-realtek_mutext-v2-4-5d62ba998791@gmail.com>
References: <20260726-realtek_mutext-v2-0-5d62ba998791@gmail.com>
In-Reply-To: <20260726-realtek_mutext-v2-0-5d62ba998791@gmail.com>
To: Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Rasmussen <mir@bang-olufsen.dk>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

With CONFIG_DEBUG_MUTEXES enabled, mutex_destroy() needs to be called
before the lock is discarded. Use devm_mutex_init() instead so the
cleanup is handled automatically.

Fixes: 336e3e4a1ab37 ("net: dsa: realtek: rtl8365mb: add FDB support")
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl83xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 9f40afb19ab2..9dd50b20c000 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -164,7 +164,9 @@ rtl83xx_probe(struct device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
-	mutex_init(&priv->l2_lock);
+	ret = devm_mutex_init(dev, &priv->l2_lock);
+	if (ret)
+		return ERR_PTR(ret);
 
 	rc.lock_arg = priv;
 	priv->map = devm_regmap_init(dev, NULL, priv, &rc);

-- 
2.55.0

