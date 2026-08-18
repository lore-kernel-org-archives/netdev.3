Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C129A477286
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059661; cv=none; b=mK3yAPdQRKfeZlb52eNDbht1ljnUYVOHaQETNXeec9Ev8H6C7AED6K116tGj+2nRSTY6nc1PQkaPsTISg8hO1jc1+eZhJ+ia+0AwMrWU584zIr4wqgEl7B8Gl2Iz2LDTn/yjTiEFatyHRGgMZY1oPI7qI4hTJ/MAARij0SIe578=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059661; c=relaxed/simple;
	bh=Ydyy/Hj73xf7iU1OPDBxYLZO4MLEAqdL03I2QiMdhIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z/IiAF054Dj4W/felUhOnqa6b20fug9ZJrqOKuJamITv+LcLuMg7khfoENKCkL4Y1IrSCkkUzKzQfYryf7ByrLUPqsnanpFbulsV2gM488ox6h/SnT9GVdSLQTt8f3A/O3NKTwPKz6lq1iSJPgom00qcj8oYXpZQukEqMDCDIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q8dnRxGh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8dnRxGh"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so43458115e9.3
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787059658; x=1787664458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fRt75Cw0D3zOWFN+00SWJIuIxB+ErtT9mg4MKtDgEDI=;
        b=q8dnRxGhSVCd8883N3Nh/5unrrCiB7751H6n25PtF+JZDjB0eInESZswhPkECQoGAb
         KjSnFDHbcbtAGcF3wnwUEA+JMaCsyKsJifYXrXC3gWp+bkZakLQe9CTevyilqgnDHODW
         TKx7AxZb3N83/yGH8At/8what/YA6QTNPSEF9VO7r7j8OCYQJ8ZGsEU9eprRldPpXve8
         e0tMUEW3i3wCwEF/AH3q4XdfDxGQtU0SLWDV6ZFX8J+KUuCqQuPXcdtJ685xkZIDOA8t
         Yu1TdxNJY00EV4Q6qdvsTEaDS7G84KuKynO8Va8FXF5w7bp5Uo1VY5ZUTSVE5wphaH9r
         +z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787059658; x=1787664458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fRt75Cw0D3zOWFN+00SWJIuIxB+ErtT9mg4MKtDgEDI=;
        b=HwfrqNWWq6bCzYWCzhEtRokEVUiY50sE4/pnBThv1DmfgnMSBVl9L75bO5dsc23bpA
         CWn4JkveCH+3dclYMMXZo25TsHamD3fbAjt9X2DI8Hmp+/GQl+axyvbPolDyvUlKQm5J
         4y/WZNDt2jsDUPu72M08WxwIGe780utMBrkrgOqyj24iRABAHUGC9W5uyiy7u/06Q/eZ
         bUJ7jiZobXGe1h4pt8uNA8F4Y3VfMMleA5X6VLWqK6DBDX8hbXL9WwcaPW1/wCin6JeZ
         oj5TLjcaa6WGnT5k/O0KBnsN/7NnKyJSHuTkQd2VHDQXQta5tzLPNk7EeY3lJTeLfJFt
         welQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKqcjtSSlyOKr99PRq9v51/EXQa73SbJxXhBKGAHcZM/jJ7r6RUitIwHWueWtiMdwav60kYfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcG8P4LUfpIBpXc96orW1VgHdTp5gwppdosh/F+IXGsfoKADGO
	r8w/Qmj9D+bm8WPa216s1IaHPcvTbYZQna5m06iB99769UPETgW/7/A+
