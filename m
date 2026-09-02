Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C27395240
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788381465; cv=none; b=NH7nCUD5l5vL+xKE+zDymSVwrsM0lFWEvy68J9nMyUqFNggoBDyqTn5rvCCM8KluO1SMULApxMmcbUkqoN57MqcaI/AD0+J8TGpiQWRqywIWsDBhw6hv3IWqGbGJVKT7k1f87J/e0ZnYdyXY+1NV4hgPHM6z5O3RRpO91GS6mow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788381465; c=relaxed/simple;
	bh=m3RyCgbTYhcd2jtl8f8bV736rYnT8jb1GY/o4DvwK1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e51OisUNKV0PDpLyxfXmN4JBnL9vNwzVva+PXzfyH+Uyd2YtHgZFzxbfmL5bogLhPR081xAo67RASHg+1ZbFQm8MD/eahGMu7bHEyHOpyW87V+Xwiprexvnf9Oj26g/J3+p/LJGj+UI3kFf/ig8C4XX+Scqx4clIc9z1UpblRkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JWj6Rf2M; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JWj6Rf2M"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-854f274dd69so1779158b3a.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788381463; x=1788986263; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ns7gyWKirNLIEdATdumIRkFOdzljlcRnsIk2HEd0ZmQ=;
        b=JWj6Rf2MOcjrJ2IRDL8YQwa+DSObL3TiGtQRDymVbXEu4suAVJHDISKr+MSnShHoQW
         /sY31B8UWEIZnm3hcM9YZxQyONzaaCn/zldfIpYBskwMh2VxcoRHKK/9ptb/gCDCs100
         gE14l533Iz/Kp7BHFTKmfTCrRllQCNLybfmH7RJatLFQe/0oWhhBtpbilxdvQLEhCwYG
         Ux69PO7eTLRaSBrTqbWXVuhf7mG32LNQ6BlGisU0E4BVvQCctDWLtY1dRcxNwpZN1QCD
         /cMQwjoAEjAEQmzDlN5g5+RId7u3uS2wmpssBa1YdUB6xpoixX3mMJeaoiBq0cuS7LLn
         5MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788381463; x=1788986263;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ns7gyWKirNLIEdATdumIRkFOdzljlcRnsIk2HEd0ZmQ=;
        b=pCcVtc0PDkZ6BpOTM4AF5HkOqobByQnR+BeWrmxW8f8nKkAGhko4iXFpfKx33FSX9v
         GOjJ34Np60tAZBpzmrGQc/yj9F3ZzND7PBudEJuVcj1439N+bKptFI0E5e0jhQl0PprM
         O2eA5dpaajJzCXIh5cz6LIzVKAeQKZ3B+ItuTcxg5XWOqTKAZLeac4sqsgiYOa2FCs1Z
         89UglAp0MgwYM7Pan4pXFgNg8JLDgOgtdp+28OKbpe+KJWukb5EhF8Y107W4zsqGkR5a
         L5vrYUQ5pgCr8In7Oi+0EBCmuUE9odDBs1x7lO83caUe9YxaCCaH/mZHXyKXwZNrhwAD
         He1Q==
X-Forwarded-Encrypted: i=1; AKwUvBx8kwY/BwTzDHuNRuA3y/6FGrJfRwrsfcgrruqCpzU2R2JWEglW9F31IK0bZmyGqLS6HEPScV8=@vger.kernel.org
X-Gm-Message-State: AFuF++ngw+C1cFhx+cwMNRVTYv7mjXPpmGDILvUOORgQcXq/viloOmdx
	jlNezjcXNwzhZnJ/2coxYY0gKG94wfVO5TbKS0oAFGRcRfTo47jGvlfe4A0OrfLyAh1g7t6iDbO
	+UEcL/Q==
X-Received: from pfx27.prod.google.com ([2002:a05:6a00:a45b:b0:853:7629:c005])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3405:b0:847:99bb:b6d0
 with SMTP id d2e1a72fcca58-85ed3793051mr10934276b3a.15.1788381462675; Wed, 02
 Sep 2026 13:37:42 -0700 (PDT)
Date: Wed,  2 Sep 2026 20:36:42 +0000
In-Reply-To: <20260902203722.926528-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902203722.926528-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902203722.926528-2-kuniyu@google.com>
Subject: [PATCH v6 net-next 01/15] selftest: net: Deflake Periodic GC test in test_neigh.sh.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>
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
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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
2.55.0.970.g62bdec98f9-goog

