Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDBC421246
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224537; cv=none; b=D9IVpZEERoJYBxGbtX6d8ws6JiFUzAFzdGocC640A7g6MzTGGVq1Yy8LqhC5R7ZlPqzkYawqPqyZ1qLJdvuUTJluCPD33+LPKcuD3tXEaIuEZF+EdDICm9BXcesclih5iWkBmAt5jBtcXOu60HEntZaJ5m7dWoQT/uVNJ7WXEr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224537; c=relaxed/simple;
	bh=1x2GjawIorbw/4908l+ScmK5Fw9DJ/ZcMIgpbcs16xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnIy/tL5lN7igv/rBLei06i67hheSD18K+I6qMrOo8vip5T7Ai1PN+ay5NpwX7xZDDcDZ+wVAewFwq3/BoKtXb5OtvKBQk0SZxiPq1QcW8Pvwx6ibmNX/PEfn5/lbOUZhlv0H88tooPYfi4F5I9t/HXeympc56dJXmMJdNuto5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4qavLid; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4qavLid"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1469c1b83so2080659a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224535; x=1787829335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3splNz+eKCLGRh8XFY3AA6oSixILCEDeXRfbtthshOI=;
        b=b4qavLidcS7rsxUKMhUFKAXMMRSMP3XCCZc99ChEsGt6Xc2PGmpFNj+mEPxVZs6DVg
         zCxsbOlr2EJSJWSxvRP2o9Bsl9NPeiNPeRh0T10wg5u1fwNffEmmn8LqLBvA5u5M/svG
         ow6yC8Spw03t/+5qq2t9rgNXYvmbJayRheO+eAUZzDeALp2K/jIBjIOb69PTV92Hp1oE
         Nfs0R0lbQXVI0Jw0OYx5E7KOQNri51vYz/F3ERN/0AcSBV2Q7h9ymIeGQP8VeM8fBcpn
         XNDD8+C4TqjWBHH0lCKB+G291sFBBuHu7Q+uOhEgGWopEWMXmO1fCpRDs/fkem4M9zTE
         TTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224535; x=1787829335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3splNz+eKCLGRh8XFY3AA6oSixILCEDeXRfbtthshOI=;
        b=aS1URQDjq2FTzm9IYoaa24LDQVl+IELGElNFSwCY/9Dpp8Arn5s2T7zGOvSdjo8xRL
         qQP4hFbheDswrAhSrGRKEbGlKgzloGOOmDCfmQnq+V5wPPRhRhTWIAOPufqUcIBWBNto
         ciuxTQ06YFAsaB8IsGilMJ6H+25wHwgJPxESR0/6611fUd3CWh9v1G7u+uMgPSRYadCU
         ylqdJJcf+a6bpgVIAbmWSFAGTosDFrf43KY8ghzJwmQvvHjgQz02i+qOFWHLF9fdUtc/
         5BHjSr6PaWUsYh8GNDLikeVf3bS/oaZ91MfJ1ORuhfYh09iF27GLepX4F9cQrbhRovaq
         a72Q==
X-Forwarded-Encrypted: i=1; AHgh+RrVolkBQNc6QdiUOT1+3WcEOi7ddUGy/Bw/5180cWWt2wGEBXC58RZ2k+K8NWqQ6Oqd9wK+BFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsz6jjvfDMH/xWAdgDCsGQPKE8jNpa68QmwxP1XRE+W7MXdRsF
	WZV/mjORvaot7oFXS+aLksmfYZ25NQJXgh0QJx/uKienWYPXsbU9CobW
X-Gm-Gg: AR+sD135UZuII1EYMaGtw6SdM+BuYBHMLzf/vH6jgVUAH4KyrRVe1WbNtZo2nVhUZaK
	Fcg7+Pgz1OBvdZ/hyx024wjPSqokRy17Fez0sOLS/nXddAZMGN40gmMgNAu24N2gkLVNnzYKIie
	GZEqhS5MExypHt2iQMttDfn/bXE4l1N7o2GSHeFDC4732LZRbjWolM6aJLKOI/I4AtY6zvU2qtH
	51qOYikUAFVeEtz2mM6/DkQgrbsu6oWCbmZyGq0XV/+nM6ViqBzxX2EY8YHUQasRYQqkgXuJ3me
	G6uwcVgKMDtJcZ1JTegTTSYk+462VC6PXRiyHQRO6uni0i7vddTHnnbATanzTQOiYn2YAsRnLrn
	Kl6GkEE6QEXWWKGm3QyDcuDByRBP07Kdvn2qM/U77NkIeBo4OXAg3EqZXWVfqDJ72DGoQKV81CP
	ymKl7UjewD1b8L0+HnmL5Eoky1Ym9tLLPI0RKQslsqZbHHlXfE0afymJoztiw3ctCjQuESZnByN
	F6B3xX47dTpK+l54GIIrdguTnwiWkxc7YAQS4jDsfD3hKqpsKPgoy3MNjjJSx/WZ+/q9djWJtQK
	WmSi
X-Received: by 2002:aa7:9319:0:b0:846:bc60:5bf7 with SMTP id d2e1a72fcca58-851d3862b53mr23055166b3a.6.1787224534715;
        Thu, 20 Aug 2026 04:15:34 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15568c722sm1676503a12.24.2026.08.20.04.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 04:15:34 -0700 (PDT)
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
Subject: [PATCH 4/4] net: bcmgenet: Propagate WoL IRQ errors
Date: Thu, 20 Aug 2026 18:14:56 +0700
Message-ID: <20260820111456.97947-5-phucduc.bui@gmail.com>
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

Propagate errors from platform_get_irq_optional() instead of only
handling -EPROBE_DEFER. Allow -ENXIO to indicate that the optional
WoL IRQ is not available.

Also propagate errors from devm_request_irq() instead of continuing
the probe when the WoL IRQ cannot be requested.

Found by manual code inspection.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index a2305e6428d1..c1c66a52efd0 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3993,7 +3993,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 		goto err;
 	}
 	priv->wol_irq = platform_get_irq_optional(pdev, 2);
-	if (priv->wol_irq == -EPROBE_DEFER) {
+	if (priv->wol_irq < 0 && priv->wol_irq != -ENXIO) {
 		err = priv->wol_irq;
 		goto err;
 	}
@@ -4033,8 +4033,10 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	if (priv->wol_irq > 0) {
 		err = devm_request_irq(&pdev->dev, priv->wol_irq,
 				       bcmgenet_wol_isr, 0, dev->name, priv);
-		if (!err)
-			device_set_wakeup_capable(&pdev->dev, 1);
+		if (err)
+			goto err;
+
+		device_set_wakeup_capable(&pdev->dev, 1);
 	}
 
 	/* Set the needed headroom to account for any possible
-- 
2.43.0

