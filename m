Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4DC46AA62;
	Wed,  7 Oct 2026 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365706; cv=none; b=oVUanrSqvjYEgiEWFcT4OixUctTh+IG07Qkkuv1mRODkAOWtfROckHjrM0D9T67Ax1nry6J8denEY1ue0Cm5dUETmqg231PDfOfTSDU8VnfX2gWvCO4f8CcxX/kHlpRIuRTax3pwwe7+B9KkjauzCsOGDHxc1lcTmVvcvP+3YZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365706; c=relaxed/simple;
	bh=STdj1NyZ/CXu3QmVASONSlnoLGQWniAJEwR++4zfm8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AapiJATM1/3hQ5ot9l62ikKyGVevPh7NsoieIvccqD+CPeq2P35v3q3WEXr0WJOQT6YYgk0LI58yZHhDxw2FHw5ViwQLK9q0LecRtYRqPrU/NPSqiofx5qeYr838LoOK8akho6dGZJuwHVKFZLW656pes9VBsjUdti68lbz2vzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=gMzAmzIO; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="gMzAmzIO"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AA68E207B3;
	Wed,  7 Oct 2026 11:34:50 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yvyzsp5Sozqn; Wed,  7 Oct 2026 11:34:50 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 13A2720764;
	Wed,  7 Oct 2026 11:34:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 13A2720764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791365690;
	bh=/BTgAlW77G2wy5YPJKnnLQRzisoQuy/4CrtG1dzslzU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=gMzAmzIOHXFdkZ9bl84y6MhdyXetdGW02CIBLfxaMnJMGg7DK8wTxEPSGP1IgVo0/
	 zHmLVIbCGUCA9DmVs/numw+fRaZ9TUbH2VlGyB6tl33ZagXCnh3514ZjfaewfC26IK
	 GL4vzciSU22NbYV+e1R/HW3bZNuQEh4QxeZDftzmLWFv4rzCkGgyoelNpZGfr4I3Fe
	 xBr1FyWIkKY6JKHKXqI7gREoGRGOIqL6hcBqt0G71nrjE1KoKtPvW5xdyTADXQzIDp
	 KGY5QSwbduUd/QPZ6cTSj4bUhtuRZlw0+c4cScQhSdxrAd61ACi1JA2Pm9ahqU/QYV
	 ro8C/VM5Iyv+w==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 11:34:48 +0200
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
Subject: [PATCH ipsec v5 1/9] xfrm: state: reject mark with bits outside its mask on add
Date: Wed, 7 Oct 2026 11:34:28 +0200
Message-ID: <migrate-state-fixes-v5-1-d9d3d794553d@secunet.com>
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
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)

A mark/mask like 0x101/0xff is silently truncated to 0x01/0xff on
insert, so the exact-match lookups added later in this series (DELSA,
GETSA, GETAE, NEWAE, EXPIRE, MIGRATE_STATE) could not find the SA.
Reject it instead.

The mark is no longer sanitized on state add.

Also reject an invalid XFRMA_MARK (the new mark) in
XFRM_MSG_MIGRATE_STATE.

Fixes: 0b91fda3a1f0 ("xfrm: Sanitize marks before insert")
Cc: <stable+noautosel@kernel.org> # needs exact-match SA lookups from this series
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v3->v4: added this patch
---
 net/xfrm/xfrm_state.c |  3 ---
 net/xfrm/xfrm_user.c  | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index e45aa1ed5b96..602404ffc4d4 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1732,9 +1732,6 @@ static void __xfrm_state_insert(struct xfrm_state *x)
 
 	list_add(&x->km.all, &net->xfrm.state_all);
 
-	/* Sanitize mark before store */
-	x->mark.v &= x->mark.m;
-
 	h = xfrm_dst_hash(net, &x->id.daddr, &x->props.saddr,
 			  x->props.reqid, x->props.family);
 	XFRM_STATE_INSERT(bydst, &x->bydst,
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index a2587c7e796b..0723d791b8b7 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -314,6 +314,22 @@ static int verify_selector_prefixlen(u16 family,
 	}
 }
 
+static int verify_mark(struct nlattr **attrs, struct netlink_ext_ack *extack)
+{
+	const struct xfrm_mark *m;
+
+	if (!attrs[XFRMA_MARK])
+		return 0;
+
+	m = nla_data(attrs[XFRMA_MARK]);
+	if ((m->v & m->m) != m->v) {
+		NL_SET_ERR_MSG(extack, "Invalid mark value/mask combination");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int verify_newsa_info(struct xfrm_usersa_info *p,
 			     struct nlattr **attrs,
 			     struct netlink_ext_ack *extack)
@@ -333,6 +349,10 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 	if (err)
 		goto out;
 
+	err = verify_mark(attrs, extack);
+	if (err)
+		goto out;
+
 	err = -EINVAL;
 	switch (p->id.proto) {
 	case IPPROTO_AH:
@@ -3370,6 +3390,10 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
 			return err;
 	}
 
+	err = verify_mark(attrs, extack);
+	if (err)
+		return err;
+
 	copy_from_user_migrate_state(&m, um);
 
 	x = xfrm_state_lookup(net, m.old_mark.v & m.old_mark.m,

-- 
2.47.3

