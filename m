Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6A34A3BF
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445659; cv=none; b=niRuZOuo1XsrZJR7HPFHJlZ0Zi+XFoElooyc0mZIbDInUmYvIcHdaCzEgX1aiQ/4MkgrOd+nzToZ4VyiEmz6eOtlioB638Slqinnpx9Yiz0XX2lklVF5gYJVX/Jx/3IKxCEt639Hjq++WMdVoAsF99Zo6KRKvsl5srcdcuyp5Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445659; c=relaxed/simple;
	bh=c8U72Avkq333DsqD9ebaP4WB+h80LMguvXOyTKQuRls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WKyr/URAAIZTjQhp34O6AWgDreLqaPRlsJJh79S0uiitX9jRjMCCGTEuFbuGpAP32Uqo+PemeTXp+Vk78aIDBksknShFfucwL6gSIzsQZbv/TeFljVxOFpfmArrItRZOMqOJz+VJv+D0QfUCBnrJMkEbNuegXsBu0XyxRaJq8UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=A+/miluq; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="A+/miluq"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533930955a4so25595641cf.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 00:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791445657; x=1792050457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l6FZSSbwSezRp+l5hlW6gyTNpXrpjcdpoGWNZxGhEuk=;
        b=A+/miluqCDNEiHmLgCtYoXX0uKBGqHcjEwGZv5s53if45CiEEjZgWxrqAMEXbkGIk7
         +Q7Gz8kkZDKw6lc0RCXRiy4SoutPvJeDSzDNfrXJFP696a+5T9yiXFv+xNopxhBBGvMq
         pk9A++lV2fDLUNQWEtXhAhQ9m2Ud/630p4BBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791445657; x=1792050457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l6FZSSbwSezRp+l5hlW6gyTNpXrpjcdpoGWNZxGhEuk=;
        b=AcwVvFKeHHefsfm56uGdAOJ29Xq0xQx2rMquQeKrARQhsx7B1TBNsoUSa4gw4PuuDI
         7eNDUqlKcT5dzfcl2aQqBqGmKRqOMr56AjtrNkzCX+O1HQkrZmZ8L2pvZwbFqy9BKj/y
         0Z9e+5frLqh7RnM9G2xY/3njFrWCws5c0SOi5PrQ5HsDT5np8/7cNZTuxCjKtoUYvj90
         NVGoY+5R9ztrYC0UYjk+BD58uYgeXU1YV+Dkj9VVXWzEaKNAEPKwqEK8L4/0KChLMUjz
         QwMx3KCCWg+cQsoG0KOLDm4UOAGArIOouyaOtYNo+enL+NNSoTNcLErjDHNfgXJEt4Aj
         wNpg==
X-Gm-Message-State: AFuF++ns1a042fSANUulrFFD/kb9vynyuyLoloqHcaP8Nhth9n2rVQBd
	OL20YWAK1n8nWbApnZpoPqMzsi5//QxyRdkkk/qKvOWPEsotRKzH+lNF32MwxmoJBsvZzYGca+X
	fPRnVsg==
X-Gm-Gg: AYBFou1ZIjQxw20zth3sODsBd74SqBT+v/ejPZ1h1V06A1L/ujvI8mExfeLdQXd8v/K
	aRrIspdgsyQjM0e5R28OM4sgpuTPgkkNuZYHclIohgfHzupfSTyVUvtq9dxPtqOgK9quMRmc6QY
	xyN8X6oJFDbhZ0wth9bwZ/VbuazOdxZyUmEgCrEEnOX/9FCZyBQ2j1nMpLVFSUyD2BzM1fOYfyo
	a9wtr9R098Wkbc+QiIYTl3EDeNxj9Bny2TzR5coj7YRcWgOeRrPjVJMT6pwkJigAYAWfqjF2Pln
	/22bddrGmuAwSSqB7crVHwCY4s1RElxAEq7ynAgUjL/xcLXF8A3l3LTdReSkAWv1ZMRN4xqdAFi
	+vUIf8ma5Bk3mRtffV+yQPSKbBkX2/oOSToRqGFFDTIck7E2ZPW839yEaG03x9fj4Cjg8BR1Uhn
	fgswTR7wCsP3bzi52vXUxehep6bQfnlLsX0uBdxEMBLeBF1P9aOauiDpQl9qCcxBgqwgsqJ90wf
	xCzlkRHgsQikLNIJFzBrxcvpsmu2uhhxL9DUnFds2UBuhSpLg==
X-Received: by 2002:ac8:570d:0:b0:535:2e3b:6885 with SMTP id d75a77b69052e-5357560d7eamr85925811cf.48.1791445656785;
        Thu, 08 Oct 2026 00:47:36 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5357213f3dcsm38253961cf.17.2026.10.08.00.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:47:35 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	cake@lists.bufferbloat.net
Subject: [PATCH net-next 4/4] net/sched/sch_cake: drop dead nla_nest_end() error check
Date: Thu,  8 Oct 2026 03:47:12 -0400
Message-Id: <QDISC-5RTM.v1.20261007130704-5@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-5RTM.v1.20261007130704@mojatatu.com>
References: <QDISC-5RTM.v1.20261007130704@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cake_dump_class_stats() closes the TCA_STATS_APP nest with

	if (nla_nest_end(d->skb, stats) < 0)
		return -1;

nla_nest_end() never returns a negative value: it has a single
`return skb->len;` and no error path (that is why the overflow-aware
nla_nest_end_safe() helper was later added). The '< 0' test can never
be true, so the 'return -1' is unreachable dead code.

Drop the check and close the nest with the bare statement, matching the
sibling cake nests in the same file.

This issue was discovered while fixing a bug on the gate action, see:
https://lore.kernel.org/netdev/QDISC-H19Z.v1.20261001053234@mojatatu.com/

Conditions to recreate the bug:
- not runtime observable: the issue is found by inspection.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_cake.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 4caf9718c9bd..124f552023f8 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -3211,8 +3211,7 @@ static int cake_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 						       READ_ONCE(flow->cvars.drop_next))));
 		}
 
-		if (nla_nest_end(d->skb, stats) < 0)
-			return -1;
+		nla_nest_end(d->skb, stats);
 	}
 
 	return 0;
-- 
2.43.0

