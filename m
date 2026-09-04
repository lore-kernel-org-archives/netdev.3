Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C33E51F9
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547063; cv=none; b=B6QN7ZrDyx+USjtA63NqiAQsXqxoaBlhhueaKkBpeokp4uCFCMM+/TD0OW8isSfqC6UXYS43rU22s3LhhltK84bDCBtIW4qdeJ/Ci+PeGErfpFQw1ho791ljUD8ADG+vuPWENSHLvsF5x8zajdS1hp16xhhXdjG8sKdjOJU8JZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547063; c=relaxed/simple;
	bh=dbrsGx7Z1JZFuEt3GzNTe3o3ow+LgppRDQf4cQvzgm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DgyXyca9s/wJpF6MlWBxEeSbsuzJ53ojxQcz8lgNTXrDloXF3qedxDAI22IkWTkdvNIkwiyeLi9EHLnXcHIwsAog54bwNegh+uHkKj3rWiKYzNo5+snsh4Y1nxZysc1gd/Zhr/N9g5CTvSX2gQXoF/A7KNkQcWHbBld6b8cRA8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngVn+J/W; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngVn+J/W"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1670dad7a8so206761566b.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788547059; x=1789151859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2DA3mdpg9p97zW+otya7y9pg3R+tiPiEPhqbCYleRUY=;
        b=ngVn+J/WdeF6VDEL+Hk3AX9f4+yRfZ/htisr60xn0TPkAZ/ysZHWlC2ubVp4uXBsiG
         R05GJasX5XUeH3uiXJQ1AGmzrOMulTbY7+XoT+zINgTmIiGlrg0X54Pmg99DtxjyejO5
         yoyLLv+ehDPdmakBjkNj+x6HAzG9VLjdUlpgPjhXW2XOAjqNZagiwKC9w96vOkm6ZhcX
         dxguN3aSaIHR6qH7A7vLkFhIu+q0NQTSQw8MXEzT4Gw7YCoeFuMWiuxSRGpLH/G1zqJ5
         wp2Z7RULO6SGSlxI2hyDvz+/WMx+XyclLZ7Db88HVNoSUtpj7DS6Wr6cFvjeZEVDMsFh
         me0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788547059; x=1789151859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2DA3mdpg9p97zW+otya7y9pg3R+tiPiEPhqbCYleRUY=;
        b=Zia3avErFpi0AlfOXQU6qHTWI8ApzSqTJ+q/+WWKpis8nEUWgGEoz7jCrJOKIyiS+2
         qKMIe81q2A3v+fi6JypzdP9vHCuF2WbxL/YvwyFtbcKd+eXChsCwizWvVxxMbYb7uFqB
         qqUJhah7t1G2f+dP2C4+/jWha4WE9Q82qJ2RWCwtd09I/V9hu5zGaIcde+8vGCE/QsoM
         c36kcKzzFC81EYmQDRSH2UO5amIvW/WqJXvdUgMmb8zDAtR0gmqa3xfyWzWhugE+7Wnz
         Fe7wvuz7lpSA9D7F7JodlOO+eE1CVBRrW8mbJo1qhMrKNNeeq5x4jbjSgslfXSKoWtab
         QeZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAtr7kiYj1ETqB39VAHVApZEIwCFtbEtquHMXTfsfp5UanpbFNM2C6BuUOp0BWcqkAhVkQdGg=@vger.kernel.org
X-Gm-Message-State: AFuF++nS4EE5zqPArUiBMia8/LqVGnzPScvfAYpamZBCFunyNxDdl/RJ
	5Xg9crSb3NUWo3KewlKs73HcAdTrtzIJcgyXvfcVg09uKGsjYyMCpseC
X-Gm-Gg: AYBFou37vIeXcc7cYc0MIh7TvRikcF427Nkcxz2qErixgNCeCMS72KvAqPRyQp2WD8Q
	WzpL6PdEZ8PBokkEfAcvHE5Na2wfQA5NCVDj21qJgFkDtaJURhqQMfqmO4qI9yW0d72Wa2zQJIc
	TCyFc7B63zAMO4Ok942ksZAMwmm6X5zp9Qhyat/RwjasVI6NCDNEirUHH+CUFqDDlQXY3EgV2Xn
	VHSUWKwWawJ3JeniqC8Q+8VwoCt1L9rOP1nh4hyj0OCIkwxXlLbg/KaCQdUG/9GnGfWvSdHTfVD
	EBeWbD4WwiFBOhYwYFREgaurnmXCwgnwaJ7segovit4v5Vnd2fnMsthJ8TI/s9zR47zDeZfTuCW
	2uSj0xgtwrXazi8YWPmFbl5r3OI5X0NzqZP54MSHS3JpMc4Z/mNdL6IoHsq0GSD+J/3wuXoJZdV
	G+WxHJIN4oWHrIsSh5qXk0BAY3S1h4JUaVpS7DliKAL74qPsWh8ksv4RODxe18LSDpAK/j7360x
	ZAWq20aqTiGdskchKCtTg==
X-Received: by 2002:a17:907:7b88:b0:c26:19de:9131 with SMTP id a640c23a62f3a-c2619dea19emr210144366b.36.1788547059113;
        Fri, 04 Sep 2026 11:37:39 -0700 (PDT)
