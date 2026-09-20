Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49562333730
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 00:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789865270; cv=none; b=ebNJFP24vX/5LiZNUVJZmR5uPqMw6sf2y2yCc8QjG3N9MYny1+/PJKvJQl4NbX+EldtIKnYle1cpfmdJNmoPInpUHDqyskUfgK/WbujJO30/eVXCGkB3TYQPb6ivu+FocJEoX1lswlABOcMAKONAfbV9H3HNbbfUA1xZ5mK/GJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789865270; c=relaxed/simple;
	bh=i0mBiP1JkgHcESHm7CxWXeGEgOSmLAz/z/JCtwsAP8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFy1xw58yVwvcXg149v8GmDNwpnjAwPOcj/FOICD/oPEaOjAxOapfRcvey2bT3hp3kF0fOumM5wjtLalHrnAjdXON0lFLPBlgft5IbQtaImxU+EFKEdp/2SnB8LvS5GxotjFdmv1DcmIn0tgEWIJkXrbDuIkbyIULt7nQtaboxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeGX/b4/; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeGX/b4/"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91235f46716so19419286d6.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 17:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789865268; x=1790470068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xNRwTnv6INwJTRG/2/luNN9rurp+iuSaljjyDm0JWe8=;
        b=NeGX/b4/PwWtI9F3DrsGjlaPrG9J3TBpyd5GcR7hqgCW7H5/CPj+rS//0CAtviCUQu
         Hl4/hL+8cApiR/9BDT+5rK8t0oXMI4IrHhmcW/BVXlhQ1jsPssDeDOMb+d4gKX/6+Fxq
         E/r77W2nTxUIkWgu8YMnw4jjE9HpXfHjpDPC45tyPlRk7RsCicyTxkJSXARzwqchxWk7
         KU4rvABJNfT2/cXGal5Xb9qLBaeRkCmcPqpDQhxdSBTWKQypigQtQ5Ag1P0M1SdU5iKX
         I3dJl9/YWLKL7b+JrFBDPSYbvJJUpajWWt+F8uZngK4FdTsiBsvyNaS1C1uIIqIGub/n
         0JzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789865268; x=1790470068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xNRwTnv6INwJTRG/2/luNN9rurp+iuSaljjyDm0JWe8=;
        b=kBP+qC9+ykoehajX0ouBZx8hsptO1jKsE32bYRBsmyysLBHPA5SgczPp3YjvIuZMcc
         +9RQkdwyUJKj4H1t7IvyBsWJA+LiGEqqkmtH4sLdQXHUEp4vqbFvbavA5cBTLZxPERuF
         pUZJILqNh1vbX1s2/oW0ac7HqA0frc0I5yD0e4NYxGADbta7WR7knqAApAkXjfkZF/rr
         eCaYHZgh0PHfwvLkauLLECmPpOBgVqzLNu/wuAcbo/BT8czX7BlFZhLPNDci0A/FZoCt
         aBdSHvwDF2Q12bVDNwD2LcFmWidQ+zxJzNZgY55gKLWiXN/oN7OXBg5W8LnJQdQ6Kx3u
         YDCQ==
X-Gm-Message-State: AFuF++moCx3QOy5dvv/VQUAsoZpGuLt2KhvjKXoor2/8ZDw/rvy3d7M5
	1Jbo6EWhJVgMIwBscd2PqVJNgAhQ5cjBEEsw5ieVGXGJKFaiai+VYI+kxLEzTV7rfPY=
X-Gm-Gg: AYBFou2UMhdAKZU6A6ueJ7neFE7Lg3KBML6xnjyPrV5sXsy187DqdK/wsFsZrOIx1pS
	ErniecdiVEuGWzb0yQsqBtGqNG+p1EGNULrhHB79qeZt9ubboy5hiobe/iT92yJShh46wXw3cXZ
	nwrzgl3Vjsf0+voX1ZMOEi21rjjLKuAU0g0Yrqlj2gpMxZJWZSMuX79kymRK1WA7wUqltmU0Nqg
	F1ygpRkmC1oAQo/VDhK+gQeE9cmwQYakI33baS9Q7OkhatMR1UsOX76wK17VCN2Q1m/TiSTuRA5
	uhYoioCBnC894UEM87jICL6SdIQXiVrw6pUezQhd7qzINkrr+1k5489VsMX60QSGBGefIaha2TT
	PEkfDbdlTqOYxFb2kW8TswHh3ObJ0/WckJyyEHIrYcB8W0dFfSq+KhJBdByjabx8D6tnQJORiee
	g1xTUkUZ0gKW0hckBjZbhyBWW0GhU/8AadSqsd2v1D4Vh5io8rt16p8E3NmphqdYr6n3XbVyNGn
	wSwXDdu/b+Fp/u7UXJgA5L4natIk6JW52nZIE7EvLpktrv3zFdNvQpjE4bg5gd3k7SrBAxy
X-Received: by 2002:a05:6214:e81:b0:912:517b:90d with SMTP id 6a1803df08f44-912a9b49deamr40829346d6.44.1789865268273;
        Sat, 19 Sep 2026 17:47:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:c8b1:39dc:7ddc:dd0c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9126078cab2sm32122436d6.0.2026.09.19.17.47.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 17:47:47 -0700 (PDT)
From: Paulos Yibelo <habte.yibelo@gmail.com>
To: netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	hannes@stressinduktion.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 1/2] net: validate virtio checksum start after network header
Date: Sat, 19 Sep 2026 20:47:32 -0400
Message-ID: <20260920004733.6473-2-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260920004733.6473-1-habte.yibelo@gmail.com>
References: <20260920004733.6473-1-habte.yibelo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__virtio_net_hdr_to_skb() rejects a CHECKSUM_PARTIAL start smaller than an
estimated minimum network-header length. The comparison currently uses the
offset from skb->data rather than the offset from skb_network_header().

For an AF_PACKET frame, skb->data can still point at the Ethernet header
while skb_network_header() points past nested link-layer headers. A
checksum start at the network header can therefore pass, then target byte
zero after those headers are removed.

This does not require a virtual-machine guest. A TUN device with
virtio-net header support can supply the same checksum metadata.

Keep the existing data-relative lower bound and also require checksum
start to follow the estimated minimum relative to skb_network_header().

Fixes: 49d14b54a527 ("net: test for not too small csum_start in virtio_net_hdr_to_skb()")
Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes in v4:
- State explicitly that a TUN device is sufficient and no guest is required,
  as noted by Michael S. Tsirkin. No code changes.

Changes in v3:
- Keep the network-relative comparison on one line for readability, as
  requested by David Ahern.

Changes in v2:
- Make nh_min_len an int and remove the casts, as suggested by Michael S.
  Tsirkin.

 include/linux/virtio_net.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index c381b91..a95ad46 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -52,7 +52,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 					  const struct virtio_net_hdr *hdr,
 					  bool little_endian, u8 hdr_gso_type)
 {
-	unsigned int nh_min_len = sizeof(struct iphdr);
+	int nh_min_len = sizeof(struct iphdr);
 	unsigned int gso_type = 0;
 	unsigned int thlen = 0;
 	unsigned int p_off = 0;
@@ -104,7 +104,8 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 
 		if (!skb_partial_csum_set(skb, start, off))
 			return -EINVAL;
-		if (skb_transport_offset(skb) < nh_min_len)
+		if (skb_transport_offset(skb) < nh_min_len ||
+		    skb_transport_offset(skb) - skb_network_offset(skb) < nh_min_len)
 			return -EINVAL;
 
 		nh_min_len = skb_transport_offset(skb);
