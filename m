Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A963538D81;
	Thu,  1 Oct 2026 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871265; cv=none; b=BILjK9w8LII+OZ5sWNpA1J91VE+T5PKAJ4p+TFUzfv+qTrAKJGIoJ3OeuCq0zDa1rTfMLZixJKrV73HoM+7iK+BPd1FbbjlK7CAdZQN2U6fsKVe5kuwpExvkZNkpVzpSg76pekpRSvEWAGB92ulZ9Uk10ymsTxHT8YUhOt+Pqac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871265; c=relaxed/simple;
	bh=x4QDSKa3uUbkGyqM6BgoedxOZGNn6zXlqR62PAoqJNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ns1XgDuxVjbYhDj4Zmicw19oq96K+7NZQ5JzlChR+zuJTNtvgmCNL5HjFdvhv94O/m0wBcOlHFbAJ3qSPkuAope/AYX9mms/t7gAZldxPUeqWpjqLIv6NUkEA4fxCkw+a+oPcw2s829vr5bZKnQxHaErYP89TicjCljkHLz5iFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3Myv6Gm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3Myv6Gm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FB61F00898;
	Thu,  1 Oct 2026 16:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790871264;
	bh=W0pzQTADNEWd5Hpps94prj4R5jhnHNhgf7B99L1yipk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I3Myv6GmO57dc20fN49TTnmEooEs8u+eHG6/DMU8Z8QuOA8aEeRZXXtPmfdwyj2PJ
	 UENyLezxTLtOJNR6aa+Dyuccy357mZbjRIK1Fz4Q2NuZYLckYSggGtgJ8Abn4/gwLi
	 hdGl6QVPhj3yzlwnFY2IDp0q8KcpaG1wlbQgzSDwr//u0kEe96/ZU2BUJQ3yquhcGD
	 LN3JepjYWvKybJYIWtUVCYccDG1bLagkb5QtXjlJyKW9ZznADv9N5aTAbMu73hwvG0
	 YaERLr00TxZ4pCaJttWunysVH7KUH8oDEKLSC4k39L1sCDadvu+joP2YHQZq41+xDk
	 7vCiyGIefNtVg==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH 32/38] net: ethernet: sgi: ioc3-eth: fall back to the platform MAC address
Date: Thu,  1 Oct 2026 18:12:07 +0200
Message-ID: <db3d3f341b74d91f7119849d7d5621bc024c8578.1790857966.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790857966.git.kaloz@kernel.org>
References: <cover.1790857966.git.kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOC3 on Fuel's system board has no MAC PROM on its 1-wire bus, so
ioc3eth_get_mac_addr() cannot succeed there and the probe defers for
ever. Ask eth_platform_get_mac_address() before deferring; on IP35
machines it answers from the L1 system controller. Once deferred probing
gives up with neither source answering, use a random address.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 8702dfdf4c36..85b49e7b0f79 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -857,9 +857,16 @@ static int ioc3eth_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Invalid resource\n");
 		return -EINVAL;
 	}
-	/* get mac addr from one wire prom */
-	if (ioc3eth_get_mac_addr(regs, mac_addr))
-		return -EPROBE_DEFER; /* not available yet */
+	/* get mac addr from one wire prom, or from the platform */
+	if (ioc3eth_get_mac_addr(regs, mac_addr) &&
+	    eth_platform_get_mac_address(&pdev->dev, mac_addr)) {
+		err = driver_deferred_probe_check_state(&pdev->dev);
+		if (err == -EPROBE_DEFER)
+			return err; /* not available yet */
+
+		dev_warn(&pdev->dev, "no MAC address, using a random one\n");
+		eth_random_addr(mac_addr);
+	}
 
 	dev = alloc_etherdev(sizeof(struct ioc3_private));
 	if (!dev)
-- 
2.47.3

