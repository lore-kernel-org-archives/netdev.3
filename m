Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793579838;
	b=tkUsiLotf5W+eINvZ86GYkF6nEKjQZ29GVPHNa+KZaahP7esTDJcuhb9oHqI+aFsv/es
	 f1qVyu8vcsTx+uSx5IxuWvCUFNZ1/7Kt3Vo8qpr0zBvsWs1fMKCp0UCUzoJzU5HHD93AJ
	 lsuTPKDMkE6Vg2MQXSURQKUHb2b9x1kfdB77Mgmgps63+WNcq4wKiWGcvuBWJgNpGBjbp
	 gZ6Pnh+rWuf9B7nYQjnoRoE3y18zAroCNU54/pHLj2JosEbRhS8V8s5HkP0gy8qh1bWfZ
	 tpl49BzvadHHxdQDx41fEobh3D1FYBdEZ9Ge6VFgV1W2VZCrgiOX4E+MeO3wPLJKZgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793579838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aHxNiJHHxEssGSp/2Xs2oy5YS0nrj3YMaZixDHo/tOw=;
	b=C9XoFMpvOGXdxGdjyynPceW6XPn8AcSNj9VR4esoQhLPss8eNHukTmb7GJX9VbGMyHpZ
	 MYpVJGAB2tT/tQLH7Or7eM9yqYniqy2lbQruBb/aQtYSfAtZEG4mJXE/JfD9Wv2vTveG5
	 GQ4MR2TKg2/LrZPNbil+7OwjFiErH5APPVu0PE/SIl9lg241Bczv+b52N5ig35dvYyc4L
	 8zk7UZycr2jIa3Xas6gV0tiwQvcX+0m4a3d93fWWLmda+OHrmzrXF0+TW0r+4zJFz5NR5
	 f2aWKlfAHRItp6MHhhmmszlSYBfx0B5p0mTsqatBtXeOTWAUUdw2iGG8rcA73A1D2AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=A1VpEPx1;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546AB606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 00:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 546AB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=A1VpEPx1
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91c79f306e9so29599396d6.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 16:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793579837; x=1794184637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aHxNiJHHxEssGSp/2Xs2oy5YS0nrj3YMaZixDHo/tOw=;
        b=A1VpEPx1JwWNrUP3+P38+4tfAB5W5YbvAoGRutm3oWD/PL0fybiPt7a/mhpZDr7LGJ
         D1ObOtnWgXswSTSUXFwFifMQZpIPrBUzoyvKoQ9YSmte4R4xk/tesiSqZkxCahg/dil9
         fMZAG+Tsw6GjbAmF22Xi4+6jptWRDc60Bb7d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793579837; x=1794184637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aHxNiJHHxEssGSp/2Xs2oy5YS0nrj3YMaZixDHo/tOw=;
        b=y5A3HwuXB26g2dnTxgkIn5ehIVYiI/3q1JJznMXZ75VL7os0WeiuAjBI1H8kZDF8tK
         MROhHR/y9ahc2tzHVYH6T+ftBzXqd1Ev+ieXuoNZFbqhjptmZkGCF1vg78aX37QaGjEA
         ZWq5iZO9lz4nkRaNWvgIyGEO54HkxVgf7mD0wPl5mYvLAqiuQ97uiGDBD9CsQkocFpr8
         T+4zH8rg+JaJOmJivjy4Ril1/xL7i+LQMuJJ03PMi4OYSH7CeVmsoxYGCoFPQrfP/VKp
         PrsnPjiCiMUnXqHfUJN8dJh5n3/ma2dSJcvwWuWZgNPfCiWCEjRi1lrz7wzKn7Fd5Jdh
         fWNw==
X-Gm-Message-State: AFq9FYKfs62zf2j73yEAXYAbMLptVZA0gMuyKP0jBioPFftc/KalR55M
	J6qYcs74GQkUP4/8sUfdQdXvfLFc9Ku3XNf/f9YTWvURiMq7N3CJ7CNoC96TYxEblp/BEs7ETjI
	uEyc=
