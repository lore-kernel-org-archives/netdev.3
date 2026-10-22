Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660950;
	b=109X7cFdMgQ0SgZkhuGnWOt16f4N3lz9/mkDjvJlf2p5OhRDzFaOYNUROtCDPJD1SXcw
	 xsM0DAKtNveoUk0RMbjqzxw5qDPntgWQe/mqjUu86m2hgo1+BbkFPcoxcow2GaCwZPyEo
	 9verPB1YJlM/b0NQvSaJ6y8zAIpfO+8R+HRAF7OjoSoW0RYPkTviMcy3zvCZ50KQBjkU9
	 nHwdfYulOVqZbcV2Rrakm0HRraW4cdKRtCOcRAs3AEkv3Ckl9qpPJN/lzo6Im0xsce+4/
	 bny7PMENi0YeRSfU5sJvk+sWlsk+BX4dhn0eDWY+eG3weDATEBY7Iit+ByRpybafhJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kAwFyiGlL69edCRWnCYWnDbLZUd+/qfHv9HYgOhIe7I=;
	b=RYc7rC7shgoa2BfDNx6zOKCF/NnN59AnyuNmU3IRpJvv4IqrIcKi1+21AnSrkFQyYODv
	 YTVGgwSLyY3OgZL73kaOwVs5N7BECvMA3CpJkFCESo16WcOWmvkEZpBPS4kmIOVgUtvqv
	 adcpe7Y8YtFwhShjzJf+3b2es8h+Tbl1vnUoj2Hvb3KS0Fk92drcTuLbwKlgfLG5KmDoK
	 IpN3gokVSJVbmt9TcQXPh7qMwKTRuWzM6HtJKHanh7EEhNKepVHNb9uDLAJbywU0MPaXB
	 RtrPgPPXlL/Dp39jgfXgNaUHvv/So8XKo3+zlhhbKAE3g9TO/a6GypnYHX5IYnQzKbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=dPxWFIdc;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D78606A322
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70D78606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=dPxWFIdc
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91ba702cceaso20460616d6.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792660949; x=1793265749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kAwFyiGlL69edCRWnCYWnDbLZUd+/qfHv9HYgOhIe7I=;
        b=dPxWFIdcC9xf1UkmEEILwYbOGS3DT4ZZjIpkMUSV9aBIPqT8XdKKGip+5aIKxEYgCM
         zC05Cum86WM3BB/g6uwptXmDR12HkP6YM00bKe08Hpj29+E1jMlKSGYRnnELp8Df2ow6
         f/xcnU5Bqs5LASaR9Z6t3IQq0VaM82SatTgN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660949; x=1793265749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kAwFyiGlL69edCRWnCYWnDbLZUd+/qfHv9HYgOhIe7I=;
        b=AMKTyYlsvmVgEwo6r8Z3QeXNLxtwm3uQXUBqxAjzFFZ+NS3mf4i2SVMBICE/NKmKg4
         NF3iGpDR6KSgZDJYu0T4iSeCNIwU7swkX+j1NR5WIXYNMyDXA4ghklEdyBsQBbHxaR9b
         6oy8HdWM12/VRV0QTE/Ei8YguLkmI9CH6onEFNnacJ7TC0gDURmK1x4dBaGPb7E2nHSR
         4BCu/OlP894ILl865kCaET9scPoX+kcaAwbGE8kHTbXj94iSYd8VVqvoBevHvq8kkITN
         Xg8jgdfkU/+D6ztBSrlcXA2qPI0lwEzWfIkz1kdgbcjo6EHsAnfzMRm/HI6uiHa7tsUv
         DyQQ==
X-Gm-Message-State: AFq9FYJS4ewv0UCioVpODyLpF49jKqoV/GD+gzDtiWCxdCGO9ygB9R66
	aVtO87glXl1Mp+ysrcvembH6PDWvn/1Jj30FYJVN1lgvsG4+5L5PPbuiUiFdsLc7sb9SDxQC1Ik
	emc4=
X-Gm-Gg: AYBFou1y6FgZwbkfEjSuRKm/TXe81MTR1McgjYGnBxnfWfRn3AW6dRmyBm8ANU4O8DQ
	ljtWnpYU1cxsLDOeMlnep/wMOm0b1E4qlCAG3PeZANCNKOEHqNUGg/ujz3iXl32cXiThSa6zZvW
	055al32x9lageIVj9Z+073V2kcdH91fkwHeNmEzLIlPMMdjQKO9WZPGByA6WYjw11VGFAJ9gV/c
	zK8m871yMfAPl4rI1HykKkO+QeiH/9sxeWRT0pD7rGP/mqlrTzyojre92LC09SqfbByqOljZXFp
	TGJDNZSe0lXAcI2+TeS5qnwbwOnSkmsxUp0aYR6A1Ku9K7ciprejs1I78TyzsRca2dKiaiBDx7/
	aN/0xgRcyve6hDpQ7zML36OnqGHf42IJvRiFw/iSLS6OpiZyLZlAdCeClqOIUUGOZOAKOVRWBKA
	+khUTloymVGBr2dklx9WcBfv9bu8HaqL1RTGUh9VhmZi42eS6SlHOwY6rsKZen/zy+P4nK4V52g
	HaS9so+eQHoBPBTYR/t+xe0UyCZYsI/QNxM+NmZtL1Qen78xJc8VxU7DCC8GJZJM1ik8Tbwuxgq
	Dq6SKQrmebAo0+v/vZ6RtFzmPw==
X-Received: by 2002:a05:620a:44d0:b0:93f:1af1:7952 with SMTP id af79cd13be357-93f57e5e325mr843876485a.4.1792660949345;
        Thu, 22 Oct 2026 02:22:29 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e2a60fsm469884685a.41.2026.10.22.02.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:22:28 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowangio@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/5] net/sched: act_vlan: reject short linear Ethernet headers after POP_ETH
Date: Thu, 22 Oct 2026 05:22:18 -0400
Message-Id: <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com>
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue:
act_vlan POP_ETH can leave a linear area shorter than ETH_HLEN; a
subsequent eth_type_trans() may then BUG in __skb_pull() when the frame
is redirected to an Ethernet device.

The Fix:
Drop the packet at the producer boundary when skb_headlen() is shorter
than ETH_HLEN after skb_eth_pop().

Conditions to recreate the bug:
- egress tc filter on lo: action vlan pop_eth.
- AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=28, and a non-linear
  eth / inner-eth frame.
- The pop leaves skb_headlen(skb) < ETH_HLEN; a following
  eth_type_trans() can BUG in __skb_pull().

Fixes: 19fbcb36a39e ("net/sched: act_vlan: Add {POP,PUSH}_ETH actions")
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_vlan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 6a375fdc63dd..ddf03b08bfe8 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 		err = skb_eth_pop(skb);
 		if (err)
 			goto drop;
+		if (unlikely(skb_headlen(skb) < ETH_HLEN))
+			goto drop;
 		break;
 	case TCA_VLAN_ACT_PUSH_ETH:
 		err = skb_eth_push(skb, p->tcfv_push_dst, p->tcfv_push_src);
-- 
2.43.0

