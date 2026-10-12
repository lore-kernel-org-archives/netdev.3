Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF0837BE78
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812308; cv=none; b=h18jQiDSFQZvZFKaOdAJ3d7ISKglcNtAXoypDew1SOU1WY+3j6aFlcAnK3jAM08Rl4dqfD3yp+FGZSRDZNcDWOo86e4UdFoUgiRv7UuTnaPu4G/U8PeX+ArcTLc6ykMtCQ3Y/xgzSMvwy4xWvNGFA3/fDTtTqMj6/NVtTvVViP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812308; c=relaxed/simple;
	bh=rWTCDK7Lu98+d3mkrV0MN4YOesMUBm1C1YFvlmoJwjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vl1qQMS+vZ5z+yM6TMIk74Heqr0ieVGooEArbN+JaFL88DrZzR28PFT+RT0sV7K/UAsAa8lrya56sKvIFH0Qwc1LQ1L9zprP36Utm02VDC7OhZCzDGglW5SJ7HSbGkLO1X6IXItPho7FW3s0tW1/Gz9aloo4SZ1UVrMQLtJeaUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=A+k5TgFp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="A+k5TgFp"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a16bc2278aso12912675e9.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791812305; x=1792417105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PUZNOFnMcYElO0ClXptU5P2JhQobHKhnh+QtdfN2Je8=;
        b=A+k5TgFpY0UedNuEDZYptSzzBB5n1S3+kbFvF/BtYuBgnpmzyKywzuGLAR7HSL8jsi
         zsJsoPPXi9TvNIgugXkdUj/Di7/Z7yBHKD1gmWLpe4LEO1aflNt8OzYgWfdpps8Jifwk
         eNtPqLkINROGy5tFKKWuPAtPQevMGQbHbh7q/ztjDQGadBIucitzEBICVbp3jt1Yv6Pd
         0EQAkyTwzbzeoW3wDPsDRD+J0T1PGhZ2tc9TijPtLIp4UfZGCfTvwwQ6Xg9YgKO5Rixz
         vQolz6INLtZ+7CY/7YhVdxmznDbesVLNr4hEwgwtYNTBCMBrsAJ5+f45qHb2oFjqmlnb
         pM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812305; x=1792417105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PUZNOFnMcYElO0ClXptU5P2JhQobHKhnh+QtdfN2Je8=;
        b=ugnts5WVB6hWDNAUqYMQ8saKG1Z9AUYH+fb2gq7roFdjJs5/FSdLnhJvv/+kcLcSjt
         xJuykbEkwZkCxSDkqtCe2NwiO390getq3CqT6amwitPj308LoKeKgvDXPg0Gpo3B3VGS
         DHEi7nIsgV3DFHJYoBa44BmM8wpc2SiXeyOlIVshXAaOyubom5fHMWA4xNT0I9AWgSRj
         FLUP5zaiNXmhreYLesIL11CKu168cdi4kATLCuxhWSTt81NjJPPkf4aRCJ85pauW1u1X
         0MCIBmk8VKfhEjQh06tjq6fxRAsM2tOwIw9avMijkd1XlE+Ku/6VNXb0w62OTrLXiZeM
         /YEA==
X-Gm-Message-State: AFq9FYJA4bNr7p8/aKDPpIoX8+hFfH6gjUNisgaW2PKN04i8eeWzVuQY
	yPQZQphnceGVvFfiVuWvDybE3W6FHc8fYaPU4MCUtFmP0xJT2U+IA/l1bBDWFuN/IIc2uJV9Swm
	yDSbMy8orklWW+AG9h1pUOck+TbUoSfBxGTTlvoo1KOeTof/LOF0WURCHB+AVunb4YNI=
X-Gm-Gg: AYBFou1AENpwWPd312me8R0/zdBUG6CyckHUGnKE7XKdGReQ3eYUD4q1XCFRAQL7lrQ
	U2RpAVyUE+ZMPy43SNX5jUtHKqSkZQzHqi+9+d4NvXYhqtrcD7qzW0DMKfSyypjla4qMi0ZsWPx
	HK8582bRjGuv/rk2cSQSm9zfx9eYDyI8WFBszaohpxzodWypzXrUS7JcEGcahlOdvjQNIrZ3xmp
	x2zMgulVmzn94KRCEFaWwtDkRV7T1wXnlVV4ukeQByEovG0Ba9+CWVR0hmpIyXKO+5GGSFDa9O0
	K7XvEM/IjpMmgWAjPqUpebVJ6c9T93HdSO8GPTtDV53aiQwWclQR38zRqoxP+R7jZuNJ3FyIRl0
	oLWvvVhlpxn0C4GDxGJEXIU1RH9Ke6UnomstzRPTaR2VpyQPoTKqTzIrAEQlIcvjePm3+I/atSY
	2NJBxbNFIdmHX9bXihoJtogcfEpQCYGd5hSTBbVlD9XOkRwzJhZbzfWGn/J01Je2L7ZOyg9qtfi
	b8neksnS+I=
X-Received: by 2002:a05:600c:548e:b0:4a0:1aa0:7cfa with SMTP id 5b1f17b1804b1-4a18e4aa724mr183307495e9.12.1791812305080;
        Mon, 12 Oct 2026 06:38:25 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:2e28:6511:e6d6:deef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm418114735e9.9.2026.10.12.06.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:38:24 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 2/6] ovpn: remove unused work field from struct ovpn_socket
Date: Mon, 12 Oct 2026 15:37:59 +0200
Message-ID: <20261012133809.2477063-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012133809.2477063-1-antonio@openvpn.net>
References: <20261012133809.2477063-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

work in struct ovpn_socket was introduced but never used.

Remove it.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/socket.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
index 4afcec71040d..5c87392ecd30 100644
--- a/drivers/net/ovpn/socket.h
+++ b/drivers/net/ovpn/socket.h
@@ -24,7 +24,6 @@ struct ovpn_peer;
  * @peer: unique peer transmitting over this socket (TCP only)
  * @sk: the low level sock object
  * @refcount: amount of contexts currently referencing this object
- * @work: member used to schedule release routine (it may block)
  * @tcp_tx_work: work for deferring outgoing packet processing (TCP only)
  */
 struct ovpn_socket {
@@ -38,7 +37,6 @@ struct ovpn_socket {
 
 	struct sock *sk;
 	struct kref refcount;
-	struct work_struct work;
 	struct work_struct tcp_tx_work;
 };
 
-- 
2.55.0

