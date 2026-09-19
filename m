Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8272E1F0E;
	Sat, 19 Sep 2026 00:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777298; cv=none; b=QB1iCt5V/AkXO9ZJl0V6k4N+fvphiQ70qqXQongvrtBN8WzUs0ZmEbegm2iKSiMe0WYMtxE5zJwT8IJL4pFvmVJC7WuAOMNsRX1RiL7teHIcGexlMPSvOZIlc3t/3PT+rWNmGK7Zn8G1F9kToIcWj5HWpHDiWWMxtuB0vIelFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777298; c=relaxed/simple;
	bh=r1H383cqo22+mz3TPx9ADQc/uB3M7tYmjBX0PgRUDLI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=azNdhy0A8H5yFH7suGWC1lsHCNXBKfdjyQnbtxvPFK5gcre2QafPiJCLuLPombEr/dPK41Bid5hQxxuhuUI8D6fo/y1Iq0qFGxsQ4a/Q5mKZ9hYXUnyzW5GRfJQGVDvcmyZ5XfO7eYVUOrdHNHs0eZ9i5yEsFI37h16wcy2z8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpV074UX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpV074UX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5B81F00898;
	Sat, 19 Sep 2026 00:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777296;
	bh=L3JCCS0ixxje0WqOyXpzAhd+hYsIi/NZ5DPntPFt3AU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JpV074UXjK7MLylW4z0AjlKcpVbiVYfPVmjVUMDmvc5fvOcMCRIVgjyrvJlEAX24S
	 Yk9bil3sKScJPoJPAd7IzMGLW73abO1EMzwE86xvdPx73Uq2+q+BnKzv3HlHZd4+9Z
	 FNOlMX2ux/7LLHcWbnXpi/ZOq4pn5a2CPCplH4I6U1rEGS503iEDX2Wiz+cyJ6FFWs
	 nIi2DZ+zAN1n3bxtnWzviWHeG1TbPDcoHaESkzC4S9wQdkyuDGuwcSaFSpufIh/mXt
	 xCaGmdTQY02Ft+VjqoCNkPC4/5nfHMdriRxJuMLndbA9jioOup139HB/9IT34arTxD
	 8cicC5ikpPxXw==
Subject: Re: [PATCH net-next v2 5/5] selftests: net: test the vxlan vnifilter
 VNI limit
From: netdev-bot+sashiko@kernel.org
To: alishmery18@gmail.com
Cc: netdev@vger.kernel.org, idosch@nvidia.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, razor@blackwall.org,
 roopa@nvidia.com, linux-kernel@vger.kernel.org
Date: Sat, 19 Sep 2026 00:21:35 +0000
Message-ID: <178977729516.22033.14954545787392978256@kernel.org>
In-Reply-To: <20260916193449.2552039-6-alishmery18@gmail.com>
References: <20260916193449.2552039-6-alishmery18@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 1 (1)

- [High] The two sides of the vnifilter netlink object model now
  disagree: `vxlan_vnifilter_dump_dev()`…
- [Medium] The new "24-bit boundary" cases exercise
  VXLAN_VNIFILTER_ENTRY_START only.
- [Low] The oversized-add assertion at
  tools/testing/selftests/net/test_vxlan_vnifiltering.sh:382-383 only…

Pre-existing issues:
- [Low] vxlan_vnifilter_api() creates veth-host and $testns via
  setup_vnifilter_api() (test_vxlan_vnifiltering.sh:299-304) but never…

--

selftests: net: test the vxlan vnifilter VNI limit

This extends vxlan_vnifilter_api() in test_vxlan_vnifiltering.sh with cases
for the largest accepted VNI range, one VNI past it (for add and delete),
and the 24-bit VNI boundary.  All new cases go through bridge(8) and check
only the command exit status.

v1: https://lore.kernel.org/netdev/20260909092645.3105263-1-alishmery18@gmail.com/

> diff --git a/tools/testing/selftests/net/test_vxlan_vnifiltering.sh b/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
> index 8deacc565afa1..7cd4acc76ed6c 100755
> --- a/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
> +++ b/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
> @@ -371,6 +371,40 @@ vxlan_vnifilter_api()
>  	# change vxlan vnifilter flag
>  	run_cmd "ip -netns $testns link set dev vxlan-ext1 type vxlan external novnifilter"
>  	log_test $? 2 "Cannot unset vnifilter flag on a device"
> +
> +	# a single request may touch at most 4096 vnis in total. bridge(8)
> +	# sends one range per message, so these cover the one-entry case; the
> +	# total across several entries of one message is not reachable from
> +	# iproute2.
> +	run_cmd "bridge -netns $testns vni add dev vxlan-ext1 vni 10000-14095"
> +	log_test $? 0 "Add vni range of maximum size"

[Severity: High]
Does this pair of commands leave the device in a state the kernel can dump
but no longer accept back?

