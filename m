Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE4B43CE4C
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585959; cv=none; b=AiqnXw0aLQ9S+zj/D/am++XKZ727auyifQidnHBAMYyvC6BTsyDAl0HOWkdotFqbEg2wsZRuwy4BJ6B4vx+zke2drN09nUiN8Oa5fVPsjf8zCveuWJwDZ5pRD99Y1Q+Dw01SjUFY+xkZEWUKdGe+AoML+/mEnTy4HPlMrIuRsqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585959; c=relaxed/simple;
	bh=IjetYUeW9lr3PbXixu7nPzICCPTghHS3oMFYk4M+rp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuYC2JY9L4sGjRQ4AkP0XVyHRpZ+Qb0S3xvq4W3QXUeNkW4YxAmw/CcfQwUAgBuwtHVJthmDmedIZ4a8YfamiwvPqLKFquHocj+SWJeGwM8CctktxKOiYSa59xRyu2e91vUv38O+DEvE4xsFMVqKxLosJTF30bt1GYww0gaUpfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=shSYHE3h; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="shSYHE3h"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc891373e0so40244325ad.2
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787585956; x=1788190756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Rg7+44fja7LjQKGuwvuVNRR/GQAvnJd7pWDCQCu/yQ=;
        b=shSYHE3hpJpUbBA+f4HKLi23lEjwUcAN8IAP/igjLy/+9iWbogfQkMw4BCXl928QUe
         SVc7vYAG6+jkKAr1f1ReAZZAw0vcP7dVRdUqgup/SwgxaA8zWXYlToDzsBkeIivMZ9Xj
         ZasuUn/lPtsI3RPg/Bb+6nBy749kmnQSRoDDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585956; x=1788190756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Rg7+44fja7LjQKGuwvuVNRR/GQAvnJd7pWDCQCu/yQ=;
        b=d47amUT6NS4xQmH65vbY1M/nOuVRMMod5I3JDWSp+MaQClrJwBWyX9dSdqqVKJXy/C
         P4NRXa5uRgkBD8S0FkLj+CLwK0sa+abIoCCvXIiSpmOP705RJ8HahtsHt9yFlDo58pHb
         z0glWnK4mE0WUy2tDtlnaLBtAoH4s5AARrWy3wqGOqgYGjweW3p+4lf9Ads20k8go7LO
         F6WK49fXVZZEwgnRgbEtPDR4qRz4vsTZsjiuPOAwbjpTtx8rbi2Y5FPyclQWyTjLzfkd
         aFSsrS2YatUX9V67hN8ge3wXw8py77hHib90k6aW7CsS3bs1+myICY3fYbW9jlkCeKOW
         ofvg==
X-Forwarded-Encrypted: i=1; AHgh+RpdAOa0IJUlsd8HAMHYmR4gunF2OVmG9oc+/nzdHS1tJBdCfVIvUBFLPbHgESaTl2f+fCI51tw=@vger.kernel.org
X-Gm-Message-State: AFuF++m1sqnIq7lwVKdV6Z5os7GTEjzqwIyNRzYX/4JiDkAvms4KQWh3
	RJEaxnAKe9WjTiKGXLODAh/HcXbj1+1/82lH48ol1SZaEYYDVve2HLFDa20WFZnEoA==
X-Gm-Gg: AR+sD11NfKXzIhBQQrHfJdiUVi2x9MW/XAOM94qsGHAGkaYsTyd9ZrbfhPwyLqgkyzR
	l2dnY8oEVhI+at7X/WN20fUyuU8JzY0K8Q1Skz5gm7pVu81cp+dDwUFrBLmIeGpHX3cI/OodSOd
	PWkmACsh9QreytvVLyYMtQMQiUT9yqtnhkUQL7kBoyopZV7ZqhSEFYWcYQW8N955pN42DEq0qHH
	17DaZjgYJmp/ZziTQpE7pG5QRldFUfYTY5DJ9/k0YkxvYChG5+hjE7ykkACh9NOq6ZLDHqResPA
	M00+RZPOWfofobmsmCMHV3pZ15i0bz9qG0O7z8xnpTfRZdMtccW1UAWNCNWRAxF2nW74GDUQOh6
	vp7v1kjgEscTSJsWbjRDs1IvqsmG5ptVDKUBHW2ie6L9sQzwHQjRTMKQ5gpMh3a43ba7/HFp/ww
	QCgAMkump4Uv3CsD4EaQ1lEX2kNMarU7EMbBGji92+WCc=
