Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D307367B90
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782688189; cv=none; b=cgsR/UtGYnOFVP3iq0dvIojgWMVP4BxFnsIPr+wuHnRQTEXHL353+PwReIvoniAihKPf/g5YAJo8D7AWL3p51xQ/YPGxaZavGduhFOk4Mld9h7LGMY5MoxQsil35MWEr+DQnc2SZY0oWZzsGVnR2OXwHbcqq+e8psD5QENQZjJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782688189; c=relaxed/simple;
	bh=wHzJ07thjGcb23pK5OSEFKM5WhNdv0RAe3FLxmBcy5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxxUyl9/r5HFs0LnQIpEWCWy9O3cgMmKsmi2+oFzHsIjGI8vs3pLUPat3LmalwfSlggMc/qNkCaU/TYT9KNl+hWZIUuMc1tDI2JGkxSCnDGL6lvLNN9ppl/5aFVOEHH4exY7/DYXqNK0suQOlCbu77RKbgPB/l9QKejnGbf7Fg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIZQUKvn; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIZQUKvn"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37fb17e1435so551593a91.1
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 16:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782688188; x=1783292988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tizSwas8YHcypZL2dVhET/Zc9jaBNCk/iG8Mcm3/l0I=;
        b=JIZQUKvnswpqRkixfn8TzuWKM3wrmRJWy01hz3nCwv9Xr5Y2nIW5JBOPT3AOkgLSGU
         AVZ+qD59KhDJiapAJIzxEl9z4q/S+5bsCH0HDnby9t4J5jwDTJq+VRnG4OwSNrjJsVFv
         wRxGZuNkdPeddUGIRNlRcsxft4Gw+OE53/6P4wPnYf7YWwG0WBzug3KWHXpfAdZL72da
         KxFEftFna2LtxGvAA8zz2pp6AA26yljfEAt/r8Dus1ZK7/CMj6ZTrxV+353X/19Ro8Mp
         HMgaGOjdgwS+lRcJwlMLzes+dSsmVBa/dz0Tk5galQE5QAJX2Im7llysb8IiE0ptRG6y
         vHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782688188; x=1783292988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tizSwas8YHcypZL2dVhET/Zc9jaBNCk/iG8Mcm3/l0I=;
        b=cJHvYCmZnCMsH3w+L/8nANuRDGiEiPsjCvCqJR4ar+zUD420KAa3E13NAgvNiQ+bhn
         R7b0uTcfTWZTZxoRtWaHJo2rk1ENthz4KB3Fb8si8CedbuVTUY+RfIBze20WWttmHMjQ
         PWfocJ9BHPVuQ6pJH+zksiCEEN37zVgFl3LrR7AxH3+GNlNbMfgG1+qO5kML2pW8Lv8I
         N9KaktdSgVHx73TlMh5KshrorUFBsa4nvRCRrpD8c1FtYnUwsxXDLOHIZG/11oEBQlcB
         FZmXoJlYy0FChRY7OY39msemkDqpAruF0vthj9aLbq9004rinRy+r2KmlCRV+Xyuqjik
         I5Mw==
X-Gm-Message-State: AOJu0YwhiPHolI4NH/1n1AQvY1sOlG8ee7KkmL+EfBtbheZYcj3fATZJ
	G3G2bnO4prQyOFMR8a6fMgCw0do9StAdqgCKBy0rXcS/Tkaor4rixSvMQgLyDA==
X-Gm-Gg: AfdE7clUuL+z8DmA7bS4QBUpI61kGJg3PQAeC/LMQSM8X3upKFee7kw1Ll8nA7vjz55
	NfgIOnYXNSfEElXmgmRzk2gDmWPsadW5Hz5c3WbFF49dpWirQZ5777Kj5UKsNJWJbHb7rNVc3zo
	OHNccb0T57m3EPpk/JktpaUM1NgfwTKF7LQHV2m+nVEoKrxJlIDQHQ+zLV+2koxtnC7vJHW079g
	Ws8wUykoHbocVxi8Ckds1DAIEvUA3ZG0gWI4xxoimF61aAfDtQxu/0Vaayf+LYN8UdJfmVh0FW4
	mZqCQg7S/wUgzLz54B4md/K5LecFVdv7qvVO7g0evhLVmmkMhKRTRpazhNQU6LOo8v8fOaFYkIE
	502IO74uzl/9HxELa92apKOmbu+y4ew1BN8DadGv2RL1uRxGF1prh9/B7eTsAQbAcyolck51Fae
	USc/GTl5pJcMMOI835t4OtWI7OkVwLU1mSWurz3R0bfPCtDxDSfp2Z4wZ5syJS/nyyj4u0ESDOv
	XWQ6Y/IL+1dIvLO+dSo
X-Received: by 2002:a17:90b:4c4d:b0:37f:ed70:cc30 with SMTP id 98e67ed59e1d1-37fed70ccf3mr2331009a91.26.1782688187936;
        Sun, 28 Jun 2026 16:09:47 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3800b9c834dsm606960a91.6.2026.06.28.16.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 16:09:47 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] net: ag71xx: Use default NAPI weight
Date: Sun, 28 Jun 2026 16:09:42 -0700
Message-ID: <20260628230944.1244501-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628230944.1244501-1-rosenp@gmail.com>
References: <20260628230944.1244501-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the custom NAPI weight and let netif_napi_add() use the core
default.

The old comment claimed larger weights wasted cycles and cache, but
recent RX and TX path changes altered those tradeoffs. Keep the driver
on the standard default unless measurements show a device-specific value
is needed.

iperf3:

Before:

[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec   327 MBytes   274 Mbits/sec   31            sender
[  5][TX-C]   0.00-10.00  sec   325 MBytes   273 Mbits/sec                  receiver
[  7][RX-C]   0.00-10.00  sec   170 MBytes   143 Mbits/sec    0            sender
[  7][RX-C]   0.00-10.00  sec   170 MBytes   143 Mbits/sec                  receiver

After:

[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec   341 MBytes   286 Mbits/sec   30            sender
[  5][TX-C]   0.00-10.00  sec   338 MBytes   284 Mbits/sec                  receiver
[  7][RX-C]   0.00-10.00  sec   184 MBytes   154 Mbits/sec    0            sender
[  7][RX-C]   0.00-10.00  sec   184 MBytes   154 Mbits/sec                  receiver

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index ac4eadb9190a..1def2ad4c5ce 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -40,11 +40,6 @@
 #include <linux/io.h>
 #include <net/selftests.h>
 
-/* For our NAPI weight bigger does *NOT* mean better - it means more
- * D-cache misses and lots more wasted cycles than we'll ever
- * possibly gain from saving instructions.
- */
-#define AG71XX_NAPI_WEIGHT	32
 #define AG71XX_OOM_REFILL	(1 + HZ / 10)
 
 #define AG71XX_INT_ERR	(AG71XX_INT_RX_BE | AG71XX_INT_TX_BE)
@@ -1913,8 +1908,7 @@ static int ag71xx_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	netif_napi_add_weight(ndev, &ag->napi, ag71xx_poll,
-			      AG71XX_NAPI_WEIGHT);
+	netif_napi_add(ndev, &ag->napi, ag71xx_poll);
 
 	ag71xx_wr(ag, AG71XX_REG_MAC_CFG1, 0);
 
-- 
2.54.0

