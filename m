Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F33E866B
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546409; cv=none; b=FsBM4/kSiBX/txChkj+ZGok6M7P440aLyYLpgXUuapr9zCek9aCrEfWpAWnesP2gdBsspfglnMCBHdyRWoIpXJ83M3hPCHLC2iquQ9hUXCKd9SMQYIUmRej++Av3DiAcJaJeFHr+5XGHII5Hvd3s33DGvSMvQlcejgTmBDN7BtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546409; c=relaxed/simple;
	bh=Hx5UJuxKjwprvSGWaXQVjVJ0w0ttNwljukD9w8lrWm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rPpFnC3JA+kwBLqotkpZsILt/HO64nYkj2XiOe9fPtVw6Xuuwcn7nrbIjo+N7nnvVhjpfoG5Wn/GHTVr5Fjoi6jkqh7v3OobDpm/hgcUH2SFKRAllzq5OQbvdAon5BdA1i2Kp+Vxc1bVsX1/kRYS0J7s+IfGmhuU/9S/fJbMbHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sedZzQuf; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sedZzQuf"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-8137b129131so1604880a34.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 15:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546401; x=1791151201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KfjvWDlH74aBokTz23r7fE1Dwv67vVeYYEoQzFsEUhQ=;
        b=sedZzQufY1aPY2nUE663G3m9glioc6Lnd6BjODfLk/YLBrrOmH560H0JbP2E7GSh2M
         U99bvf2EudZDkXtBeGO+Ni6d/RgM4ZU0M8WznDCpE+yMymBiw5mnlDaBWwOySkDVUpIc
         GCbqRcORHJsB/epZosPsD/d1aDAJn+LZEGCJoW9uOPmFKDsdPuQFhwZX/sxR8R+JnO74
         eGYcA4xyRGH/soY0V8hE7J4MlGg4VcBTNJi6QvJgAB9/H2sshFgJw59z2Z4tOxmlLWwC
         rQSwuHa+CPcxkAsGwmRewloh1SZLZusmeA2lhsoRn0uASfKMJOxOL1HmAITMOBoTM5oZ
         pliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546401; x=1791151201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KfjvWDlH74aBokTz23r7fE1Dwv67vVeYYEoQzFsEUhQ=;
        b=qlJMPK38t7EbH4a7c+7ldYnOcvVqmkSVry9M4GW6+ft6laZ5k39uj6yzepVAUlC7//
         sIv8NtB0yQ676HrbMH5DLhbFaYguApBczRqAQbj63ugV1H43OfZivcA+5Qw4qbfjDz1U
         zt8ZxFnTV1/sI6zVS0/RCLKSMr4LD5PrNSuhsXJx84fBcEJ/hsRQsvVcvUd3ih4pt0CJ
         3bMlf7XSkpFAH7BuCRtbQVxB3zCfJLP7g2QJ/w0U4+amnLmNVQk1q60EvKkaCkcx683G
         szX9nSXJHIh2eCNlgBSdtDo4iEXfV6PA15py2GUjl6oAsHo0lQf/c1rEGfDtBHrlDbQW
         2/BQ==
X-Forwarded-Encrypted: i=1; AKwUvByTPd04z5+i4TmFNXBp8ZhzL0MyWt2BmMGIDGy+HUSzBHC4scpEaj5KBD/s3LL54jOdpFHGufY=@vger.kernel.org
X-Gm-Message-State: AFuF++lvD+C3rNfq9HTkd6CbVMb0PqgqoCckqrUJsbxuSrqew/eZ/vBH
	+vE0SwgkZcRrjnqkOTAOO+R3hNPX65p82KsfR5/HxQvBqTdLZ7kPj8cR
X-Gm-Gg: AYBFou2dC8/N1HNGf8xGpZRlukg/Do7vsLwLvASMIUfoXc20CwQbR/GSe4toQ2SfzyG
	x5bBQ4BrWcgDRC/vLUo9NNdCaxa0aQaVgDVgDaMp+yi8801h/qpZMYla6B6SwLIPBx0jA6gSlmP
	1OU682YFPrGryIDYv9TMQhbGjsNNZZiXOvTWRIeSrpSSLtkOqOstLXTz7TneTEPMRM38aUQKLuA
	lIAl/dVGLKFNgAZ1Ip85igAw7fLP1nmsl5z/uf0Dvyvou737Wo664N3L+bysP0GEyyWhl35WuBP
	OosX5aWGvTsu7v3F/sS+n/8oWxeTTqnaJsr5unX+44ybIYKoq2eDMxXfgG45/QqzjXl4F6H3B41
	qc7rc9MJxQaEMaxCLOVv7z6f74uM6PP6pRNCi7/o6zU2aogoe4zyYBLYAWhczSQXxIvZAcUZ5hD
	VLS4csX57LDWYK0mFhgFc/OfK+BBwycw8USl/yAYJ+oQM8ES96ZZH0duL//q995JVN/cmes8ejy
	coSxngYZOMW0HbbZjCx/AxPOUpAIKE8K5WjzmqtTQZjFbagYmDGX3hmmh5PH65aJKpJbbvDQ6b5
	EYXgyplF8JtxhU38x4ixeqbHru0sy7Cshx+BN7Doxdf8vooLkuDlh6D1x+d6y57aEfy/Z6AnAz9
	6u0fjnzKyeGa8GkL4PYZpOA==
