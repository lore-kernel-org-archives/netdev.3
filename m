Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50C82DCBF4
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774452487; cv=none; b=V2I2OOyeAhPGLEGFJIvMQzclLar5ezmG5pfS4U9G2It/3rI+sydXJl63Yxv5QF49UeR5IDmhMn63jCq48zdxx0GmZohAB1T/G475Me1XOH3Uq2dZJnBEJlhTy6jrs1yrLxOMeeI8TI6A9uvtxJxszM74bCIf6Y/7uCOgYYlDs/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774452487; c=relaxed/simple;
	bh=1um2/dIoDKaPYzCtkM6Ts/Sm6TbFwHoiKDwcUMHbA4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iqfaDjBmhSqbw5bNeZwqhvCtsIO3uhCIMk1np86rQneei6xR7m0KcLuzc6bNHOE1+Ej+gQ7OQN0QTEb32M8DP5kA1ieP15C+VpPD2jtMv+JU9oDNoo15mXA95fuQOPmufiHwJZmy/JBcZWMvvh9VS8bPA2pjk1LygNl5SkWHd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KUoZNzcS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KUoZNzcS"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso25775065e9.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 08:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774452484; x=1775057284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T/RrMkT1T+9Es35x/WZUJR2pQrywZdmNJcvK7JnqAyo=;
        b=KUoZNzcSIo3A5jYcY664Z/AkWJVEeGEJMojE9zAY3vidDbaSfz+QKB+BPJT/9U6P4M
         qxduzzmY3/WmYfr7YFPxYVJ5v3n4rupMDQ02ngq1z9NXoenx4kw7KV8/CW3Kr8tWtxPQ
         JqCI7DbbpNaFK3O6DK+wb/SLjP4h29c6yB8cKL2l0PUNv4ctbIAXVkkwUDmMUq/y2ISg
         7aq+NsHlwSV+wNMwRSfWfXd0vxdyOR2meduKrvfNoB9H361dcRZ8fUx2JjWQlYS8cZcF
         1nYLS2dZTqoot15gBjcOohqMFr46eucr7EKirZEVGFx61EfirjOupZFpeeCcMKy02huB
         y24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774452484; x=1775057284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/RrMkT1T+9Es35x/WZUJR2pQrywZdmNJcvK7JnqAyo=;
        b=dr8tSCYp2ReUQ8pMm91H9zh19bDhL8V57Wh+im5Q16JrsvhIOG39dHiyspjOFA1xUd
         g7HbwgkOHKtO9I8Cy0Q7Lza4Qkd9ElNaOSUciQuWajebRukOaiu3Nx/Db3n9jhILlkM0
         3DsnWpwfnVRHTBkJxzo9UWJmwim//t6Uj8cnnDC+VhkLrR2fTND+HWhNUGzVDA2QK7+0
         KfkhZml+WTk3sJoYDo+SRHWdXJXKH/Al5Ch+r7PpFTp2fdiZI+YNo2AarZvuv8GXTMzi
         lz+9Aw4IsyU8faezShhunOVH2mXL1gE4ENhfERNWVQmgNe5I/s4ihin8XMoieaiGUAo/
         FjJg==
X-Gm-Message-State: AOJu0Yzxtz2cpJRQtkEp9hq/Dx13LnXS2XOz4AaKYGfXcK2CbZM2m9LF
	XbsRD8S1ztYTI/InaQ+2qEglVX2csLkEUGWMfulLWVQgmc4lLGZ1YbBj9WCzVp3ORLbq7Qbfgx3
	X7bVj4Es=
X-Gm-Gg: ATEYQzyAtEI9PGNXJr45KFNCtMNJ84gcM6bdpTJ2rVL0ZRPod7lvprLu97zzuEbEkSf
	lrzZpEx+BZXymMYKo8uJ1lI0CIUWeBjd0Q28UumslgWfUTx9eoSXoaAU+S7rIvskhOgCLvGbLzk
	YAQF5ccuBNl9dbT2tEv2pM1Jy6WxtMX2Q7yVLligAQY/LB3xognZrTkvalZrSraC/l0axRGtGzB
	jtb9gOosXhtYQM+xz2aw2Wy1XT3qyoJ0lT/JO8cb4eiaFTZgt1E/3w7Ph5BufKr09DN1PhM8nId
	jkLRGSwZOBWcer531Vh6AhN7aNuWgim4AJcxOuwhIXVIngBjGT2IBFO7U2Rw8Nl3hO9fZ3zxT3l
	/Kf861C59SMh38f4JP53ndAn2IbpJh4n2AS2S68mVlk6g/l+a/NczxuM9jZ3fhHT18k0GFpMc+V
	Z01enn40Yvl+CUow==
X-Received: by 2002:a05:600c:3491:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-48715ff3363mr56853145e9.11.1774452483689;
        Wed, 25 Mar 2026 08:28:03 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487165ecf00sm24442765e9.5.2026.03.25.08.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:28:03 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	admiyo@amperemail.onmicrosoft.com,
	ben.copeland@linaro.org
Subject: [PATCH net-next] mlx5: shd: Gracefully avoid shared devlink creation when no usable SN is found
Date: Wed, 25 Mar 2026 16:28:01 +0100
Message-ID: <20260325152801.236343-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

On some HW, not even fall-back "SERIALNO" is found in VPD data. Unify
the behavior with the case there are no VPD data at all and avoid
creation of shared devlink instance.

Fixes: 2a8c8a03f306 ("net/mlx5: Add a shared devlink instance for PFs on same chip")
Reported-by: Adam Young <admiyo@amperemail.onmicrosoft.com>
Closes: https://lore.kernel.org/all/bab5b6bc-aa42-4af1-80d1-e56bcef06bc2@amperemail.onmicrosoft.com/
Reported-by: Ben Copeland <ben.copeland@linaro.org>
Closes: https://lore.kernel.org/all/20260324151014.860376-1-ben.copeland@linaro.org/
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
index bc33f95302df..b925364765ac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -33,7 +33,7 @@ int mlx5_shd_init(struct mlx5_core_dev *dev)
 		start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
 						     PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
 		if (start < 0)
-			return -ENOENT;
+			return 0; /* No usable serial number found, ignore. */
 	}
 	sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
 	if (!sn)
-- 
2.51.1

