Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D00411FBB
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766666; cv=none; b=nOziSc+mNH0ozj0p0/poV6rvKCLF9qkXqvutYfmCFRNaCYVC5V/cpC7g96hI+z1YRMbCmX/+3HfA0Hm+N3Wpkmpc3gt1eUqRzdqvBOVxi2VOAwGWXutAXJnk+o42QVB7mjklhgfQJbP6PpQwcLJnYGYYmxDxm6ZRWDFLBCDI7iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766666; c=relaxed/simple;
	bh=PU2WLxTCykVfv59jdFKxJyVwUaIMow5rckLVbB9Wydk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgFiU93/D/2rv+gnPiB2t2Lc/K+YumDvg1EUdruuqgW0yB/Wjd+DUHxQjSHvE51qU87PyuXagf7Zioj2JMuktdBXqi8JmeO6jfwPYH9G/6RJZZVw8NeDiLn9Yw6QZ1aPn0h2nkd96c2gaRrVqN9JCJwhMR1QFcMYbjXgvfVI1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyyC1YIm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyyC1YIm"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-383cb94f742so3406654a91.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766665; x=1786371465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=13/m9BHJpTOrbyiXp3UlB7/KUp3A1MVFY837aXZLXF8=;
        b=AyyC1YImsRsLna/FCB8mGB1hdUoZGaaldEh9POag7q3AdyiZJAbudh4KQwgllQ/R79
         TdPxY+3HqXH6jzyBzhtHEJhcBxXjlrhWJushMn0I+SqdNVkuAWkA+w5hqT8GfTUSVzTk
         1ZceJi/0IjJvMcm5L+lMxOlIU6CnseejzoUgCAwOIrwD0pKgAaflm1TzzTlOcK8RUJMe
         iIsRwKHJ5LUAci/reLfjuR4QqqcyqS6+f+1P2DyRFRmG48dXnjm2Sao1zpdsBtlF3h7v
         yRKSNqykXy3Sz3nq4MwawChGBuN4CRE600tXQ7y1ihxMuZZC9s0qmSSQPR/pUjq2mH4z
         79jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766665; x=1786371465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=13/m9BHJpTOrbyiXp3UlB7/KUp3A1MVFY837aXZLXF8=;
        b=GfXwyV5yZlCFvPP00o2Ac8ypPNEVfMUdM40I34L96gpv1lFoWIGVag6eCiBLfzVxnU
         l6Q4Sv7dHtKQG7Ey6K5S0H9vPIjc9wYxBeHPxusubp+M7fs3wg3911UubPd42e4Ai+o3
         TO9rfzZD6aCt0NMBsSIYqsSAtX7TA1h/J5XU+2FJJDXiYgoAAM/CjhGTLpMB8yGbBSzV
         yQpuORtFyZrTYHysOVrFE5dkydfMZJdr12VBEFuT+v/q2gomLFmWaGhlPy7WlO/Nmj7g
         vvA5+twMl+6VnIlNP8qLvR52nV8KqTHtwbZDCMyAVXNhZF7HekoQ2RChhsqNk9bhw3MJ
         sMzA==
X-Forwarded-Encrypted: i=1; AHgh+Rp8qze31sJjhBCr3YmKwAwGkptTgM0qDl/T6GuudaW8lDrLXb2FtVCd0mHcjla3fWvUmNWcPpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh7UaV0EjT9H9nhA2BketRWudNFnGS6FhAIzsPY1wNQFghmyuw
	DuMY4L3J2XO5MS/0D28vgUKfj9UWUhP1H5M5x7eDl82v8ucELchac8ys
X-Gm-Gg: AR+sD10Z2c11+sbLfMu+smA53+QoURqp0QpYabhtA2y3cdWo5s1uqVTtwOrPmJX5rWt
	10wldNXIGcUZWMJLLq9u1mS/IL6bqL3q5LL5yfVlzaVJ5Iph37V5MAM6y+3rE2NdvpAarO0CO7T
	fEEuaDfi/zHD7VcqxQigkfmicrVyZErPBcfBNdp+kaoUhTa5Qou+YqWtAbi7HbAgPzwhH8gDqJi
	DELB3CxX6ZJD+EVUL47LKq+DbubfZa6ZT8tijT4xZI0dX30XU9EEIYVdQEU4znEIpvOk5dncoLb
	eckuSdxWEydNokUFhA9rdlQJAZWBE7y1U/1FL3t9hv2dE5bAARh+Pgcbng/C9obQQeKoglDzhC3
	jiTQcgp+z/LYPehxHUXFVzg548t0T/mwu43WcIY/h1KurnmOs9hApEqHqfPs1ctql7fHF/jK/dm
	Yc4KTuBcyVSqQNYxKlmBbvQdjHFfwTIkcXG5edqm3oMY+MvnQeA7FPSQwLROFk0Cbsz5YCngRjX
	DfCEA3YHYQPafNMXqn9
X-Received: by 2002:a17:90b:544b:b0:37f:be6c:f3f2 with SMTP id 98e67ed59e1d1-38fbc3fe415mr9386869a91.2.1785766664794;
        Mon, 03 Aug 2026 07:17:44 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:17:44 -0700 (PDT)
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
Subject: [PATCH 04/32] clk: mediatek: mt8135: fix memory leak on module removal
Date: Mon,  3 Aug 2026 23:16:31 +0900
Message-ID: <20260803141659.559129-5-akkun11.open@gmail.com>
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

clk_mt8135_apmixed_probe() in clk-mt8135-apmixedsys.c does not call
platform_set_drvdata(), but clk_mt8135_apmixed_remove() callback calls
platform_get_drvdata().
This results in platform_get_drvdata() returning NULL,
which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Fixes: 54b7026f011e ("clk: mediatek: mt8135-apmixedsys: Convert to platform_driver and module")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
index 19e4ee489ec3..e3b7dc13b458 100644
--- a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
@@ -66,6 +66,8 @@ static int clk_mt8135_apmixed_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_plls;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_plls:
-- 
2.55.0

