Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F603A5E77
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667438; cv=none; b=HK4X9TJk4rdIzaIKxgF8K4PSSY68Lu6WO3RFrVa/sP0+zF0f6Xj66WqOiCA4xizwyHZOOjDDu7W0xN170jYKPouJilXzzpPchFNcyUsd2lcLeXF6eqFnZK4dlrGEossoRm8A844ZO0SP1aL+g6ypPEisAGXhocxiAx2s0gVQ6L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667438; c=relaxed/simple;
	bh=zl0xoTaTYS/w0n0Ztaa7vwfu7tIkczl6Z5m3FFxtjn0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JETgqXT959EeSxHmKa98sE4Qad5TsfJob1Klp69rtpW7qWmYFXdaCAsmwfONkPVSQgF4lbWQPqqmIaNn2sQvnW+BMcmYc8KoadEaO9t/Idp0dT2Cel6Yxd3l5E+QXEkk3YgCnXiytKHCXSgyW7qjOUaU5fZCxNtP0KmcDMScn9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJKIPOen; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJKIPOen"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb751so1809660a91.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 00:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790667430; x=1791272230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lH7vabi1ElgAOD/H3yIzbFBlm3tuRz9eFpdl+CXfo5c=;
        b=kJKIPOenBxXpe3zgnYmEnIGcMuwA5mxMf03HsloCbwup4mnADSK3QzYPW/oZf65Zgu
         CspXQvB6lknmqabNi6t33ZL8xX28hJbhX+0e00OHw4GkS3GKKJgkQz9pOB3DHeSuCN4+
         b6sTTV7bAiCVfn6hkHJqs9iZmjRyq9vEwPFMYgNgh9GFstAaOMOqxl57AiYZEiEj+SnZ
         sYUIwWQNrD68Yr03udE3BxS94eCNvL7my2rtlTYZFbRQYSZLRIVKhV9woSWqD802O6RC
         KG5HU/GWko6dYp5Aj1w9dR057n2mbCD8yVjJRDBxGMjG8+rJftl2mKWgsYvHM3g7gyoM
         OUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790667430; x=1791272230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lH7vabi1ElgAOD/H3yIzbFBlm3tuRz9eFpdl+CXfo5c=;
        b=XOCzO0Tw67URAkb2upPRt1XEcU+Fwqoqtm0LGuWYd8RaPhGnHAD1xeIe5F7iIsqe9Y
         X1J47o0kn75LmavSjP0hzFtTU3JAf6dlUUQ6ghrFZvNTgifzXdzsa2Qm/TFDYUK5ujOr
         zBjkfg95XZ8o63gtvEPSXj1AIHpZByxBzwTEkzUDEDAh86uDtwBjVhdWTIT8Yv4UmAmU
         3jmNSx9ca0YrfjfMg3EckPq9USNi5s76qDODidwO5haLN2YA7hm7s9wgK6DURX0s9KYR
         sAbwQ0nxYMhRYitogsYrdIPZegQRKfPVFhjcNZgI2laxvAh0jph8ODbqfcRCSjrNFhos
         8Lkg==
X-Forwarded-Encrypted: i=1; AKwUvByiL+AVRVRq1dJHTIOnn65vfNOGFfq7yV3yBpnf/DubN2iEGg/8JRn3BRsotTrExoxePa97Q7M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9jTa/rT3IuFq9IAZ150bG7ShhdqtNgHce8y8DONVV0VJJy1DD
	9ePc6T+lSgo93g7KMK37TsERNAgGU9+sRMbpQDbBOLTVVqphrQHBSkWe
X-Gm-Gg: AYBFou3PY+Ca9dW2c9TvgHgbQhHbsUKUWhy8LBI+qL+Ut5h9HgIDmUv3WuVqvGdAHSt
	+p0+mxu6gQrrFsursILdihasjWc8vaJjF4v1YzpC2vIria9vCtfNyQq8BRtwgouEm8vhtkbj1w4
	UcoenQiPlTCIVVEp/Bm7I69dbn5t+0CQqB2W687s0K6vKG5G21HaHbzfeEZjwTkMFH48KtX7jqS
	NE6g0LEfSqES6ODC6kFH/YX1IuRCktXWtJ0gFLMFXOil0mMntU+87QByZWDAW8IRYuACva+JuME
	cO2d/hw2c3R71ODdVQhDjmIzjxizsnvXvT6eVSAWBCK1h8AouervJVqm3W7/WFf6DjX8aa76SgK
	ggJcUPw+OWZL4ZOCksLnVZnhbesTCuhSk5bJnVyphS0iNsc0Nh5dOD+8k2BZI1NsmhKSTZQ3H8q
	fv6MrxC2j5cf4tvxh/nsvoV79aUoCzIDjAVaSMvz/6UlJXDNoOzoZPYV4L/ZZTz8MPSem6HA==
