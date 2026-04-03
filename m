Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C443284B2F
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176566; cv=none; b=S9tnTT5BnIrC9cPHJZfePJEvgQUGcnpdA+Db9lmgnf4etNDtBNBeDKYJKWtvzYg3oqAKh/P5kH0xBXwcJZnPlqlgLroE4idwBbiMUlx4m4ggphkdNkXT9bWJ2dtCw6b0OLaEVXQM6quYyVGI4e1Ld7R/uMNUJVRARRWGEf1hvKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176566; c=relaxed/simple;
	bh=i7LlFWSxtXSqs68JNjJJCKZTHI6dOrsEB4tMckHBawI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEZl2yv9K9IEX+dMHqi6e7RrLTNrRIQrrq/6mFyLbSC4gtAGpVSRcFhK4XJ3+a1Q8uTMfWty0ZCho06R5RoYdaiAXX4UpT0lknAfoZQK38xz8TZRYOgS92cTjSEOC7IHYjx5b9yYNBg8NGzuobPub5ikCc0HtuJ7oTO0HEa/JSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=MmAe2Oze; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="MmAe2Oze"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82d03827316so394516b3a.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 17:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775176564; x=1775781364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhSdyxItZF7Zo/U3S2uuQtdffY9aqIoTVtx9G17MmZM=;
        b=MmAe2OzeTwiq35q7vkF9ovVPa2opHPxGRfP3ECPEGhizcdzSqreUwbBgVmLwz1CP8E
         qui2QZubVpcZfZ13kCkXoAZscyS/TMW8GFJnXppjSgyN4ruILDcF9Gg4d2+aKr4dxety
         Ms5fj+dkcqT+Dx3f5zCzWTLxMlJ0QNMB688/0CvfUR/NFO+fVq7sVxwtRyoPR2r4LE+E
         FLjK5efaYcUtu7v6TdHs24LydcpPFA40rpLhhCScD7rFGt2DPXrLUDYI9B4IH/Q+HFby
         9mFC5WVH4SmvCyKd32TufXpJbuFUlsTv6qM9HzCDSr2QiIF5Q6nDDqu3cr1ERrL3M8QZ
         UP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775176564; x=1775781364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DhSdyxItZF7Zo/U3S2uuQtdffY9aqIoTVtx9G17MmZM=;
        b=pe7SqvNEjgcBVq+CvbwHUtRIZ2pToHj9jZdyrd+BhdUdTPyZQsTACH1UA+imuueTBc
         Y/kDLLQG4Sa+eZMPcQeyH/sCW4uB6GsYmaRE1LQYrt156DtOiqAMi8I3BP0IJcaC7fCW
         LsYVI9sco9KVgxwzZIohm0P2hdB0HCwGUaqqqFilAfR6oadvS+hWkp6Zo2GgYLrfyczD
         xgW6+ti8K+yVZeRQT2D3/CjHuML/romphulqTLViMGX2cmJ8mzoq78vsV2o18bsK+Lmx
         U0cLCLkUqi+ZLC0vFrcxCtkkwVHd3KRc3oAdcyduV0CJhbUPJQWbs0A5mZRoKeV77LcG
         x3Uw==
X-Gm-Message-State: AOJu0YwIJVHQ3qEPAmEANudntpJLxHyThAC3ICM1kAlMunN2CDCF2CB6
	rsRCqbYCYvPjYa+3aVnuWP0JaUwj8j1hASn5nrlL52zEk8Yal9qwC9BJm2qD0kHYbfEstu/lsXH
	5ApVkQk0=
X-Gm-Gg: ATEYQzzUfx6F8XDdxuvXAZcNqBO1vi5cLm8b3oMegWo2oq9YN6LLPylboWMbWXFAOUD
	nJs8Te+IvVOGwkj+XyC1eAqfpYC2XRTFEwqibmSsLHTwgnNrjzo6XLnoh+sfKXR+mcyEIBd657+
	6B4sfCkrpWehIghcMZPJPBKXBfxsAHffI/bo15GKlXQ/6VmfFgFrA3EaBbGLUK/Giry/kjTOpSN
	BF1LiM6wvAHjnMjfcbj8IXG9MEMwZ/+HYatipdfcQC8Pphc0bJHCE93dX7X07X4fCGEDm5inMTz
	20M2qdCKRAGleXQjo+YzALIHmT9Ef02CpfsCe0elNs1gBhwVjaSYc5ZV/uqx0FOKgwCmT+2lQXn
	6iKyKuDPiQgLfVmuVGa5Wi1nR/oso1Io4jeHc3MTdJ6qGCqS/WqN3R73ie/clO89aeOjLpXppSE
	F0QJ17
X-Received: by 2002:a05:6a00:421a:b0:81f:32cc:b1fc with SMTP id d2e1a72fcca58-82d001e9b4dmr4081991b3a.3.1775176564568;
        Thu, 02 Apr 2026 17:36:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c41bc6sm4252084b3a.29.2026.04.02.17.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:36:04 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v8 09/10] net: bnxt: Dispatch to SW USO
Date: Thu,  2 Apr 2026 17:35:16 -0700
Message-ID: <20260403003524.2564973-10-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403003524.2564973-1-joe@dama.to>
References: <20260403003524.2564973-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire in the SW USO path added in preceding commits when hardware USO is
not possible.

When a GSO skb with SKB_GSO_UDP_L4 arrives and the NIC lacks HW USO
capability, redirect to bnxt_sw_udp_gso_xmit() which handles software
segmentation into individual UDP frames submitted directly to the TX
ring.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v5:
   - Added Pavan's Reviewed-by. No functional changes.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 82bab63b5821..a89b0927118c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -508,6 +508,11 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 #endif
+	if (skb_is_gso(skb) &&
+	    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) &&
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP))
+		return bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);
+
 	free_size = bnxt_tx_avail(bp, txr);
 	if (unlikely(free_size < skb_shinfo(skb)->nr_frags + 2)) {
 		/* We must have raced with NAPI cleanup */
-- 
2.52.0

