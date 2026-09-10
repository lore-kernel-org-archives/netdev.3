Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3799841D23D
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027830; cv=none; b=QgevY2UNoQ+iVXb2MnBTREZEDxSFZrVQsNVLQ7WGi3bVxlkYFdcraCIYzzMb+vYv1n7joTtmyGmxYYvfKJOERcjRKsdR1pp1N1yb6rziKQNkm+woBOXqqvdyCwDY8BR+TQCchK+iUGVNOAPEpo6NP5rvFyC9elz1JG6JlA4rw9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027830; c=relaxed/simple;
	bh=Ups6Na12RMvnO7T8H4wHROVUdgJrEy7x5iqCKw6n8wA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y2BuDA+3xvxjDYN/lMatlM37XdY60P6KWEWipr6nZ2WXvMR9X88UuaHdxgya/SgH+HFAcaCZfDc76KAFfWIps6OAsX5qi7I0dp0jTxH/WSV21OI9VGOpszBl2MJlibmzfGzn1PlmSNK9csYbTMOalYQkVrWkJhQmQgUlxmGtqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOewAPJV; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOewAPJV"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4aeso1838443a12.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789027828; x=1789632628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LGTao/KdTdduxv+yT3fMuwnoAGn1zACXJ7pG0Rb21UQ=;
        b=GOewAPJVOL37bjW4dw5RZc8rupUWtuWllDfVW1QVJwx5uDeidAR03o3Pykj8V6cxna
         3FnPQfo7l1Rz+z6a0dQpMJrJW2fZflyFL6S05Hpraervzs3ijtO4YdeUVLB7AeiN1Kk+
         hZ+Y6ghmDwd1jw647JB+zyCzj5M8+2E4o9JFwvRpCN3tTagU3C1/OjsMAzKyzP0Of7r4
         7kMWu7y5xwaTfo8rCs2Fg3AYkIS/YZCWIc7TpBWqgDxI02znaXC6NNwSnDyCOUOGCjJF
         B3OCTRdSnGg9smpUsYIqTieVUDYrUD4tyM8PHjRJGy5tUIBT9RIOVnEAE6f9uhR2j5or
         9drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789027828; x=1789632628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LGTao/KdTdduxv+yT3fMuwnoAGn1zACXJ7pG0Rb21UQ=;
        b=m2AJXqkjbeTA6RbZTrF2khCpKu+Kh5zULodBtbsqDY1sG+BKwzBHvMd9vMTt793gx5
         pgW7oIHD1wxNo4oBbMbZqZiNkxE/Tx5aUciRuug88yKNsQABOwEKcqVqCfR6rCEOr2J/
         vrLm+h2ZtBOB8Of4IVbEmNTvZbPank8ApqphckbTmbIcfJUJv26BfvsS0+91/0NIwB4y
         GumnmK34UGiHc1xDMVfKnKhk9qVOpIifDXrU1z2H5m/RWTCg2Zz6r3S1z33x5yLOzqS3
         ARz7u94u7raJ1ItgjWgrEgUOxmaeGBpubn4dT6M6VAq+yNlHSQSX9rcaE+nXMN8RFiia
         e2Cg==
X-Forwarded-Encrypted: i=1; AKwUvBydmzuzRNg+zznip5kF0rzgosoqtJtRYYWkwsQCdyv0+wrhy/tCfFL3jy/8T37E8GbX8nb9/DY=@vger.kernel.org
X-Gm-Message-State: AFuF++nIeL/wGqEco+2CCo5U87JmUGWgmR6TkV31FoZilVCFjmR8Ijpf
	/nwG4EbK3/sjpUKnamnN75eWhWgXrwQcNwyu4FOP61Y/zMEyreoAqgCs
