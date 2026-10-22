Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660952;
	b=QUjjnd4j07UOI8mpX5s0UfpmwoEZIQbCVDGmC29QEZ5eKc3Czr3RHYB+F2aDMNUkNcjI
	 kMaDy/U/jynUzeFeYzunTDZEAuSiFxqWPwrVzYqdbD42OVZKjH8/v7ZIGl2aeExuu3fgr
	 ucqFRpJsg4pIRMYcHQMexLzIDJYhdw0DgmIuwDfGzfTHsNaYQLlRMK+skTTUE03KMmbKO
	 jkQDmrxwvocWvwE1itFKQIagVkMybAI94EURSUqB1eUtpiPNGwzsQ2W2nT8WvSlWAcYMh
	 q9N97mpfgSNSwz3rsyfK9LbV2jGz2IMF9SAdwEXc5/7F6BGFAQ8VJ+w7CXbepEW3nLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Yk4KE3dyngW5psir5iFSrVdqdFTjy0Bi2iDkl4FIkXY=;
	b=PF8hLutSLnfq3xoVLZyYtnxvnMmjBamFZEqd0AMK9xlAwERtpcDfR5PYLdqYoQcWEELN
	 4zhutO3Nd7Q6qAHKgF5exU13ZKnFsUwK+ve7jCNGaBsfgpEG2VO91uAY0zs16NVQideYu
	 EtqgaZ1AWmqf+7zMx6tpRHCxAYXtXnPxfxAh6pCYDUGSdLWi+JbkC/JJBlWEf6+g5L9wz
	 Q/5xvHvfqIaxxr2O1MOIZBv+dFC+SbNva6fXxTJrMstzkmHvNV5vFnPV1ydnB8tJEHdyu
	 YbXwokVEtI3Z/x3ixEJgY4gGAYtD/GDD5YR9v0LSp83uf4e2X9vajVW3aOtgUDP06Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=dh4NS4Q2;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075D606A330
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0075D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=dh4NS4Q2
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f560af6aeso179949785a.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792660951; x=1793265751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yk4KE3dyngW5psir5iFSrVdqdFTjy0Bi2iDkl4FIkXY=;
        b=dh4NS4Q299jGzUCS2/Fk81ApiML0bF3rQtTWTfHMdgm0laKWejNmjNHxugbi/q47Xs
         ixX9bzSNKItAawqVaufocQKIisLKTDgG5gU4rgTfGhbDY3B55Vzbzddwd1KjawanIcpA
         VowEbQuWbF266yuSwweTEMPbxNVtNeu5g2BFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660951; x=1793265751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yk4KE3dyngW5psir5iFSrVdqdFTjy0Bi2iDkl4FIkXY=;
        b=TJkNCUGHhCGkqEKhY6O7QEIYoUz4nv5cqO3mditMvWQxAZGKy0dAjCuuiJW+bt8ZlC
         o3wFYZsZqrt7Ieq9hD60mzLCubm2RmvIfAOpxr6ElXs9LtbkP8R3UYDrV4j8JKO9H+cC
         ULAHb3Elnub25G73m7gRGqyeTeo75YHZs+TFzj37uTonwjNJAdvjDD+gzig9mGUHzFZ2
         F20TXHll9373D7UdohuYvlTQ6q384wJZLfR3Zf/ZUsOezSmsSy5sJvPQlNzi2X3XFWVC
         y/yCaJPqLoqRhJIkF4KPr+LNLJNJ4Hatcksm84zu1Gk9cT60l1FpLYRDj2iBnUtqzRIT
         Z1vQ==
X-Gm-Message-State: AFq9FYJ0RACW1X/y3RnZFBehZBdpOXk4BHz/2ZSZSgNVTYoie4ABIji/
	FwH7KrNfQTBKp345MHvFufbTwMcNMO1iAHLv4vtM6HIhbPfYHWFvXTtwCVbHDoZ+hfWYbvY/+U8
	T/7g=
