Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EABC4BC03C
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927611; cv=none; b=o9DQs4wVJX7lMBKEwQnf08N9RSuIYXSgwxZ0k3PwYQhRArj9rWHh/DrdstwdQ+XW9E4uyW0LvV0RT8OI1jhaEcczVjjghsyJhbmUzMHK/ajzp0oGucFIfEIfyeJzQEimOHMKebvrVczbjio9DdohV9hbF5NicurrpjGc3eZk0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927611; c=relaxed/simple;
	bh=fNumZjM2hBuJwDYgwakrQxc2m2bM4Wk/Hhkx6g9MAWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hc6D6ZhzeFPzT8QKn6f3KTjXey70ky+yNRIkud2JDqFnKVtQPcpIfMnfiyTmfZdyfHVbDGg36S5pLk3OL65mya6N4zlDWU1NTlMlCjnRxfllirWvpB6d90oNMgKLltUO5dxCacFW/EEZYDsvDMoBEdieqfWbma+eYIpoOB36Kto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bV1NHHO4; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV1NHHO4"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37d46e0d246so491149a91.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 10:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782927609; x=1783532409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nX/V75O8J2WGNu/mWMfxmlHtmoEqENvIH158XOB3dkU=;
        b=bV1NHHO4+YNsOllmwiHH63sV5rQOsIu1Q05rBcM9z2wElwzwS/32dRd8vN66oHAEAG
         VaBKCIINcH7Dl+bqZuMSl2Y30KdavIDlYBWiAG5lQ4KVp6LI7HTLBHzJ/gc8CSvTwr3c
         eZck3CC9KinKgAUWX2NzlPrDxYSFZIQ9dhWaKlFntjY6IH1YQ7OnuBiXtbJ9uZd+MgCc
         eMFiWadHzn1sRZVdk/FFElDW0Qg3IibkQ6pC2Ez6+wiKKFDlCz2bULRm334dHEcO4G9f
         3Gqm6//TVEVcZerdsQ6L6zKaTBDcT94tvBXx73nBNShDN5W1BMFoZUmirzbTeT9RKHZE
         0B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782927609; x=1783532409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nX/V75O8J2WGNu/mWMfxmlHtmoEqENvIH158XOB3dkU=;
        b=rgWlXxdMPwXvo5eoWFMQXHVOgEeacfhLRdbSCoAPxbEuIArBwP5PuWEUEx6RHYoNyP
         AwTTf8HoOeGv+KAmWBmhZ9xOR0hYaCCkZ/1aVO4uJm5VNef2rEXROb3qeoVxlvEML9BB
         rLgOB2QhjmAOIXNeWrYeQ0BOL+3Gw2Dv6TV2lb5+gcHoXt9YghOqDOBOW2DwDEP7Na6N
         JWWz4uNnWF2P/nzJ7ZGNaVv+2vKi79Y9260JV2iyhGZAobFSf7VYKFRKGw6wnDNCoTeI
         yBaOcmwB8Wie8q5GIcmrF1mkKcoyEkZWFTEK8aDbkqc/210pNTPtuxca3py/8IDQLHGX
         cUhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+p6v1X7Aqyv+nN2Pg2HEMHWsjOqxGrkWcoQzmwbJ8kgfMQ8CbTk4ufOkjmqZG3MUVIjojxm5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBcSrF1HmRqCu+qZnGWLM/QFnGAJuDwsVOj6uUab4e27kbHDvF
	wszprdlld39z7orTBVoU8F6WHCP46yMpE3qDI6DMgPuwBD2gJdbPlMq1
X-Gm-Gg: AfdE7clM5D90BLRcYrsSq+s8mhbOJr9/IP0SpRCytpyuH7RLEnLPcfedT+59Cr+PL4Y
	1vV8pl3M0+nFFPQFBiv1woqtsNDPhB5sQQ7PnNxyS3Titzi1T4PUgHeHexGCT7L7RxBf98ld234
	a4AXMtibCTT3C/zoZpfrZY+7v1VsXDaKBSrgxIYB2Xjdoo7Sz5PQRwTKGO5zYQwVpTLGNO2BHpb
	Giik6Qpg6K40Jaciq31+LIFe4C1j8UDYqScpOn6ID64jN62wsKvpUA+4k0Tj5VV/op+p9ZqkMF/
	GTrrEaQQkVXd6tv3MO0khfjRwYVgDiIrAiOeBosvcjy60PuVBO3d07kvdQdfVGlhqIejdqYE++6
	WTVawkes2FiwoT+HRsNALx0EQ7EFX2wYfdBHnQOdtSpdeE1xXM1m6h3xZlo5NRvRKGH3srMLqb/
	s1uW+SpPv7udwPWF3E2Rke8FW+TR6EVVbpkPUQSQ==
