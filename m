Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A6E472789
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937259; cv=none; b=pR6tbZqLJpij//3NRN4CUM0G0XgBCHi/X2AnMVnum6vqdLkAGuFupUC6g1CWQJaz375lcgdPBo0VbMlz04X3Ra9lc4ZMh+gK0Bk5SFi2Y57D1QWNAahmdkCnxiMaadpmD8SDLOCPk9tL+1eTgwp5BtoK53zITlmnDSsS3m0ALDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937259; c=relaxed/simple;
	bh=bSbVERY0fbBAKMYiBOQMSbce6hlSXKbL2+6aAdD0fvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nc55BdiObXg2A5zUUO6J1xKQBH26I2pTjV/w0mLPojbDP8Hu4Laj8fNIpe1wZyMhNUSGFLeVJYqne0Q35sHy8f5SNYiW1WoFC+lROp2MyGaw7dv6+MZas2xBXSXLxDGZj8EQ3xoQCdUGOjfTmquKbuoiJH4o55uusbsWJ9G0V+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=FDe+wvl2; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="FDe+wvl2"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5c375a9e76cso581757e0c.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 06:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785937256; x=1786542056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XurPFXg/JJmAvCasDVhA/y1TusgyJKNUZwkQutcgkhQ=;
        b=FDe+wvl2Z4a05LaJrw6IF+in38Vjft5s1DpjLMQR89CgCAWxrRt6v+zy5/jP3FztfS
         V956W1C97cbVhylhgo9wCF+Ewi6KY1r8gBq5tpPjzAf8exkWjb3ryPvwUer89FBzyYXQ
         XLkRcxk4hTv4nI61qu3U/sZ9nLxFoEq+9lT8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785937256; x=1786542056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XurPFXg/JJmAvCasDVhA/y1TusgyJKNUZwkQutcgkhQ=;
        b=H+FAPEtZkNc9Gz+VudNFkWuvQ0azyY/h7wsNPouvocJQ2Mp2l0bMqS6gJ0qwIkK2kA
         dKBAG7qJgKWbO6SRmkSLUoUxJMAq6fYbv5OqDiaN26AXKOk/FG+LmckwPM7X19wo+eDg
         2wYeZUK92BgmbxzWe5Km9hO2DDFcJJxMTnd/27sYyX5c+eVs8tKAs/Ou6Z+AO0mXoaR2
         gYr2kB921nd3YXnkffwnl62SOybC79SxHxmuZAOjEi0w84xLsdBAzRCqUZRhzVeatFA0
         yrPyt7kt5JizFPUXZ+DoZEBcte7R05yy/dfxBackb2YjmV6METePAokX/xpciVGQalWb
         eDJQ==
X-Forwarded-Encrypted: i=1; AHgh+RqsBdLDg53SoHXqSAmyKa/LI+6ZsGNeQDeahpw+4jmj6N1I+Jxfk+yX6zODUcZF7h32UBgQkOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeBBDFGSd1gsSB/aTC2XM8Yus4//5F/5fKJsInyaNDDZsIdS1H
	m1PQ3shO6ffpFpbxgX6GKEIiA4+YnSIaEH8K9eKyy7AXf2XbyDrvIP+BEJMmIShkcg==
X-Gm-Gg: AR+sD13R51eXa+AIqrHYjsdnIQKjj9hpshgjNpv7FrJy6FBaRcRt2a0iNY3/89H26Qf
	xbRtvUfGAznGwbwK52jv/HJDCUQUglw/gpVMbjdj1s+Vr1PAibZghjX0XwttyykWUU7ZhA3Y3rh
	3laRZMrfxVapfdAnC0CV+3wy8xhxc/ydDgLz6JMjwgcPnDSxMvdL0jPp/tU3LZ+4Wt8k0/zPdxZ
	4VhUmpIIbM0SzIA8g4EeM1oRkd9IHT0XoCHApQrOs4Arrvz0/ahJ7u5xqVVfg8cLKmoOQZjG4xx
	vyp3htu8F393M2oWuaEiLZ8Y9UhRe8xC/aiBlqv7JJLdpCM4A9g6qDIhi0NRgU5t5CQFFqyxWuz
	awlYbxztJ3ObBHrbkbvFysWot0v9Suh32QW3ojoZnyU6dQYSSBlcBnEuQGZJBgny1dZ1niBivl7
	md7ZlI46EWR1/B9mVamICOJXjpzI0SkGSYdXsHLcT3VeY=
