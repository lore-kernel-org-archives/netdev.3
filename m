Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE9334C05
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786664264; cv=none; b=IBCXrUQo0fY5pGPVL7L+H4bSXk7DJiNz9FXOUlmLULH6jG1dlM6MgM4H3vkPaPiCp0+Zeh9s1ahDP8WPcWUK7a9795WJxlnS3FXP3A2UrMwLX+0PiFur4VzdfuGK3ofTfRI3N/RSZGQOLAjz7Gnq3u+KWd/DkujXu145r6kzY28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786664264; c=relaxed/simple;
	bh=tDRUIDreevjQ5U+dTowBbTn/xs7X/4tT+rcoNJtQp7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D9fRr5ZLkqTMQXxbfhh0DzY4huM3kyOADeW+PEqZpzR0ZEfrs9Tioo5n3LKTYxMKJWwmv4ghou9Lk05sI6YCbH7/mx3gUUeXb5bhOYemvMNwmHussiqv5Q308AQihDHNuAjn32w096DnV6D8A9QIvuwgXdajURrxS3AFhjFYU6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUEvf4Wv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUEvf4Wv"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cacf197759so7718235ad.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 16:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786664263; x=1787269063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E5sge5OLBjZqNmnWZTCO07UEdJPIZNcrGW9HCOI0cPo=;
        b=GUEvf4WvTyHO4a8ERQzIKLX6mUaGujTgAcBTENQCxQZwHlpNnpweD/EJSpKSzgPK+H
         kO426BB4W+Vnxm5LczDJrnETekoy66CgBW0Xt2rlJYitz1kMsswmxv8Na29a30+nR9no
         feM+d42Es922TFrzgrxSooTwkjXHw/5nf+Sdvo1WC9ePhoaVAqhMYGSjYGocmbWb1UuI
         GAhZqUpW4TvbS55irImvVhO2UaylcqvRZ+6GkTaPyQMPPgbquMptpDZhmoQpNr5hBWtu
         S/Si5fCG70siRHeEWMD5Os6dx/ZYSHCND2bkRik86/ZDGlEOfrIbxrnOxA8E44fhsH/p
         5kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786664263; x=1787269063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E5sge5OLBjZqNmnWZTCO07UEdJPIZNcrGW9HCOI0cPo=;
        b=oEw5HJS2DKY1rIBFPStx5CRPCmlloTej+UUcGnT55E7uDFrpA8sS/JP5SKBZu8lP0b
         PG/xf6TGFiQ1gQ4I7f4vESgvfeX8jyAgkT+Kxg9/ctAHwDDfzcXcUIJVzkULlEUtBwN3
         bqnj4k8ofKrNFoCZDd4E+XppPusWIUYC8c7K4jbgXRmIrld1V8CojKs/EO9/EU4Ah9Ko
         4i7bFankcPsMNDwvruqmdtvadWKJcyofbwkovMqMNRy+z5ewCyiI29tMj1U+e5NhPGAF
         2TRG/fJtBjBXljxw6KGdG8aVo4r49sYmRsx1ZM57TdYtEWKb9bH0umB31AkGmRtBCJjD
         wZKg==
X-Forwarded-Encrypted: i=1; AHgh+RrREr1MDQIWOaczurDvQgUvKTm/glmkAbnlu3EuJoIofRjwc1GRL8kGkKE3j05jHgA6BsYR7Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz41oJdoQrEVu+r+TCGmL8xYjrM6AWHOYQHE9Zvwo5C23pNVek
	XGho4gCyR0GjD+hE6mvTys2bnmof3QG1PysIslYRsuffh05k4ke5ImrR
X-Gm-Gg: AR+sD12NHXRr53LnHeORSEugMY0iUoGYA+tiyfI2K8gLVymfsr9MRaJQIV/FItzkX9E
	Kt/7pha05p5z+NZKu73vcYrecQNJCKJfl8peQlEr0Hnd8Oa98hge20Aqc2EglhrQ/uOkKCRW0Wj
	xGedLl2MqlCvVa4wMn+Ou+1qiMn1NHV96AtBtFXF01FzGg1Mj7Dy7zb8pFwIrqtyoigNmm0OIdM
	xS94cIhp9SyGFDRpB6ZxQfNBF6adyvdQ9ueouUSfT/fCpxaZx9vWndp3Q+npqiiIk4RvAbHcZiQ
	xddneroMXrd217nTwYk5cYTO9x5HdI1H2Jv7nzUON6xtn67Ic6CTXYLRw/nE2/gR5wxVjFT6PG7
	J8h/+sxD3D9laWFhbktLQZ1UUiiMWhzpk2l7oKNdmocbVqn8bpfzdZ47ZZLncwlJYLKRSCUL04Z
	2Jnq01t+BYhPwr2cep0EyQHIYbF/CG0S/tFD3C7Ktx+BbmsD8pZRLQummYpDrSQq2fcLr3nVGq5
	MYtd21HrjiiUIGf/8WZ4rsdEevzi5IxxkU73eUdkh9zcQtbHxTpIA==
X-Received: by 2002:a05:6a21:4582:b0:39c:126c:93b5 with SMTP id adf61e73a8af0-3cc71c57b8cmr1688901637.21.1786664262754;
        Thu, 13 Aug 2026 16:37:42 -0700 (PDT)
