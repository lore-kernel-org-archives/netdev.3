Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5442399019
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 04:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783484595; cv=none; b=UI/JYPFOkKJ+vARBLhKu2+WgX0szsDT1yhpvI/WvrZDt8ubJScg1qtC57AoMzANzcM1+RE9heJ7suAwefmTCvrLTStFhdQ2yFzaCeb0f8zSSEK48SSSInFBwobiENtslzR7YoM8d/m3E50gNpCp7bghaQvHkbdd5n1c/CYWWS8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783484595; c=relaxed/simple;
	bh=lmoEk0E0WxkNe4TF0si+19kXdOpzScnW/1QB75/O9jc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=khRklH+A7OuOGfg8+26Fcw8HJElyNuYnbSlBb0/4Oynq86HPgLJMcMWkZXMCQ4mhEgy0szXC5+L/pxK3yzecM/bozoVtnOI0JJjni53PmCkaXSMcphEQKrRFB6CoQ771HAQ408TvA65vMWTHvDTHKZbQ9zjq7BaGueHjOhcB1zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pAlZS4Fl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAlZS4Fl"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so2405035ad.3
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 21:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783484593; x=1784089393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YXGwDIVYfEp4SrDevpmsoFqCz02J555zuiOM0j7gxMQ=;
        b=pAlZS4FlyL0XFbQ1gUDQ6v/Y8vRhZgUOQ+d3zvKG4YDtvo9y87MnK83D2m778NUkBa
         qK75ADTfAJO1+HNOgOoY/+uVfi5beWrpWt8HCAiFt9q3uWE61B/Nch+3VbMG+qh9exRn
         OYrihX7YDWQWm30kY6Gr+hDDAQacWR7g7c4tQFAPr3vSH0DKCJNg+nGZPZgTqDSYxpAe
         3S10bMTHzciF6UaOyvGnm72X503BssLT/ikP5jjjvTacyy1xZpt3Pre7aqiW1AHNKvHS
         5bv4ecFUGjjBzDXykajcl7sKDiKyLb4pQ1617+yOM6SZcLILLYPUx5ZdV1kBJtNgw/2m
         7yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783484593; x=1784089393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YXGwDIVYfEp4SrDevpmsoFqCz02J555zuiOM0j7gxMQ=;
        b=YFVHm6y9z3NHSc/rJlBkjcrSDVp0Vmce34PTxEX7ko+ONh+qZQN2gZ+8Z69MzEQMbh
         C/qSUKPYep3VfdVHedIrl1UMeV83gqOpj/uSK5UktqZGCnhsCrFP63DkqC3WNSWLnfRc
         aP3yhiYUxhk7+NUkwgHBBpqGNYydpKiauYzIj4j29GPfGsDtotZmXXxeNCgG7BsXIjtw
         XmsMK/Ny7Mx3M+Rfb4kFAd6WGt5LejxCwvtMdoqtWUosrL0Mu0KC8GcFRTStVDorq/Nx
         d4UE1l/Ci1pokNI1yfBCjf4vTYnsokpf195PWysTMldsB9CbAMVGexpYrOv1o9C7J0r7
         cw0A==
X-Forwarded-Encrypted: i=1; AHgh+RodDt6qf38gbD8KkS9dMXJBReXzE7Xjwh6UkMTmSiLfCxde+PihvvgXcgefmxYfOdnL4gG7wd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkVjitteFPnR+Om6jza3E5ASeftD4R29od8aM6bYSaxYIsQ2Bc
	3bz6e2kt5NvR0qIlxMj6NPggtlJOv7CITnKrfpLJcKp7iAijZAlHVem6
