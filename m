Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC3372EDB
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315601; cv=none; b=ch0vjfAHgSGLVmh1fwGq5tzm6PolAgOm1ZdhEJB4ehM+qYgIFw41DO4WCwtmlyb2jeMoUtgfPYpltpBsdtOKpE84FpHTXmsuVWUoWtP56DkMPvRnxlnnhW4f0ktRtFhy1tsWavGODIW1vIEFiHvHK7kVWQVHqkIqGpRf9SYj0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315601; c=relaxed/simple;
	bh=vc9oGAqRaMzb6Xdaj+3NGIpap5QZHwRnk2S+pTd4Ur0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcAAqcFd6qlcshlPe8ggemItQOndYozrj3JDwNlPh6v0ak2U/RJDpNyvGmx/RCO7/kdCF9/hAt0skw/JUVcoo8QXU9/XJwCjL32Nh04mpxgnQkotZgjS60k+rMJmnX4ejZhinIlGsYCbHVPzXeK59KPPN7DFvozluK40hXxu9Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tINavzeZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tINavzeZ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cedda2ce6fso5498015ad.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 05:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787315595; x=1787920395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vwKd+TdvIX9ZItYpiwc95hBpIK2+IZI68PvC5hF8oBU=;
        b=tINavzeZOKMANcMRwKeEUWydp5nWIoCKCrIuctzNkQTHBo31qrRTSBUTIDJjtxHnsi
         h4p/Wt+VS7MgdRRg1DeUNAnR5t+m9OXzxQGaGegxWFUNw8MynWuU63q93KlaLtzkt4tD
         fRwMOkbWF8ApoG2dkDeCd0zoPmtpuv5aAqb2Tk47BR2+tXh8Q+GHmkikR+BZQ9rGo+xf
         dSOJbOnrTCWLmv5W7rnGfhmNWha2CKjeBYNugHvOkpy+wj3UeqxabEacwOhYBZ814Wz2
         meBrQK5cu/cUu6nENqQie/qHivE0WKpUZoNslaNbFVDJ0EZdODKp8Ra9D5MwnMAdPIVX
         tP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315595; x=1787920395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vwKd+TdvIX9ZItYpiwc95hBpIK2+IZI68PvC5hF8oBU=;
        b=VsnAMVcQ97yyMK/ariPw+TKz3q3cuNnM1a9zt7Aq/t7eFxSdaqKExnzJsIRbcdHfur
         ucrhrFWIl0MLlHAm9hFus8E2b11d44W59HKkJkqNuDNQg0KBiAry5qwuCAyq4Bd5KXn2
         86X3pAFRdnPlDValJmP15HDcKrmmTi4n7jmltD0Zuqte4P5PHDhQwK+E1a1yckVosdqT
         L+73mOP2OhPkH3Khj99dx5sCJ/P2KBNhX/BHQEVlpklCQ4fg/4jzJ76XDpwKzkAMpSHz
         bShO4aVtTUH6khxoCRIgb6s+1Uh+9bU0Fab9cmm/rVkPZnnb4gG8G9qS7zGXMOIMVbZx
         ZLiw==
X-Gm-Message-State: AFuF++lgIxgA7GQFTNK8PubOFTkOk+Qp4B2gJUHF4RS1EWh8flURMyn9
	Lc6FqK+pQX4bOkFrF6XHngxPaZge7TRxj0RSfuZCSq28nHWxQ35yOOFPVqhVXQ==
X-Gm-Gg: AR+sD10CQx9xo1TgV94s8tYvwEr4Bys7M7Tfqc0zd52B8npQj56ATyj+IcgLfr25EFp
	JdiFxWI5+qMQJlt9+Z5sngD8AbXrQivL99++xSo47RsyGTyIYBjRxG8g+6/Abryh5EAUE0CWTw6
	ny9AnwNk3f6zuiTvzIgGAqRazrOPmfa6yfcCkgbjf9wSgCVK7TyZKvs7CwJQkDy67cxMAql6L0j
	Er69DZDGKH9mBNkrhiDZYHacIqm5wfAxspPcnWnOfyaLw/z7Kzpq2sRCX38wsn/xVEVi0vqmHQx
	pHYjs7NutoZoyz17e2J7QwbA7l3NrFAzaH43jZ0tqZPZWQQxLzYhaYCRjgckEYcCwNoUTuTWZnh
	1AThXHjxT8OqWKty7PfbNEOn497m9GoUKvCXP+zIzHQ2O7d3omC5MgwupFLztWdD9sdHzWyu+5X
	JLmFcOP7u1gQEKiTYXYHw62wXp6rYFWaoCiounPrktQtDk3+GRs67wtkkmDHaZQl80O9dWJNnQ/
	9q+7wn/C2ywIEuZATEC3412daltHs/ATeArJlg6XlTrRMSCCTHdKx9WLuidO9M+hpu6nDcm58xn
	c3EmEv7Ia/o8t5c=
X-Received: by 2002:a17:903:3c6c:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2d64adc5f3emr120824505ad.5.1787315594849;
        Fri, 21 Aug 2026 05:33:14 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e36e1d8sm18402285ad.52.2026.08.21.05.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:33:14 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net v4 2/3] net: xilinx: axienet: Handle optional IRQ return value correctly
Date: Fri, 21 Aug 2026 19:32:48 +0700
Message-ID: <20260821123249.41527-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821123249.41527-1-phucduc.bui@gmail.com>
References: <20260821123249.41527-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

lp->eth_irq is assigned from platform_get_irq_optional(), which returns
a non-zero interrupt number on success or a negative error number on
failure. Errors other than -ENXIO are handled before this check,
so -ENXIO is the only error value that can reach this point.

Check for a negative value instead of treating 0 as an undefined IRQ.

Fixes: 522856cefaf0 ("net: axienet: Add optional support for Ethernet core interrupt")
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 207aecb5f8b9..3927ababf833 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -3052,7 +3052,7 @@ static int axienet_probe(struct platform_device *pdev)
 		ndev->ethtool_ops = &axienet_ethtool_ops;
 	}
 	/* Check for Ethernet core IRQ (optional) */
-	if (lp->eth_irq <= 0)
+	if (lp->eth_irq < 0)
 		dev_info(&pdev->dev, "Ethernet core IRQ not defined\n");
 
 	/* Retrieve the MAC address */
-- 
2.43.0

