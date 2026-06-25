Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A100337649D;
	Thu, 25 Jun 2026 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381079; cv=none; b=MeF27dttK3qmCxb+m2ce0zVkPQ9Nw+rNc912XYzlXhE9DEZeutaMJhlKdSuunBNe41/m9duOTkSIcyi3k9wVwmQsnaPuLt8j7+WqQSCMHMSKaLZKaqcRQ4h27msatO9mFzvwWUcpU+DqLGQbHKHJcfmngn7PHY/Aj+tczzFoeME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381079; c=relaxed/simple;
	bh=nr75AHDd0My6X+MxzJbRuBmJlIXwzD6UQPYsQ/jxGQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NMYMScR4ob0xCYnsmYqJCOUn6okjvcTiLSMKr39CGBIcH5z8FnTpWMCI1MPO/xSlOeBs2j56lzB9FO6PjQIyoxrkqzXAK6QYiGaqA+TdqP42FD8fpWVbBUVqvpf4EErA5+gcE4B8fGgyaa9F7GAqf2e446F5qqmoIrZoYB1/pmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJcgFNBh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJcgFNBh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63B2AC2BCB7;
	Thu, 25 Jun 2026 09:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782381079;
	bh=nr75AHDd0My6X+MxzJbRuBmJlIXwzD6UQPYsQ/jxGQ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sJcgFNBhJXPvULpaGaR+ZMEVqHPtkbq6/bvFseJL5t/aEGldmBHV0sNt8RXJb9Stn
	 iBGFxde7A97hcKKaWNa13PHu19Bve0NkKnU1h1EmkHMMzDsTUjoPHMVzv5DXpmgycR
	 OHzv/Zstzei4I4oF04VlsOVWJsEjAlZCXXsmj0VkyEMvV3ibb0mXiC++q62mUtJ/IO
	 l+TxHPBCzvS9ktDv8C+ixv5l/bVpXJBbVyO3GWXL+neMh8bx5MGPhk3mJdlqapLWgb
	 pcTwxOsk76OMOuAmqp8mgUuZ7x/kO2mFSUAD3DCBgVtkv7ycUz+afUdvsSXx7I7f+8
	 UTfPA/RL6B75w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB46CDB466;
	Thu, 25 Jun 2026 09:51:19 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Thu, 25 Jun 2026 04:51:19 -0500
Subject: [PATCH 1/2] net/sched: sch_taprio: Replace direct dequeue call
 with peek and qdisc_dequeue_peeked
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-disp-31bcb279-v1-1-85c40b83c529@proton.me>
References: <20260625-b4-disp-31bcb279-v1-0-85c40b83c529@proton.me>
In-Reply-To: <20260625-b4-disp-31bcb279-v1-0-85c40b83c529@proton.me>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 Jarek Poplawski <jarkao2@gmail.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782381078; l=1455;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=I9sNMlAiSceZhvpUxi2OMlwkYLdcN+Ut0LViKyKBXds=;
 b=M9wckTxm60NT+s0Z3ddnLVQTNS9uzWZVtEUYcRFz1+zQ4Xuunik7tlUl2nUazDPI5NtN8y6w4
 9w0Xxw9DM8mBh6jBEOTp6ykv4OCW9SKAhKxi491UUPBg+lwQqdNgd9Q
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

When taprio's software path peeks a non-work-conserving child qdisc, the
child stashes the peeked skb in its gso_skb; taprio_dequeue_from_txq()
then takes the packet with a direct child ->dequeue() call, which ignores
that stash, orphans the peeked skb and desyncs the child's qlen/backlog.
With a qfq child this re-enters the child on an emptied list and
dereferences NULL, panicking the kernel from softirq on ordinary egress.

Take the packet through qdisc_dequeue_peeked(), as sch_red and sch_sfb
now do. The helper returns the child's stashed skb first and is a no-op
when there is none, so a work-conserving child is unaffected and the
gated path now consumes the skb whose length was charged to the budget.

Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
Cc: stable@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 net/sched/sch_taprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 558987d9b977..299234a5f0fe 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -749,7 +749,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 		return NULL;
 
 skip_peek_checks:
-	skb = child->ops->dequeue(child);
+	skb = qdisc_dequeue_peeked(child);
 	if (unlikely(!skb))
 		return NULL;
 

-- 
2.43.0


