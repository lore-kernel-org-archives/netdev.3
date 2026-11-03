Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713635;
	b=QjanOf04EaCEms1zTFwuuzyAq1LZkc2ryWrOETJTOUmfI502jb2M5ZCfhoiYsqmnsHpH
	 OcvGE0nWjWXLxOobtaBb4ITsDpS5t20+HITkUrdmyYLAdJvhVgUB0UNi8QoJYDajWr9EF
	 BH+I73xhsymuY0fCTtX1sE3gXpu+ZWAzhFZmmLkLBvy5pW2/AWnX8dzRivqKA1v1KTuMe
	 0IIyPQMSuMS5lIeinNamXv3o8tX4KHqnRPwSnD1Veiq77lqaoz6T+SjE/nrrXQ7ljTUP6
	 mOXYtT2vv3/k3AtkNlVSoMAnRtzkpDeF4iRRudy6nYv7SDm7ijqjT14B9F40603/0Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PKjWRUzPQ/AfOjwLbgBl9OKiNXSCa4wej4PtIGjwOlI=;
	b=B0FrVRj8CK38MT0lVNcjq3WuJXhcR/eYxsYzJH4/nwewvMq8X9CHrhtl6bOHnJDa0DFD
	 uHoxMnvOLZ8m3M+kdP/flDej85tq3I5C9D0ToJZTFfTl/hZI5FgDcTm1Q/IW9kwFvnfq9
	 ny9toFF3tZPNIl4ldu8ooVzq2mIONHvnIJerph1g5Tsepx5WRPirRWZWIXWH3vkc9gs7M
	 2M5uGsg1zwqUSAKD53kbBw5a+LoDTaOOnFP7en3nCtPjpDnq3M0H0/hXuqKyWvnkhech5
	 82Bj5PPNRWSnyCsiXVH+GHb10mld070wIhqgTSf+WwyLP4ZAd9FNb+/XiBoE6JRx4qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D7PEmlY5;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9980B606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9980B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D7PEmlY5
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-89ff475a152so1466933b3a.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 05:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793713634; x=1794318434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PKjWRUzPQ/AfOjwLbgBl9OKiNXSCa4wej4PtIGjwOlI=;
        b=D7PEmlY5k7wOC+F0nZP+WRt17y704Pn0Gj0t2m24022le2/m3TEQLsk3WgGjQxjKI5
         AT4wap6DJldbXKNEUf5GVmxdM4mWLGPKYnAGFC82zB9WjLLv5UyiplLkms6nr8sxrqx2
         1uAyQC040dRM9YZBOdE5cbeQjAB1erDJEwIuVueGuzNUYAWkuuwtoqN97L+Os4DMLsTW
         5zoJH4IyxtfVMGH1eRJCkm4CZ4GhRKuhmdqnQEAVros6f2sqlbOJJ8OshwkMwoJsCRbL
         YvgjbCgIsIFaUfviUhHz+LU6q6G0iGYnxr/MX5PfHqegGgucXJgvevtWRzXJqFzMhdch
         6OSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793713634; x=1794318434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PKjWRUzPQ/AfOjwLbgBl9OKiNXSCa4wej4PtIGjwOlI=;
        b=RxElY2lxqw2qJM17MPPnq8yUGW7rMLm+dgGJlNUZ5pbp8zQ4oMv1A1DkuO74zOHqst
         XKsh/dQhFdhGHbWetUjMBAdjUGBvjMffg39qoRjx2BaRuVDZ1Il9+nsbNzV21yq6JLr5
         C6vfmnHHxc8j0FsyCtIwzkXsOrTn5cHm9bo4YLuskzJPDs0d9SESpk7pV3WhZ1WazkXb
         hrxAskUuRu10Nzal+5IZ4agJeJxI4d52liUEHC2Xv/mMSq3G2MCt+9jxxJ05QX9L1m2c
         kklZinINXdnM7OVMHthm8RomGLAFk+iIWREL86Mr6nshpZaVXsn+3hCdAxrPV92kq22t
         iGyA==
X-Gm-Message-State: APuU4Z9k72xGD2ZApHbXRHJUt79aii7BjJzS1mgn3J5gINkHeEuhV/El
	3hmr2vXmcskqDkc9MIhVtV1Kuc9C8Lcg/Essw4UM+oTip70mW55kAr/tqcXrNA==
X-Gm-Gg: AYBFou3ZcrxXiOm2X1XtLx+BhFVL7/w08sJU/SMvwMiDJD8t4uVTjMWPkmJreQzEluZ
	TuhzxuBLuB99A7da0g2WzYbMJ859wrYxhedQnEB6VzlbmNgX3Y5RnB+/ex88X8VSZb0Udkxl3Ri
	KHFHMpW2BzEeMpXOBwjxNZ5h/2YYnv8SNUujMJo6yO4ckjDdRQlVoUmeXaHxUG/WWFyVhyBMuam
	6XLtSJySAZkb/PtTlXf/ut37EaQ4QuDvrv7n2ufdMbtvS4JfAS4k7sfGMrGheWDoT6BWrrAzfsm
	GENxLXCRfQv6q4GhVL0TaJPvB2tggUGAZBqbM+kgPj5Lv/WDSO6H7TQKp4wjeN4WawyFQvv1cgh
	QO5eqxlc4HF8rQldpBfEVmn9h658dvvAYMudXqbIzNLEuMSgvkMdC1KluxkDo1ktGEHeV0gQGcK
	CizECbnYL9r2S8W9GvddHKBtCYghTOx9wTNtl7UZuxzKU5vJegwhnii36IHGbam/sdajC8H7vJk
	bPbkENimZpiOGVdXMXeNfIYmU1+AUJZCZWoANhqznM3LfeJV5j5GFgYSg1gxOHLn0zuM8SnuBQm
	QnoC95TimMH/mMAPEnDgZ/XdHw920UJdoL3W4pc3SFbWxbclB5Bx
