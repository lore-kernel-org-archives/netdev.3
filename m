Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852138;
	b=47ZtOPBHPEzKC6FPZHG4Ygl5TImhrGajWxt+sz3aCWbjs4mxx97XW5YHKK4ShRcgV5/5
	 mKJUtV6SzTmwiltwLeDAwiF4CKiyGVq0KijphlFTI7swjYe+vPZDaTG8RUUxYIw242lVl
	 JdrAibqgQkZPmOk7wQurJCpyeuHZ7G1uuDwXjB47ltZcjZnZOkfchQLHdW9iFEuDarPB/
	 8oogtjdoGatdmvoTTm8Ujy75Y17effe9tAK08aj3zvE9hNHEKsdRadYGQP8TW03hTLWZ8
	 vIXsQN4lZCfQyUI7UFQoROCVJBUwJ9hDTJOMaWaJLQpEUhmIFadQjP30K40d/Z5+KOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ai24WEl5RPn/XvUk05mE4pUqYbTqasZdMRowqTpHdk4=;
	b=wybMY2d4DinEekWvhTSS12wQp31xijZcFJjzpHVtkURPCkxGq6BPafNS8Xzs/r8vCDqX
	 ZLNbZIz/W1HY7sFYwBONWtnvIm+o+JUrVctH7ZiCq9ClPrOV5CoOrOJL40Tr71ZWFeHdI
	 3oedln4g/JqEWNfBELyPt1/resmnHfPpGIuBcQrd7lA64osQHj4V6Msn/mCSsPruxHgSJ
	 bIz0oeGX/wv80ag3Yb41HpxpIU3L0LNplniZsxcnkaJnwsGLCBhFnJ/ov5rNEU/EIN/O/
	 0ut/KayBR4WKUX+ngv/NazbE7mAj+G/+Z2bFm8XT16eOhSe7k4E3MbSoCs4cHCGcOUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=EvLJFVSP;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D5060A260A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 14:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92D5060A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=EvLJFVSP
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91befe703c4so13497586d6.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852131; x=1793456931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ai24WEl5RPn/XvUk05mE4pUqYbTqasZdMRowqTpHdk4=;
        b=EvLJFVSPTQffcppTJz0jaei/0P9Zk8/CWj9KnjzCJprqTxxeB2RtoWzIUS++YIILy9
         jdFJ7SLbK4J9xMbH5bIK7tv2p4tMqRUQgAeCPvqYNszxUWOUbA5T8gt80Jn8fAz/FpSi
         kw5StGFMahVd2Oo9kD4c33uglz3XoGW34SBwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852131; x=1793456931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ai24WEl5RPn/XvUk05mE4pUqYbTqasZdMRowqTpHdk4=;
        b=Fia2F2UmiKmUPVW1ttMzeBYAEi60KUuTiDVn1ATGT8Oc55gD4eUdy3lU5LgssqrFED
         dkXPqNB3bu2TeHttuMazla9ALTf2wVISWss4tko+C7awkBfhyLJ4I1H0akLUaFYqLOEA
         DOJWxvf+LfdTRVfMcqR7ci5tKCQSEHSnkRs1RWz9HQw6IrAGg1g4FNU3Ocl3o8sUOT70
         VjJsW+dkiLEQjNbCJAA2eDeDOad8QJ53eg3vkgqndFySkLax14mvOFXt9KqC0rGu1L7d
         /0uZ83Ex0jh8lIbQaVSA7AhLTFwyPZrfKSejc3kUI7QdjjLJdTlC4RXr1ol+t2bgJNKF
         ct4w==
X-Gm-Message-State: AFq9FYL0aIT7AROzjKDKTFPlcTuly+GffFo9Qp5bB8+XMTdrHlbgqSkt
	W2Ngd32rO54ah5ShRgUaVQ/QgLhWT5RJbRG52hUQ+szQlz+6nGtNvPhHwZHVxU2IY4rj7plY+JS
	GW+o=
