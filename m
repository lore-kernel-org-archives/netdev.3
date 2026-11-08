Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794162728;
	b=4wY8PhpBHsj3pTGEZ8lYEi9ygFddympP2/A+8wo3kAPByslAgAb/yqnjhPhrWqiIS5Bf
	 JGIm6RFRQQvTkKxUx6kiiaWUhY+X6kYy2IHB3cGjjMJ+4ILbMtbzwdaWDstFY2fM9KNhl
	 Qydq/uozHedLthvCQJVRdwmdw++SMitdaLeOvIQAccpT0gKlB8H2rW2vJTFumBcpeV5td
	 WdKVBw517Wb3rJFpqnEZrRzzucTAtK4ixd5MBxnJBjAG9m1rgxtpNsibOJi6Q31s19HbJ
	 WplMEsjY8Vdm1g6JSTliWq9SO6XOL15JmeyAqpkaP4aTCIb/uzOu1/Pg/qepMv3beBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794162728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ne4a4cFR+Swe51cblyaim6Ifl0mbkjVxPPICo0J0BlY=;
	b=QxXlhpOuUhztujOTvYonwKOlLX9m3mu2AgrBN+AF6k2wTufhQhmGfoP+mx78O6PhCKrZ
	 k6KbU8pNlDdY8JRofGm9jpNbxNe/dUNBp8AlUMSgJa/aTm0h48aDylNvYlA2U97X8y0nh
	 bcrFo7Z/wxs9Fda7NbBX/zSGMdIYUyRSksfYCqaAUBQToKEFxh80aK+w+WcHxEMIVK4qQ
	 z2ogvDtkhphP3cFwJqsgv8RYRyukKBR5GrI4mh8p2tU2nzBKJO14jSDE16z9K0LHBoulc
	 JUxJTaIdHdRPC5/w/39oPWpBDRt3JJA22oFen3sRH5gTJWVuJbeIsbO4WBz7RO45fcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sxRA07V8;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C3606A332
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 18:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 520C3606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sxRA07V8
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd3310348d2so107662a12.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 10:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794162727; x=1794767527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ne4a4cFR+Swe51cblyaim6Ifl0mbkjVxPPICo0J0BlY=;
        b=sxRA07V8K1fDu8MxNg12Vj3Qc61INJdsm49M6Vk8k0Bq58QC5xo+PfXQxIYdGujQ3q
         cFMUHuphKGnWAeuxa9MJqAkJph8y21fouxw5L/u8idZoLrw2QjaG0WTht2s/XvKJRwHU
         iGvIjYkSlhBQFZYGVXycLLUxURN947Bdq/0CmmL+cv5WirglAW2KtG5MuTyhtucslw5D
         sG3ZyN+ywcIk/ng+POIuhxumyQhSj1C++sVaeP+gwI3nY5XPwFSsbh9J8XcRqQwD2lum
         OmS7gqzBp3NaDWd+ZLb3fr/AeDVIaCSvADiUmXO1/vIY0LTkDder5NVc9hljtGnqHOOX
         B2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794162727; x=1794767527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ne4a4cFR+Swe51cblyaim6Ifl0mbkjVxPPICo0J0BlY=;
        b=j6CqcIIY+2IsEYQnpuRGGuAFHnWIqHPqEzteZybalSFLa3AIKszHbgPpGpZalLVmTR
         vbITbE1lPS9GCwVitfJTC99+CljITUFBb66uX9FapZ7p1jTMbbuvZd4Tov4miSOm3BlK
         feOZ6c3dhSUn85UPdMDtXv9BxScSbBm7cqw1rcfsjJF/6yqBxoE/m9I0ldPTf+zYp6NB
         scGcguJ1xmQ5ddkuGyVDBsTmLtDAJ7sNfH63sXVZTKymaNuazu4wz+veSTe2Z9B9Ver+
         sP/ormOeAl6WORGn6t5qzk34Z1KMo4KJBSqIW2o0iRNgiJeKBFWAXRoPuvzXTk0G2NDb
         7B3w==
X-Gm-Message-State: APuU4Z9nqPLIpQmuX2t9AEBgOTf7Yvlibx9csnya82yjkY9rZajrhMs9
	K2DR1qCDM5H+yCisoLTlwaj7BEwhzazINVQ4wt2V2pwtpN2s77xkP2IBOUfZ5g==
