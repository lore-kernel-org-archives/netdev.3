Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA66377AB4
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862335; cv=none; b=qZTL2nRKImZq7cq46+8K1yAQgCoq7PjlRILXSXQgFwQ93PEF8JeqPf33PbODPlQEiiKIOx92cE203ub4v+Z6ov8qCPG0Kum1Yv9AOlOpgeybvslNnMSFcKIrZa5EbbFRJmRWJEaKI2+wlxgwQrohYRIljjoIxRtF7CKx9qwaPN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862335; c=relaxed/simple;
	bh=IyheIQPFaBDT7+LxjdCL9KtVVA6tqApMSlyfFxvP220=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NFwqSnb6iu74ioMd0M1qhHepZopPUPOY/TzgUSgIrGFSmRkec58eKjek2sLevqPIGLHvE1azKiSgHfBenlDiW3l+TLukWKe17mLla3BFNXW0Egj0J5isAupUObJPPbardUiCTS8ucTeuSDiZOLmoReMJAcJ+vpquSe0bTKItbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eahw3a89; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eahw3a89"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e5d0ee1951so15420015ad.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 20:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862334; x=1792467134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K5tVRnzC7/u+9J2k/n3TM+qJYjKV4r4MGpsSjnXhUFQ=;
        b=eahw3a89k4aL49c5ZY/wZVXJZ6YEsjiQn48Z9UYjGKrKfaNPxTjcqtZzklzwbIRyQ8
         Bl7OMnsPy7p7tTzn3oqsbL1ww8xyfcN8+QZkr00BNTuGg5wlaoTGsK7sYi8RsUr/6oJI
         KtwCp4NwzWkTgh7kV9WIrPd5yCZyCiyuN851UyrAhDRTuj4tljNtVO48F5qosAqYZipl
         g/ElFhRteaC3xDQWVMDB+qzDfVbwZKbjfBvmCyCARoe4m2ODvDrC/Yq1CDcj7NAbp1+/
         rT3dL/mcE8pXegUC5Nck3Ql05jIUR8tAuNNcR7iWl9sPh0aWRTbGxQboMRM2zO2E5htQ
         h+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862334; x=1792467134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K5tVRnzC7/u+9J2k/n3TM+qJYjKV4r4MGpsSjnXhUFQ=;
        b=EdmLAivLJztXB9cQOcd8qnT65w1fE3YSiib5MvQoGnVVUgWBovvgUX7QqPNuLx8bic
         khfOVwq6/8gJk0WOSG5ZdoNbgqlUQuLoOLG2Xwp9rzGJB5TXUg0GkX0VfSkH3psWbzOL
         I6qyxKAiaFPyrAJtxbEKKYkmT+JwyS7KMEOvxb7rvNIYngk/WiIZ2PZtbozbvlZKXWvN
         K5ztF9ARaJZ4V++YABZgBFTcNH/Be1X/orEMY6JDHJwGUptyI7JzFGC7tvJKd4rpKqy3
         FxT+Y07OM8ZmBVdCo+uA8WH9/PApaTXST3ZKkp6v/JQuZjQLQ8hApMpXteLJnM3tFmk+
         Y8Jg==
X-Forwarded-Encrypted: i=1; AKwUvBzfpcaPyzWID+cnRKg6gDtd4lgHFB9129TSw6rpSvv3xsPs948oOx6JInwCwLteqZxbPAz6LAI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmdnVHLp2jEIOJsSwbsV1p/AIpsL7FciiGRLLBGE75dEA8g2Na
	yNlYcX9ZJTotP3gQh+janNISU6zgi1jKwX8gVfUBlG6KBlVfcWnb0YGg