X-Received: by 2002:a05:6a21:3987:b0:3b4:736b:da45 with SMTP id adf61e73a8af0-3bfed47a34cmr3039240637.31.1782927609099;
        Wed, 01 Jul 2026 10:40:09 -0700 (PDT)
Received: from nbai25050028.domain.name ([2401:4900:1f39:4252:c62a:fc28:1de9:62ca])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c80aadfsm30031c88.7.2026.07.01.10.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:40:06 -0700 (PDT)
From: Aniket Negi <aniket.negi03@gmail.com>
To: lorenzo@kernel.org,
	netdev@vger.kernel.org
Cc: Aniket Negi <aniket.negi03@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: airoha: fix MIB stats collection to be lossless
Date: Wed,  1 Jul 2026 23:09:38 +0530
Message-ID: <20260701173941.314795-1-aniket.negi03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630111834.233643-1-aniket.negi03@gmail.com>
References: <20260630111834.233643-1-aniket.negi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current driver resets hardware MIB counters after every read via
REG_FE_GDM_MIB_CLEAR. This creates a race window: packets arriving
between the read and the clear are silently lost from statistics.

Fix this by removing the MIB clear and switching to a delta-based
software tracking approach:

- 64-bit H+L registers (tx/rx ok pkts, ok bytes, E64..L1023):
  read the absolute hardware total directly each poll.

- 32-bit registers (drops, bc, mc, errors, runt, long, ...):
  store the previous raw register value in mib_prev and accumulate
  (u32)(curr - prev) into a 64-bit software counter. Unsigned
  subtraction handles wrap-around transparently.

- tx_len[0]/rx_len[0] ({0,64} RMON bucket) combines RUNT_CNT
  (32-bit, delta-tracked via mib_prev.tx_runt_cnt) and E64_CNT
  (64-bit, absolute). A u64 accumulator tx_runt_accum64 holds the
  running RUNT delta sum so that each poll sets:
    tx_len[0] = tx_runt_accum64 + E64_abs
  without double-counting the E64 value.

Merge airoha_dev_get_hw_stats() into airoha_update_hw_stats(),
moving the port spin_lock inside so callers do not need a separate
wrapper.

Signed-off-by: Aniket Negi <aniket.negi03@gmail.com>
---

Changes in v2:
  - Store _CNT_L register reads in val before adding to stats, improving
    readability (suggested by Lorenzo Bianconi)
  - Fix double-counting bug in the RUNT+E64 combined bucket: previously
    "+=" for E64 re-added the full absolute counter each poll; now a
    dedicated tx_runt_accum64/rx_runt_accum64 accumulator holds the
    running RUNT delta, and tx_len[0] is assigned (not accumulated) each
    poll as runt_accum64 + E64_abs
  - Replace 7-element tx_len[]/rx_len[] shadow arrays in mib_prev with
    focused tx_runt_cnt/tx_long_cnt and rx_runt_cnt/rx_long_cnt fields;
    only RUNT and LONG are 32-bit and need wrap-around tracking
  - Rename inner struct hw_prev_stats to mib_prev; rename accumulator
    fields to tx_runt_accum64/rx_runt_accum64 for clarity
  - Fix comment alignment in mib_prev struct block
  - Rename airoha_dev_get_hw_stats() to airoha_update_hw_stats() and
    move the port spin_lock inside, removing the separate wrapper

 drivers/net/ethernet/airoha/airoha_eth.c | 115 +++++++++++++----------
 drivers/net/ethernet/airoha/airoha_eth.h |  27 ++++++
 2 files changed, 92 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 59001fd4b6f7..4b7c547de165 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1686,12 +1686,14 @@ static void airoha_qdma_stop_napi(struct airoha_qdma *qdma)
 	}
 }
 
