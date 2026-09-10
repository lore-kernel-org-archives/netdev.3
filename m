Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691C343887;
	Thu, 10 Sep 2026 05:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017641; cv=none; b=dviifYYD5VN3vbxc9lo7h4C9a3XTZ8wplFxy6Qbg9lq3Uxe8og8xqHT89daH9Om1F0HH/NXzSJ+EwTZOCevL9ba/kQ058nHFc4BtLy82u9tOXNGFERhuaNGHBRS5c1FTYpfWxeAjIzHDQFdhe9RtK/mE0gHFdOL8mmu3kbMsE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017641; c=relaxed/simple;
	bh=bxiJni1pfImDDM11Ii2XeuDiBA2kQS2GBBJZlGOPF3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=brZgbZSNsIqtQT7P2GyD2TIFsV5sAVSdCB1MBO3/Y/bnFKz+zqnCfF5I4KeON6cPJohngzJk1/faQn4ssJVjL09CFnxtZUSA3AjkCeOhrWpmVe0/kg3TcL3VggldeTz7t7URuVeB2WAFQ0h1ZhJGq4zkep1XHIsVOEEBzAIRN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=U15qeieQ; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="U15qeieQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1789017619;
	bh=DsZOltiP1R8W8vsyrS5UrPX+wRdKVv3/djndYWU1II4=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=U15qeieQsFu3gsb4LFFHvNYLyS/pQMqehrogEqnWMZ6JAuUAGdQYSMZl8P5dw3GGD
	 dgzZfgF0jknJCOck+/Y0ZPcE5gylC3nxxKlGeqfVB8e1yVZvPdJmYEP16pd6QZl256
	 QDIsDQCHK1n6Jh1jsR1eVWab060PeE55CN2dMSLA=
X-QQ-mid: esmtpsz19t1789017609t8b058a96
X-QQ-Originating-IP: DUmqSkz4nEReLFqUyWpMium9HE3atKEqluVbWzOIZ6Q=
Received: from [10.10.7.69] ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Sep 2026 13:19:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6560279084322675743
EX-QQ-RecipientCnt: 14
From: ZhaoJinming <zhaojinming@uniontech.com>
Date: Thu, 10 Sep 2026 13:19:44 +0800
Subject: [PATCH net] net: stmmac: fix stale descriptors and DMA mapping
 leak on Tx map failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-stmmac-fix-vlan-desc-leak-v1-1-6b07dca5e5e8@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAO89omoC/x2M0QqDMAwAf0XyvEAU7HC/MvYQ2ziDWqWRIhT/f
 WWPB3dXwCSpGLyaAkmymu6xQvtowM8cv4IaKkNHnaOBBrRz29jjpBfmlSMGMY+r8IIT9c9xJNc
 GZqj9kaRa//cbopzwue8fTPoWLXAAAAA=
X-Change-ID: 20260909-stmmac-fix-vlan-desc-leak-f057bb061daa
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>
X-Mailer: b4 0.14.2
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: N2K7JO7TcIoEXORpfNom9UCEKAHIG1ooxo1cYntwkOz7215O66a+8bOQ
	phZapzVqBS5x2RfkgpwInRi/Yp5qPkALWWMkGc8PhpCiqHuRgfwxjBdM4bw7oUOTRQMMNFs
	IruM3ZdvO3HpM5D5WnzCQyTfi/sjBG9qT44aeNQPCOYw6MXSeDuKL8Iid9tsrmZ4ylfKGBA
	5S8BYBeqvcS58QCy8tpTzFJyA4FKsEq0RCwSHlnW2WbOesGIqt/S7bhYbnyyzw5fXOHIstQ
	81oIN26cPWFxNoQ9rxyeVymjbuyU8etvf5YLX4ZLoUsnbGjZWhS5Gh7otBjSdFSB2nY6ngD
	flBKNlwLNdrDdG/b19J1mu7HmGDmEAz8CUn+wKKBf/dlNiePIojxMfUAsqPyxkgqAZ9d9X0
	RakfevUWgIqqYGjAA/tTLn8AeVKCj2HI2zEM70vblUvrwg0fcQHfvRSnL11dpsUVTgm+qy8
	SVphzTvBnyvvj6q6pH1ONV3pCmopkPB2KP8Q6eopKPWndJeRfRf6ILXi2r22gtNU6J2TwGK
	nBAWPhhxQ6pTQwaDfrZBKNUURwJ6Y8OTuzusJblvPspNrMUiu9i9RnN8FerlSm/iJxnHSkG
	Tb2AYesm0z6wnX3WqQj06DHvMXLGayyDILz//v3iurzMepGGjP4YcLxEl7jHjSATtvmD/su
	HbDkgzi7mTUd1aMFfeZsr0kDMvE2rBPEDSGKPVN+ds+WOIEdOQZvyCsDuJibwWc92D/FxIF
	bC7AJwLqqV8xNq5No8Bt7zDSKfOOYfJ4rn3cAB+7UbBaPu7qLiT9TR/CXWqfCVA0nufI4Bx
	8vn7q+Oujh71796GypOXGdBlF9QAwT63VC5vQHp9ouy/Kbk+Fi1hTEe7jhRDaZDrwjFC8VH
	RjJ/BOjSEl93ayJYtU3SDoRFE+g8DCE5xaqUBv8E2FE+MP9BdemhZQru/WpXBax+4QXOtA0
	Wwa46U2oPCcn8RUYRGUesmZwdQnKHL1GC+Tcru4Kz8cPxi3zO6YCsgM3EZbgx2dUiuO/WVc
	gnKC/mC7+BKmtJKW8TnSEas+ZZw9c=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

