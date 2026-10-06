Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B52C3266;
	Tue,  6 Oct 2026 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270377; cv=none; b=scRcczWo9vXRcmDqx0sVpIsW1HkRg4dkCEQJcz/FjTvUIN12c10Y+xinu4L8vyh5A1QkD7MPI4eKiSfHEVaGz/bZsMpE+RY9dK68VnM5PTAYCBJQJuolVMW0lT/6ftJVQE8HSoJ4t6H1vtslHfjKVOMJXJK+VpGkIYqfclNwTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270377; c=relaxed/simple;
	bh=Z3ykhbjVIzJyZNeN3nHF0O+4WsulmWB/JiOUaUbfC9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eSQpgFd2sCCyvwvvn8kIswAnbqxorkvBcJm5n7U6fVHSpmfH/L+tVa6vSm5FpNpbNo9hdP+ST7fDrEcZV3QqmW+c8PdnTjZ8UlNbV9xBtUcwfGqa3BkgK0+cROfyQDlVDdelMpSsQvWuuUbNV/SuOX/41RpOjeut8MFG4kpB1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=UiUBtBnz; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="UiUBtBnz"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A41F020704;
	Tue,  6 Oct 2026 09:06:14 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dYFoGXfDdJzj; Tue,  6 Oct 2026 09:06:14 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 278FF20547;
	Tue,  6 Oct 2026 09:06:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 278FF20547
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791270374;
	bh=iHrISD0ykxocG4A9U4GLCkTvtry/S+fBRfGGHYXd+P0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=UiUBtBnzqlfveAJ+6NDaLZGWTOFSE2TVbrdXsVUzC0nkf3rmwfZ1FuO/nccgkkCYX
	 AQJKtbpG3fvE2iunPGyOp3c6otNnBf/g11NnZLhQYPiLihehW9ShM256vbL+SgEH1I
	 hGkUiKVkul47mXFBFOIrMz/ohb0VfrlvIHXoEYAakcLuqF6ojFXw8VSlu+UEEfzWCw
	 OJd3H8vGNEqOg/9evp+wwsn8Hhk30nRlsqEwYovPKlbOAMeq+vdkKTxj6wbxQyJZ2/
	 SVSTyB/uAOVecBo7Mqa+pnty+mFUjX4i6Cfjs0OZL65ch7ITN/yH1lKcr8b45l4K7e
	 UuRMiEdfo+5xg==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 09:06:13 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Jamal Hadi Salim
	<hadi@cyberus.ca>, Shuah Khan <shuah@kernel.org>, Paul Chaignon
	<paul.chaignon@gmail.com>, Louis DeLosSantos <louis.delos.devel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>, Yan Yan
	<evitayan@google.com>, Tobias Brunner <tobias@strongswan.org>, Florian
 Westphal <fw@strlen.de>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH ipsec v4 6/9] xfrm: fix hw offload state leak on xfrm_do_migrate_state() error path
Date: Tue, 6 Oct 2026 09:06:03 +0200
Message-ID: <migrate-state-fixes-v4-6-d5054459fc78@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-fixes-v4-0-d5054459fc78@secunet.com>
References: <migrate-state-fixes-v4-0-d5054459fc78@secunet.com>
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

In the error path, the cloned state is dropped without removing its
hardware offload, leaking the offloaded SA entry.

Fixes: a9d155ea9b44 ("xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 8640838dcda0..4de8c401eb44 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3541,6 +3541,8 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
 	xfrm_state_put(x);
 	return err;
 out_xc:
+	if (m.xuo)
+		xfrm_dev_state_delete(xc);
 	xc->km.state = XFRM_STATE_DEAD;
 	xfrm_state_put(xc);
 	xfrm_state_put(x);

-- 
2.47.3

