Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16D73FC5B7
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372671; cv=none; b=tYKBM0VY0ir2lRtCvn4jEKPGxPN+HDNjMz+6iQyVfRf88hKsOJMAoHq8dZL9IfIIsJ+2WttuO3RSg/Pbm8kSNqc9Qs0DkvHvD7wu91HBjAsHzg3qCebETyM5+8a4UAttiYcIy0D5QEekKvERWHLgeGj8xU2iJPXVjzjlMHgDwl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372671; c=relaxed/simple;
	bh=U6eFYUjtgUAS0INLZ0XN47zNG9bR0RQBjpsfNay3kyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c1sAD7lVuuKtCaq6ujcWgEO12hDIwFuWQKOGwJZHZddiUrmjx+oiGd51qkEbrVmQmMeX7hODNWltS3lF/WuVXYdHikVmhyHKlS33Pcnx3338RmGZoPt2Ml0N0dmlwPdM+7zaFu0Qp+jlkURDTvdzK+rgJYv6hAROD6o2r+gCWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXxpmUmJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXxpmUmJ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso22881375e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786372668; x=1786977468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=931F2HfB2O3wskp4ekB0sosbH9ZDKfZP0WQEyB6ZcAw=;
        b=FXxpmUmJXaDncV8Naa3UuDJyA/S53LddEYbZgyPwLod9dBTdtSmh7PJdxjZOeQRzPX
         zRW9ZFICWD49iU3/lPrCwOYM/DJdvyoPRSQTE3D/wjPEmvu/GSH4ybdlcc9TV0duz8fZ
         6L3PIIB4Magc1XHZSSOcUIBvIaeNSGETCYdHqyffCPSO0EarC9IR6YcMKPK8c4/HfGDv
         ux7rOPDI/wJJ0uVl1CLH5y/Mo2xR7EH2ew35kJvZp32fCTJh0PsBg/RQBqQHB3zMbBfP
         lcozIVdJWQGMct+tkQJylQsF7USczhp2kGNxUQr3U2gaCian7IA5n/FHxryLe21bLv6b
         rlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786372668; x=1786977468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=931F2HfB2O3wskp4ekB0sosbH9ZDKfZP0WQEyB6ZcAw=;
        b=cvaWwt8GoV0efPOkflNWjYPeZgLpay0i+K1aMvmDzMIbBWV5l7PQSSaxibDwEdgyOE
         ifriN1q/3OCkWeDe948et57bJEEePWbqnsPTVoYYQI0VLQsVma9GkBe58O2OuZYLD9OW
         8hSH61cGUJ9aUIEvgVUWZH7pdhR28GbBR/cashPBngzPvD8wErtfGZbw2/ecvylzXWhb
         B7cBsAAJ1a6vKM03iulT3qsYEEolffwvaHqLyf7Wws4WzLYvkgCFR0OOTsGx3M6F+4uA
         KG+lkv3kccwBxIxzoJxqiucfwzvKLHoI+cWxO/TNB8HaqWFXLc2eQ5yu4xtcFGjTF+fS
         N//Q==
X-Forwarded-Encrypted: i=1; AHgh+RrYsxr3aucnytIwyT6xliUfp/GowFLG0+lxgnUQBh8xENiZv1UfP3D/xmN8lzvWOqn+7hWIU8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YygPssuGF9wTOxGVJFhtGw1mGT/znLzIQJ1Wu9e8rS72/j3mQSq
	KcDNq5sZNnFpMU4DRJnuA6Qbdd3AtL/xpQQLx3DvzKZo4FlNkYU28Dl9
X-Gm-Gg: AR+sD13i4SNROuIidXljSRwd2qBwwf0FCKq18ujJh8oYx9/JBEc4BAdxwdSbm+NUUhE
	1umCfmXfVHLTxUDIx45l07I7aYfy1qD/AXXV1pKzAHvIWxvL2fGaVVBjy5FyeRaj3zpb2AFeUlG
	LQBI15rF2ehW+k4zBMeUaMV/V6KDsd6qxv6+4Yj91lEwJG+/g1rk64x2LTbL2NZGBULCOSpD0ub
	y32UWg24JbqpkAuVavnLDCsB0hzO/dUgtsS3G//ca6MeqishdSIA5f5V1Se3bBvxg0VxRbydo8/
	2Ny4grWN7aOCQo+SXPy8ZkaVzf5flXka5ekyrW9PWyKkye5Rt96gnr52x69FcF+Ry8rA254fxZ5
	lojeR652wEST9C5hO1ywdAIZqJHkGb6BkaDF1e8dYQmtEVOgqRdpFPTbXhim6LT6RmVrlmyxH9f
	9ZmoHHXiEZlHX+1QfHZEoJ9FT6vszMi+01uQ2GT/qOs2//2Sy+AlKHzT7+VqenuJJyz6eApuarF
	wPBrbh8KCKA744WFAMLxWVTxl0AeoKWY96GOE88bou2Tsl5
X-Received: by 2002:a05:600c:4e08:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-49972771ed5mr39660555e9.7.1786372667813;
        Mon, 10 Aug 2026 07:37:47 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995919df87sm355510695e9.6.2026.08.10.07.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:37:47 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH net-next] MAINTAINERS: add myself as QCA8K maintainer
Date: Mon, 10 Aug 2026 16:37:05 +0200
Message-ID: <20260810143740.652804-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

List all the files of the QCA8K DSA Switch driver and add myself as
maintainer.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6008f16ae2ca..2a23908c3d59 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22281,6 +22281,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git
 F:	Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
 F:	drivers/net/wireless/ath/ath9k/
 
+QUALCOMM ATHEROS QCA8K DSA SWITCH DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/qca8k.yaml
+F:	drivers/net/dsa/qca/qca8k*
+F:	net/dsa/tag_qca.c
+
 QUALCOMM ATHEROS QCA7K ETHERNET DRIVER
 M:	Stefan Wahren <wahrenst@gmx.net>
 L:	netdev@vger.kernel.org
-- 
2.53.0