X-Received: by 2002:a05:6830:25c4:b0:7fa:5c68:d04d with SMTP id 46e09a7af769-8178317f9a9mr11970434a34.23.1790546400973;
        Sun, 27 Sep 2026 15:00:00 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81b3de6f7e1sm4874147a34.22.2026.09.27.14.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:00:00 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 27 Sep 2026 15:59:41 -0600
Subject: [PATCH net-next v5 06/19] net: stmmac: pass the desired EST enable
 state to est_configure()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-submit-stmmac-reset-fixes-v1-v5-6-feec6c14dd06@gmail.com>
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
In-Reply-To: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, 
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Joao Pinto <Joao.Pinto@synopsys.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>, 
 "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jose Abreu <Jose.Abreu@synopsys.com>, 
 Yao Zi <me@ziyao.cc>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, Linkui Xiao <xiaolinkui@kylinos.cn>, 
 Linkui Xiao <xiaolinkui@126.com>, linux-tegra@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Pass the desired EST enable state explicitly to est_configure() instead
of having it derive the EEST/EST_INT_EN bits from cfg->enable. This
decouples the hardware programming state from the priv->est.enable
flag, which records whether the taprio offload is attached.

No functional change intended: the callers keep toggling
priv->est.enable around the EST programming, as before.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c | 6 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index a8a5c8fdd5ed..1fd9f1ab316e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -617,7 +617,7 @@ struct stmmac_mmc_ops {
 
 struct stmmac_est_ops {
 	int (*configure)(struct stmmac_priv *priv, struct stmmac_est *cfg,
-			 unsigned int ptp_rate);
+			 unsigned int ptp_rate, bool enable);
 	void (*irq_status)(struct stmmac_priv *priv, struct net_device *dev,
 			   struct stmmac_extra_stats *x, u32 txqcnt);
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index afc516059b89..f15d4d046aa7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -26,7 +26,7 @@ static int est_write(void __iomem *est_addr, u32 reg, u32 val, bool gcl)
 }
 
 static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
-			 unsigned int ptp_rate)
+			 unsigned int ptp_rate, bool enable)
 {
 	void __iomem *est_addr = priv->estaddr;
 	int i, ret = 0;
@@ -62,7 +62,7 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 		ctrl |= ((NSEC_PER_SEC / ptp_rate) * EST_GMAC5_PTOV_MUL) <<
 			 EST_GMAC5_PTOV_SHIFT;
 	}
-	if (cfg->enable)
+	if (enable)
 		ctrl |= EST_EEST | EST_SSWL | EST_DFBS;
 	else
 		ctrl &= ~EST_EEST;
@@ -70,7 +70,7 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 	writel(ctrl, est_addr + EST_CONTROL);
 
 	/* Configure EST interrupt */
-	if (cfg->enable)
+	if (enable)
 		ctrl = EST_IECGCE | EST_IEHS | EST_IEHF | EST_IEBE | EST_IECC;
 	else
 		ctrl = 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 2a4099fe470c..64d890664421 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -74,7 +74,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		mutex_lock(&priv->est_lock);
 		priv->est.enable = false;
 		stmmac_est_configure(priv, priv, &priv->est,
-				     priv->plat->clk_ptp_rate);
+				     priv->plat->clk_ptp_rate, false);
 		mutex_unlock(&priv->est_lock);
 	}
 
@@ -104,7 +104,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		priv->est.btr[1] = (u32)time.tv_sec;
 		priv->est.enable = true;
 		ret = stmmac_est_configure(priv, priv, &priv->est,
-					   priv->plat->clk_ptp_rate);
+					   priv->plat->clk_ptp_rate, true);
 		mutex_unlock(&priv->est_lock);
 		if (ret)
 			netdev_err(priv->dev, "failed to configure EST\n");
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 357d1eaf0d7d..67c6fc32d0ea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1082,7 +1082,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
 	ret = stmmac_est_configure(priv, priv, &priv->est,
-				   priv->plat->clk_ptp_rate);
+				   priv->plat->clk_ptp_rate, true);
 	mutex_unlock(&priv->est_lock);
 	if (ret) {
 		netdev_err(priv->dev, "failed to configure EST\n");
@@ -1100,7 +1100,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	mutex_lock(&priv->est_lock);
 	priv->est.enable = false;
 	stmmac_est_configure(priv, priv, &priv->est,
-			     priv->plat->clk_ptp_rate);
+			     priv->plat->clk_ptp_rate, false);
 	/* Reset taprio status */
 	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
 		priv->xstats.max_sdu_txq_drop[i] = 0;

-- 
2.53.0

