Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D97C4ACC6E
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789596595; cv=none; b=QU4JzlAcmmvL+ixwoYrCcsw33Y9BuCP7vJFcBbev57+XKd5SbmadFYt2Ich9jGXX2iDf59elYek4e4Tb8Xl7+ssMpH+I/od7SMoCZfcnggOTquIVAyTetjLdx5wzat+e89dKxtmp4Y+7awlgLHPntxQ5UcWKe0h3r2QSRZDrCAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789596595; c=relaxed/simple;
	bh=mgIRnJhD7/q5FZgYZI6kuJKUCV6F/Iu6XD/5WNiODeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OeLStLl2i6wy75Y7LpMZgzTP20N7Bys2QhXJ2VuWFHFxamfOj7se5vwDA3MSUUAZtVom3rLOVW6Gyljmiq9b34zH1emk/4z/SIGQpBtwtiGmLMQFFeY07zB/1MYaa9AkXN5U9o+ShT7vFJ7h6C6yL5wwZtEI7Cynk8FS7t3HNEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG7eBbFM; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG7eBbFM"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d747ee1f9bso1769875ad.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789596573; x=1790201373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GOo/om/lDHfRUoYT5QkmCr+jFQv8NIVl7KYNHNpx/+M=;
        b=FG7eBbFMlATJO2NT9x5PCPQMCrBryM02uSk5p/rfxYi0lgbI3vfT2na3u0AwPpTX4k
         43Mk+tiyYcN+PF4fl9M4+43eho6LbPNfnKIiR9q9FnoKTK/72XMXM6lt/WWrxZKtWV4M
         P8ChpTnGXJD2WmScdD6asgWr0QXUjeHxbq1RgY0ie8GBrgjEGm/qjwVxutgg2PIcLtZT
         uZvdSbz98dKbjgYjdgOzESeOXyR0aRp+VGwDqTYvxsKj8TWKDdaCXN8oWPyPch1eVUFj
         uU/IPCVx1C57j4LgENtYwgBDuX6fqbFyhn7PKGi1eTfGt1gR3r0UEc39omXolh01dsA/
         H5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789596573; x=1790201373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GOo/om/lDHfRUoYT5QkmCr+jFQv8NIVl7KYNHNpx/+M=;
        b=W5HyEXt6HWtzRSJxcOjSlnWuXudSOzdELjjP2FTJ7qUlTACJbEOpLGhuv2NV8zjTqo
         r5/sB+jRuvpWRn+hkwea5gmWDiajNTy5zPEqpKSeAVKGYoTaHz8E2ykrRisVOxR9JYs5
         XFBc+755kv+59gywdW0tmIIiTd81Y5Qf/z1Fos+XThjyI9CmJBZTD+zsuHdQ5hDJrWKn
         TeU70NOYWPTARIBR1nLl8+HmOydhdoXFO8Kg2KkeXdqOSKpR5OGWCvpVP/xP8sdYpoRP
         noikzUiEbRHs0cmfaaTc82waoF7A9z8DsjvIx2ZuFl6LCszZftjoCwUJeYjRJvxVUUae
         IkjA==
X-Gm-Message-State: AFuF++kNR4hO8q+ue2c96VSCHhqahEyK8NSYzTstVnuFfVxT5cvWnr8N
	3tQwKJFtdTXT9WD20yONVQVeFG9alg/dIjijDCFjJAZMGh3Yii1ILA7m+s/gVA==
X-Gm-Gg: AYBFou0iFzJ1Y9OfX+PHYddDCO6T3nKyUHIvJ1UJlN7YFW+2f7M/TzQqX6Zc5+9jysR
	b/z6D/UbZ1YK34Y1padlFpiQk7G5xsNYFfh5wxHyV6jNE9HK5IIf2VwlzdB3SsIWJwZ0NVoX4jr
	AwlXcg1JV1qSFB/cjw04GipW6ZRhAn9BggxmijksSPra9nUVFe6R7oOiXk6QCD1WJepQq6YpIhy
	UZC7wacxjSV1yrNFigG1e/YUG5+BzWBP2cGwWmcfOp3s71L5VtTwnA/9QpyME4kEMrfvq+HqxRY
	zXhyIa/knNj9A/3/00Axu0JGjCURPo1wtnzJc3gePyueWEiXueHAQ5QN66Wf+sWXvNeUt2hlVEh
	6ynCQ2HsP6jTUm+V+WoxL9SQl0qGAx0FqJsrLC0j6To30sxu58ZvSLHhXz3mzcveUwPPB437TLt
	K8k3Km5Ss7WqwCZoY2T4egeEWM52uUDbwNZX0n6vg4ivj+JqAXBOGiZHIQO1+nCSWQYwT18PATm
	3/I44kKvfPqqdGCyTk3Y5DbaVMfSrV7H1y0jMtjvNcrfUIeoHdABB0MNaQNjt3VqNqOF+G0TYAT
	phrMDyPZI+qISOEaAk6m/p+Fd0F+6aiLXzBn0cXhaIXvvrxOjjrECI1wAfY=
X-Received: by 2002:a17:902:ce81:b0:2dd:64:12ac with SMTP id d9443c01a7336-2dd8e632d3bmr84807695ad.11.1789596573331;
        Wed, 16 Sep 2026 15:09:33 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89e9290bsm17471345ad.15.2026.09.16.15.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:09:32 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: fec: gate MPC52xx driver on PPC_MPC52xx
Date: Wed, 16 Sep 2026 15:09:31 -0700
Message-ID: <20260916220931.262932-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FEC MPC52xx driver only applies to the MPC52xx family of SoCs,
but only depended on PPC_BESTCOMM. Restrict the driver to MPC52xx
platforms so it is not offered if COMPILE_TEST is applied to
PPC_BESTCOMM. Otherwise the following errors happen during linking:

ERROR: modpost: drivers/net/ethernet/freescale/fec_mpc52xx.ko: symbol 'mpc5xxx_fwnode_get_bus_frequency' undefined!
ERROR: modpost: drivers/net/ethernet/freescale/fec_mpc52xx_phy.ko: symbol 'mpc5xxx_fwnode_get_bus_frequency' undefined!

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index b34c0fcfddea..d81984fcec64 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -38,7 +38,7 @@ config FEC
 
 config FEC_MPC52xx
 	tristate "FEC MPC52xx driver"
-	depends on PPC_BESTCOMM
+	depends on PPC_BESTCOMM && PPC_MPC52xx
 	select CRC32
 	select PHYLIB
 	select PPC_BESTCOMM_FEC
-- 
2.55.0