Received: from lawlee-vm0.d4y3nv5wwgfelhhopdxv1tqjld.dx.internal.cloudapp.net ([13.93.150.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebf731dbasm14354359eec.17.2026.08.13.16.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 16:37:42 -0700 (PDT)
From: Lawrence Lee <lfqlee314@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Arun Ajith S <aajith@arista.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lawrence Lee <lfqlee314@gmail.com>
Subject: [RFC net-next] ipv6: update NUD_FAILED neighbors from NA messages
Date: Thu, 13 Aug 2026 23:33:44 +0000
Message-ID: <20260813233344.445265-1-lfqlee314@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I noticed an inconsistency between IPv4 and IPv6 in how the kernel handles
neighbor advertisements/ARP replies for NUD_FAILED neighbor entries
and would like some guidance/input from maintainers.

For an existing IPv4 neighbor that is in the NUD_FAILED state, receiving an
ARP reply for the neighbor IP will update the entry in the kernel to
either NUD_STALE or NUD_REACHABLE depending on if the reply is unicast or
broadcast.

For an existing IPv6 neighbor that is in the NUD_FAILED state, receiving a
neighbor advertisement (NA) for the neighbor IP does nothing as
ndisc_recv_na() explicitly ignores NUD_FAILED neighbor entries:

        if (READ_ONCE(neigh->nud_state) & NUD_FAILED)
                goto out;

This check was added by commit titled "[IPV6] Don't update FAILED
entries on receipt of NAs." (Hideaki Yoshifuji, 2005-01-16; pre-git, in
mainline since v2.6.12-rc2) with the justification "As NAs do not create
new entries (RFC2461 7.2.5), NA should not change state of FAILED entries."

However, RFC9131 introduced a method for NAs to create new neighbor entries
(implemented as `accept_unsolicited_na` and later renamed to
`accept_untracked_na`), which means the original justification for ignoring
NAs for NUD_FAILED neighbor entries is no longer 100% correct. I think to
remain logically consistent, it makes sense to allow NAs to update
NUD_FAILED entries anytime we allow creating new entries with
`accept_untracked_na`.

I realize that RFC9131 section 4.2 states the following:

    ... routers create a new Neighbor Cache entry upon
    receiving an unsolicited Neighbor Advertisement for an address that
    does not already have a Neighbor Cache entry. These changes do not
    modify the router behavior specified in [RFC4861] for the scenario
    when the corresponding Neighbor Cache entry already exists.

However, I would argue that since NUD_FAILED is purely a kernel construct
and has no equivalent state defined in RFC4861 section 7.3.2, a neighbor in
state NUD_FAILED does not actually have a valid Neighbor Cache entry as
defined by RFC4861 and should be treated as if the neighbor entry doesn't
exist; therefore NUD_FAILED neighbors does fall within the scope of
RFC9131.

The motivation for this question comes from my work on SONiC, a network OS
which is built on top of Debian and runs on switching hardware. We have
encountered an issue where the switch receives traffic for an IPv6 neighbor
before that neighbor is resolvable, which leads to the kernel neighbor
being set to NUD_FAILED. When the IPv6 neighbor becomes ready to receive
traffic, it sends an unsolicited NA to the switch which gets ignored
because the kernel neighbor is NUD_FAILED. Subsequent traffic destined to
this neighbor stays entirely within the switch ASIC and isn't visible to
the kernel, so there's no stimulus for the kernel to send neighbor
solicitations; as a result, the neighbor entry stays unresolved and traffic
to the neighbor is dropped.

The main questions I'd like to pose:

1. When RFC9131 was implemented (`accept_untracked_na`), was an intentional
   choice made to not update the handling of NUD_FAILED neighbors? I
   searched through the discussions for all three commits relevant to this
   feature but did not find any mention of NUD_FAILED handling:
       commit f9a2fb73318e ("net/ipv6: Introduce accept_unsolicited_na knob to implement router-side changes for RFC9131")
       commit 3e0b8f529c10 ("net/ipv6: Expand and rename accept_unsolicited_na to accept_untracked_na")
       commit aaa5f515b16b ("net: ipv6: new accept_untracked_na option to accept na only if in-network")

2. Should unsolicited NAs be allowed to update NUD_FAILED neighbors when
   `accept_untracked_na` is enabled (this would align with existing
   IPv4/ARP behavior that allows ARP replies to update NUD_FAILED
   neighbors).

I've included a proof-of-concept diff below for how this might be
implemented (please note that this is just meant to help illustrate my
point, the diff is untested). I'd be happy to follow up with a more
thorough patch if the community decides that this is worth pursuing.

References:
  - commit titled "[IPV6] Don't update FAILED entries on receipt of NAs."
    (Hideaki Yoshifuji, 2005-01-16; pre-git, in mainline since v2.6.12-rc2)
  - net/ipv6/ndisc.c :: ndisc_recv_na(), accept_untracked_na()
  - RFC 4861 sec 7.2.5, 7.3.2 ; RFC 9131 sec 3, 4.2

Signed-off-by: Lawrence Lee <lfqlee314@gmail.com>
---
 net/ipv6/ndisc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index fe36b3f51285..2a6fa1252a04 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1086,8 +1086,17 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 		u8 old_flags = neigh->flags;
 		struct net *net = dev_net(dev);
 
-		if (READ_ONCE(neigh->nud_state) & NUD_FAILED)
-			goto out;
+		if (READ_ONCE(neigh->nud_state) & NUD_FAILED) {
+			/* Update a FAILED entry when accept_untracked_na is
+			 * enabled, under the same conditions used to create a
+			 * new STALE entry (cf. IPv4 arp_process()).
+			 */
+			if (lladdr && idev && READ_ONCE(idev->cnf.forwarding) &&
+			    accept_untracked_na(idev, saddr))
+				new_state = NUD_STALE;
+			else
+				goto out;
+		}
 
 		/*
 		 * Don't update the neighbor cache entry on a proxy NA from
-- 
2.43.0


