Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE443815D6
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793000; cv=none; b=Re52WyVcfL8fQYUuGyKbqssqeNT1YHZL2dFxNecUI+cMpvrMoJ5MYNCNGEZYDLva3DHYKX3BSuXHerfAqEYOvrOAGZsEi1jKtDNf8XnRDNLxsdPYjT4Mes4XT70nq/EWAJxwCmXlqU5hL4a0wvJPOSEdt+joIGRJRarKvFm+IyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793000; c=relaxed/simple;
	bh=1bq/W0yF9PeD+ycJds7LgcI05OxO22szqDYp6wvvEtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+ldeoxUHnXVJAodOBbS7oVTV1MXjdv3g5go0SwtNi06eTqhC15XYKTaoS/lqmBbbnbVRCB+m4dEm0LLfd2jzetsus6F80hXcQItj6Q/lvNwFbzmH33Cx7iCyVi/S29cqCN+bed9mbqcYzpjq7hfmGP/dR+9ug5RYLDNp4S2JEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDq+540S; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDq+540S"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c964d52321bso864923a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782792998; x=1783397798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EG2fAhbSvmD2UnsNh2J+7cClBAWJwMlTSzzcRhRVGMg=;
        b=RDq+540SRzU3PCG+xgXkIqgziBktbzl8Oo6vSpttyTeCE/fMgKcC6MrsQdRd4bAjX+
         XehLUQLL9YnTclMrBSBwssXqnoSrT+f7pMb7kEvzoduy+u3Nyb2qffIwezQfYoZ4ZfuP
         X8Y15ntfY5U/v62SHayLjxfnPc4wVlguDxyQIbtrEl2BlT8YzktYxblZxL52xnl+1Nn8
         QcduJfaC1DNRA8SCfoqw8wcaIE51pJ/O3+kVsfqhqp0Ky6bZZtS8+l4yZOm0Jn6Ch5v5
         siEWguZvAmfj+ab2sHk0yz3qn/bqMptL1gExQQaC3ebFvLta0cuH9362csVOvU3gd5ub
         9YtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782792998; x=1783397798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EG2fAhbSvmD2UnsNh2J+7cClBAWJwMlTSzzcRhRVGMg=;
        b=BE5oNdmwam4UfOLPVTQUBzd340jbJoeihsRJpIBjAiypJjtctmQWFQ9GX6veSeo7KM
         3Pj8Kt8nN3BZhe+xF+sHEYZCMdSft6rEH+rf6ug+KyOiTIdKkwRVQHs8izPCg1G25jz3
         VpCHUZMQZusBGPmVlzQUiLxx0vS5QmbuVDFj1ft6haWdS+XTXSmcO3VCqQ70vZWxIHVc
         Y6e0f+GzGuO4i93NkD4ZuReClOVcFIw1iK+iMnRcTGsgOI5kZ/JCvMt6evHF+pK9Vipg
         QYvvw+DEr7n3sj4+Vg1PoPMOqkXjK+BSitFBLR0I8+JDW6ncjN9kOws3gTJWW2/CK+ve
         5SaA==
X-Gm-Message-State: AOJu0YxUPsoRGFN666cuGD9iuc/CBijjEnOOxaRYY6IWBiuUJaC2AviT
	VMFGbzUkSE7Vz79ODd7Nhly5qPjI9fK7FHahO2TmljpnIkUnXFiLA5ZDmdo62VUz
X-Gm-Gg: AfdE7cmwib08azXegq+NCwZNJrtp+BKslzm6MWoZFT0V0HeZJZwik0ZGpGkEQv7n255
	KEsPX370jJzkjG7F99HxRc3dZUIWqVwFs+gVNCtdxx9fvMnfEvAi3+q/jBQH5vI0oFjTBL5btxO
	+8i6rxYq3RHn+nZeE/hS9UWROFCx5oEXJPvb8xyep0xVU5CU9IUez4CiQEPKt70vNfe1JVkIiah
	drgrYV8WxCrGPx0ezvV+k5WxJsqFUvn1RMOeY422NZH1OAJV06u/rEy6CelSHy4tgUkH3Rm27/a
	j+ArGK3aNKSsLya7O/Mq3naO7tXKY8IMfwUnrP/Nf09pRA0DkKyt9EIA+p1Ef2//gdBH2WJtAYk
	DzeCBUetrbPsYbNcbaqyc5G00oKxtTSBbU/yLN0gvF29Y9z5FFajXBIJnjdc/Gq0lK/y51M8EdO
	U0ajJH3wGt+n4mnNNerQ0nkVKux0RfahJ7MKL7FgrSn8eBIr3CAydwDNVvlee7WVTQflRx4iB68
	vNd4SEzWA==
X-Received: by 2002:a05:6a21:68e:b0:3a3:a9c4:3d60 with SMTP id adf61e73a8af0-3bfc5126035mr1651623637.27.1782792998145;
        Mon, 29 Jun 2026 21:16:38 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95a3e7sm702659a12.19.2026.06.29.21.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 21:16:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 01/10] net: emac: remove emac_xaht_base()
Date: Mon, 29 Jun 2026 21:16:25 -0700
Message-ID: <20260630041634.284127-2-rosenp@gmail.com>
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

Unused function. It's also missing __iomem.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.h b/drivers/net/ethernet/ibm/emac/core.h
index 89fa1683ec3c..46c5512c8e00 100644
--- a/drivers/net/ethernet/ibm/emac/core.h
+++ b/drivers/net/ethernet/ibm/emac/core.h
@@ -420,14 +420,6 @@ static inline u32 __iomem *emac_gaht_base(struct emac_instance *dev)
 	return emac_xaht_base(dev) + EMAC_XAHT_REGS(dev);
 }
 
-static inline u32 *emac_iaht_base(struct emac_instance *dev)
-{
-	/* IAHT registers always come before an identical number of
-	 * GAHT registers.
-	 */
-	return emac_xaht_base(dev);
-}
-
 /* Ethtool get_regs complex data.
  * We want to get not just EMAC registers, but also MAL, ZMII, RGMII, TAH
  * when available.
-- 
2.54.0