X-Gm-Gg: AfdE7cmPp1w43HoxuhYeoMcyfL4YS6w9Bx5Rr2z7I6zMV3KRIX4cRI1nyGZoni88ySV
	RWyOkxDVRrkRbWriTSFheuJwbjh6gMzA4xnmMmmdZetI8vRHv3Y2HloPpSHwINxfHLaW6odo3YC
	HDEFXiYKxaSn6LqcFz37IGUy1iEJRpgndiaUZxwx3hx5jxPVw+x8X0LExRLcl/wMhRq5ElSWNwy
	B3YVtSu9UEaqXM4NU1esYMPIybQU68aoD9dz7FaswlAZOU4tjdDaS9jleoJ8EL0sVLcAAfli9kB
	n9wQb4s9qe6gFa+kj/dNoun/gPDtQaQWShLJV4+528g8eywYyWrIS+95vviHhdzL7/6MmE6CEOT
	PM1bQqpG0KZy3+UZ14mv83EeLYX3MRcv26n/Ny9vOZcbf0Sl8kxLgA0kWYMOP+sZ8yBGoRycdTo
	MSjqs3JpEDXtKKwiIyxUC2OQ==
X-Received: by 2002:a05:6300:85:b0:3be:b0b3:3962 with SMTP id adf61e73a8af0-3c0bceb31fdmr771855637.9.1783484592882;
        Tue, 07 Jul 2026 21:23:12 -0700 (PDT)
Received: from c79home.localdomain ([14.127.26.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af6e04fcsm1814096a12.4.2026.07.07.21.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:23:12 -0700 (PDT)
From: Zhixing Chen <running910@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	Zhixing Chen <running910@gmail.com>
Subject: [PATCH net v3] gtp: parse extension headers before reading inner protocol
Date: Wed,  8 Jul 2026 12:22:44 +0800
Message-Id: <20260708042244.120898-1-running910@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GTPv1-U packets may carry a chain of extension headers before the inner
IP packet. The receive path already parses and skips these extension
headers, but it currently reads the inner protocol before doing so.

As a result, the first extension header byte is interpreted as the inner
IP version. Packets with extension headers are then dropped before PDP
lookup.

Parse the extension header chain before calling gtp_inner_proto(), so the
inner protocol is read from the actual inner IP header.

Fixes: c75fc0b9e5be ("gtp: identify tunnel via GTP device + GTP version + TEID + family")
Signed-off-by: Zhixing Chen <running910@gmail.com>
---

Changes in v3:
- Refetch the GTP header after pskb_may_pull() before checking the
  extension-header flag.

Changes in v2:
- Add missing Fixes tag.

v2: https://lore.kernel.org/netdev/20260703093708.18141-1-running910@gmail.com/T/ 
v1: https://lore.kernel.org/netdev/20260703084244.59077-1-running910@gmail.com/T/

---
 drivers/net/gtp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index a60ef32b35b8..c0e38878af51 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -826,13 +826,17 @@ static int gtp1u_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
 	if (!pskb_may_pull(skb, hdrlen))
 		return -1;
 
+	gtp1 = (struct gtp1_header *)(skb->data + sizeof(struct udphdr));
+
+	if (gtp1->flags & GTP1_F_EXTHDR &&
+	    gtp_parse_exthdrs(skb, &hdrlen) < 0)
+		return -1;
+
 	if (gtp_inner_proto(skb, hdrlen, &inner_proto) < 0) {
 		netdev_dbg(gtp->dev, "GTP packet does not encapsulate an IP packet\n");
 		return -1;
 	}
 
-	gtp1 = (struct gtp1_header *)(skb->data + sizeof(struct udphdr));
-
 	pctx = gtp1_pdp_find(gtp, ntohl(gtp1->tid),
 			     gtp_proto_to_family(inner_proto));
 	if (!pctx) {
@@ -840,10 +844,6 @@ static int gtp1u_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
 		return 1;
 	}
 
-	if (gtp1->flags & GTP1_F_EXTHDR &&
-	    gtp_parse_exthdrs(skb, &hdrlen) < 0)
-		return -1;
-
 	return gtp_rx(pctx, skb, hdrlen, gtp->role, inner_proto);
 }
 
-- 
2.34.1