X-Gm-Gg: AYBFou2C2GtFb6Ea58dxAunQjh4NFYSSrJeDGw0h99lVfFKZQpXe1F65Lv5+E2EwsB2
	Z0FYnK0ZEpV0ZIkNdSBlDKfEewxum+sM/N3k//BFpJ5c9sjREK47kiw+XIN+0mCuDRAhWQsKb4w
	SojRZxaTkeXrjay03EDik+OEl8WrnzinGLH2TphV+1wNS8DH3eGYH8Jikzflm0hPEubgROt7dJ0
	9bZHj9PniwV0ZmHejgwvprUHisPzR6t3qlW4Gu8xjOqgCUVAF0iJJbJ1/EE4NvfHrd+RMq12zSV
	LGHqnltlafKa+rEyknAvsgMi4YxOJ6W0+nv5GEhx5MGZJQZjF4nGqwD/tLtwdDnfdvdZG1CEE89
	U3WpG0gepmzUpDrr9RQF704d7SJMAdokPm5pWenfIrFGiH9lbmAdVT6rq2BkfWGwbO58FXB8lnn
	sTEOvemdhajMVRFV4EhltTNkGeiOe+GxrEKla6ZcXIO7mXmyUlyd2OtCvfJIuBxPSRZHClw1Sf8
	ImsfFbBJYFDXfoe5lH2pn42/tvxYTKJ96vGyHDWkBaMOSaaD4z+uylY2z63Dj6yLgqdoTRMNiyG
	w2eeHgbjpIlqujX3BaI1iWLKuS9hS5qwlrrg3D6CCp1gm99jp0lCF80=
X-Received: by 2002:a17:90b:3d8a:b0:3ae:3e9b:5265 with SMTP id 98e67ed59e1d1-3b12d4f77a0mr1174456a91.26.1794162727510;
        Sun, 08 Nov 2026 10:32:07 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm7600534a91.0.2026.11.08.10.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:32:06 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net: dsa: motorcomm: Fix stats64 error counter mapping
Date: Mon,  9 Nov 2026 02:29:26 +0800
Message-ID: <20261108182931.1542638-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108182931.1542638-1-mmyangfl@gmail.com>
References: <20261108182931.1542638-1-mmyangfl@gmail.com>
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

rtnl_link_stats64 wants aFrameTooLongErrors in rx_length_errors, and the
eth-mac stats already report the oversize counter there as
FrameTooLongErrors; move it from rx_over_errors, which is a RX FIFO
overflow counter.

Drop the tx_undersize to tx_fifo_errors mapping as well; a runt frame is
not a FIFO underrun. Report it as a TxUndersize ethtool stat instead; it
remains in tx_errors as an error not otherwise counted.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/mib.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index 6b170fc6e187..b8fe2c407c32 100644
--- a/drivers/net/dsa/motorcomm/mib.c
+++ b/drivers/net/dsa/motorcomm/mib.c
@@ -50,7 +50,7 @@ static const struct yt921x_mib_desc yt921x_mib_descs[] = {
 	MIB_DESC(1, YT921X_MIB_DATA_TX_PAUSE, NULL),
 	MIB_DESC(1, YT921X_MIB_DATA_TX_MULTICAST, NULL),
 
-	MIB_DESC(1, YT921X_MIB_DATA_TX_UNDERSIZE_ERR, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_UNDERSIZE_ERR, "TxUndersize"),
 	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_64, NULL),
 	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_65_TO_127, NULL),
 	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_128_TO_255, NULL),
@@ -366,6 +366,7 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *pm = pp->mib;
 	struct yt921x_mib_stats *mib;
+	u64 tx_undersize_errors;
 	unsigned int start;
 
 	if (!pm)
@@ -376,8 +377,9 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 		start = u64_stats_fetch_begin(&pm->syncp);
 
 		stats->rx_length_errors = u64_stats_read(&mib->rx_undersize_errors) +
-					  u64_stats_read(&mib->rx_fragment_errors);
-		stats->rx_over_errors = u64_stats_read(&mib->rx_oversize_errors);
+					  u64_stats_read(&mib->rx_fragment_errors) +
+					  u64_stats_read(&mib->rx_oversize_errors);
+		/* stats->rx_over_errors */
 		stats->rx_crc_errors = u64_stats_read(&mib->rx_crc_errors);
 		stats->rx_frame_errors = u64_stats_read(&mib->rx_alignment_errors);
 		/* stats->rx_fifo_errors */
@@ -385,7 +387,7 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 
 		stats->tx_aborted_errors = u64_stats_read(&mib->tx_aborted_errors);
 		/* stats->tx_carrier_errors */
-		stats->tx_fifo_errors = u64_stats_read(&mib->tx_undersize_errors);
+		/* stats->tx_fifo_errors */
 		/* stats->tx_heartbeat_errors */
 		stats->tx_window_errors = u64_stats_read(&mib->tx_late_collisions);
 
@@ -399,12 +401,14 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 		/* stats->tx_dropped */
 		stats->multicast = u64_stats_read(&mib->rx_multicast);
 		stats->collisions = u64_stats_read(&mib->tx_collisions);
+
+		tx_undersize_errors = u64_stats_read(&mib->tx_undersize_errors);
 	} while (u64_stats_fetch_retry(&pm->syncp, start));
 
-	stats->rx_errors = stats->rx_length_errors + stats->rx_over_errors +
-			   stats->rx_crc_errors + stats->rx_frame_errors;
-	stats->tx_errors = stats->tx_aborted_errors + stats->tx_fifo_errors +
-			   stats->tx_window_errors;
+	stats->rx_errors = stats->rx_length_errors + stats->rx_crc_errors +
+			   stats->rx_frame_errors;
+	stats->tx_errors = stats->tx_aborted_errors + stats->tx_window_errors +
+			   tx_undersize_errors;
 }
 
 void
-- 
2.53.0

