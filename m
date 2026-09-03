Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E191621A459
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420806; cv=none; b=EcS5yCbG6g9HkOKHXKA2ll8r7O/fCgYfmVnclokk2EKngmhJFaWJKuv+meSR5cl2BeRn4KPgOsDYaOMyGU8s5sxNq8qjsG5Lkz5hCNdTi056sPG3KRygHJG2pSoXRQy2aJ/IiQyjRRfoQo0oSn5LsCwfm3uBN94WWuMpLxmOSO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420806; c=relaxed/simple;
	bh=vc9oGAqRaMzb6Xdaj+3NGIpap5QZHwRnk2S+pTd4Ur0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxYsd9T6BzJbmNjolKF4u+FoZTUR1gljkJGHY+uKpi4vm8N5332fXYHFN8tt2YMKLwwgagPCdopqt3/hiea2QymEFrbUO2B3MLE9iHun9N54tJBBPMZB6NaHesmvRpcQMEJ+uuZIAfUdy++Q0S0oA5G8KtaIZdCxoTNIUcuGr5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXRQ+ot8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXRQ+ot8"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so2613620a91.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 00:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788420804; x=1789025604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vwKd+TdvIX9ZItYpiwc95hBpIK2+IZI68PvC5hF8oBU=;
        b=gXRQ+ot8xrnODpfz1oRU3OnQE6YKCLOZFFWUun64wvWG1Qd/SV1XbeOBvHjFSUwdQN
         MIw7JW3scVPQVv+bhdAVTtUnv1WFC4GkkFCBzn7gMI4C8W1gbSXiAMZGa9+H0jhoa2Ys
         oAQQhjKU/1nP2fkRJur38BsS2WXfCXou3RF8f4XVhY5Nde4Y5ory/VEObNee23KJdFqm
         vJSMolBQHjCF9MAR7RQI1O/84uCRW20Xvf04KYO0sAPQIKaThLySwbd46kgtrFVjZ0l4
         xdgQo0Ift7I5rZmBzQDZKTBrF2OwrTGi9MQV0Oh1H6pMQycsfFUcJFliLGlgCialR2FF
         mYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788420804; x=1789025604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vwKd+TdvIX9ZItYpiwc95hBpIK2+IZI68PvC5hF8oBU=;
        b=Ht9/hEbeFhRtmTxz1JhH85Z0kS3LxqLoydqCOzWdc8OZjBBLGLeY2G8kswGGgz+MQx
         SJi8aZhX6NncfbESMv2Nis1GbNMAwm/Sum/forcu4Z9Dl/y/AvQu2xA47QVTIrAkChlA
         af/a0/Q2trSAfiLPvk3AfGugx3frYjFiB1Guf96rra+nnLzMivfK8PL9tYqCkEQjESGV
         FIinStP4OaYvvU8nT8/JYSbyHm/aI8KGktBGOiNnw4GzVq+UcDfW3Py6/pEhy/qSceXJ
         vTjkTCMMWup1dGc0di2jMouecy4jbpuOQ0KeDY5bWvlFpHPtlt/7YNDe7yDJTzNd/AuV
         JtrA==
X-Forwarded-Encrypted: i=1; AKwUvBwOgJPcuH/daQVtmIU2nE+IzKk9xAKpCq5bQ9LI7K+ThlMQfDy81srbPVnf+kau3A/lCGHkP+Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kPKJCTiAevrNfnvJV4MIE7SVxzMWXtO0l/PGuH6XhkQbVDL3NS
	hPuxcmjTmBzgskdLiCyXB1lu8Eokfv0T8N/601BDxlZzi4jSk1ltGlE6
X-Gm-Gg: AYBFou195QCMLeha87jgGPMpx9BBr/2ftJxZ3ZXZ5exgWOy60/Sp7szmNcvpmobxUC4
	yhFgpxXtzlaZH943HYs0IAeb+rr+578o+VJ7OYDRU5xXlx1nsyx8T/iB2GQ5mxDgvlqK+XpF1lY
	x19s2Fc6fythABFKl63U0VazjyWGK9I/hYQcppqAlykBsu/fjV18ConqFN7lapf3wT8IiZTDVW9
	WjwkUDMG345/VUE2i+LGD28MOE01hwOaVA4JYzhn5ECSptuS3xThmbxhLoNXvUEluXttOjKpH0H
	k7qo07mZMfNnoDflE/qHKa292XeTqOusYXOijXHNK1rgCePSiVAiXSD+OZJy+MGKE3kMiMlUyZs
	Yb8j7SLoLEvi2XgsLcAZhG8f03aaFDWDgsqkMN/F5JEOx3QOyem/Z9wlJTO6nn+K+LF+ixe5oIx
	cjE9OypXseSNY90x0xPQl1W1kqhdn0nhyJCSl5vLLZLWGTRaNJhE6JLyHR7acFzhrNDiHDXWnLj
	usFAoQcNYrW9j4gyytAGp42aNGnR70lEE01bHgXmcLv0fhr8S0m+V8OI+YsTxWEnp89u0jBTJr+
	SLN7
X-Received: by 2002:a17:90b:3d84:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-39aedf7cc2cmr17489022a91.2.1788420804175;
        Thu, 03 Sep 2026 00:33:24 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08624f11sm3606813a91.11.2026.09.03.00.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:33:23 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Simon Horman <horms@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Robert Hancock <hancock@sedsystems.ca>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net-next v5 2/3] net: xilinx: axienet: Handle optional IRQ return value correctly
Date: Thu,  3 Sep 2026 14:32:51 +0700
Message-ID: <20260903073252.339250-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903073252.339250-1-phucduc.bui@gmail.com>
References: <20260903073252.339250-1-phucduc.bui@gmail.com>
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

