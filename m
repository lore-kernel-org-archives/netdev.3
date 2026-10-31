Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793475373;
	b=Z8398yavjLoJxhBpCKZ0GV9nY5l8JiYWaGh4FzWTxjjNeE1l8M3kKnYMPDUWWLnS7+7D
	 8mCKbR1uFSh9WYCz1uMeOSnNc6XI1JzCCus1ySLyk4Bm+MZMPq3gZ6ozXN0wOOah0n408
	 ZAblNc8PZ795kOQrB5Qy3aQninYQA9XslAZKz+Au5SBUJQs0DsmGfVC5rftn+QwIMFSGG
	 hs/NQdPZVu4Q8bigeOzlPRv2ueBMnlwXDv8/huR3nS2ataFrthClYECqZ9qTcjaVv5AiV
	 aKvuDFfWxWJbPeBTDWnPSi/HfoyIHEZOVfAiZw/aC7rDNZ8Lss43OSfF3MU9X1Fn5Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793475373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Tcw4NzrOgqE+x7t21T1n7e3eg9qgEAOu7RVJe3lTDxQ=;
	b=ivoz/qvRBVAyGQ73VVBkmgiJqjAetjYBtAstEOnacND1R33gOUNFxoJE+0oIP4hxzXb9
	 tCIsE3DCFuHIHPHXXZlkQ6tF3noSMUu2+ILMOAch0IC+zCuqkWbuRLtF8ajjrIyxHuSZZ
	 MuRrdyQza98J7WsEH/egncPsP/d4fFf7qLi3mnNZUKAJ8B7rfliwQQTIW1SzXEe+z5TDW
	 z6zfZce4WzlmHmqB1E2Il5hoZD7Sa1YBQ4qvHaCaIWudwCZyp6izXyysTRS0rtVEsFUnA
	 qEAb/h9OobOY20CWlrcac2jnU3I79T/8GEiuv/pWSb6fbBK8o0r8UWtDneja8iu+Z/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XImFTfsw;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB8606A31E
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 19:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59BB8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XImFTfsw
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f3c895a0eso164547785a.2
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793475372; x=1794080172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tcw4NzrOgqE+x7t21T1n7e3eg9qgEAOu7RVJe3lTDxQ=;
        b=XImFTfsw0SLwJqjGHU+fV4jK1Pitb1f2YLQ4OV5DYmpH1j0ONA2NwZptddo8FuYy7I
         D2shw2sErCs6c/bYUjzUrIdCefLv4uD8HxQGWFYshionn5tM2jrb4bVS/PyICOCIK6m3
         K2gb7eFXNzA8+TEDDD+UvIhPl/UxhqO1kLLxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793475372; x=1794080172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tcw4NzrOgqE+x7t21T1n7e3eg9qgEAOu7RVJe3lTDxQ=;
        b=sdpu6E2nbvZqT9jNa/2rbOO9GMDz02b0lXjFmwUjn/XzxV02g1AD2buL9is9W/2Axa
         SZEvk4+UL+UdABj2DIlhHFQNvlZUxlEzLSsK3iN6aU+8iu5Au3bRmniX5V0SJwOz7Tq+
         k8GJWXoDEWWt4GppK5YP60u8QIJ2RKV5/To++9FFJyvQUE49V/X/PzD3Xh1bYd8thJ51
         x19cMvvsZE3kYr53dmrZqww/xjByuz+UtVWNRuVUoGVYDXXG6s7kFjIPMYrh0j5E8+de
         Id7ORZAnu5PZK1w+jPxeRosdYwkba/M9u73GC+GMN/ug33kONjbfEJeEd3qfoIpLgslO
         nPJw==
X-Gm-Message-State: AFq9FYJ1ogKmLcmirE4YmqVIFyGl8n3dPDL3coyaDS3y0NCKqRgu55OQ
	kXiQZhrILVoQvrPPjBnFjzqd/o36kVajVjB2J20FPAgU402hO0nUvATzqD4lr/7Lbq/DbuPZyDP
	MUPE=
