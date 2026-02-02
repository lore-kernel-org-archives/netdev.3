Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0773009DA
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068814; cv=none; b=sk0BJ/OOuEcGyBlUhjFLJX5gNsx4R9X+LyeCI5DgXdSUC1SoC2af1msNHA1eySCrLEmpB51SMwy4oqwK+C7MvDmtbIlWSsRC+wLgr+WIVlKSBRLQniP09eGzUUbdANSJLYrFcpXcOu6O8RmvSPEK1li2jmeYHQPhm8L/WOGp4NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068814; c=relaxed/simple;
	bh=xdhHPYeAdFOZYR4Zg7U8+mkp0K+rotzh7dWu4j8zGwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVZFBaUccsOs7s1f3o87nfOjfz06Uq4PNgvDtxKAwH+Sf/rPXgV1l+2x0LIO1w8i8RqURngHVU91V2DdUVuaxB+IGsOEZQQsbaDu990oUA0niNVvDassMQrXyXh3RYPOXh545L7phJwlHTr5PJLjtkBzdp6m/u8oOGWuv8OJb9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtFskrdB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtFskrdB"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-352c5bd2769so2943221a91.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 13:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770068813; x=1770673613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHIwykhdUieAex5HshaCUwDG1Gzu7+lRTTqsGi4c63g=;
        b=PtFskrdBj5y9IaxKIuryc4DfPI2fbAqXroyEUMqoWYQcbCRG79XSE4YeI9U/0QTdUD
         +5UsOnOro5ncwDfSrwYY06F7RabP9WrjF2INrPnu0KBdKjRnAwN9i4k5aeo1kpA7+U10
         MUit6nWHtE+TAKsqgnBCPLkyU+jXuEmXoYUwL09U/MhzmtdJ/HMKMlekee2I4ZaMcrXl
         EHRY3if2cy0/BVis5T78l9v5N6VYz1OUXg6LkMPHi5Aa9AzezxMuAGL8u9kaaNMg9+Ex
         MPFQsboeG4J7CXcNuG/AVDa/0lcsASk+noJlqMnVI2W3XudBTbqUhJuq4kEfod0BM2K8
         cEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770068813; x=1770673613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jHIwykhdUieAex5HshaCUwDG1Gzu7+lRTTqsGi4c63g=;
        b=rnhmHZjq7L8TNNaPz58w5mWg2gFY2YmHhnJsz3EUNs/W8eK5SPi/mwlr1wf5ZJ8+eA
         JXcgL5OWObmrXPIBHkKZju/bJDoCNz7Cig/iKP7BMY7BAPMLx+NY314PB958glav7A8i
         8ilT6vtbuOJCidgkdKVJrOAgl4+qqDktCOVrYGeNw5SizoNKLDa0EyA3j1axAqpseP38
         dU44XZ3fB9MSJmiGj0JpMvO5vQHwcE5uEpAbU8iDNjFfCSm22OnwJ1CDOIpSx4wyhvww
         U6TtkAIrjfEl3FRkOYrGNRg+sDCyeb4IdRtz/FwuH9tGuGTTTEksol9rdFc29eAVzgC6
         Kpuw==
X-Gm-Message-State: AOJu0YwthSJ3iJrij8aOibq2Lj/szOUelq4cxbo6KBwbQTC/Yxwvxb9V
	qVum9r+dC7/RCSprbccvEEnKx9YFjMq0unAAbfz+AXipFdSLMUwsqFhVENZasA==
X-Gm-Gg: AZuq6aKx6SZWeNzgb+uPtuqFsVQ9nnXfys2x1syZUKr2hAIW5RlD2ORIEYbI+OXjwoz
	A8sLbCk7zS4tkhlUsagBaqT80TXAnADG9vWgnZBD/0cEQCPLUXBMql3H0Ps7qIhzV5rosEMpQ4t
	NdONUmHCDxB4Pww3iluE2BwOh/eMM34l7n30vaol2BorfoWN1sutRSc0Vg4trRb4+2VJWhxKPNe
	1t8qMXTtS0GwCtryC/PYsYJNyo2ivS7gi8SK2Oo4GJjN6Hcx1/AAsL899C6tKB5Do0GzSvrRit4
	VlZICcLltKfoKUIF+xTQmtjDeYvQ5owdgmj3B/w7tRnmCjX4uQckPMiRpVl+VDnzJsKxVal4yb6
	+NOgG48iDyalizUpv4gkhC1vx61ux6HWaQ4a2B9avN8G/dfoTf6un9teYuA==
X-Received: by 2002:a17:90b:578c:b0:34a:48ff:694 with SMTP id 98e67ed59e1d1-3543b3b5d3bmr11004585a91.31.1770068812658;
        Mon, 02 Feb 2026 13:46:52 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3547767cf29sm391215a91.10.2026.02.02.13.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 13:46:52 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk> (maintainer:SFF/SFP/SFP+ MODULE SUPPORT:Keyword:phylink\.h|struct\s+phylink|\.phylink|>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 2/3] Revert "net: ag71xx: remove platform_set_drvdata"
Date: Mon,  2 Feb 2026 13:46:33 -0800
Message-ID: <20260202214634.72738-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202214634.72738-1-rosenp@gmail.com>
References: <20260202214634.72738-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 94656823c1ac31b35549fc0d96cd7862254e7c3d.

platform_set_drvdata is needed in order to destroy phylink on platform
device removal.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index f2f12642529e..7114f2970ac6 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1921,6 +1921,8 @@ static int ag71xx_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	platform_set_drvdata(pdev, ndev);
+
 	err = ag71xx_phylink_setup(ag);
 	if (err)
 		return dev_err_probe(&pdev->dev, err,
@@ -1929,6 +1931,7 @@ static int ag71xx_probe(struct platform_device *pdev)
 	err = register_netdev(ndev);
 	if (err) {
 		netif_err(ag, probe, ndev, "unable to register net device\n");
+		platform_set_drvdata(pdev, NULL);
 		return err;
 	}
 
@@ -2035,7 +2038,7 @@ MODULE_DEVICE_TABLE(of, ag71xx_match);
 
 static struct platform_driver ag71xx_driver = {
 	.probe		= ag71xx_probe,
-	.remove_new	= ag71xx_remove,
+	.remove		= ag71xx_remove,
 	.driver = {
 		.name	= "ag71xx",
 		.of_match_table = ag71xx_match,
-- 
2.52.0