Received: from localhost (78-2-18-104.adsl.net.t-com.hr. [78.2.18.104])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d52dbc7sm142564066b.29.2026.09.04.11.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 11:37:38 -0700 (PDT)
From: Dmitry Sinyavin <sinyavin@gmail.com>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Dmitry Sinyavin <sinyavin@gmail.com>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4] net: wwan: qcom_bam_dmux: account network packets
Date: Fri,  4 Sep 2026 20:37:37 +0200
Message-ID: <20260904183737.2994139-1-sinyavin@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BAM-DMUX data path does not update the network device packet and byte
counters. As a result, userspace sees zero traffic even while packets are
being transferred.

Use the standard per-CPU software statistics helpers. Account transmitted
packets after the driver has prepared and accepted them, before returning
NETDEV_TX_OK. The asynchronous DMA completion may run after the network
device has been unregistered. Account received packets after removing the
BAM-DMUX header and padding.

Fixes: 21a0ffd9b38c ("net: wwan: Add Qualcomm BAM-DMUX WWAN network driver")
Signed-off-by: Dmitry Sinyavin <sinyavin@gmail.com>
---
v4:
- Move TX accounting from the asynchronous DMA completion to the transmit
  path, avoiding access to statistics after netdev unregistration.

v3:
- Count packets discarded by the transmit error path.

v2:
- Read the TX payload length after unmapping the DMA buffer and combine the
  network-device checks.

v3: https://lore.kernel.org/netdev/20260902124506.363174-1-sinyavin@gmail.com/
v2: https://lore.kernel.org/netdev/20260831181006.1382372-1-sinyavin@gmail.com/
v1: https://lore.kernel.org/netdev/20260830085400.2542956-1-sinyavin@gmail.com/

Build-tested for ARM with Clang and W=1 using allmodconfig and allyesconfig.

Tested on a ZTE MF283V with an MDM9607. The modem registered on LTE and
three 32-byte ICMP echo requests increased both wwan0 RX and TX counters by
three packets and 180 bytes. Bringing the interface down afterwards produced
no DMA, BAM-DMUX, or kernel fault messages.

 drivers/net/wwan/qcom_bam_dmux.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
index cc6ace8d6437..03360301c8ee 100644
--- a/drivers/net/wwan/qcom_bam_dmux.c
+++ b/drivers/net/wwan/qcom_bam_dmux.c
@@ -335,6 +335,7 @@ static netdev_tx_t bam_dmux_netdev_start_xmit(struct sk_buff *skb,
 	struct bam_dmux_netdev *bndev = netdev_priv(netdev);
 	struct bam_dmux *dmux = bndev->dmux;
 	struct bam_dmux_skb_dma *skb_dma;
+	unsigned int len = skb->len;
 	int active, ret;
 
 	skb_dma = bam_dmux_tx_queue(dmux, skb);
@@ -357,17 +358,19 @@ static netdev_tx_t bam_dmux_netdev_start_xmit(struct sk_buff *skb,
 		if (!atomic_long_fetch_or(BIT(skb_dma - dmux->tx_skbs),
 					  &dmux->tx_deferred_skb))
 			queue_pm_work(&dmux->tx_wakeup_work);
-		return NETDEV_TX_OK;
-	}
+	} else {
+		if (!bam_dmux_skb_dma_submit_tx(skb_dma))
+			goto drop;
 
-	if (!bam_dmux_skb_dma_submit_tx(skb_dma))
-		goto drop;
+		dma_async_issue_pending(dmux->tx);
+	}
 
-	dma_async_issue_pending(dmux->tx);
+	dev_sw_netstats_tx_add(netdev, 1, len);
 	return NETDEV_TX_OK;
 
 drop:
 	bam_dmux_tx_done(skb_dma);
+	dev_core_stats_tx_dropped_inc(netdev);
 	dev_kfree_skb_any(skb);
 	return NETDEV_TX_OK;
 }
@@ -402,6 +405,7 @@ static const struct net_device_ops bam_dmux_ops = {
 	.ndo_open	= bam_dmux_netdev_open,
 	.ndo_stop	= bam_dmux_netdev_stop,
 	.ndo_start_xmit	= bam_dmux_netdev_start_xmit,
+	.ndo_get_stats64	= dev_get_tstats64,
 };
 
 static const struct device_type wwan_type = {
@@ -421,6 +425,7 @@ static void bam_dmux_netdev_setup(struct net_device *dev)
 	dev->needed_headroom = sizeof(struct bam_dmux_hdr);
 	dev->needed_tailroom = sizeof(u32); /* word-aligned */
 	dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	/* This perm addr will be used as interface identifier by IPv6 */
 	dev->addr_assign_type = NET_ADDR_RANDOM;
@@ -533,6 +538,7 @@ static void bam_dmux_cmd_data(struct bam_dmux_skb_dma *skb_dma)
 		break;
 	}
 
+	dev_sw_netstats_rx_add(netdev, skb->len);
 	netif_receive_skb(skb);
 }
 

base-commit: 2188569e7e1b0bc3f3b557dc97ab7a02befc11c8
-- 
2.53.0