X-Gm-Gg: AR+sD13YYj/3PnYyER0UWbNnTzWSFk39Ich391qX6TfarmEvRLuougn7TnwgvDtyias
	8V2nCBvzddUbSfWxARC7yUOBJ/gWZ+n1LLWZaXLYX/mknP4wboyQK3KHZbW7UhyBVc1dLSf8VMh
	hNvNOQxgm/nU0+YjbV/7jZxa+OJABvYQT7HVMzGRbFSFoqxtrbjHm2aYfgbI3qTgpxvPjoEr5K9
	MzucuJp1D19cKNHG+rMiOTOwqa9/tLWfzygGmKpAmg5xMunXFr2AG9sDF/rG/RDLL5fXQND90lN
	LS/R4kcTEjuMWxhQoV2d9bLNPwxqLm7CT9O11PUYTFsa7YBSIM2GzY8Pz4n0wwRMQ4QldKUiIXb
	huiAJCu9vIF8fwy73zwAp+mpHCz6QDR2mNr863EYxwjDExociv6gzHMLyoBfXKVpfD3ORyRlF06
	AGrRIA0+52k0sfw58RE3APIq5AhMojx+xkg7pMHgk8VoaGxpYde8/Q9RRPXx0=
X-Received: by 2002:a05:600c:5286:b0:499:621a:2ec2 with SMTP id 5b1f17b1804b1-4998933fd79mr572811735e9.3.1787059657466;
        Tue, 18 Aug 2026 06:27:37 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7c568sm12140145f8f.18.2026.08.18.06.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 06:27:37 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	richardcochran@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	muhammad.nazim.amirul.nazle.asmade@altera.com,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net-next v3 0/2] net: stmmac: dwxgmac2: timestamp interrupt + Agilex5 fix
Date: Tue, 18 Aug 2026 21:27:20 +0800
Message-Id: <20260818132722.1852876-1-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds auxiliary snapshot (EXTTS) interrupt support to
DWXGMAC2/DWXLGMAC2 and fixes a regression it would introduce on the
Agilex5 cross-timestamp path.

Patch 1 wires up a dedicated DWXGMAC2 timestamp interrupt handler.
Before this change the XGMAC hwif entries used the generic stmmac_ptp
ops, whose timestamp_interrupt callback read the dwmac4 offset
GMAC_TIMESTAMP_STATUS (0xb20) instead of the XGMAC register at 0xd20,
and XGMAC_TSIE was never enabled, so auxiliary snapshot events were
never reported on XGMAC platforms.

Patch 1 also unmasks XGMAC_TSIE in XGMAC_INT_DEFAULT_EN.  That makes the
new handler run from hardirq on every XGMAC timestamp event, which races
with the Agilex5 smtg_crosststamp() poll loop: the handler clears TSIS
by reading XGMAC_TIMESTAMP_STATUS before the poll loop in process
context can observe it, so getcrosststamp() times out.  Patch 2 fixes
this by masking XGMAC_TSIE for the duration of the cross-timestamp so
the handler cannot steal TSIS while smtg_crosststamp() owns the
snapshot FIFO.

Patch 2 has been verified on Agilex5 hardware: with both patches
applied, smtg_crosststamp() no times out (no "Wait for time sync
operation timeout" in dmesg) and the PTP clock registers and operates
normally.

v1: https://lore.kernel.org/netdev/20260806-dwxgmac2-timestamp-irq-v1-1-c051c79c9d90@gmail.com/
v2: https://lore.kernel.org/netdev/20260810100221.9166-1-zxyan0222@gmail.com/
v3:
- Add patch 2 to mask XGMAC_TSIE during the Agilex5 cross-timestamp, so
  enabling XGMAC_TSIE in patch 1 does not break getcrosststamp() on
  Agilex5 XGMAC (reported by the netdev sashiko review, fixed approach
  discussed with Maxime).
- Patch 2 verified on Agilex5 by Nazim Amirul (Tested-by tag carried on
  patch 2).

Zxyan Zhu (2):
  net: stmmac: dwxgmac2: add XGMAC timestamp interrupt support
  net: stmmac: dwmac-socfpga: mask XGMAC_TSIE during cross-timestamp

 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 11 +++++
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 43 +++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  1 +
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 12 ++++++
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.h  |  1 +
 7 files changed, 71 insertions(+), 3 deletions(-)

--
2.34.1
