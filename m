Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39D3431E6
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491398; cv=none; b=WfnHa5y0P/DDGCiQPFrua2lOHnLViUS8p9rwb6r5IbSvWTnMMym+tg1UE9emCQn4ccX935hAo2Ru8FRTg/9P70HU7t/g4S5Vj2J1xWAdiCv+xJS1DOw7J6gaCum5ekX/eQGKuNUBkuDu6gDUbuY0M8vpFpg4O9RcwemasKzGvVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491398; c=relaxed/simple;
	bh=onGMzDqycDsYbkgJ3q3xnelartFMzpxKYH0fu6V8tx4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o8jU6p6+3vjiEOjTzk00csPWrTiw386VWKpF/fi9prl1u6ZApDzJdZL8BZ+UPbOpgmCggvjpZ19o4qnznK7+6UY2Lt8qkxVjeUO9da/f5EUOwSsFPJc3RDwy6RbdZaRn4i7sXYJJKzcQtVGArPn2ltZIudjydcBgbKrl5NcEcyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z05PDXEg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z05PDXEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB781F00A3D;
	Fri,  4 Sep 2026 03:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788491396;
	bh=Cl+usHMoaV2A12r9LgZqZGhwhfpID2apTmXMYxL9d4s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z05PDXEgyyb4E5qTZ1tnr/7DsQtYUmXOZnFjpbAmmmC79b9r6sZSN9HWzdtmUnhiO
	 b1rGhZNQxsgapoM/2VqGbfu1dy3SOOn+PeX0zhPc4m6DADW7AZPo3x9W6h3O2bHsYT
	 BsF/heHuqQRLuLoF0oXs0bRynAPEVc3u9KTpQP3aaO5QuAVreqXcW6kqD81pbNI1Yh
	 8IzqBKrYDwXot7AOORgvp0kERiRr7aw8yQyAp0K/Hy3NWZ0ioglptASteY8LyCka1A
	 VOxqiX4JEFQgw40vvJiS12RxKyKj5mOv/kgPA1mBdAPa9T0PjwRyYsI5rZ1wWYGC41
	 4ajKdS1xv3tnQ==
Subject: Re: [PATCH v6 net-next 01/15] selftest: net: Deflake Periodic GC test
 in test_neigh.sh.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 razor@blackwall.org
Date: Fri, 04 Sep 2026 03:09:55 +0000
Message-ID: <178849139572.4131868.6040641098132451650@kernel.org>
In-Reply-To: <20260902203722.926528-2-kuniyu@google.com>
References: <20260902203722.926528-2-kuniyu@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 4

