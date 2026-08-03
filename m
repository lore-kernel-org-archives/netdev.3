Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B889414DFA
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766681; cv=none; b=MDPwpHwFSuiGTYIX+o07EwP+hpCFl46LqGzM9MyzwpoGv6sTwwkIEh6+vquFDEUY5jy8/nYmoxQ6lIkSR1vvmLfmQFUrktBRQQjNUCa2TKRAX1872JI2wk2t8PPpjWqZ+nEbRlghmsosByV5HKNnw1a91kOfqoHM18at9mB8xTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766681; c=relaxed/simple;
	bh=V47oyzd0XPM6qZmTh1BgPQ6mJdcG+FwNvo/fLSmwpXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/JoK/e0sHXe3CZURnr2/iTnM06MAhJdRa396pzXwCqkKd3WhCK4TrHcAMUFCrIKHeH5b7nTfzNSs27W7vwUttXVutrAD6kaEeER4Y2bmy8Pnzvd0/DBSmUu5myuEcwrR9oI5kYvbGybYCT+z/Jh0JsH3L6QCUm2fH12UxTyclo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvEdjiGz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvEdjiGz"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ced3386430so34180155ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766678; x=1786371478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wn8DGKA5kSavmCRKRx9MyxFXC5hjjcK6hiv7Zc2G8KI=;
        b=CvEdjiGzilGV9t82WBz4Okenoo/EZFN+Sohg1SOAgLIOqXiUDj2QhfoY/hBxgzck7f
         LOrT/aRpFc1bA7TUToX8VkFzechASpKeuQfwQljcI+Q0wnh0jUr4vY/KuYJQ51ju2agb
         EHl52cBOJvoXo3KwvnR6Q2KSg+7FlsGwUMi4LdAzO6mA/dHFSX5kJlJQnolu9USSXo7x
         hcf2gKAT/KSSjF8Dxpi5caRujv5uMQIKokoCdMbAYMAOUVNHAtpkooN2xWGsu8sBOBKX
         qsFYY5Phe1b7x0/QtOqBFg9Qb7NOC6H9O2xgE8Rs8b+rmlqi36xdgDADkGdhenBP16Yv
         hHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766678; x=1786371478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wn8DGKA5kSavmCRKRx9MyxFXC5hjjcK6hiv7Zc2G8KI=;
        b=mmB0+lJZyFLvNLTIf45JAMmk/9MORgjRu+p9vQALmc6n6F7Vw7WtVXLsfK/u3+RKs6
         OqybRkWoky/mlH98Ru5UMlZkvwWDi6qSIumHTn9j1i2xr2sbPSXWnZSW3J2HawzqwdQ3
         JZVnT/1809RLx/5jF36u+j2mE0sRSjx3klUmF3al9izLf8sLQyAmx+fdaquFqw3jTfvS
         VB5SyCbs38uU/vu/RRVHTyRxGYS9uGEBr6ixpQgOWk+deuyvtjg1omdlvPidf1/12NCb
         xfmh+ZI87qBhQzbyodI41A/lA3FGW3169axHMX5c2q/whAmVJXPNjNcNlm1WS0LRbt86
         RmKQ==
X-Forwarded-Encrypted: i=1; AHgh+RpCyok7LDsBLlrQC/L3TKxLwM5an7Ao5KHKJR10DFrzqkMtfSZPbTzRx/DO8NXKRQGyu1sd/g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPBbtr9cnBcFl1qtaL9PoBOOx31zaH8BKrX0Lj9kmNOL6aRsC2
	x/CeUh1HVCZkBv3fEY10o1A7cMdI+DrdzhtjzekQ0Zgvf7T3xO+aa7XM
X-Gm-Gg: AR+sD12k9h7limP6boP830FVmfBwIKbMAvf6SW8CguZONubFUfBmr+93bIbShFOwhm4
	2icxLr9yrXROVNRQFGYzYdxARZIxRRj/SApkeTki+sBMp7aQa+gS28i6odB2pWZO03FKdhXDWE3
	3W9INoDPd74Ee4dyKlUCJwhk9nAFbpV1Z5zlO+08ictQ/psk8Fpm3S42nSf1l2QfFWBn6CQdfmN
	yZh8dH2CT7LGrjnqL2x2fUCaRsl2YYT7ix3PA/yKM0iO6K6Jtx2bfFe5qdz6gqbW2vgZy2GVQ++
	eyqzKdnE3+2T4pqQ2FLmm3JEcj21zQoSpG4AiixbdgW1VdN3JNMMBI3wN0zRol1DDhNI/YZVZgZ
	IedlDMSDfcVIshgtqoX/72xKJGnZuDJYIGie9u/7A+trkrO9uyQUKMnyxWoSMkUgDK1XT0omKLO
	q7Jzwg70EY+sA5qwhaclFD+rkLYazWn5svlYT0g+bywQS7LlQXDW6rCdmG8bIFtcn7OZDHvbhUe
	nty6RBrnS0fBcDzkbOkOcxbcDoqJHes
