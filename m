Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057660;
	b=zTH2uONY5cPOvFvDuk9het3X2Jt3MRt5tGCEpIdIW3y1VaWdx/bTyhIqJKzPVDHoX70a
	 qFbaiy7SMDxQ/yUPjJvGM/I3wm/hpo7J/Td1ucnqVke/+alQ1+vWxmNQggLKXXbrBYC6Y
	 0r5OUVf2CCB7FUpFJY2mM4qOp0tm31imTxUxOXU/ANLBCYpLeg+6HVMdKtwg7gKVuKSd9
	 fMl+x86EJHBVi2mRdtm4IHjqgZYB3+GnEFpwut5C1xZIZhSHfN4IGdNfi/AE6cqlIezAN
	 9yudnxBwJC1KSLQ2+XlP13Qf6WA2nyagP8fsOqfTKzNT8UFwnTORxb+Qa5s2pDvJvNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p/l/ItgemMFWSjv2M5mduN7bQYto7r4TWh2GQLaqw/0=;
	b=Z8B6bf6YEN9m0EOwpq6tcE1uUg4firpJz51IyNDgbRkA4TaCjDgnWTYWQoAeHXjAVVTB
	 CX1i9oW0M6R/cgxJTJLDMUb6IHaANV4qk3GD47pc8/xAVhvw3m+Kthv6Qr6cVvNLhh0ml
	 /akKqXA3zEP5i0qXYwT/I5ejxdF6TCp2ZuXgU8UFpYg84nHXy+I03EHpWNmw8HU5jamPh
	 NNEuipJ5xq2lRJdl5dGB7IyqL+Uh6HbFN7qtPk1kxbS6CJrrvqi7nDTsJTDsgUAqW2Ozr
	 S2qkspGWZbMw/km499sDigKmhbO872Z2fFm8up5WczHyNdk6FxMNdQG/F75HE/1Vf1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mMjYpSZ0;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D534C606A337
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 13:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D534C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mMjYpSZ0
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so1305997a91.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 05:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794057659; x=1794662459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p/l/ItgemMFWSjv2M5mduN7bQYto7r4TWh2GQLaqw/0=;
        b=mMjYpSZ0PCIIB0fJ3/3ZVizmYD92jMgGlTJob219pIs42Qs/uGJ5jL/5c4rjaMKgHu
         8qcxbeilSJuNv768B+kfL/P1AGCyifdmwUzeChJClhiiU3CCQ6hv14/J6IO4P8tNpifJ
         KKaFTYEsWCkpUf7vIzA9t4i/Op2nr5s1ycQYMTEsGNEfMGHDAE9i3mUIvkprepCwNAIR
         kVbl3n8ooSsK1nAwGSSxioKXtqDwlGC1RyyvCj9NgyhK6iV7UKOu0uWpkDcDjKa6irN6
         8sVPlU1oIvCC96ANxZGL+R265moDKDEcGmjipn7s0ynyLobdoNCRdt8Rq1E5sX0Y37PH
         IRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794057659; x=1794662459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p/l/ItgemMFWSjv2M5mduN7bQYto7r4TWh2GQLaqw/0=;
        b=v+cGsGzV+ziayxlUsakJtb8pRgEy38DC+wsd+wLVm5EaShpC/bDjdVXM9ObmQFjOtH
         GR82EHji42foZRI9obROEg/z3+siNpMMGPIfR9GdlZCKyf2TlDf/6MLv2i6qBShpBM0c
         bJCxCN9CWGZwesk7LDipVj7rneUhkY+jikTN45ka0YpZocNRcuu2HczCvvtuIzCO5bV1
         7UzBUj6dDxqgSfo7UDoQK7bY2AjkgQ4SprjSUABd8Y5HodIxnVcEg3FCOotnOFFMGrQ/
         1zO39da984VxF2vBmPQwGNCKHgWDpUdMBp8nTRyTWWeWPNtPKbxxKEQmcEST6Up6Ru3K
         Fp7g==
