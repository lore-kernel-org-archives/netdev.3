Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756770;
	b=09sqoiHhPTbbSUV5TGUIATsCtiYTaq4uAzHbeFasO9vLQXxbdPnmZyR+w9IhgY7lRG8j
	 uiRJUGZRQgdzOWGP9OC/uj4VqV+HNV0hSjCZoHHnCK86cv6EEp3AT+TWpifFtGh5HsffU
	 xmPYQsuQgWymvpGuIBczQlpcPzvQhinaIazPcSQ8S55XH9l6b3dOa6KQVypSEQdDu9s+9
	 RjWScgk7oDw3pf8UfUDLFHlk4cAEjyeTN8AMtiiNz245ruoTOqmzNjaFoNWjOi+KX0rJu
	 r/dcruSuEOqs53U7dwQmYEGsUZmxsuqaDV/VkZf362SXuYSyNbGXLdB0C2ZhPt0WoyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DT0mSqAbYVaCte+J8d0YAsmxoXU9xn+dv8jMhDaEL28=;
	b=k46j/v0OVW1YSvvgY8hC8WDuXGDD/AfI0wQh4twSkIDMqwN8tLPMOS5fCG38PU6N8ITg
	 BEF06kL3u1ZJTPYg/GV/LzMeHSsetZWSYOVvPrfXpnw9TmPCCtNsQgPnqhOJ0GuquMJCm
	 zjSX9BIeR/uSdB+2Ut39mlidswRZxYsl/a7H+cPL3qU60ZrzAff7nVLTMrnAzwXF00FjL
	 bfFuPp1IBxkcdU82gWPyhDzq0yixwtgNiL3RwPmWMXM38v6IL8DFzg0N++own44GnRjyz
	 MToq4tRwXkBT42gvQkjrxGBgsj98D5xNAdMNY0DFQ9JtKcSH7cEL3PotoDRygZY5lRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=pGPmKnWy;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F1606A321
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A90F1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=pGPmKnWy
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917a707f37eso9551586d6.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792756768; x=1793361568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DT0mSqAbYVaCte+J8d0YAsmxoXU9xn+dv8jMhDaEL28=;
        b=pGPmKnWyvRQOVI9PPuMMhx8N+Djpk3zwdlpMRV5GEQesgvmNtwHvVAVyPaJ6uJjVXY
         SGf+UifQ2M0Sk9kCLxSY9l0/ioJ0hRPu7/FUGcx5L6SNBZNSrniKdIZ05tWnlEeoTmdX
         K4Ia3U86i5MCV9fSa/zOoy0JG2LJOFFw6XwJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756768; x=1793361568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DT0mSqAbYVaCte+J8d0YAsmxoXU9xn+dv8jMhDaEL28=;
        b=ggXnZ0FXj4LIe+S5KOm+l+7N5ntXpE9ZCg7dMV28QnCFAgd/UjuqUf1vjyKd1god+w
         t4YxfOHZ1TrP31Uakj1YT+9SfIUU1qJAJ5Ry02/xs/FedLAiRlG2WkiuZum7cbFwKklH
         mcsIwfKAsB0DquuPa85jD/heYtryFFcanGXxi9mwYjXe3b2t4uWT9DQ1J+599aftXaQF
         FZMmUK+jWjW3te/cxPwl8P3sju1GMePGwTKh2upNrRZuoxeZbHXEAk4S8k4L5brTMKWN
         so8G6tmZjs67JAqgiAO5xn6KzS2EP1YJikHSWPG1nv6VBcDaR8ykU/4zVvTK9f8o3/v2
         U75g==
X-Gm-Message-State: AFq9FYKesGBT6Aihfr3lK+7/gs/KeJUhRGYY9Y8hJUz6pf2+fFZMxXM8
	DDC95SE1VmBd/xRSLknaEZKAunBopqECe4M4D9mmi6HeIkYZDF6ycYxMG2uzg+HR8U4PT72UmUm
	zbcE=
