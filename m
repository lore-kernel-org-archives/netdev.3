Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979CC41D101
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224533; cv=none; b=m1YWKSeuQQte0AI0oT6U6qi4aLSwddu3YrQrtczyIk7cNwStjzvFRGql28OoLm+l/Xikt2bwfcehUKSq7V/yv55nh6xTqoqR6fifSkDHNQv1owfd0x3TbVT81CX/Knf3pQjebKPsvXVupZHuOR6bUQLWQO8WjKkHgq6t8x6Kp+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224533; c=relaxed/simple;
	bh=o5CuQsLtqAHkVCYO0+td7xiYDLntqu61PDPsgViuQIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAJ5/vJ0ddXpDuICVxYn73/XH72hrgR7f71uBWp9XCMRoJM10XyN3wupBtxzfJ9ainWCX4jNqoKh0jziAEkrgJ62dqkU4mfhiq4TawzdNq292CP6pCaZca8kl9bPebyf9qgfwZhc3VUa6/fC9Y8ejvbWFgxPvTaYpAwxDf68eZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efpxZWKj; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efpxZWKj"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84eb992a881so1662331b3a.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224531; x=1787829331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kXwo8eezAKAf2A4o/+O3GLjl9XPgejnrObTpGultTzc=;
        b=efpxZWKjmdjKc8Rgl4dBxb8pRxaF5owqeizHklNX3qIps4/V/E+yHT6K4fCdcXzKT8
         5VPOigTn7Q8QD7dFe8uVldtFVfHTfDNURJgj/tvvciQXRNB8qlxowzReqgS+nr1wZT0K
         cWmlplD+y6xdIAl3iFiMupZQUHPQwJPt4bUxDXthshme4QsyGZbfH6WIjq7pcHlb4ZPh
         VegLNLRE8AjsiKcG3b1FwEMih6QvDMhQe6Mifr/GgoMmPmRzI5WRc9QgpFI7qZmK6M4v
         vwRHFK1BUKMkHoil+KH3jNAg0FWe6ZUQAFlhmAqeKkcvJ+SfgOhKEBEdildVoObr80x8
         257g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224531; x=1787829331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kXwo8eezAKAf2A4o/+O3GLjl9XPgejnrObTpGultTzc=;
        b=bW+1X1TdWh+an0BAK3nsFOqjBdMHvljFWJEqGIYnpnayi9qIFlTgmyyAL1jqU31peY
         fZMvF03Ep+JYtA86u6xMSe9+0BTurOqEVr/eT3nu6+0mbTPBk5PvYHGoSdjGpE+d5wUE
         gBv1QW8SWLMVmnNP2WZw+KeYVzbUZzm8QxpolIftvOEctBj0OR4zeB0VzeymGdr5ZNk4
         8RyDCn/EA1henuTXWugy6PQk1lYMzcnj+aDfEGk14p+yJjuSvQFwerHLP/m48l1o9Zlf
         fI9/4pd9SJh5xvFNX/32innz+BQtHmDHg8xvtpbhDl970fj7K2s5GoZdk7TBd1aY02tp
         WSMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpe0ylEBhN6+UcjkoulURaUzL1Rdl57VXVVVMnzay9hTkRPlm2loqQI8TAAJiPnpsbrSKI5MYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM9ZNMLWOJHzaQsRlpWPvO7N4+uesG0QN3sv8wYG3sHol6pCDD
	++2Nnm+hdy4VLve2n4WeXE4XPpSz/U2NLGYP/GySFHTb17Jxhyh4x44p
X-Gm-Gg: AR+sD13zSQKx6dhX4BHhTK52MUB+QA2PeZAhL8JuWIFFbJcCwdpo/6+VS7Xw6x7GGS0
	xSvKPrBwVK7mb5Wk9Q3l3LnIbB8NjZTG9OU5oMh8Y4bjru+f1D/+IgNckN6Wrt2I2HcmWQwlwoz
	sbh5Ke21hpstPQgV3eKiZZcxnbyE7zy1kbJAg+IOT84CCCgsqLDN6KhqufXT/a37hKDgMhlcGqv
	siXkn/gvHyrCsfIJSQCci6WS38wZxCUwxIgDo06O2xI9+7Gqanw+2WTXHjqG6bidm41ayD3xK3c
	X+8XJLE5dEt1o+gbV+P6Kjiko0tl3vwVeJVYicQWDuqaNeTZxIgtIjgesqJ9fTT7yhx2Q8LkjJg
	wUaAjY/7J0SMAKru6iQ+RsXt1kZ0Rm3tJ+EkW/yw+ew83ZKlJ6Oa33a2tKwlIA9YqJlg0XXUAaj
	0RkItVlH3brSMXIqdTiqxzhifFT1fbgnTVDU0AsODUca2LW2bdG7jNl4S8YwRM29zKBLej2LTqW
	9aptEEx8zHc9Y6F1268VGahNQash3j+9IeRHAvFRSXmYYOuGqom3yqKLgmcqshrdACKh+QPwx78
	PHYF
X-Received: by 2002:a05:6a20:3ca1:b0:3c3:66c5:68d6 with SMTP id adf61e73a8af0-3cd00f77410mr21961884637.9.1787224530717;
        Thu, 20 Aug 2026 04:15:30 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15568c722sm1676503a12.24.2026.08.20.04.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 04:15:30 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 3/4] net: systemport: Propagate IRQ lookup errors
Date: Thu, 20 Aug 2026 18:14:55 +0700
Message-ID: <20260820111456.97947-4-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820111456.97947-1-phucduc.bui@gmail.com>
References: <20260820111456.97947-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Propagate the error codes returned by platform_get_irq() and
platform_get_irq_optional() instead of converting them to -EINVAL.

For the optional WoL IRQ, allow -ENXIO to indicate that the IRQ is not
available, but propagate any other error returned by the IRQ lookup.

Found by manual code inspection.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 4d06c6ba6641..2acaffccdb08 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2499,14 +2499,22 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 	priv->num_rx_desc_words = params->num_rx_desc_words;
 
 	priv->irq0 = platform_get_irq(pdev, 0);
+	if (priv->irq0 < 0) {
+		ret = priv->irq0;
+		goto err_free_netdev;
+	}
 	if (!priv->is_lite) {
 		priv->irq1 = platform_get_irq(pdev, 1);
 		priv->wol_irq = platform_get_irq_optional(pdev, 2);
 	} else {
 		priv->wol_irq = platform_get_irq_optional(pdev, 1);
 	}
-	if (priv->irq0 <= 0 || (priv->irq1 <= 0 && !priv->is_lite)) {
-		ret = -EINVAL;
+	if (priv->irq1 < 0 && !priv->is_lite) {
+		ret = priv->irq1;
+		goto err_free_netdev;
+	}
+	if (priv->wol_irq < 0 && priv->wol_irq != -ENXIO) {
+		ret = priv->wol_irq;
 		goto err_free_netdev;
 	}
 
-- 
2.43.0

