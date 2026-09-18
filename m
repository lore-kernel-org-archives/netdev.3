Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8772331EB0
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 04:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789705705; cv=none; b=NZyGARw3vnlViCOQ/oK+qm0pe7OvN+m4PxvyyBJOloR7s+KazVd6SqG0papgrqGv2UDxoIRNalpvNjXYjQg3ugN+w7M8eYOjNm9NSHtOVeQQEkhR4ordFY6+kKpRHun8PH0EdTFmCQzdPiI5q7bXhPNa52t3dtXIsGgzVCg2pjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789705705; c=relaxed/simple;
	bh=gGqMfb0mZ00dpgEGGq3pBv+M6NbKCtJNRN37oILdpbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d20ffdFyB7DjtgEy/EzOoyQjb3v60ZzZko+bbUy3TD2JtXs0NnVLYBDYB6hk2v8TOH57awSBovSZbE3RaZQkXac32s4o5L11tfkiZOC/DUNVHHJEFtqRbBvU9qvr1ASHHQqMEQ19xrESyT5sAefqFGt+Ip2U0A/Rx4OBoTKiB/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJ61Aidt; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJ61Aidt"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc515bef69dso161405a12.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 21:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789705703; x=1790310503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YTJNZFQzN8h55ADSd3YdqRemM2GmjoMFnZirfF3PNDs=;
        b=rJ61Aidtg3CD/rJxjVYtToJn73tkPidw5Fevt9+xku+gPusIK+XEy7W77tyk3aoX4Z
         Ga/Omdz8VAWjtWqPJDd9KbNKMnI7a1LBWU1XmX0WZWdSqVNpybaFZVeohiXQVvXxi4jX
         WZ+dijLMqNn/32girLMoXvHgwrdZM01NpTr4JwSDwI+7hHFsbe8HeeHZZMzDBKQlkZTE
         EFppCfYmoO3flcYV9/CVuhQjmlsDm3eRZKaWVzE0y87qHic41eZMsVq7T6ScdkdGIKzX
         WqbgZ0kmv6COBUGjdmt+DhvEJE9wrDZGaO1ok+v37SFMPsFiK8kUK8V9H1B1wm3k348G
         Vhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789705703; x=1790310503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YTJNZFQzN8h55ADSd3YdqRemM2GmjoMFnZirfF3PNDs=;
        b=wquiIOtPXM5H/uuU0jR+mpsNzyfdtn9r/7DvkWbCp9X3Afpjji9gLIbnO8K/hROsis
         OYLC3IJxDTZbB8l4us2qFd/KEWijIe/d4F62RhTtLdVY4rlX90K1KF671MmMy+nhu/mP
         Pb8AFoJ6wK0rGnQDMu8xsVHMHXhxZX1fs+5RO4HegoVkR0/7H2Ez0v15t7PX6rTI0arS
         SyMLrkex1Btotlrg+LHxJGXIFUEh2rmCco0C4EajntEJgxE9uC5L6eSLqq3FUPu/3PLg
         cXn+Tf/tci6W5xVCI7gm1fLUy1AM3oJn2g9fpnCTjIU6nx5UiwSf4Kgn6Xzse50vaIG5
         mI6A==
X-Forwarded-Encrypted: i=1; AKwUvByvNNUdTJek15GEcQ48TfhTie0oQhSclgaO8UjaLaKSYEyfCrhXTdkaP4VrAMLUOBXJHbzxqfo=@vger.kernel.org
X-Gm-Message-State: AFuF++neuBIm7+cZwfUxCXXI4/QHb3Bpp8a1O5u0sKi4bNici+BklVgf
	Oo9ZM343aMHKxFQl/RNg7Se4dz8giz9aar0nK6OEHmkTs+9ELo7Up8a7
X-Gm-Gg: AYBFou2p6KYCviALla2/5xlzpWPWbFu6eyWUmRW0cggqi9WdT7cZreH8Q9hPnV3GSox
	t9LFM4McVYdVc8W0o1Dvera41BviDNVZ/ELvNvd2VBuPgl2dH4D1JXwomTzXqmKd8n+dfBAL67j
	SNqxZTJ4xPjzX6trXKu3BMF3HZ2kut9YBN8UEe6uJQxqTPVtMoK7RNldP0/zB/CmdtqOHyElHkJ
	LthVidtF47IeHfz4ur5S10preRtXtJnaMv5zsPVSR4yWHniBbnNdBDP3LU7YbDopfpAUK3qiRs4
	odJsMuQJ0nCnolHF59hN7YN/sNiGgip1/xHxQjQpTl4OqoG4mBUo1B8rFwIyLABiCEHz3UMK945
	vEX7RQBeHST7lOCb4qQM1ZS/P+TFOBzyxonpjeyegcxE8VZFEW0zL5Vzyeq1wbqYvlkHivntQQe
	wLfBjGbkmcT7Zdm/p6itVWTU98IAvBEP5kIX0hcnCvbNv8YqZoi+mynzOnxSMGQ0tVaZ6uMPaIn
	nSSAtusG/BsmJHI27uBpYzbBktlT5VlLPFFtarPTK6e8KIBDAaToB1Gvx2s5ggQdvump4KWUo07
	amkfK1htXFrsv0XG81TRWBwWDw==
X-Received: by 2002:a17:90b:548d:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-39e54d11d8dmr2910601a91.18.1789705703042;
        Thu, 17 Sep 2026 21:28:23 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e361b8e1asm8119606a91.12.2026.09.17.21.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 21:28:22 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	David Yang <mmyangfl@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Nishanth Menon <nm@ti.com>,
	Wingman Kwok <w-kwok2@ti.com>,
	m-karicheri2@ti.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net] net: ethernet: ti: netcp: fix pm_runtime usage counter leak on error
Date: Fri, 18 Sep 2026 11:28:04 +0700
Message-ID: <20260918042804.13101-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

pm_runtime_get_sync() leaves the runtime PM usage counter incremented even
when it fails, but the error path in netcp_probe() does not call
pm_runtime_put_noidle() to balance it, leaking a reference each time
resume fails.

Use pm_runtime_resume_and_get() instead, which automatically drops the
usage counter on failure, fixing the leak.

Fixes: 84640e27f230 ("net: netcp: Add Keystone NetCP core ethernet driver")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/ti/netcp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index eb8fc2ed05f4..4f9e20468bbb 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -2225,7 +2225,7 @@ static int netcp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to enable NETCP power-domain\n");
 		pm_runtime_disable(&pdev->dev);
-- 
2.43.0

