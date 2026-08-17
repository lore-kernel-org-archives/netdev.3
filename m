Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CE3559F8
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002223; cv=none; b=pLSz6nYiT5nW45sCzPfWVBmYFDJ5hjP4gYe8mckestzuxVU0T+G15SbyL4UN1vxGHRXF7NvE9JrYhyBnOrZqZ78aQfiKM4eUMzRU1N9+BGMUSz3PhlhmMmc3PpwcFqsEhX6KQZ+zOfryrFB3u2uwiv+yQDJV8UXFMlkqkebXoIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002223; c=relaxed/simple;
	bh=+zOGPOWYYp3mtciY4HcVIIxjyTC9dPPH8Oh+OEDd3Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TFEqBUUW+RcbaAgu0uRaWe25Le/nS9F0EQmd1ZBtgth6OwJPbCd+wblFgjPOHuOYD7+2CespOCns92+qUi7sfZV2WGGD0Cc4jKxSTYBSw+iGa77cJ4nE+AsAqPsSJDZjBWnzemfetkO53eGyw1nRCFY9Aa1xs/9v8Ad79sVWa+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5svpgsh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5svpgsh"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b966dd74so26127635e9.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 14:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787002220; x=1787607020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yjofeyvckE+h5b1Kd3kTyp8/0NYwS43KnFfuXKj6AwM=;
        b=V5svpgshtoX5MkrnC8UG0gjG6PY0aohr3AJjCDeIzXTfI4oNImEk3+Su5RsZzmtakm
         +xY+FGKBWGQ8LG0m+J8HOLjvcVBXc2lRXTiKMLUdfbq8t55J1bnxF23Oiazx9h4GENNY
         OFAtyrY5D2mKqnSxZN1+tCawbxQT53PjXF4chb0Zhson9T/kfBOlz4RejYGyUpkhXs+d
         qPXy/V6absXX/qzNakEr5WEsUOi4BlTQ3ZrU1EPTWVuBAbGvCGlpdTAybRzFwA00wiHk
         qZ8RcCfyGgPVqLdyHvFoWEp36b8NwUkV0xriObc+GISM+9V33Oeeny65N253VSx7auTV
         QIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787002220; x=1787607020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yjofeyvckE+h5b1Kd3kTyp8/0NYwS43KnFfuXKj6AwM=;
        b=bLcX+HBrhDOWh6ggOkpnh0i74721FJqGygTQpnwXfKjmG4WtI5QeGD0FrgyF+9P8RS
         6drt65G8Bkoj95gWOH1JZ1CEVLdOeYG6jKbADmWwvUxA+h4rSMXzYQdpqmyJol6uF81G
         tt3sbO2kxNFi00Z3pgPzV2KRbuM3itWq6u70wBBnN5rXVq5zPW9saobH3w7DvRuhOBEG
         qRJchFLeCqfLV1/vi7DJmTqB7P0DpSo9IQmj0TmmZ1nZNsCFwfLxHeCcXyqGvdLEAPFA
         DMZlRqGKcbIeeo3UTJtsefDUqEYRvxSYMsQkxWQZMWpJf5hBhr2+0DKXm7u11iipLqqi
         0CMw==
X-Forwarded-Encrypted: i=1; AHgh+RqwyQxRPI2Cj9+Kg7IQrIlnSorOGdYlgTjsnV57zmIY5rfzl1c+QoyTx72Kd+dotyhbp9i94uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ywk1oDUZfSxucMQFDEaaIg+miPd86LC1Dkeff4YHDn8RgfQz
	tfCZFqV7H1O6rvIfbrD/1sxSzneIFcuGUwDMpiBRFiahTmAsLx1J5yRj
X-Gm-Gg: AR+sD11hPNRgoHxbUA6BuYeCPD4rxHN52KIqnLX2cvT6UNZiReOuw3+APjzO7zNgnqf
	h8ourvdjQcnAtxayEqau7XCub2H4Pcca4/4DGhZy2IRWRHyj8my4ukRzbS86pZfQm2cRYmB9o/c
	OMTAbLFPAQQYDpFZAAZtrs3E86x3YRBmfPZib1nHlZJyK5ft++dCvpblwtptHZNOwAtNLin+F5H
	fEy1AJ3jzHEB12ZUcT5FIzPx9ZqncS7QwLovCxxB6H+1Q1M0Jv82RtIgMB15FMwqhnTGqNcxTY2
	g36dmzwYu/8nqy5h5YO0fZ3GBAwAsRJWoyEtwLIz5Bh8Ay+hEfx5931O9hwFqjPMXm0a2PEDVjm
	F11as/zXux1shuuxjxTM8am3eaiz+IKeS3KdA754UT10HB0pUaIgaN3PP2Cv+5wunjOH/KTvZwR
	QjL4kINZvF+bR4XIATl5sJBBsFB85kyr1s8PhiJWB1y+b9P5n2FKvGSkrZRvCb44bj30tUMZTsu
	g6XJYA8CLb6YSiyJUnMs29X9kVC5a+vJjDbh/phlWu2GtLE
X-Received: by 2002:a05:600c:19ca:b0:499:7ce1:d8a2 with SMTP id 5b1f17b1804b1-499879426e9mr360090035e9.8.1787002220485;
        Mon, 17 Aug 2026 14:30:20 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-21-27-15.retail.telecomitalia.it. [87.21.27.15])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4999d0876b8sm107808495e9.8.2026.08.17.14.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:30:19 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: phylink: correctly validate returned PCS in phylink_inband_caps
Date: Mon, 17 Aug 2026 23:30:03 +0200
Message-ID: <20260817213009.13924-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In phylink_inband_caps(), the PCS returned by mac_select_pcs is only
checked if NULL but mac_select_pcs can also return an error pointer.

This can cause a kernel panic as phylink_pcs_inband_caps() only checks
if passed PCS is not NULL and directly dereference ops from the phylink_pcs
struct.

Use the IS_ERR_OR_NULL macro to address both case where the returned
PCS can be NULL or an error pointer and prevent a kernel panic.

Cc: stable@vger.kernel.org
Fixes: df874f9e52c3 ("net: phylink: add pcs_inband_caps() method")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 5b8e956902fb..3ec3bb439109 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -964,7 +964,7 @@ static unsigned int phylink_inband_caps(struct phylink *pl,
 		return 0;
 
 	pcs = pl->mac_ops->mac_select_pcs(pl->config, interface);
-	if (!pcs)
+	if (IS_ERR_OR_NULL(pcs))
 		return 0;
 
 	return phylink_pcs_inband_caps(pcs, interface);
-- 
2.53.0