X-Received: by 2002:a17:90b:590d:b0:368:af5c:5925 with SMTP id 98e67ed59e1d1-38fbc4d0204mr9749689a91.23.1785766678572;
        Mon, 03 Aug 2026 07:17:58 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:17:58 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Laura Nao <laura.nao@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Kees Cook <kees@kernel.org>,
	Miles Chen <miles.chen@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Sam Shih <sam.shih@mediatek.com>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	netdev@vger.kernel.org (open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:\b|_)ptp(?:\b|_)),
	stable@vger.kernel.org
Subject: [PATCH 07/32] clk: mediatek: mt6735: Add missing MODULE_DEVICE_TABLE()
Date: Mon,  3 Aug 2026 23:16:34 +0900
Message-ID: <20260803141659.559129-8-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803141659.559129-1-akkun11.open@gmail.com>
References: <20260803141659.559129-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE() to the MT6735 clock drivers (imgsys, mfgcfg,
vdecsys, vencsys) to export the Device Tree matching tables.
This is required so that the clock drivers can be automatically loaded
when built as modules.

Fixes: 0bd9b1211f74 ("clk: mediatek: Add drivers for MT6735 syscon clock and reset controllers")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt6735-imgsys.c  | 1 +
 drivers/clk/mediatek/clk-mt6735-mfgcfg.c  | 1 +
 drivers/clk/mediatek/clk-mt6735-vdecsys.c | 1 +
 drivers/clk/mediatek/clk-mt6735-vencsys.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt6735-imgsys.c b/drivers/clk/mediatek/clk-mt6735-imgsys.c
index c564f8f72432..813241d526cf 100644
--- a/drivers/clk/mediatek/clk-mt6735-imgsys.c
+++ b/drivers/clk/mediatek/clk-mt6735-imgsys.c
@@ -41,6 +41,7 @@ static const struct of_device_id of_match_mt6735_imgsys[] = {
 	{ .compatible = "mediatek,mt6735-imgsys", .data = &imgsys_clks },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, of_match_mt6735_imgsys);
 
 static struct platform_driver clk_mt6735_imgsys = {
 	.probe = mtk_clk_simple_probe,
diff --git a/drivers/clk/mediatek/clk-mt6735-mfgcfg.c b/drivers/clk/mediatek/clk-mt6735-mfgcfg.c
index 1f5aedddf209..8a18ee244a4d 100644
--- a/drivers/clk/mediatek/clk-mt6735-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt6735-mfgcfg.c
@@ -45,6 +45,7 @@ static const struct of_device_id of_match_mt6735_mfgcfg[] = {
 	{ .compatible = "mediatek,mt6735-mfgcfg", .data = &mfgcfg_clks },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, of_match_mt6735_mfgcfg);
 
 static struct platform_driver clk_mt6735_mfgcfg = {
 	.probe = mtk_clk_simple_probe,
diff --git a/drivers/clk/mediatek/clk-mt6735-vdecsys.c b/drivers/clk/mediatek/clk-mt6735-vdecsys.c
index 8817085fc1db..d53ebf92e878 100644
--- a/drivers/clk/mediatek/clk-mt6735-vdecsys.c
+++ b/drivers/clk/mediatek/clk-mt6735-vdecsys.c
@@ -63,6 +63,7 @@ static const struct of_device_id of_match_mt6735_vdecsys[] = {
 	{ .compatible = "mediatek,mt6735-vdecsys", .data = &vdecsys_clks },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, of_match_mt6735_vdecsys);
 
 static struct platform_driver clk_mt6735_vdecsys = {
 	.probe = mtk_clk_simple_probe,
diff --git a/drivers/clk/mediatek/clk-mt6735-vencsys.c b/drivers/clk/mediatek/clk-mt6735-vencsys.c
index 8dec7f98492a..64ba9da9fd42 100644
--- a/drivers/clk/mediatek/clk-mt6735-vencsys.c
+++ b/drivers/clk/mediatek/clk-mt6735-vencsys.c
@@ -37,6 +37,7 @@ static const struct of_device_id of_match_mt6735_vencsys[] = {
 	{ .compatible = "mediatek,mt6735-vencsys", .data = &vencsys_clks },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, of_match_mt6735_vencsys);
 
 static struct platform_driver clk_mt6735_vencsys = {
 	.probe = mtk_clk_simple_probe,
-- 
2.55.0