X-Gm-Gg: AYBFou2eTKCvcV2w4PN02um3YDmLPxSHR82rcfGDHa7t/2RDWKD6lhwp5GAO1FPSwjN
	swzJbcYajBpckoeDdx9NledT4a446hAeAv14BEHgsz56buh/J6JmTXNl4jdu9TLkr//2XO3vkvj
	J6fU6Bhdlyeh3cRfrlrdtGROzhroXgATlJsz5xoU7GSyV2hKx2C6GuWKHgt2F0Dd95/aODnx33G
	3c2R5L539WbPUzCzYGY0yKE3r82mbpJh3vRF28Ch7bhnqP5wyZyGjT3uLLQPzcVkOGZNaTf3OX/
	77mQnlXJtn4zx1b7tdJ7btwv0zmW9Tuo6rkV1TxrrB3pCQi/Xx2gRPJznrDDkTjCgtweEwhlY3Y
	5fLLppt3MZybZARaILVM94hNtSmVVkZ1dXeUMKrMSd5CnI0xYguDqNQNYhBzt1C0wIxHa33uaNb
	kXvw1bC9YFZLwj9TN+HFd69TgNY8/GxZYa5CxKvpVGE5m6REPhVmv2JSBCClPmuEI9EDuXVo4vC
	O1m9k7V
X-Received: by 2002:a17:90b:4d84:b0:398:e73e:5a0c with SMTP id 98e67ed59e1d1-39bac138257mr15353888a91.1.1789027828457;
        Thu, 10 Sep 2026 01:10:28 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d770bc9f5sm4442434a91.2.2026.09.10.01.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 01:10:27 -0700 (PDT)
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
Subject: [PATCH net-next v5 0/2] net: stmmac: dwxgmac2: timestamp interrupt support + Agilex5 fix
Date: Thu, 10 Sep 2026 16:10:18 +0800
Message-Id: <20260910081020.86227-1-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds auxiliary snapshot (EXTTS) interrupt support to
DWXGMAC2/DWXLGMAC2 and fixes a stale TSIS race on the Agilex5
cross-timestamp path that the new handler would otherwise expose.

Patch 1 makes smtg_crosststamp() complete on the persistent ATSNS count
instead of the transient TSIS bit, waits for the ATSFC FIFO clear to
complete before arming, and derives the pop count from the poll result,
so the completion condition is immune to the destructive reads of
XGMAC_TIMESTAMP_STATUS performed by the DWXGMAC2 timestamp interrupt
handler and the TX timestamp completion path.

Patch 2 wires up a dedicated DWXGMAC2 timestamp interrupt handler.
Before this change the XGMAC hwif entries used the generic stmmac_ptp
ops, whose timestamp_interrupt callback read the dwmac4 offset
GMAC_TIMESTAMP_STATUS (0xb20) instead of the XGMAC register at 0xd20,
and XGMAC_TSIE was never enabled, so auxiliary snapshot events were
never reported on XGMAC platforms.

Because v5 changes the completion mechanism, the previous Tested-by for
the mask approach no longer applies; Patch 1 needs re-verification on
Agilex5 hardware.

v1: https://lore.kernel.org/netdev/20260806-dwxgmac2-timestamp-irq-v1-1-c051c79c9d90@gmail.com/
v2: https://lore.kernel.org/netdev/20260810100221.9166-1-zxyan0222@gmail.com/
v3: https://lore.kernel.org/netdev/20260818132722.1852876-1-zxyan0222@gmail.com/
v4: https://lore.kernel.org/netdev/20260902131441.322167-1-zxyan0222@gmail.com/
v5:
- Replace the XGMAC_TSIE masking approach with completing the
  cross-timestamp on the persistent ATSNS count, and reorder the series
  so it is bisect-safe.
- Wait for the ATSFC FIFO clear to complete before arming, so a stale
  ATSNS count from a previous snapshot cannot be observed.

Zxyan Zhu (2):
  net: stmmac: dwmac-socfpga: complete cross-timestamp on ATSNS
  net: stmmac: dwxgmac2: add XGMAC timestamp interrupt support

 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 29 ++++++++++---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 43 +++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  1 +
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 12 ++++++
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.h  |  1 +
 7 files changed, 84 insertions(+), 8 deletions(-)

-- 
2.34.1

