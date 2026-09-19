Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0AF2C15A0
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789839756; cv=none; b=M931mw193wexSj9B8Fn6W8ECTWZj+OOToEU7Sa6UyM8guPeSL6JOaTzI0CQgnmawFmmV0+sFYpcAgCxRgLNRlsT7DsTCO2vry9MOj3DUUmBkBm667lnaz7gzko/8n5QK+HlerCh00lSr/+ri/AEd8oY24OBlm4PzdABarSdbsgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789839756; c=relaxed/simple;
	bh=ERVYNPfubS1lL7XJj8hGOUw4uQFg9cuUwbGKdJsaNUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MaTVLgApAvBfDaPokuKxjZeQRTFJJNoJoVTPuVmuNyWbsmUL/MJvfliJTEj+wxaZ+fg2iGuJLI2oZXZ63Jge8hkG4PP4aMQhZ2o204lWkeyYvcaB79zFNapF1TST/IR4Xy630ZtIcNoBuwZexM1Gc8vRyqNb06D0km7pZZOjh2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yr89mYWe; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yr89mYWe"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-39e501442e2so1224390a91.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789839754; x=1790444554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wqtGKu4ehtoV9DVHcDQz0i0Wul1TLpZRrMxi7IKUvp4=;
        b=Yr89mYWeUB8aXyJmU5tGNiLWRx6H40u++exYmhiCcYrJwHhbyNYK1HyulcZkr/KT4E
         9gfnJ9tDMZsxgAe68BIBmvqGCR8FyAC5+SKSY9so48H+1Xrl6qOizQGLdF//bv5Wlqzz
         PWVjlIRWZgGGtJL6OUAe9cAHFiBjeUwgMyiKKObogYt6spPf73A8VKwuKaueEYMUKCae
         LwlTBftCVR4CgQewFA1qK7zRnqkZmHbHqnE/rkakhKujIQmUVsOUz44kzyXujxDxt1US
         hnFHOgCJaTwjbx4bD98Mo+lh7qVw39ncO3uiUBH90GtC2XdW51cX4ClFzEtPT91lgxBO
         P+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789839754; x=1790444554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wqtGKu4ehtoV9DVHcDQz0i0Wul1TLpZRrMxi7IKUvp4=;
        b=VJR+3YnTvsnORcicePoyG4idn79frgaCxpb+fDuR6SJ64ZLfJVGQc4ey1bCDWvaIf5
         FgYJr5GMiiMhzXgYzKwbwgIfYCWnO/uxOIU+D8JMai/w29WfR6xcrnVUv2WUwSEQwm0h
         Tl5R6GzvukuUnknqpvQ/i+ZDApXntdszMGFCugykZHyrlskxTSTzvTBAQUOzsa/oNPD+
         7+mP8tKXidBvTQs2J1w7U5mB6wxeqQapd2c9JqFITp4aDtzQPyeONz9Q9D1+HEPmpU9g
         M2b08hdnKJ0T0x59K6Il8s5KapxjdCd+WWKuGaAIePd9OxEdO7IKdYAZtLnAE9R80P7b
         vMNg==
X-Forwarded-Encrypted: i=1; AKwUvBxnwj2rDBkZ+ZZgTwVEJuIfmHTNpekCbX6c9uCC1qiJa9s5EkbmAQmoVo9fKgHF7xmSOU9Th3s=@vger.kernel.org
X-Gm-Message-State: AFuF++l6PeS1qbaDRlFGf+ipwrcNLC7eXp7EiiZDvtKxNDxkkr4kK37l
	F8yXJWiz1ler4xU1OFUqmmrGUpfJCXiFlTwjVSYfsHtdZYgGchZlsEIQ
X-Gm-Gg: AYBFou3srQ6hJ6V3YDxcjr9dOMl5NnMEEOZsBVhStOEyTc8NFG/4XkVS8Y46spSd0hn
	jyYzUYad0N+vzzJUZDJmnsGHPaVXH1nkJ6Uo7Z86si4fRWAwahJAwDTkxV17tWrWS00iQrhGdP4
	a93Khh6xY/PVp/mRIB5JY4HsaRXrXrfGvJEATRM/FsmZF1X83XVsQKnmM7uJEEwuarh+sa05CiX
	CzS3ynf0TOGGTfeca0oXvAXFzaYjU1RDsfdU50baO0BQ4TClQ7hK2vWIec52Nvn00D4zYJf5yC8
	5ok9BTKTLtc+6YBEGUZOWhShdEX0ShYDpfmNETkVIwtP9oVKiKyCXbDrcdRMwUAAiqYqbqDuhfC
	cg9caPN0RNnjEFuydgKVdm7Q5rXMzCMtioHL1qkyGqSISoNkg1/tTUbbbSC/Nk11gdg5lCh7mBQ
	ZkBZrP+diJGqfueqpu6VdkL2miuoeoAhZJPIXkb+/TCv+eS/l2L2TN9VSFJqD+NpMx1bmNoszXP
	/13/6ho
X-Received: by 2002:a17:90b:384d:b0:39e:6c6a:656d with SMTP id 98e67ed59e1d1-39e6c6a6757mr4257438a91.48.1789839754436;
        Sat, 19 Sep 2026 10:42:34 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6f1835adsm5144018a91.6.2026.09.19.10.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 10:42:32 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net] net: ethernet: stmmac: dwmac-rk: fix bulk clock leak when the PHY clock fails
Date: Sun, 20 Sep 2026 01:42:23 +0800
Message-ID: <20260919174223.2356964-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gmac_clk_enable() enables the bulk clocks first and then the optional
PHY clock. If clk_prepare_enable() on the PHY clock fails, the function
returns without rolling back the bulk clocks, and bsp_priv->clk_enabled
stays false, so the later gmac_clk_enable(bsp_priv, false) becomes a
no-op and the bulk clock references are leaked.

Add the missing clk_bulk_disable_unprepare() on that failure path.

Fixes: ea449f7fa0bf ("net: ethernet: stmmac: dwmac-rk: rework optional clock handling")
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 8d7042e689261..f3a98bd9d6ead 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1163,7 +1163,10 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 
 			ret = clk_prepare_enable(bsp_priv->clk_phy);
 			if (ret)
+				clk_bulk_disable_unprepare(bsp_priv->num_clks,
+							   bsp_priv->clks);
 				return ret;
+			}
 
 			rk_configure_io_clksel(bsp_priv);
 			rk_ungate_rmii_clock(bsp_priv);
-- 
2.47.3

