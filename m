Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1940643B6CD
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608176; cv=none; b=WsQzrsyuTc5SFmc9zX1pv4uvZybGpEx7dcw6/8ErqlScsaDtB4WXMCdz0cZyUkpntYRYLw3yOpThmU+NNBvEpItSmmSkIeFNMQlNAhykxgQnPSMrOQ7gRJHlO+bZkF3/Zq4AhR/DgFr6Dkb1hzeIAaWL2MmeCK2ma6qDgL8B4xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608176; c=relaxed/simple;
	bh=ZH1efo12iEeckQi+DGyZvjSa5jSRFV8ZgdAxTcPxYaQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mg7TjYBDHuVZbK0yuuhuixxOJcBQjjrdfHQInffWNWr4FrbDoniMici9991RBf8OzdlajlyJj/Pvah7WviGVQh+STntrRBEMLEqDE5TYA/qM1W8+1cYMz/8mzOIdg0t4zBS7MxldnZhDYhPB5MiYRMcaN2gxRlYUvZsTzT0vvfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vnqoaWlX; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vnqoaWlX"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8487eb67173so2954885b3a.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786608171; x=1787212971; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HL1ovlIdXg+p8vayys6zOx4GhvEm+IraH8in5uR+BmM=;
        b=vnqoaWlXeElBEQkUuESxPT91oXgjLxg4u5gT9ZVJWyoSoH+M9Z7GpkoCr2/aS4j3AT
         vJnwlrD12eDepyP8N2spSF3Qxk+R1R24t7D5JQUdZQq3uPpOyovMCDfffBZHQaiPykTu
         WW6K+ijEF+3oMCSnvE4kad+Z2zC3xfQbbscZpR0tXO4VGK/q4GLNgVBethVqnGh1tXQR
         LGxck7oOUZSwsiDNHsOGu5/lm50fsXd3BM7qw48e1vYqL2UT95VdZQKS2JQfF1v9aiVg
         xrIpe9QTHzvRKILi183YuwL7o7rps0AYG48uKUWyDLv5F+7XMGl9pjKoVlN7ewv2ODAf
         N4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786608171; x=1787212971;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HL1ovlIdXg+p8vayys6zOx4GhvEm+IraH8in5uR+BmM=;
        b=Gb/ra5BmebDH3x8wlVSbs14YgoJ8uTt81KFhbtGuFrHXRUHCnYUNqxuOdFOr6aDNkR
         i3LIZsYeUMGjnfpz+swVgaiVHJV3QciwtQ0tYyE958jRznP5pLe+RQMmACnQI7UH4X3E
         h2MJVa0p+3rW4G19qtwUAr+miChjRIvIDE5SPKupp6B48bJ8zM0KykjeqwdDjuC5NPcq
         PwkRyOnwUsf+arpJ5I2RRPUXQ4Jd6Krb1LCNUIQm+z2YuwIBO2LE2OWUVg/mzvbYrJBT
         hz0d6OWBC6F8K8ABIPsLvfU+k6G4K+cZqZ5cPqPOSs4va20TPkcZNFm7u6mvNebOfGqY
         4tqg==
X-Forwarded-Encrypted: i=1; AHgh+RqgvYqgEZuV1WoJrKdF5hdRchE6NX9C6Z+9hsVTwJe6yVYwjVfvE868YA6EIjHLzod6KZF6aAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT07aYSTxWsVCEg38OYDX4lrn9xsNV6kiOZvY/Hh6pHtnJ+ec0
	OvsN0VstJCG9wC68skWCDcbhlhe+xpg4zWZcQH/mwUswi7y6/idoBjtlnr2aBtEcwsmYwmNIFLy
	FZ1Xjjw==