-static void airoha_dev_get_hw_stats(struct airoha_gdm_dev *dev)
+static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
 {
 	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = dev->eth;
 	u32 val, i = 0;
 
+	spin_lock(&port->stats_lock);
+
 	/* Read relevant MIB for GDM with multiple port attached */
 	if (port->id == AIROHA_GDM3_IDX || port->id == AIROHA_GDM4_IDX)
 		airoha_fe_rmw(eth, REG_FE_GDM_MIB_CFG(port->id),
@@ -1701,152 +1703,165 @@ static void airoha_dev_get_hw_stats(struct airoha_gdm_dev *dev)
 
 	u64_stats_update_begin(&dev->stats.syncp);
 
-	/* TX */
+	/* TX - 64-bit H+L registers: hw accumulates the total, read directly. */
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
-	dev->stats.tx_ok_pkts += ((u64)val << 32);
+	dev->stats.tx_ok_pkts = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
 	dev->stats.tx_ok_pkts += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_H(port->id));
-	dev->stats.tx_ok_bytes += ((u64)val << 32);
+	dev->stats.tx_ok_bytes = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_L(port->id));
 	dev->stats.tx_ok_bytes += val;
 
+	/* TX - 32-bit registers: accumulate delta to handle wrap-around. */
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_DROP_CNT(port->id));
-	dev->stats.tx_drops += val;
+	dev->stats.tx_drops += (u32)(val - dev->stats.mib_prev.tx_drops);
+	dev->stats.mib_prev.tx_drops = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_BC_CNT(port->id));
-	dev->stats.tx_broadcast += val;
+	dev->stats.tx_broadcast += (u32)(val - dev->stats.mib_prev.tx_broadcast);
+	dev->stats.mib_prev.tx_broadcast = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_MC_CNT(port->id));
-	dev->stats.tx_multicast += val;
+	dev->stats.tx_multicast += (u32)(val - dev->stats.mib_prev.tx_multicast);
+	dev->stats.mib_prev.tx_multicast = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_RUNT_CNT(port->id));
-	dev->stats.tx_len[i] += val;
+	dev->stats.mib_prev.tx_runt_accum64 +=
+		(u32)(val - dev->stats.mib_prev.tx_runt_cnt);
+	dev->stats.mib_prev.tx_runt_cnt = val;
+
+	/* tx_len[0]: RUNT (32-bit, delta) + E64 (64-bit, absolute) → {0, 64} bucket.
+	 * Accumulate RUNT delta in tx_runt_accum64, then assign tx_len[0] as
+	 * accum + E64_abs so each call gives the correct combined total.
+	 */
+
+	dev->stats.tx_len[i] = dev->stats.mib_prev.tx_runt_accum64;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] += (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_L(port->id));
 	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_L(port->id));
 	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_L(port->id));
 	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_L(port->id));
 	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_L(port->id));
 	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_L(port->id));
 	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_LONG_CNT(port->id));
-	dev->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += (u32)(val - dev->stats.mib_prev.tx_long_cnt);
+	dev->stats.mib_prev.tx_long_cnt = val;
 
 	/* RX */
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_H(port->id));
-	dev->stats.rx_ok_pkts += ((u64)val << 32);
+	dev->stats.rx_ok_pkts = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_L(port->id));
 	dev->stats.rx_ok_pkts += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_H(port->id));
-	dev->stats.rx_ok_bytes += ((u64)val << 32);
+	dev->stats.rx_ok_bytes = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_L(port->id));
 	dev->stats.rx_ok_bytes += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_DROP_CNT(port->id));
