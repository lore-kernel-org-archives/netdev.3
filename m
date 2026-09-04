Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF603AA51E
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 03:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491407; cv=none; b=ic4d+pszmaCUTfpzevsvRmaQ2CdJ9jQTZgx6+FnVmVkWEWLoWXhw1sq8t5/KnJHi+9EY1w8ZiqorMp5gAzdccVzwUs/3AcrB5yrgmaOoXq2S1cCTSzf4hADe1PS9S1K8PXDGNa1V8jU49cjB9bNuNzArxoav1WyHk+Xh6yCDqLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491407; c=relaxed/simple;
	bh=Q5inLhkQy3voOXFCYbDA/fV6sDU9WforXsJXYHOTmRA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QkA1IcMT/il1uyiYZBFfz2xPpJf8asmzdIU+0y+LoPAysRtKpHToc00okuVZJDQyTLaw/C28AKXQBtUmFc2ic0j/JFjYOaE/T0FjTNOaDh/DG0gUioJglwX61RINIWzlt8uJTOXR+kEnUPYpj3GQwclcOXESWOItFpGmooe7kXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZe0f+t4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZe0f+t4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CDE1F00A3D;
	Fri,  4 Sep 2026 03:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788491405;
	bh=WWOA0CbdWfosLzn/ZAywBQSPXd/IjBcilFCTdZoyHiQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NZe0f+t4mGXWfyYPZW4AgwKxdWTE4c3KxljaqArq8sF6Ovmb6swSxzYwmB2IXDw8g
	 c18dpJOy6Q9XjtHuAXviLQ0nXxK5dDw87ZxEWaWMl3tEZ46zGP7aDPIPh25QHqVXtO
	 ev15/kLSp6mI8VA6Om76401vti3HOKSHC2OwOX7ruGTdKruZibvxJUOpsysr0/pzEA
	 nyaH6YV4AwZ/I3uN4La2FV7usnA8el93YEscGDZtmysW9WirxXfaLvNXpYGLWDQbZk
	 lroyAUbZ5Pqc4IKuC0g8i6Qvme1kf12Ar49kSqpCZU67pS+/7ji+X7whbm6HkTgGGm
	 vkR8Gs4PWn+6Q==
Subject: Re: [PATCH v6 net-next 15/15] selftest: net: Specify netns for ip
 ntable in test_neigh.sh.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 razor@blackwall.org
Date: Fri, 04 Sep 2026 03:10:04 +0000
Message-ID: <178849140464.4131868.14135881617308602846@kernel.org>
In-Reply-To: <20260902203722.926528-16-kuniyu@google.com>
References: <20260902203722.926528-16-kuniyu@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The series namespacifies the neighbour tables (commit
  "neighbour: Namespacify neigh_tables."), and this patch is the…

--

selftest: net: Specify netns for ip ntable in test_neigh.sh.

Now that the neighbour tables are per netns, this patch converts the
"ip ntable" invocations in test_neigh.sh to "ip -n $ns1 ntable" so the
thresholds and base_reachable_time are set in the namespace the test
actually uses, and drops the comments that described those knobs as
global resources.

> diff --git a/tools/testing/selftests/net/test_neigh.sh b/tools/testing/selftests/net/test_neigh.sh
> index 447423713266..e70e31edf633 100755
> --- a/tools/testing/selftests/net/test_neigh.sh
> +++ b/tools/testing/selftests/net/test_neigh.sh
> @@ -240,9 +240,6 @@ extern_valid_common()
>  	# Check that an "extern_valid" entry survives a forced garbage
>  	# collection. Add an entry, wait 5 seconds and add more entries than
>  	# "thresh3" so that forced garbage collection will run.
> -	#
> -	# Note that the garbage collection thresholds are global resources and
> -	# that changes in the initial namespace affect all the namespaces.
>  	local forced_gc_runs_t0
>  	local forced_gc_runs_t1
>  	local orig_thresh1
> @@ -250,18 +247,23 @@ extern_valid_common()
>  	local orig_thresh3
>  
>  	run_cmd "ip -n $ns1 neigh flush dev veth0"
> -	orig_thresh1=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["thresh1"]')
> -	orig_thresh2=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh2")) | .["thresh2"]')
> -	orig_thresh3=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh3")) | .["thresh3"]')
> -	run_cmd "ip ntable change name $tbl_name thresh3 10 thresh2 9 thresh1 8"
> +	orig_thresh1=$(ip -n "$ns1" -j ntable show name "$tbl_name" | \
> +			jq '.[] | select(has("thresh1")) | .["thresh1"]')
> +	orig_thresh2=$(ip -n "$ns1" -j ntable show name "$tbl_name" | \
> +			jq '.[] | select(has("thresh2")) | .["thresh2"]')
> +	orig_thresh3=$(ip -n "$ns1" -j ntable show name "$tbl_name" | \
> +			jq '.[] | select(has("thresh3")) | .["thresh3"]')
> +	run_cmd "ip -n $ns1 ntable change name $tbl_name thresh3 10 thresh2 9 thresh1 8"

