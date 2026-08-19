Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432122C0F93
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787182344; cv=none; b=VkzcxWzF9r/LcmlOYAt4oGILJqa830i4zoYySK/3hvHf7KEJOsYJAH1hTwovGgEUzJ6hisc+PGTmur6c+n4Zix4clQsEmZplKd2x8lbbv0HfzUtWk5gVsDDwIRB3chEBm4c8RxpiK+jHn3uko9LV2aAVSl2gtelukh9tVshjBIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787182344; c=relaxed/simple;
	bh=0IKdMwWw8MeoLI4HAXFOswTW0yNbMN9YDdEes+7tPUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kovaJwek353vdd4uyyYWcmnQZkSVUrTjyDZIDiUvQzpA3gebH3ErrB5Q6NOWTn7OO9Ygi2jVrhEKC918RAS/fpd2Hx1lnZ/btXLNS1/L3wUmcdLmK3TQcRP899DHR6SN8XpDbahIgUXDKMxh3m3nT1sXrOLdc3YofBk+q08PyCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=FlDFAKv1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="FlDFAKv1"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc891373e0so19447715ad.2
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 16:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1787182341; x=1787787141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QkfK+n4pBa8IvbBuEdCKRmANPwZqjt2vhK+NoTYINkg=;
        b=FlDFAKv15ooE3J6v61xuJsOC1B/oNdBj6waRKj6QpwuvnIedyEBAgAIB5W0J6xn8az
         ltcP0rTzzWBzaXai/Nqvuf4nQyGgWtsfQSdGtHInJ3d/jY7pdWUE4EYZ9b2S5NUKdzFb
         /HtUnAM61q03Zzg9bp60RtpX6fZ7DibxCEz7R5ZcBfbAtx3A77Mxld4o77t39FJlGwqi
         eHv/stTiOnSOVeKwDNk+tCT/Lk+3pF2UT0fuymUZSQeEC5w5lGK2tDicIlGSL143cdqN
         ao8W/ZuHIgdyEttZfyX1bckZ3l+uepa09taUUEZplHJA1V0RhRrfvOY9TjxaxfFpXjx3
         j9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787182341; x=1787787141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QkfK+n4pBa8IvbBuEdCKRmANPwZqjt2vhK+NoTYINkg=;
        b=NjKE87sgMQDdrJWo/+Kp56scQZYukMek3PrRkHMuGqtLVbugmUltQPFsDXgbIRZf55
         iZ8q9ZIQMTWqePKsKm1pTyTPe6ROLfAuaR7oBb8NZjH+fRnlHuSoz2rlXuJe2zArJmal
         uHjCyTCBcXa+4fkf68zWg/8SBpSu9n/ifhJGsHupW3qd8Ag3xzD9sE0+aVIi1HhqRGOo
         rFbJ7CmthMi03cABrf1KLnJgxEvKhz59PKP9EGFlXv2CvPzFkq6onrPHH8ngk/db48Zh
         w+aY6u7W6urz3saWrH6UBAn7t/C02G476grZMk7iGRFEtJhtoSD89bWB3+jE++uaohZX
         QBBw==
X-Gm-Message-State: AFuF++maPOxzDkxNUgE5sH5Bh2PdHV3haF3WlIAtmbGAebfMI38MjMBK
	i5QVnrRMZbLFDyadRC15z9EMUdRZ3yKARG6BgiuY/DkFJXzWlH+SN1YK1niXQUArP4ockv1QNdP
	Iq+Ae
