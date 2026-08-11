Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FCE220698
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415094; cv=none; b=o3s7egu8tPo6WfD3k6OHBYAiV1wm3n+GQM8/EZskaJct1bZQQTR+KYebffcpaWFCd6eahSNk0WWP6y5DCXSC+jYfd4JIY3Ov7ByX8MM0IE34vKrt4idVe0uRIYd97MASvCA1wxigifBHpfK/A0mSvupTHiDoUl1KkweIkGWza7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415094; c=relaxed/simple;
	bh=ZH1efo12iEeckQi+DGyZvjSa5jSRFV8ZgdAxTcPxYaQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F7cJcaAGhGZZPF6vQ6i0DYuqDeUlDg17o6GvcsHoZJBYwn9yZ2NUe/5xMrgcFmrk8iDg48vs3yONg8l4kz3HwjdisKR6OuYsC5+D2BMmjip8DiTMvcIXz6RK3ZG516+94e26GKn2YNh7dyedsVEQsx5qIY0cMNVTfB8RfnnArdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d5PRC+AS; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5PRC+AS"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cea6a46766so48618895ad.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786415092; x=1787019892; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HL1ovlIdXg+p8vayys6zOx4GhvEm+IraH8in5uR+BmM=;
        b=d5PRC+ASykjykxxTBOBfPzCzekdkKgMpbXxNECjwYMHbIRODbhgwc6+Z5QBum8vs41
         0ND8iG+qc/nsx8pME/eHCmVCAf1jqRvwXKihpkQpKRuFdjD/hQ2QRwXgU189eiIw72Mw
         JuTtXs2Arsatp22QSIJc99MYn46JC57szispGtyq/nsLMRpK50LDSXqCF7jk2QxTHIbO
         cLNN3/BLLE0lFiW1alEFDTJYWWwdtPe+6xICgnGnbET3uc3Uh1q8hEFwxZsOWbOmay88
         gVYM8wyIdWZB2DfsbsUJh7UwX7b/zoz9l9TV5yeY2G2GJj16/6/WMJ/t1Ff3PpDKVirn
         aWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786415092; x=1787019892;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HL1ovlIdXg+p8vayys6zOx4GhvEm+IraH8in5uR+BmM=;
        b=MrJfiwVJSeTsn7NNHBBq8uclYcl/l+VNudw0bFps55UpN8r+F31rnHR3XLERINH2qe
         nyDVQFWFbN8qtwZFA1+VavjJBi/nfdPVu83Tbb7hOtFrP+xA2Qk6QrfwhEHSaGQcyX2O
         Xh+oyuuyYaixrEg99fiNLfyxA5DdJk0wkZuLaEATkIMPS8QB+aIs8T1ftS+gfPVKWylL
         8o6DRwb1D+Yr8lhM6ahGy+QI0L3+QEnILnbLvpRd+zFbHI80X61ywA5U36wPI2RZZbWI
         b3U0QfJKv6lbs/4vE1oYWej4E4ektOoonAV5jY8GlDKAj0vqWY5FXborISuZmSGRxC4H
         Ixww==
X-Forwarded-Encrypted: i=1; AHgh+RpvvBf2gKhMLFtLTQ/8zxVrPAm1oXcnZQDNR5xr3L2216Maah5qs7xkyY/ruj77tJhjTHdHc0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAzDW0HliobIQZbyckxI/ntT1TADBCDh/edVwXdIAHZVgDazpD
	rF+w6SyKUvZcEtVbkecp55IL05zkLWoxfcxIdJCH2K+c/GiZR/ppK3CFqjH4pSQ3pv6L65dTN18
	rqBw4FQ==
X-Received: from plhw6.prod.google.com ([2002:a17:903:2f46:b0:2c8:1ded:d061])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ac6:b0:2cc:f5b8:4c2e
 with SMTP id d9443c01a7336-2d31782853dmr1935695ad.9.1786415091954; Mon, 10
 Aug 2026 19:24:51 -0700 (PDT)
Date: Tue, 11 Aug 2026 02:23:35 +0000
In-Reply-To: <20260811022448.116235-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811022448.116235-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260811022448.116235-2-kuniyu@google.com>
Subject: [PATCH v3 net-next 01/15] selftest: net: Deflake Periodic GC test in test_neigh.sh.
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