[Severity: Medium]
This hunk moves test_neigh.sh over to the per-netns form, but should
tools/testing/selftests/net/netfilter/nft_nat_zones.sh get the same
treatment in this series?  That script tunes the same knobs from the root
netns:

tools/testing/selftests/net/netfilter/nft_nat_zones.sh {
	...
	setup_ns gw srv
	...
	sysctl -q net.ipv6.neigh.default.gc_thresh1=512  2>/dev/null
	sysctl -q net.ipv6.neigh.default.gc_thresh2=1024 2>/dev/null
	sysctl -q net.ipv6.neigh.default.gc_thresh3=4096 2>/dev/null
	sysctl -q net.ipv4.neigh.default.gc_thresh1=512  2>/dev/null
	sysctl -q net.ipv4.neigh.default.gc_thresh2=1024 2>/dev/null
	sysctl -q net.ipv4.neigh.default.gc_thresh3=4096 2>/dev/null
	...
}

With the namespacified tables, neigh_sysctl_register() points those ctl
entries at the per-netns table and registers them in that netns:

net/core/neighbour.c:neigh_sysctl_register() {
	...
		t->neigh_vars[NEIGH_VAR_GC_THRESH1].data = &tbl->gc_thresh1;
		t->neigh_vars[NEIGH_VAR_GC_THRESH2].data = &tbl->gc_thresh2;
		t->neigh_vars[NEIGH_VAR_GC_THRESH3].data = &tbl->gc_thresh3;
	...
}

and the only inheritance from init_net is a one-time snapshot taken when
the namespace's table is registered:

net/core/neighbour.c:neigh_table_inherit() {
	...
	tbl->gc_thresh1 = READ_ONCE(init_tbl->gc_thresh1);
	tbl->gc_thresh2 = READ_ONCE(init_tbl->gc_thresh2);
	tbl->gc_thresh3 = READ_ONCE(init_tbl->gc_thresh3);
	...
}

Since nft_nat_zones.sh runs "setup_ns gw srv" before writing the raised
values, do the gw and srv namespaces still end up with the compiled-in
defaults instead of 512/1024/4096?  If so, the raised thresholds are a
no-op for the gw namespace that actually holds the per-veth neighbour
entries, and the gate in neigh_periodic_work():

net/core/neighbour.c:neigh_periodic_work() {
	...
	if (neigh_table_entries(tbl) < READ_ONCE(tbl->gc_thresh1))
		goto out;
	...
}

applies with the unraised limit, which can make the nft counter checks
come up short once the entry count grows (the script's own comment
suggests raising maxclients to 2000).

The cleanup() function in the same script restores only the root-netns
values, which would likewise no longer affect the namespaces that ran the
test.

Would moving the sysctl writes above "setup_ns gw srv", or issuing them
with "ip netns exec \"$gw\" sysctl ...", be the intended conversion here?

[ ... ]

> @@ -284,10 +287,6 @@ extern_valid_common()
>  	# collection. Add an "extern_valid" entry, add more than "thresh1"
>  	# regular entries, wait "base_reachable" (longer than "gc_stale")
>  	# seconds and check that the "extern_valid" entry was not deleted.
> -	#
> -	# Note that the garbage collection thresholds and "base_reachable" are
> -	# global resources and that changes in the initial namespace affect all
> -	# the namespaces.
>  	local periodic_gc_runs_t0
>  	local periodic_gc_runs_t1
>  	local orig_base_reachable

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902203722.926528-1-kuniyu%40google.com
