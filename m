Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887373E0C4C;
	Thu, 10 Sep 2026 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033144; cv=none; b=iFpZlv4o/EtHoZZf4s8vLw4AMc2gqVVhnC79C96q8juydv2osQU3JBjsikr/+dOl3IDp9nJlklFgIs7sbDj8JF/j2FKWacTNqLMCSGZ3/6UkJ/sKmBja8pX7uLy3cvzmvLPlnr9yP2XrOStR9Vz7kkj98zXnTYuKw7wei3kfU40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033144; c=relaxed/simple;
	bh=qwKzP20F+V9VShHP1J5vtOL1QvhxrdxQ/mZ8TC+Nuiw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K+MIVWIoYF1baoelgUnO1NDaGk1GqSpoBRb2uEX+2lKdSaeUbkeLLm87U1wWqwezvm6czDmX5EWr8I8I4kYeZWOx1v377bDekcjfvpDrHnkwOXKgPAKEj7MGrQEb/RVPgPSSACfTYnHAi8G7xEG+0rwx+djjuZLrL0tbBwDiqaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+CixY8S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+CixY8S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FE01F00899;
	Thu, 10 Sep 2026 09:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789033142;
	bh=9vbyzbXoNope4m/E98fT/D/U3csHTzjzJphWG4NeJ5k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i+CixY8StmiNKIONwe0jOeJATuAqnudmZApSHMRB9wM+iyL88F/3aCdvZrioI851B
	 GORCC6CHLVFrLwIhm3KJ4pLaOWCL84E6ymksBuhQ995u4Z7bFdRI6tQ9cHcWDkEepH
	 XRObAM8Snb4fymfWeCTQCU4MGCSRkpQoIIakWjCfHuglfk2DPkYYwxglsDwq7IIVrX
	 CA6+wBd7Bxl4QPzSUBvG6nU6TUdcNXP8DenTIbaSMeoy8aNE8VgSsMv8HJsQqHB3rx
	 8J6+3pwICMYN6RwcnEitUQ6cnzJ5zu8RGIQEzuqgxq/5D1cJqMXy29f7FLGXPUFwVV
	 aCq0dbwjJx0hA==
Subject:
 Re: [PATCH net 3/3] selftests: net: test the vxlan vnifilter VNI range limit
From: netdev-bot+sashiko@kernel.org
To: alishmery18@gmail.com
Cc: netdev@vger.kernel.org, idosch@nvidia.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, razor@blackwall.org, roopa@nvidia.com,
 linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 09:39:01 +0000
Message-ID: <178903314108.219967.3512996102367717526@kernel.org>
In-Reply-To: <20260909092645.3105263-4-alishmery18@gmail.com>
References: <20260909092645.3105263-4-alishmery18@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 0

- [High] The series' stated guarantee — "A single RTM_NEWTUNNEL or
  RTM_DELTUNNEL request may span at most 4096 VNIs" (this selftest's…
- [Medium] The new "Cannot delete vni range larger than maximum" case
  (tools/testing/selftests/net/test_vxlan_vnifiltering.sh:382-383) has…

--

selftests: net: test the vxlan vnifilter VNI range limit

This adds four cases to vxlan_vnifilter_api() in
test_vxlan_vnifiltering.sh covering the new 4096-VNI cap on a vnifilter
request: an add and a delete of exactly the maximum span are expected to
succeed, and an add and a delete one VNI larger are expected to fail.
No Link: tags were present in the commit header.