-	dev->stats.rx_drops += val;
+	dev->stats.rx_drops += (u32)(val - dev->stats.mib_prev.rx_drops);
+	dev->stats.mib_prev.rx_drops = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_BC_CNT(port->id));
-	dev->stats.rx_broadcast += val;
+	dev->stats.rx_broadcast += (u32)(val - dev->stats.mib_prev.rx_broadcast);
+	dev->stats.mib_prev.rx_broadcast = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_MC_CNT(port->id));
-	dev->stats.rx_multicast += val;
+	dev->stats.rx_multicast += (u32)(val - dev->stats.mib_prev.rx_multicast);
+	dev->stats.mib_prev.rx_multicast = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ERROR_DROP_CNT(port->id));
-	dev->stats.rx_errors += val;
+	dev->stats.rx_errors += (u32)(val - dev->stats.mib_prev.rx_errors);
+	dev->stats.mib_prev.rx_errors = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_CRC_ERR_CNT(port->id));
-	dev->stats.rx_crc_error += val;
+	dev->stats.rx_crc_error += (u32)(val - dev->stats.mib_prev.rx_crc_error);
+	dev->stats.mib_prev.rx_crc_error = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OVERFLOW_DROP_CNT(port->id));
-	dev->stats.rx_over_errors += val;
+	dev->stats.rx_over_errors += (u32)(val - dev->stats.mib_prev.rx_over_errors);
+	dev->stats.mib_prev.rx_over_errors = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_FRAG_CNT(port->id));
-	dev->stats.rx_fragment += val;
+	dev->stats.rx_fragment += (u32)(val - dev->stats.mib_prev.rx_fragment);
+	dev->stats.mib_prev.rx_fragment = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_JABBER_CNT(port->id));
-	dev->stats.rx_jabber += val;
+	dev->stats.rx_jabber += (u32)(val - dev->stats.mib_prev.rx_jabber);
+	dev->stats.mib_prev.rx_jabber = val;
 
 	i = 0;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_RUNT_CNT(port->id));
-	dev->stats.rx_len[i] += val;
+	dev->stats.mib_prev.rx_runt_accum64 +=
+		(u32)(val - dev->stats.mib_prev.rx_runt_cnt);
+	dev->stats.mib_prev.rx_runt_cnt = val;
+
+	/* rx_len[0]: RUNT (32-bit, delta) + E64 (64-bit, absolute) → {0, 64} bucket.
+	 * then assign rx_len[0] = rx_runt_accum64 + E64_abs.
+	 */
 
+	dev->stats.rx_len[i] = dev->stats.mib_prev.rx_runt_accum64;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] += (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_L(port->id));
 	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_L(port->id));
 	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_L(port->id));
 	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_L(port->id));
 	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_L(port->id));
 	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_L(port->id));
 	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_LONG_CNT(port->id));
-	dev->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i] += (u32)(val - dev->stats.mib_prev.rx_long_cnt);
+	dev->stats.mib_prev.rx_long_cnt = val;
 
 	u64_stats_update_end(&dev->stats.syncp);
-}
-
-static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
-{
-	struct airoha_gdm_port *port = dev->port;
-	int i;
-
-	spin_lock(&port->stats_lock);
-
-	for (i = 0; i < ARRAY_SIZE(port->devs); i++) {
-		if (port->devs[i])
-			airoha_dev_get_hw_stats(port->devs[i]);
-	}
-
-	/* Reset MIB counters */
-	airoha_fe_set(dev->eth, REG_FE_GDM_MIB_CLEAR(port->id),
-		      FE_GDM_MIB_RX_CLEAR_MASK | FE_GDM_MIB_TX_CLEAR_MASK);
 
 	spin_unlock(&port->stats_lock);
 }
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index f6d01a8e8da1..3af1c49dd62d 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -245,6 +245,33 @@ struct airoha_hw_stats {
 	u64 rx_fragment;
 	u64 rx_jabber;
 	u64 rx_len[7];
+
+	struct {
+		/* Previous HW register values for 32-bit counter delta
+		 * tracking. Storing the last seen value and accumulating
+		 * (u32)(curr - prev) into the 64-bit software counter
+		 * handles wrap-around transparently via unsigned arithmetic.
+		 * tx_runt_accum64/rx_runt_accum64 hold the running sum of
+		 * runt deltas. These fields are never reported to userspace.
+		 */
+		u32 tx_drops;
+		u32 tx_broadcast;
+		u32 tx_multicast;
+		u32 tx_runt_cnt;
+		u32 tx_long_cnt;
+		u64 tx_runt_accum64;
+		u32 rx_drops;
+		u32 rx_broadcast;
+		u32 rx_multicast;
+		u32 rx_errors;
+		u32 rx_crc_error;
+		u32 rx_over_errors;
+		u32 rx_fragment;
+		u32 rx_jabber;
+		u32 rx_runt_cnt;
+		u32 rx_long_cnt;
+		u64 rx_runt_accum64;
+	} mib_prev;
 };
 
 enum {

base-commit: a225f8c20712713406ae47024b8df42deacddd4a
-- 
2.43.0

