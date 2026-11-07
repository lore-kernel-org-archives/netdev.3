Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057670;
	b=O1aHRl72uEY/s3fYh2a9JkN0PG0Se6a0WT9Z9OT1Xe56UOkGAbjJei+vh5vaMDibjf3p
	 8pbV+E0rsmRqfXAnwJIzvAlNs4vg2/TkZOgPiqXy2o2x875zRuYdIzQwHTkH6PwEQQ6IP
	 o5ekQPVLGGHvWW+cCjp47ZfZZerkuK8zN1n8EnpgwhCPhxHetbOFk+IEHW/6MRN0SA4Me
	 sMepacL9OfYET9Lqjr7LUaCH4gh7hitbm66QoLgIhWPqPZbZW7ir8NQbKlxs0DVqps5mT
	 UIhdGJRzKaGoHzpGyDmWpcJWR+HFE/Gh2HVC8M+7pcAtEHORGrt6NRrk6zfENkijQfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mJ1fvT6xQkbU3RAcDjFMvDU2jO1gP0q2R08NAUCv0G8=;
	b=O7GGoNP1iHVNND/c3KX5WCrf93kvA/VpY2mwkqzKUbx3PWNwr4OqkxkkGt30WgBca+y6
	 HBLfuHM4dwCtQbAWGesxrv3pabH4fPe5jbqgSgSYgUzudTb7aCIDS6SCkxdNSJXcG5dQt
	 TK3zjL9lgAntN37aqtmOXNxjRUrjrZuXO+KztLrXFXTT1RANu1Tlp7RNS/0JnVZHrvP+f
	 xquj/D608VYmh9m2G1quny2JNybvmAxZ0P2897ATAXCt0MiAq5ofvTg9ajRjt2+VoA0Km
	 RjWh8BHJUsPp7B82hRaz0l+e5fZMKF72lEnG3azGRtEjNj0b3qdfofiDOfi+C7kBi0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fD3906I6;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A86606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 13:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40A86606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fD3906I6
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso1030740a91.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 05:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794057670; x=1794662470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mJ1fvT6xQkbU3RAcDjFMvDU2jO1gP0q2R08NAUCv0G8=;
        b=fD3906I6JjeGQ2dSkg3zfm8RlYE989NbLI5KOgXBXXELSGZvOAPM8HpQoIEVoOLNwO
         fhL4sERAUbBOcQIBo6IgVM6hSe4xBJFoUjazj1y78CPBWcNNGz0IE2etDoCmpxX2rFal
         Vy0e0Jm0fGCPfoDUDwT3TQ6PFcUK8RZUJCFqnuHsUkNC3gOotWDZ9jDSl8/4SyJDC0Q6
         67ud+zo/uyB/hPG0Ivk1DH5SuyjMUV5X67JwWyAdEg88dZw539B8scE7YfCW7A9LjHk8
         caGlCWOrkotEEoflX4OBfS4Y6o38mj4U2HU0pljIF42GKhktVCwKELSrlF93taXy2/5q
         li4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794057670; x=1794662470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mJ1fvT6xQkbU3RAcDjFMvDU2jO1gP0q2R08NAUCv0G8=;
        b=PBU1HtMzrNeoGpB8VAvRKpqH4ow73h/CJf3YawaHBxpRziSouzmK+LB3L/FJVCGyKF
         tBAA2veOg/f/pu/wkdqAYgDOmpJYdlDZbNdzV1wLhjE63xMVnxmd0AiD2D+VdMy1XRo9
         Z8ag55c/O/89f76U0wDYtXvJVYubzWDsSP4Dv6GA9AV0bPsKdUK03C0HZDPdfn3raCpG
         yQyA1qoe7conB6xSGTpdPlAGUddtmldTIBtiFyuN8DuG1k5bwY/T3o9lISabC6b0IEL1
         opbeTd+71urdzUHnZwiC9CX6kLiRaMGKO9vmrdCPOJ8/4+XCFcvhqTr0VEqKz6u9SlIB
         Skdg==
X-Gm-Message-State: APuU4Z/egEKdczD0f1oMOMOXtsrx1GjxnFA7qKblN/RXqKXKEuJPFOB9
	/PA2TG4LL9hpwb+JAZyNhpT2hzwY1S5ouQmNBGDMs5sPA88NebMsOV9dYKJeaw==
