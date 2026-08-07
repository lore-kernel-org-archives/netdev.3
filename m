Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665EF40D574
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098491; cv=none; b=Wf9UXjhh74lrXk77EPQ6hFOp/YEFVpwr6HqrOh5PfeD9IiLO444JzIHUdI50oMChyCQZ+LL2Moba14HiEHRXhKjEvnfKG0Y7Pi/oHimcyLjakGAHgHDDDzfe7TuSM8+c/lQ+Uaw1k6iZTwaSZm4NT8RM5ncg8venJv5/2aKT5U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098491; c=relaxed/simple;
	bh=ErZBopwSCFYY6Xt5AlHlytAUIuf7QvsKCVd5iqDu9og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ii6lvKqaLJaGHfYx1j5IFqIAiJNJIqbK8XPKNACK3H6TzMjqg7VtjRl3H7e8Ft9+wSXhDKHQtyiE3GMlGEDekFCLov1LmqTzRsYKi+48VhheAhh/RivFX0G9Z2O8MOzv4oJ3oh26ZMAxnITVPTvhFKBg3Swj6NOb0d+g4idIjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+JKheSj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+JKheSj"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso3745143b3a.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 03:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786098489; x=1786703289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+WovA3cxQnB6aNG5Ty5hjLP6m34s2wRruhqfi42xkSc=;
        b=L+JKheSjecM3bId9nTrNIPatyhey/+fV45WOcI0ZxJIjf/t3gxrm63pm3w0gQD+K39
         ciGdJY49nNUXImiTedgK/MRnBkFkGt6/gO1yVsb/cq7Ieur59yP71AaeEOcCF6/Kpz0y
         S6GCFS4x8mZrmNCNf5Y/BRhSp6ZvBnrw4+1aND8ifvB1Nq+saY4pvd9FrhODBd7Z1VOx
         4hyNPSh+duBBLFDl+IeHLnFzS3JXNZz8TwSlNmaJm2zLK0JWcSu0gbspzqRDpVRG/yNE
         //+/xfVHUCHCFihoBJ/TzDpxOHPk55QCbMwGL08XFXgKjmpOTiUT4aQNG8DVx2y/pEit
         8s/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786098489; x=1786703289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+WovA3cxQnB6aNG5Ty5hjLP6m34s2wRruhqfi42xkSc=;
        b=AbTuAXz51BNVYarVHrXSS0e27ShviXDoDZdI58JTOM/PF0IPsBC/nzdbOjaX+7iSm7
         cBS49BXeq19ZFyWp5JLxA1s1itbrH79Oa76M4xzuQ7Xq58Z/69Vu3F+s9LJB3+w/uGJ8
         X6e37fFOTmOWwfIcXvpVfxNljHIXQfzvtQbDXJO7kh8S6EbZsS7IzDh/gTm/8Tou8rwV
         HH01ck7Awt51OLRVMVHmtJzsCMmEc7yC2hpDIoECO5sW8y1GpCC8AKuki5GeLthtqmBg
         VFcG6AkvEZihWK+A8kVJ7neh5DJF+Ez2kpd/JAvysEK2anMjy89vx3YD0PRBxpIZNcGA
         6b2g==
X-Forwarded-Encrypted: i=1; AHgh+RqxJI6shRoP0lLsGsPCHG9bh8ztqiQVGRnTXqNug3E+ciC3BIwNSYYhLIsKCG6rYPjR2TDNtQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgOt1Te+7W8Ahk04o0LqOknODoXBWgMk/AU/LYgGGHk3/dhf9n
	SgYTsml7iBO5gdZ9u7bOxYV2PrIn5/VoLJ1p0Q/z7oRUUJF8GnuvzX+i
X-Gm-Gg: AR+sD10oKsl+JDRpMAttZ+mTGgK2qksGedQVSUEfj1knW8ZQBY7J7q+Bwh/jJAVehfw
	z0C4tf8zyXF770ns+Lgc8ERGKpaDWQaFkEGcGc5DnibHNzhZfIF4fIZbzJEck/t9qVyTMPWGE9v
	jnsh8IKPKWgcgGCusRm3Qt2AkbnVSGpcVbNe5wdtaqMgyHJMp6xxR39xIC4mw+1kgBAzjgJSTaM
	XSQhoX/g3DIf1znJJRnAlfGaZultdlsHx69xAwwyvEzEjFlRGE1Zgq3QkqK+BgUr4T2rs7DJeDa
	C7gGV3UMULCNwv7MHJUeP0k1S9PVBO28JR8HJcXAX5LQvwjwZ7Zk8dEUcBnS+v+EoHX/Rilp1fu
	n0LGRrGKffpvLOXrWQeOdJTsOhtuWvTTlAFUFxB8gUJLyGmhX7ndmOD3t8/EzVOw3jGMdcmW42L
	TudADdZXt1DpACbk4AO3PdgxA5P1HL0wb8s+kAIsCA8qZgNtnXcQM6BrRdBVEKDxTjhTsyj7XiP
	3w=
X-Received: by 2002:a05:6a00:390d:b0:84e:1da9:6a53 with SMTP id d2e1a72fcca58-84f2e00c2camr23590055b3a.19.1786098489246;
        Fri, 07 Aug 2026 03:28:09 -0700 (PDT)
