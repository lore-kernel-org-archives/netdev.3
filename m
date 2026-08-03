Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A52C30D3FE
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766648; cv=none; b=s/+cK6WKpcYCGpho5Rva/9r7fK/DupwK39+OBpt9MifulFjFr1t88NBhBTE5xzrh0YIoH4y8qOrZKrBrrrRX/saOyJKR/ebXjEkaoAxoHjuFTiyuUpC9V2PFhtOzY1vsHOflulKdfRVxYNzanFeu0vlkimpKSkw9Qq2ukNrZhos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766648; c=relaxed/simple;
	bh=jqo/DmrD6EhhgwisLEA9Ghjd1hqGCYrsHk5HTzUy0/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IRi43S8Ty3POUkdDsOab5jiIUAhUjVeQmKaBeOJ+FWRV/iA0jRPmcu+u573lYSUW5Ch3VjKj/3x9/nomrgtpt9D6xkP1Himm8W9QnsFRnipz5IEO81G4kANygtAnT+y1mWhV5KzyT22hZihKvggKmFzADxVP7HAIFBS3I5vnBl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfH3NYTw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfH3NYTw"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf452def93so31437145ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766647; x=1786371447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wwjgtRb3Tj4kbI2i//w6Ka0+luCbAxG+sRZKCn0g9Uw=;
        b=QfH3NYTwZtAUFucVtvsLPPOO00i9UAg712D1L2iCwFTqrbAwXB6r9OcBA+tAsLZ+5f
         xXEN1vgg9PCMG5r4KFB3Xudr8OKlqvXDzmTSC9niwWU6jnm7elsnDCgyxxBN3x4SV5B0
         X1PL7gqDZlafGZc0jW+fHG7Md8hmPZWc4zn0tuQ0TN2NhpBQayu4HgOrFtZGm1xkOLkF
         R+mnhpx9eIkWUoOZzv6lMrmJimv6bO8VzxuBybWpHMoOFQorItcFUE62c0vXF/wezDUE
         yEQJ+EPIwxGmkN3AYhU196SaIwZpAeVovGcp3nayTH1EwcQHLPFCIfCMFaQbngd85nHR
         Wu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766647; x=1786371447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wwjgtRb3Tj4kbI2i//w6Ka0+luCbAxG+sRZKCn0g9Uw=;
        b=pte1M1esoqPKkSk3W8JZkDHgYzIbs+DwLVwVnLOO3JExARkXBHuBHiD92Q9e3PlV1Z
         xyPtp9FhPqEmXdf5s1i6brN9qFOUC0WDy1Kf58NQ5fk17y/zfKUXnb6dn56CCdB5V4mr
         omjPHgpCVoik4xc2uCwZeCzN33aQXOS+kXYoLMqSLjIuXXgHAH6PdXvQWSgAREJJ8GRi
         pqAUlsSOnoKsHCN27QHSGKl7hDcOkkujNsYCPQ0n3t0lt4D2n3I6gBxdpbGcxqddv9DN
         9WrA9qfjXZXufOocWTpAuP5p0X0ouZnJA7JR2TJCiHE+cJDn2/5KueCvn4JoYPE4NoM9
         wQXg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/QyqCLO9EKWgWupI413ClvK2UPmWeTg1JGTWP5J3DEhjZ60XvtTiNNv91aFO+llxPkcAP3BY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd/Jjn6VuPAOM6/JEBsQ5vIkyxYXiE2ri/zVPj4a2bliMrL3ia
	7LEeAGuyFvhH+qQKwjDZR0eb9FDFf4wMr71l1Q72sHWyzHaON2Tspfn/
