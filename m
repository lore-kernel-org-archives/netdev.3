Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794162731;
	b=W736gAQD888gd0v2Ii63uUwPYy1IDf0iTVyvm2mWRZbLzXUiwhxtdiHe7orh3fqwQ+Jk
	 CuVfhuiQdMXKdi54UcYaBSbY5G+n9u2tzmMj/zJzyq0hdWrAPWpe6TpY1c+4SaFWVfU4U
	 Zi1B2bh99AHD1Rhk8qHRRPxbASajvsu0pZw6gK/fMQWVVeic2KMwT4NnqG9pYU1IMQbm8
	 WCmzfVJE1gS8vAQO19J3mtejvCqP/Zi2GAMlDxcrwVxF4hs7HbZuKpCWjqXdV0gtM8b3k
	 YHYCM+YI1Q2cGh3PthCHqq0MqFBg/G0KyK5Q/VMHErSC0Tv2m2P99g3N9GKGaVuUZgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794162731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xMsgQo42kELXp5TpBRTE7OCSKfvQ8gF/xzLE0ha8Gds=;
	b=hjnq2SHLX5xn3HBn0JdHaDTJdHSmaKEwu6F1yILvVL8JSgVyBY9N5z0QywV/X3LE8v5o
	 BeJgWGacxTaFJqI6VgPRoW48d/VKP2G1H3OxGUz7KWSxE4N5cE/8z4p/ER+1cfDA/HD23
	 HGq3HFriATlTPbIHCtkKZ5J4APPye5zEuJtZue0ypol3gM3gQDT4TWQ46TeDUJ8CRg4Ya
	 C9o8NihxSMm7ZoKhejoTnb5b/fTeVD6hHYFnvvuSXqZJK0xgK724G0vXI8Q00mkASAtUm
	 5pUagNJVXPMYgkUjERX3s+pak55WGlC3Hlt91S+zKabCpcDVZBA5e43H0wP4EyB/evQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jsax9Fmq;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7636E606A323
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 18:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7636E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jsax9Fmq
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso112422a12.3
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 10:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794162731; x=1794767531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xMsgQo42kELXp5TpBRTE7OCSKfvQ8gF/xzLE0ha8Gds=;
        b=jsax9Fmqy+mDVTZmjim3al0F6YSfiGg7z/bt5CKJTti1jx0kQOSAr7EjcST9gNzPrj
         W189756essGDQ7GBRoo3hxbydCiBPRzfdwUYsQcncj2qk1++PkU8Cg33jBENmyhdruSV
         EE//hmjsIdYnGzZMf9gWDzvNO2F9yeb93bJ2otvMORVRl4lEthV0p/SLp5Sc60aSpbeI
         /J8n00KMLVtoZaud3b8vEDJsZbHffR4bhdzjzcvlogOF3H6+JRVsX87Z0GlGS0RyHCqw
         cS4FxL9/5k9NVnncWcuDQuSD4X70+MX5etYiTBZYx7yDVs9DPGNiXd366rKjz5bq4oW9
         tHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794162731; x=1794767531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xMsgQo42kELXp5TpBRTE7OCSKfvQ8gF/xzLE0ha8Gds=;
        b=AWuwavodE8r2GvudBvahbXsbg+QNf6E42l1ESOxv53jEJ9COuymKqCaW899Us8loyx
         bIY5I5qvpHDBUs8p0HkEvqoGwPuoYsdQ4dBYnh4rpVRgzK8RHEyWgwqfnHRsrO7r0pZq
         q4/We2AgLsraUP6UVhgLn9hDFszrLQkr3V9jstf3JS8EgYlzIARIKspdt8/XW0OF1RQ1
         ZWxXY13ir1zg62YwXiWZaP2sDFYPEUtZz+IwZYJ8sj+TNPNr9/Q0boiuwvTy7uoTryru
         po5D3TkJuuKlnY+j+QCt+JiDuuXM1nSr9VlP1rwKa23QI79ZHy4T2T24r1upVTn9nRY9
         w8Lg==
X-Gm-Message-State: APuU4Z9bhBpFjOFBQEUBwrjWMwAQP5ZArzN8tSLqk5/PwWvRqbcvVl/f
	BXbUoxo8jzdr+8gDHGZ37UH8i8BuYhtg44hH8bSioIoF0gr63TZBqcTMI02nWw==
X-Gm-Gg: AYBFou0vNBx2N0HNaN/XYIxYH405WhuYEUPk4SJn12A+pWawylZaNvCWiW022Jdy+S+
	zkhonPDS0uHv5qdLknhh1CrShfAQGJ950S2XjP0E7xmtTuQRSm85DCyMf5rvJVS3/jL7JFMEmcC
	mpZ2U/tn2YmB8U1SrubVst/qhzxAlDKFvwnNPqW6GpQGK7i4UYa2MLP/dTEsX9vIorOiVjyIAhb
	8cLzkSr9yERp/q2PISrWuHafjK3UH1G9j/ELWUMsWwzbvEkVObIJAoBFQOCSMSF7PanpkjzQBU3
	XHYJhlpeQoeh/UN/bE7yICziV0UGDYzJL+e+XYac300x33EYXn3FlFLrRkFZrz0I2grbKz2pGQD
	82Lg6u8EIJo+zd2KXLJjWMXkY7WBFy/+g5KRGLN8xcKJCQjBQ6hymAA9ag5vszln3xpdyoe/OEZ
	8ia92aiIECcjbf4GieuYqArNzsDH0+j3Vna8W6QSGCxEhADyqBdRFwhZkKYxjyBlKAhv/iFHyG5
	gCijGLWi24Z0v7P4bID0Y/tPx1jTKUoIyOxYHnPB0VgIQlKB/FZmbfz1UeQN6heVgwhrZMr8AJH
	ZJhI+1bqddRJW0PsajjqBcaGvauvB0OKp3YIHDyQJhPuVc2dJ2DUmg==
X-Received: by 2002:a17:90b:264b:b0:3ac:a204:aa27 with SMTP id 98e67ed59e1d1-3b12d5e30acmr1697269a91.66.1794162730574;
        Sun, 08 Nov 2026 10:32:10 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm7600534a91.0.2026.11.08.10.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:32:10 -0800 (PST)
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
Subject: [PATCH net-next v2 2/3] net: dsa: motorcomm: Fix RMON fragments stat
Date: Mon,  9 Nov 2026 02:29:27 +0800
Message-ID: <20261108182931.1542638-3-mmyangfl@gmail.com>
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

etherStatsFragments counts frames with a bad FCS due to fragmentation;
report the dedicated RX fragment error counter instead of the alignment
error one, which is already exported as AlignmentErrors and
rx_frame_errors.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/mib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index b8fe2c407c32..e9f28d446251 100644
--- a/drivers/net/dsa/motorcomm/mib.c
+++ b/drivers/net/dsa/motorcomm/mib.c
@@ -336,7 +336,7 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 
 	rmon_stats->undersize_pkts = u64_stats_read(&mib->rx_undersize_errors);
 	rmon_stats->oversize_pkts = u64_stats_read(&mib->rx_oversize_errors);
-	rmon_stats->fragments = u64_stats_read(&mib->rx_alignment_errors);
+	rmon_stats->fragments = u64_stats_read(&mib->rx_fragment_errors);
 	/* rmon_stats->jabbers */
 
 	rmon_stats->hist[0] = u64_stats_read(&mib->rx_64byte);
-- 
2.53.0