X-Gm-Gg: AYBFou3xuEoz3t3h8Aheo5Lwdtd1nLj1SWjsSkYyy27Ja9rDqCMTru+b7TFpSfkwkio
	DDnYfqX9PXyqbtXWFW04n6iT4VdlFqfoVng60EVoVwPrvZYg3NGMZHkuLBcrgAYd69yVqQ5pX7V
	HhUxFwXZTQl6gzaWeUW4p+6CozxKSyjFE1DPFbbfc0mwmbnta1kyTPyKJ9lTpsI5XGBBdz6zCSq
	nt/Jnywt33PK/jSzw485N97IWpLJvIJqwwPm7IRxeR4+sJHDwq/mZc5uqbLH6STmOwRLcyZTdLr
	Iqrv75dvdlCiWxclDafA6cP6WHlM+BMWWTNLawR7LmLTLRwu7MeTltro3TUtajDyaHsl8AAHuST
	u1f7g1yAaSLojazApLKDb+QXjXiD/cUrJJHiqX51q2MpCZqKudu+L6LUfGk+5M5RyxxwGhlEFQc
	YGAq0Zyozf7kG6PaptsvPm+t8N4bwk7YF4IpMqDNtFzGlc7gAqSicCJS/I4gBT6NiJ/3tJ+tlBn
	42C17TCw0jw4JjIuDMTEh2NWr1cfRO7HGBsWb8VqzSKGbwq+0QZT7JvrkyaYwyWAbwboDcs54JH
	NU2ORxdm5/YUsDeJAfKXfZBIh346OxgPh8whfBhmhg==
X-Received: by 2002:a05:6214:dc5:b0:91b:ecfa:df3a with SMTP id 6a1803df08f44-91c48eb32d1mr31114106d6.50.1792852131533;
        Sat, 24 Oct 2026 07:28:51 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a7cd7esm22349976d6.2.2026.10.24.07.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:28:51 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Martin Varghese <martin.varghese@nokia.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Vega <vega@nebusec.ai>,
	Willem de Bruijn <willemb@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/6] net/sched: act_mpls: pull the inner Ethernet header after POP
Date: Sat, 24 Oct 2026 10:28:37 -0400
Message-Id: <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com>
References: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com>
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
When the configured inner protocol is ETH_P_TEB, act_mpls POP can leave
the inner Ethernet header in a page fragment after skb_mpls_pop(), either
on an L3 device (mac_len == 0) or chained after act_vlan POP_ETH.  A
following eth_type_trans() can then BUG in __skb_pull().

The Fix:
After the pop, pull the inner Ethernet header into the linear area only
when p->tcfm_proto is ETH_P_TEB; drop the packet only when that pull
fails.  Other inner protocols (IP, MPLS, ...) have no inner Ethernet
header and must not be required to carry one.  The pull is a no-op when
the header is already linear.

Conditions to recreate the bug:
- egress tc filter on lo: action vlan pop_eth action mpls pop protocol teb
  (chained), or on an L3 device where mac_len == 0.
- AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=28, and a non-linear
  eth / mpls / inner-eth frame.
- The inner header is in page frags; a following eth_type_trans() can BUG
  in __skb_pull().

Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to TC")
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.26d1ddb3bd2ae@gmail.com/
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v2 -> v3:
  - drop the pre-pop mac_len gate.  The pull is a no-op when the header
    is already linear, so the gate only avoided a cheap call (Willem de
    Bruijn).
  - restrict the pull to ETH_P_TEB.  act_mpls POP can target IP, MPLS,
    etc.; those inner protocols have no Ethernet header and must not be
    required to carry one (Willem de Bruijn).
---
 net/sched/act_mpls.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index 4ea8b2e08c3a..35a6d27f76a4 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -79,6 +79,9 @@
 		if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
 				 skb->dev && skb->dev->type == ARPHRD_ETHER))
 			goto drop;
+		if (p->tcfm_proto == htons(ETH_P_TEB) &&
+		    !pskb_may_pull(skb, ETH_HLEN))
+			goto drop;
 		break;
 	case TCA_MPLS_ACT_PUSH:
 		new_lse = tcf_mpls_get_lse(NULL, p, !eth_p_mpls(skb_protocol(skb, true)));
-- 
2.43.0