X-Gm-Gg: AYBFou3xdwOM7OJoNLD3KxV55GWcuVcjcjWKb1OdVrMVaSvMlKJHuvilR+gkG18cUio
	zd8Dp/hVvcTTMQ3h3QQi2X/2b3cAp4XqBN8XlUMEpXjLihJpJYHZI6093yJARxj+J84PXssPjHy
	UjLunU0lXcGLWVuYWXavvwy0We1gKshViQVR6iuw2Ln7eaLmGYPhrP08ROXISrepjMTF282vRh3
	07pJI4OfW0AaK7564BwDnfz0RAaGTBdr7qILH9y5ecDlTiJj8PB/nXthtr3xuOZGH/oGWfrRikN
	WyAd0+7F6H25ZtiFZTYi8e6leSwtwvY5dtA990x6rNq9E2UQ6s2QEXalzm/uJw6ILBI8Y4V3+/y
	SUfptez1+nEXLsxWo8hd6HyplRFti0sOaUIpw8JJLk2ffqeCzrDZdN2nqqf41UM7LsRHaXksxeX
	jxPOaaokDAh7MqPgcTROttomaE3MU/8EZVBsHe1K/q8Thxwmb7pwyH2TbHqC06QMyOHS02EhTWe
	YX4j+IfJvYfvOIFi5k8Xs6OK1PspfmE2zk1ycC+ijXD5tVb9o9ZUgjlxCuz/TpAwOBhXTtlQARK
	8co5bCXGTscgeUxaJ1RttKzVqQ==
X-Received: by 2002:a05:620a:3188:b0:93e:c12c:f148 with SMTP id af79cd13be357-93f57f793ccmr769726585a.82.1792660951054;
        Thu, 22 Oct 2026 02:22:31 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e2a60fsm469884685a.41.2026.10.22.02.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:22:30 -0700 (PDT)
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
	stable@vger.kernel.org
Subject: [PATCH net 2/5] net/sched: act_mpls: reject short linear Ethernet headers after pop
Date: Thu, 22 Oct 2026 05:22:19 -0400
Message-Id: <ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
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
act_mpls POP can leave fewer than ETH_HLEN linear bytes after
skb_mpls_pop(), either standalone on an Ethernet device or chained after
act_vlan POP_ETH.  A subsequent eth_type_trans() can then BUG in
__skb_pull().

The Fix:
After the pop, when the skb started as MPLS, drop it if the linear head
is shorter than ETH_HLEN.  Non-MPLS pops and pushes are unaffected.

Conditions to recreate the bug:
- egress tc filter on lo: action mpls pop (standalone), or
  action vlan pop_eth action mpls pop (chained).
- AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=28, and a non-linear
  eth / mpls / inner-eth frame.
- The pop leaves skb_headlen(skb) < ETH_HLEN; a following
  eth_type_trans() can BUG in __skb_pull().

Fixes: 040b5cfbcefa ("Fixed updating of ethertype in function skb_mpls_pop")
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_mpls.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index 4ea8b2e08c3a..4d375033400b 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -57,6 +57,7 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb,
 	struct tcf_mpls *m = to_mpls(a);
 	struct tcf_mpls_params *p;
 	__be32 new_lse;
+	bool was_mpls;
 	int mac_len;
 
 	tcf_lastuse_update(&m->tcf_tm);
@@ -76,9 +77,12 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb,
 
 	switch (p->tcfm_action) {
 	case TCA_MPLS_ACT_POP:
+		was_mpls = eth_p_mpls(skb->protocol);
 		if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
 				 skb->dev && skb->dev->type == ARPHRD_ETHER))
 			goto drop;
+		if (was_mpls && unlikely(skb_headlen(skb) < ETH_HLEN))
+			goto drop;
 		break;
 	case TCA_MPLS_ACT_PUSH:
 		new_lse = tcf_mpls_get_lse(NULL, p, !eth_p_mpls(skb_protocol(skb, true)));
-- 
2.43.0

