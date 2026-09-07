Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6443B8124
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788808910; cv=none; b=suWyOHVvCBxE4dQO4HNEnQUEJ2xBC/XbupvyPVJEi2vWTAvsGnBcckbL+qQzdyC5yIQNCVClsuVlDQnhEEHJVxULofwn58j+5ZdS6GJGqVvciWcIqVhb/JHp37Fdx8tLq+hPWxpCwtxu74IqZea690Xjf0YmnRqS4VFIKvFIj2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788808910; c=relaxed/simple;
	bh=XfKSoSOiGi1GwgVANz4P2FqZZIVjBnK23ZFjJW6a2KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aix/GiGOvLKBauBJoJyUWWEXaF7RtZOEQiJ4afzDxPzr39Kf0PfdPmPa10sDIF6vNp3oJ+C4ZdMiOQs4Q1/mzHtAKjFG+zHaHL7A9RjVO2JTRZVeY8/wZJvYZ+iHqFRNOXO8fB+sdGBnxOaIgr2D3NqH/TyD+JZjZVZby2a5DO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=nDZoMnjm; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="nDZoMnjm"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8623b1e7cb2so17233907b3.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 12:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788808907; x=1789413707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7JcpgOVVLGSnTkEv2UDVkodmZmnVP8McwMN4F+3lMY4=;
        b=nDZoMnjm253usvPTupS+VP8cwYZ/m901yZOowiFauzb1PrWMao0psoAmy05WxxxlvC
         DacexO50VC7X/PYJUuoay26Jc5KOB9UFTtofdE5KwKLFk0IQuuBmtoQ7rq1VH5izBovG
         SIIrWLpVGpiPrbP6dD4Gx5yWiMtAnF/VZ7XGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788808907; x=1789413707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7JcpgOVVLGSnTkEv2UDVkodmZmnVP8McwMN4F+3lMY4=;
        b=f3smNnWgKrgDcefwQV4R3OjzRhwMYrj8qCzjU2ikqpcnVG25LLujB3DsGHXUU/R4X8
         hXUyG1eIuCLT+MUlnnP+CE4pfE1yAuIXr61avTmTOlLXP81y5Z2XAve8XBltrnKYLRxV
         VLa4eFoqClzCkD5WejwZelIwSLpUpUt6Js0kweE0w821C12WzEKiEWeZ7vpekU7dsGFF
         LqHqjK4UXDRwBT1FZ/kObEw3yYHTmidhT07YXQX8Mqbr+HgYS9ofrl22KOdiXIBIZHKe
         OZvHtQFJm3WxFVldroWFGA7pJPQtQN/xNgl/FhC6H8sPbdWE/TqfwSYRnMnLvwr9pyzM
         0eUA==
X-Forwarded-Encrypted: i=1; AKwUvBwunJ2HJPyucmNFrU7adRQWOJP4VeJMyyhGHnG+57ZK+1+K8sem0wSJeEeQjne/i4KCC0CUlyg=@vger.kernel.org
X-Gm-Message-State: AFuF++leeJa5aN7IyrvXAQBVAXHUt75luJ2/zkVjGZT9Qv+KqGtOWTw4
	5j9RWeovdDzJw1fRK4Tp3km9ZqUET0Rd36GvlhXHaQde+Jn4mb7dKmmFDkFrHuGjYw==
X-Gm-Gg: AYBFou0Y5LWAM4rT0Eh1iVYRlraOAXXPUAJdC0r6pigMLFmzE7Rs9oez1u/0N+nX0kP
	U7pvt2XQly5ex7koU0UeHXpiOdpK44bR19rAA1FICHOYSV6FSqqcxARNSRhGK5oYNz83HPm/Lcm
	wy5lM8ZpHh2Jy4lh5W8E9z1Rrh5/7qnhxG6WGLrDEgan3K1wICEq9wkjYwRarDuRK7mZGYADYeQ
	PiHeUcYt5vq/Z3AuIBshHeSP5MdVBFi4KQRRJE5+i7ZKzlN838NizFYmiTNs7oA08yVRHYIVIX+
	LEFrQo1k4NGsoyV5HUwjMtDhIVkWjk6Ak1iMtLlr5bUikqH/IdAjAgJ1ONqqVjHXfIe5c/v+tyx
	jx/mB8YidQiv3ox/WVqyByy4cnyHF+2iReRkblsjEalZB71D69pyi4aZQYZqqXFo7uDQg/HGeLj
	cRbkV33ot/Y94CxV5WzebFfJNNeEuv4bWnHGyJ4Rs11Bs=
X-Received: by 2002:a05:690c:d86:b0:878:16f9:6ea8 with SMTP id 00721157ae682-87816f973b7mr30219727b3.7.1788808907220;
        Mon, 07 Sep 2026 12:21:47 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62bc77sm76546097b3.39.2026.09.07.12.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 12:21:46 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: horms@kernel.org,
	vega@nebusec.ai,
	netdev@vger.kernel.org
Subject: [PATCH net v2 2/4] net/sched: cls_route: Reject handle aliasing
Date: Mon,  7 Sep 2026 16:21:31 -0300
Message-ID: <20260907192133.2639067-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907192133.2639067-1-victor@mojatatu.com>
References: <20260907192133.2639067-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

route4_set_parms() rejects a duplicate by scanning the destination chain
for f->handle, but f->handle is the handle the filter has before the
update, not the one it is about to be linked under. The comparison and
the insertion therefore use different handles, which causes breakage.

When a change moves the filter to a chain that already holds nhandle,
the scan looks for the old handle instead, misses the collision and
links a second filter with the same handle:

  tc filter add dev lo ingress protocol ip pref 100 \
    route from 1 to 1 classid 1:1 action ok
  tc filter add dev lo ingress protocol ip pref 100 \
    route from 2 to 2 classid 1:2 action drop
  tc filter change dev lo ingress protocol ip pref 100 handle 0x10001 \
    route from 2 to 2 classid 1:1 action ok
  tc filter show dev lo ingress
  ... fh 0x00020002 flowid 1:2 to 2 from 2
  ... fh 0x00020002 flowid 1:1 to 2 from 2

The newcomer is appended after the incumbent, and both end up with the
same f->id. route4_get() returns the first match, so the second filter
can no longer be addressed by handle, and route4_classify() stops at the
first filter whose f->id matches. The second filter is dumped but is
effectively dead.

Fix this by comparing against nhandle.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260829205422.854785-1-victor%40mojatatu.com
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/cls_route.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index 17b0ebb76662..9710b77d379c 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -460,8 +460,12 @@ static int route4_set_parms(struct net *net, struct tcf_proto *tp,
 		for (fp = rtnl_dereference(b->ht[h2]);
 		     fp;
 		     fp = rtnl_dereference(fp->next))
-			if (fp->handle == f->handle)
+			if (fp->handle == nhandle) {
+				NL_SET_ERR_MSG_FMT(extack,
+						   "Handle %x is already in use",
+						   nhandle);
 				return -EEXIST;
+			}
 
 		refcount_inc(&b->filters_ref);
 	}
-- 
2.55.0

