Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C75F3161A1
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 04:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786594836; cv=none; b=lu8I1E4T4MJMsfPRPvdrFoE9B6wUe7DyhJFTWcsH/GiNWgknVZlXNBAe2UL6j1fvOZ/818TK7FPKR5Oct2mX7tbreLPc3jxEnacrmTD0OirJ7d9xkfHjR7w5mPoSvtLXzwJ0Tp8Cf1uc70EOcHcbUKVD6WbBgMdC/dfqzJ+Vm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786594836; c=relaxed/simple;
	bh=jhz6oMwASk0fhspOmlgDfIWbfxvXA9ksWC4tOt4CDM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWj0e8xHaHc3o8GJgNJRVlwszg2k8TkcLB0QWGJYxkYRGbFyoU7tVQupyFrzIVnv+aJ3E3GXdeSY95/N90Pi0rlKs+9d7uoEBTXqR0ZG7BfuDlmUV62x5WTdkVvUrm0Tm/LY06X7725D9xVfJ2FKlo3nF1ZTAE1Yo08n/zdND8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEFDFfTN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEFDFfTN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cab973140bso5369565ad.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 21:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786594835; x=1787199635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JuAX0QZtIVEwbbkqe3Q0lDnHOIC7HPwgoRkKSD2AJfM=;
        b=hEFDFfTN0bqwOvFLDsuwxuN6OjES+zKeTW29PWkaCsw+IN38zoaSkoFi5i7LKEiJi6
         dkBHmffSbqfyMDB4HKmvOf5vIcgt7VgNz9FeJCxWqmevHfcND25+FHqA79pfgsoRD0K9
         mmj7jp6AL9CwLONqM6sp4kmG3bBkqXThjuXXkwldtA1wfE73lbSHF1eiPGsu3tj4Gved
         lR9WCRFbmrWPXVniYhKcCzysdrwMhH3RLLv69NHCZNoSNa2FuQ4SOMai3r9B4glQY+O2
         rtpUtoiF4LAppZ30KohRwFbqhJw0tBLDX4foOX+ja3EFbw7cylzz/elvMct3tticw3eP
         SnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786594835; x=1787199635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JuAX0QZtIVEwbbkqe3Q0lDnHOIC7HPwgoRkKSD2AJfM=;
        b=oHp1981wMbkq6phG/xpZ8P3dP99sNTvjmceb/FT8pO6o5Qa1Kzh5LpA8UqoZggQTLV
         Bg+aXiyogradveLlwHrKMaI0YG9MHcqVcVX1kXYmvSDtVZw9JqWYi3h2+Y+o1ZtfA3Vq
         VZ7TwbHTuRREfSl5BTnL7N4BVh4rccg0V15ntBfZTb6Q1b1+ku/moCNerhX9GTimT2R5
         f1oByKpKWLdF5C85Rsj3lw5uPpWXc6n1gpG1OKJ3TXjih0hxnbYP5F0+ZpEgyPmxBdgF
         jfuRY3aXNUnZjfEzKrYmhHUdhytu1Lk0T+7QGo19LhpQWyev7ZseJaASNqHoMvprZGT7
         /gFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqghWfaUCW8PgZyyBpROewNHK4TIHaL01ARyxGBxvNllEMNVLrM2DrR6Kvb4v4j0P7BOnu4kr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Z0F6Ab1k/R+N07f3aevzKRqDMwHTrY3us5mLgz98lSXh6+jD
	OfILGdsWZBAE1BObZxttgNe3zlT+d5HBWeff0GibqpEUKgC+nziT/+Br
X-Gm-Gg: AR+sD11EL1H3C5VEMfA/IlRO3NSTe5hXZ/U6eQwt2CNTnpvcYENjPrkipmd5wvs42C7
	t6ThwfH8nj0WV2KzT3fsv8PTMuRQ22revr14zTZG+3AulVdMDTPkWvUCHgbMqfrB6Reu80PwRB+
	3COlnbYACoFdOPuM7NYR3etWfEWUVi7NldNablKj9bXzZ6RLy+pYOFV8JQmu7kNRyyMaUqvGeMN
	BdLLlh8Z1+qfXHBVbI520jUH/fmsA6DVpeytCc/6uXeM5hiYnHGepIFT6Qs4n83Vpx1WZvrnm6l
	EBJqXgnVDoeED+zEAklLB7s5Qgd6QzuL5jNC4ZFOaS+XHAQuItpBwbI0PjBuBWargmZaYfbaeG0
	sGircOrrxypLo8VRbH3CyNNqlTJ+mYjmfIr7ZRuUgFdUGkXugsHqTeON91vk9ibogR7wweYhTB7
	Exy51fBq7orjOKZTUSoE1r+Q0JO5RWvLmxbHpEwSH4/4vZQPUdC2Z1K8hUs1Mf3R8epkii9j8M/
	41dLu3Oa/Ag3MjtTiFuD/o989Oevr5/LZ7kXr1pnhFg1TRT6oZ5J0K741QFYt5nUNZr5Xc1m7UT
	yyRJ
X-Received: by 2002:a17:90b:3c41:b0:380:7688:fbe9 with SMTP id 98e67ed59e1d1-3931e0393a8mr3833257a91.8.1786594834730;
        Wed, 12 Aug 2026 21:20:34 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931cd468cesm1700084a91.7.2026.08.12.21.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 21:20:34 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 2/2] net: xilinx: axienet: Handle optional IRQ return value correctly
Date: Thu, 13 Aug 2026 11:20:12 +0700
Message-ID: <20260813042012.17631-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813042012.17631-1-phucduc.bui@gmail.com>
References: <20260813042012.17631-1-phucduc.bui@gmail.com>
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

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index d23e9796725d..7ef099db1bcf 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -3051,7 +3051,7 @@ static int axienet_probe(struct platform_device *pdev)
 		ndev->ethtool_ops = &axienet_ethtool_ops;
 	}
 	/* Check for Ethernet core IRQ (optional) */
-	if (lp->eth_irq <= 0)
+	if (lp->eth_irq < 0)
 		dev_info(&pdev->dev, "Ethernet core IRQ not defined\n");
 
 	/* Retrieve the MAC address */
-- 
2.43.0