X-Gm-Gg: AYBFou0yMqE/jES2gKfAAGanrIHxUC9jziyWyleYzKVq/w6NcsQ8iq2hCT9et4vEBpU
	N9D+y+SbrBMsi1vu6zR2ExmxngyKx7F91A8vjZ3PNuGqp1AeYO8OWGdcHUhh6cwPB0TO5Y9LXjZ
	FuuQKkdNkUxTo3l5tXgP0ZbzJAZGZ4Q29SirCBiNRZUBfaUt+OqJJPSkEnUsckAnAm1QnPga+ep
	yTUJh0jfZYMhlUtJJBoxXXWzs61ItsgZbVX9jJYV7XmdI/SlBZW+3nVMg9We6bS7YU0GgRf6ZF6
	DBUi/bue4C01GSqyT5hJQ2RwSbQhf1iBvzMrJjHvPAJGtrYjj3OKN/MllIlS6AseeYgBJuueohs
	TaNlNkUupwqn1XqLE5DGScEkL+KmrUYRZvWsh+RevGa9pqcqIaW8wXw4bf7XAtzBxuIhsNH/wSu
	/NwLJyyx1iMxp767ccBNbpAce0J3+uEwkct/owjusIedGuvllpAhHa581QF/q84pPA1+InA3803
	cAM8cJhF/kzEk20eHCmAU1nYsyL3PtXuM8wVE92BcnvCsi0ylAyhstJQ4l/QebUznpp0IYZD/yj
	OUo8jVQaDGLenR5AzBILaw1g5+LIgASKadCfiY/wMGj1/Of9lx7zQCR6iJzmzKI=
X-Received: by 2002:ad4:5dce:0:b0:914:501c:6d08 with SMTP id 6a1803df08f44-91c3a8284b1mr23019456d6.14.1792756768360;
        Fri, 23 Oct 2026 04:59:28 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396af493sm18358246d6.9.2026.10.23.04.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:59:27 -0700 (PDT)
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
Subject: [PATCH net v2 1/6] net/sched: act_vlan: pull the inner Ethernet header after POP_ETH
Date: Fri, 23 Oct 2026 07:59:16 -0400
Message-Id: <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com>
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com>
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
act_vlan POP_ETH removes the outer Ethernet header and leaves the inner
Ethernet header at the head of the packet.  A non-linear skb can have the
inner header in a page fragment, so a following eth_type_trans() may find
less than ETH_HLEN bytes in the linear area and BUG in __skb_pull().

The Fix:
Pull the inner Ethernet header into the linear area after skb_eth_pop():
drop the packet only when pskb_may_pull(skb, ETH_HLEN) fails.  This keeps
valid non-linear packets whose inner header sits in frags.

Conditions to recreate the bug:
- egress tc filter on lo: action vlan pop_eth.
- AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=28, and a non-linear
  eth / inner-eth frame.
- The inner header is in page frags; a following eth_type_trans() can BUG
  in __skb_pull().

Fixes: 19fbcb36a39e ("net/sched: act_vlan: Add {POP,PUSH}_ETH actions")
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.38722ee638a21@gmail.com/
Link: https://lore.kernel.org/netdev/CAL4WiipJLzZ9ywOPaFHZ+wePTOuO+6+aaRCVXMHz+xmmQm2hcA@mail.gmail.com/
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v1 -> v2:
  - pull the inner Ethernet header with pskb_may_pull() and drop only
    when the packet is too short;
  - keep the OVS TEB and NSH members and restore their Reviewed-by
    trailers;
  - replace the TUN patch with the act_mirred consumer guard and add
    the act_ife egress fix.
---
 net/sched/act_vlan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 6a375fdc63dd..bca95e0bbf64 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 		err = skb_eth_pop(skb);
 		if (err)
 			goto drop;
+		if (!pskb_may_pull(skb, ETH_HLEN))
+			goto drop;
 		break;
 	case TCA_VLAN_ACT_PUSH_ETH:
 		err = skb_eth_push(skb, p->tcfv_push_dst, p->tcfv_push_src);
-- 
2.43.0


