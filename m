Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339F38DC5F
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339665; cv=none; b=ODbxX9Zj/D0WLhRqwzYQr1MGPZ8RlKvX9qSOGbPTlV46EHQ4KuBFFOxN6CQ6043h8qcIYxNQGmCHoLPAK0qpidjIQkrTpMSAgHuvEeYfrKmtRfq+0iHoCQEreHR+D50HHrPQeG6vGldklJJuoBrFEw5RizffwQVL+p+X2OWN7Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339665; c=relaxed/simple;
	bh=+Aj4hu9feBsXWf8m2TRYQ0FuDwMeJQcP/R6iPNrPAY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnvT7geQkAB9ndVz+coxW7v+k4AMOPhtGb/PKgZeFLiBF+Y7ECVMqUMR1u1+tIiKdYl0sb0/qvUJiEaI7Iw3jrSR8voEAIPJAQdePHEUsOLGRysRJtMoDVfuhM9XCcxa9FXY/z7WJySQp8QUJeR0DW9LQH3pdiQ4ZJ4FXzc93HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaZ5puHa; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaZ5puHa"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84864086bfeso1154548b3a.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785339664; x=1785944464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YOS2GMqDmZduFqetQvjZI7itILk6KRkr43w5MIgXizs=;
        b=aaZ5puHafnvM3sPC3hp5m3m2Ixxlf6L7ug7yPXcaEB3xZXCezo3g8fXC20PhPZe3AV
         JYy+y0ZNYNOEDArRAr3CpdQFxJHpJO/iVnhGyLBcgsdQpbBP++5ar/xZElCl97R39VRd
         ASrE9GM8rdJVEafppPlzL36h8aqZj42hcQh4GsyVi5BGTXe78ostpNh00BQSSic3D0XG
         h9mUhx19pSSQsJmQrE7fGxqgltxFWXJ0JYaJuwWyXEzlhUla8F0k116yEqYRJJ4TFsRk
         aHiWc1wReLO1Zgvir9krtLzTBO6qMwUhF4RrZC20X1VgB6mkF7KD4WlEl8CchmA+/tMk
         eBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785339664; x=1785944464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YOS2GMqDmZduFqetQvjZI7itILk6KRkr43w5MIgXizs=;
        b=pMtgayxm7sLtAbmqFgISh1gk1IzxfnZGmqqhInxbF53wZ+jxrD5fvNFTTuE0Kc8NWZ
         xrIk/aPV66RxxUOPy5h93+2VVJzu8luLwdTTlvcKsIP8EODdQOF+ZDYq96YDvfA/GVp5
         BHiNH+HZkN1dHbFGwvG8Gfib9dGEzhqX8tiH+NkN9HMjZIgFFJOsMcgdDS2pUMsd/twm
         No56Y/OsioJkIjpLI8IstLC/FSQwn3c6Fh4Z5ISOrF36SqUtCUQD0Twv05GdeG8ORKfJ
         lVxthI4bbRVtFOGuDHlzmKzReyvxjFgzf/BfuGoQiyiLBw5ckDguH8zChFg4ygL0oQkL
         XTVw==
X-Gm-Message-State: AOJu0Yyk2qnQMZ+3jNrVkTeNJST3Sdr3ERl1LDHNlmiyDf+cBytgBDYL
	XLlxUh3o8i21th4eElU2ZZ/5R3TFP8FR551OrIJ2dGPOI19dXSikwim7PWYT1vwuEHA=
X-Gm-Gg: AR+sD12iGwW2PZHneQTj54rzayRiNFc+kHoIxnWCIF7dW/k7HxHmyIxG+8lA2h118PV
	1meywuWP49vgGRt8XqZnJ+mn3P6bp4B4ddWb/yEwcT6yIAMP962VzzUfjKVpcGmceugpMm66MvA
	KM8n1K3FQDZZAtkITMU0iXSpIvBtsSjH4fZbJfbQGr/LSwTAKJAmWHsLb33BOon1djpHtQVtOiA
	N7BIFIEAANjPKL4dq+pLzOdTNBvB/A220HxhnN+vV4JzdvKpTl1H7+asI2tB+49kClQ5FAbjtt8
	3ZYBnWBIAgLhL3+BcPiyYrF2gWtGp33TDBtJXz1apJke14eumDfFORP8xdBwnjdU06BYFR7KFFU
	uTjqwl17WzuyGXxH//Wb/dw0oxiVhUeKNWr1pSIEfdywaNsOiLBsOgcjHCR6V+mS8IEbyBNM81i
	eQkDJs8er7YNQY6PtLbUpR5UvQMps6dltd67bAULrY/avNGTmSAofQIhdhUmOf9WqPULrBhB2KT
	Qas
X-Received: by 2002:a05:6a00:23cc:b0:84e:2722:5d9e with SMTP id d2e1a72fcca58-84e93112e01mr7950248b3a.1.1785339663648;
        Wed, 29 Jul 2026 08:41:03 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe2153csm1618056b3a.3.2026.07.29.08.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:41:03 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	milkory@outlook.com,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] net/sched: reject overly deep qdisc hierarchies
Date: Wed, 29 Jul 2026 23:40:48 +0800
Message-ID: <99183398d8534a2bd65e8819cde9dae92dd97114.1785304107.git.milkory@outlook.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1785304107.git.milkory@outlook.com>
References: <cover.1785304107.git.milkory@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijie Huang <milkory@outlook.com>

When creating a new qdisc under an existing classful qdisc, the current
code does not check the depth of the parent hierarchy before grafting the
new qdisc. This allows users to grow a qdisc hierarchy one level at a time
past the intended depth limit.

Reject the operation before creating the new qdisc when the parent
hierarchy is already too deep.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zijie Huang <milkory@outlook.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/sched/sch_api.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 668bcd60d183..09d57ad76b89 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1467,6 +1467,24 @@ check_loop_fn(struct Qdisc *q, unsigned long cl, struct qdisc_walker *w)
 	return 0;
 }
 
+static int qdisc_parent_depth(struct net_device *dev, struct Qdisc *qdisc)
+{
+	int depth = 1;
+
+	while (qdisc->parent != TC_H_ROOT) {
+		if (qdisc->flags & TCQ_F_NOPARENT)
+			break;
+
+		qdisc = qdisc_lookup(dev, TC_H_MAJ(qdisc->parent));
+		if (!qdisc)
+			break;
+
+		depth++;
+	}
+
+	return depth;
+}
+
 const struct nla_policy rtm_tca_policy[TCA_MAX + 1] = {
 	[TCA_KIND]		= { .type = NLA_STRING },
 	[TCA_RATE]		= { .type = NLA_BINARY,
@@ -1749,6 +1767,12 @@ static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 		return -ENOENT;
 	}
 create_n_graft2:
+	if (p && !(p->flags & TCQ_F_MQROOT) &&
+	    qdisc_parent_depth(dev, p) > 7) {
+		NL_SET_ERR_MSG(extack, "Qdisc hierarchy is too deep");
+		return -E2BIG;
+	}
+
 	if (clid == TC_H_INGRESS) {
 		if (dev_ingress_queue(dev)) {
 			q = qdisc_create(dev, dev_ingress_queue(dev),
-- 
2.47.2
