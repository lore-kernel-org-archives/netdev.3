Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E308315D5D
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787926651; cv=none; b=pIaPWJLKGIZFzjuVnAjcAj1hsk2N4cfGmR6uXKsqXg0Ec2zAwbrLupkgRtH7cFfocoSBdoR3b5ruXv3OGboGd2WD7aLy+6tcxaG+cc5fb0Qb4zqPevYrydcNGABYX4mfYrzq0nT+6LY007iXlq9VTWwPTRb74KccO+xyXdZvia0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787926651; c=relaxed/simple;
	bh=4rwDQZfMJFxDfNsC40a/7TUGeU8KBJVfQZW8IwAAp4I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gqpVprCzKRouC1L3D41DlEdZT5U5bsEf99Hc9ocThxAos4swraPAtfi2bWre53FP2vcI0+eUVLsy0UhxZl1W90VnLj6B9nqed4jDeGdMpxjFupLxdVdrjVLnAztvIE22QHgvwLW0JRJZQnE15RyHDzClKDzpOMBqSxDZMyoMIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lh1eRFJi; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lh1eRFJi"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930a098ea19so110424485a.1
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 07:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787926649; x=1788531449; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uraq+7UAx2uo8Q2pZh1fcNCoc+BxZilfMn21xfkQhac=;
        b=lh1eRFJia1S7mr4w3Gp0xZHMHioXrGduphBm/DUag9aTG0DQyM0dxf4nYvZxcbyOvL
         k9ChabaufAaf7r09GXC7Nsn3kAJhUXRGcd5b1cNZyut+3scCNtTGclWsevznUru5cJAM
         YzALW6YJ0X3yV/3mI3S5vZxSHIwmlmWi8LtBp4TwpPWzlfIpyHyaANG2J+LB5IrwhmU6
         1TqXL84oukyuM9Duvza0RoC/D2ZuHcXR0B5VbuXdrVo+4teKlbXqcUyhFwvg5Br04B2R
         M47HGum+Df9rWYV4VftJWbxRUv2F05vyY2bYoeubaqQw91Hz2lIfV2evevdfHiamkGxQ
         ZuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787926649; x=1788531449;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uraq+7UAx2uo8Q2pZh1fcNCoc+BxZilfMn21xfkQhac=;
        b=s5zXVCZ4eWWkE9OV3sN+c7Q/HF0FzgWDuEzekA0TYoqW6DYoZFNcpCRzX9c31v3kMJ
         E60zWa3LkjxXjgSQVjVeLpVOEks+x9SixIdCP4LJyqsSKoOKLUWXtrWRq/y+ugKJJP+F
         M8RM978fwzyveUKwIPEr1wWBow+h5O59/3SQUZI3NpHLg2AZ4v9Y173w5GK8DVjP/uN4
         AfnVEdQ1OgcdlO9qbWQvHSn8wsEfrci249PW1BsYlCu/YD7sLi0RbKMa0viuGOz+oikj
         RIaP++wOCoxEOMCzj3qjEJBNorsL8zcjfNLHakSE905Zt+SMwSv1ndIC74A4bLCi1/uP
         l3vw==
X-Forwarded-Encrypted: i=1; AHgh+RrTBwP8jyMJPoOmQJkhQvHp2AFW8d5ZJa7EXtwYUIajKO8NNTXShtS7qfDUiWFMyzKwA+zQ5P4=@vger.kernel.org
X-Gm-Message-State: AFuF++n4qHJFBWmVEAxAnOMcT8rNbCk0CGk/DTOTr6tOMTBclf2hLsUq
	islemnQ8t3UQiWHI9e82uLHz5qxSq53VeC+3rgySvuLJyZArOLDAkEVm6HbjAR8YICUDj/GtHUK
	hGD018L9Qmc+saQ==
X-Received: from qkkc27.prod.google.com ([2002:a05:620a:11bb:b0:92e:51f9:eef5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:c52:b0:938:7751:c0fc with SMTP id af79cd13be357-9391395216cmr749373185a.39.1787926648294;
 Fri, 28 Aug 2026 07:17:28 -0700 (PDT)
Date: Fri, 28 Aug 2026 14:17:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828141727.2372570-1-edumazet@google.com>
Subject: [PATCH net] ipv6: sr: restore network header before routing and forwarding
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, TencentOS Corvus AI <corvus@tencent.com>, 
	Jun Yang <junvyyang@tencent.com>, Fourie Zhang <fouriezhang@tencent.com>
Content-Type: text/plain; charset="UTF-8"

ipv6_srh_rcv() runs with skb->data at the Segment Routing Header (SRH)
while skb_network_header() points at the IPv6 header.

When segments_left > 0, ipv6_srh_rcv() previously restored the skb->data
position by pushing sizeof(struct ipv6hdr), assuming the SRH immediately
followed the fixed IPv6 header. If another extension header (such as a
Hop-by-Hop options header) precedes the SRH, skb_network_offset()
remained negative.

This led to two problems:
1. During ip6_route_input(), fib6_rules_early_flow_dissect() invokes
   __skb_flow_dissect() which passes the negative skb_network_offset()
   to flow dissection, breaking BPF and C flow dissector logic.
2. If forwarded via ip6_forward() or redirected via act_mirred, downstream
   handlers (like sch_fragment() or neighbour output) pass the negative
   offset as an unsigned length, triggering OOB memcpy or buffer overflows.

Fix this by pushing -skb_network_offset(skb) before routing, ensuring
skb_network_offset(skb) is 0 for route lookup / flow dissection as well as
downstream forwarding. On the loopback path, pull skb_transport_offset(skb)
to restore skb->data to the SRH before looping back.

Fixes: 1ababeba4a21 ("ipv6: implement dataplane support for rthdr type 4 (Segment Routing Header)")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Reported-by: Jun Yang <junvyyang@tencent.com>
Reported-by: Fourie Zhang <fouriezhang@tencent.com>
Closes: https://lore.kernel.org/netdev/20260817104128.22681-1-juny24602@gmail.com/
Closes: https://lore.kernel.org/netdev/20260827092345.2301937-1-fouriezhang@tencent.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/exthdrs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 51941ad656a36e739388c7da2fcd639ab0e453b5..09a4552f7f08aa8208eb981c0536c58a3561ecbd 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -445,7 +445,7 @@ static int ipv6_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 	hdr->segments_left--;
 	addr = hdr->segments + hdr->segments_left;
 
-	skb_push(skb, sizeof(struct ipv6hdr));
+	skb_push(skb, -skb_network_offset(skb));
 
 	if (skb->ip_summed == CHECKSUM_COMPLETE)
 		seg6_update_csum(skb);
@@ -469,7 +469,7 @@ static int ipv6_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 		}
 		ipv6_hdr(skb)->hop_limit--;
 
-		skb_pull(skb, sizeof(struct ipv6hdr));
+		skb_pull(skb, skb_transport_offset(skb));
 		goto looped_back;
 	}
 
-- 
2.55.0.897.gb25b4bd76c-goog

