Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382D947ACFA
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315594; cv=none; b=nzJ6O78sG9b1RDIHDAVGVgLTMT+RFmkG5dDHp6vfn/jRg5jaNXfJjU77EBAcl3t2mBPIvE3F3Uz+3FUVtwsy1GXb+OZNOQwB437ueZTcKzbFNSBVZqETYhmaMGRFV3gZtqZZ8DMhnB7KFdSqD79Z0g05+1TVjSAGZ/6evzdrJGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315594; c=relaxed/simple;
	bh=5qMEuy5eGy/JVQD+dpqf2Q/66DUF3xuDuOpkz4CMcPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdLUzg4wNcHiKTR14xlUfo2YryJE/l/xPr8i6eNuLpGpc0HYL12d7O6K5mZh9xABZFOLANt1/0vlW6BdHjA3y/4HIgEREt1GAh+HFL7vh09CvAysf1GHnCjdSMr0bxwXthd+6Nb6TonpJBrbzMqAtPI7hAmiUmTfsaJhvTqTrIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSiPdCzE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSiPdCzE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d53197d8b5so10087615ad.3
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 05:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787315591; x=1787920391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fQhuxUhRanThkxdEOXasCJ4w6JBVmta7BprVKmAc0/A=;
        b=QSiPdCzEsjkoAJIdg8hWwIk4hzaBSMvm/wgaaD3+4YCZIWKvGkW4hL7eEZlt2NAePy
         Q5XLRnglu9yG4X3X/baI9TAiZLyVxwEKCykglLoCO7xWLrFmwNI8HFVpbJ10gvDVcZJG
         xj6+Lz5p+hjB9QRTKu4BOzbnWZHuEjio5dZaH/UJqzWJDAbvFlx8/ygDl5v4iU2aPOMS
         6cVEjq0yfWVjWuZFMVFrUses4mRcvStoZhMKQd0aU9pzQ6UmlyGXp6RTzaH9Zuc3V13N
         3R7hxK4Z8P/mfRzMglIZeNmUFcqfU4v6TCBmb/tVUPRwsGwfvv2zoSZu6ygM9iUPYswy
         YRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315591; x=1787920391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fQhuxUhRanThkxdEOXasCJ4w6JBVmta7BprVKmAc0/A=;
        b=GvUsjIjRCOivC8dtKE1wj5ui6abgzKgUOMEf/bWeywJDEMKGbmgc28Inctwi1MUSoH
         KcPkLFe2woRZgExyt4K/PokPNs7b6cBt4w148vq23T0jNut/2Kt7Mr9KXcAdSkEBLv1J
         XwvuOVF2djk4Wh8FVVilNLHQXas03k3ahjPG0OmjpecjCNo10pP2tEBFvyemtqaZVupn
         lOdT9KogLaPMnFUABg4yDoA7xj7htbb7ByjQKc2jcpbLiUn7yF5RpUS822QT8fi9UR2u
         UYp4o7dpPR8vkRI3cv/ysDpWX5mQ8tm0T4BuOajA2s8C/DlDhBbLWwcNx+FffziQSWd7
         2DLw==
X-Gm-Message-State: AFuF++lEs6jVZKsPiB2u0plOK/XBXLOBZ48Oo5UcfTSW2YTBp0sMAImG
	qWml6hncpF8pw4CQvsZLAZFCX5Q6SshraQH6LOO3/hCQbGcw7miehySj
X-Gm-Gg: AR+sD10w3xUaioBAAf+sOxDNyUoVFJ12iIBLU6OmtRkJyNVSvBHjWWA4BDg90nhZ7bn
	f0JLmA6NleiE8Uo34bgc8cuNBTMYut4/6Fy0yL/zh2Dzc1bFIfpssYy7a+g8nDvALXOu9np6/AO
	s8jOcEud+QZ5gienvouThqC2N1E6cN8MlNy/o8eipziswByff5HFtDiMiZayBNxwiGgtogzY82w
	cAVpQJwvY8oH0Moa5ZP/KVtJ5dVAsbkkv4F/ThOKeZBt7+LmEZVsZLlBAJEfuVLugSXXFMPj3m2
	uW4mqXy98aM28TPmC8oorVJuxinOXqXG54OGxFOG0hc77OkQzd9nQezLHE6AsTm2KQy8rgaLcxh
	B8ieRUfmqNzlDLT+Nr9FkOw+gK0GvG4AJ5TJINz61ggXSQg8Y6wIDJZIXmpfwp4KF0vAc6a+ebr
	SvNw8QUi6LLuD6IdWvJJFUkX07fuPxYO44dhNFrgPfl4m6aHWgxBr8H6lVO7yvneePuwYeDuhQI
	nPWq1J5nWhH4OlSdgo8yIpuoT63oaBkkMIUeK459Jv3dee9y3FmM3OISfY6l4t1pGLnZ0rzdPc1
	SaBw
X-Received: by 2002:a17:902:ebcd:b0:2ca:481:de45 with SMTP id d9443c01a7336-2d64afa4e37mr124259535ad.6.1787315590698;
        Fri, 21 Aug 2026 05:33:10 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e36e1d8sm18402285ad.52.2026.08.21.05.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:33:10 -0700 (PDT)
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
Subject: [PATCH net v4 1/3] net: xilinx: axienet: Propagate errors from optional IRQ lookup
Date: Fri, 21 Aug 2026 19:32:47 +0700
Message-ID: <20260821123249.41527-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821123249.41527-1-phucduc.bui@gmail.com>
References: <20260821123249.41527-1-phucduc.bui@gmail.com>
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

Fixes: d6349e3e14c7 ("net: axienet: Mark eth_irq as optional")
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 1722b7038f34..207aecb5f8b9 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2975,6 +2975,8 @@ static int axienet_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "could not determine irqs\n");
 			return -ENOMEM;
 		}
+		if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO)
+			return lp->eth_irq;
 
 		/* Reset core now that clocks are enabled, prior to accessing MDIO */
 		ret = __axienet_device_reset(lp);
-- 
2.43.0

