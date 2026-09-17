Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AF945000
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673319; cv=none; b=TKCr8z73qFToAK9woKYHQhrByoCYYIJKaeCHJZJRVEqLOSTeoMYwg1UWdRRkRnOTXYiMclEBHYBx8+c7QOKv0BtHH0wphASiNICuf+YtmsFqj2n5nyx3RwvBCRcxySU/B0+D5Gmbl0ZCEy2AexQEds5eyS1JCTGlwnbNyUmW+Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673319; c=relaxed/simple;
	bh=kiJ8keaXl4aBoqSuNH1yUdc+yH4rf+KYUY3jg3YGXM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPQHeXOjep+Zo4WKNd49W83H95kBQIdQfBG56Okc/1D7ghYPQaDL8FcgJeBZByf7+rr1lu4oC5STYH6IFXPJYHc4dHMV+xu2r7tVWkL9r7qfcfrQmb2/uw6KqiPeXkcaXMqfecPtITEGNUqW7WYE7PyXnNuJWupqSo6jznD0UF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLGpnZZr; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLGpnZZr"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939ca12ab70so145584385a.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789673317; x=1790278117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DYFrXGjlvtshGh6uTDLzwFW8Ia3Piduo4Mx7nxDTOKY=;
        b=JLGpnZZr6hMX2bzqzZmvuKBY0tCL+A1WNuyhVvEKADmCWzjOngoYa3ElDAOzgOM2eJ
         h9qeQz6kggy4l/YzkWARVRmv2V9ubHgTWsF8+ZIVWsibseqruiCE9AD0t9n6ciIIRwZf
         Kpo//GhxFbUwsE6en9ZAJumEcxe2ylD6bauj+t62wsHCw6+m143Nl2WrORjEFlMp9ndD
         NDrrbnKmWwCKO7T6FfUCFHuwpJYi0OuSca9WO5B0LzCTKut+XHn3ic4j0rhKH67MKLf3
         f3c/J9QwxawuAbGgv61Ou6DMCqyP9Vk1dmP2KbAr/5waaveN+aSsSX7iWNzwBBaeLDmY
         jtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789673317; x=1790278117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DYFrXGjlvtshGh6uTDLzwFW8Ia3Piduo4Mx7nxDTOKY=;
        b=09hqRDXjLZOaIN/G+vhPNHc/RB1I/UWvpctvXzRi9Dtv0qypQ8mesl8CQpmX2Fq8pl
         PJJPSIp0cKy/0ZQTZIX3+yz53FXYC7Ov+EiMKWnVqZTZjMdPlsZAgBWKJVkGisXGeWEp
         VofME7F3ycqOYHoD2sa+wfAaZwQSB1HkZzZYgG/4BLpztUXIEClO8JuccG9oLKL9F3/C
         trJcflZ6NMvaObK/S9G/hy1QNT1DX6JOoYloDibq7sRH5+ydUiQYmx3YIqy4GdNQOhnu
         jbyZo/Y3233HcQjpCIrr5CHbIS+XdlBEbAuUJ3bqXGeNIWKrTyE1z7EkbqFUsi1Xaf06
         ov7A==
X-Forwarded-Encrypted: i=1; AKwUvBzo5/380vm0jhBftMyfYwPfxQuevnAsfetTecV3dKxflw6Fwn7xMB9X8u4QYNmHgEFFyFCUVBA=@vger.kernel.org
X-Gm-Message-State: AFuF++mt6lhkZmjVZdoN40FRtiS9MNUa9uGicfhqfm7dwokudUQepRjb
	Yq+CCcx9fevR1jVDQDEP4zzsZb+967DqJqi004rnNXHaJfVenxv6Kuc=
X-Gm-Gg: AYBFou2YAIjNWtMQkJzCroFTWsh0FwV3NXyN/BwTstmzMDrKS9wemuDZUTEF2lKHV7l
	99mFHLAbMnaEqx7CxAbNLserBwSIpKC1rokqTgTOdJDbkNYkxjFTbylJlgglgzDajbH+vuw3pCO
	qd4MpGRlhuwkLr2tVNk04tvGespEE7z6ZETb3hqf81zXa3YW2PF/N5b53ZoqFnHcVNTXEffiD4o
	VuXr7wOPSTA9VeVr1DhYWFSEhZMHNr9QJ3uaXPA3Vhc9V9pnYsGLEOooBjvd95ZVMJosoIsoDtQ
	bI6o/22TWTG0nn6vZVVK2ZVc4AdtZ6HGNujHrg+EuGHCijWm7jHUSaOCnBz/trVXjcmqMr9GgZ8
	ii/8aNBhgq7y7FzcFKtVMkVPiN+3Sg0v6UPmMVjdfx7dvBcuVQj8N+9IzZthSber0yOOjZ7V2PP
	Zikguc7KaZQp7e8eRBj2fia+atnuXMxyM63T0LxmRZXy66SK1ZvbBJ+JRewBZ+gh7RVqMVGZJAj
	7YFj04mQJpbNuTq7qAN4t02aoQV/Kb6kMsvfLqTM+64MaLjRuFhtWC0tzdIF/9HyvdS1YgNz87/
	junZszsq8yCbBQUt78EXU1DP22KUVD6mLFtj
X-Received: by 2002:a05:620a:6cc5:b0:939:ee44:36bf with SMTP id af79cd13be357-93bb785b995mr1306780385a.29.1789673317506;
        Thu, 17 Sep 2026 12:28:37 -0700 (PDT)
Received: from localhost.localdomain ([104.39.169.225])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b78255316sm525568085a.29.2026.09.17.12.28.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 12:28:36 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH] net: gemini: Free the shared queue after removing the ports
Date: Thu, 17 Sep 2026 15:28:35 -0400
Message-ID: <20260917192835.58126-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The software free queue is shared by both Ethernet ports, but each port
remove callback frees it. The parent also frees the queue before its
managed child devices are removed. This can free the queue while a port
or its threaded free-queue IRQ handler still uses it, and free the same
allocation again when the children are removed.

Keep the queue owned by the parent. Explicitly depopulate its child
devices before freeing it, so both ports are unregistered and their
managed IRQ handlers have been released. Disable the free-queue
interrupt after those handlers have drained, since the threaded handler
can re-enable it. Only clean up the queue if it was allocated; it may
never have been set up if neither interface was opened.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/cortina/gemini.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 4c762229ce42..e493d495f2ef 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2364,7 +2364,6 @@ static void gemini_port_remove(struct gemini_ethernet_port *port)
 		unregister_netdev(port->netdev);
 	}
 	clk_disable_unprepare(port->pclk);
-	geth_cleanup_freeq(port->geth);
 }
 
 static void gemini_ethernet_init(struct gemini_ethernet *geth)
@@ -2656,7 +2655,10 @@ static void gemini_ethernet_remove(struct platform_device *pdev)
 {
 	struct gemini_ethernet *geth = platform_get_drvdata(pdev);
 
-	geth_cleanup_freeq(geth);
+	devm_of_platform_depopulate(&pdev->dev);
+	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
+	if (geth->freeq_ring)
+		geth_cleanup_freeq(geth);
 	geth->initialized = false;
 }
 
-- 
2.47.1