X-Received: by 2002:a05:6122:d8f:b0:5bf:8807:b154 with SMTP id 71dfb90a1353d-5c3d941f4aamr941492e0c.13.1785937256451;
        Wed, 05 Aug 2026 06:40:56 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d0578544sm1628792e0c.6.2026.08.05.06.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:40:55 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: horms@kernel.org,
	vladbu@nvidia.com,
	netdev@vger.kernel.org
Subject: [PATCH net] net/sched: cls_api: fix teardown of an adopted proto on insert-race loss
Date: Wed,  5 Aug 2026 10:40:49 -0300
Message-ID: <20260805134049.927864-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tc_new_tfilter() the create branch sets tp_created = 1 before calling
tcf_chain_tp_insert_unique(). When the caller loses the race (another
request inserted a proto at the same chain/prio first), insert_unique()
destroys the caller's own tp_new and returns the winner's proto with an
extra reference. tp_created was never cleared, so the loser's errout
path treated the winner's live proto as its own and called
tcf_chain_tp_delete_empty() on it, silently unlinking an active
classifier that the winning request already advertised via
RTM_NEWTFILTER.

Track the outcome of the insert step in a single tri-state variable so
each errout path reacts correctly:

- TP_NOT_CREATED: no proto created; pursue the old path.
- TP_CREATED: proto inserted successfully; same code path as before.
- TP_NOT_OWNED: New - lost the insert race; tp is another request's proto
  (chain ref already released by tp_new's destroy)

Both errout reactions are single expressions derived from the state.

This fix is motivated by the Sashiko's automated review of Patch
(net/sched: cls_api: Always acquire rtnl_lock when destroying locked
classifiers) [1][2]. The review identified the silent-unlink behaviour of
an adopted proto's teardown when a request loses the
tcf_chain_tp_insert_unique() race.

[1] https://sashiko.dev/#/patchset/20260801125632.360365-1-jhs%40mojatatu.com
[2] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260801125632.360365-1-jhs%40mojatatu.com

Fixes: 8b64678e0af8 ("net: sched: refactor tp insert/delete for concurrent execution")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260801125632.360365-1-jhs%40mojatatu.com
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260801125632.360365-1-jhs%40mojatatu.com
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/cls_api.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 4e6a2812a4f3..3271963c945d 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2248,6 +2248,12 @@ static bool is_ingress_or_clsact(struct tcf_block *block, struct Qdisc *q)
 	return tcf_block_shared(block) || (q && !!(q->flags & TCQ_F_INGRESS));
 }
 
+enum tcf_tp_insert_state {
+	TP_NOT_CREATED = 0, /* did not create and insert a new tp */
+	TP_CREATED, /* created and inserted a new tp */
+	TP_NOT_OWNED, /* created a proto but failed to insert */
+};
+
 static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 			  struct netlink_ext_ack *extack)
 {
@@ -2268,12 +2274,12 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 	unsigned long cl;
 	void *fh;
 	int err;
-	int tp_created;
+	enum tcf_tp_insert_state tp_state;
 	bool rtnl_held = false;
 	u32 flags;
 
 replay:
-	tp_created = 0;
+	tp_state = TP_NOT_CREATED;
 
 	err = nlmsg_parse_deprecated(n, sizeof(*t), tca, TCA_MAX,
 				     rtm_tca_policy, extack);
@@ -2395,13 +2401,15 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 			goto errout_tp;
 		}
 
-		tp_created = 1;
+		tp_state = TP_CREATED;
 		tp = tcf_chain_tp_insert_unique(chain, tp_new, protocol, prio,
 						rtnl_held);
 		if (IS_ERR(tp)) {
 			err = PTR_ERR(tp);
 			goto errout_tp;
 		}
+		if (tp != tp_new)
+			tp_state = TP_NOT_OWNED;
 	} else {
 		mutex_unlock(&chain->filter_chain_lock);
 	}
@@ -2455,13 +2463,13 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 	}
 
 errout:
-	if (err && tp_created)
+	if (err && tp_state == TP_CREATED)
 		tcf_chain_tp_delete_empty(chain, tp, rtnl_held, NULL);
 errout_tp:
 	if (chain) {
 		if (tp && !IS_ERR(tp))
 			tcf_proto_put(tp, rtnl_held, NULL);
-		if (!tp_created)
+		if (tp_state == TP_NOT_CREATED)
 			tcf_chain_put(chain);
 	}
 	tcf_block_release(q, block, rtnl_held);
-- 
2.55.0

