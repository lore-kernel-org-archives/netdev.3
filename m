Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793477911;
	b=rzI16dj86CthQ/4aE4wNKmqqJovzJXYadQQBCMbW0xw0drx4bFaJD33FfkK9M6r63p67
	 MWjstUmc9NyMlPv0trGIm8sXdqs4ctfkI8A0k7YUo7AXcF+79aWtj70guXfYeyAHfcMDO
	 7Gxn0jxOIHCHi2ScPB88FMrzMGT+8evfZM6SnF4BDwU1UERi9fiZlw6BRh3YRN/wcVkVa
	 tEpRr2WvUpTTdTC1ymGCjcP8p7htz8ZJ2mjcfNxmXi2qlfJd25wyNEy6Or3j1syUPMalf
	 Mr4cN/JvQxwVjzgWlAvhAXS6jP5lSZZnWa8aMfkmto240iRtHayYOlyvT6DvCJWVymA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793477911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jGKJiamAitTKQtqe2g22VNzvYmBlctd6oSPWEhMy8xg=;
	b=eecoUePr7gDei/Rj/g7x/ECMk9W2GCO8/6nJw+lKV56L3VXBTSSRUrn2Sfq/ymi/5+Qm
	 gp/wJaHAQA6Jj1mEscBeioRNTZuiux3X999RKNWAYGM8aQFjfMee+6NLRqaDjNeuihz24
	 O2JPKOdwFo+y3aC2YlReC/u6qY3WXlOsKkSZTaG/mZJmNI0SNTqO9kl4ALl7zeg/rmaCv
	 uJPBBMq+uytpLM+YjrBzo8R8SVH1j+86DrPdwfBlu6A5plGHDO9ocjHiLEBe2A71e0P+0
	 GsoBSca3GzM64KjtAAt1MCOQfU8/rNuB8EcBwi2HFXHSo6/CBM+mqxpIitMK0TAyHvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="CSW/oTos";
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B4606A31E
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 20:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 334B4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=CSW/oTos
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91c79f306e9so21510806d6.3
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 13:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793477910; x=1794082710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jGKJiamAitTKQtqe2g22VNzvYmBlctd6oSPWEhMy8xg=;
        b=CSW/oTosbHHKk97aJNAmCwOBy46OHvfIHs+LRYjW6TQPx7ZLdruWgSTKuZUulrGi0C
         eZpR4tgHwAxcvcDmzuDGwdFFfUIexzPsvWPjj6OcxGKljaRGEWV9SrvKU5pVKjazt2vD
         mQU6XJqyvQhi/ihKsdonp0+/2yBPOnqw/rvIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793477910; x=1794082710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jGKJiamAitTKQtqe2g22VNzvYmBlctd6oSPWEhMy8xg=;
        b=OHfFIRYuby0oC641w3Lc1BgN5p+UFJ/UAca0+gnQ1X9+ibYUW7+8YRcAtVuzl1iNCd
         JhFDgIRbRWEYJ9GE+p4kbQjMS90q6FMunsNn+YyZNhs8cJwzjq85B8ATQiUEBJhloWZJ
         5fhyKDtp0NO1eCsA4femGlXVgiVAKvq6jG0G4yE7e7bk+jJzDSC4ARRPlWnFbzG+wO/6
         fI1Fo9jkBcFn3kAP366/7yGQh6hqL7EoiEUxf66fiIbZUhScz1X/pcNTeh6xOeFMb07O
         OveXaN8kikVsTpcWgJiJK0YsYLKpRH2QBorPj57XKcb4ita965ECD0O4+0icL3+9d8BC
         pN+A==
X-Gm-Message-State: AFq9FYI4l9aQVZXVyZqMxKvqrlMmOc/StR7BnUJ5R1VBqNXQhuucwMCe
	J5LkMmUmvgDYNxi6PU1zFkjwWPYBXEdcAzHf4j9oXw4RYULtI0uSfQmTyKpoEkqB9vhA5Fnahf/
	boIk=
X-Gm-Gg: AYBFou3ABsEnKORSOshRZelwuGia0pyD8C1cvf2qQrYwEMLYBMKmNUlesYrSIi+lE5U
	fXbrVb6MpRTJdC8TgNlOapmn1wcUTOAhNj/6GrqIt0LnoURS5GCFoP4JSPyjlCCUOnoie59RMSt
	DZrKcU21H8XGc9C6XxVhyEIQKoN986SaUFxIGaHoWbM/2rsdr68ekc7x06oacD6WWT3mX6+cKEp
	oIJ1yDG0FwNOjOXQxOij8zEbdjG0wmoL7qex8GpufZUAcXVuD/T7PoJCrwKHJAtS0SfR5qISJWK
	HoJR5mSkaADlBe3JA9/zlIrGRtmWZg59IBQjMhdF6CeupdwVKoQiipdN3Sd9bZ8mKDG92AyZ6wt
	rXN9qZhc0OWbgcQlnYKZUHSIS7doD7S09pq14ixTd+SnXPK+gRd8Xfsu7Yi9MbiEEke2em1wpLp
	7BkjL8AFl7SFFsZNbLOQFIXL8YV9mEcSmSVl+BjYa+4Ssf4kICz/z5OwOsO/G91sRWOW0BLlS6p
	buU76Fq9R1niUUJvewvyNWALUArKS55Wz7GIHkNdVTYEoAiQgONGHY86n5ovydr/M47o6LJNZfh
	5DSRCbDjyQyfJVQIJ+CCEfeUCrNjxERXwSRfqFg02jO46TUEVHJzrCZIyES8AOIebLlPlLwO5Tz
	yluOGzjyhfZ5/9w0=
X-Received: by 2002:a05:6214:252a:b0:91b:9496:6a11 with SMTP id 6a1803df08f44-91ca4b1cb27mr102837326d6.29.1793477910007;
        Sat, 31 Oct 2026 13:18:30 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7e23441sm49148926d6.4.2026.10.31.13.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 13:18:29 -0700 (PDT)
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
Subject: [PATCH net 3/3 repost2] net/sched: sch_teql: reject qdiscs from another network namespace
Date: Sat, 31 Oct 2026 16:18:20 -0400
Message-Id: <SER-NSBD.v1.r2.20261031160050-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v1.r2.20261031160050@mojatatu.com>
References: <SER-NSBD.v1.r2.20261031160050@mojatatu.com>
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

repost1 -> repost2: rebased onto the current net tip.  8b2043279dae
("sch_teql: fix slaves_lock IRQ deadlock") rewrote teql_qdisc_init() to
take the raw spin lock with irqsave flags, so the hunk context changed
and the repost1 posting did not apply.  The fix is unchanged.
---
 net/sched/sch_teql.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 70c948a26f80..c5f171a66060 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -200,12 +200,19 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 	struct Qdisc *first;
 	unsigned long flags;
 
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
@@ -213,8 +220,6 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 
 	q->m = m;
 
-	skb_queue_head_init(&q->q);
-
 	raw_spin_lock_irqsave(&m->slaves_lock, flags);
 	first = rcu_dereference_protected(m->slaves, lockdep_is_held(&m->slaves_lock));
 	if (first) {
-- 
2.43.0