X-Gm-Gg: AYBFou0X+C1cYbgxXNQGMg1ncPFnCZrSIx1yGU/VPO5zce0ChoKvHbBzdah/53QKWst
	TN7U5OwOLroYPRi4o8Ybpyh//ewA288AHwaH6qfDUE7rDYRyzf3uxVTkphCoj9kDfn4Ux8R4jdP
	+wqRjZb5PmrLYLYEMsipfL28hggWTOczZEOLL46Pwr/oupwKcBrgrGqwtU6FBQ8hC/bGD113rV2
	1/asPKAM+JeZaaeupI93XatPUNa8CpGSsewfmhRx7HaV3RTokgl3oxTrhnMXtuU3gCGDh2jN7jV
	4qPKDmsGplEkq37NiCXWrR4Pr5v+TePARJLrNPMNmlByjC7chfocYbZO6ncP4T/VGMhuQ09w0TZ
	3vamOSiTmHPweLLqaw1LTOy/6lGy9RILXMi5aJF9/brFVIDJWeI5t6BOq34HfftDAz9K2XZjHCX
	ne7/h+cTGNrRJ21PvmRu6qmJJe8KZqh7eCFfuq1IaILrD0KUaZTYCbscBaFLF/Z1kv/mW2NFiQ8
	PKM4QIj48DM0OspcULhIVzArJz5hJ26cILuNZbonhkWM8nouKNrJ3WQt+4E/KVoupzmBqvZN4ni
	rYX4hBbsZ+HZc61d42i1NtKahyv9dyR57n8Bv63Ra7/0I6rHOShzqWJZJkgG6QgD0pfzBM4X0RA
	rIvZ4hSxB8++MCMI=
X-Received: by 2002:a05:6214:4346:b0:91c:67a7:1360 with SMTP id 6a1803df08f44-91ca4b1a2f9mr143205086d6.27.1793579837186;
        Sun, 01 Nov 2026 16:37:17 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f23754sm77043066d6.9.2026.11.01.16.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 16:37:16 -0800 (PST)
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
Subject: [PATCH net v2 3/4] net/sched: sch_teql: reject qdiscs from another network namespace
Date: Sun,  1 Nov 2026 19:37:05 -0500
Message-Id: <SER-NSBD.v2.r0.20261101171325-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v2.r0.20261101171325@mojatatu.com>
References: <SER-NSBD.v2.r0.20261101171325@mojatatu.com>
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
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v1.r2.20261031160050-3%40mojatatu.com
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---

v2: considers comments from Sashiko (nipa) on the repost2 posting:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v1.r2.20261031160050-3%40mojatatu.com

The cross-netns check ran before the "teql can only be used as root"
check, so every case it did not catch was answered by that check, masking
the assertion that tc-testing case 124e makes.  The root-parent
validation now runs first and the namespace check second; 4/4 adds a
case that covers the namespace rejection on its own.

 net/sched/sch_teql.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 70c948a26f80..dc21cd9704a2 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -200,6 +200,8 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 	struct Qdisc *first;
 	unsigned long flags;
 
+	skb_queue_head_init(&q->q);
+
 	if (dev->hard_header_len > m->dev->hard_header_len)
 		return -EINVAL;
 
@@ -211,9 +213,12 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 		return -EOPNOTSUPP;
 	}
 
-	q->m = m;
+	if (dev_net(dev) != dev_net(m->dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "teql master is in a different network namespace");
+		return -EOPNOTSUPP;
+	}
 
-	skb_queue_head_init(&q->q);
+	q->m = m;
 
 	raw_spin_lock_irqsave(&m->slaves_lock, flags);
 	first = rcu_dereference_protected(m->slaves, lockdep_is_held(&m->slaves_lock));
-- 
2.43.0

