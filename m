Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314422;
	b=Rsjesk1prvc2slOznan8x3Ha5bmL8G4az31lS4mbw/yiiL8NzGywbwNdP32q+mgcaNZQ
	 njKqcSClOFMcpsOS13iW9Okxq6YMi0HIca+3FuRdUei7ChYUwCIXzrJ9uolzCCuhQwIYk
	 /DUWb4cGBf4qx3SjPAG25Rgt/91Hu/EhR7hiH/Hk6jH5fIgrrs4BzW+tEfcsd0cp709m7
	 mPgnDthEHd0n1oJ+VplRfuXrnHo51+a7S0tqRZoouiK686jaNsJNBZS6+8Vhr/219UuCJ
	 3B4LJjDuY4LZVH1VcrC3GZh2RQueuXEcQ9b0DsFi3vCqclkIYDEmQhlJKv6fKMfDVZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314422;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=s1OQyxfD95E5WNGfUMbMwVtQoxYEAXTWm7roN9HSr+8=;
	b=swEw+ieZqCzZ7MXEUuxYC3AoJZRqQt27+sD65cGs8doYnREN3H9gZKv3BdCHz4Q5rGLR
	 e2mg7TO/4Z8UW+PPrpGBcQYJaUhC+tELZVqssfYg3LeVelfJYIkViMV8STU9NEUD69A5J
	 7QwMf0YuvEZaEfWPR3AGTuHMcQ5djHsEKr/IAbDiaMBDaHebnhWLyjUmvtg9AX520ECGC
	 Vyl1jwIanQzVHIFMG/7vOfGbkFPwjWdPNRwuQNj0FEiy12xOPND3KkpOK5TAQSe4fVm0+
	 yKMzJyHy/xCTLxSL9MFHyQkaa0JgYpj+S95sMEyB+VwQqwRlcej6s3LYH2gJnNtlW2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aOkIZCwW;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB7A60A2616;
	Tue, 10 Nov 2026 12:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EB7A60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aOkIZCwW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=s1
	OQyxfD95E5WNGfUMbMwVtQoxYEAXTWm7roN9HSr+8=; b=aOkIZCwWdQIExpC9lf
	1jP8aq/lEoXAiZN2lIKMF7l+ZugjjmgG0Q/Al5n7G9ir0gMdfAyBXFHMXISkIr71
	tpw8nR/RdJkVx0Lii4a+oFHDor5v/Cnjeq+4U/CKTGpbQy5TaSBndyamIqeyxB2B
	0Twci904XC+DhpHoY7xn3mKgo=
Received: from 4CV529F122.company.local (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3X4hjEPNqevk+Eg--.59821S6;
	Tue, 10 Nov 2026 20:39:19 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org (open list:STMMAC ETHERNET DRIVER),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: dinghui@lixiang.com,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com,
	liuxuanjun@lixiang.com
Subject: [PATCH net v6 4/4] net: stmmac: restore the XSK TX pool on resume
Date: Tue, 10 Nov 2026 20:38:55 +0800
Message-Id: <3ee93ddae82ebc7b5447095d12c4630963413b05.1794311618.git.dinghui@lixiang.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1794311618.git.dinghui@lixiang.com>
References: <cover.1794311618.git.dinghui@lixiang.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3X4hjEPNqevk+Eg--.59821S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF48XF1DCw48JrWkAFy7KFg_yoW8ArWxpr
	Z7Cayqywn7Jr4xZws8Gw40vFyFyayftF45ua4xJanxZFW2kFZIqryYvFWYvrW8Jr4kXr13
	tr4jkan8C3W5ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jV4E_UUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC0hi55WrzEHglVAAA3W

From: Ding Hui <dinghui@lixiang.com>

When suspend interrupts AF_XDP zero-copy transmission, resume releases
outstanding TX buffers through dma_free_tx_skbufs(). If it completes XSK
frames, that helper also clears tx_q->xsk_pool even though the socket
remains bound to the queue.

The resume path does not run the TX ring allocation routine that normally
sets this pointer. Consequently, stmmac_tx_clean() skips XSK transmission
and a running TX-only socket can stop sending after resume, despite the
link coming back up.

Restore the TX pool from the queue's existing XSK binding after releasing
TX buffers and before restarting DMA and NAPI. Keep the buffer cleanup
helper's behavior for teardown unchanged.

Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
Signed-off-by: Ding Hui <dinghui@lixiang.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 99e46174741e..140b95f767fe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2280,6 +2280,9 @@ static int stmmac_resume_descriptors(struct stmmac_priv *priv)
 	for (queue = 0; queue < priv->plat->tx_queues_to_use; queue++) {
 		stmmac_reset_tx_queue(priv, queue);
 		dma_free_tx_skbufs(priv, dma_conf, queue);
+		/* Buffer cleanup may clear the pool; the socket remains bound. */
+		dma_conf->tx_queue[queue].xsk_pool =
+			stmmac_get_xsk_pool(priv, queue);
 		stmmac_clear_tx_descriptors(priv, dma_conf, queue);
 	}
 
-- 
2.34.1

