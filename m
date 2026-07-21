Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B708399892
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784601568; cv=none; b=sv1BDK39uH4VMvYnqjQd2aozIQ/ZJzuqmPjOyUqnnTk5YvrxV0pkkPQMVJvUYpDzDQ9LODTCpamtH4Yub3H0iHrUTRXEYOuuzqbEqXfVtDva2ZBX8q9pb5fPhLFY+G1Jwk2ehAqV/1Q4oG/5xuiTwwszB21YHVvkZqGEzM0Cco8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784601568; c=relaxed/simple;
	bh=qKSHhVdoJD801B4KF7UfypZpenDEgYwc440zDFLMz14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kx2iYc9JD5Rz52GaIZ5+JJ9mvwq68uZk2GKonl+bMwFnbyw/8eY5SRcrihf87rZlvzVkXcX59XsFvoXWQRXGPp0kuwaWv7r6L5pyrZg8C9ZaUc7nb50AkhJVsDNBRS0q6mhjkminXUhYCNuTvx8oV3BtnM1aMhFJ8cSW7Tuoax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S57f1If3; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S57f1If3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Uy
	n/Lka8S3gM+4HEByvvtvMTl4Ui6G/FFpRbBF0ufTU=; b=S57f1If3/GXyRwyyOu
	je0QSvb+8JA8e4SnFM/5d7dcetoBKHrzZIqiRcYaMZD8HGmvz5OKxTqb7stenXBn
	AqfQUjCpSB3KtIJBWwGc4Nenh/2rB1rvJZNYfTMXTMMIKcRP+xELJFd5WY3kG6bk
	3noaHQHyGf72r/L+i71wIfoPA=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCH7yys215q7xSBHA--.9530S2;
	Tue, 21 Jul 2026 10:38:36 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: justinlai0215@realtek.com,
	larry.chiu@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH] rtase: fix double free of multi-frag skb on DMA map failure
Date: Tue, 21 Jul 2026 10:38:36 +0800
Message-ID: <20260721023836.6691-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCH7yys215q7xSBHA--.9530S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw17CrW7Zr1xGry5AFWDJwb_yoW8GF47pa
	y5C39rCFs3Gw4UXan2gw4IqF4rtwn3trWYgFWFk3y5Zwn8Ars7CFZ8Ka9Fqry7trWkCayS
	yr1Yy345u3Z8KFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5Ef5UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wxUI2pe26wa2QAA3Q

From: Yun Lu <luyun@kylinos.cn>

In rtase_start_xmit(), when the head buffer DMA mapping fails after
rtase_xmit_frags() has mapped all fragments, the error path clears
the fragment descriptors with rtase_tx_clear_range(), which frees
the skb through the last-frag slot and accounts tx_dropped. Control
then falls through to the common error label, which frees the same
skb a second time and counts it again.

Return right after clearing the fragments when the skb owns frags;
the no-frag case still drops through and frees the head skb once.

Fixes: d6e882b89fdf ("rtase: Implement .ndo_start_xmit function")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 255667775f0e..67f7fdada119 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1426,6 +1426,9 @@ static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
 err_dma_1:
 	ring->skbuff[entry] = NULL;
 	rtase_tx_clear_range(ring, ring->cur_idx + 1, frags);
+	if (frags)
+		/* the frags were cleared above, along with the skb */
+		return NETDEV_TX_OK;
 
 err_dma_0:
 	tp->stats.tx_dropped++;
-- 
2.43.0