- [Medium] The new completion barrier is the wrong signal:
  neigh_periodic_work() bumps NEIGH_CACHE_STAT_INC(tbl,…
- [Low] Undisclosed netns switch of the periodic_gc_runs read: the new
  get_periodic_gc_runs() helper queries the counter inside $ns1 (`ip -n…
- [Low] The patch fixes a currently reproducible selftest flake
  (extern_valid_common()'s periodic-GC wait in…
- [Low] Comment/code drift: the section header comment in
  extern_valid_common() still describes the removed sleep-based…
- [Low] The first `slowwait_for_counter` call (line 309) is the setup
  barrier that guarantees neigh_periodic_work() completed once and re-…

--

selftest: net: Deflake Periodic GC test in test_neigh.sh.

This replaces the two fixed sleeps in the periodic garbage collection test
case of test_neigh.sh with slowwait_for_counter() polling of the
periodic_gc_runs table statistic. A new helper, get_periodic_gc_runs(),
reads the counter, and the timeouts now account for the randomized initial
tbl->parms.reachable_time set up by neigh_table_init().

No Link: tags are present in the commit header.

[Severity: Low]
Would a Fixes: tag be appropriate here?  The commit message describes a
failure that is reproducible on current kernels ("The initial value is
randomly chosen, so if it is larger than 27s (larger than two "sleep"s),
the test fails"), and git blame points at the two commits that added the
sleeps being removed:

  171f2ee31a42f ("selftests: net: add test_neigh.sh") added the
  "sleep 10" wait

  f8fded7536a93 added the
  "sleep $(((orig_base_reachable / 1000) / 2 + 2))" wait

Without a tag the deflake will not be routed to trees that still run the
flaky version of the test.

> diff --git a/tools/testing/selftests/net/test_neigh.sh b/tools/testing/selftests/net/test_neigh.sh
> index 7c594bf6ead0..447423713266 100755
> --- a/tools/testing/selftests/net/test_neigh.sh
> +++ b/tools/testing/selftests/net/test_neigh.sh
> @@ -63,6 +63,15 @@ exit_cleanup_all()
>  	exit "${EXIT_STATUS}"
>  }
>  
> +get_periodic_gc_runs()
> +{
> +	local ns=$1
> +	local tbl_name=$2
> +
> +	ip -n "$ns" -j -s ntable show name "$tbl_name" | \
> +		jq '.[] | select(has("periodic_gc_runs")) | .["periodic_gc_runs"]'
> +}
> +

[Severity: Low]
The old code read periodic_gc_runs in the initial namespace:

  periodic_gc_runs_t0=$(ip -j -s ntable show name "$tbl_name" | jq ...)

while get_periodic_gc_runs() is called with "$ns1", so the counter is now
read inside ns1.  Was the namespace change intentional?  It is not
mentioned in the commit message.

At this commit it makes no difference, since neightbl_dump_info() in
net/core/neighbour.c emits neightbl_fill_info() (including NDTA_STATS) for
every registered table regardless of the requesting netns, and only the
per-device parms rows are filtered by net_eq().

Inside this series it does matter for a while, though.  After "neighbour:
Namespacify neigh_tables." the counter read in ns1 belongs to ns1's table
(default base_reachable 30000, so a 15s GC interval), while
base_reachable=10000 is still written to init_net's table below, so the
second wait's 10s budget is shorter than the interval ns1 actually uses.
The mismatch only disappears with the later "selftest: net: Specify netns
for ip ntable in test_neigh.sh." patch, which moves the ntable reads and
writes into ns1.  Would it be simpler to switch the ntable read/write and
the counter read in the same patch?

>  ################################################################################
>  # Tests
>  
> @@ -282,24 +291,30 @@ extern_valid_common()
>  	local periodic_gc_runs_t0
>  	local periodic_gc_runs_t1
>  	local orig_base_reachable
> +	local base_reachable=10000
>  	local orig_gc_stale
> +	local timeout
>  
>  	run_cmd "ip -n $ns1 neigh flush dev veth0"
>  	orig_thresh1=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["thresh1"]')
>  	orig_base_reachable=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["base_reachable"]')
> -	run_cmd "ip ntable change name $tbl_name thresh1 10 base_reachable 10000"
> +	run_cmd "ip ntable change name $tbl_name thresh1 10 base_reachable $base_reachable"
>  	orig_gc_stale=$(ip -n "$ns1" -j ntable show name "$tbl_name" dev veth0 | jq '.[]["gc_stale"]')
>  	run_cmd "ip -n $ns1 ntable change name $tbl_name dev veth0 gc_stale 1000"
>  	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
>  	run_cmd "ip -n $ns1 neigh add ${subnet}3 lladdr $mac nud stale dev veth0"
> -	# Wait orig_base_reachable/2 for the new interval to take effect.
> -	run_cmd "sleep $(((orig_base_reachable / 1000) / 2 + 2))"
> +	# Wait up to neigh_set_reach_time(BASE_REACHABLE_TIME) (~45s) + 5s
> +	# for the new interval to take effect, see neigh_table_init().
> +	timeout=$(((orig_base_reachable / 1000) * 3 / 2 + 5))
> +	slowwait_for_counter "$timeout" 1 get_periodic_gc_runs "$ns1" "$tbl_name" >/dev/null

[Severity: Low]
Should the exit status of this first wait be checked?  Only stdout is
redirected, the status is never fed to check_err, and the test body runs
with set +e (set -e is enabled and cleared inside setup()).

slowwait_for_counter() in tools/testing/selftests/net/lib.sh does return
non-zero on timeout:

  slowwait_for_counter()
  {
  	local timeout=$1; shift
  	local delta=$1; shift

  	local base=$("$@")
  	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
  }

If this wait times out (up to ~50s with the default base_reachable=30000),
the script still adds the 20 entries, samples t0 and then waits only
base_reachable/1000/2 + 5 = 10s, a bound that assumes the new 5s interval
is already armed by the requeue at the end of neigh_periodic_work():

  queue_delayed_work(system_power_efficient_wq, &tbl->gc_work,
                     NEIGH_VAR(&tbl->parms, BASE_REACHABLE_TIME) >> 1);

The resulting failure is then reported as "Periodic garbage collection did
not run" with no hint that the setup wait was the thing that timed out.

There is also the inverse case: this wait can be satisfied by the initial
run armed in neigh_table_init() with the randomized reachable_time, so the
"new interval took effect" precondition is not really established.

>  	for i in {1..20}; do
>  		run_cmd "ip -n $ns1 neigh add ${subnet}$((i + 4)) nud none dev veth0"
>  	done
> -	periodic_gc_runs_t0=$(ip -j -s ntable show name "$tbl_name" | jq '.[] | select(has("periodic_gc_runs")) | .["periodic_gc_runs"]')
> -	run_cmd "sleep 10"
> -	periodic_gc_runs_t1=$(ip -j -s ntable show name "$tbl_name" | jq '.[] | select(has("periodic_gc_runs")) | .["periodic_gc_runs"]')
> +	periodic_gc_runs_t0=$(get_periodic_gc_runs "$ns1" "$tbl_name")
> +	# Wait up to BASE_REACHABLE_TIME / 2 + 5s, see neigh_periodic_work().
> +	timeout=$(((base_reachable / 1000) / 2 + 5))
> +	slowwait_for_counter "$timeout" 1 get_periodic_gc_runs "$ns1" "$tbl_name" >/dev/null
> +	periodic_gc_runs_t1=$(get_periodic_gc_runs "$ns1" "$tbl_name")

[Severity: Medium]
Is the periodic_gc_runs increment a strong enough barrier for the checks
that follow?  neigh_periodic_work() bumps the counter as its first
statement, before the table lock is taken and before anything is reaped:

  net/core/neighbour.c:neigh_periodic_work() {
  	NEIGH_CACHE_STAT_INC(tbl, periodic_gc_runs);

  	spin_lock_bh(&tbl->lock);
  	...
  }

and the bucket walk drops the lock and reschedules after every bucket:

  		spin_unlock_bh(&tbl->lock);
  		cond_resched();
  		spin_lock_bh(&tbl->lock);

slowwait_for_counter() returns as soon as the counter reaches base + 1, so
the pass may still be in flight when the script proceeds to:

  run_cmd "ip -n $ns1 neigh get ${subnet}3 dev veth0"
  check_fail $? "Entry without \"extern_valid\" flag survived periodic garbage collection"

Can this fail spuriously if the worker is preempted mid-scan, for instance
on a single-vCPU or debug kernel, given that only a couple of ip/jq
invocations separate the wait from the check?  The removed "sleep 10"
implicitly covered the whole pass.

The positive check just above it looks weakened in the same way: the
extern_valid entry can be reported as surviving simply because GC has not
walked its bucket yet.

Would polling the observable effect (the ${subnet}3 entry being gone), or
waiting for the counter to advance by 2, be more robust?

Related to the second timeout: base_reachable/1000/2 + 5 is measured from
the moment the increment is observed, but the next run is only armed at the
end of the pass, which eats into the 5s of slack.

[Severity: Low]
Does the block comment above this test case still describe what the code
does?  It reads:

  # Check that an "extern_valid" entry survives a periodic garbage
  # collection. Add an "extern_valid" entry, add more than "thresh1"
  # regular entries, wait "base_reachable" (longer than "gc_stale")
  # seconds and check that the "extern_valid" entry was not deleted.

The code no longer waits base_reachable seconds; it polls periodic_gc_runs
and returns on the first additional GC run, bounded by
base_reachable/1000/2 + 5.  The comment also survives unchanged to the end
of the series.  Could it be updated along with the wait, including the
"longer than gc_stale" rationale?

>  	[[ $periodic_gc_runs_t1 -ne $periodic_gc_runs_t0 ]]
>  	check_err $? "Periodic garbage collection did not run"
>  	run_cmd "ip -n $ns1 neigh get $ip_addr dev veth0 | grep \"extern_valid\""

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902203722.926528-1-kuniyu%40google.com