X-Received: by 2002:a17:90b:57c5:b0:3a2:b04e:8084 with SMTP id 98e67ed59e1d1-3a2b04e8394mr3109613a91.42.1790667429672;
        Tue, 29 Sep 2026 00:37:09 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a498ecc986sm1328708a91.3.2026.09.29.00.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 00:37:09 -0700 (PDT)
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
Subject: [PATCH net-next v6 0/3] net: stmmac: dwxgmac2: timestamp interrupt support + Agilex5 fix
Date: Tue, 29 Sep 2026 15:35:50 +0800
Message-Id: <20260929073553.4136336-1-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds auxiliary snapshot (EXTTS) interrupt support to
DWXGMAC2/DWXLGMAC2, fixes a stale TSIS race on the Agilex5
cross-timestamp path that the new handler would otherwise expose, and
guards the shared aux snapshot handler against a zero channel mask.

Patch 1 makes smtg_crosststamp() complete on the persistent ATSNS
count instead of the transient TSIS bit, waits for the ATSFC FIFO
clear to complete, and holds aux_ts_lock across the whole
trigger/poll/drain sequence so a concurrent PTP_CLK_REQ_EXTTS
request cannot flush the snapshot FIFO mid-flight.

Patch 2 guards the shared aux snapshot handler against a zero
PTP_ACR channel mask: ilog2() is applied to the mask without
checking for zero, and ilog2(0) yields an out-of-range event index
that ptp_clock_event() feeds to test_bit() unchecked from hard IRQ
context.

Patch 3 wires up a dedicated DWXGMAC2 timestamp interrupt handler,
following the guarded pattern of the shared one.  Before this change
the XGMAC hwif entries used the generic stmmac_ptp ops, whose
timestamp_interrupt callback read the dwmac4 offset
GMAC_TIMESTAMP_STATUS (0xb20) instead of the XGMAC register at 0xd20.
The PTP clock advertised the aux snapshot channels, so
PTP_EXTTS_REQUEST succeeded but no event was ever delivered.

Following 30300d9f9150 ("net: stmmac: xgmac: Disable the Timestamp
interrupt by default"), XGMAC_TSIE is not added back to
XGMAC_INT_DEFAULT_EN.  Instead it is armed on demand from the
PTP_CLK_REQ_EXTTS enable/disable path via a new optional
timestamp_interrupt_cfg mac callback (mirroring dwmac1000).  The
interrupt is only touched after the ATSFC FIFO clear has completed,
and the handler refuses to drain entries while that clear is still
in flight; it also leaves the snapshot FIFO alone while an internal
cross-timestamp owns it (STMMAC_FLAG_INT_SNAPSHOT_EN), is disarmed
when the PTP clock is unregistered, and is re-armed on resume by
stmmac_rearm_timestamp_irq() when a channel was left enabled across
suspend.

v1: https://lore.kernel.org/netdev/20260806-dwxgmac2-timestamp-irq-v1-1-c051c79c9d90@gmail.com/
v2: https://lore.kernel.org/netdev/20260810100221.9166-1-zxyan0222@gmail.com/
v3: https://lore.kernel.org/netdev/20260818132722.1852876-1-zxyan0222@gmail.com/
v4: https://lore.kernel.org/netdev/20260902131441.322167-1-zxyan0222@gmail.com/
v5: https://lore.kernel.org/netdev/20260910081020.86227-1-zxyan0222@gmail.com/
v6:
- Hold aux_ts_lock across the whole crosststamp sequence instead of
  dropping it after arming, so a concurrent EXTTS request cannot flush
  the FIFO between the poll and the drain loop.
- Arm XGMAC_TSIE on demand from the PTP_CLK_REQ_EXTTS path instead of
  adding it to XGMAC_INT_DEFAULT_EN, addressing the review comments on
  reverting 30300d9f9150 and on the missing disable counterpart.
- Reword the ATSNS comments: ATSNS is the aux snapshot FIFO level; it
  is not cleared by reading XGMAC_TIMESTAMP_STATUS, which is the
  property the poll relies on.
- Add Fixes: to the EXTTS support patch and guard the shared handler
  against a zero PTP_ACR channel mask, placed before the new handler
  so every intermediate tree leaves the shared path hardened.


Zxyan Zhu (3):
  net: stmmac: dwmac-socfpga: complete cross-timestamp on ATSNS
  net: stmmac: guard against a zero channel in the aux snapshot handler
  net: stmmac: dwxgmac2: add XGMAC timestamp interrupt support

 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 36 ++++++++++---
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 54 +++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  5 ++
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 17 +++++-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 14 +++++
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  9 ++++
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.h  |  1 +
 8 files changed, 130 insertions(+), 10 deletions(-)


base-commit: d0ec95a8a4e79f2fd6063fc8932415db8c227689
-- 
2.34.1

