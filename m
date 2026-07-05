Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8E034F492
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783275480; cv=none; b=Ee2d5cSzwcA5FAULq8bnEb4Sf/mMZTMHNkXDD42ottvePwJcw66HVOabsvNEvKugKLrK90hfsxw8Vx/rdxTV5uCeh0c+rPIs5oVc1+DUwAy+Wz1dh8CvPQkhg3tJMJdGJn35euyX95gJ1QaQeLUds/XS7RhDDgVofZ5/9uwBXSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783275480; c=relaxed/simple;
	bh=jZQMbkqUKzgpB0N8LQscTBMu/tXkWJKyxlt06Wn+VMQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oL4LG+6bp1TGdZ/APcRpL9h3W+Ln521f0IAl5jvId5lv5XchNNp8DzYMfRPQ1FpaXYYDd1bLJ4SMZvOZo2jn/O5MDs9DO1zt7lJowdLQzck4FfcrsmcWbxXi0nkCv+gGe1Nlzp1QB09kI52JvVDZSV+43kAP4jdQjTd0ZPK9qYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DIS6HoDA; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIS6HoDA"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-51bfe3fa93bso26525911cf.2
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 11:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783275478; x=1783880278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4+JQduAhv8Nx+27EMZDv1egevlAnkPWlHznsmTvYV8Y=;
        b=DIS6HoDA5nncqs5JSbHvyblAki4VAQHV4mnDMxB6R2oc4OBl0fYlaJj6rHOVxOxA6i
         44yRnrVJGQwwtFjF223x7Qusjrt/0u4Ti48ejCJwUtA6DssKGCRqHM33/8LGt78gqZZh
         jHUGbx4xZEIcLUJCZjJLdVR1jYP9Yna2verRGKY09MCfsdJOnO9GEDCFvL9Of9tIviLX
         O6+XyUYHNAdxicnfA6lpfUbjuJtj83jfes8VAvPcJcH5hFgtig+X7eiJNnEaAXlbG/RG
         l6MuTFN9J6UJlxidQzp0snCfCjPZYFCAAPaul+CCnslfndXTNWzwHRDd0cszuJnDEd1t
         Myeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783275478; x=1783880278;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4+JQduAhv8Nx+27EMZDv1egevlAnkPWlHznsmTvYV8Y=;
        b=ZDnKV0kf/G+LWdQqxX6eqTnU5qsYmXqpbCU/GqdbQywLGDN9Bh2WYaDCI1X68D25QO
         ZftXamYvMGnw9Risk0jLnR1naFNWFvLwmFv5/rKMjyEdgjoAF7547TvbMHVfw26k+BS+
         dnhvtWAJt5yoFIAhPgDpAmbYL419TNcDADmFUi0OdmvNNoBzglbx/nufZGyIFdA0aYX9
         Vow7MHvLslIxAa1X3V16tslSWiSrZYgZ885DJGcVDrgYztV3HAnuZ/K0xHgVG4UL6nxc
         yTLk9fUWkp/ywyP1YLrV08cwFB5yqBtH0rAgtPvwFoe0YGijNuakxUucaysSPFPe+Fv9
         LnZg==
X-Forwarded-Encrypted: i=1; AHgh+RoEgf74oHjPUhBcZIvNaI7mbhHXciBrb+bTthqGhZn8R9oT/mzfKp6Re166yjJJ8qvOau7uTgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtRUeK9I8xSHACGoFbeiMLJ1adl28IR6ZzZyGu38zd+Vr9Gqid
	BFtCs+qBWSqByiNOdrP23nEyAk6KjNCXB4Llx+GR9TANr58YxtjxR98pkR4boHJTA8tSEfisB0T
	iUNrGSY+ctX5xtw==
X-Received: from qtbby27-n2.prod.google.com ([2002:a05:622a:95b:20b0:51c:1681:1a6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5903:0:b0:51c:504:2ef7 with SMTP id d75a77b69052e-51c4c351ae2mr105160041cf.67.1783275477766;
 Sun, 05 Jul 2026 11:17:57 -0700 (PDT)
Date: Sun,  5 Jul 2026 18:17:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260705181756.963063-1-edumazet@google.com>
Subject: [PATCH v2 net 0/3] ipv4/ipv6: Fix UAF and memory leak in IGMP/MLD
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series addresses two potential UAF vulnerabilities
and memory leaks in the IPv4 IGMP and IPv6 MLD subsystems.

The first two patches fix a UAF where the packet receive path races with
device teardown. If the device refcount has already hit 0 (but the memory
is still held by RCU), incoming IGMP/MLD packets trying to schedule delayed
work or timers would call refcount_inc() on the 0 refcount, triggering a
warning and eventually leading to a UAF when the work runs after the device
has been freed. This is fixed by introducing safe hold helpers using
refcount_inc_not_zero(). In MLD, we also ensure we only enqueue the skb
if we successfully acquired the device reference, to avoid leaking skbs
when the device is being destroyed.

The third patch fixes memory leaks in IPv4 IGMP when timers are deleted or
stopped. When a timer is deleted (in igmp_mod_timer) or stopped (in
igmp_stop_timer) and not re-armed, the code dropped the group refcount using
refcount_dec(). However, if the group was concurrently removed from the list,
this decrement could drop the refcount to 0 without triggering the
cleanup/free path, leaking the group structure. This is fixed by using
ip_ma_put() instead, and deferring the put until after the lock is released.

Eric Dumazet (3):
  ipv4: igmp: Fix potential UAF in igmp_gq_start_timer()
  ipv6: mcast: Fix potential UAF in MLD delayed work
  ipv4: igmp: Fix potential memory leaks in igmp_mod_timer() and
    igmp_stop_timer()

 include/linux/inetdevice.h |  5 +++++
 include/net/addrconf.h     |  5 +++++
 net/ipv4/igmp.c            | 28 +++++++++++++++++++-------
 net/ipv6/mcast.c           | 40 ++++++++++++++++++++++++++------------
 4 files changed, 59 insertions(+), 19 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

