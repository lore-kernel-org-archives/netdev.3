Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3315399365
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781970813; cv=none; b=PHFelzB2he6r8JUA2IoJSr518mC2MGuw5yEEBfK2Z/vXMZUqW3HUiQQXBCuGxN/Jq3x0ffRzoEDK3Yj3gxxi8eM4Io1HxAMe7pgkM1LVn7x3yYKPrCIe1qlZild9GH3xLxgAdF3/p+na8eY1KYC2HXw8Y9U5Ecf/PRN+dpukrfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781970813; c=relaxed/simple;
	bh=27f18OOfD1wCLKfucVJgwaw2m6et21Q/k59tBorfEmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pM7xpRIJ6VSMw3WGhfqkBSL8z13RauWntXNWjWXgsmxsdUikEjHI1x4p7GE+d1bZO3oTYX+yJoFQURz7pNJeJl1uuIecEbSlme7hfJ/e6PlMu+9822va29fuMfWZwJhURDWoQbknkvgtW12mpsJcHEQjao5yZvVnTjt7MmH9mbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egpiAvWV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egpiAvWV"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-845537740ddso779975b3a.0
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781970812; x=1782575612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=enS82+dUPNj0lLplgn6nU4h7gPttfijjEVh4iX+6X1Y=;
        b=egpiAvWVeKL1+HlZwS6Rxkl+HthOb/nfxCycvBYlT8/feNIa0LODwbEwF9Q31aGZvC
         n+jMpCJ5dTjwrVp2k+LDZYAbHnmoaz3jcB54zDvlfXUiWj+HP5wzeXElUPX5k0r/t12C
         yDS6kpJhNU5JTFETTiDZ34p7rblakFAWh42nAzTxUJVaxd7ORdsP77Uh+xIP2+k+AcSY
         +NiEL0vWbDHvMeCMz85rMT8dKcTDkUP2pU+Yk2A1yr7CMD9vg3CjY05njt9xfLi9lt5t
         8HzvZYS5phLIGdRnsTApYry1y44C3J4IqsXIDsh6ao1ByjEZ3XEeHCMlEuyXV8Qp/wor
         VZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781970812; x=1782575612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enS82+dUPNj0lLplgn6nU4h7gPttfijjEVh4iX+6X1Y=;
        b=n1kRZMFJUxYqoSNW99iy1vRnxRDvLqCF+eCHHFiKk+3mtf6HYMv3SvAQOehcEgaaly
         ANMq0WdHZHrJYtg7EYEcn34WjO4Ojpu7XmQbXREx9DmIxtzJB7xyvgV0ut5NRdhmAwfn
         1kkQciDiwfEty1KazWa1aT4kBBMnMLsj21udTG/brdMeDdu4oxZExiHwnwROehd91qLz
         /7u/csWuS2IzujVPq3zXY9gCytcjzrK/M+rOvbQKAt3C8yXYyFpbl5p7vAelV5F3hn+r
         B+0QQp2MtZWG+cFYALmcJWXP+BpGMgymyaeAdItVHLtJf5kgOxMw3z3CKt7xo8Al5RBy
         kOEg==
X-Gm-Message-State: AOJu0YxTwHT67XJInk9zeOPA3F7r2g3JzE747wK4Q2i1oI2JUgzHy4KQ
	6xlF7YUpxLmc45be0db89fy6N3idNPkdBbxoAGtUkyLhEdermq3boUZC
X-Gm-Gg: AfdE7cmKSZRQ5HRBY784h6LVHTPkrzDJCHalfb3sZhA6c+9xCDrrvIT90+F70PhfPcX
	yzxrSMwejkDeUudGYWICbSIhtaq11A+IzYpg3ePapSsP/3Q10aAQTE7RrAvWa2eysBG6xT4BLUi
	7hEr4F+jeh7dmur3Rg+YQUmEJnR897FeogEvisEPYfL9FxjCK2+IqeiDFdp1k6dB8uah2jtfZz5
	ykPK5ZStGZ8pdDSN+O4JoSapd4g3hDpxGzzC7/MNNArF8BuSer+iAc9p/P9dV0igM6ZT1j6j5v6
	ef6xd9ooS8E61ZCOSC1rGEKLv/C+8AgFvWYP3bcHosxT4EfUAIPkzVRLDpH1co783Qeyt0PCoy0
	w5oHYlUTsWnb7Yq5XBCl8So1r/9MyprSI2xZb4RZooSs3QV0Yl+qMOIWeUeUofIqAs6cEt9+sww
	J2gSse61LiHRLzi03cFCWbxCfKva3NlREP
X-Received: by 2002:a05:6a00:882:b0:842:2382:a0ea with SMTP id d2e1a72fcca58-845507de690mr8534471b3a.14.1781970811867;
        Sat, 20 Jun 2026 08:53:31 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:8e0e:956e:b09c:23cd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ed9516sm2555118b3a.57.2026.06.20.08.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 08:53:31 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] net: sungem: fix probe error cleanup
Date: Sat, 20 Jun 2026 23:53:26 +0800
Message-ID: <20260620155326.80582-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gem_init_one() calls gem_remove_one() when register_netdev() fails.
That path unregisters and frees resources owned by the net_device,
then probe continues into its own cleanup labels and touches the same
state again.

Clear the driver data and remove the NAPI instance on this error path,
then let the existing probe cleanup labels release the resources once.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/net/ethernet/sun/sungem.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 8e69d917d827..26974ee71352 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -2986,10 +2986,10 @@ static int gem_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->max_mtu = GEM_MAX_MTU;
 
 	/* Register with kernel */
-	if (register_netdev(dev)) {
+	err = register_netdev(dev);
+	if (err) {
 		pr_err("Cannot register net device, aborting\n");
-		err = -ENOMEM;
-		goto err_out_free_consistent;
+		goto err_out_clear_drvdata;
 	}
 
 	/* Undo the get_cell with appropriate locking (we could use
@@ -3003,8 +3003,13 @@ static int gem_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		    dev->dev_addr);
 	return 0;
 
+err_out_clear_drvdata:
+	pci_set_drvdata(pdev, NULL);
+	netif_napi_del(&gp->napi);
+
 err_out_free_consistent:
-	gem_remove_one(pdev);
+	dma_free_coherent(&pdev->dev, sizeof(struct gem_init_block),
+			  gp->init_block, gp->gblock_dvma);
 err_out_iounmap:
 	gem_put_cell(gp);
 	iounmap(gp->regs);