X-Gm-Gg: AYBFou2/S5Wz+x7oSPMDbvDB0dAklNGCRlExVapjZGT2Tnd+lenDO/8y9G4YTrL6MuQ
	7BR06HGOFaFU/aLMHVn28Elluxxj8uh1ujhbGXtnKje36AZa9H6143kFBMJFAncElmjLGYcSXc2
	PR/DNYMDTW8iP+Ka+U7Ngekjd3YRP3RTOBF4SEgpSrYFOhBifnw7wEIZtpJJy1914IqN1oSRUH6
	VzGh2/8ZPvRDc0gyxPNKHnsu9LthEV8LCyyMXy/8cICmXpC/30eRcuoCGreOlkYHXNEoK5hvLj8
	CxXfSzR22GtGy/wbZxXn7Gke6b15JQfVX//kRV9dy0rFHK4kpgj3Rd841saA+EMnvCaFa5F9Y1+
	UQ1WcJHFUI3T8d+GwLUaKUFMZEJZoc1qsxYr00XoMEAQBhirivwdt0cTtjmrL1Sx9/IR8qlvu1r
	74qGiebmLgh8eJccmZKrhWPCfmAvOnv2JJcrYklBoSSaT2g2a/srD9iHkAsXMntFdwdCxzjFu73
	nAtGWzPWYoXqMoeNX1wF4bLjkHgJF767aVld32rQgoliiiV7hpJQmoNGGCf+EDJMLSLqmEVXQwh
	F7DyTZhoKg4tyKUOLGci4e0IXtY+aZDUlq9/21CFT3QY8s8mYxo7FQ==
X-Received: by 2002:a17:90b:2d50:b0:3ab:884b:65b4 with SMTP id 98e67ed59e1d1-3b0db702a95mr5716040a91.59.1794057669654;
        Sat, 07 Nov 2026 05:21:09 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101d3d0e8sm1626521a91.3.2026.11.07.05.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:21:09 -0800 (PST)
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
Subject: [PATCH net-next 4/4] net: dsa: motorcomm: Prevent rx_bytes/tx_bytes underflow
Date: Sat,  7 Nov 2026 21:20:36 +0800
Message-ID: <20261107132040.1066996-5-mmyangfl@gmail.com>
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

There is no direct rx_bytes/tx_bytes counter excluding the FCS; both
have to be derived as good_bytes - ETH_FCS_LEN * frames. Three hazards
can pair a frame count with a mismatched byte count and make the
subtraction underflow, reporting rx_bytes or tx_bytes as about 2^64:

- a register read fails midway and the half-refreshed buffer is
  published as is, pairing fresh frame counters with stale byte
  counters;
- get_stats64() on 64-bit kernels reads the published counters without
  any sequencing across fields (u64_stats_sync is a no-op there), so a
  writer update can slip between the frame and byte reads;
- the MIB bank cannot be read as a whole; counters keep counting while
  the read loop walks the table.

Handle this in the writer: do not publish a half-read buffer, keep the
last complete sample on read failure, do the arithmetic on the complete
sample under priv->reg_lock, and publish the derived byte counters only
when check_sub_overflow() succeeds, so that get_stats64() copies plain
published values.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/mib.c | 25 +++++++++++++++++--------
 drivers/net/dsa/motorcomm/mib.h |  2 ++
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index b45bc8211741..cb3912493cfb 100644
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
@@ -124,6 +126,12 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 		}
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
@@ -143,12 +151,15 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 		    u64_stats_read(&mib->tx_jumbo);
 	u64_stats_set(&pm->rx_frames, rx_frames);
 	u64_stats_set(&pm->tx_frames, tx_frames);
+	if (!check_sub_overflow(u64_stats_read(&mib->rx_good_bytes),
+				ETH_FCS_LEN * rx_frames, &rx_bytes))
+		u64_stats_set(&pm->rx_bytes, rx_bytes);
+	if (!check_sub_overflow(u64_stats_read(&mib->tx_good_bytes),
+				ETH_FCS_LEN * tx_frames, &tx_bytes))
+		u64_stats_set(&pm->tx_bytes, tx_bytes);
 	u64_stats_update_end_irqrestore(&pm->syncp, flags);
 
-	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
-			port, res);
-	return res;
+	return 0;
 }
 
 void yt921x_mib_poll(struct work_struct *work)
@@ -389,10 +400,8 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 
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

