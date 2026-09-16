Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B11E3ACA46
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538366; cv=none; b=Yl22f9I2H1HrDf3nAe2+CnGcJWCNaWkN4hUyaEaUlGoMcHJxEEncgSgnMkZ5GTIDpzlfehyWaGcvi3Q6Oii6cVFOTykuA9BfKKymmZUT2WuBlPRBa353e4OpeaqCG1G9Np63BnTrqhOj0DZrXe8pN7lmO8jTOBiHQ1xUZYlHtBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538366; c=relaxed/simple;
	bh=djRbzIiovJx+oLFaryQwnSgtVMfADKF8NqdeIMo63GU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NAx7lhjmD0tOEhzg5ZbxdJKTIteVrWL7j4O99h9NNxpTG0BHS8T3maUxUDsNbOuqga2JZ3XY2d/jDJ1AnL9WY98nlY5uADHs9QQq+BcLDKKQrh1GoT42gBtM8IJyc9CPsMRqiTuQgFXKcv/a9mZnME1Sggz2CPBK4dXY6hsH9IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sTcyZZXf; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTcyZZXf"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so393145a91.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789538365; x=1790143165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wWnmHAMPdOzeGK3Sr5eg1RKJL6eIVjM91xJo25+AOg4=;
        b=sTcyZZXfUk2/One7Cm+uG2hb/OiH612/RGmaV4LXl0+kYoM5M6D33r0e9XCPi7t66j
         3nWP1MFlvv1mWEDGztNQmDOc8kCzDDAOFt2gNnyEb+Ux1uEUIq/iUXraQhhYL4wLODwO
         6zh+rd6ssiC9wIJ2gFNPlCRqMXpZLCc/bdfdpaew5meybg6+VqO19nO72t0wdiDEAF9b
         VHesrQDvXLyJayihOJHCJjcnq6KtV76jHksM/9RfHWqFbJnHwvyX5qkC+Y9s32gzp3Uq
         /osjkBBQxzXdcwUnCNMeOPcfWpjaJX63d14bYBOVGqP8xOiE4KaX/8/FRXmp4rvp+4k2
         k+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789538365; x=1790143165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wWnmHAMPdOzeGK3Sr5eg1RKJL6eIVjM91xJo25+AOg4=;
        b=sgOSQdwS3GDN0TeCpfmaeUQL5ZphGFRVY+OQ86ukriyHf0WmV8J2ZSxFTvcjJ0KNe1
         D/9mkJj7VVzpzWr+/VtD85lSjyqFXwFYlkr2gDmbq/SWUMY/CR4l1FAEb+kw71876U3t
         La8o5yzYKne33FME45zgSJxgfbl0+FujC4QUMcbZjgf/Top5bQfv60rGCUT4V7DHw8G4
         LI9dVA66MwO5MmBGJgDVY0A1l6DSVdw2/6NG1me/0mapHfjduxhsEPWe5j0h+eKUggei
         joxFZWjXZJJnU5DGxQBLTbkLvGRo8iVtIPwsPwgv0yQWltmjSWHxWqPnDz8rW+xLnvdX
         5qOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwx5JmQvpO56WO+IllW0e4tShHOe8Gy0Jg/wYkG9MHpNcHRsTi18hs1/BjGOyJTaUrAiXYZEow=@vger.kernel.org
X-Gm-Message-State: AFuF++lZajHyohJh4j05TiFk0osPR/LRbUy9bDHrOQCVJeXNX9kL/+1j
	S9O43Qpb1tBWmMAicy7grkldcT7yDm1Rn2YTxK7hrsuivp0pso+IxOZ1
X-Gm-Gg: AYBFou2sjLN08CEddJu7d1H4k0YHcdLGglMhBIPHE+13i22YWeiQ3G/qaiNSpsfQNIF
	CKkizmU3+O1eqN0GNel6tXryLcMcju9cGf2VAq6UwjS+NHsFpYlhAsPgX3UuumsUkBNA1l2Dmjq
	lUOH4FeZawnqsVVDlzQsFwrmWYhz0T+sRnUuJ5zXBBPeSIvFtmOfh6Z1D4gTUZUuO7VpAj/N99u
	3Tp33D7fUFV0Ua7yruLysCRPPGru3w44RSjxIaP1+Em22+GgJKTQLyw5ojl3vGBQ1lEpnL0GRwF
	ZL0HTcUimmIyuydaUpdcRUis+VDK1BM7HLouAjEGIcFGsgr2tz2F/LXgVtBWVM949ph+J9u/Okz
	GUcKFHPE3OiaJG0bUxFrXM/bimMRobf8fikCPhAeVf/qj4MDQjYA57TgaOSwCrhBi4uWiWhI3Gm
	lM2FpSfjBLmI6W4fztdKjcd8dq8UqkSig/nrOZk/i6Ay9+6cIpwMsQfQ==
X-Received: by 2002:a17:90b:384c:b0:39d:f615:725e with SMTP id 98e67ed59e1d1-39e1e4921fcmr2985136a91.13.1789538364891;
        Tue, 15 Sep 2026 22:59:24 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1ae99ca6sm2753254a91.0.2026.09.15.22.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:59:24 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jijie Shao <shaojijie@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Ruoyu Wang <ruoyuw560@gmail.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Jakub Raczynski <j.raczynski@samsung.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] net: sungem: disable PCI device on remove
Date: Wed, 16 Sep 2026 13:59:13 +0800
Message-ID: <20260916055913.2910349-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gem_init_one() enables the PCI device with pci_enable_device().

The probe failure path balances this operation with
pci_disable_device(). However, after a successful probe,
gem_remove_one() releases the PCI resources and netdev without
disabling the PCI device.

Call pci_disable_device() during removal to balance the successful
pci_enable_device() call.

This issue was found by manual code inspection.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/sun/sungem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index dc5638d105db..6abf4d292802 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -2806,6 +2806,7 @@ static void gem_remove_one(struct pci_dev *pdev)
 		iounmap(gp->regs);
 		pci_release_regions(pdev);
 		free_netdev(dev);
+		pci_disable_device(pdev);
 	}
 }
 
-- 
2.43.0

