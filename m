Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59F126C02
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789540289; cv=none; b=bcnL31wuG1I/7VdqHlyakl2yPPQdtIdPKNApBgIGRVKUozcavYn8vYGlpvdqjOgBllxy9yvMlC/jbnlLtMJZ1ZsvXqWNKs2Y+dn8oNMgyEppuT8qZHxF80MEoG6RnyA3m16VVrMZijPSn9r3m+NpB2GoVxs4qmwxyUlF9jzkPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789540289; c=relaxed/simple;
	bh=Ni7Nb/tkSb8xMBveKfixGMHJTCUSsBx41uEaih62Pk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZDs9FwjHAY2/tMLIovI7uLUUKx3Siftt0fWVdgGgM9VnueE8dVMS6DV7bEf7x1i2ItpmOuRUPXEE6OVWmK9ooUc0DblUJ99OJbc5m+eUoJI6thFoxsGKmB29zMFbP17iTK/CmMmDNSYH4YR2rM3yxTYs5ZT3TxOlZ9UMZb7mld4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pL6mji5z; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pL6mji5z"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so590171a12.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 23:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789540287; x=1790145087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WouBy8LrBhobloOGcs5+4K8UnnGyA8XojKOtb+0NfU4=;
        b=pL6mji5zB5KPC6uoVGtIQKoGi95xo69J3dQwnXgpRGvKy43PT6QS+Prp6zshRB21WX
         zxDeNFc+GHOasZiROXri90d1Lb25pVhOLM3ksQXd19AZRYVlHU3dgJFtOuQj58+uTRND
         NFG5na3ozBv2FpuJm6BWdx8ZN1/Jhwgza4s3umrbzcS1CmyG7qNYQzWUzMrEylBOppQk
         r4Nn8UTteh70kodW7JJu4F7ev+6rHasqQDqUNDeqgahMHLpH93GRb4mv+JklXGvtMplR
         HEE1Gw5fcm+G/D17Ex5iz3Wx15cSaiQ94n8k8LUkyUlktzmQG1y28x0Solfvi0hjlaia
         dFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789540287; x=1790145087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WouBy8LrBhobloOGcs5+4K8UnnGyA8XojKOtb+0NfU4=;
        b=NNdu7PJOBSFMJ1L6xid6LO0USvMdoSJtVTGmEqPkGS1IyE6HCq3lAWuvAxAVYg34v4
         IxeZ4K3D4Dff5jElJZx8HWnuGrlZnOmssS9hMxexCufkA1EbStsn/+Jt8pAQBGQC91Jf
         Ix3g2j1R9QM7cbcgTcVzoj/WK509NdqO2MGBQDvBwC28tJdz4h07rCPkOWyOTzbnPpKq
         aJkLhMW8Kbgm3LQQay43D/qrDdym04udojsFQ9VAKG/zYHvvHZlvk7VJjgaYBhR5v0vR
         IidNH5mMZz5WQMCA96++zz7YVTCZbRpAlZ41HYpHX8lonvb4f1zFUJRw2IlKNWq3f6fO
         i8AA==
X-Forwarded-Encrypted: i=1; AKwUvBzP+E2p/ToCmubKXvWPpEBBneDN1cdkQP0YMJKSGPNXkxObaP7yIKcNwV6LtjNby7EAuFgqKAY=@vger.kernel.org
X-Gm-Message-State: AFuF++nqTXbDFpyNsQGxebKdi5JT9FY/2fCBxQdMA3c3IECTPZC4002T
	1W7lYxdwg75Jk4i0xrSQMNBXM2uX56JSjrsBa3jvEX5IUSblfgj0mk0+
X-Gm-Gg: AYBFou1P23wriKg4LSBVi4KdNXExaj6/9V4fnOhfh6DFGmtzpUiT9xfIA/sQiNLwEif
	WYrb7Ty24HyOmOwdC1E+XrzABamHf863nwCdvvA5tPvU0Iqfl3bqr1R51p3WKS2R52H5dC99/3K
	Rr3LMGvtxj5XM/VMOFh+POGD0+7sRAZaheFzsxp/apE2y8yHrFr5X5e+L3+ls5u22aTF1lN7dSl
	TOw8FYYGsFDn6/43EVHz74MQOeeFvmjLkFn1Nvh+/k0VRM8ejCVv21ZtHWLR7wdw4g0+RatqCpA
	leaj3pWs6ZW1fulXw0Vy25P9nwhha+hkjwjXf9XJeqNFDsh9nJ31n72n4FM+BlCKIme8P+I4F+U
	vx1DbY2NXgDC2pSoV5bFJx2Pfvj/LuiGN9JGCHHS5Nppir6A9ncg8NPX3Tk2msK2P+2jEosIfhZ
	0RJduUvIJuHJTOlhWsnC2iqScaIbbeCu/hpW5R3CMlhkWY/Y5DrYU3YVgkXU5xniMC
X-Received: by 2002:a17:90b:582b:b0:39e:f1:b2de with SMTP id 98e67ed59e1d1-39e1e4c54fcmr3564649a91.20.1789540287232;
        Tue, 15 Sep 2026 23:31:27 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b712ea3sm2906637a91.9.2026.09.15.23.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:31:26 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Kevin Curtis <kevin.curtis@farsite.co.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: wan: farsync: disable PCI device on removal
Date: Wed, 16 Sep 2026 14:31:18 +0800
Message-ID: <20260916063118.2924049-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fst_add_one() calls pci_enable_device() to enable the PCI device. The
probe failure paths call pci_disable_device() to release the matching
enable reference, but fst_remove_one() does not disable the device
after a successful probe.

As a result, the PCI device enable reference remains unbalanced after
the driver is removed.

Call pci_disable_device() after the existing interrupt, tasklet,
mapping, DMA and PCI region cleanup to release the enable reference.

This issue was found by manual code inspection.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/wan/farsync.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/farsync.c b/drivers/net/wan/farsync.c
index 6508c53bdc24..0ea637270ad7 100644
--- a/drivers/net/wan/farsync.c
+++ b/drivers/net/wan/farsync.c
@@ -2561,6 +2561,7 @@ fst_remove_one(struct pci_dev *pdev)
 				  card->tx_dma_handle_card);
 	}
 	fst_card_array[card->card_no] = NULL;
+	pci_disable_device(pdev);
 	kfree(card);
 }
 
-- 
2.43.0