> diff --git a/tools/testing/selftests/net/test_vxlan_vnifiltering.sh b/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
> index 8deacc565afa..464ff353d6c0 100755
> --- a/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
> +++ b/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
> @@ -371,6 +371,19 @@ vxlan_vnifilter_api()
>  	# change vxlan vnifilter flag
>  	run_cmd "ip -netns $testns link set dev vxlan-ext1 type vxlan external novnifilter"
>  	log_test $? 2 "Cannot unset vnifilter flag on a device"
> +
> +	# a single request may span at most 4096 vnis
> +	run_cmd "bridge -netns $testns vni add dev vxlan-ext1 vni 10000-14095"
> +	log_test $? 0 "Add vni range of maximum size"
> +
> +	run_cmd "bridge -netns $testns vni add dev vxlan-ext1 vni 10000-14096"
> +	log_test $? 255 "Cannot add vni range larger than maximum"

[Severity: High]
The comment here, and the commit message wording "A single RTM_NEWTUNNEL
or RTM_DELTUNNEL request may span at most 4096 VNIs", describe a
per-request property.  Is that what the companion patch actually
enforces?

The check lives in vxlan_process_vni_filter():

	if (vni_end >= vni_start &&
	    vni_end - vni_start >= VXLAN_VNI_FILTER_RANGE_MAX) {
		NL_SET_ERR_MSG_ATTR_FMT(extack, nlvnifilter,
					"VNI range spans more than %u VNIs",
					VXLAN_VNI_FILTER_RANGE_MAX);
		return -EINVAL;
	}

and vxlan_vnifilter_process() calls that helper once per
VXLAN_VNIFILTER_ENTRY attribute present in the message:

	nlmsg_for_each_attr_type(attr, VXLAN_VNIFILTER_ENTRY, nlh,
				 sizeof(*tmsg), rem) {
		err = vxlan_process_vni_filter(vxlan, attr, nlh->nlmsg_type,
					       extack);
		vnis++;
		if (err)
			break;
	}

So a message carrying N entries, each an individually legal 4096-VNI
span, still results in N * 4096 add/del operations inside one rtnl_lock
hold.  An entry nest with only START and END is roughly 20 bytes on the
wire, and netlink_sendmsg() accepts messages up to sk_sndbuf/2, so
thousands of entries fit in a single request.

Since iproute2 emits exactly one VXLAN_VNIFILTER_ENTRY per message, can
any of the four new cases observe a multi-entry request?  They all
exercise the per-entry path only.

Would it make sense either to accumulate the span across entries in
vxlan_vnifilter_process(), or to reword the comment above
VXLAN_VNI_FILTER_RANGE_MAX, the commit messages and these test names to
say "per entry"?

> +
> +	run_cmd "bridge -netns $testns vni del dev vxlan-ext1 vni 10000-14096"
> +	log_test $? 255 "Cannot delete vni range larger than maximum"
> +
> +	run_cmd "bridge -netns $testns vni del dev vxlan-ext1 vni 10000-14095"
> +	log_test $? 0 "Delete vni range of maximum size"

[Severity: Medium]
Can the "Cannot delete vni range larger than maximum" case distinguish
the range limit from a plain missing-VNI error?

Only 10000-14095 were installed by the first case, so the delete of
10000-14096 has two ways to return non-zero.  With the cap present,
vxlan_process_vni_filter() returns -EINVAL and nothing is touched.
With the cap removed, vxlan_vni_add_del() deletes 10000-14095 and then
vxlan_vni_del() hits:

	vninode = rhashtable_lookup_fast(&vg->vni_hash, &v,
					 vxlan_vni_rht_params);
	if (!vninode) {
		err = -ENOENT;
		goto out;
	}

which the loop propagates.  iproute2 maps either errno to exit status
255, the same coarse value the pre-existing "vni add dev vxlan-ext2 vni
200" case already expects, so log_test $? 255 passes in both cases.

In the no-cap case the 4096 VNIs are already gone, so the next
assertion, "Delete vni range of maximum size" expecting 0, is the one
that fails.  Does that not report the regression under the wrong test
name?

Would deleting a span whose every VNI exists (for example installing
10000-14096 with two capped adds first), or matching the extack text
rather than only the exit status, make the case specific to the limit?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909092645.3105263-1-alishmery18%40gmail.com
