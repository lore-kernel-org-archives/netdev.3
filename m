Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F1149C4DA
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287613; cv=none; b=XfmUJED8LgRcjOeJpMNVryDpcqapsSyNi/U0dmdupR34/AZM+Nw8S8zhfD03xrZ7RXdZYjjwPlnP+/i3rfpb9/q7tr+LSR/YO10/t4EPiqyUHjK6PyCdJdVK16yNQ6Cr2vnHJkvMvWtozoZxtHryQHcYIzoYq2Agll4nzAMaYgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287613; c=relaxed/simple;
	bh=+lDkiYnV4H0WMbnMKb89eGybFp3x2YxRyFXjoGHZul0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U2yUVtnSkBUttqP059aqjTJMaGmdbUmiBP68hxPhjO6Inq2L2PTBkaE5L6WdismJx8SQjN9d1tMsRadCBbUz2p4igLkLOm44UPYXmDPhhXjkZWDJTprOm7awY6d2m55jicPYSmddUm2lopLoW2PYgUCoVvjFinwCCVvZCaJuNsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CRL+4p65; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRL+4p65"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso1383985ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287611; x=1788892411; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x7zPn5TyHklReje8imk3KX20I+BfvPlhwFh0vlkD+AM=;
        b=CRL+4p65YZTXPn3wFUtBcrIDXKLZJAE4YpFieSyar7X7qv12fruA4340oJcWBphRCA
         kp4wlGnaJhz+T/1n3D53GYxws4RO6E5gNsDp6BjkH/gz3jPuW1x6ttCtnULMJTDHUkve
         7mHPU+/XrOwIfxv031RNhlSAyoKD+3VhfAVJ9enkPQT6cCVlr3rTJNsi5ML8oNp+WLqU
         7vmb5hSy44C8/xDCl6+s41idaPVjitB6T9nAhvToVLAGcq1EJ6wW+fYaXveTQF8cTZQB
         K6eSnFMUlvzTV5RDvVu4tQPKG93KMTqhS69zwnAF4v45Dc2jV/LPyeosJECBTOJiGD+0
         GrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287611; x=1788892411;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7zPn5TyHklReje8imk3KX20I+BfvPlhwFh0vlkD+AM=;
        b=DYKzcKX5Hvfuip/Jfgmr1WT/JiV+h+4kntFDC+KrmiO1KTvI7U/MfsrIWuCSPC+1tw
         nnhBSriZeW2HiX6E88y6kA9yqgcoE7ZZaT4xqr0/Fpj4HjFASX0dSDiMOBPDc782GK9h
         YKk2C02TtWi6qQl0GOttpxhruToIGxJZlrDIC+5b0VZZFG2QykrNZYdhGNXTFxe9G9bR
         AXuKWmUUdlFVllNaZEeby2WXfZadyjpoCeRMFkHDJyp6Nx+ueK36aCnJXXpG63O+mhwF
         Jrz8QsoPMHkfb//LSGO0R8pO32NsMPH0ChiOzjWDqxKMaaAavrSLyp4XrJSYv5OIgnfN
         7csw==
X-Forwarded-Encrypted: i=1; AKwUvBxKvjODxXvkgKzaxXmMd5Kw/mD0NcrXhU5Lv2hdn+iD0gNGaWw2VpGELMP/yyujTjY/J1cu/lk=@vger.kernel.org
X-Gm-Message-State: AFuF++n0oqin3i+CUw8F/8c4RtdjydqzBHPw1N3ESyaPQEJ/hPcnHALJ
	bk76EKRocVRXhJ9xFjsLChahWSoJUqOzPY1AHSyyvTtnnkFpx5CCORJwdMhkJxNDwOKRVygcb6/
	xjRJB4Q==
X-Received: from plih6.prod.google.com ([2002:a17:903:37c6:b0:2ce:d2e2:393])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f0f:b0:2d8:d4cc:be65
 with SMTP id d9443c01a7336-2d94a905007mr147424765ad.18.1788287610646; Tue, 01
 Sep 2026 11:33:30 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:32:50 +0000
In-Reply-To: <20260901183327.3332855-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901183327.3332855-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901183327.3332855-2-kuniyu@google.com>
Subject: [PATCH v5 net-next 01/15] selftest: net: Deflake Periodic GC test in test_neigh.sh.
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
2.55.0.966.g6673acef38-goog