vxlan_vnifilter_dump_dev() in drivers/net/vxlan/vxlan_vnifilter.c coalesces
any contiguous run of VNIs sharing a remote into one
VXLAN_VNIFILTER_ENTRY, with no upper bound on the span:

	if (!dump_stats && vnirange(vend, v) == 1 &&
	    vxlan_addr_equal(&v->remote_ip, &vend->remote_ip)) {
		goto update_end;

while vxlan_vnifilter_check_msg() rejects an RTM_NEWTUNNEL whose entries sum
to more than VXLAN_VNI_FILTER_MSG_MAX:

	if (vnis > VXLAN_VNI_FILTER_MSG_MAX) {
		NL_SET_ERR_MSG_ATTR_FMT(extack, attr,
					"Request asks for more than %u VNIs",
					VXLAN_VNI_FILTER_MSG_MAX);
		return -EINVAL;

This test installs 10000-14095 and then 14096 (both with the default
all-zero remote), which is exactly a 4097-VNI contiguous run.  On
RTM_GETTUNNEL the dump then emits a single entry START=10000 END=14096, and
replaying that one entry in a single RTM_NEWTUNNEL now fails with -EINVAL.
Would a save/restore or dump/replay consumer of bridge vni show break on
that?

Separately, is the limit itself an rtnetlink narrowing?  A single request
such as bridge vni add dev X vni 1-10000 was accepted before and now
returns -EINVAL.

> +
> +	run_cmd "bridge -netns $testns vni add dev vxlan-ext1 vni 10000-14096"
> +	log_test $? 255 "Cannot add vni range larger than maximum"
> +
> +	# install the one vni past that range as well, so that the oversized
> +	# delete below can only fail on the limit and not on a missing vni
> +	run_cmd "bridge -netns $testns vni add dev vxlan-ext1 vni 14096"
> +	log_test $? 0 "Add the vni past the maximum range"

[Severity: Low]
Can this follow-up command distinguish "the rejected message installed
nothing" from "the rejected message installed part of the range"?

vxlan_vni_add() in drivers/net/vxlan/vxlan_vnifilter.c short-circuits an
already present VNI into the update path:

	if (vxlan_vnifilter_lookup(vxlan, v))
		return vxlan_vni_update(vxlan, vg, v, group, &changed, extack);

so vni add 14096 returns 0 whether or not 14096 was already created by the
rejected 10000-14096 request, and the later vni del 10000-14095 returns 0
either way.

The comment above vxlan_vnifilter_check_msg() states the message is
rejected "before any of its entries is acted on", which is the property this
block does not observe.  Would checking that 14096 is absent first (a bridge
vni show grep, or requiring vni del 14096 to fail) before installing it make
the sequence detect a limit that moved into the per-entry dispatch loop?

> +
> +	run_cmd "bridge -netns $testns vni del dev vxlan-ext1 vni 10000-14096"
> +	log_test $? 255 "Cannot delete vni range larger than maximum"
> +
> +	run_cmd "bridge -netns $testns vni del dev vxlan-ext1 vni 10000-14095"
> +	log_test $? 0 "Delete vni range of maximum size"
> +
> +	run_cmd "bridge -netns $testns vni del dev vxlan-ext1 vni 14096"
> +	log_test $? 0 "Delete the vni past the maximum range"

[Severity: Low]
This isn't a bug introduced by this patch, but vxlan_vnifilter_api() has no
teardown on exit, and the new block adds up to 4097 entries that depend on
these del commands succeeding.

setup_vnifilter_api() creates veth-host and $testns, while the generic
cleanup() installed by trap cleanup EXIT removes only veth-hv-1, the
vethhv-* pair and the hv_*/vm_* namespaces:

cleanup() {
	ip link del veth-hv-1 2>/dev/null || true
	ip link del vethhv-11 vethhv-12 vethhv-21 vethhv-22 2>/dev/null || true

	cleanup_ns $hv_1 $hv_2 $vm_11 $vm_21 $vm_12 $vm_22 $vm_31 $vm_32
}

cleanup_vnifilter_api() does remove them, but it is only called at the start
of vxlan_vnifilter_api(), so it cleans up the previous run.  If one of the
new commands returns an unexpected status on a kernel without the limit (the
oversized add succeeding, or the final vni add 16777216 succeeding), the
entries survive together with $testns and the veth pair.  Could
cleanup_vnifilter_api() be called at the end of the test, or registered in
the trap?

> +
> +	# the vxlan header carries 24 bits, so a vni above that is rejected
> +	run_cmd "bridge -netns $testns vni add dev vxlan-ext1 vni 16777215"
> +	log_test $? 0 "Add the highest vni the vxlan header can carry"
> +
> +	run_cmd "bridge -netns $testns vni del dev vxlan-ext1 vni 16777215"
> +	log_test $? 0 "Delete the highest vni the vxlan header can carry"
> +
> +	run_cmd "bridge -netns $testns vni add dev vxlan-ext1 vni 16777216"
> +	log_test $? 255 "Cannot add a vni the vxlan header cannot carry"

[Severity: Medium]
Do these three cases reach VXLAN_VNIFILTER_ENTRY_END at all?

They are all single-VNI commands, so the message carries START only.  The
kernel change bounds both attributes:

	[VXLAN_VNIFILTER_ENTRY_START] = NLA_POLICY_FULL_RANGE(NLA_U32,
							      &vni_filter_vni_range),
	[VXLAN_VNIFILTER_ENTRY_END] = NLA_POLICY_FULL_RANGE(NLA_U32,
							    &vni_filter_vni_range),

but the unbounded walk in vxlan_vni_add_del() under rtnl_lock is reached
through END, for example bridge vni add dev X vni 100-4294967295 (START=100,
END=0xffffffff).

No case in the file drives END past VXLAN_N_VID - 1, so the whole new block
still passes if the range check on VXLAN_VNIFILTER_ENTRY_END is dropped.
Would adding something like vni 16777215-16777216, or vni 100-4294967295,
cover the vector that motivated the change?

>  }
>  
>  # Sanity test vnifilter datapath

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916193449.2552039-1-alishmery18%40gmail.com
