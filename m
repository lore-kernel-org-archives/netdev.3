Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28353D0B6
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695079; cv=none; b=BAJQyaMEa/D58vMhLfWB4bea+8+jJx7AL94iBeDxiNjH5kfOz0M7rObMCuKERS8KhB9yX0QJKYCvieW8zL4t4M7ITwA5FUCC6mMUwz2pBYsmOIaltGGZKM+4tak8SoU89WzBGcg5pvjOXDCEUDpVQlnrrO5GqVD8KUDhW2UL0sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695079; c=relaxed/simple;
	bh=xG8fQs+Nv8hzYaB47vBOWqr+MR+BJEmuFuZwRxqnET0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEgm/arGYPyQW/PbW97tThjLzaWrxhFU801MGeHmI2S9AAqK+b4tmDmm1l/kowl9PPJ6ctrfxlnmuTnRvysR5BYJBklft1QL89HdBn1+mQd1XGRNdS4pelPEjvfTy9jHHiqCQBYoJk9kDIf10PmBaJJ522tmMlL89uRvhRQpUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJjPFAC7; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJjPFAC7"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso32287425e9.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695072; x=1791299872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6TBF9avaY/bTBgvPOC6p2G/lL798dgydRUW2YJl/tA8=;
        b=hJjPFAC7Qrjc9VWgZio19Ell+7G7mzSgX/IwZMpcVNzhkpAFHDNw/VSegeIhenBBao
         tCkMCGNHAIQgfFySZp9ZhC59diNlypXVCqMn2qFJcmmmRUjpc/pKtEzGzRxNDlz055Mc
         jq8u5vVhlWIhlcBJBbHqw0SO03FyQ6MnBixio7CvxIyXn3qCS12Qq78sD9+koxGehXuu
         ERLzIu22Q7FptOAkIroEUf0crnhtRnYsQ25L6CWGHZuwd6Pr6eXipW965f34QP0QowIh
         IXagtbOqGzsZ6CYUU2VKc1H+JufFVzwO8RkUbajJhKVasPs0130i5F45gEUWgocdbxhd
         SaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695072; x=1791299872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6TBF9avaY/bTBgvPOC6p2G/lL798dgydRUW2YJl/tA8=;
        b=hMzZS6UepBWlBKneuKkOM90xPcLVaoMFOrp40OTjGuwnXWV0/qq8PrewMor+8OmepH
         kGfiaFAeEvQwp2d5+l0MV2DiNdDrsA6u+ekrAdgiA5nl1Ro7q6bM/VEGyMpQoGf+k2Ps
         +QuNsjnOuLZ5hGjo0O4vZEdQ3LkJt4g+ADEavq/mURojbhK7+//O1tnnFUr60VVIvNI+
         UJVJmSLDLVBb7RDGBT7RTvziSJc+/8vRbHIr9fzrl+WgvEEU4H0rG2asA6653iNHSEHp
         ndzfdhEjKAR0nDJfVUrPz4WI6V7d89ilDYj/UCDUvJCEiQqi+3dCtOnGySN9VsvdeExK
         /85A==
X-Forwarded-Encrypted: i=1; AKwUvBxC5u/061Jd9Y+wYvWX8ubjagNA5AGgtwqkPSWU9sE5Xyv7YS4bEBn27Xuu59cxLsw5bUqZfrE=@vger.kernel.org
X-Gm-Message-State: AFuF++nZMLdUocb350N5a5U28p38Rb4GC3Af6jyq/FmQfdaNPO23fOBQ
	OPvkctWl+U6JQYyQpmsdc38t7mXjD+ITYq4ls1x/pD4zOE5WS+v71SDk
X-Gm-Gg: AYBFou0egeyhY+rJIoxiJEttiOIHBps3A+s4FO8zcVHwuAe+PxuMM8BukBy6/dpoIVV
	UlIRkZx4cxzNJz9+r4jRS9ZpQB1pTk9dfmaZKrMA3lJj3IYZ5jaPdUq6Bgt16vXDBUoKC7QNz1s
	Nk8RHrRK3PaHMRZGja7PeX8R4D/QPV85UY4rhBIFEV54xjTrRuVHJDy4l8Ae4HQBHfdZvT08lDF
	5zeejxlZ0xM2OrLQOSIbVJKL99+rYMJy7h/Ly1p6i+Cs2kV8o2BPaXYR5SJIRBAtys/RLYkmcHW
	uaLgY8gxtEPS6uAaTKtTNrATxv+sDb7Lgwt8AGVxY61dYsTWKgOGrVZ5wHhQNEsfR6dEQFdCrJD
	wGhf3kV7mg1SQNyf0osQjPCYgCVLyuAg5hAXUbU1Ao6n2itwgIopJ4PBqRD73Yiah/9SQYMKUBN
	zu2bXYLej/AI57HAqOicYH/1oxw6rII3hN4HxNzJFy4YTSEu3JFr2/sRhhPGsFjfgQrG3qG1ZTy
	uFzdEKLj0NdtGlGAtNjCnHfd50QIx6DvXefYQ5Z2iiLaZ7MWkkraOzzTYlbXrtwOeceNzfe6r+P
	2QgTPqPjQIiCvZacnXqQq+c=
X-Received: by 2002:a05:600c:19c9:b0:49c:d019:70c5 with SMTP id 5b1f17b1804b1-49fe7ae84a9mr291312065e9.0.1790695071599;
        Tue, 29 Sep 2026 08:17:51 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a013cf8402sm10313705e9.2.2026.09.29.08.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:17:51 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Joseph Guo <qijian.guo@nxp.com>,
	Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v4 04/13] net: phy: micrel: Check RMII clock select property presence
Date: Tue, 29 Sep 2026 17:17:31 +0200
Message-ID: <249f29ecae7cf9dbbeb9691df2c67e4f0cfe326f.1790693249.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790693249.git.stefano.r@variscite.com>
References: <cover.1790693249.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Radaelli <stefano.r@variscite.com>

The micrel,rmii-reference-clock-select-25-mhz property is tested
for presence, but of_property_read_bool() warns when the property
has a value. Encoding it as <1> to satisfy the DT schema unit check
would therefore produce a warning at PHY probe.

Use of_property_present() for the presence test. It accepts both
existing empty properties and the new numeric form without changing
the RMII clock selection.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
v2->v3:
 - New patch: use of_property_present() for the RMII clock select
   property so its numeric form does not warn during PHY probe.

 drivers/net/phy/micrel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index ae830781824b..acb481a29c25 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2791,7 +2791,7 @@ static int kszphy_probe(struct phy_device *phydev)
 
 		if (type)
 			priv->rmii_ref_clk_sel = type->has_rmii_ref_clk_sel;
-		rmii_ref_clk_sel_25_mhz = of_property_read_bool(np,
+		rmii_ref_clk_sel_25_mhz = of_property_present(np,
 				"micrel,rmii-reference-clock-select-25-mhz");
 
 		if (rate > 24500000 && rate < 25500000) {
-- 
2.47.3
