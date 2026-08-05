Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5DD3803F8
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 04:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785904616; cv=none; b=FdDx6C7Rg4ca4WtLvdrqYBNsMVMmVwmjhUF0HsRVL8Z9i/hNiJhApLfRIFhryF6QTdNSV9sMwsfNFTCWL4to5EmsD5Vs8hy9Xe3EB1wUU6qnI2sjsAmbTxK4q2yeJqTxfWmgpvI1CBjBsDMN1FOF/XyjkrIIpOzpy4igxQsbkDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785904616; c=relaxed/simple;
	bh=L2fpyRSq4G3d0EM7TTdkQUIefQmGvyL/xKYJ6hmxv30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qJDS6G1bHkMW2cZbqJcUmKRrYfa1tbawfvEPwFGnXk1dDP1m1t5yJobPYezG2lid/AlzP3zgbt0nCriO2qPGTTsEy99Cvm88eF0gRg6YhrOD+XUNhg3ZRQkVJfOZ9AvN/l/TLxniKaOhjVfmjwKiwTUogzFhxdPDmBOBiJC+R/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ki1nNbYu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ki1nNbYu"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso420845a12.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 21:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785904615; x=1786509415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N29rOnwidiWrDHOiNHbIbbpfozqgtTDIGAsWss++ybE=;
        b=Ki1nNbYu2Vg/6pgSQkaXUmch1Otmi2iBaf6e8XhINMZ4Zgtc4qRc+aR1w6eautUJOC
         iqAQ7JWx/M58PtJDaVFe+ijSXd6hyncLkWUKbf6jjRkXSDqjboWkZ6HahQZlnLuqwOzH
         Tzyd8FUZOSF2GHdxP7euHJJaWavwab/z7nuSSDgDapMU91likULh0UMFrlqDGFChQOKj
         3cY8PJUcz58CnQG/ONT5QDwq69M5MdRxbCg3wtRhq/U7fv5uJdFNVhUGF+J72/vlGxmq
         MNOYQfN7wCrEJft6oWRKdp+6y1XDMkEPZXwT/GhlQ3K6eFVSTtWAScFV47kar/nwXKvy
         4MGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785904615; x=1786509415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N29rOnwidiWrDHOiNHbIbbpfozqgtTDIGAsWss++ybE=;
        b=JhjWNzKK161T4gDQOMAUL1qmFlyZirwuoA1SCXT7JX4Dc3wjpOrsf+VGPqDiLKwVwG
         FKQstirvzOo4KW+bZhyeAhhxnU/NY/HyCkJbJ+JNMAVVB+jp+8fjQxuHW4xQugllQ3ix
         UIdxJPKRLe8T8YbQ4lqhRTbB1XMp6Yzo7/788zFBFI2cwT5rZv8HSnyPQoNG5AkGu6Gw
         sVu7fGS6g507YJ0A5AL+yJeRAagq/6MM2lHatq2TqtEfMEqhY219dEeuB8yJ/sFu6D3h
         weFDyOYhFzHx1sQp1Fym/trryT1+Iqan+CzbRGcdVCFKC40knZhkT5NYbWX2a8NdrjOk
         iarQ==
X-Forwarded-Encrypted: i=1; AHgh+RpPvFUvOkX6sTseNL4EukymS5g3EA9AGnIeCZsF2CvFzB7Apy2sOlpGDB/4phILou5iKu6SOGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBeUGebmf3xuR3gnlqZ8CLCwSk0Ejh10V519mxjPYiCxP5J2zq
	iRwUJWZ/NLk6EqaTM1FvcvVFefsFBrxVxQHjrTcF/NIh2FyQWnJPS3/t
X-Gm-Gg: AR+sD10gkBIHQsp7PEfDTUFx7BbwitYE6wnUN5J5lZvcXR3X5kMWudNkU0Kp3klqhHd
	zcnT8bSzewHJ2Tpqpq4K3pfJqhiue6Wc0+GnEhaBtWV4fYYWh/IgU+ZVhvLCGHePKZn51QT2Ajf
	gygpAIi/flO7XsQunp/etalZyEEKgdfoh1AcOHolY7KY+/+MN6FucOD237dmMIydO6luNx6rwTz
	e8zfqPoScrgmR6G/aV02VBuBA+OzMITbcrHU2yv0nKyX1igCVe9K8zdiz1Phu74r4qryhf2xlto
	YcVQiF4Yzycu/AAyJqV+4twtlseoJHEwrPOlQwZb4Jp4neYcGRwLnPqMOV6tt3PSc1DONosPZYn
	mKdgtLDJdlWGBnq/SNNo6v9sfENF0Y90TlJKGw74wjozL4FRjl2gFTRa7ESe6qsqYmuYUr6rcbc
	KDx7cxXJCZ7fvt2BjP1Cn5FAIEO6QweQBMY5D6TyW7/oywOKIgw8GLYvd2eqtMIPaslbwko+i8h
	DM+uHEdNwDdbmK/+hAJZnQgPdY=
X-Received: by 2002:a05:6a20:428b:b0:3c3:64cc:311a with SMTP id adf61e73a8af0-3cb85ef9229mr4839207637.22.1785904614975;
        Tue, 04 Aug 2026 21:36:54 -0700 (PDT)
Received: from localhost.localdomain ([152.59.182.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b0bfesm11262346eec.3.2026.08.04.21.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 21:36:54 -0700 (PDT)
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
Date: Wed,  5 Aug 2026 10:06:43 +0530
Message-Id: <20260805043643.194976-1-krishanmohan298@gmail.com>
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
 drivers/net/phy/sfp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f52020673..bfa2b821f 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1916,7 +1916,11 @@ static void sfp_hwmon_remove(struct sfp *sfp)
 	if (!IS_ERR_OR_NULL(sfp->hwmon_dev)) {
 		hwmon_device_unregister(sfp->hwmon_dev);
 		sfp->hwmon_dev = NULL;
+	}
+
+	if (!IS_ERR_OR_NULL(sfp->hwmon_name)) {
 		kfree(sfp->hwmon_name);
+		sfp->hwmon_name = NULL;
 	}
 }
 
-- 
2.34.1

