Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0013845D3
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784759931; cv=none; b=mdOCnplj6NKbQ/CIL6zUC2CI5O/Lz4GQSItIg1gVFaDMKLKJAaluiQ3QLgXKh4W3VdYiAMCPECB2WP9etEGBuKmiBk1/1LvUGn7WHdcgR/iVJiHTg8Hl1/zvlwgcfSifdENILWpjrV53bL/0JAB9Z6bX2HUuJ+w4vl52hmTNOYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784759931; c=relaxed/simple;
	bh=ErJpjEQWDeZx+5Ukr3howqPNeHRsrbWj24/d7PrQaQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OeVZJJwTt5t+EoHEhKSdzvI/JBRKilLCMy0q9kZqbSIkJp+RH2IGFdhOc/95xzzqdXyD2sso3qVFQkTLRyg1h2T2z4iTwZtwLkyvKsKzO73WbNZTQFpyWg1+GavPvkSnAvOVpvcbGpW0yo95lg5LdfgZRpPE8sBEGVaH8otE3Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Rq6hTw6Z; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Rq6hTw6Z"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-383cb94f742so12305414a91.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 15:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784759929; x=1785364729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0yGVB60xf7Pehiss9PEglYAbbqwJonda8iGQt4O0k6M=;
        b=Rq6hTw6Z4f3OGzg0TZXmkGROhRK5wFWsfUUUHFbXycFpb3awolcFqFwM7MeFs7n2i9
         e9w28x9dy/GagegvrqgtJsTLMndJojHnV3udZNQXO+WXvGN4fURaVHsLmdD3XnC+gT4e
         M7NmAjxjgcLmEBhTf5iwZZykIOm7mjOGNhxfDltD1seAZvH6KMA1cyPHweqhJo8bNaiF
         UyCRMzP/IaLd0kDyGCEh2a7QzBkfE6aEDWQSqRRukoTjlHBKZubtWi9NnLcXh+FcMRiX
         AsAFxDSh0/iTUbVqLBkFonlI6xZlwaS99lJD6gkAykHZib7o2IuuWd2rXA3zA9wmRHmJ
         v/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784759929; x=1785364729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0yGVB60xf7Pehiss9PEglYAbbqwJonda8iGQt4O0k6M=;
        b=AaZUq9zewKRAer/JHCXhYrxNwOa2YkN7uU0mzgRJrP/Dp7XdN8EanCa6MpDnYSjNUF
         h0RbMDSDAz9po61eXK2AlBBRN2HnUaEVE+p3cbJit15+Ipx7Pt0wSAm2+s6Lx3F5nZx8
         +j/o2Mp5f03N5z4EwGF14+eRF9vdpipdM4DG+OYHclgnMUqfoBZkxa90x0s2Ku3M3kA+
         QL4VESxzUtsJ6IhC6fhShNsbAxPs/EwyQHUuyE6DpRICR8a+Oo6xifaarnrBa60Tb4k5
         ojhMZqro+90tNP1QB3K7yhppikGbIAZ0RCgg1HzEmJipKdWCMCENQyABlLxfqBqsGHkF
         s4WA==
X-Forwarded-Encrypted: i=1; AHgh+RqkG2HULFSqMj5uheWxHi/Q97yR3pqsc078ypjW5zgysc4t9kQAS+Y96iv2INRB8VVthXxKRls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBdm2WEhJK6DCLxllvNf9jl+6C0CW7SkjBZqSK3n1GaKa2lyV6
	PdpK4erxbg0h4et0y9Ig05R7HqWn5NpIfbXEDHgXrsf1W+m/lekT946F+hV1ja5ezQ==