X-Gm-Gg: AYBFou0otRfv8VO5KVaRCn7zanB58lYrE+d8GCc+nESoZb3S/OKB59orNcPuUkj6zUc
	0sJ4FcgIomIw90PVE1iEXZyZ7FTWZDadch8TA5FDMVhkgioO6BlM6d36hOj9v9RaCf55BS9vx3e
	IId1oSLW4mxPDiW3jbNcP466HtfXuXFgiyLbU0PIds6MvYzANBYXpeOh2Xhoac6gxphx5evtg2C
	bnvMDjTUJXgw+Ri6qkPThC+dKDfi62nKNpHLAVs9Pb7SqgTbhUZSz4cUQ43EW9e+hWRofGwt+KJ
	q5ljsLxugC2kE7dTs+2BEFBR5Ke3TTEWUvzXm2AxcJz8ZSyWA+ar+dtGfqVD8xJnquQN98YwC6G
	sLaM7W1Qp+1B5tiRcWZeVB5IkqQsA2ibFvgkx507wn5K0Bqmm8RGe4sUyP5ff/POemgJXMb+g1k
	r+0Wr5lhzi16IvnMamImiuBAItxpvY6a7TIYjFLwOUfvuQPV9fSOpUxBpsz0tN/07cJdDv3ubxH
	NIto4H/
X-Received: by 2002:a17:90b:3143:b0:3a6:e99b:bbdb with SMTP id 98e67ed59e1d1-3ab3ac718f2mr10568795a91.50.1791862333896;
        Mon, 12 Oct 2026 20:32:13 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36fdc75esm19541303a91.12.2026.10.12.20.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:32:13 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	muhammad.nazim.amirul.nazle.asmade@altera.com,
	rohan.g.thomas@altera.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v8 0/3] net: stmmac: dwxgmac2: timestamp interrupt support + Agilex5 fix
Date: Tue, 13 Oct 2026 11:32:04 +0800
Message-Id: <20261013033207.1684328-1-zxyan0222@gmail.com>
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
count instead of the transient TSIS bit, waits for the FIFO clear to
complete, and holds aux_ts_lock across the whole trigger/poll/drain
sequence so a concurrent EXTTS request cannot flush the snapshot FIFO
mid-flight.

Patch 2 guards the shared aux snapshot handler against a zero channel
mask: ilog2() is applied to the mask without a zero check, and
ilog2(0) yields an out-of-range event index that ptp_clock_event()
feeds to test_bit() unchecked from hard IRQ context.

Patch 3 adds a dedicated DWXGMAC2 timestamp interrupt handler.  The
XGMAC hwif entries used the generic ops, whose callback read the wrong
register and whose enable mask omitted the timestamp interrupt, so the
clock advertised the aux snapshot channels but no event was ever
delivered.  XGMAC_TSIE is not enabled by default; it is armed on demand
from the EXTTS enable/disable path through a new callback, and the
handler only touches the FIFO while the interrupt is armed and while no
cross-timestamp owns it.  The interrupt is disarmed on suspend and
unregister and re-armed on resume.

v1: https://lore.kernel.org/netdev/20260806-dwxgmac2-timestamp-irq-v1-1-c051c79c9d90@gmail.com/
v2: https://lore.kernel.org/netdev/20260810100221.9166-1-zxyan0222@gmail.com/
v3: https://lore.kernel.org/netdev/20260818132722.1852876-1-zxyan0222@gmail.com/
v4: https://lore.kernel.org/netdev/20260902131441.322167-1-zxyan0222@gmail.com/
v5: https://lore.kernel.org/netdev/20260910081020.86227-1-zxyan0222@gmail.com/
v6: https://lore.kernel.org/netdev/20260929073553.4136336-1-zxyan0222@gmail.com/
v7: https://lore.kernel.org/netdev/20261004120526.2728564-1-zxyan0222@gmail.com/

v8:
- Gate the handler's FIFO drain on XGMAC_TSIE being armed; the handler
  runs for every MAC interrupt and must not touch the FIFO while the
  timestamp interrupt is disarmed.
- Hold aux_ts_lock across the whole EXTTS enable, including the FIFO
  clear poll, so the re-arm cannot interleave with a suspend.
- Drain an in-flight handler with stmmac_sync_timestamp_irq() when the
  FIFO is handed to the cross-timestamp and on the EXTTS disable path.
- Roll a failed EXTTS enable back in hardware and software on the
  FIFO-clear timeout, and drop the EXTTS state when the resume re-arm
  cannot restore the channel.
- Disarm XGMAC_TSIE on suspend and unregister; re-arm it on resume.
- Initialise aux_ts_lock in probe and destroy it in remove, so it is
  valid for the whole device lifetime.
- Only clear the software state in the resume-failure teardown, since
  the auxiliary snapshot register differs on DWMAC_CORE_MAC100/GMAC.

-- 
2.43.0

