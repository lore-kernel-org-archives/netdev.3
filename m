Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDCD39E6CD
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788080045; cv=none; b=trpzNEKR9HjW2xf5qPhhApvpDwZ9Xbp+iesph2UUSGJIcemDlzSObY9LdSdpSvfuokWJavqnZmMRxYwObANfgRfWlCJAjn1RvswPU9J9Ny4MzAWhJrYT6s6hUOexVv1x50SZH0zNDf6lu9rkc8Ly6iA+fAH+WcdCDiiNYtoD19E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788080045; c=relaxed/simple;
	bh=SnV7qMnJnGGnA1tGCCTiRMQdf/6JklFHWRYohECXXDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PMIb0EFzDpJimQxi200U8hKOXi0/VzPnfYKhUEg1d1Gl7fB5F3qDcEgnd5o4u6HBBbeamBFZ/idTpcPfsev/8E85xwGqQoqoXaAiqw5i4MiYZ/phPRzQ+JCTtu1hUX1S4z1hOx/iNGQ26mjrXahqKqMj8lSo93GM5LfAll2CdxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/wr637Y; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/wr637Y"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1712a04ddaso394565666b.2
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 01:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788080042; x=1788684842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HQ5vBRYf+tr60JYXeTNkJIuGhQ+YcT7vQL2jhuUkKao=;
        b=Q/wr637YknOR1Itf4ex8GXbJC//sH6tUQwa/mW8pPrKVFbrH+6rGzSEaXSeEvnDsWJ
         4mmkLk75QZ0GI65QTcNe/Izf9tfciM9wHyJQ9Y8TIo3cX61iXP95Nnhaa9cmjVjxktHq
         JxmdF2bKfauYgX4Yeol5OjTSZcrvt93uuphpPKn/JHN/4vIw648ECFsBvV2RKIKR1PmF
         MYJ8VvyFlvUmMKMAwwOfS+iJY5CQDEy6Hk9Bgvjmv7NfmiCPL2TYdZu0N6oNQdzs2Kj2
         1rtxSjy9hN90+PHFe5NhXNSxgsctIgdfEDGRvgkoCi8DjHN2bf7eL9Hk8QFq8TYAV5ji
         Rlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788080042; x=1788684842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HQ5vBRYf+tr60JYXeTNkJIuGhQ+YcT7vQL2jhuUkKao=;
        b=XbI9gKPfmdo7ow66fbzCKinw298Anpf2Dyk1h5pyg2GLoQwXkGKV4UIwb6PcYa0QfJ
         MuTx1h1FtgTWwS9t/HhbedntpmrWl4GYbgN1PtwWJLku4pqb9bqTKUoKCg24OJVJLXZ/
         9SVvZQ9c47jrSXxIVwYK8akg/iWnZIV8FRx3Xvtk+LGLURMTTKWoH9svMqlACzFyIAfO
         mTO7J2FmN3ogeYi3TPB0cjtmQRz3xQ1XSa3MZafYxofNZv8fM9fLbMRVRSJLnf+h6pZC
         jHckQBFZb5iTkXa4gCod1me0Kl/0MZhjTY4XFpoz0wIFZRAvRcSf97XeTSxa6yn5uKnr
         6K1A==
X-Forwarded-Encrypted: i=1; AHgh+RoEw+XDb+2ApBbbMe8dNTzWYCDkMKqnXt18wFMw/3CCiRsPo2Jzsgjvog2c9wj2TVuWQ7Gr27I=@vger.kernel.org
X-Gm-Message-State: AFuF++ntArSAL5hCfp89FInpauSGtb+Ck9TxHpyCRtHT9BAeqcTGv3XR
	El+I6j6SEpOsDVHUBa0WU9oMNFZ89bUlz+cWwm+PO6LDMPgKczm42tFy