X-Gm-Gg: AR+sD11Z7T6Z+8SZ1He2kVE0hi0b47pPSUWpuvsR/fd+r9p0rhuxjO39Ym2qCa0VH2G
	GKETUTWWoA/ZOWDhKpeFDYpW0oprAjVJmbl0t05VOmLSjkTQcYQ4bZa9Ku3wG9Tbl3VhsfYYo2u
	kryNqL2BUeUpA8LkbulahpCtZLYRQ+zJiTY0cyenpXau0FYYx5yHKQ1RscT0udlVY5E5ImJ3mo9
	Va6QNum270NwrssnS4h21ii7JJwF+0MXTRLdbYmA1U+lrChYQPOSaBWwkYj61ibmdA3go74vKhH
	M03zry5BqWOyg0RQCjPYkZ9YnB5d1R9InW24c88o8iI3wZDCBvibjlWjlZO8c3U+3NgZa5VPlRg
	GFPDszHHi0Ztom9cfZ7Zu1gAkaYgD79i/56w8MpHDTBXcnpZsv6jyeq6HR2ufefQXIh22AXBVlO
	riL6SGFLGJqsItzjJ9S/NTc4PcTI4/91Arm7xsiAZtst6YyNeOeDuI4uKCutNFXQAFx0yltSQ9T
	0E4KpLAuBel3r0x5bSy
X-Received: by 2002:a17:90b:57ed:b0:385:3ab:fecb with SMTP id 98e67ed59e1d1-38fbc9f3ebemr7249914a91.4.1785766646430;
        Mon, 03 Aug 2026 07:17:26 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:17:26 -0700 (PDT)
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
Subject: [PATCH 00/32] clk: mediatek: Migrate to common probe/remove helpers and fix memory leaks
Date: Mon,  3 Aug 2026 23:16:27 +0900
Message-ID: <20260803141659.559129-1-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series migrates most MediaTek clock drivers to the common
probe/remove helpers provided by the MTK clock framework.

Key changes:
- Fix memory leaks on module removal caused by missing
  platform_set_drvdata() calls (patches 1-6).
- Add missing MODULE_DEVICE_TABLE() (patches 7, 8).
- Add missing support for cpumux, PLL, pllfh, and sub-device
  auto-population to the common helpers (patches 9-12).
- Convert all compatible clock drivers to use struct mtk_clk_desc
  and mtk_clk_simple_probe/remove (patches 13-32).

The memory leak and MODULE_DEVICE_TABLE() fixes are split from the
migration patches to allow backporting to stable.

Drivers not converted:
- MT6765 apmixedsys: requires direct register init.
- MT6795 apmixedsys: uses mtk_clk_register_ref2usb_tx().
- MT7629 eth/sgmiisys: uses a hacked probe sequence (multi-instance
  sgmii gates).
- MT8173 apmixedsys: uses mtk_clk_register_ref2usb_tx() and custom
  divider registration.
- MT8188/MT8195 topckgen: call devm_clk_hw_register_mux() and register
  a notifier.
- MT8196 vlpckgen: requires direct register init.
- MT8365 apmixedsys: uses devm_clk_hw_register_gate().

Patches 1-6 are based on
"[PATCH v2 0/6] clk: mediatek: fix memory leak on module removal"
(In addition fixed a compilation error in mt8173-infracfg)
https://lore.kernel.org/linux-mediatek/20260707074839.240676-1-akkun11.open@gmail.com/

Patch 9 is based on
"[PATCH 1/3] clk: mediatek: clk-mtk: Add cpumux support to common probe/remove helpers"
https://lore.kernel.org/lkml/20260304181024.738391-1-akkun11.open@gmail.com/

