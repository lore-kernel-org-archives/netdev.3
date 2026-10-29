Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316469;
	b=TXGG3ZtdHxrM79qlEYx226F/ScXczcHtoWBiydJxn2QHYzXw0cDNnBnImkbgvRL2/Z6l
	 vKRdrSbM4nAIFiF2zP9oMiaLtFcBcU5joxCqv415OdwreAeh3zxR59gPPAE6XnUd9MfcU
	 +JGYwTOBbfUa6dnECfggg3gioF5WGHzHre+4sWZrj9wnDqLrap96/GZxPVT5Rfkra/dba
	 wDT6EiosFGzlCykSXkyrz1DS9P2uWzy3Qi042+2hP75BmHQgF+kcsuoUbG6fw+5urn4Nm
	 qm096kcqj/r+ZzTFVNpMYMHDn9em81KRuEU2Q5qFCw2jawFDK2Q9NanmlxHjkTTvS/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Tcw4NzrOgqE+x7t21T1n7e3eg9qgEAOu7RVJe3lTDxQ=;
	b=m8b/x1YD3/beoGn1g2n171yC24ZeLHXoTaJpCFITQxIbEqDxZuhPGUd/TlmYgKKQ2m+N
	 DAHaza4QTZCiP6T0hgo2j9hYeROdk8IWOnqArHOUlSq818jjHm9mbIlfdD82jL9BaVWK3
	 GUomRiR4+Qn1cPr5tXrfURuoaCWzLo5BGU7QUB3SgF4ajxqiQ9IH84lZn9rFjTqxX4+vP
	 SwnmHkMnNEo+/pOAzRh8Ojo8tXRbSLfAFFhHDWtJFACLPWB7/C/eb06/baN+zLTvkLnqt
	 zxWbU4vsKPz7LzD1Hc/5Kb7gpEo7tYzJ07rsKNnLXPNmSIuPAFMbz6J9sGr9KsB7a4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=zP79A2BY;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8243B606A33B
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 23:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8243B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=zP79A2BY
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-930c0f9c1b1so6301485a.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793316468; x=1793921268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tcw4NzrOgqE+x7t21T1n7e3eg9qgEAOu7RVJe3lTDxQ=;
        b=zP79A2BYQxt43e0Mt2tUUbvkfLwmvNCoWjf2DYm+QaWHhzwqx+lljFgGZIMhh0rQU0
         EFhcZkiRWpwEj1IEFoXs6t0puXkEDNHUldaXOW3V2P1R2obGGKe8qtq8edadqPVn0PFX
         xBKJZZsgdeLzcPL5+kDojNbXqto2l+lMNmPGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793316468; x=1793921268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tcw4NzrOgqE+x7t21T1n7e3eg9qgEAOu7RVJe3lTDxQ=;
        b=0r8mmuCXJjBSD6lC1RjBybmRzNHvNlQQcb5pWCny6pCsc/AQ7cxyHBXwk97JGybKaZ
         XUi8PyhZPa7C0+YLX1csFQAvJDZh8Oek187K4fS4fEq4PE8Drx2XE7uW5rMhxCy/jCJr
         X/6d4pn7eK6cpixp80Sx4jElzUmoJRq6psHRmtPqv3jvxTGYr+SxkFOfjQNqi0NZIFNw
         q06T3RKisya/qVEX1PgfAMV293LMwEnIZN5bRRAyxJc2iyGS6YQ2LqBdYyYrjrV5fA6V
         El332J/e8ULOJ1ytCSDPR3LJnitgrD4JKZ32QN9U1ay/TBtZu7bLo5SYZ6rMGVBGO1eh
         Rmyg==
X-Gm-Message-State: AFq9FYK+E1kHhpdsVHncXOw4lRp2CVP2J6ImTVsb0zyxKXvPjMl6Xmb8
	OjNz57NieeWHGIywLwPQKWvhEtnLQMFx0ZQYXNMecSoytsnFCD3uwIgUm0Q4qq18PkDpocNhmwR
	ImMo=
X-Gm-Gg: AYBFou1Zf49x0jrukAaRAfVchPm4JZ6xZZ4/FVIq+JrQjEPDbFh0DPcMewRjU72qcvm
	DuEI8j8QSq+cUuN/elrRS5ksuDxh0UcQh611OetyzvjVkscZGEVBQbreSwKbNk9x6MDasI4KVqU
	VByoPVOFSnyJrcvWcbrg9JgfhRympXZNgYdr2kgboIoRzI3M2pppwtm95Am1W+rXwAXuotZrhAp
	lkoHpzO10lJtQu+2SDufqCRaXw8CUmRf0BLL0uBz11ea3VD4R6gP4a4etA0ZvOPdDgQjmk45p0+
	A0wJAjJ22yolmwsb7LGEg4ubjdT87lHPPfC+C5u4M8xzNqEronYzj+anKtRjMibkwcOTUw/AYEA
	2tXo1hrinNqgRRB/26EZ06iHsT0YjL4meGqJzZmdK1jbZ1faReEEGcqgNL68Iky0xPGsuMU8wRt
	qdsKUwczxjdqDxQ8sJLkitk9IxqX1XMywtwcZPFfZorliKLTZUKZwNDzRZocHF8DVMiKRt87QIr
	hFOutOXNnI/t+aONKiWR5x+N/fKX3X3n48AQIcXC3ejLLfOqEvSnzm9NEBCiAAlPCtcpkFVhhmi
	sKXDDLawKz5LeoWx4qpX5wKz2xoDykKhUWVp2HFl3pVtWCldNJ6+y2ZiXHQpKWMTtV07ew/uuLh
	yaO0wXcsjkx9lc8Vmdip6
X-Received: by 2002:a05:620a:372c:b0:93b:d79a:c45f with SMTP id af79cd13be357-944216cfea2mr131022985a.55.1793316468408;
        Thu, 29 Oct 2026 16:27:48 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94424243823sm5384385a.21.2026.10.29.16.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:27:47 -0700 (PDT)
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
Subject: [PATCH net 3/3] net/sched: sch_teql: reject qdiscs from another network namespace
Date: Thu, 29 Oct 2026 19:27:39 -0400
Message-Id: <SER-NSBD.v1.r0.20261029191634-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v1.r0.20261029191634-2@mojatatu.com>
References: <SER-NSBD.v1.r0.20261029191634@mojatatu.com> <SER-NSBD.v1.r0.20261029191634-1@mojatatu.com> <SER-NSBD.v1.r0.20261029191634-2@mojatatu.com>
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

