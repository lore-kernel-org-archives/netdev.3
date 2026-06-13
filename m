Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEB41CAA7D
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310427; cv=none; b=P77HG1VL/riPPYct2mXSvnIMXXaVfFmyL/coEyzfWxb9llA7JgM6AONQryD1B3uljN+S61MFXeUxqzuk0wpWZO6Zeb5fFB7BYOC4wIR9vr9ElbCtC0NgoYaSrMS1LZCviNVAnztVY/xLGlvfYOe0nCbRi3fSGjOtPmVzO3X8wh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310427; c=relaxed/simple;
	bh=Sib4lr5qF0Nit2buoDrYcOR+Jlt/ZNDUU6u8vG9loH0=;
	h=Message-ID:From:Date:Subject:To:Cc; b=B1MWboxL6nwmgGE90NgMhCth97xtkUHPpyecGVL0mL7x028vQV7pXUuNhz/ER2C/eQGm51FLv6iMHltRpLADTJmkfFzy5qmOxQsyDCS6/cK/he/N/0opBGWzYGtbD06dPO/mxjZkW65hf5xUI/WnbyGhRu3HqTrfED1m0BYKakM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wmnz9O4R; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wmnz9O4R"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso1551112a91.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781310426; x=1781915226; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jZZatEXd/JafvuiFH5stqy7hRhy8giY4fPvDzpd45o=;
        b=Wmnz9O4RkQ1FeIXhuYGV+HxhaB/bZsYKlcyjSQzmfZ8uPmiOOpCAhM/OXyuT0jFx3h
         yGZIGpeseYDIbrIoKWBSo3ZOtZ8zIyi+UaKj/XPbWmlBDFh/DuY/qEpqXwKIMVQBL3Rr
         SNcK2dFj8hsZPIzNBK8scPajdQMuIQ7Xfs3E3uQt30oYRM4i8v3gb2gUpSAB4BQTQotG
         xUlqirc36j8DHs7r2mXYS5W3G2QpEORmC46WKACTy4aKvIio9+WNOKgIwq0ZsdD+ZDH6
         3EB+x3Yj3g7cTRjWp2Yie0fDCBH4xorgBXKm5x+5IZNn9F0G9WRXmyN5Cc94Uu72XfuA
         9Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310426; x=1781915226;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9jZZatEXd/JafvuiFH5stqy7hRhy8giY4fPvDzpd45o=;
        b=THfthPdzYAi8VS1wUp78vHdmt+AcpDZSIDEtQlj39iEoZbIdTQtMjE8zvdqqtpI9Bd
         KdIta2H7eZgJTlFhOiDHnA4XBzfO2MylmsWnaG59MX5YuEbvL+s6yYFAEp6mGQuFXdma
         NjSrP2VQtAp/K60s/4G6xiSMwDeftDksXturCl+g2Z6+wv78Jc+YrQgxEuTb8KmBgi0k
         iKvYRypi71m6W2goEFWuII/77Wgi6RjBqa4O3WfvrBJmnMIkgPuEU9tgII6dfgdX8jiA
         umBMGzeSsC86Kq42Ahgedyi+1ch39lZqcTIgzo/twjOvNRZRSv7qhOQJPwm7YNCuYSrg
         vjaA==
X-Gm-Message-State: AOJu0Yxf3dgBiYHqS1JlcMG7Qpi2OJdR0U+TVh2keFiqzXALF2n9tBpL
	LyTdxG0x5U/gQQBGAqieNyFw6a3YFh2fFCCb9RE8vqsdJsBHRdIZoBIDU+8M1EFlcZg=
X-Gm-Gg: Acq92OGm9OlAUaaxW4jJNf29IWr0e4x3qljxUyDJO8l9smS70cxJ5Zqzuk96sSQXOTY
	BJ+M9ViDeuud8KODUGzKq3YZCgAbbBk/H2bKxGdV3ekFLjOdGTq/e7Hssswn5K9ZxhOALrFhFH7
	q/0N2AunLl8hHKjOz7stdv8jrvSx4qkcH3YM1VOOBYMoLI+o5N/M/w2ganteqelYwz8hyruUDXd
	FgWKx4KN6jI0ZDbiWhQ/1AKz8yGE/og76nKzmM3HLhxACS5BDDyQSqzNDQ5+Sv4M9ZfsQnrZHei
	6CmsSF+BW0xzGBKUbKulTxx8rAKrMLL9OjvUL2i+yymZ1SqMR8qgLekHXLmttWrQxfWUp46hfdu
	VAlXT7XAnjT7jnhNikFPE+5yczOvqqUto1Jftfi9KQDj2kwOFdFOf75VyOBuucxXgLnF2H76xJW
	SpItr4ux+9ykuK/+ynMjGCXPuku7I=
X-Received: by 2002:a17:90b:3d01:b0:377:23bb:9b88 with SMTP id 98e67ed59e1d1-37a033e024dmr5562386a91.12.1781310425834;
        Fri, 12 Jun 2026 17:27:05 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8ea7sm3441412a91.1.2026.06.12.17.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 17:27:05 -0700 (PDT)
Message-ID: <6a2ca3d9.ad59c0a6.147df9.2a62@mx.google.com>
From: "Wayen.Yan" <win847@gmail.com>
Date: Sat, 13 Jun 2026 08:22:31 +0800
Subject: [PATCH] net: airoha: Fix non-standard return value in
 airoha_ppe_get_wdma_info()
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

airoha_ppe_get_wdma_info() returns -1 when the last path in the
forwarding path stack is not of type DEV_PATH_MTK_WDMA. This is not
a standard kernel error code. Replace it with -EINVAL since the
input path type is invalid from the caller's perspective.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Wayen.Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 5c9dff6..7260177 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -264,7 +264,7 @@ static int airoha_ppe_get_wdma_info(struct net_device *dev, const u8 *addr,
 
 	path = &stack.path[stack.num_paths - 1];
 	if (path->type != DEV_PATH_MTK_WDMA)
-		return -1;
+		return -EINVAL;
 
 	info->idx = path->mtk_wdma.wdma_idx;
 	info->bss = path->mtk_wdma.bss;
-- 
2.51.0


