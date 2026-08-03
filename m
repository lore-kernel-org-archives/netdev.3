Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A8C40F75D
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766662; cv=none; b=GRMe9mXDEkny2g/TtCDLb4cIsyFtMyyUbynrjkSaqn5rDkuhd6/1+/8PXnMWO8BJHt4+wvFVxC+tgq6hneKm49PbxFRYfdvaqqebywSZTZ0/wAa6ZUzMDqOGVkq3/VxQt8MIuotQTmIQyvwBNEIE3cx4qNKwnYOe6LGaaOA27b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766662; c=relaxed/simple;
	bh=J3vrVWoQoo9SDz7Fu3bUlFwKeGghiPaMM54JY4Dk4aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3LvZHiYnfPOWMVMl/rsDoRB2f1xbfp5jUsHZXHDh7P6qfaSALNOd0IpBimlhXiL+GxZlA+Faz232o/GtHq+LzX+9nez6IbhfrUaUhftSnHF9ku6wGzIXl1CKfjGCeUhkteRRjFQoYHPemDvBehvtNs/yMiCELGgX+tkno9mrZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rAGQs+em; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAGQs+em"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38511175ad3so2285363a91.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766660; x=1786371460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EQTegJW8Vwp7QjW3gCxx6DQBByocZqrqYYXa3MGI9cg=;
        b=rAGQs+em83p6rtehKwfH3GNyiBRVLVTpezTVT6oGWud3x1dQTM42uj0shafNr3cHNX
         VraHzXeVroxeTY+J4QctFngWoGJL2qkHhNsIy7osIXAU+yX8kAJdQPHyT+T9pVZ2H9iy
         ex+aadc/8kmf9Rlf3NDFWCBcM9IEklwJF39BObM4u4GcZbYwIVsTyTaLNUH8TPwyG2EO
         EjuPL3GuB8zhmHwK48D0p4+f/gqe2cq8NJaZo7Uq2WNCNq9LYJ0dSFUiu6EDGPB8IZI3
         WqRHE01SZkuHdjfVbzf+k48LbNF+5eNRMAn6Hf2Pl1+dvsE9vEPx7H5ELwvSO3i2q4MG
         /sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766660; x=1786371460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EQTegJW8Vwp7QjW3gCxx6DQBByocZqrqYYXa3MGI9cg=;
        b=gnSAzHCjphRvucQ/xQqPlAAgYnGiOyLzkzEHnL1+FrwZ5tZfwDLtbgN7OfpOctkYhC
         KFT/2BCVsRxUshj66n8XX1UOYCY6rY/0YPT0RTBDx45qX1fa6obEpD1JZt4f1wfFn9JK
         P6VICqZXCmCy1FVELQdCBp0gL4eDsyH49lbWsgH5becPrdR/YRmSdvIbQYLyEdHLHT+l
         l9ng/3x1Skod/rOQS1Vzuui/FZDw3VnM1KK6xKiimn0CURu9fJaUNqM3yAb71ZMeLCce
         vZw5HI8UfPRJg4fYcLHxoZc39E7qqrj6q/ZuHG1a4eN1dHmkNWh2m4sbJxJdZf4t/sZh
         qRog==
X-Forwarded-Encrypted: i=1; AHgh+RqmApZSGGP+GtIVfIsSSE8vdrvnMpcOSdbLTp7cTWgPzzVU++da+oS2cZdMqmgeYYLIoITIoBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGgQWZHLMcZTIC18KVTc7IjlK4Uf3mYNxwYV9SXBL9sIg5sjyU
	XAtGcj7i5e737F1JaTgeWDBPB5JD76aagR09ApSHmMQZ+K06Sa3jt06caOZuc7+h
X-Gm-Gg: AR+sD11wQeklj2FfgcDU9+uFUDWsz++FB9yOQElTqyiUQyPHcGGVZijwxKUMKv23WH3
	YI6ll/V6JEQP69qdnOmbOBHPS7pi2CQWkr+4HFfYUhfFYA0welM2c6zeAbrljNXQO5PRpiWIAev
	boIK/FEaoaIvyNJ1JoLZMYSaT/3IbBfKLd76tMrgoXC5IOYeOoBJMANdZcxZf8JueqkraqMESOz
	qfVzQ9DHfSi5NE5JpiXuoGkq2rFoSe/VtlHSe0x8sly6r8mmbv41115WVfWGCnX4NlQthbGi/eH
	xvpBTK21olE+GWw1d9svN3i4Wtev/8bVUkGwVeZ6PJVFBoS1em68rNahioD1900uUEOH/gRN5Gc
	vjGHRbzdG7KBEsPHisYXigxHXMLUf/psV8XgE0Gsm3x1z4/oxFzbwftkVRNDBSo0M4ruVYGZF9K
	9/Yc6xiQf1X6yF4ZhJ/O3e4vg2nwOH/d7DGrIdhx2qWkD0Y0Cfy9CKSL2qmOFf8566XfvTs3Jqr
	Bf73IyEYVfxcyHkPJGN
X-Received: by 2002:a17:90b:51c3:b0:38e:4114:d8c7 with SMTP id 98e67ed59e1d1-38fbc0b4881mr9861203a91.0.1785766660245;
        Mon, 03 Aug 2026 07:17:40 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:17:39 -0700 (PDT)
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
Subject: [PATCH 03/32] clk: mediatek: mt7622: fix memory leak on module removal
Date: Mon,  3 Aug 2026 23:16:30 +0900
Message-ID: <20260803141659.559129-4-akkun11.open@gmail.com>
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

clk-mt7622-apmixedsys.c and clk-mt7622-infracfg.c do not call
platform_set_drvdata() during their driver probe callback,
but their remove callback calls platform_get_drvdata().
This results in platform_get_drvdata() returning NULL,
which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Fixes: c50e2ea6507b ("clk: mediatek: mt7622-apmixedsys: Add .remove() callback for module build")
Fixes: 838b86331c5e ("clk: mediatek: mt7622: Move infracfg to clk-mt7622-infracfg.c")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt7622-infracfg.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
index 8a29eaab0cfc..fae8abda14b3 100644
--- a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
@@ -109,6 +109,8 @@ static int clk_mt7622_apmixed_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_gates;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_gates:
diff --git a/drivers/clk/mediatek/clk-mt7622-infracfg.c b/drivers/clk/mediatek/clk-mt7622-infracfg.c
index cfdf3b07c3e0..cec19447d637 100644
--- a/drivers/clk/mediatek/clk-mt7622-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7622-infracfg.c
@@ -90,6 +90,8 @@ static int clk_mt7622_infracfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_cpumuxes;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_cpumuxes:
-- 
2.55.0