X-Gm-Gg: AR+sD10yZ2+6kAp4wf+ENt1/7mNcI2YFY1B2IVB6OOQ4CgDnAioCtRGqRLfQMmS3cuo
	yQC7CNb8Tk9R+mP0qI9Q0QsGAyJJRua0K5K77tonCMCBRxrWgspTae+1DlfSA97b1N6VAUpWx4D
	wWQg9cOqmBAITkR9SuGSVuTzdGHtuWn2QWyng5U9seve65ndccqi87S2VFaojgGDPL8e2M64cCQ
	xzwBFzn3giGrbxVGvQVM504AfDamiX5ZbccKeH9cX9FRy5VtAR4oQYRW6ZBOVI9qPp3k45q721e
	NsCvimP6GV1PcKCMRGma7p5dSXqmO+cset3SnfTUOPxBN7KSKegcomatlsat0HwfKMPiPTxIvZJ
	t7YtZUnoGrufMZcXBFd97Y4BR2Jp/NU6/4m5VurLekLNAMhIgLaVmmj/QfEn+mXzXgYuP8hZ1Kt
	DjxO1L48s=
X-Received: by 2002:a05:6a20:9398:b0:3c3:bbe6:95de with SMTP id adf61e73a8af0-3c44afcd580mr443511637.6.1784759928377;
        Wed, 22 Jul 2026 15:38:48 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1cf8fasm13254741eec.31.2026.07.22.15.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 15:38:48 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH nf] netfilter: ipset: fix refcount race between list:set GC and swap
Date: Wed, 22 Jul 2026 22:38:32 +0000
Message-ID: <20260722223832.3524006-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__ip_set_put_byindex() resolved the index to a set pointer under RCU,
then took ip_set_ref_lock in __ip_set_put() to decrement set->ref.
ip_set_swap() holds that same lock while swapping both the ip_set_list
slots and the two sets' ref counters, so it can interleave between the
dereference and the lock acquisition, leaving the caller to decrement a
set whose reference already moved to the other index and hit
BUG_ON(set->ref == 0). list_set_gc() reaches this from timer softirq,
which the nfnl mutex does not serialize against swap: an expiring
list:set member calls list_set_del() -> ip_set_put_byindex() while
IPSET_CMD_SWAP runs on the referenced sets.

Resolve the index and decrement under ip_set_ref_lock, as ip_set_swap()
already does, keeping the refcount tied to the index rather than to a
stale set pointer.

  kernel BUG at net/netfilter/ipset/ip_set_core.c:685!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:ip_set_put_byindex (net/netfilter/ipset/ip_set_core.c:870)
  Call Trace:
   <IRQ>
   list_set_del (net/netfilter/ipset/ip_set_list_set.c:159)
   set_cleanup_entries (net/netfilter/ipset/ip_set_list_set.c:181)
   list_set_gc (net/netfilter/ipset/ip_set_list_set.c:578)
   call_timer_fn (kernel/time/timer.c:1748)
   __run_timers (kernel/time/timer.c:1799 kernel/time/timer.c:2374)
   run_timer_softirq (kernel/time/timer.c:2405)
   </IRQ>
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: 9076aea76538 ("netfilter: ipset: Increase the number of maximal sets automatically")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 net/netfilter/ipset/ip_set_core.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 6cfad152d7d1..16d33c3e28cf 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -679,11 +679,18 @@ __ip_set_get(struct ip_set *set)
 }
 
 static void
-__ip_set_put(struct ip_set *set)
+__ip_set_put_locked(struct ip_set *set)
 {
-	write_lock_bh(&ip_set_ref_lock);
+	lockdep_assert_held(&ip_set_ref_lock);
 	BUG_ON(set->ref == 0);
 	set->ref--;
+}
+
+static void
+__ip_set_put(struct ip_set *set)
+{
+	write_lock_bh(&ip_set_ref_lock);
+	__ip_set_put_locked(set);
 	write_unlock_bh(&ip_set_ref_lock);
 }
 
@@ -854,11 +861,11 @@ __ip_set_put_byindex(struct ip_set_net *inst, ip_set_id_t index)
 {
 	struct ip_set *set;
 
-	rcu_read_lock();
-	set = rcu_dereference(inst->ip_set_list)[index];
+	write_lock_bh(&ip_set_ref_lock);
+	set = ip_set(inst, index);
 	if (set)
-		__ip_set_put(set);
-	rcu_read_unlock();
+		__ip_set_put_locked(set);
+	write_unlock_bh(&ip_set_ref_lock);
 }
 
 void
-- 
2.43.0

