Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADBA3D6CB0
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793002; cv=none; b=k5jpHW+jChwgO1k/TkP7TS9gVkjhNPAXR2r9fwoph8zWkKzuduOpKQ6z8YxSWjpvRkSzVin+5qfLZFATPGrPsyA6zRNf4KcNSgx4iGoAu9WZQG2md/JfC7VYDwiH7L7ZV9M2nAByC0HzZXM3VsLYjgKL4kxugzQh66850CAU4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793002; c=relaxed/simple;
	bh=xt21QE1VqYy9bI9Px03bY6lvMC/3LTqF7x6ygM9mT10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZwfCDqiISyUkck3OXQQKEKq9aO7+QmUSTvBaF4kmkoXyMRxi4iu1zjKKgJCLopike73B+7hoQ32bJiIZzEzTy4z1wyMZHKRN+8ufEj1erj5O6XSgtsbQT5J2IB3NO2mFlvzEc3VzZB5HejxQSyHnmxq0+lIBEISMQDoP38xzzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dP8h6fzt; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP8h6fzt"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37fdee9276fso1806937a91.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782792999; x=1783397799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3+TlLu1veQ7gQkbd8iz1W8RBT2z64POb37tY0+Wf7A=;
        b=dP8h6fztfXenrR0+daQ8VSZqCROJWipmjjqsqGm8cGGuLUNBJy0bRI7uIgEdINT/eH
         HEWGY+VMJQbO6EqBM4KuXtKqcEENeqXlhSkcvEEgVUzCsPcNeEQ+7D7XiNX5mXv9n2z3
         MUI6NTbQmYr8CVo3+b9LLJDm+OpPuWCRka74bs13cJJp7XYqcCEscqVl3dNU8a+hOcgQ
         bihuELmC3AvpcjmUc/Cx4mWBA93Vn/x1T1nBzw2lLsjWJAwcn+TJxmvSu7Ay4ZwbMvvc
         I/JtAJvymzUDO1WcZP1b9mhB+NNLnK9SMQZaHqiO3JLnPx2sq2mgp4M7Jdd/ovkx2R+7
         ww7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782792999; x=1783397799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h3+TlLu1veQ7gQkbd8iz1W8RBT2z64POb37tY0+Wf7A=;
        b=YJnpewaQ8zJIma9tus2yRZdF+3B+of02EVOwT1lyg4XSZMNYlUAcQs/h/A9e01dI1w
         alAuCWi5bdXm8lpQUZMy97m6BHI4S2EpRqJ4ngf2ixXbKF1Qzy6FTDYLG88hnO/7rYz+
         3FRHJWuZHGSQDCohqpIJdu2Pz3LKPAynbowftGS98/WiZdviBk+ALezVOlNRh+zamnYg
         4/dxdEIuyqsF1/n3siQKqymrr6QlhIj5QsqZkD0sltcg1o8yxECz0vlBl0LaanO/7dt6
         O6YfcBAilpWNSlpaie4Kj+3ml1e4BwmrXbQc0CGTW+cUVe6beLpEcm0JXF4u8iukyBrH
         bZ5w==
X-Gm-Message-State: AOJu0YxWwcESoM3Be51VSA6y5YqUlnTDJpnsl/VFh7xliWEbhwfOx05s
	y0SUKwbZcD13CiF7HMuayhN6uo/IcOJVjRoYqMOcS2FPCnAIaDDbeZ3SoVj6DLPy
X-Gm-Gg: AfdE7cmisGbx4W1D1lcY7B0IzxgzVjeSedn1pnHiZmLHBq8DMIkBoQuImeeONHA7u4z
	qDFXUnnJOBfYKFv+EqOQFSregvNBl9jj2HZM6JY73Z1uXhNUt4/MznG6CipBsAck73e/7Qj7K92
	eD0jdYkRe78WnJE7q94mXYPKwCLpIPlHsE1xO3OTPQRjSGOSXKiN9itKp1T68NsBtSqpSM+Qdvu
	UyGkYxrx5rQ6lP3iAKQzHBTqt9Xp0HdecSo1PMDBUMm7il2/ryhQ6ZYDOb3XYQNAP7Qwv72guf8
	E6XaXjGy8jYVf3Oju+wXqesoNZzULFYEbyaJAAjpLMLdtkB/Mj3HxKqY6q1vdeVUgmsSK7Tr8Ei
	zeZimUT3X7zyJ2AMRwPxVw8OnM5ucTiZWcsOwwQ5fBv9brXh9MLbn71LKoS74jYX0ODijtUhRMh
	K4WAYaE0Qrvpn2Em+swY+RbUBOo0bxhs9Ovn7CVCKg9K3qwLF8BkfeMxgTvqYUELB7bwZKFSnK1
	oUCGBPRtA==
X-Received: by 2002:a05:6a20:db0c:b0:3b4:8f57:3205 with SMTP id adf61e73a8af0-3bfc5272280mr1899199637.36.1782792999415;
        Mon, 29 Jun 2026 21:16:39 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95a3e7sm702659a12.19.2026.06.29.21.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 21:16:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 02/10] net: emac: fix sparse __iomem warnings in IAHT register access
Date: Mon, 29 Jun 2026 21:16:26 -0700
Message-ID: <20260630041634.284127-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630041634.284127-1-rosenp@gmail.com>
References: <20260630041634.284127-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate iaht1/iaht2 in the EMAC4 register union with __iomem so
sparse does not warn about address-space mismatches, and simplify
emac_xaht_base() to return &p->u1.emac4sync.iaht1 (or the EMAC4
variant) directly instead of computing the offset by hand.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.h b/drivers/net/ethernet/ibm/emac/core.h
index 46c5512c8e00..296da4bf3781 100644
--- a/drivers/net/ethernet/ibm/emac/core.h
+++ b/drivers/net/ethernet/ibm/emac/core.h
@@ -399,17 +399,13 @@ static inline int emac_has_feature(struct emac_instance *dev,
 static inline u32 __iomem *emac_xaht_base(struct emac_instance *dev)
 {
 	struct emac_regs __iomem *p = dev->emacp;
-	int offset;
 
 	/* The first IAHT entry always is the base of the block of
 	 * IAHT and GAHT registers.
 	 */
 	if (emac_has_feature(dev, EMAC_FTR_EMAC4SYNC))
-		offset = offsetof(struct emac_regs, u1.emac4sync.iaht1);
-	else
-		offset = offsetof(struct emac_regs, u0.emac4.iaht1);
-
-	return (u32 __iomem *)((__force ptrdiff_t)p + offset);
+		return &p->u1.emac4sync.iaht1;
+	return &p->u0.emac4.iaht1;
 }
 
 static inline u32 __iomem *emac_gaht_base(struct emac_instance *dev)
-- 
2.54.0

