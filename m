Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE284192FC
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766685; cv=none; b=tkQaZAjK/ZzFKTR2VDi4DlYRJFmkW+8D0eg5iml3sBPbfBNzeABai0ho5ok/DmcHzPKOZt4+2Pf8eIhnteyLECuXcG4kmNn2dU6NV5FYru3M9VO9lIpIM5SVyBIkJg4UsRYc4m14cGqrZkAPSbiif9gB/YEmFkPcOz6KyjrJbP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766685; c=relaxed/simple;
	bh=7h3J0KJRIBj4TZbgkPIpnUg4BNLSixuEuLBm1vCS7vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3zkibeNENOD2p6Rh4s75mF5vu6Wc1nV4uPkGiRrErOq3Ggem5FPNLWckxIDP+M/WqnfhB5j46kH9gEafVZwg7ojySRr47NhPrPvwD3XhUvZ23MRJXSmzNCZtZLAuuiZZoUfEw54+iRhFnDc2XCFWDbiGd2U/CffioUbFdlf+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agPAT+9t; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agPAT+9t"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so3187889a91.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766683; x=1786371483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zWFicEK01U6Ib303mAzU47Nrzec6N90vhxPL4yip0pg=;
        b=agPAT+9tuwf4Jn1YfhRPz0IaKYkRrpLW6lMB4HultJlcY9CMMpRoS60fiEmy52qjNp
         RIgf5Q+ZaPq4NfuWzTB5HPp70KfpBf32yfhIoq6G5j06D2inq/mrzVrET+MA30nTPtoH
         6yArbHkcGUsLadjlheyauyBM9LAjLpFltAU5NeISXPB85IfuPl2jvq4fj+f1kP9DuGFX
         H/KcaWICtna1ySz/pPf7L2O5mp3Zl80maHp+HC9i0fZIe4PYx0j5/wMOYPpLpg3iK5qs
         7OxxoAMILq0IUdZcWGBVxd92yg3n9hJDIQ37Bzxkyjp8eleogP0u9ZRK5QCCVaRbBoGx
         BMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766683; x=1786371483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zWFicEK01U6Ib303mAzU47Nrzec6N90vhxPL4yip0pg=;
        b=knMXV7PNVoH1rb9A+yVoXN+wy+kUfuF4/i0Iou77NnV/iAOMOLbef4oWBE/41o5C5l
         tcUAxFMUs3gCpDGxcFKMGfhN2DlWQDjPbU093NxCRh9h1SRplajtBhqCmf6/reh7AGh8
         mUg5KvZPrhKs+qnE49ttmDBu6gp+rgT0lG2bGzdDO4upyGpXMhcTTIC3oRHF2Hwi1bwt
         3LEjdkNiTecxhpxtj4MuAUjIX3urcOYcIFUutbe1QsrAX2ivsuOFgaiY4t66eSNSnK3v
         nh4uDR+6QJoWVglbtdz6nRSqUVD+4rPJXD4HNqydde97DXBFK5IfSG61JsuieGun2tpo
         kBKw==
X-Forwarded-Encrypted: i=1; AHgh+Rr457oYUSGnD9MQ+6rusBS9Cx68SSrultrKJL1XH9XTiJDlshqU7zhHlvAb4xUY2st5BPk5kcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiFNr/LZSj1Gh6frPB0L+05mOr5GT9wSgkLEZqa6zT1zn81jRS
	V+ZbDD/1qZibOyLEkY6b9yzAPzMCV2pMfa/eGHmV/M6g5FX04Yf+PL9j
X-Gm-Gg: AR+sD13aiQo2dRWpfRfgdJ4DYNgulwcW0FoiN2yOj9HJFRXBnj/DNdU7fiEdzUbIIOU
	3NSXBz4vMmco81aE5IeDsutroF+u6lTZYUNvEhyCdTuWLIyA0qlH82jAVMnvmij0g5Ffx3IHNac
	imU/toUo47y5L5OxNZ1dOWThE528RI7pvB0LOajocCef8Ild36VDCOAkxRiLB1izIOBwHpvC7Ok
	HVOe6mySDlHaFgmplGEgnxamV6X0eHA/8+Q2HSeL+QM/ZLtgS4NJmzmOGJEljhzE3dyPho2+GhO
	XGD5+L+V5rwlS/L3xYCP6ZaOirN/W8gdEEfLqtDffkfWyleomD0oAwnJKCqyR5pM7ld4VrKQ8sC
	bSs/ut6aGkV96zDonJUXMM+zKStKZ7gWcFk1wAcvyHk0juhlUR0pk4x36MDPxu2Alv4hBaSft7n
	5bCVzYws/yVEN4M1sAmNCYT26ig0OEd4qxcUsCEMmxHLolDktrbJuUjw08hrGII1WQcFZz5GNZu
	yQ/LOthERfGFb5hIecT
X-Received: by 2002:a17:90a:d445:b0:38e:6a30:4bbc with SMTP id 98e67ed59e1d1-38fbc53109fmr9002290a91.21.1785766683087;
        Mon, 03 Aug 2026 07:18:03 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:18:02 -0700 (PDT)
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
Subject: [PATCH 08/32] clk: mediatek: mt7988-apmixed: Add missing MODULE_DEVICE_TABLE()
Date: Mon,  3 Aug 2026 23:16:35 +0900
Message-ID: <20260803141659.559129-9-akkun11.open@gmail.com>
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

Add MODULE_DEVICE_TABLE() to the MT7988 apmixedsys clock driver to
export the Device Tree matching tables.
This is required so that the clock drivers can be automatically loaded
when built as modules.

Fixes: 4b4719437d85 ("clk: mediatek: add drivers for MT7988 SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt7988-apmixed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/clk-mt7988-apmixed.c b/drivers/clk/mediatek/clk-mt7988-apmixed.c
index 416a4b88d100..24f4e7b87a31 100644
--- a/drivers/clk/mediatek/clk-mt7988-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7988-apmixed.c
@@ -75,6 +75,7 @@ static const struct of_device_id of_match_clk_mt7988_apmixed[] = {
 	{ .compatible = "mediatek,mt7988-apmixedsys" },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, of_match_clk_mt7988_apmixed);
 
 static int clk_mt7988_apmixed_probe(struct platform_device *pdev)
 {
-- 
2.55.0

