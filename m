Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8D83AC0ED
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524588; cv=none; b=rCBOAQhFlNBhj5Oi4iOyob4k+x6W5xoJ2h0MhxjtXaD0yudNR6vVu6WZFJrXiWq6J+N+avICrJv2/1kNK4jb0rgSwvAaYkFQkjTlWsR5eLtcpVPJafuaNhtQ1fAW9FPO7tA3mkOBiASb+QPwsnOcZx7RRZPy4u0poWto6ZQE3+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524588; c=relaxed/simple;
	bh=YG4COEKulNp769D/BH1fCYynnVil3u1ZWIifJ+zRmkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EF/EdivB3aK6GPQHI4lz85QughC+Bob75ZVSe8/X4z85JAf/AXrKrssOWb0o/QqbFO7Xfiw7Auk+jlIovSk8tb9D1bvUP6Q+t+ckzpMmk1gEbn07SgM8mvFU3bgk2hFCHrjP+3ysjZBKktDGgODNW6xNYeQbpIv1T+EL3KEk470=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcPv8o/x; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcPv8o/x"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469f204f6so208122b3a.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 19:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789524580; x=1790129380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wm31bZPNQbk147CGwUHP23ZCay3Kn8INjT2oDuzYLtc=;
        b=FcPv8o/xNEeDJ15f/ck+7wOxyuQ2vkXb07FBv5bMzvikGrllRPat9zjKwyIOLs+PI8
         eDahLH9sOQfC0PRkZ/FshyIVzJA9coonZkbh80KwlFcAWMoy04H//EiyOFIvoHgTBarc
         llqXpc46GUK9EuP8zXQuwe9K1HAdGa59XW1BibI0XAGjs11vgCIuW3Ws4w73m7MVjO+S
         bLy9kJY6uM6ZaClAuaI7+Vc+AGFVb1hhS2uV6VOEHAYcasKHlLuqSLV3cvh4IqEyGCxx
         KOv+sSDHpFdYFZHU8ZqCu8YFqcF3BfPPDBDtX4oqxW8zpgDVaWB/sH7YRjfFXRswjBpB
         IwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789524580; x=1790129380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wm31bZPNQbk147CGwUHP23ZCay3Kn8INjT2oDuzYLtc=;
        b=fArUzSSyuDyJ854Qy9I0psmCM1cJNBXz2kISRiMfdUKmZjQYc0ng1J5hPxI6erwUXo
         isfptkLmu55rt3UQgKCxAxoXQEo09Rgj2CcxlrMWJvZhGPpo22D5AcYCyItKAlQXKXnB
         RPzOLzW0u7gpkaaiwZCY3C1SvXONYUoXjAtecdgbv1HxT8pbh0sC/YpVCTFX2CmJ4Gnn
         0Es/Gk9dCrx5/n50+UFDCZW+37fzb+UXJIF0krzow05WNgm5LomQK+Cj6ts864arLwdm
         aHyzuN9PXnDCFBzfXgZXooyWofATi1ykCg6b/P4SCQtQRKX1ImhdHr9boRdUAVF9Z3T2
         5Uig==
X-Forwarded-Encrypted: i=1; AKwUvBxJD8igSqvysOnO5NspElPKot6qsz912T0aWCHR9uzbtABAvs16GkRqzq7iiP6+FsOYFSu9c0U=@vger.kernel.org
X-Gm-Message-State: AFuF++lXxDuLDiZe+Mn53ON2nRrFrrEaWIvEPqNcKGCWrVteYsVQVydx
	Y+qpzKLSk5uxUNt/p4JkEXLFiauz5tVCEscz8zH7om7y+jlk+OwPhHCo
X-Gm-Gg: AYBFou0qu1tYYh15cQ0VoCkPTcyOHtY6LO9677hRcydURzpH/IHlZlNH6wEOAZ6UGYr
	34p4QS779kbjqueoy26o1YERebDWhDq3h0gurzOBqRUCAdeNYv0vD+GpE6mInSQAtIyaJ1ukjdM
	7fB9KdriG+fFVIMyEc1gdNBSyAcZQnqX8hHWoYWF+7pZyFoXbhMc0PgrW/ZilbwPgBUGpmqrHM4
	TQap15nG9fQ/UKYECZMDtCmEcPnq8sKKufV0EablZnAyNm0n9C+QsppAtss1yhqClBvhdGCK6W2
	BZF1gaUNti84DqZSAWNfdVOjmZExphKtAwPy6UGzt0RNxcoFsnQD8wq90O48SBPvBpUxfsCAVCZ
	Rg0dPU0rhq39qZgXrPwJE9qR1+EUo7RutG6Cj2MZkdXUZL5FNy0zATmfe3qr11GIJciJStafjWJ
	J+eaTJ3p4WQXrMv+4h850VRuAZtAR5nXj8imTHsOV9EBzSPJjF8u7GLA==
X-Received: by 2002:a17:90b:1845:b0:39d:f259:3363 with SMTP id 98e67ed59e1d1-39e1e491d27mr2086478a91.12.1789524580108;
        Tue, 15 Sep 2026 19:09:40 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm1508988a91.11.2026.09.15.19.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 19:09:39 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	John Crispin <john@phrozen.org>,
	Ralph Hempel <ralph.hempel@lantiq.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] net: lantiq: fix netdev leak on remove
Date: Wed, 16 Sep 2026 10:09:30 +0800
Message-ID: <20260916020930.2606675-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ltq_etop_probe() allocates the network device with alloc_etherdev_mq(),
but the remove path does not call the matching free_netdev() after
unregistering the device.

The probe failure path releases the allocated network device with
free_netdev(). However, after a successful probe, ltq_etop_remove()
only unregisters the network device and leaves the allocation alive.

Call free_netdev() after unregister_netdev() to release the network
device during driver removal.

This issue was found by manual code inspection.

Fixes: 504d4721ee8e ("MIPS: Lantiq: Add ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/lantiq_etop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 83ce3bfefa5c..ecf2f3cbf4d9 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -711,6 +711,7 @@ static void ltq_etop_remove(struct platform_device *pdev)
 		ltq_etop_hw_exit(dev);
 		ltq_etop_mdio_cleanup(dev);
 		unregister_netdev(dev);
+		free_netdev(dev);
 	}
 }
 
-- 
2.43.0

