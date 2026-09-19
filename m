Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8B2931F4
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789845592; cv=none; b=OPBf0/KbfIR7LLDf8qbIRgYsVO9CGjbaedK//K8X9L93vpUXk8oPeW7efmmVnM2NUJQBR0hosxkGzljToPyHhXTOWoijL3G9wTHV6qyV2uyUtj/THfbTKlxk9YkIdnm9OzBa2unNRDQW8Pp9BzE12tdcEaaMZilBU4EuO+drbAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789845592; c=relaxed/simple;
	bh=7eA14pkMyRijHLSluOg7mImGg2JgMqno00/5HbUy+ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FTLqAOsMf1h43LaSNn8SmWqoXC2obpx6N+oKvG+OXapnO0N36xWHhjac57Y4oDvobXKYb3JVqKipKkupQ8oFi4Af3osmXYVgLMTl8BKR43a2Q2fad3coFtpQd+RV3GXZculQof9Q7XeDXGvpXoYpjd/VDJl+C8ucabsmxJKCMEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaIJ6n/z; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaIJ6n/z"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f62ccdb1so606055f8f.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789845589; x=1790450389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DNn5LfmzIp0Qiso4NKlxppBej7z4xYBUzlf1B0pA+mk=;
        b=iaIJ6n/zHZeWTzuP2gE5ZsxtT8MKkcx2CYcDnf79Lc4dSRxi8oUKDgrvz38rz/AukK
         jt+GuCGHOOLozo2p6CZh5tgnBN3INqnuHheCctPcbqHE+O6cKyHmW0742ZIRqQwwNe/H
         v5RhqInYwmTYHwRFVajiJS2NbKAFUA802vFyD4HAaPDkQqOQglJVU+GK0kLW9aGhM4Wd
         jS3vl4+a29Kh0h5p6ifyJPhzTRzH0TvesKkf1y/Fe+bq+F12cqMp8E3Rr+dNPyxii/zA
         ehnF8zAbM+QtLtu5ohM+q6I51R41FIhak5rZ+AZcCExjpunUQFDek+cVdYBclu82UCFG
         bryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789845589; x=1790450389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DNn5LfmzIp0Qiso4NKlxppBej7z4xYBUzlf1B0pA+mk=;
        b=S+iPEm3ObjiMFrDjiKTkryn4rYK3KPFGbZDIS41A8+Me/R6B8g+G7Npzm8ldQvXDch
         3IBjxUvhWfYsPZ4RiEQWMMoSF94pj1Xa16jxFlVT9CKP89Y2d7lPJsAGLHgDo+wV/R/U
         0hAy4QnTjybEcAplUEMJQtMITZXrFIpLXvzdDCcdLJDPRJJ/gq+sK3VKMMYfwayLeY6k
         yqAMwUyAQIS2IWbk6iZtEZJoRsrSlDxFRRPjAvLsOoFhP/xwJl2S2juYe6ug4Ek/OfhH
         dfaxurI91AYRxPVn152fZjnqQV1Fx0owHjU6M0fLt26x08bOalJO7ESqLixwtnsI+e2s
         hWlw==
X-Forwarded-Encrypted: i=1; AKwUvBxANb8xJcMxUXfPtOVy/ABJIPM3vbs37z6gjNxuOorSa4ndi4fFozJBNiaEa9fP4N5Ligc39H0=@vger.kernel.org
X-Gm-Message-State: AFuF++l1nQqUrdqbqinTKdbMfhJRNtOUDgJyPd88c5z+1tuHdTg8/wYR
	zZtozcQbcIKzMxroNaIHXH4YofRX8vfuSOsQsPYVw5m8YEI9Xv1pOziYKfCmSWAB69Ms15G5
X-Gm-Gg: AYBFou1gTC/lToO8R94CyZgxoYxTj0QX0sAzeBwleceFjkboEeBIpTRlPjPG/SIn7Hy
	tbxWYLQd2T5R8oPsN1t1AQJbkeMxFPdt8vjQKVoQjP2c9oA2P60eoZpojoyrwwfQGHuKfL9QG9w
	EyoYqo4UhZGX9qc5Gw99+OWov7cB1BKoJnrcxLD8GNwvHK8SK1a6YTYJvBS4yFMTfW7gBXLocTj
	ZiMrU5blXDJcFc5mWIY2GUYRVqAvbr6H510g7F/OTuYIU2d1taHSzReSWXW36UeWl1tuWi8RSrc
	paM+WuvoIJDcTjMlD5u1nQ6/PoaipMZ5+7Wjl/n+viwEO5g4/VIxta6p7qRVNVbGIQQa1lDj9KB
	cFcgN9ZPingqAQarIh/ofweRLU59p3OFsvPTLVjWOsLQrq1icKSY2oTs6V8A4DnDXWn6yKUAgon
	PND/EwcbAvIFIs4zAby6wKd+V8Rcnh/qmLD5H3cucHxMox7nLiinxsn4mJzSI2mmg1/hA7EMkIi
	fdwdsDR3UeZ5VOxTUIh29rxNvwkkCVuKk8q3KpTnxv5Fv/8E6j3
X-Received: by 2002:a05:6000:41cb:b0:486:fed6:d7e with SMTP id ffacd0b85a97d-4871db11bbfmr10180389f8f.22.1789845589033;
        Sat, 19 Sep 2026 12:19:49 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724593bbfsm8097078f8f.27.2026.09.19.12.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 12:19:48 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dlan@kernel.org,
	wangruikang@iscas.ac.cn,
	vadim.fedorenko@linux.dev,
	maxime.chevallier@bootlin.com,
	troy.mitchell@linux.spacemit.com,
	netdev@vger.kernel.org,
	linux-riscv@infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] net: spacemit: clear TX descriptor on fragment mapping failure
Date: Sun, 20 Sep 2026 00:19:37 +0500
Message-ID: <20260919191937.271202-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

emac_tx_mem_map() writes TX_DESC_0_OWN into the ring descriptor for
every slot beyond old_head as soon as that slot's memset()'d local
copy is committed with "*tx_desc_addr = tx_desc", i.e. before the
buffers for that slot have necessarily all been mapped successfully.
If emac_tx_map_frag() then fails on a later fragment, the err_free_skb
path calls emac_free_tx_buf() to unmap and drop the skb, but leaves
the already-written descriptor memory untouched, and tx_ring->head is
never advanced past old_head (the "tx_ring->head = head" store is
skipped by the goto).

So a slot between old_head and the rolled-back head can be left with
TX_DESC_0_OWN set and buffer_addr_{1,2} pointing at DMA mappings that
emac_free_tx_buf() just tore down, while software considers that slot
free again. The next successful emac_tx_mem_map() call only rebuilds
old_head itself; if the DMA engine auto-advances into the following
descriptor once it finishes old_head's packet, it will fetch that
stale, already-unmapped address.

emac_tx_clean_desc() already treats emac_free_tx_buf() and clearing
the descriptor as a pair when reclaiming completed descriptors; do
the same in the mapping failure path.

Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/net/ethernet/spacemit/k1_emac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index f7f16397a2c2..d641ac26a1e8 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -803,6 +803,9 @@ static void emac_tx_mem_map(struct emac_priv *priv, struct sk_buff *skb)
 	while (i != head) {
 		emac_free_tx_buf(priv, i);
 
+		tx_desc_addr = &((struct emac_desc *)tx_ring->desc_addr)[i];
+		memset(tx_desc_addr, 0, sizeof(*tx_desc_addr));
+
 		if (++i == tx_ring->total_cnt)
 			i = 0;
 	}
-- 
2.55.0