In stmmac_xmit(), when the DMA mapping of the linear part or of a
fragment fails, the error path only frees the skb.  This leaves behind
the DMA mappings already created for the linear part and for the
fragments mapped before the failure, which are never unmapped.

The VLAN context descriptor programmed by stmmac_vlan_insert() is also
left behind with its OWN bit set while tx_q->cur_tx has been advanced
past it, so the DMA engine later consumes the orphaned descriptor and
applies its stale VLAN tag to an unrelated frame.

Release the descriptors and their DMA mappings in the dma_map_err path
with stmmac_release_tx_desc() and stmmac_free_tx_buffer(), walking from
first_entry to entry, then roll back tx_q->cur_tx and release the VLAN
context descriptor.

Fixes: 30d932279dc2 ("net: stmmac: Add support for VLAN Insertion Offload")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 29 +++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 24656b35350b14454fb10deced6516eb89e2c0c9..2e36c27e2cfb436af3566cf1c3e70d32ce9830a0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4769,12 +4769,12 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	unsigned int nopaged_len = skb_headlen(skb);
 	u32 queue = skb_get_queue_mapping(skb);
 	int nfrags = skb_shinfo(skb)->nr_frags;
-	unsigned int first_entry, tx_packets;
+	unsigned int first_entry, entry, tx_packets;
 	struct stmmac_txq_stats *txq_stats;
 	struct dma_desc *desc, *first_desc;
 	struct stmmac_tx_queue *tx_q;
 	int i, csum_insertion = 0;
-	int entry, first_tx;
+	int first_tx, ret;
 	dma_addr_t dma_addr;
 	u32 sdu_len;
 
@@ -4832,9 +4832,10 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	csum_insertion = skb->ip_summed == CHECKSUM_PARTIAL;
 
 	if (unlikely(is_jumbo)) {
-		entry = stmmac_jumbo_frm(priv, tx_q, skb, csum_insertion);
-		if (unlikely(entry < 0) && (entry != -EINVAL))
+		ret = stmmac_jumbo_frm(priv, tx_q, skb, csum_insertion);
+		if (unlikely(ret < 0) && (ret != -EINVAL))
 			goto dma_map_err;
+		entry = ret;
 	} else {
 		bool last_segment = (nfrags == 0);
 
@@ -4984,6 +4985,26 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 dma_map_err:
 	netdev_err(priv->dev, "Tx DMA map failed\n");
+
+	/* entry points one past the last descriptor written for this frame:
+	 * on failure it is the descriptor whose DMA mapping failed, so walk
+	 * from first_entry up to, but not including, entry.  Reset cur_tx
+	 * unconditionally as both stmmac_vlan_insert() and stmmac_jumbo_frm()
+	 * may have advanced it, and release the VLAN context descriptor.
+	 */
+	while (first_entry != entry) {
+		desc = stmmac_get_tx_desc(priv, tx_q, first_entry);
+		stmmac_release_tx_desc(priv, desc, priv->descriptor_mode);
+		stmmac_free_tx_buffer(priv, &priv->dma_conf, queue, first_entry);
+		first_entry = STMMAC_NEXT_ENTRY(first_entry,
+						priv->dma_conf.dma_tx_size);
+	}
+
+	tx_q->cur_tx = first_tx;
+	if (has_vlan) {
+		desc = stmmac_get_tx_desc(priv, tx_q, first_tx);
+		stmmac_release_tx_desc(priv, desc, priv->descriptor_mode);
+	}
 max_sdu_err:
 	dev_kfree_skb(skb);
 	priv->xstats.tx_dropped++;

---
base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
change-id: 20260909-stmmac-fix-vlan-desc-leak-f057bb061daa

Best regards,
-- 
ZhaoJinming <zhaojinming@uniontech.com>

