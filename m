Received: from mail-wr2-f42.google.com (mail-wr2-f42.google.com [74.125.225.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F0D3B8D79
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791127747; cv=none; b=Htyvc+Acof62OZhknQs7VaeDmYrm86IuLwzb5HkBo3WuqHJjgN93WcDqvaSLkWCxbnAnc6su4GoZpk9MS9Tw+FQFaiWRcdIKDmXWY/cWw/TqvhyTMzwQhUKmYOy5fzO3DX5j4bcRkcFbpm1lq0X86LZ1FH8b2WeyeCt5B1V3kQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791127747; c=relaxed/simple;
	bh=X6sQTrF5sRJS4FjRxjDb+iu01tlVl/GwIKIQobzsJcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJsAKcNSmn0X+3k7+ki4V08bZDbGvQupq3GepC/Drh2FuD4k/5aAvC3hvgbqUqySUBn48Nwv9gN3QeRa928tlftUfEKQbj+54u9IXpxz//KgK53ZyuCycnwIKo5pPifFC2bK8taSvqdI6kRJJoxdw9HRYGeNwiEsghk/cTc0yDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sQ2WfDFl; arc=none smtp.client-ip=74.125.225.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQ2WfDFl"
Received: by mail-wr2-f42.google.com with SMTP id ffacd0b85a97d-48b0622cc90so397355f8f.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791127743; x=1791732543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=da8v9Ff4EAj7a0ycHgkCs+irzmjp0yJ76SMiIUMp9bU=;
        b=sQ2WfDFl+UnNJ3TviQGq1ZVj4X2IPH1YipRbI/LFNB/qMm1rJO3zi+BIFVPJslCWN+
         7uiVGbsx5vcL2E3VsIy7B+stPtuLgEMEY+sR+U8pFgG9EtJziVtm0J/Plcnr4ap5xxoJ
         aP8yZjZXVDLymjB7Dua1+Dvld5Tgp+zDF9Kc8/G0k+Ylf8In59JvKYJSgYK8b+OBSQTk
         BJHKpHkbsEn63liLk7c4SL3mPV2A3CgUry6XcOC2xR/lbelF7cmjO+PgucyeNWy5n/T2
         buTbRFWFz6g++Qsm5ldQ5BYRzPHTxiGK565Zgdo5nLczPV+nm3F7AmwKRSnK34z/dH6Y
         DFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791127743; x=1791732543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=da8v9Ff4EAj7a0ycHgkCs+irzmjp0yJ76SMiIUMp9bU=;
        b=ENMrd1Db4qKMwxI7Ra1VNxwI71yy98vN62k5ixKPwIHuGii7rD7gJL5gLRQKy1todG
         5Ca1Ag+tvkisc7WyX8dD0sHDfOrdZHqdQZc6d4KfA0k/pDWHPrT5cebYOBRrMClLre4J
         a/JYy0cDWL9tiIcYZbV8mwTMfdqd1NUyZkUKvmlz3vv39yZKwvC63GUCoyE0iFxjbNWz
         ytUViMIR6EnsyRV2q6sS2+WRlKvgpKEFbhngyJwpITfNvkH0o/HVRz7j7/S1kIKFO8ig
         MZ+oKVP9M0MQCUwXPCKiep61dY4ekB/SgofPawo1h4j5ax9cGAkf2E0WSYDwTB309dtI
         GX6w==
X-Gm-Message-State: AFuF++kwRYQfroIYfgw4HxYAntM54gMjinTC5LxTfVMLEjxl9vK4Wcv/
	h2XxMyGePRBvHbv6FyAsNUTc8yhtadnmblTpeFRm//Hi39V7hNeX3Xf1
X-Gm-Gg: AYBFou0kE4cFvBPvvCqrTUu6lRIb9+PoLuRudSglo7fhoIfohxIC0UJpxlAZU8dN+/W
	UIyEslx4HZsdLrofWGG5RYb5T+wg8GbGAUy0OARJvGhqEnwC3KV5UGXHELKjQAfhCmuGv6OusgY
	bw26VZZy2D9ZXz1KHbDdMjBABb9nfjuXaM6ygiEXtUs7g3c0RJiGI75S8l9Oh8iAOSQHNk0Fggx
	HBAYTCDkXO0YiPkh5tdxUBatlS2KICeLS+whINmt7LwvuHe3AaGDJ9qIVGsqq9XjvTb48Ocf2/w
	odevckqh4Rh9netuBo/1tjEuz9lXyF0qtLICBju8xBhFGh82FGnx7AIV3++FdPke9EPld7Mt8F7
	TXre9nD2pnvaRyvzmyfqYCP1kcikaTG/XOTleW4+ll7bgcKh0KHb6v8ab1j8yEUdHJO2C2tFGw9
	2Cxk52xfGWANVSS04xpZhcJIUQr0MpbfUO7cOCKz/YGz1SqLyeXNsudLrVqZKeEUIAavA8k1dl1
	VdyAxGvIpvg27Fh7ujPkn0vIOh1Pz7tvHZkicQu/ugsJl8TARNDs8/oYchPVXkH+VDCrhN6WSo=
X-Received: by 2002:a05:600c:1552:b0:49b:d03:8d3a with SMTP id 5b1f17b1804b1-4a02755f84bmr145261655e9.11.1791127743178;
        Sun, 04 Oct 2026 08:29:03 -0700 (PDT)
Received: from citron.bnl.ovh ([2001:861:44c1:870::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1698f7910sm83819735e9.3.2026.10.04.08.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 08:29:02 -0700 (PDT)
From: Benoit DE RANCOURT <b2rancourt@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Sasha Neftin <sasha.neftin@intel.com>,
	linux-kernel@vger.kernel.org,
	Benoit DE RANCOURT <b2rancourt@gmail.com>
Subject: [PATCH iwl-net 0/2] igc: Fix Tx hangs after NETDEV_TX_BUSY with TSO
Date: Sun,  4 Oct 2026 17:28:38 +0200
Message-ID: <20261004152840.61222-1-b2rancourt@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit db0b124f02ba ("igc: Enhance Qbv scheduling by using first
flag bit"), igc_xmit_frame_ring() requires count + 5 free descriptors,
while the queue is only stopped in advance below DESC_NEEDED =
MAX_SKB_FRAGS + 4. TSO skbs with 16 or 17 fragments then hit
NETDEV_TX_BUSY. That return skips the tail write deferred by
xmit_more, so the queue can stay stopped with descriptors the hardware
never saw, until the Tx watchdog resets the adapter.

Patch 1 aligns DESC_NEEDED with the admission check. Patch 2 writes the
tail before returning NETDEV_TX_BUSY, which remains reachable for skbs
with buffers larger than IGC_MAX_DATA_PER_TXD. Each patch was tested
alone; together they keep the queue stop logic consistent and the
remaining busy path safe.

Setup: CWWK router, Pentium Gold 8505, six I226-V (8086:125c rev 04,
NVM 2017:888d), 7.2.8, default MAX_SKB_FRAGS = 17. Load: CPU saturated
with busy loops, a remote build routed through the port, two SSH bulk
streams in each direction and short TCP bursts, 180 seconds of load
per run observed during a 195-second probe window, TSO enabled on the
egress port. bpftrace probes on igc_xmit_frame, __igc_maybe_stop_tx
and igc_poll recorded NETDEV_TX_BUSY returns, the inferred last tail
write and next_to_clean stalls.

                       runs  Tx timeouts  NETDEV_TX_BUSY  TX_OK returns
  unpatched 7.2.8         3           25           10890       7.3M
  patch 2 only            3            0           10751       9.5M
  patch 1 only            3            0               0       8.8M
  both patches            3            0               0       9.4M
  unpatched, TSO off      1            0               0      21.5M

In all 25 timeout episodes, the stalled queue had pending descriptors
after a NETDEV_TX_BUSY return. The probes inferred at least 214
descriptors beyond the last tail write. For that queue, the hardware
register dump showed TDH = TDT = the next_to_clean value recorded by
the probe.

With both patches applied, no NETDEV_TX_BUSY occurred, so the flush
path of patch 2 was not exercised in that run; its effect is shown by
the patch 2 only runs.

TX_OK returns count igc_xmit_frame() calls returning NETDEV_TX_OK,
excluding NETDEV_TX_BUSY retries. These are software call counts,
not hardware packet counters; with TSO disabled, segmentation occurs
before the driver.

Related code, not addressed in this series and not tested:

- bnxt: commit e8d8c5d80f5e ("bnxt: make sure xmit_more + errors does
  not miss doorbells") rings a pending doorbell on the drop paths. It
  leaves the busy path alone, reasoning that busy can only happen if
  start_xmit races with completions that both enable the queue, in
  which case no kick can be pending; the current code warns "ring busy
  w/ flush pending!" if that assumption breaks. In igc, patch 1
  restores that property for skbs whose buffers each fit in one
  descriptor, and patch 2 covers the remaining case.

- igc drop paths (skb_put_padto() failure in igc_xmit_frame(), out_drop
  in igc_xmit_frame_ring(), the DMA mapping error path of igc_tx_map())
  also return without writing a pending tail, the case bnxt fixed in
  e8d8c5d80f5e and 00eeab0c644a ("bnxt_en: Write doorbell when
  linearizing skb fails"). The queue is not stopped there, so pending
  descriptors are delayed until the next transmit on that queue rather
  than stranded.

- igb, ixgbe, fm10k, i40e, iavf, ice, e1000e and e1000 also defer the
  tail write with xmit_more and return NETDEV_TX_BUSY from their
  admission check without writing it. Their stop thresholds match
  their admission checks, so this should only be reachable for skbs
  needing more descriptors than the stop threshold assumes.

Not done:
- runtime test on a kernel built from this tree; the patches were
  tested on 7.2.8, where the affected code is identical, and apply
  cleanly here;
- launch time (ETF/taprio) and XDP/AF_XDP traffic, which share the
  ring and the wake threshold;
- longer runs and other I226/I225 boards;
- only the igc objects were built with W=1 under allmodconfig, not
  the full tree.

The analysis and the patches were prepared with an LLM-based coding
assistant, which also wrote the bpftrace probes; the results above come
from those probes and the kernel log on real hardware.

Benoit DE RANCOURT (2):
  igc: Fix Tx stop threshold to cover empty frame descriptors
  igc: Flush pending Tx descriptors before returning NETDEV_TX_BUSY

 drivers/net/ethernet/intel/igc/igc.h      | 8 ++++++--
 drivers/net/ethernet/intel/igc/igc_main.c | 6 +++++-
 2 files changed, 11 insertions(+), 3 deletions(-)


base-commit: a83267db14681b3be481e02a4d5a38177507006c
-- 
2.55.0