X-Received: by 2002:a17:903:b85:b0:2d6:ccc5:a3dd with SMTP id d9443c01a7336-2d6ccc5a4dbmr93576225ad.4.1787585956531;
        Mon, 24 Aug 2026 08:39:16 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6767b0aeesm18704585ad.36.2026.08.24.08.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:39:15 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: horms@kernel.org,
	baowen.zheng@corigine.com,
	louis.peens@corigine.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org
Subject: [PATCH net 2/4] net/sched: act_api: size the RTM_GETACTION reply from the actions
Date: Mon, 24 Aug 2026 12:39:01 -0300
Message-ID: <20260824153903.4143642-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824153903.4143642-1-victor@mojatatu.com>
References: <20260824153903.4143642-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tca_action_gd() already walks every requested action and accumulates
attr_size += tcf_action_fill_size(act), then wraps the result in
tcf_action_full_attrs_size().  For RTM_DELACTION that value is handed to
tcf_del_notify_msg(), which allocates max(attr_size, NLMSG_GOODSIZE).  For
RTM_GETACTION it is silently discarded and tcf_get_notify() allocates a
fixed NLMSG_GOODSIZE skb instead.

Any action whose dump exceeds that fixed budget therefore cannot be read
back. For example, act_pedit overruns the budget with 32 actions of four
munge keys each, act_police with 32 policers once the optional
rate/peakrate/result/avrate attributes are present

Fix this by passing attr_size through and allocate the reply the way the
add and delete paths do.

Note on exposure: RTM_GETACTION is the only one of the three action
commands that is not capability checked - tc_ctl_action() requires
CAP_NET_ADMIN for RTM_NEWACTION and RTM_DELACTION only - so this turns a
fixed NLMSG_GOODSIZE reply into a user sized allocation on an
unprivileged path.  It is bounded by TCA_ACT_MAX_PRIO actions per
request, and tca_action_gd() does not reject duplicate indices, so a
single large action can be requested 32 times; an act_bpf program near
BPF_MAXINSNS is about 32KB of dump, or roughly 1MB for one request.
Creating such an action still requires CAP_NET_ADMIN, and the add and
delete paths have sized their skbs this way since the Fixes commit.
Should this ever need bounding, GFP_KERNEL_ACCOUNT would charge the
reply to the caller's memcg.

Fixes: 4e76e75d6aba ("net sched actions: calculate add/delete event message size")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810164357.1653956-1-victor%40mojatatu.com
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/act_api.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 766162b0b810..20b6501fd33b 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1697,12 +1697,12 @@ static int tca_get_fill(struct sk_buff *skb, struct tc_action *actions[],
 
 static int
 tcf_get_notify(struct net *net, u32 portid, struct nlmsghdr *n,
-	       struct tc_action *actions[], int event,
+	       struct tc_action *actions[], size_t attr_size, int event,
 	       struct netlink_ext_ack *extack)
 {
 	struct sk_buff *skb;
 
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
+	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
 	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, event,
@@ -2053,7 +2053,8 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
 	attr_size = tcf_action_full_attrs_size(attr_size);
 
 	if (event == RTM_GETACTION)
-		ret = tcf_get_notify(net, portid, n, actions, event, extack);
+		ret = tcf_get_notify(net, portid, n, actions, attr_size, event,
+				     extack);
 	else { /* delete */
 		ret = tcf_del_notify(net, n, actions, portid, attr_size, extack);
 		if (ret)
-- 
2.55.0

