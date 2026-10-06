Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5534635CBD7
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282747; cv=none; b=MM7pBQFixtmQuuvH9RXh/uBQYFlvVtK+JUIDqi6HanvfUCdiuBdO3441K0BG6OynbmhBttNoFLm8KIy/rShASpmZseuv+9Y9LB2g5bc30/UlJFMY+Ro6Ugh7m+Lp1rKYNIUg305jHfO+RNl2zlh1D8TCWVj9CyucgCgv8LyBuiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282747; c=relaxed/simple;
	bh=/z1mtYFosWYDl4G9Goeh4fvMR59E9gra0185EpZWKTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6/1GFcFSj0kbua1AmCpx4D/ku7erUuZPLDt2I+hltql+0NZ/AKQMpEPfzWj/0aAMjIKZxvPLGyHNvl/PWLV5Dv837zfEJwPE757WML4whDwVkDaCz930gKzlRv0oBwYwQ7fSogpMC8ycl1HwYm7BGetfN0CVGbaCX2T2a/jA8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMKHfZfk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMKHfZfk"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2a832c6554so58023966b.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 03:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282744; x=1791887544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wClIytfBTMwnkpSGNyg13HyUgwUOhd8DTwIiBhpaeSI=;
        b=lMKHfZfkBSaB5SJ9L9F+g5+cBPDlkwOUjdhGTTRxDWe4L0OVg9BfLA1SIiWtjQK0wl
         ceeJ8JOlVkML6sc0zLrMrqH9swCPckqdmCif0BZzyqE2qyL9WdKThmDoDD6gko5qXvOD
         aSHe1nZDLnOCuvFJrYlxz2YOI+JKnc/l+VxLTzzpol+7WIrcxFvwKoJ0U4bHpgpb1o00
         VxQUcktz6cBYxrmet3XMRO5XUDHjnSf0g39qIIpEKRQbDPtiKNb94YhyDx5S+YeRbpRu
         KXhP2x9ia3SgKYs6dqzzdFb7k2b4FVG5i9RG3LcSj/8NMZrqWy1OaYyGlpJ3o1yKH+Hy
         mTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282744; x=1791887544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wClIytfBTMwnkpSGNyg13HyUgwUOhd8DTwIiBhpaeSI=;
        b=ecZXsMGvMmGFLkQJmY1cW3oLTZT2ROw2Ue+5uqeL6ke5NwlXj0JCG3fZekXBNttJK1
         WvFLuCypCxTn18RAeBSmYvzZs+JDPsgH0b8nHNSJGxOGnHc3bXPD290un9PPf6oxRXIZ
         eSy616WeBdWTTTD326Lqp377SnV4qBTMiZWjivVk2S7rhG209TqpwMC+GDUSc85Ajd76
         J4IZBi1xWO6WEG9BjzFLc5UeoD3J9RsRpA8sWDVQJSy5gPTilX0UfmHsjj00PwzQcM3v
         6OdZu1j9BOk4xNiXDI7VTto9BLyKomIalbbvOoNjwWZGrGWA8fbHCZLClZurcb+MNE/I
         /5Hw==
X-Forwarded-Encrypted: i=1; AKwUvBwbjqSOvz/4KNg3j5SvHj7kobg9tpt9OftmPPa6JGAMz6v+bxW3AoLWTAXmM1Fkh1JRHcwynLc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpJJTSckDb6HWQEz2PWpF2IMVJ/Ajnpy/PEG+caw5zuBMH94J5
	+2EpJ4kKQa02DYm39FgvbNJaeQ36/hCIlYKt/PmNSkpgZKHOZedvlh7y
X-Gm-Gg: AYBFou0khUz1bo6xp48yulqX2NQc/xL6d6/LOmKr3pHsG/WVWuHcCQRzju+BjwnLS3c
	GvRF7aiVLqsdFMTkRU3OpaWaHvSc0ZmQBi8smfgxREBMC/REcUekT+V6FXmO7VmC/rdWf4I3HaP
	iZmUgKSXm6q3q9lD0QD20QKDXeF/ZcAbquG/E+vfSFFk9jzw7KvBPJQAsgrJs+C2nnkFdWViBa5
	mRIhiTRIH1JY6yLZNbfQ3yFno49gWvAqfAFolkkMEhgU5jL88MUYuRB9/E+2HxGXaZmh3ZLyYAa
	MCSLZ1Tgu0X7nc1nw/UGsLvlY01sM+dyEDiddclnRedgCRNcw+T8ijC9kzrw5sTbTtVXu1etkpL
	gWtKbDW725u8oQIanq8NoktU1gwral0qHfRyE4zYk1YDvzhjau4yOEV+GuXEcXaXpVW+q8/MEN6
	+JmLMsE/eKpJgzljHQ6JLWWQIXf23IOX+bAmHWBPd53BZyTDuyJWue8G3QaMuZBApVtKrxh0JOE
	142GHlmGa81GA==
X-Received: by 2002:a17:906:7951:b0:c2a:6bee:77c9 with SMTP id a640c23a62f3a-c3169cecc1fmr119190866b.4.1791282744269;
        Tue, 06 Oct 2026 03:32:24 -0700 (PDT)
Received: from stukan.bbrouter ([46.201.91.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3156332f28sm191575266b.58.2026.10.06.03.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:32:23 -0700 (PDT)
From: Timur Stukan <timur.stukan.linux@gmail.com>
To: jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fmancera@suse.de,
	Timur Stukan <timur.stukan.linux@gmail.com>
Subject: [PATCH net-next] bonding: 3ad: remove unused TX state
Date: Tue,  6 Oct 2026 13:32:07 +0300
Message-ID: <20261006103207.68974-1-timur.stukan.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sm_tx_state field of struct port and tx_states_t enum
were introduced in the initial 802.3ad implementation but
have never had any users.
The TX machine uses ntt and sm_tx_timer_counter instead.

Remove them.

Signed-off-by: Timur Stukan <timur.stukan.linux@gmail.com>
---
 drivers/net/bonding/bond_3ad.c | 1 -
 include/net/bond_3ad.h         | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index b8e4b4d68dd6..d91533b80996 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -2071,7 +2071,6 @@ static void ad_initialize_port(struct port *port, const struct bond_params *bond
 		port->sm_periodic_timer_counter = 0;
 		port->sm_mux_state = 0;
 		port->sm_mux_timer_counter = 0;
-		port->sm_tx_state = 0;
 		port->aggregator = NULL;
 		port->next_port_in_aggregator = NULL;
 		port->transaction_id = 0;
diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index ef667dff2972..9e548d3dca21 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -60,12 +60,6 @@ typedef enum {
 	AD_MUX_COLLECTING_DISTRIBUTING	/* mux machine */
 } mux_states_t;
 
-/* tx machine states(43.4.15 in the 802.3ad standard) */
-typedef enum {
-	AD_TX_DUMMY,
-	AD_TRANSMIT		/* tx Machine */
-} tx_states_t;
-
 /* churn machine states(43.4.17 in the 802.3ad standard) */
 typedef enum {
 	 AD_CHURN_MONITOR, /* monitoring for churn */
@@ -231,7 +225,6 @@ typedef struct port {
 	u16 sm_periodic_timer_counter;	/* state machine periodic timer counter */
 	mux_states_t sm_mux_state;	/* state machine mux state */
 	u16 sm_mux_timer_counter;	/* state machine mux timer counter */
-	tx_states_t sm_tx_state;	/* state machine tx state */
 	u16 sm_tx_timer_counter;	/* state machine tx timer counter
 					 * (always on - enter to transmit
 					 *  state 3 time per second)
-- 
2.43.0