X-Gm-Gg: AR+sD12CFkIeg55vIwrd4SrDt05wG63bOPCgRm96zZUlDr2VtJm5GAvZqCqK7V1dVCP
	N0sEUqPeY1/UMSUJaclIpxMs1XJZY1kRie5a/hqU5Bfx+D9GK35MjNHs3UDtvg4RIXYjDL0O+0r
	ijf8wbtZPoIYBLhpCAlElCVcS0kcjH0v+YjkJZhlAOC9rZrpEQJf/HYFQayC6YjnPoBtZYJrgtx
	7PEiSHnwoRShNMXWnUxGP7AwBalB8shEHF6ZvuXKMrS66fmNLABR0PHOryHUX0hoFYf34dQVIEv
	p9dgsKNbUIIl9OkBrqngr9yT6hLtJteGhevqcu2wdZhlTDeD32epsUaDjJMXTxQjWhdI+1+49v6
	aqGlSy7J7PQ9rxIdNXNRhl519OAbqtHoo5hp5icGb6NBQkJuRp5zD/2LgMprOaKwoPc8/g4UdEg
	iBgToEWlr6aKBo1uvheTsaP5dnwmnIjgn3VzucOWRt0pDvQM7pfrX1kSdscrbsTMEMXKKNEHvj/
	Lp4Lvv6BYbDY3OtLhQ=
X-Received: by 2002:a17:906:7952:b0:c20:d90b:2cb1 with SMTP id a640c23a62f3a-c2556795d78mr1257354066b.0.1788080041834;
        Sun, 30 Aug 2026 01:54:01 -0700 (PDT)
Received: from localhost (83-131-188-112.adsl.net.t-com.hr. [83.131.188.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1b2049sm297331766b.36.2026.08.30.01.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 01:54:01 -0700 (PDT)
From: Dmitry Sinyavin <sinyavin@gmail.com>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Dmitry Sinyavin <sinyavin@gmail.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: wwan: qcom_bam_dmux: account network packets
Date: Sun, 30 Aug 2026 10:54:00 +0200
Message-ID: <20260830085400.2542956-1-sinyavin@gmail.com>
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
packets after their DMA completion and received packets after removing the
BAM-DMUX header and padding.

Fixes: 21a0ffd9b38c ("net: wwan: Add Qualcomm BAM-DMUX WWAN network driver")
Signed-off-by: Dmitry Sinyavin <sinyavin@gmail.com>
---
Build-tested for ARM with CONFIG_QCOM_BAM_DMUX=m using Clang and W=1.

 drivers/net/wwan/qcom_bam_dmux.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
index cc6ace8d6437..40c40bc5645a 100644
--- a/drivers/net/wwan/qcom_bam_dmux.c
+++ b/drivers/net/wwan/qcom_bam_dmux.c
@@ -177,8 +177,15 @@ static void bam_dmux_tx_callback(void *data)
 {
 	struct bam_dmux_skb_dma *skb_dma = data;
 	struct sk_buff *skb = skb_dma->skb;
+	struct net_device *netdev = skb->dev;
+	unsigned int len = 0;
+
+	if (netdev)
+		len = ((struct bam_dmux_hdr *)skb->data)->len;
 
 	bam_dmux_tx_done(skb_dma);
+	if (netdev)
+		dev_sw_netstats_tx_add(netdev, 1, len);
 	dev_consume_skb_any(skb);
 }
 
@@ -402,6 +409,7 @@ static const struct net_device_ops bam_dmux_ops = {
 	.ndo_open	= bam_dmux_netdev_open,
 	.ndo_stop	= bam_dmux_netdev_stop,
 	.ndo_start_xmit	= bam_dmux_netdev_start_xmit,
+	.ndo_get_stats64	= dev_get_tstats64,
 };
 
 static const struct device_type wwan_type = {
@@ -421,6 +429,7 @@ static void bam_dmux_netdev_setup(struct net_device *dev)
 	dev->needed_headroom = sizeof(struct bam_dmux_hdr);
 	dev->needed_tailroom = sizeof(u32); /* word-aligned */
 	dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	/* This perm addr will be used as interface identifier by IPv6 */
 	dev->addr_assign_type = NET_ADDR_RANDOM;
@@ -533,6 +542,7 @@ static void bam_dmux_cmd_data(struct bam_dmux_skb_dma *skb_dma)
 		break;
 	}
 
+	dev_sw_netstats_rx_add(netdev, skb->len);
 	netif_receive_skb(skb);
 }
 

base-commit: 2188569e7e1b0bc3f3b557dc97ab7a02befc11c8
-- 
2.53.0
