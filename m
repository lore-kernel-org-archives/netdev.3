Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DB01A0728
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 05:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774933342; cv=none; b=Y/XgDsXvHVUrqvLDakhUSO80Q3hdYcSBkcSlQOljyAvPlOWxEBKaDExDRJQF/dRo3GB9saik1IPZy9DKyidRzhdPfD9TcJ4OxcXxW0oAilnRO7slYJHTcm4BuKVS6IWk1HICDYy593m3DrchSg6fLnd8wYvY6MMuughH6sdpoPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774933342; c=relaxed/simple;
	bh=HSViWL6qmR4G6CYQFHwaB0+bKGCfEgbDuvH/aVZiMBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BUtYNd8y1qSuLWFU8E177TZSv0wk9desdGengaao3IfTr90DmcXXkNTKM7ia+cvUmgnxi7i5P+zJ4KPzjC7rcjRw3KWm7WiTul7z55ou5a25mTUS1hsosE3F7YDmIBcPr5l2pJdqTMb6SJzSqHExVF2Zg6uhKgmxT6WsGcrBZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=AZxd4WWH; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="AZxd4WWH"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c7d8bbad06so1254378eec.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774933340; x=1775538140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PPllFL0XGQvii3MpiDHswJyXI/iiimH5c7285IJsb2k=;
        b=AZxd4WWHVInqCAqaMjXjvJPw/d+Zlq8kH0geYTgBrEnGk3QE4ANHbC7Lsd2UkJNLn9
         +DM1lH+OH4mS5jz3pkJVzim+ocxQVptk3iHQ/U4WtxCJgVrdRIOtZMF8rrDKGPdbQRbQ
         +09ofAilAkCpqiUYW3iKtF9GFFUNp8h9EjZFeO4n9/vl+xi1OhaPJR1GNZtSYLzZ8IwQ
         2n2tju9LXrZmr8wEb+28JA4R5gcPYI1+bzVZZb5xzJwjbUqFWtw/gY+wxyWSN2MpYD1r
         H5AAYHXg2Wm97O11SdO10uQdJ5QEcQAMSwOXzELPBA9wa8iTSWEwXetWSoz5uSvL5z5T
         ENUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774933340; x=1775538140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPllFL0XGQvii3MpiDHswJyXI/iiimH5c7285IJsb2k=;
        b=PU3K2ksiCnduirqao78UW64/FKAAdzeldnPVrw4oTDcHt8M1aSiWmVQjPUPYuLQPXI
         zTUU17g36CjT8zrjkN1cBWXHUyu4D4gTHjnDnkEjK+XYv8HaGJUmH7yRR4C3+gg5evqi
         iIqcxM4cDAXoldvtBYukNBKbRyDVCNYiEilKYmm3ghSQY+AbqazSRgPQ6R/M0tqj4IYS
         VZJpPf9G49s0k2aV62hPbQCfovI59PHr/f6Uak5pTD5sRTXXgJdOxyxdfrKJ/gKrH8pR
         1KpxVr0p07yqrlXeg/eVUmTPQpEP6R4WP0BQ5+V/WUNpzKdCqRlQ2R66CLC5mjGekXCS
         Fm/Q==
X-Gm-Message-State: AOJu0YxV16RrF8ZqP2oWXJgsTZ7v9hiQVCMNhJMiJ5/tXVNaaoAB84ni
	iIoWaKTOJgr11yAEzcjdUZcRZKff9WU75i1VifwxMMTnkmyFvp0DcuL+ALtxB4/4edxE2drUSfY
	v+R0=
X-Gm-Gg: ATEYQzyUs+lSzOQiNQ5X6MAz/9CEuchr1f2HH7yY66jG9mqQtI2nsvSmjTb5vX1KTF5
	3VdAwwcd8WNLPGiYCFXjLXr7+FCQxrVBQ5m4crTOKdwVE7ufT1pd955/i1tWtJxUzFTrT8ErQNe
	KmPAwA12uzfpt3y8OnaD7s7Cjq6gDVu9ehr2t4g5Yc4aSL07vZ4oedoW7jCEjzX+MIlTSQcyG+G
	x0J8c4XNgLYT6cc3tCWIK8V/De1QK3aSQjvc1BreIXsRmic9BPlVBWXTia+pCdd+6MhYMQvDcV1
	yRDCOTfn386CYQu09b2Xlp6/9g2rR1wwn94kRlfsr9C+WSTE7gGiZ8wzE1lgxVymfjSLvH0Q6Sa
	eywfNgzYTJovCN0zIgtqyO0sfhHYMaATErId2GtcSCxRBENDoPqfc7QKN7IZgYOoKzmvX13saAu
	L1SlvoHei6J6PXI4nEyIUrgbe1qkCqNccVElcMBu3MX18ZIHEN2u0gJhHXL7VOhZQ8
X-Received: by 2002:a05:7300:6423:b0:2b0:571a:28a5 with SMTP id 5a478bee46e88-2c185e1677dmr9089665eec.18.1774933339904;
        Mon, 30 Mar 2026 22:02:19 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7971d97sm9853819eec.30.2026.03.30.22.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 22:02:19 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	shuah@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v3 1/3] net/sched: cls_fw: fix NULL pointer dereference on shared blocks
Date: Mon, 30 Mar 2026 22:02:15 -0700
Message-ID: <20260331050217.504278-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old-method path in fw_classify() calls tcf_block_q() and
dereferences q->handle.  Shared blocks leave block->q NULL, causing a
NULL deref when an empty cls_fw filter is attached to a shared block
and a packet with a nonzero major skb mark is classified.

Reject the configuration in fw_change() when the old method (no
TCA_OPTIONS) is used on a shared block, since fw_classify()'s
old-method path needs block->q which is NULL for shared blocks.

The fixed null-ptr-deref calling stack:
 KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
 RIP: 0010:fw_classify (net/sched/cls_fw.c:81)
 Call Trace:
  tcf_classify (./include/net/tc_wrapper.h:197 net/sched/cls_api.c:1764 net/sched/cls_api.c:1860)
  tc_run (net/core/dev.c:4401)
  __dev_queue_xmit (net/core/dev.c:4535 net/core/dev.c:4790)

Fixes: 1abf272022cf ("net: sched: tcindex, fw, flow: use tcf_block_q helper to get struct Qdisc")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: Correct 3/3 selftest case
v3: Avoid the bug earlier in fw_change

 net/sched/cls_fw.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index be81c108179d..23884ef8b80c 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -247,8 +247,18 @@ static int fw_change(struct net *net, struct sk_buff *in_skb,
 	struct nlattr *tb[TCA_FW_MAX + 1];
 	int err;
 
-	if (!opt)
-		return handle ? -EINVAL : 0; /* Succeed if it is old method. */
+	if (!opt) {
+		if (handle)
+			return -EINVAL;
+
+		if (tcf_block_shared(tp->chain->block)) {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify mark when attaching fw filter to block");
+			return -EINVAL;
+		}
+
+		return 0; /* Succeed if it is old method. */
+	}
 
 	err = nla_parse_nested_deprecated(tb, TCA_FW_MAX, opt, fw_policy,
 					  NULL);
-- 
2.43.0

