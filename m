Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C536C9EC
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172170; cv=none; b=OCFhCAnLffHilPO42Fupb1fzS5YJX3fCcxsKALGI9dk6rBGU0NHM5g2Snug2kVYlnbVCRhONIrSiiuTeROJ2hn0C/3f2wfhSi7JOfEr063q3geovdMJYfve0qFsV7NR2i0N2pFmK4Tmvg0+ZRXhT51y09oH8cHY7gRo2J+rRIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172170; c=relaxed/simple;
	bh=1ptAzGN/z38ORkK1L8Dh043hMTW5e+UsXpdoMyKTpmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfxU7+C///NnqB4nerTHamHkt2VNm4PlYCKo4bEGC5uTaiGEVs58G/P9svRxotc19WTpBPjZuJbaNH/tXFHcSKJ9btfwuMQHQiYUoMN8+wybnAs4Ss9sKT9uNV4SccaL8KqvnjfslpPrNT/M1Yxq5BWFS3uepdTM8yvDri0v+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 7F3136035B; Wed, 19 Aug 2026 22:42:47 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net 4/4] net/sched: act_nat: discard any conntrack entry post modification
Date: Wed, 19 Aug 2026 22:42:10 +0200
Message-ID: <20260819204210.23722-5-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819204210.23722-1-fw@strlen.de>
References: <20260819204210.23722-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

act_nat is stateless nat, so the expectation is that skb->_nfct isn't
set in the first place.

But if it is, then addresses stored in the conntrack entry no longer
match what is in the packet payload, which isn't expected.

As act_nat can't mangle arbitrary data, this shouldn't be an issue
but better play it safe and don't retain such a conntrack entry.

Fixes: b57dc7c13ea9 ("net/sched: Introduce action ct")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/sched/act_nat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index abb332dee836..0c3d3b89d349 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -257,6 +257,7 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb,
 	}
 
 out:
+	nf_reset_ct(skb);
 	return action;
 
 drop:
-- 
2.54.0

