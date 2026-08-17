Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF013F7884
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786963985; cv=none; b=PUcSvUFGetq3PBhgqvdy9NJ1uYkgtmpkcMWDkXK/V/ZcGXeHBk8FSl0r+rlAWEP+IDXE6jNXKH/Poa/JX27YkN6FtF5VxsPY9BMG0Oxhr7q7yrgoGmNaFUcE6Ej45LwYrL3cliEfk4Cvz52Q887ed/dJCG8to/MMMg3OyETx2Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786963985; c=relaxed/simple;
	bh=jt9f/5Bg5HKdcUg0UDYwKyDopsaUzHywIYt+q+N3dcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IY8WllSqOtoFgOzKfY8XMxlaVsv1weGuI2aifhpoKaJEKnKP+L5y/J1njY3dfRj8eN6UT9rSp7dBSo40qwNB1s96e5yINXVDvdVvnF3fvg0jGrpCXBrHZhjGO0gyzUtQc6DTHpqbRICJppAUh1/yHlxk5ABmk1+PI5zFdN2urmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvCcoWrL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvCcoWrL"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-848643382fcso3281670b3a.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 03:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786963981; x=1787568781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w/B8tIPegnY1ix5z2/emLnUMnM5hsvaByPeUzupMv/Y=;
        b=kvCcoWrLKFzOrFzh8Nh4lVeBQtVFYZiMgW1kHtfpCaZuulVHNvw+uYW3iISoSgCbXj
         HNNqjZuiwbLrvQrQHq5v9HOUaiuSOGhwQnazUG70sGKaGOt5mQIamoL8idcfsg0l2TAZ
         rtDBERJKKfe07CcjapoGWuotbaWYfWS4zXgaPeX3R0s9XRLLWf6ifk85CScjjDosAUDw
         72FpUty0PkerS5dDO6xt/q5NYIn/RUzaGttj12UM1nZb1g3oYQLC8wbGH1A+Ez/rYePs
         XLMYMCuIWtb0wSG+musAlSZgFZ26UD6Z5w9V1sEnGZKr946UNpcuWyvyV11VFAfbVfVW
         waXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786963981; x=1787568781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w/B8tIPegnY1ix5z2/emLnUMnM5hsvaByPeUzupMv/Y=;
        b=RILF6DV7L9yif6vexsqcLpVkrW3CB8mY6Cw7ZFRLAqdXjygnRft6Uy8TORDw7CE7Vs
         HHwT4iiEGPlyovBbKgQ0SAdxPtthX2YrvA/+yw+8LKP0uTlf//0/oFgzHXXuAxnxwKdX
         zsDnT4e9XGzBEdhYasMxrn1DAEaKqeDXD5dQ/XdDMjfV6CbD5JDzJMBahXtarjrhp35X
         fROLq9HhrVpOcXBlqkk4IxtAt7rdffr3pFFKR9dyKoHmjeVdsD4d2HKk+ecJqUUH0hvh
         eko5Qet4i5lwDsluC+P4uyoy7m72+x/TBWkvgDgL+ghjp5OEsvPMYkTkvVjUb87Fbfmv
         KYvg==
X-Gm-Message-State: AOJu0Ywi6CHROWmeMg8Yg35N55w8VsHsD6Juxb9Zn3qSmQ++YgOp5Up7
	VGqiz0dXqwwrKCuDXEY8SQg1NyQkPTRlygfDM7Sx8nRdzvBFqVELKg3K
X-Gm-Gg: AR+sD12aJyZcFIh6UunPhzUU/qj/nn9q6V2hcuQlECRQ2hb9B++HBhY4D/fQxdH313R
	MvbgP9Njif5Gzov2t399/WT3sBDbn1orkm7o0bETxQEYL0ENZuI2/QTU6WHIZ1TIiyugE42uB0P
	Pq3Hw79r7WptaLc2yzaYUQmK9UDLFaI0IPrNk+1OUwkL9bzGZzGJ+DZBm1P0X7Ldsqz+pjnG6vR
	62BEe0Og4bMMzJVdggfsSLX4563ScWnYqMWeDcKNtiy8/LmUIzc5cCiLO8KdvBU9i0Vb3g1Tgz0
	rK9JCeZ+nt1Ak+XR63g+sicLpJKTty8ZShsxmlduxORt84hmB22VfC6LsNVrtpTf9XYVGi1tUud
	EjPrmQzgzGIRlVQ37guwJncUIvHxxJf/4EXFhivozTsJincu2/HcMgxsLSpvvG6X36hjzcb898Q
	ok7M7/Q2jSlmo7nuKaeuWxaV96kAOOoUNJqpVnaI3BDDQOPd9hdfbhjtQago+Oip1vuvGJNjxbb
	CN3c1S5MCAult9kU8XMzmlhuBRfSQK6pUISvPPe93Tyar22lG0TxIByY6M9sJsjNa12gun8Zx7W
	4Ez3BwjiFw==
X-Received: by 2002:a05:6a00:32c3:b0:848:5cf5:5040 with SMTP id d2e1a72fcca58-84fde1564c3mr23741397b3a.10.1786963980764;
        Mon, 17 Aug 2026 03:53:00 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b401ec98sm354846b3a.6.2026.08.17.03.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 03:53:00 -0700 (PDT)
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
Subject: [PATCH v3 2/3] net: xilinx: axienet: Handle optional IRQ return value correctly
Date: Mon, 17 Aug 2026 17:52:40 +0700
Message-ID: <20260817105241.63345-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817105241.63345-1-phucduc.bui@gmail.com>
References: <20260817105241.63345-1-phucduc.bui@gmail.com>
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
index f92951422b2e..50f88a38b6f6 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -3049,7 +3049,7 @@ static int axienet_probe(struct platform_device *pdev)
 		ndev->ethtool_ops = &axienet_ethtool_ops;
 	}
 	/* Check for Ethernet core IRQ (optional) */
-	if (lp->eth_irq <= 0)
+	if (lp->eth_irq < 0)
 		dev_info(&pdev->dev, "Ethernet core IRQ not defined\n");
 
 	/* Retrieve the MAC address */
-- 
2.43.0

