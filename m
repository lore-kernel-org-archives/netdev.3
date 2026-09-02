Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB373EC81B
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354912; cv=none; b=r73U8f6v14s8UfQvPDfpF9ArI7gtPDqPtR7TQf1OWCtWaHD6VDoNClrK6BS9S/W+cerge7BpN29nrBBL/NeJ8FzO4Uu0Au/N11Y77Cxo0YMnVwERxHaBZ2vSGCTijsTgmNKAhKu6muXF7zgtDXfzDAzyG0SIJFEc0Z5JpGryd5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354912; c=relaxed/simple;
	bh=/h8KHRAun/jLn6ihpqdnZw6r1LjfxVZG68liizvJoKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UEDVQKe+7jQmL0Vm/x/NgH2wboVjK9O2E91dv6OEB98zHfmD6KDOvFoR7XH4mvqdcDgiWIMBC3PPYitiII160wsGgcgMwVlJlhYeBeOf8tuEnQL5duBxsCzxhocGoS3g+pk9v/6bFHu7V+XU4/FQ5ihvNTm0ZfTC+abc4eTelhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgCU/bfg; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgCU/bfg"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso820586b3a.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788354911; x=1788959711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uzv/JmEo6dRoaDeN8R/MmzC/JFKPPs1P6QOp8MtYRWQ=;
        b=UgCU/bfgyaUH/yef9cmf2BmBIB0UQRXOiA7OUeGfTY/4HiVOrZfobtxowWi/GkgpJ0
         uqsebvgAidMwvCUp/l/u+TRj9OTymvAFy5GUTiHr8YC8lG9JCO/a/xa/aYBMzMPqbYMg
         O0BpzaC6nvTm+2EeJs/zsKur7GD7D07pyi3OhhpfEUvvgCLZoGeaY7yR3JzviG7s8fR7
         dJ3W1WJ9J2dUpobwBS3xeRxSouiH5PJ/g5ahsMLSKGEfJsppGSNVt9ENI+gD+f8lGgZY
         lAgvTIQxsJZoXpYPp7TRHyceK9qeYZeFbm478z3w0o1BbV/E/uta+asbbsBV2CMQfUHv
         Er0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788354911; x=1788959711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uzv/JmEo6dRoaDeN8R/MmzC/JFKPPs1P6QOp8MtYRWQ=;
        b=e/8Gm2YAwSDxltgqxXRbptbzmBknEQ4UyOcyUlnxQC1MP5xsPEdI3Zle62/6pGYEcH
         A4l08C93J33r4Ga5gTkdBEgghumjJiQKen4/LEXz5GyjEHLAuKEskC1z7G3uhuWBIKz1
         2AWvIso0DjRX7gHSAq+HaiqcWRu01PZqqBwFsJ1OOiGcOkgb44Mx/sf7mudT/pu6GJjq
         t/WhCnKt/ub+2QEkK82psFOzrv33zaLL6aBX3yXwMUhUeRZwKIez0C8dDwxVIrxnkmWL
         niKcbGq4FV51u/2aaJZa1FoSXln6RHtKYnhtHV3Rzy1ZkPiTCHu3HhyKN5TplHrNQv65
         Td3Q==
X-Forwarded-Encrypted: i=1; AKwUvBz8JhO7mfBgw2Qt76FB9lt6A3hqBiW6WlAt/l1KkHWjXLlBVQKhqVr/cNkkRHc9ZkZ2kGjE9AY=@vger.kernel.org
X-Gm-Message-State: AFuF++kHr7pJ+fNNT/lJXWftHjUC8/Ne+O/Jy5lTngMOmu/nDFG9Sg4W
	qcpNqhWsD7ZLrVGIBzWgHRmxlQmwAR/qGx+/3m1SOkmMiqQSRBD6UA3J
X-Gm-Gg: AYBFou1Ou2W95mndgJPT4nvDWjohGcGc4w+mMv2uMSJkQ9rC7MAkTtlWdKNJKP2Nlsa
	NU2PQLJSRGegN0oPgN7CeEdX+k7HPP53iz1lK78LRTb1nlmlMxqwnegocyURXhuZYDt8o88aPTx
	POw+ei2kuKwYeAe6CV/B0gl2KFgjAWqW8KIMv5gwOzjpazVfVofqCGmOTgSHitXmadEG4dQgeG0
	8U4uvvClBLfMReTGZhrJMEQV3Y8mDZRkYo8V0q6vjxSRmB+5sTKGwul4pMrgC6quvO8wiK17OV3
	85B3f/83z6CrRBa5A/POmqhs4LmxDXj5keXc+gQdPkhY+/878uJR6KwWN5MVdNvbvNKbDQbAeEp
	CMQEPwH4jErCLnhV+Xk4WOSLhZ7ow+yY5B64fa/bx656rjsbAHGQ+c5Y7Dqob2X1akheZaea3p1
	/aNxvMor4k6uSPb2GWe4cfTWoW5oMQO+BX4+Pmol5s3MfbD4U0jsvHTewAGQI=
X-Received: by 2002:a05:6a00:f88:b0:858:b809:6ec0 with SMTP id d2e1a72fcca58-85ed4d13780mr8488702b3a.23.1788354910497;
        Wed, 02 Sep 2026 06:15:10 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85da342023asm1398533b3a.0.2026.09.02.06.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:15:10 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	maxime.chevallier@bootlin.com,
	muhammad.nazim.amirul.nazle.asmade@altera.com,
	rohan.g.thomas@altera.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net-next v4 0/2] net: stmmac: dwxgmac2: timestamp interrupt + Agilex5 fix
Date: Wed,  2 Sep 2026 21:14:39 +0800
Message-Id: <20260902131441.322167-1-zxyan0222@gmail.com>
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
applied, smtg_crosststamp() no longer times out (no "Wait for time sync
operation timeout" in dmesg) and the PTP clock registers and operates
normally.

The pre-existing FIFO-pop / PTP_ACR / flags races that the automated
review raised are not specific to this series (the same shape exists in
the dwmac4 handler) and are left for a separate follow-up.

v1: https://lore.kernel.org/netdev/20260806-dwxgmac2-timestamp-irq-v1-1-c051c79c9d90@gmail.com/
v2: https://lore.kernel.org/netdev/20260810100221.9166-1-zxyan0222@gmail.com/
v3: https://lore.kernel.org/netdev/20260818132722.1852876-1-zxyan0222@gmail.com/
v4:
- Rebased on the latest net-next/main (v7.4 cycle, after net-next
  reopened).

Zxyan Zhu (2):
  net: stmmac: dwxgmac2: add XGMAC timestamp interrupt support
  net: stmmac: dwmac-socfpga: mask XGMAC_TSIE during cross-timestamp

 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 11 +++++
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 43 +++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h     |  1 +
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 12 ++++++
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.h  |  1 +
 7 files changed, 71 insertions(+), 3 deletions(-)

--
2.34.1
