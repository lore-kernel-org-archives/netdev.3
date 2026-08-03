Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F37D41D20F
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766699; cv=none; b=RmK19Pv4uGeqfV5TGz0F6VKm/vCg3wkUmHCdluh8ZC7HI95jbMLCKvVjK+Xr6AQcWZqxFWNUWhcDVF8wB2mVUBt4Ig70JnHOVIwFTq0D3B186BwOkpPsf2kfs/2ZYSLG6ohmgubv0nY1rD2gi9/aiS2MZiIo7z4fbZ+uND1fbps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766699; c=relaxed/simple;
	bh=MXdYkoJOWU7nHQn0EZ6AYJo6j4YPL0512kkd9ogUwIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E758JKZqelr+l5p1pQkatMgE/+j+EQTQ+B9zJP0eq4GIjuovyMF00EYDp2myZmL3uQ86+KbXwX1RG7P0l/fPRl6A8b/K0RbLRpZpI9hvlNxspyMm1c0MHl/RPw2+B2dCSuB+59cAncK/7KE4oN+F4yaSJ+4Fxc6hxwlVOxEmjl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJMBTMA8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJMBTMA8"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e58034d05so3407415a91.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766697; x=1786371497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LDSgzdM6Me9LLVj79/WXjjcDnuicd8z67Cux6+E8JMA=;
        b=GJMBTMA8X+gqZB1NPVsAO2/G1KZI/g4AqbS2hEUUx1+bRI9+1Vnycai7uxCDVIgcj8
         4X6tb8IBbXgk0j4C9mtES6LzrA9NaUWJjRRl74xiNVkCxYVc1Lfa0k67UvPR47NG/f/5
         uGsAPGh28Mz5jwasnTVO5132Sq1LDKP2zgRRBJZu+o8xZIj+p4d/9u/oazjvtKj+xUKI
         Igh+/8y1gygARYYss1TRAwNiqZE9mw+JvmPKdVrfAhPa6D4iagTJZZHXGWEXwQJ5Ql+P
         TqKdeaxVFh8LDRpRUMkQj1ym7J2lriXmNlGugN2M80sOsXEYWJ8abA/Hf1AHwDR0FGj5
         2f4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766697; x=1786371497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LDSgzdM6Me9LLVj79/WXjjcDnuicd8z67Cux6+E8JMA=;
        b=nHTcZWm9uipsWvis8i6NIyniTI+JRtftmfNjoEOhSEvULO+jKoH9qC5+GssVP5cXj2
         eXinvpyeMYoBJQMkJs2OISeeb2CBT9zttN8Ua24VQK/nJDOi8aLwm3Cv2OBK05LiO7ch
         nAAYXU9We6Hw7fSrdP6LHQa7eR7TYhoZO4GyHBeJPdGfx5Va+ocBMmy86QY1NKUAHQLQ
         l3gKG8SMrQgva9d9H+KnH6t9kNYNGSOsPwLwHu50MrsuhWKxmoYcRR8B8Gnm2eOItxdr
         UFDyrLYU01TRtksD7Qf0oEOL1sNqzDm6tRyN22vKL8m8QLIHxU1i9UHwriy0++56Y7ge
         Ue7g==
X-Forwarded-Encrypted: i=1; AHgh+RoX9Zc6oImz2Zv2ZLD7ISq7TcYGZ+P7BiTFtRz9c5p3wu5V8gw02/ie+ApmbsUgvr+EWztgiUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJJd6c8KEpyzu2CBSuckv4je9kgVodxo8w8X4MT1SdIfI4fu2Y
	rBRO0gNFEHM9FMAVQsVmbo6l88dW63Kll3DwmlL5i7+nTyWw9SaYGSnz
X-Gm-Gg: AR+sD11xoNWIa46AfjZviW7DizA4CJkzCpCVDvr8rn12GWdEKjMOhmp3QK/2qLx40sQ
	6G6LHNk2cFxTsuLJOsHLh4kAAowHovb1KNR5w+EyGM129DBx0uvO6X8E7cTY79zyTHusiFURQV8
	JBSGMm3+zB86nSPOwlSy2ArHBg6v1oIfOkDMw9GnwVoSTcEpiGaKyVK+l1hIZ1vBTzQLCPTIB4c
	/0mNyz44ANbhgVeicYbcS7o+9tqDIycQd28hCzEZHZ1+pBo6nc+EdEQx0i0YUJOIG8hD7eE7Z83
	Y0U0XykH2SetF0MRlRttgmlkTPj3OBH0yllrVj3rQHd6UuYyh59IVZp2Oxd/q+nv0PoNCuJsibW
	j82yNo4CbYxLyiIN6sh1XtKxtif+8yZG4yidUazatmPPC5odGIVCkyxvT1g3auEvFH50zYsxRD0
	X8pj+rVPt99berbOQgl9GXANTpaoSMG0klc5mf1U1vT36UqHvwmsSDaNQWaZkOYmihwHtBDm0Fv
	wkRneggPuLecbAd3r+z
X-Received: by 2002:a17:90a:d004:b0:380:873:49cb with SMTP id 98e67ed59e1d1-38fbc4d615emr9615843a91.21.1785766696772;
        Mon, 03 Aug 2026 07:18:16 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:18:16 -0700 (PDT)
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
Subject: [PATCH 11/32] clk: mediatek: Add auto-population of sub-devices support in simple probe
Date: Mon,  3 Aug 2026 23:16:38 +0900
Message-ID: <20260803141659.559129-12-akkun11.open@gmail.com>
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

MediaTek audio clock drivers call devm_of_platform_populate() after
mtk_clk_simple_probe(). Extend __mtk_clk_simple_probe() to run
devm_of_platform_populate() when the new 'populate_children' flag is
set, reducing boilerplate.

Note that explicit of_platform_depopulate() calls in remove functions
are unnecessary because devm_of_platform_populate() is managed by
devres and cleans up automatically.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mtk.c | 7 +++++++
 drivers/clk/mediatek/clk-mtk.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index c3369a04cdec..71d70b5a9990 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -609,6 +610,12 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 	if (mcd->need_runtime_pm)
 		pm_runtime_put(&pdev->dev);
 
+	if (mcd->populate_children) {
+		r = devm_of_platform_populate(&pdev->dev);
+		if (r)
+			goto unregister_clks;
+	}
+
 	return r;
 
 unregister_clks:
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index b6504b3e77ed..11939e3e0b38 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -265,6 +265,7 @@ struct mtk_clk_desc {
 	unsigned int mfg_clk_idx;
 
 	bool need_runtime_pm;
+	bool populate_children;
 };
 
 int mtk_clk_pdev_probe(struct platform_device *pdev);
-- 
2.55.0

