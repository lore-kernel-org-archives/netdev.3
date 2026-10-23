Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756771;
	b=fSOxyVpQzFz2WEz5m7By9xHK75KEKHScebNEgRM4KbBs6swkbe/TI02vXwVDI6omH8ty
	 CBA9lxUheE+1D6vOUj/DNTEqmIbMkOGz0iYB2peJ0jpivzZ5jwmiWogCVgDd2jukQNiJq
	 AMZlUKP7e4DXG5iiNXBmPlxkc2xdwfHnQq1sGYt+UFA02yPAfzYA93UDIup999u9Cd91W
	 xmS1/ECoITAbHEL/JGvCRRsFmKd1uB6hynSWlZh5zUMc/b3Ex5hPpr0JUapd8ObQFJOHK
	 802UBbQPuN1oxj0s/S9PsEFa4r0waQHUDqDegAGc0deT7iXXvQNdosNV7l1r2LkDMDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+i7GpuJr4ODC5HZ+Y0j28aF5sIN7ZcXFv71PRMGw+8g=;
	b=w0eF39DoAxBztuBCcfsd6Pep/5H3w967C0/GNcLSygE0y2MYQD0nI61ub9SzMyCxFpYJ
	 JC+L1N4nYqgB/RgmVvxxranHDG2I+PJC0+mfiWhoe5IWFXq7qaaH0WdOjMU4MxJgJnrhg
	 Z8a3wBTGb/vgDK/4/lW7lw+i91XzSKL9Ly7iZibnQVRAtbY+X6LcJ60+wmhVkym94YwRN
	 ZWoNI/AIEBmn31zCbSZOfZL6q2wcfV/78Gf1YCzhrLZp/MFUx0e0g/odCZ4DFvLuL6y9S
	 iDsI3nTFdIkp283FsDdAri1HtEFjxBgQTDggyif0Y1J9+Kh8l+geNdD6H22+dFnfJyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=tBIgRa2Y;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1F5606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D1F5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=tBIgRa2Y
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c162febb9so6402466d6.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792756770; x=1793361570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+i7GpuJr4ODC5HZ+Y0j28aF5sIN7ZcXFv71PRMGw+8g=;
        b=tBIgRa2YHa6KTz7olo7oErgQgvfHxFY2rOPiCMkC2iDvG1dF3TY8KVEziCNZN3u8G+
         nRvu38QePCITkMJU3PeYTYzfT+bLaTuqfXzd74IVdAYY5UoIooT1zY0ZMdmtCy76ZJfw
         un52iZfrD0zC3ejnsPR+akINNKhOJoxPuMXf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756770; x=1793361570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+i7GpuJr4ODC5HZ+Y0j28aF5sIN7ZcXFv71PRMGw+8g=;
        b=VMcDlwj+09qOIPXfSxnvXvw3aQHQTBvC1n/br5YQSvcmxbVFs2TF9W+virorSqSocX
         F1c6783WQoXcQuj9pSy27b0fpImy6xBzrV+MZMc2lbiJC80zmPqZ2nniUV23j9luJhwF
         zjeEVnf6/mvNMG4dtSoyWkl8kzb/2JuVFXhCUduYt0c0R2Ll4p80tIsKz9kQE9ReQuSm
         VWkKCax4TCF5VF97dyAr9BYryPrzeMhuxR9QHcK0tr5hDlvexW1QOleBXB+Jc7DqgYma
         Dz8Sjm5/A16f4PqUWhD3hDcJN42XSrmXuqc7q5B9L4QX8mlZ+9ZgIixajPtYFb73/XvV
         VkxA==
X-Gm-Message-State: AFq9FYLfWSzh3NaHLJhftRSsuORMCYHqcuBh4Ers9vfK/m2C80da4Gs2
	Ic6E+I9Vc/HCusI7XRr/x5Zt31v9zHheWf9UmGVJl+fh8ZA5hu6NUaYdb6rUcaozPgLGn/2I/a1
	JaK8=
X-Gm-Gg: AYBFou2FN5v8P5YRJE1USAYpQ1+CJvjMtX5fZgern107uKbSumaMlz8x0bIdrJO03kj
	pYxeBclaAHRq/rqjjGWOJVaWB8NevPQF40baH+Qb6tl4rCNhEZjwXO9HCm9ge+rlvkBGbbHGv/G
	vyHFEZKi6FGm6d1snSIf6hr66vPf0WK8M9AquFs0VHKW3B2DlgiZCKOlsHMkdVwjsXmnPaf/oYL
	HzXHmWZgZjeH4xF6do85ntLjIzRz41+bF7di2u1TJAMEWrXxNpH+p8vpxWvc56mM+SoPSHNuNNc
	PoSAU+96Ir4Kfl+Q2q95CaKjjLxVcIIq40/0kdoPz0b6umGX276V6N9vMRQd6TtO/kJMaSbWV6L
	CxqBrH16fhwve11zkRYUEiggkGl+i5DzhgPwYRzaIZ0g9labB8pXalU7LYuAyqjTtdvRUWA5HOk
	SaVdhS7SONEmOWhOJwxmuVHWQ36zXHyHqSVLvF2xUZnkn5IPllVayzyDTW0XSKlmlxiQm9Gs+FG
	8fzbH+KcEl/bNI1s2z4cE+H4eDGPWru9WLB1g59xHJppO/x4lAPadR1qzI8hqFiRNqNM8vyTj44
	ifbOp06h7pGyBgngmCU9nIvLhO6BVc1y57du6FBE6g==
X-Received: by 2002:a05:6214:3f84:b0:90e:8be9:c384 with SMTP id 6a1803df08f44-91c3a8a97f6mr21514976d6.27.1792756770125;
        Fri, 23 Oct 2026 04:59:30 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396af493sm18358246d6.9.2026.10.23.04.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:59:29 -0700 (PDT)
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
	John Hurley <john.hurley@netronome.com>,
	Willem de Bruijn <willemb@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/6] net/sched: act_mpls: pull the inner Ethernet header after POP
Date: Fri, 23 Oct 2026 07:59:17 -0400
Message-Id: <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
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
act_mpls POP can leave the inner Ethernet header in a page fragment after
skb_mpls_pop(), either on an L3 device (mac_len == 0) or chained after
act_vlan POP_ETH.  A following eth_type_trans() can then BUG in
__skb_pull().

The Fix:
After the pop, if the original MAC header is shorter than ETH_HLEN, pull
the inner Ethernet header into the linear area and drop only when
pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does nothing when the
skb was not MPLS, so no separate state is needed.

Conditions to recreate the bug:
- egress tc filter on lo: action vlan pop_eth action mpls pop
  (chained), or on an L3 device where mac_len == 0.
- AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=28, and a non-linear
  eth / mpls / inner-eth frame.
- The inner header is in page frags; a following eth_type_trans() can BUG
  in __skb_pull().

Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to TC")
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_mpls.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index 4ea8b2e08c3a..5363bca892fb 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb,
 		if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
 				 skb->dev && skb->dev->type == ARPHRD_ETHER))
 			goto drop;
+		if (mac_len < ETH_HLEN && !pskb_may_pull(skb, ETH_HLEN))
+			goto drop;
 		break;
 	case TCA_MPLS_ACT_PUSH:
 		new_lse = tcf_mpls_get_lse(NULL, p, !eth_p_mpls(skb_protocol(skb, true)));
-- 
2.43.0