X-Gm-Message-State: APuU4Z/tZRhDHMWcPuJw3RszXFcFHs+Sb6QqtK35t2utUYFgmGHVaZzI
	IGA+fJ1PMRpPFl5I9lt/SNRrWwp0O0yNVO1BtSVIppnYvAMZO/+bj3lz5p5Y2g==
X-Gm-Gg: AYBFou3KQ/0ObMmVsD+8BxadYBPIBkocIJ6l9Gbo0f7YpPXTD1xc/R/csSq/CF8Nv/T
	aOPy+pv2jPIAHQG7bPK6LU3+KwgsEK/D4ldSYkbjbUKjGXWULGzJ2YiBa3FoJOwdtgq1E4pQdm1
	dX3FzLSZSiPletd4MU1H+JSIIw/ZYffLjMFAcoc6GnCRYuXUnQNuIRGwONRsPDc8DFq32wWeGoZ
	aZuWjTxdcd1RkFg4TNT5vVHmSJJXSLbSvp3l2gqEiVgXmGe90+Z+AdVx4fahQF4oxNKgqJS5YX4
	UO8bNBa5gBoasIE8qJTjZ0OeyrB9Q7aqLNX618AuKM5JkZe8nA1tl5e5uTzJyvppqTftY+SxdEx
	PwG4hMPWK5dkWFgUzd1PuPLRBcL+2rmo5sJ4DI4kLHRmv5qieeA5uBO9ch/k79lYOUD4CvkziEX
	ZYS2Ud9qCtpFDCLRnE2SQObUW9u2mGTQkr29T1l4Vb11lYBsTjCrBFLKKkbM3uGmX7pVLQ9hVEm
	UsDdGK7SdLMx8A7w5kAdjX36XYs/PzsFp+8h4GqyNR8+HzirmuGSjbaRzFI2BRge7JevkcAORIb
	+Eac2ifk/oqU7JYMHxixY/SThFvMMDCyonQND3tli920RSQXeHH49g==
X-Received: by 2002:a17:90b:4986:b0:3a7:b260:9ccc with SMTP id 98e67ed59e1d1-3b0db70d52cmr5229686a91.65.1794057659179;
        Sat, 07 Nov 2026 05:20:59 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101d3d0e8sm1626521a91.3.2026.11.07.05.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:20:58 -0800 (PST)
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
Subject: [PATCH net-next 1/4] net: dsa: motorcomm: Fix stats64 error counter mapping
Date: Sat,  7 Nov 2026 21:20:33 +0800
Message-ID: <20261107132040.1066996-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107132040.1066996-1-mmyangfl@gmail.com>
References: <20261107132040.1066996-1-mmyangfl@gmail.com>
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
not a FIFO underrun. Report it as a TxUndersize ethtool stat instead.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/mib.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index 6b170fc6e187..5c027edb71e3 100644
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
@@ -376,8 +376,9 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
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
@@ -385,7 +386,7 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 
 		stats->tx_aborted_errors = u64_stats_read(&mib->tx_aborted_errors);
 		/* stats->tx_carrier_errors */
-		stats->tx_fifo_errors = u64_stats_read(&mib->tx_undersize_errors);
+		/* stats->tx_fifo_errors */
 		/* stats->tx_heartbeat_errors */
 		stats->tx_window_errors = u64_stats_read(&mib->tx_late_collisions);
 
@@ -401,10 +402,9 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 		stats->collisions = u64_stats_read(&mib->tx_collisions);
 	} while (u64_stats_fetch_retry(&pm->syncp, start));
 
-	stats->rx_errors = stats->rx_length_errors + stats->rx_over_errors +
-			   stats->rx_crc_errors + stats->rx_frame_errors;
-	stats->tx_errors = stats->tx_aborted_errors + stats->tx_fifo_errors +
-			   stats->tx_window_errors;
+	stats->rx_errors = stats->rx_length_errors + stats->rx_crc_errors +
+			   stats->rx_frame_errors;
+	stats->tx_errors = stats->tx_aborted_errors + stats->tx_window_errors;
 }
 
 void
-- 
2.53.0