X-Received: from pfbjf15.prod.google.com ([2002:a05:6a00:6e4f:b0:848:7f21:167c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1da5:b0:842:708f:39be
 with SMTP id d2e1a72fcca58-84fc744db5emr3997298b3a.5.1786608171068; Thu, 13
 Aug 2026 01:02:51 -0700 (PDT)
Date: Thu, 13 Aug 2026 08:02:15 +0000
In-Reply-To: <20260813080248.407680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813080248.407680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813080248.407680-2-kuniyu@google.com>
Subject: [PATCH v4 net-next 01/15] selftest: net: Deflake Periodic GC test in test_neigh.sh.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

test_neigh.sh has a test case to check if GC is running periodically.

It applies a new value to BASE_REACHABLE_TIME, waits for half of
the old value (+2s) to ensure the config is reflected, and waits for
BASE_REACHABLE_TIME to see if the next GC is triggered.

  orig_base_reachable=$(ip -j ntable show name "$tbl_name" | jq '.[] | \
                        select(has("thresh1")) | .["base_reachable"]')
  run_cmd "ip ntable change name $tbl_name thresh1 10 base_reachable 10000"
  run_cmd "sleep $(((orig_base_reachable / 1000) / 2 + 2))"

This is because neigh_periodic_work() schedules the next GC with
(BASE_REACHABLE_TIME / 2) seconds:

  queue_delayed_work(system_power_efficient_wq, &tbl->gc_work,
                     NEIGH_VAR(&tbl->parms, BASE_REACHABLE_TIME) >> 1);

However, the very first run is scheduled with a longer period in
neigh_table_init(), which will be up to 45s:

  neigh_set_reach_time(&tbl->parms);
  queue_delayed_work(system_power_efficient_wq, &tbl->gc_work,
                     tbl->parms.reachable_time);

The initial value is randomly chosen, so if it is larger than 27s
(larger than two "sleep"s), the test fails.

The test fails more frequently when neigh_table is namespacified by
the later patch.

In addition, the long "sleep" makes the test more flaky on kernel with
CONFIG_NO_HZ_IDLE=y, which is enabled by defconfig.

The tbl->gc_work is initialised with INIT_DEFERRABLE_WORK() and queued
to system_power_efficient_wq.

Even when the next GC is supposed to be triggered 5s later, "sleep"
makes the CPU idle, delaying GC execution until often 20s later,
which is too late.

Let's take the initial tbl->parms.reachable_time into account and
poll periodic_gc_runs every 0.1s up to the proper timeout, not to
make CPU idle.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
It seems NIPA has CONFIG_HZ_PERIODIC=y and has no problem.
We may want to add it in net/config.
https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/769301/config
---
 tools/testing/selftests/net/test_neigh.sh | 27 ++++++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/test_neigh.sh b/tools/testing/selftests/net/test_neigh.sh
index 7c594bf6ead0..447423713266 100755
--- a/tools/testing/selftests/net/test_neigh.sh
+++ b/tools/testing/selftests/net/test_neigh.sh
@@ -63,6 +63,15 @@ exit_cleanup_all()
 	exit "${EXIT_STATUS}"
 }
 
+get_periodic_gc_runs()
+{
+	local ns=$1
+	local tbl_name=$2
+
+	ip -n "$ns" -j -s ntable show name "$tbl_name" | \
+		jq '.[] | select(has("periodic_gc_runs")) | .["periodic_gc_runs"]'
+}
+
 ################################################################################
 # Tests
 
@@ -282,24 +291,30 @@ extern_valid_common()
 	local periodic_gc_runs_t0
 	local periodic_gc_runs_t1
 	local orig_base_reachable
+	local base_reachable=10000
 	local orig_gc_stale
+	local timeout
 
 	run_cmd "ip -n $ns1 neigh flush dev veth0"
 	orig_thresh1=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["thresh1"]')
 	orig_base_reachable=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["base_reachable"]')
-	run_cmd "ip ntable change name $tbl_name thresh1 10 base_reachable 10000"
+	run_cmd "ip ntable change name $tbl_name thresh1 10 base_reachable $base_reachable"
 	orig_gc_stale=$(ip -n "$ns1" -j ntable show name "$tbl_name" dev veth0 | jq '.[]["gc_stale"]')
 	run_cmd "ip -n $ns1 ntable change name $tbl_name dev veth0 gc_stale 1000"
 	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
 	run_cmd "ip -n $ns1 neigh add ${subnet}3 lladdr $mac nud stale dev veth0"
-	# Wait orig_base_reachable/2 for the new interval to take effect.
-	run_cmd "sleep $(((orig_base_reachable / 1000) / 2 + 2))"
+	# Wait up to neigh_set_reach_time(BASE_REACHABLE_TIME) (~45s) + 5s
+	# for the new interval to take effect, see neigh_table_init().
+	timeout=$(((orig_base_reachable / 1000) * 3 / 2 + 5))
+	slowwait_for_counter "$timeout" 1 get_periodic_gc_runs "$ns1" "$tbl_name" >/dev/null
 	for i in {1..20}; do
 		run_cmd "ip -n $ns1 neigh add ${subnet}$((i + 4)) nud none dev veth0"
 	done
-	periodic_gc_runs_t0=$(ip -j -s ntable show name "$tbl_name" | jq '.[] | select(has("periodic_gc_runs")) | .["periodic_gc_runs"]')
-	run_cmd "sleep 10"
-	periodic_gc_runs_t1=$(ip -j -s ntable show name "$tbl_name" | jq '.[] | select(has("periodic_gc_runs")) | .["periodic_gc_runs"]')
+	periodic_gc_runs_t0=$(get_periodic_gc_runs "$ns1" "$tbl_name")
+	# Wait up to BASE_REACHABLE_TIME / 2 + 5s, see neigh_periodic_work().
+	timeout=$(((base_reachable / 1000) / 2 + 5))
+	slowwait_for_counter "$timeout" 1 get_periodic_gc_runs "$ns1" "$tbl_name" >/dev/null
+	periodic_gc_runs_t1=$(get_periodic_gc_runs "$ns1" "$tbl_name")
 	[[ $periodic_gc_runs_t1 -ne $periodic_gc_runs_t0 ]]
 	check_err $? "Periodic garbage collection did not run"
 	run_cmd "ip -n $ns1 neigh get $ip_addr dev veth0 | grep \"extern_valid\""
-- 
2.55.0.691.gc56d675ccc-goog

