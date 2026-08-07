Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962DD45516A;
	Fri,  7 Aug 2026 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085910; cv=none; b=d/98fBBQwwL0v64WkzXSnx+fGQMmMlSZg2+8hU0qcYqFXqAMq9P+/GpE4FtbhNTHZOXDLF/+1N0OBMcmWS+VirujXzO5oqMhYoaZIX4avj9fwPKtPd8Ja65p/Z0noHEA/NN2Hr4vQ5bDET9X0phiwgISxM0dzFVAwLg5qFhHjKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085910; c=relaxed/simple;
	bh=/aEmT9UrcURq9PDZs5fjN5LTc+aj1LMQ1wDfuInlqEo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BEuPk9HkE8YgSjOZzUCHVN6NOrAZrQlRs9zhtq7iB0oDdn9BOw5NhBZ+/JaSuiG1LrYspbe/dfJa5vlbUEdqIQIXN7kOX/2PQ+NTW9d4xuWGeSC35Filsv7yPLJhqbaHUVGxUdVxXGsqXUsJmVPUUDq2sS/wWWUD4epe6tBJhts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=i9srZo9I; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="i9srZo9I"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pRoC3IxBseUskQAzs2+chToiKMMzZikDNrJaWxvnJug=;
	b=i9srZo9Iec4mnGccNLDHg5TJ8Q3KicgqQqY7CXi+NAdbw7K0x8A4IQgnxvxngnhnrNgAXx6Dr
	3m7oC1hk37+6+kp29pX+MLGbEXxq4k32ptC1Dxz/epK+ph90oxF+khS9o0qlig+T/bDf+e+/xSx
	nfresuN//Pf4WackSjf6mOI=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hGZTZ5kmsz1K9Ck;
	Fri,  7 Aug 2026 14:47:46 +0800 (CST)
Received: from kwepemo100014.china.huawei.com (unknown [7.202.194.230])
	by mail.maildlp.com (Postfix) with ESMTPS id A5C4F40572;
	Fri,  7 Aug 2026 14:58:20 +0800 (CST)
Received: from localhost.localdomain (10.50.85.93) by
 kwepemo100014.china.huawei.com (7.202.194.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 7 Aug 2026 14:58:20 +0800
From: Zhang Changzhong <zhangchangzhong@huawei.com>
To: Cong Wang <xiyou.wangcong@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Zhang Changzhong <zhangchangzhong@huawei.com>, Jamal Hadi Salim
	<jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH net] net/sched: cls_u32: skip hash tables in u32_bind_class()
Date: Fri, 7 Aug 2026 15:50:38 +0800
Message-ID: <1786089038-36366-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo100014.china.huawei.com (7.202.194.230)

u32_walk() enumerates both struct tc_u_hnode and struct tc_u_knode
through the walker callback. u32_bind_class() unconditionally casts the
passed fh to tc_u_knode and accesses &n->res, so when fh is actually a
tc_u_hnode, which has no tcf_result member, this results in a
slab-out-of-bounds read of res->classid in tc_cls_bind_class().

The issue can be reproduced with the following commands:

    tc qdisc add dev lo root handle 1: hfsc
    tc class add dev lo parent 1: classid 1:1 hfsc sc rate 1000kbit
    tc filter add dev lo parent 1:1 protocol ip prio 1 u32 match u32 0 0 flowid 1:1
    tc class add dev lo parent 1: classid 1:2 hfsc sc rate 2000kbit

Fix this by skipping hash tables via the TC_U32_KEY(handle) check.

Fixes: 07d79fc7d94e ("net_sched: add reverse binding for tc class")
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 net/sched/cls_u32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 34d25f7..90ad80b 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1250,6 +1250,9 @@ static void u32_bind_class(void *fh, u32 classid, unsigned long cl, void *q,
 {
 	struct tc_u_knode *n = fh;
 
+	if (TC_U32_KEY(n->handle) == 0)
+		return;
+
 	tc_cls_bind_class(classid, cl, q, &n->res, base);
 }
 
-- 
2.9.5

