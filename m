Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CF343551D;
	Wed,  7 Oct 2026 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365723; cv=none; b=Cn/vS9LnSxll6F4KTwq3QGkx2KMa0kmzfdWz/PRd9zFgZPnwUocL7yuwaxnqOgMtZIPwHW0kq6co3zW7a4gLnZt9BCP4XV6+9DMo6uuK0akOAAO+Q+3xtkW8qIRt0YF3JywNQe/FlvZXTxfnu2nDHux6UDBpG5KkoLHC3G/pvFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365723; c=relaxed/simple;
	bh=1wjj8SkEDC2opjYTtIkRlUdnHarqkS6kTWy7QDSFG44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFUByfB50pVRnUqP7M1+BUIFi/fRZrwWlSwfIy1K5QzGF4s8NZEZ2HrT1UgZYexKB9c2bXxAKvcfmRhZufEJTRVH2tNmMAjsR1MNjAeQHqt+SWey9HR/pF4dAfMl6XKkuNDc70dvM8k53grtUXVxQBFprF2INPJUOkSBt5EpFdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=yEfgSHrB; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="yEfgSHrB"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8FB852082B;
	Wed,  7 Oct 2026 11:35:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x5mLv4iBdrqT; Wed,  7 Oct 2026 11:35:09 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id DE6DF207B3;
	Wed,  7 Oct 2026 11:35:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com DE6DF207B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791365708;
	bh=cNTZ2A7uaNfK6zWi+crV4PFigYwEp+LkrACYyeIm3VI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=yEfgSHrBMHzneI4ElfuOLJkOijdrewz+0baVkszoP8uOMSYOQVFe6BDgNwzJDnTqw
	 Dzhuzs0Gqgd9wbg/jhowgl/WYSb1HGn7QKMXVkAcxN9vjaTJFavVuXiMEAPUDgk02I
	 m2TaCjEaRDdCX98mORX7jTdGvI+sCgzc6MCffTOGbTJSlFwLDdNOLbn7H01tUpbEEr
	 kyITvy1MLLR4SQicy+FifjyLfNYCC8A9riRJM1Ogec/jbuIQObwmq6YzSHrNiue1OW
	 L8DBkYSP61Q1SHQGjHxxYvnNroMNfezizV4ZOvIZgiv7s25enBeBrOUmuboEceoVkT
	 7omt/dNqNjpgg==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 11:35:08 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Jamal Hadi Salim
	<hadi@cyberus.ca>, Shuah Khan <shuah@kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>, Yan Yan
	<evitayan@google.com>, Tobias Brunner <tobias@strongswan.org>, Florian
 Westphal <fw@strlen.de>, <linux-doc@vger.kernel.org>,
	<stable+noautosel@kernel.org>
Subject: [PATCH ipsec v5 3/9] xfrm: policy: reject mark with bits outside its mask on add
Date: Wed, 7 Oct 2026 11:35:00 +0200
Message-ID: <migrate-state-fixes-v5-3-d9d3d794553d@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-fixes-v5-0-d9d3d794553d@secunet.com>
References: <migrate-state-fixes-v5-0-d9d3d794553d@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)

Same issue as states: an invalid mark/mask is silently truncated on
insert, so GETPOLICY and DELPOLICY can no longer find the policy by
id. Reject it instead.

The mark is no longer sanitized on policy insert.

Fixes: 0b91fda3a1f0 ("xfrm: Sanitize marks before insert")
Cc: <stable+noautosel@kernel.org> # avoid breaking existing userspace ABI
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v4->v5: drop the now redundant mark sanitize in xfrm_policy_insert()
v3->v4: added this patch
---
 net/xfrm/xfrm_policy.c | 3 ---
 net/xfrm/xfrm_user.c   | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index f6f40ba713d5..0f6fcea28bcd 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1575,9 +1575,6 @@ int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl)
 	struct xfrm_policy *delpol;
 	struct hlist_head *chain;
 
-	/* Sanitize mark before store */
-	policy->mark.v &= policy->mark.m;
-
 	spin_lock_bh(&net->xfrm.xfrm_policy_lock);
 	chain = policy_hash_bysel(net, &policy->selector, policy->family, dir);
 	if (chain)
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 6b53373168b0..c1571c7a2315 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2307,6 +2307,9 @@ static int xfrm_add_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		return err;
 	err = verify_sec_ctx_len(attrs, extack);
+	if (err)
+		return err;
+	err = verify_mark(attrs, extack);
 	if (err)
 		return err;
 

-- 
2.47.3

