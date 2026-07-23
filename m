Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EA93B6BF3
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817780; cv=none; b=CKwKH+kzOpugIBFdiTVbMa/wJtAqpyxAMXS9hi/osz2+YRIRb/pP+jiNTSAcwJtm7jLPt/+QwRr99h6ChBX9v6/0NWMyIFu4kFdWNmWALx7m18MFt96t6dVNFRoBFPuebyw8X+SHgJw8gY2upqg7l22LM1nSzhBAzRIpMSdTjHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817780; c=relaxed/simple;
	bh=YzXfGSA4v8iBluAtw049vOGF3tTA+JQy0e4hNtNAP1U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YDirj7MpgkeoYMtAYLcB8Gr/PArgv52yoVjXDSHm61q+h0EOBfjG2M9Zy2Enc8ec6lM4xRAfELbnTUTBoshJRl/t1+mw4qKxnHWSzOihBKBGDxZsnSnFVVRAhREwMGrds+orYZtm5vb3tr1W+m20KwfC/Pdas5TMipM7gTahLw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KpYjhdM+; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KpYjhdM+"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e4f946461so153830685a.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784817774; x=1785422574; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rzs1C1Mae38rnEv/GWTjDvVyUY1VhGDhiiw8EJ99y3E=;
        b=KpYjhdM+FqgI+ILTodBQgrh0SN0qExWW6WyMwkm4IUAb2s0w92GoIHx1kmcTMqqqeE
         9ZJORQ95dnAdNI8XgZK0rwv/L3SlTsCee0lPeWfQjL5Q6O0HXxayyjy1cn23E59N4MQ3
         Yg/jZPLgPBHGuUJqAAMjm/tPtLJsSEsmZjBmxBwCZgTCp1+F5OKFAoHCeH8ZBKxlmwql
         +cahrkA33C0MKmSCiEEij72ktgDSB9WwjdfHAuBHTquBlbJdbseCnAJ+qE+mz7dU5VbM
         M0iPQPkaUfy9cf/mtL6snSDTkaudJJ4hSWcpAvqiJ4+RWsCmi975nKRPAS0mBoEwtktS
         44YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784817774; x=1785422574;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rzs1C1Mae38rnEv/GWTjDvVyUY1VhGDhiiw8EJ99y3E=;
        b=DyRhwnNzduSU0R/mwZCvQD1HjcwqcJC8D/70udZa0JwCPgCfe5XZBWD3qQ0S5g3ktn
         pEoNOZV5vzNRAlt2cRyEabq7YC/bF/Gkc+GfvwiHQ2QWu2nVu7BccU6RLv3LgB+NOOJd
         h/3gOelUBr+m3IZEEtTnDZtcU8e9sGdY74y4kaDis5KYliKxM9UyiVmbDhxJOwWE5QVM
         AyybqBFjzYFvzgdZ+KdU5TWrvFfLtNt2CWm/9/UHYsBIhKGqugidmglVULsYHMHtbib8
         Z0D6wgdVjBZiTa9yv02jHBh0jaFJ7pn62x8ROduLyrDIsQiLCxYDWHSI17agVNgJCePx
         jJ/g==
X-Forwarded-Encrypted: i=1; AHgh+Rq89WgD9UJd3jHps8oxZ1O8NBtJFfXTWSfo3f4mfPCg/OPeTFAORGMHqz3tLH4Emr8RlPq+Oz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYbMSF6ncdU6GXoHA0/avLXECuBsdB+jzxA9gNWOnk+MEqcghM
	NzMCLadH/CAKnBv2P35G9xLonQONTN77SdfYiUZembxEqC749BpQcnZG9eD2eRiIlBLc38z5N7m
	+vPBCLfQUDoKAsw==
X-Received: from qkoy14.prod.google.com ([2002:a05:620a:25ce:b0:92f:e7b:c025])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a0d2:20b0:92b:1233:9a2 with SMTP id af79cd13be357-931035ce713mr250335085a.17.1784817773770;
 Thu, 23 Jul 2026 07:42:53 -0700 (PDT)
Date: Thu, 23 Jul 2026 14:42:46 +0000
In-Reply-To: <20260723144249.759100-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723144249.759100-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723144249.759100-3-edumazet@google.com>
Subject: [PATCH net 2/5] vxlan: unclone skb head before modifying eth header
 in route_shortcircuit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When route_shortcircuit() performs L3 short-circuit routing, it modifies
the Ethernet header of the skb in-place:
    memcpy(eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest, dev->addr_len);
    memcpy(eth_hdr(skb)->h_dest, n->ha, dev->addr_len);

If the incoming skb is cloned (for example by packet sockets, tcpdump, or
dev_queue_xmit), modifying the Ethernet header without uncloning can corrupt
the packet header for other readers holding a reference to the cloned skb.

Ensure the skb header is writable and unshared by calling skb_cow_head(skb, 0)
prior to updating the Ethernet header. If skb_cow_head() fails, abort short-circuiting
and return false to allow standard packet processing fallback.

Fixes: e4f67addf158 ("add DOVE extensions for VXLAN")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 9060a1259ac283d4db4b7a854ce74203496e9313..fb4a706cd5786d1937b1922acced31ffdb187c2f 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2163,6 +2163,10 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 
 		diff = !ether_addr_equal(eth_hdr(skb)->h_dest, n->ha);
 		if (diff) {
+			if (skb_cow_head(skb, 0)) {
+				neigh_release(n);
+				return false;
+			}
 			memcpy(eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest,
 				dev->addr_len);
 			memcpy(eth_hdr(skb)->h_dest, n->ha, dev->addr_len);
-- 
2.55.0.229.g6434b31f56-goog