Akari Tsuyukusa (32):
  clk: mediatek: mt2712: fix memory leak on module removal
  clk: mediatek: mt6795: fix memory leak on module removal
  clk: mediatek: mt7622: fix memory leak on module removal
  clk: mediatek: mt8135: fix memory leak on module removal
  clk: mediatek: mt8173: fix memory leak on module removal
  clk: mediatek: mt8192: fix memory leak on module removal
  clk: mediatek: mt6735: Add missing MODULE_DEVICE_TABLE()
  clk: mediatek: mt7988-apmixed: Add missing MODULE_DEVICE_TABLE()
  clk: mediatek: Add cpumux support to common probe/remove helpers
  clk: mediatek: Add PLL support to common probe/remove helpers
  clk: mediatek: Add auto-population of sub-devices support in simple
    probe
  clk: mediatek: Add pllfh support to common probe/remove helpers
  clk: mediatek: mt2701: Switch to common probe/remove helpers
  clk: mediatek: mt2712-apmixedsys: Switch to common probe/remove
    helpers
  clk: mediatek: mt6735-apmixedsys: Switch to common probe/remove
    helpers
  clk: mediatek: mt6779: Switch to common probe/remove helpers
  clk: mediatek: mt6795: Switch to common probe/remove helpers
  clk: mediatek: mt6797: Switch to common probe/remove helpers
  clk: mediatek: mt7622: Switch to common probe/remove helpers
  clk: mediatek: mt7981-apmixed: Switch to common probe/remove helpers
  clk: mediatek: mt7986-apmixed: Switch to common probe/remove helpers
  clk: mediatek: mt7988-apmixed: Switch to common probe/remove helpers
  clk: mediatek: mt8135-apmixedsys: Switch to common probe/remove
    helpers
  clk: mediatek: mt8167-apmixedsys: Switch to common probe/remove
    helpers
  clk: mediatek: mt8173-infracfg: Switch to common probe/remove helpers
  clk: mediatek: mt8183: Switch to common probe/remove helpers
  clk: mediatek: mt8186-apmixedsys: Switch to common probe/remove
    helpers
  clk: mediatek: mt8188-apmixedsys: Switch to common probe/remove
    helpers
  clk: mediatek: mt8192: Switch to common probe/remove helpers
  clk: mediatek: mt8195: Switch to common probe/remove helpers
  clk: mediatek: mt8196: Switch to common probe/remove helpers
  clk: mediatek: mt8516-apmixedsys: Switch to common probe/remove
    helpers

 drivers/clk/mediatek/Kconfig                 |  34 +--
 drivers/clk/mediatek/clk-mt2701-aud.c        |  35 +--
 drivers/clk/mediatek/clk-mt2701.c            | 233 +++++--------------
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c |  48 +---
 drivers/clk/mediatek/clk-mt6735-apmixedsys.c |  48 +---
 drivers/clk/mediatek/clk-mt6735-imgsys.c     |   1 +
 drivers/clk/mediatek/clk-mt6735-mfgcfg.c     |   1 +
 drivers/clk/mediatek/clk-mt6735-vdecsys.c    |   1 +
 drivers/clk/mediatek/clk-mt6735-vencsys.c    |   1 +
 drivers/clk/mediatek/clk-mt6779.c            | 124 ++--------
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c |   2 +
 drivers/clk/mediatek/clk-mt6795-infracfg.c   |  70 +-----
 drivers/clk/mediatek/clk-mt6795-pericfg.c    |  71 +-----
 drivers/clk/mediatek/clk-mt6797.c            | 140 ++---------
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c |  60 +----
 drivers/clk/mediatek/clk-mt7622-aud.c        |  35 +--
 drivers/clk/mediatek/clk-mt7622-infracfg.c   |  70 +-----
 drivers/clk/mediatek/clk-mt7981-apmixed.c    |  37 +--
 drivers/clk/mediatek/clk-mt7986-apmixed.c    |  37 +--
 drivers/clk/mediatek/clk-mt7988-apmixed.c    |  40 +---
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c |  48 +---
 drivers/clk/mediatek/clk-mt8167-apmixedsys.c |  50 +---
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c |   2 +
 drivers/clk/mediatek/clk-mt8173-infracfg.c   |  98 ++------
 drivers/clk/mediatek/clk-mt8183-apmixedsys.c |  51 +---
 drivers/clk/mediatek/clk-mt8183-audio.c      |  26 +--
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c |  59 +----
 drivers/clk/mediatek/clk-mt8188-apmixedsys.c |  60 +----
 drivers/clk/mediatek/clk-mt8192-apmixedsys.c |  67 ++----
 drivers/clk/mediatek/clk-mt8192-aud.c        |  26 +--
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c |  67 +-----
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c |  49 +---
 drivers/clk/mediatek/clk-mt8196-apmixedsys.c |  67 +-----
 drivers/clk/mediatek/clk-mt8196-mcu.c        |  96 +++-----
 drivers/clk/mediatek/clk-mt8196-mfg.c        |  84 ++-----
 drivers/clk/mediatek/clk-mt8516-apmixedsys.c |  42 +---
 drivers/clk/mediatek/clk-mtk.c               |  76 +++++-
 drivers/clk/mediatek/clk-mtk.h               |  12 +
 38 files changed, 472 insertions(+), 1596 deletions(-)

-- 
2.55.0