X-Gm-Gg: AYBFou1FzORCwcHh03t4djt3g/GoQE+jqPUjop3SOcwzAuhObjwW3tZKwfse2uGnMUl
	ZsWnM61vzmF8HM8Pj9aZxCM0mITTw67NG2SZWMO+Gge/Csq7j3E4tZT2dL7ABCYqSlGVvSYSch4
	HxdxH2vCchVwmNIun1/ddN/Scoq5Lq0TbPlT4PT7URE+SBv6AavLTm5gQH4+f+CC6OA/zFlQ+Xd
	hEJnovwJt6Rptp+50MSNM16S6niaVWZl7+oUdJy8EgbdLudJcdB9ZXStMtIC6tdtULWnojzFb1h
	UvPl8oOvwmb/WvwC3jMwThNqu2tbiywoJxSjXQC9H1iAX/S83k9T/hHH4mTq8t1+2Cm2ZQmT6a9
	CY3ofYXBnHk97nQSo9M8jRXH5VkIrNa+pjnnQgKlwWdDHYyfC0/6fV8Vco0FX877qB2CB0rfXyK
	aPrUYekMQOiLHID4bPtvBGB+dDTX4skA/8dKwvCE0Y4YngvHNKhQoce6WXqZ2SOmlPj0fsDp18k
	mvEc9iZ7ifT7FDN7+qWMvES4dOlREOFpefZqP02x3a/9Uuv1gJSWeYT71tJaMtzjMgQbSjJPcaj
	Gj3OhNO9nqUaAfJWWUuNdbFY2NMV3iQT9tVkzIlURPfkroYbJAZyBC9/vBBh/JVtwbW99JIqvbS
	47EDl41qS2Vm6D5U=
X-Received: by 2002:a05:620a:8388:b0:943:faab:aabd with SMTP id af79cd13be357-944216c608amr1010302885a.52.1793475372306;
        Sat, 31 Oct 2026 12:36:12 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425abd317sm446917585a.36.2026.10.31.12.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 12:36:11 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Tom Goff <thomas.goff@boeing.com>
Subject: [PATCH net 3/3 repost1] net/sched: sch_teql: reject qdiscs from another network namespace
Date: Sat, 31 Oct 2026 15:36:00 -0400
Message-Id: <SER-NSBD.v1.r1.20261030042947-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v1.r1.20261030042947@mojatatu.com>
References: <SER-NSBD.v1.r1.20261030042947@mojatatu.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.

The issue:
The teql master devices are created once in the initial network
namespace and their Qdisc_ops are global. teql_qdisc_init() takes the
teql_master embedded in the registered sch->ops and uses it without
checking whether the new qdisc's device lives in the same network
namespace as the master. A qdisc created in another netns can therefore
attach to the init-net master and change its MTU and flags.

The Fix:
Reject a teql qdisc whose device is not in the master's network
namespace with -EOPNOTSUPP and an extack message; same-netns teql still
works.

Initialize the private skb queue before any validation so every
constructor failure path, including qdisc_create_dflt(), which resets the
qdisc before destroying it, sees an initialized empty queue.

Conditions to recreate the bug:
CONFIG_NET_SCH_TEQL=y, CONFIG_DUMMY=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y.
As an unprivileged UID, unshare a user and network namespace, create a
dummy device, set its MTU to 60000, and add a root teql0 qdisc:

  unshare -Urn
  ip link add dummy0 type dummy
  ip link set dummy0 mtu 60000
  tc qdisc add dev dummy0 root teql0

The init-net teql0 device changes from MTU 1500 to 60000. A pfifo control
on the same device leaves the MTU unchanged, and a direct MTU change on
init-net teql0 is denied. The namespace needs CAP_NET_ADMIN; no init-net
privilege is required. With the fix the attach fails with
"Operation not supported" and the init-net MTU stays 1500.

Fixes: 7316ae88c43d ("net_sched: make traffic control network namespace aware")
Reported-by: shaos <shawnq1@163.com>
Link: https://lore.kernel.org/netdev/20261022144830.67948-1-shawnq1@163.com/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_teql.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 409ce50cc0db..55f9944ca47d 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -188,12 +188,19 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 	struct teql_sched_data *q = qdisc_priv(sch);
 	struct Qdisc *first;
 
+	skb_queue_head_init(&q->q);
+
 	if (dev->hard_header_len > m->dev->hard_header_len)
 		return -EINVAL;
 
 	if (m->dev == dev)
 		return -ELOOP;
 
+	if (dev_net(dev) != dev_net(m->dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "teql master is in a different network namespace");
+		return -EOPNOTSUPP;
+	}
+
 	if (sch->parent != TC_H_ROOT) {
 		NL_SET_ERR_MSG_MOD(extack, "teql can only be used as root");
 		return -EOPNOTSUPP;
@@ -201,8 +208,6 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 
 	q->m = m;
 
-	skb_queue_head_init(&q->q);
-
 	spin_lock_bh(&m->slaves_lock);
 	first = rcu_dereference_protected(m->slaves, lockdep_is_held(&m->slaves_lock));
 	if (first) {
-- 
2.34.1

