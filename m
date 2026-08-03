Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1DE40B11C
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766657; cv=none; b=VXuxXv9T0kPaP0dxPTX2TkJfWfjvK6NmSaEAXml7CZRZE6OFMMVR/d/tYqIc8ueAhLLVSqXkhHgl8YeAd83Ni8Z0TeJRbpYQ0cB2CdWHApHJjMbZj+HgffIonLvGYOrbe2jOMu7kAjzWSIIzESNDD/Zo6BDgXTWhgzxiU1VTgIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766657; c=relaxed/simple;
	bh=jXMNEPGSmgzb4Ni0tFwqVaC5hDYyBsmFzVyIZbl8eok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSFnbuhjHcMzraC/+Yprm8pEqVdSOdBjA0xdsnNCjTesjzqF9bRzcWCvD3clToTb7WFtTB70xqClJA+HV+Yh6znBztEKwxNE0IIyAjpx1cn5YVItqW961ykt0BFVONbGwpf/azxZ2Ly1w5hld0MC+1OFHj/LxP+jygL6XFgz4Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrEGY7NH; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrEGY7NH"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381b831d535so3843722a91.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766656; x=1786371456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YIV+HU50AEtRbtVbE/kWRl5gYNOX4lr3tpB0iIeyarg=;
        b=LrEGY7NHH8ULc+ge2eBS13hi56QQRdd/tb+/Z6J++ZCphX5LcEnmEC6zlygG4F7v5I
         8Gsj3rkPOaXrdWt710nYv8yzfMcqQ17zQgmjix10HOPNRcYVZDlwniYGTWtZqH48D76O
         utxhy11jJo1Xlrf3UKIPgXtULASeI1er9So6bfFk+ovguHBHQU3CADigYdSqquMNJJlF
         VU11fBHTmcfKOJ2F3s+0oozGHGGVzqf2Gtpo2LnbyhUlx19zMK7rGruEIfVatp7kBRFg
         UcMZAC8dZyU3jgMTrq9XatJTZ84jrfRNfeF54mPFsGpUJWEuj3CJwyFzU9qRLCs722hz
         aKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766656; x=1786371456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YIV+HU50AEtRbtVbE/kWRl5gYNOX4lr3tpB0iIeyarg=;
        b=oWbRsyWc88SXuIx7Q/n3wcBGa5q6c3IPrTV06zsDbZN0wHVAL/UTZLTjZGQ0R5yayb
         J9SCU7sgCMw0u8wL7Olkkp7Qyg79jXJafT2V0v4brqCjlnBGuc10juc4Oul0WgBxzz39
         K71z4JY6yJ0GiQeJ9Lvof6iPkiMk2qXHOdIzvGOQoKVhycntSsY5zURimtJ0fao+gw0a
         xUlAlqYs+5MLvIrBxTHq2HPkXmGDmtv9SDeudToFjqsjFd/H+X8+3NKr4w/I11NByL9P
         B6fsYCdygtD8wu3E9v46pjrRG79WSMaTc64yPEyxfKNtqK6HP48m5vJmlsVJ4SSKicAt
         DS6g==
X-Forwarded-Encrypted: i=1; AHgh+RoqtpQGTnGgYkF8PHHPZLHAtKVk2vTHtSGBOF+DhqKHkcHjmStdXkj8sR+MHZfYjhjvrHCVRl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4mCgoIT1bohxbLIbtyI6AAFti61sfr77XZA5SPVTe3mqtBHR6
	6R4JMc0rftgxPt4Nxlue8n5As0E/6wjXyfwupr/Qv53K0Cqasy3btvLR
X-Gm-Gg: AR+sD114S+C08OS79yCL86UoYz9uHMtl5/QjbStvIqUs5vB1L25StcQQfEEm4RRcSLH
	UUjQuuqATX/Fi+Ws7wJT4OcatyMvmHv4PsduF1xv1ZjLABKQY4TXH9YpndOS1cc4OGAZDN2coDR
	xuSYpYt1VfHRXQKGl+32JL8KRZtR3QOhhbovRwMTHsi/VRIA1aemzP5p0wU1So5VTfedTHkyU8r
	qcrwUOs/ic0sDNzYsWQHseLwpuTU93ztqG0k6XuRFriQ0lzaJZ31P5CYEvVQ0kRmYaTkS9TVPrO
	0/iez/XXxyCeeLehAzxkPQFg7lA3wUTYXX9zKf023Z0uND3pHrA330jAzjAuQt91AvT98WCn0gC
	5b2gxloB2fPf5lvzz8hUJG6K5ZEetn0M2gC42uuweJ2zj6ME1y14RK7GXdElwj608tx1fhw8EId
	bWoaJ7sXSiPStLSeViaUPLrpNrZylq+onY3zCn2FkZyVxSDSr5+eJGxMH4VkXnsAE0uwzSS19v8
	T6b4aj8dRqbSEzY5xCA
X-Received: by 2002:a17:90b:5690:b0:38d:a8be:a597 with SMTP id 98e67ed59e1d1-38fbc56732bmr9286831a91.37.1785766655662;
        Mon, 03 Aug 2026 07:17:35 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:17:35 -0700 (PDT)
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
Subject: [PATCH 02/32] clk: mediatek: mt6795: fix memory leak on module removal
Date: Mon,  3 Aug 2026 23:16:29 +0900
Message-ID: <20260803141659.559129-3-akkun11.open@gmail.com>
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

clk-mt6795-apmixedsys.c, clk-mt6795-infracfg.c and clk-mt6795-pericfg.c
do not call platform_set_drvdata() during their driver probe callback,
but their remove callback calls platform_get_drvdata().
This results in platform_get_drvdata() returning NULL, which leads to
calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Fixes: 0d363282bb0c ("clk: mediatek: Add MediaTek Helio X10 MT6795 clock drivers")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt6795-infracfg.c   | 2 ++
 drivers/clk/mediatek/clk-mt6795-pericfg.c    | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
index 123d5d7fea85..239a3f5e1760 100644
--- a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
@@ -175,6 +175,8 @@ static int clk_mt6795_apmixed_probe(struct platform_device *pdev)
 	dev_dbg(dev, "Performing initial setup for MD1\n");
 	clk_mt6795_apmixed_setup_md1(base);
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_ref2usb:
diff --git a/drivers/clk/mediatek/clk-mt6795-infracfg.c b/drivers/clk/mediatek/clk-mt6795-infracfg.c
index e4559569f5b0..914bb069aa85 100644
--- a/drivers/clk/mediatek/clk-mt6795-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-infracfg.c
@@ -116,6 +116,8 @@ static int clk_mt6795_infracfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_cpumuxes;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_cpumuxes:
diff --git a/drivers/clk/mediatek/clk-mt6795-pericfg.c b/drivers/clk/mediatek/clk-mt6795-pericfg.c
index d48240eb2a67..27d0ef7d7b2f 100644
--- a/drivers/clk/mediatek/clk-mt6795-pericfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-pericfg.c
@@ -125,6 +125,8 @@ static int clk_mt6795_pericfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_composites;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_composites:
-- 
2.55.0

