Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DFB3F329D
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786963980; cv=none; b=BHLiGrc1/wfzrN/dpUiQM1d9rvkCYWHvIayANvwHHZBxSoVHMfw5rwltfJlGmuAdT/xZnB5CTzAi125iCCa4gPDjpjiXlIu+y/vVuSYc5zIHu2yX3FzMpIYli7eMIbRjA1PG9FJG/sW81XRYOzc53GGsIjCsyyFsbEnIgUJYR8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786963980; c=relaxed/simple;
	bh=8dWA7vOQUSxOmxFCj+tzmegCJx2kzud+kSIalgUVeo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7oTP0cvGY/5BozayEmhc9NmtjOFIUGvEAix8oFWsxdhhr8yg/xM8ACL2ASFHsbvApxnIrt9ISV8KtZvBJCiDaXN1qdGLmsw5r554khJ+lae0Vwflts4gPYlrhbc/ehhKqIXLhULfOn9rlntGoZqR97/Lq48OR9XpDdvbuhQ9bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JID+/vzb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JID+/vzb"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so2676594b3a.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 03:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786963975; x=1787568775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4gBThyHru0i4E+ZzvCsRvUjwLIOQSie4fEFNF+loR8Q=;
        b=JID+/vzbwXu58vYgA1NKvl/Y8GXUXzAvxMiEWgqQWKUR6XpuhY0jdLoqIXt6b9ZXzI
         upjLJKYUZPqSS8xJWIS06gma4yb4R0zv+4pmPAcKBdSNg2DrZVZKSq5OrzeDvmw168EM
         XASPi2FwgGESewOa8UpLT8fgWIwx2YtUAAvyGsqzqyKJ9aqHbZN3xTYwV4PSdoUs+7Ij
         yArhPiuWAkENXyIzJOOGAFwNJlsOXnOrM7YsTKrwHYSBGwaV+hOSGYoFwSG/kuSb4W+9
         iPrqZ2TbnEkkM1z1XIBIaPu9ppPvf6X7SLJWhbi8xkG7nxqjPzina7quhokic6Epy0zF
         c+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786963975; x=1787568775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4gBThyHru0i4E+ZzvCsRvUjwLIOQSie4fEFNF+loR8Q=;
        b=euxqM6YqV37uo7fHVm3tzJL4dEOyxlHruOxjulO/0P9yzMcObyVHOGHdjVsp1LZgcd
         OrtoTZO/6lVFkm9j9fXu5AbzyUZn4Khi1HCU08UMXAYfepmR+fi0wxZDS1bT+EYhGL+1
         MuZoUFc1bqeP9SJdCEfJ4Z38wdC+zFKiEFhdISCzLPkpCXQaVlf3kJL6DIxwso2t1AT+
         cr9ynn5b6bMqolaCSzzEajzHrbdG4WZFSIzu6Rkf+Lm81mNMQvbMfhUj8Y3umYYn0RzA
         f9i+GI+pkKGZJZaF8nsENaFv9aZEgZPkTCg2Vm5Oc0a10I9TWQNDVTNXQrU4dxwGKPUA
         A5rQ==
X-Gm-Message-State: AOJu0YxOszFvlDG97RDfO1omBmYasV3GqEHxyOsCxYuNCAlWUI5IqRGe
	Ov4Qr2++GanpT/GeJeIk7b/z2Njvp7dMYdaU4H5/hhA1g/IHCPZz+8//
X-Gm-Gg: AR+sD13wNiCwlPs+e5V6qj706nEH8Elhek+wPnMICW9125vskKuGJdIpRhRGGBQM/SI
	Rz6+QaOap5W7xMWrKXywq9t7dKO9jm7qecF/FkKR/REbKSAnrL6gTnDkhwiW4glOQMC1YD468Q7
	suVsAygvLDVG2BS014m7lCPfB4v4dtpkwgyG6TIeGaU+bqGzDnJtDQUXtAR60Vp/RgCcjGknrTh
	SoZaBqBBDHGR6IrJ2YCfG+/E7gkLU1hGmT7fSQXfCAdGI6QxU9gehObxbSfUJn3kUIEr/b0Yc1h
	7uG3txlMaFu3OnltrL6OlD/muoU9EZIVQoS3DDWI5mwsUFbYqBBXNpB8dLXjuo5aOdBt1LYzuwJ
	KhvZbAu59OGExbKCkHPvYYDSL63BGoB/j1rahHZS9/Mpwy28kIgV112be76tG8rr8MIWE+AQffp
	AiKKqLkr0Zpum7gBHwzYU3mAYH30rooai24/3Uh38W1SoKAeyFdcyh+i+V8F0NoEhcslOCgT7yH
	EpnPT3Ot+//E8WWpgcjBGU4UonYIr1LFk3RAyFrMMA/BQXbPjC5Efj50Dw/4FDXYd2CKemdW1V/
	LarX
X-Received: by 2002:a05:6a00:b91:b0:851:b03a:fcb with SMTP id d2e1a72fcca58-851b03a12ecmr2971688b3a.14.1786963975460;
        Mon, 17 Aug 2026 03:52:55 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b401ec98sm354846b3a.6.2026.08.17.03.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 03:52:54 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v3 1/3] net: xilinx: axienet: Propagate errors from optional IRQ lookup
Date: Mon, 17 Aug 2026 17:52:39 +0700
Message-ID: <20260817105241.63345-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no optional IRQ is available, while other errors should be propagated.

Propagate all error codes returned by platform_get_irq_optional() other
than -ENXIO.

Another call to platform_get_irq_optional() in the same function already
handles the return value this way. Apply the same error handling to this
call site for consistency.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index fcf517069d16..f92951422b2e 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2972,6 +2972,8 @@ static int axienet_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "could not determine irqs\n");
 			return -ENOMEM;
 		}
+		if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO)
+			return lp->eth_irq;
 
 		/* Reset core now that clocks are enabled, prior to accessing MDIO */
 		ret = __axienet_device_reset(lp);
-- 
2.43.0