X-Gm-Gg: AR+sD10CSV9uYi9/thovLM6E6omTEunrmaCGrGBQuqKXTGVZR4ykXD9UuZiPlmCGQn/
	ZJ2aIlMdXrC77dgZu348x8hq19pXTyBKDDhbPzYSmwDaIUY8Y+62Jl+XHOu2DG9+eHtxbp8kPKI
	SZfKDlfPs2AeKqYil8aUMpauYrJ1XqwFECIOlHqmCUZrhj5EfCZBDLcOBdxzAG8EBDV6gFFlWEH
	2MtvSLkZIhnaMc1t1JtdHV9mpYm9hJ2vgmWj+4FxKEqPVzXiRSUMjC++2Ifb6+dsjT46fKNQSEG
	QCVmBimw3cyNxza40HJIwyob4PB5E2mtX8h9JRPewbXGCPbc9lcXUhmcYPva5zQQCKWxoHXT9LS
	5JkkfEldyA6VxLnqHYi/raHtp+G4c/RqUL1E+KPnhJ3N/bOlcWgd1kJf1IGJA0ZAqFxp+yJ60yS
	OvGTNsVik94JAGn+dBee5A0xgwRRdbSIDwV+xBt26jkSs=
X-Received: by 2002:a17:90b:5484:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-3958110cfc4mr15615141a91.9.1787182341460;
        Wed, 19 Aug 2026 16:32:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395ada67783sm39772a91.3.2026.08.19.16.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 16:32:20 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: bnxt: ring the doorbell when SW USO exits early
Date: Wed, 19 Aug 2026 16:32:11 -0700
Message-ID: <20260819233213.3673149-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a burst of packets is handed down to the driver, the driver defers
the doorbell to the end by setting txr->kick_pending = 1. The normal TX
path handles this, but the SW USO path can miss it if it returns
early.

If bnxt_sw_udp_gso_xmit runs but returns early with NETDEV_TX_BUSY and
txr->kick_pending was previously set to 1, then the TX queue can
stall because the driver wrote some BDs but never wrote the doorbell.
The device won't know to do the TX which would generate the completion
that would wake the queue back up.

Simplify bnxt_sw_udp_gso_xmit to set txr->kick_pending in its success
case and check the flag on return. The added check after
bnxt_sw_udp_gso_xmit returns ensures that any pending doorbells are
written handling both successful USO and any early returns, which
prevents the TX queue stall mentioned above.

This TX queue stall was observed on a production system with a netdev TX
watchdog informing about the queue stall.

Fixes: cc5d90667db8 ("net: bnxt: Implement software USO")
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
---

v2:
  - Simplfy the patch as Michael suggested, setting txr->kick_pending in the
    USO code instead of exporting and calling bnxt_txr_db_kick.
  - Update commit message and remove stale comment.

v1: https://lore.kernel.org/netdev/20260818211540.2991183-1-joe@dama.to/

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 10 ++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c |  4 +---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9377bf675981..d3cb25abb632 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -485,6 +485,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct bnxt_sw_tx_bd *tx_buf;
 	__le32 lflags = 0;
 	skb_frag_t *frag;
+	netdev_tx_t ret;
 
 	i = skb_get_queue_mapping(skb);
 	if (unlikely(i >= bp->tx_nr_rings)) {
@@ -510,8 +511,13 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 #endif
 	if (skb_is_gso(skb) &&
 	    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) &&
-	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP))
-		return bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP)) {
+		ret = bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);
+		if (txr->kick_pending)
+			bnxt_txr_db_kick(bp, txr, txr->tx_prod);
+
+		return ret;
+	}
 
 	free_size = bnxt_tx_avail(bp, txr);
 	if (unlikely(free_size < skb_shinfo(skb)->nr_frags + 2)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
index f317f60414e8..f7e18bea0fb8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -223,9 +223,7 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
 	netdev_tx_sent_queue(txq, skb->len);
 
 	WRITE_ONCE(txr->tx_prod, prod);
-	/* Sync BDs before doorbell */
-	wmb();
-	bnxt_db_write(bp, &txr->tx_db, prod);
+	txr->kick_pending = 1;
 
 	if (unlikely(bnxt_tx_avail(bp, txr) <= bp->tx_wake_thresh))
 		netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),

base-commit: 61eb236c41c2a4717015dff18016a75a5eb90052
-- 
2.53.0-Meta