X-Received: by 2002:a05:6a00:2da5:b0:89f:172b:3b88 with SMTP id d2e1a72fcca58-8a9bfaf8c30mr10114132b3a.47.1793713633720;
        Tue, 03 Nov 2026 05:47:13 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad7707ed0sm3436124b3a.4.2026.11.03.05.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:47:13 -0800 (PST)
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
Subject: [PATCH net v2] net: dsa: motorcomm: Publish a consistent MIB sample
Date: Tue,  3 Nov 2026 21:47:03 +0800
Message-ID: <20261103134705.867613-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

get_stats64() derived rx_bytes and tx_bytes by subtracting ETH_FCS_LEN
per packet from the published byte counters, but u64_stats_sync gives
neither ordering nor retry across a multi-field read on 64-bit kernels,
and a failed register read published a partially refreshed buffer as
well. A fresh packet count could then pair with a stale byte counter,
and the subtraction underflowed on unsigned arithmetic, reporting
rx_bytes or tx_bytes as about 2^64.

Do the arithmetic in the writer, on the complete sample collected under
priv->reg_lock, and publish the adjusted byte counters next to the
frame totals, so that get_stats64() only copies published values. On a
failed register read, keep the last complete sample.

Found by LLM. The issue is transient and abnormal values will be flushed
by the next function call.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v2:
 - more issues found by sashiko
v1: https://lore.kernel.org/r/20261102101334.3525485-1-mmyangfl@gmail.com
 drivers/net/dsa/motorcomm/mib.c | 23 +++++++++++++++--------
 drivers/net/dsa/motorcomm/mib.h |  2 ++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index 6b170fc6e187..d47aafc468a3 100644
--- a/drivers/net/dsa/motorcomm/mib.c
+++ b/drivers/net/dsa/motorcomm/mib.c
@@ -95,6 +95,8 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 	unsigned long flags;
 	u64 rx_frames;
 	u64 tx_frames;
+	u64 rx_bytes;
+	u64 tx_bytes;
 	int res = 0;
 
 	mib = &pm->stats;
@@ -127,6 +129,12 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 		buf[i] = val;
 	}
 
+	if (res) {
+		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
+			port, res);
+		return res;
+	}
+
 	flags = u64_stats_update_begin_irqsave(&pm->syncp);
 	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++)
 		u64_stats_set(&((u64_stats_t *)mib)[i], buf[i]);
@@ -144,14 +152,15 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 		    u64_stats_read(&mib->tx_512_1023byte) +
 		    u64_stats_read(&mib->tx_1024_1518byte) +
 		    u64_stats_read(&mib->tx_jumbo);
+	rx_bytes = u64_stats_read(&mib->rx_good_bytes) - ETH_FCS_LEN * rx_frames;
+	tx_bytes = u64_stats_read(&mib->tx_good_bytes) - ETH_FCS_LEN * tx_frames;
 	u64_stats_set(&pm->rx_frames, rx_frames);
 	u64_stats_set(&pm->tx_frames, tx_frames);
+	u64_stats_set(&pm->rx_bytes, rx_bytes);
+	u64_stats_set(&pm->tx_bytes, tx_bytes);
 	u64_stats_update_end_irqrestore(&pm->syncp, flags);
 
-	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
-			port, res);
-	return res;
+	return 0;
 }
 
 void yt921x_mib_poll(struct work_struct *work)
@@ -391,10 +400,8 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 
 		stats->rx_packets = u64_stats_read(&pm->rx_frames);
 		stats->tx_packets = u64_stats_read(&pm->tx_frames);
-		stats->rx_bytes = u64_stats_read(&mib->rx_good_bytes) -
-				  ETH_FCS_LEN * stats->rx_packets;
-		stats->tx_bytes = u64_stats_read(&mib->tx_good_bytes) -
-				  ETH_FCS_LEN * stats->tx_packets;
+		stats->rx_bytes = u64_stats_read(&pm->rx_bytes);
+		stats->tx_bytes = u64_stats_read(&pm->tx_bytes);
 		stats->rx_dropped = u64_stats_read(&mib->rx_dropped);
 		/* stats->tx_dropped */
 		stats->multicast = u64_stats_read(&mib->rx_multicast);
diff --git a/drivers/net/dsa/motorcomm/mib.h b/drivers/net/dsa/motorcomm/mib.h
index 9c24a52d46cc..2e2b832cb245 100644
--- a/drivers/net/dsa/motorcomm/mib.h
+++ b/drivers/net/dsa/motorcomm/mib.h
@@ -136,6 +136,8 @@ struct yt921x_mib {
 	struct yt921x_mib_stats stats;
 	u64_stats_t rx_frames;
 	u64_stats_t tx_frames;
+	u64_stats_t rx_bytes;
+	u64_stats_t tx_bytes;
 	/* protected by priv->reg_lock */
 	u64 data[YT921X_MIB_STAT_NUM];
 };
-- 
2.53.0