Received: from online.mioffice.cn ([43.224.245.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3a1056sm843200b3a.11.2026.08.07.03.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:28:07 -0700 (PDT)
From: Pengfei Zhang <zhangfeionline@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangpengfei16@xiaomi.com
Subject: [PATCH net-next] net: ethernet: drop skbs with a short linear part in eth_type_trans()
Date: Fri,  7 Aug 2026 18:28:02 +0800
Message-ID: <20260807102802.1696827-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eth_type_trans() pulls ETH_HLEN unconditionally, but never checks that the
skb has that many bytes in its linear part.  Only skb->len is checked, by
skb_pull_inline(), while the __skb_pull() it calls requires
len <= skb_headlen(skb).  The two are the same test for a linear skb and
differ for a paged one.

Drivers using hardware header split, such as amd-xgbe and dwc-xlgmac, can
end up with a paged skb whose linear part is shorter than the header: on
certain frames the controller reports a header length below ETH_HLEN.  With
2, that gives len=56, headlen=2 and data_len=54.  Nothing is wrong with
that skb, but eth_type_trans() on it hits the BUG() in __skb_pull() from
softirq context, so one received packet panics the machine.

Drop the frame instead.  Test skb_headlen() rather than skb->len, since
that is what __skb_pull() requires.  Returning 0 leaves skb->protocol
unset, so the frame is counted in rx_dropped and freed with
SKB_DROP_REASON_UNHANDLED_PROTO rather than discarded silently.

Signed-off-by: Pengfei Zhang <zhangfeionline@gmail.com>
---
Notes for reviewers, not for the changelog:

We ran into this on a platform built on the Synopsys DesignWare Core IP,
where a single received frame is enough to panic the machine.  Nothing was
corrupted -- the skb was intact and every invariant held.  What is missing
is a check that the header being pulled is actually present.

The length in question is reported by the MAC itself: with header split
enabled it writes into the receive descriptor how far into the frame it cut
the header.  A MAC reporting less than ETH_HLEN there is misbehaving, and
that much is the hardware's problem.  But eth_type_trans() requires
ETH_HLEN linear bytes and tests only skb->len, so the short length reaches
the BUG() in softirq context, on a path fed by received traffic.

The same failure mode was CVE-2024-41091 when it was reachable through
tun_xdp_one(), and was fixed there by dropping the frame, in 049584807f1d
("tun: add missing verification for short frame").

amd-xgbe shows the same shape in-tree:

  /* On some frames the MAC reports a header length below ETH_HLEN in the
   * receive descriptor.  The driver takes that value as-is; nothing bounds
   * it from below.
   */
  xgbe-dev.c:1901
        rdata->rx.hdr_len = XGMAC_GET_BITS_LE(rdesc->desc2,
                                             RX_NORMAL_DESC2, HL);

  /* The length is passed down unchanged and used to fill the skb, through
   * the ordinary core helpers.  The numbers below are one instance of it,
   * hdr_len = 2 on a 56-byte frame:
   */
  xgbe-drv.c:2355
        skb = xgbe_create_skb(pdata, napi, rdata, buf1_len);
            napi_alloc_skb(napi, rdata->rx.hdr.dma_len)
            skb_copy_to_linear_data(skb, packet, len)    /* len = 2 */
            skb_put(skb, len)                            /* headlen = 2 */

  xgbe-drv.c:2370
        skb_add_rx_frag(...)      /* the other 54 bytes, as a frag */

  /* The skb is well formed here -- 56 == 2 + 54 -- and eth_type_trans()
   * pulls the MAC header without testing that it is in the linear part.
   * The patch adds that test in eth_type_trans(), just before the pull
   * marked below.  Without it the pull takes the machine down:
   */
  xgbe-drv.c:2435
        skb->protocol = eth_type_trans(skb, netdev);
            eth_skb_pull_mac(skb)              <- eth.c:164, unguarded
                skb_pull_inline(skb, ETH_HLEN)      /* 14 > 56, false */
                    __skb_pull(skb, ETH_HLEN)
                        skb->len -= len;            /* 56 - 14 = 42 */
                        if (skb->len < skb->data_len)   /* 42 < 54 */
                                BUG();              /* fatal in softirq */

Every step there uses the standard core APIs, and there is no skb memory
corruption anywhere along the way: the BUG() fires on arithmetic that
__skb_pull() just did itself.  A driver doing nothing unusual walks past
the one test there is and into it.  A received packet should not be able
to make the stack panic on purpose, so the check belongs where the
requirement is -- the stack has everything it needs to reject the frame
itself, and should not have to rely on the hardware or the driver
reporting a sane length.

The BUG() in __skb_pull() is deliberately left alone.  It is the backstop
for the many skb_pull() call sites that discard the return value, and for
real corruption it should stay a panic.

 net/ethernet/eth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index d9faadbe9..84914709a 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -161,6 +161,12 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 	skb->dev = dev;
 	skb_reset_mac_header(skb);
 
+	if (unlikely(skb_headlen(skb) < ETH_HLEN)) {
+		net_warn_ratelimited("%s: dropping frame with a short linear part from %s\n",
+				     __func__, dev->name);
+		return 0;
+	}
+
 	eth = eth_skb_pull_mac(skb);
 	eth_skb_pkt_type(skb, dev);
 

base-commit: 4fa4977a0d900f936bcae5cd2c510be5554e8dd6
-- 
2.54.0

