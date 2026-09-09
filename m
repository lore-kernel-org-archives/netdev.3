Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96023BADBC
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936462; cv=none; b=N0ubeoKMVyo4r7e6XC7QGiPeirY0llQ73BqYoacvUP3nmsXJ7t3A700j/Kwwz0N0em+kmE3ZZs1zRmzx5/wKBKwJUxpp7gDKeqRBp8WcQ5QjZLgGmuzwU39l1Be7QgxHTvLrGYBEd3Plrelvtx4tBfWkPlWqMGf72d+1ctE2AtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936462; c=relaxed/simple;
	bh=QjPDfY8HUX1aMlWrIqvKTmWKvq6qJTUY69IkdKukLbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDGaq9ltajnsAEXXlCJr6mcxvDAzMpNxkzTS3zhwnMDEfzqFAR5pHfZbQfrQJGUKqAp/idu0yBTZIUENJLQwnj7QrcNzfoCSuOoj6tt3yxNfPo6bbnx6eFPrlUryHLQwIbifsMcvsLBxTgW/exMvwwna39pYcsb79Cdql8DcOnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ht8GHM8k; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht8GHM8k"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84eb992a881so4013597b3a.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 23:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788936457; x=1789541257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PiRADsgEtjb9wVO+PPwZjDl9Sb9Qx/bxeGIV39F6Vss=;
        b=Ht8GHM8kcaXBEG0QxVEtgfiuhS0iaygTSQePwS5WNk+r81xJGHZbkPqUy787LO8/ah
         OZSJ5lMdF8x3a8lR6KbnNb6I1+u8MHU0k++FjmMz0byrl4QNrTwZeBGuIjHDW5bk4VQM
         NUaX986xhZr8nN6Wt3KaQbnIU538oH5QgSxIufiX1pLOr09C2hrh1UPKxr5XAbhDPUpe
         jQly3hE9A8vCSL2frAg1MwqV9HhsTkCr3ykR3Nh8EThvUTqhp6fUytARzkhhmgqhB0De
         vM0Af3QZN9kzPCjpC8pa7oViH1O9sRArn1sWMNmjMvkfh7QHnool7MBCoV6XFcZhEXpG
         Q+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788936457; x=1789541257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PiRADsgEtjb9wVO+PPwZjDl9Sb9Qx/bxeGIV39F6Vss=;
        b=epV3bjFjdhJ5MF80bT0z00CCMebJXSDYxSOoxq412P+j4z6VOimL6nfS1HN8j4Il9D
         PhAj4wp1WVbz/BjVM8/Yr8wisL0Qip4OZ5IqzGE+zBsICETg7JMihZg6wy+YoxrXQjlq
         Tm/IR0GlrMnz+21fvWnjnKSbdCiJmnLjuV1cP1rPErrZEVuMC8yIuVux4o/KTnqlCWqG
         xnMd6WmhX8Y97c0fTa3QlZwwW10WNAJvwOma1FWvyvorytBJhwEhrymbkGFPjt+GPPF9
         Kvy6TvOGGA1+02h0w734umAzdEbAOYVC4z3IX/EUnR7iE582nDXPS6PiJSEF4jthzboF
         Yhhg==
X-Forwarded-Encrypted: i=1; AKwUvBy5YuV08Zxgq/7syYWJA6G9C7Jt7MXjhDRYZ+eIR6koNBr04t0BZFP9zDpXGGM5fQUD6917HK4=@vger.kernel.org
X-Gm-Message-State: AFuF++ktioD1fuwvkZJe0Qhfq4gJwGQxZmHt0CsMfZdvhr8xr38b+bEh
	8rZXW0A2LSOOEy5rIaYmAP6sZLR5+aMGDSOg+buWGOLHjGucRSSqBirM
X-Gm-Gg: AYBFou1MPPmR2jZ7Yv2hXxGuwaqUvgB2kyrAyzAlnRZJNntoLrl4saoYz9VOFqnAxhq
	Obmh7JG7MGUUGT2798/FumCq6ey6vrTmcbwx3K+DTdiqAxe5mB/MK2vJL4QyUgTq1jOCv/ByGIA
	6WeywX4CaUr28DESGZBpA89jdOFBQ7XoFedZ27u38A3m3yrWc3nBy+OdxomrFR1g7F5F5xiPSdA
	2O0+pNixB22lc7DEDcS4HUOFj0R25YK7esuBY7tYvzbfJChoJGVjlfsGFB7dH0t+JSYrPObqDdg
	DlpFdRzq9/miCfeHCqrRYATqlbABzuiuQ6ijY7uDZx28/pQMIqgAIByaxkmm1+CE1yhDiMvF5j1
	STSPgb2pnVuTzOzSYsP30M6/RvgrSozmGcdz0qKEjCTR9tMe7MPhYtddwrJXLyYPcB/wHR15BiW
	SmOxcvqr6tJ+h0rsSYe58O0ZLQ/PnoQDR5OZYQgQjf5yYKymvPHkvPNhSsgQpKMFlLaDUpm7ivn
	6dpjyUIe+cVVBmVBzPlKUaR+PkXyO06TkpukN6ispbupU883W++6QJ/nfXO/NsT6mwSPY/lPDLf
	qqsIHLSP/IUxbUA=
X-Received: by 2002:a05:6a00:17a9:b0:857:7317:cff4 with SMTP id d2e1a72fcca58-8616a867724mr47261170b3a.21.1788936456799;
        Tue, 08 Sep 2026 23:47:36 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152045e8dsm6406973b3a.20.2026.09.08.23.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 23:47:36 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Wei Fang <wei.fang@nxp.com>,
	Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Stephen Boyd <swboyd@chromium.org>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net v5 2/2] net: fec: Handle optional IRQ lookup errors correctly
Date: Wed,  9 Sep 2026 13:47:12 +0700
Message-ID: <20260909064712.22539-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909064712.22539-1-phucduc.bui@gmail.com>
References: <20260909064712.22539-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Handle errors from platform_get_irq_byname_optional() explicitly while
preserving the existing fallback to platform_get_irq() when the named IRQ
is not available.

Propagate errors other than -ENXIO from the optional IRQ lookup instead
of silently falling back to the indexed IRQ lookup.

In particular, silently ignoring -EPROBE_DEFER can cause the driver to
continue probing instead of deferring as required.

Fixes: 3b56be218f65 ("net: fec_main: Use platform_get_irq_byname_optional() to avoid error message")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c6e29b5c2abb..f7636f23d1eb 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -5397,12 +5397,17 @@ fec_probe(struct platform_device *pdev)
 	for (i = 0; i < irq_cnt; i++) {
 		snprintf(irq_name, sizeof(irq_name), "int%d", i);
 		irq = platform_get_irq_byname_optional(pdev, irq_name);
-		if (irq < 0)
-			irq = platform_get_irq(pdev, i);
-		if (irq < 0) {
+		if (irq < 0 && irq != -ENXIO) {
 			ret = irq;
 			goto failed_irq;
 		}
+		if (irq == -ENXIO) {
+			irq = platform_get_irq(pdev, i);
+			if (irq < 0) {
+				ret = irq;
+				goto failed_irq;
+			}
+		}
 		ret = devm_request_irq(&pdev->dev, irq, fec_enet_interrupt,
 				       0, pdev->name, ndev);
 		if (ret)
-- 
2.43.0

