Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88281340DB8
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786821887; cv=none; b=A5P2zMg/PR3KJslEDUbIy5qUAI84McdPxOnZHcYQKkSq0qu4WBSssBp368NXw2HvfLeTIkkG2W3bK4fT7E1yre5reRDLslCmaB70vGnaf9ZkLpXMIP3ag2Yy/z0eaaZYBDWZeQRZ9GrA+AG+Op8/fNS7cwKzkhUWM6QlXVcHn4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786821887; c=relaxed/simple;
	bh=szdQC/NtX3xi3uNHpemQZn4gh9hnWCosDs8lG/Mt8hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nriEa41fdUBdymp4aG0LBMmZWp9tIjhgLGijUaPa4wocGy49i2P/WCPZcmihivIhDGrUkdYQLJGZF7qBhjWm75To4x4l3VCM02R/2Qp9jFZc2OBPl0tx6DQxdrgrWaFqaJ8UkL1QRTb8mO/aVIdFiuRjvOrgL0B88cNVCUUsfYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqjOLuxG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqjOLuxG"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caea3f742bso36418615ad.0
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786821886; x=1787426686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v+cg1OP18itWhQOmvdwkWYBWY3QqDqTh8gAXvCoG3WU=;
        b=TqjOLuxGUyNlqbkhYwwWnWAg9vOvPcB7WHLtMWK7iZfFJiwFYSlLy0tk9BajM3yw7f
         2gmUEUoFouREF4PXsDe79NYsPIq3ImGzhNISXLo4Ky0LssCr+upXl0UPdQzE50jkeRfj
         LxgzHe5APHecHv45h9tDZLALRg2W5S8wfylMgDJDKSyEjKol6lD1bELA6y9MmBiAT5Bh
         I2P291Iyl3VL9aYhd47WpPjEZpRjbkHG/3JRtRWk7iHm2Pdq89JlCo90JzXPD0W0lwwx
         LZB0L/lgqFJJ4BwmCIWjhPiIqTj3OT8taHt9KztZxN0qPIabWZUcGWYTAbKLaBX8npRH
         7z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786821886; x=1787426686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v+cg1OP18itWhQOmvdwkWYBWY3QqDqTh8gAXvCoG3WU=;
        b=baxicFCRTVtLkp/WR01D7Ib+Zba1eGRV6TXQOAZFbuxRi9vVuuCiRapxiMXormYs5T
         6ta12Mkiz11gCPoKMJclOQWD2flhQbKTPsBPw0hWy3fsQHfSGW4S43nYys0xhJdKvSwg
         jez10ZyiVh7Ruf764DrkDAd02iOjI3E/4SxRZ+G6KYnYMBrzE1M8amL6R6hQUuXcX657
         ag4cE1VXOoE8mPItHH2pVtQTdkkPkToF7Z8v3hMRdR9YXI5k8Zbj+y5LPLuOJnDDiFeZ
         b5H3JCnlui/2f4yfrfHacK21UK536gekeR7qkNYQu0sf61wuOnHpHEx0Z4wkOQATkGGc
         Ytvg==
X-Gm-Message-State: AOJu0Yx9toRe+zmehGBxGLaKePD4mhVMIeGOsL1tX9zTYlv4eWXG1EN5
	aDpqVqW+yAyTAiIvDSeeYjUvtbyFxg+R6rDZx4eGiyQ8CL4B70RHwL+J
X-Gm-Gg: AR+sD11jvumKhhUB+Og4TQkobJzLcJ1lQ0sT+qFFkG/3N3nukSjiehPQY3XQpYn0Bqe
	D8P9/7iJ0XHPeX5euF1K1QczIB4S1tyo+cr1eWhwDihzXwO7YGFEWZAsB1EqfF/UwIdFYHgH2GZ
	fE+qHxu5sESV8/WYpbY4pf8Yo5mCoJ0fDPufxM8HzU2IbOiz1pVUuEDCGbrWj+kWtfM7WOtgiCS
	P1rFnkVQu/TasfCuUSpp9HNXjH5JrutnCix7qG8ezWe2y6hvUrEaFwSRc2504eD2ggSg6Q25U4D
	BGsKa6pUiWKKi0B0jzAfHeIK4QsDWO+OoUpJN2bDwwcMLC5F1dgpP5aToOYSVbBez0SLOvqlErh
	3xMGdb1gnszXjHCgh9zxBQV/8CHrNycd+GcvpDuKMzvnTqaJETmrVRH8y5MuuiaRk35OvcvjSlH
	RcP+n+YoKEwKAWhIoX7Von6lc96zMqJZ4tYrCU/xZTetxqnTnQnnGmnQ==
X-Received: by 2002:a05:6a21:7316:b0:3b4:b276:a789 with SMTP id adf61e73a8af0-3cc71ed6b3bmr16610653637.36.1786821885735;
        Sat, 15 Aug 2026 12:24:45 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::6868])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc08f388356sm2024947a12.2.2026.08.15.12.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 12:24:44 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: Ion Badulescu <ionut@badula.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ivy Lopez <skunkolee@gmail.com>
Subject: [PATCH] net: starfire: fix ioaddr sign-extension causing ioremap() failure
Date: Sat, 15 Aug 2026 13:24:32 -0600
Message-ID: <20260815192432.38951-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ioaddr is declared as a signed long, but is assigned the result of
pci_resource_start(), which returns an unsigned resource_size_t.
On configurations where the BAR address has its high bit set, the
value sign-extends when passed to ioremap(), producing a bogus
64-bit address and causing device probe to fail:

  ioremap: invalid physical address fffffffffe480000
  starfire 0000:08:04.0: cannot Remap 0x80000 @ 0xfe480000, aborting

Change ioaddr to unsigned long so pci_resource_start()'s value is
preserved correctly.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198035
Signed-off-by: Ivy Lopez <skunkolee@gmail.com>

Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
---
 drivers/net/ethernet/adaptec/starfire.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/adaptec/starfire.c b/drivers/net/ethernet/adaptec/starfire.c
index f1109d90e1fc..b72b393e6fb2 100644
--- a/drivers/net/ethernet/adaptec/starfire.c
+++ b/drivers/net/ethernet/adaptec/starfire.c
@@ -634,7 +634,7 @@ static int starfire_init_one(struct pci_dev *pdev,
 	int i, irq, chip_idx = ent->driver_data;
 	struct net_device *dev;
 	u8 addr[ETH_ALEN];
-	long ioaddr;
+	unsigned long ioaddr;
 	void __iomem *base;
 	int drv_flags, io_size;
 	int boguscnt;
-- 
2.55.0

