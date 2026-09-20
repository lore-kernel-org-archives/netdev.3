Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B15D4F5E0;
	Sun, 20 Sep 2026 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789875454; cv=none; b=WxjQPOQ+OmEkyfD18PtZjlG2eut29xkOIa7by5xf7i8G3BL4P9TAkj5BLUX5eN0AoQ6Fvndsg1aUgdLDL48Pyw06EEBjhW7F6tIL8dT+ozzSA5RPVSYWvmI40h49VoIpgXs4UVn1YS0YA148yLGI3gMAo0Uy1d/9ndbPIroYRiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789875454; c=relaxed/simple;
	bh=mo0ahd/joszVMCHdlgm1xW6x2Mnd4Uwk1LSGs0Ir55w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YpESa10OkGTj4++gJphPYnSg4cTtgSbalRUAP/oba8oMusawzE0R3nIQncFrwxLFYemZQLdLu7FDDtZIF3RySPsS+M6UgFQtsDTMJSbl69QZcffxYD8KLx4gROuuOBDNMYm9yg6bjwFf+QIb2XNzfMKU4ws4U+Up1J2Gox72Lxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BYEHnCwO; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BYEHnCwO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ZG
	+mDsbpJrojv5EOAhvPgRD7J+oeN29xvYJoRg81qNs=; b=BYEHnCwOsP5y0RYetp
	v0s/MG7KEUUf5M49X6dds2Il2q3oyEwnyVWeUn3JNzxvAepx49aUGXb3nnopvwu2
	i8dpc3Q5jSJUxtFQkS4zIo6Bky3V72KkOe2g8xItHqGYGNzvxjitEdgwlWp6NBcg
	BYPYvsAad7MLf2gL2h5xELCLQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgA3aMLLVK9qbz1RAQ--.43010S2;
	Sun, 20 Sep 2026 11:36:44 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: shenjian15@huawei.com
Cc: shaojijie@huawei.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaojiangfeng@huawei.com,
	horms@kernel.org,
	hppiscas@163.com
Subject: [PATCH net v2] net: hip04: use 16-bit byte order for HI13X1 TX fields
Date: Sun, 20 Sep 2026 11:36:41 +0800
Message-ID: <20260920033641.13590-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgA3aMLLVK9qbz1RAQ--.43010S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr15urWDKFW8Zry5XF48Crg_yoW5GF4Upa
	1DCay7Cr1Uuw13tF1v93Z2g348uan3Gry3Ga15u343ur1ayr18KF97tFy5CFyUtrs7AFsF
	g3yFva93AFs8K37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYoGQUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxQzOl2qvVMxfxQAA3X

The HI13X1 TX descriptor stores send_size and data_offset in 16-bit
fields, unlike the 32-bit send_size field in the other descriptor
layout. The transmit path nevertheless converts both HI13X1 fields with
cpu_to_be32() before assigning them to u16 members.

On a little-endian CPU, the conversion moves these small values into the
upper half of the 32-bit result and the assignment discards that half.
The descriptor consequently loses the packet size and cache-line offset.

Use cpu_to_be16() for the two HI13X1 fields. Leave the other layout's
32-bit size conversion unchanged.

The issue was found by our static-analysis tool.

Fixes: d413779cdd93 ("net: hisilicon: Add an tx_desc to adapt HI13X1_GMAC")
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jijie Shao <shaojijie@huawei.com>
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since v1:
https://lore.kernel.org/all/20260905132958.63085-1-hppiscas@163.com/
Use the full author name. Clarify the HI13X1/little-endian scope in
response to Simon. The finding came from source analysis; there is no
established explanation for why it remained unnoticed since 2019.

 drivers/net/ethernet/hisilicon/hip04_eth.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index fc2c47dcfaab..2920985144bf 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -527,13 +527,14 @@ hip04_mac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	priv->tx_skb[tx_head] = skb;
 	priv->tx_phys[tx_head] = phys;
 
-	desc->send_size = (__force u32)cpu_to_be32(skb->len);
 #if defined(CONFIG_HI13X1_GMAC)
+	desc->send_size = (__force u16)cpu_to_be16(skb->len);
 	desc->cfg = (__force u32)cpu_to_be32(TX_CLEAR_WB | TX_FINISH_CACHE_INV
 		| TX_RELEASE_TO_PPE | priv->port << TX_POOL_SHIFT);
-	desc->data_offset = (__force u32)cpu_to_be32(phys & SOC_CACHE_LINE_MASK);
+	desc->data_offset = (__force u16)cpu_to_be16(phys & SOC_CACHE_LINE_MASK);
 	desc->send_addr =  (__force u32)cpu_to_be32(phys & ~SOC_CACHE_LINE_MASK);
 #else
+	desc->send_size = (__force u32)cpu_to_be32(skb->len);
 	desc->cfg = (__force u32)cpu_to_be32(TX_CLEAR_WB | TX_FINISH_CACHE_INV);
 	desc->send_addr = (__force u32)cpu_to_be32(phys);
 #endif

base-commit: 518e5b794c06c0f0eb40df3e202274a66202c137
-- 
2.50.1 (Apple Git-155)

