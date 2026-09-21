Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9AB4B3364
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023813; cv=none; b=OuGJD9zi+oOeJA/KjijECyvVSpqw9AYu8BftzDXM4mi7Bw2Uzjku8oy7BKLmcJOonfQ88Z5R22ODV0ioNtV4EK+0QABigeujafw+21N/TobEOHDAE6Cmpp+Kmn3a6yMbOPghTaePZnqhHJgxjHuIqdrZJfB/byJAKPxYiNWuyqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023813; c=relaxed/simple;
	bh=YhsMkq9OdsvXnyK35+/zhA+YLwhC2Nd8AA4HSF7VU0g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tcp9SA2avNpFO4aAsFlPADAndA202Hd7MNYz6neWHhEUN99efR92w/NlW5UvVDW/xCsxpIAkU2yRc+4YvNy5yVaQo1psCw0rE9Y9r0GD4fk7jLtfXKe3SPDN3wLJCzpIJ/8UESiWcPD9NKGwBDN/o+v0deLfJO4cgRNpArk0lKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMaRAFbE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMaRAFbE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F691F00898;
	Mon, 21 Sep 2026 20:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790023807;
	bh=gXTXh2I1i1i5UF4HPojuej/+aUH/2J+fbR/QmYf2C1E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WMaRAFbEPDEMKuo2pbcf9c2BL/6RrGppfhd2cXbi1EUtQ2wBsjsz7t/qQBXz4ByW7
	 2VeFChxdxxvqQ6JHGmDkGXgZcPfMViR18mSOahtVbcFInhjvV0jhBGH5cmwBmKbCZ8
	 gWjTvN54FNiqV5dBHwtS/S+tKAtXBFz0o1fNNehGj9k+7tF1zi+zqbUMgHzf/OTcK0
	 YaEk9OpCTGygLDqbrokMTd7uT+pvPH1YyReHMgDaJwkUHeIJcu6TPhAhlRk7Xk6atW
	 xxNizNZZMfnYgRjKyBPf5vbFOecVURIDYOTI/ytSn6pb6mY14ycn3LAcOJ9lwyjRJM
	 hw3yLb/APSIeQ==
Subject: Re: [PATCH net-next v2 4/4] net: net_test: add tests for bounded GSO
 segmentation
From: netdev-bot+sashiko@kernel.org
To: wang.zhan@smartx.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com,
 i.maximets@ovn.org, aconole@redhat.com, echaudro@redhat.com,
 dev@openvswitch.org, andrew+netdev@lunn.ch, jasowangio@gmail.com,
 willemdebruijn.kernel@gmail.com, ncardwell@google.com, kuniyu@google.com,
 alice@isovalent.com
Date: Mon, 21 Sep 2026 20:50:06 +0000
Message-ID: <179002380633.2160803.14947068011503961407@kernel.org>
In-Reply-To: <20260918084651.3022878-5-wang.zhan@smartx.com>
References: <20260918084651.3022878-5-wang.zhan@smartx.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 5 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] gso_test_tcp_bounded_segment() (net/core/net_test.c:375-409)
  introduces an undeclared CONFIG_INET dependency into the NET_TEST…
- [Low] gso_test_tcp_limit_l3_proto() (net/core/net_test.c:455-503) makes
  the VLAN step depend on a large high-order GFP_ATOMIC allocation.
- [Low] The in-tree comment on the GSO_TEST_BOUNDED_ONE_MSS case claims
  'One MSS per skb is what the unbounded path produces, so a bound of a…
- [Low] gso_test_tcp_limit_l3_proto() never constructs an IPv4 skb, so it
  does not verify that IPv4 packets select dev->gso_ipv4_max_size.
- [Low] gso_test_tcp_limit_l3_proto() leaks the net_device (and, later,
  also the skb) whenever a fatal KUnit assertion aborts the case.
- [Low] gso_test_tcp_bounded_segment() leaks the input GSO skb (and, mid-
  loop, the untraversed remainder of the output list) when a fatal KUnit…

Pre-existing issues:
- [Low] In gso_test_func() the verification loop is bounded by the output
  skb list (`for (cur = segs, i = 0; cur; cur = next, i++)`) and indexes…

--

net: net_test: add tests for bounded GSO segmentation

This adds KUnit coverage for the new max_segs bound on GSO segmentation:
three new parameterized skb_segment() cases, a TCP test driving
__skb_gso_segment() with a bound of two MSS, and a test that the device
GSO size limit follows the packet's L3 protocol across a pushed VLAN tag.

A few questions below.

> diff --git a/net/core/net_test.c b/net/core/net_test.c
> index 9c3a590865d2..6ca0cbe3a365 100644
> --- a/net/core/net_test.c
> +++ b/net/core/net_test.c

[ ... ]

> @@ -135,6 +147,54 @@ static struct gso_test_case cases[] = {
>  		.nr_segs = 4,
>  		.segs = (const unsigned int[]) { 100, 200, 300, 400 },
>  	},

[ ... ]

> +	{
> +		/*
> +		 * One MSS per skb is what the unbounded path produces, so a
> +		 * bound of a single segment must not change the output.
> +		 */
> +		.id = GSO_TEST_BOUNDED_ONE_MSS,
> +		.name = "bounded_one_mss",
> +		.linear_len = GSO_TEST_SIZE,
> +		.nr_frags = 3,
> +		.frags = (const unsigned int[]) {
> +			GSO_TEST_SIZE, GSO_TEST_SIZE, 3,
> +		},
> +		.max_segs = 1,
> +		.nr_segs = 4,
> +		.segs = (const unsigned int[]) {
> +			GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE, 3,
> +		},
> +	},

[Severity: Low]
The comment says a bound of a single segment "must not change the output",
but does anything in the case actually check the form of the output?  This
case leaves segs_are_gso unset, and in gso_test_func() every GSO-state
check is gated on it:

	if (tcase->segs_are_gso) {
		KUNIT_EXPECT_TRUE(test, skb_is_gso(cur));
		...
	}

There is no negative assertion, so only the four lengths are compared.

In skb_segment(), max_segs == 1 gives partial_segs = min(len / mss, 1) == 1,
and then:

	if (partial_segs > 1)
		mss *= partial_segs;
	else
		partial_segs = 0;

If that guard ever became ">= 1", the grouping epilogue would set
gso_size = 1000 and gso_segs = 1 on each output, yet the segment lengths
(1000/1000/1000/3) and nr_segs would be unchanged and the case would still
pass.  Would adding an explicit check that these outputs are not GSO skbs
pin the documented behaviour down?

[ ... ]

> @@ -247,6 +308,15 @@ static void gso_test_func(struct kunit *test)
>  
>  		/* header was copied to all segs */
>  		KUNIT_ASSERT_EQ(test, memcmp(skb_mac_header(cur), hdr, sizeof(hdr)), 0);
> +		if (tcase->segs_are_gso) {
> +			KUNIT_EXPECT_TRUE(test, skb_is_gso(cur));
> +			KUNIT_EXPECT_EQ(test, skb_shinfo(cur)->gso_size,
> +					GSO_TEST_SIZE);
> +			KUNIT_EXPECT_LE(test, skb_shinfo(cur)->gso_segs,
> +					tcase->max_segs);
> +			KUNIT_EXPECT_FALSE(test, skb_shinfo(cur)->gso_type &
> +					 SKB_GSO_PARTIAL);
> +		}

[Severity: Low]
This isn't a bug introduced by this patch, but while adding cases here,
can this loop read past tcase->segs[]?  The loop in gso_test_func() is
bounded by the returned skb list, not by nr_segs:

	for (cur = segs, i = 0; cur; cur = next, i++) {
		next = cur->next;

		KUNIT_ASSERT_EQ(test, cur->len, sizeof(hdr) + tcase->segs[i]);

tcase->segs points at a compound literal with exactly nr_segs entries (2 for
bounded, 3 for bounded_multi, 4 for bounded_one_mss).  If skb_segment()
returns more outputs than expected while the leading lengths still match,
segs[nr_segs] is read past the end of the literal and the garbage value ends
up in the failure message.  The new TCP test uses the guard that would close
this:

	KUNIT_ASSERT_LT(test, i, ARRAY_SIZE(expected));

Would the same assertion fit in the parameterized loop?

> @@ -261,6 +331,177 @@ static void gso_test_func(struct kunit *test)
>  	consume_skb(skb);
>  }
>  
> +#define GSO_TCP_HDR_LEN \
> +	(ETH_HLEN + sizeof(struct iphdr) + sizeof(struct tcphdr))
> +

[ ... ]

> +static void gso_test_tcp_bounded_segment(struct kunit *test)
> +{
> +	netdev_features_t features = NETIF_F_SG | NETIF_F_HW_CSUM |
> +				     NETIF_F_TSO;
> +	const unsigned int payload_len = 3 * GSO_TEST_SIZE + 3;
> +	struct sk_buff *skb, *segs, *cur, *next;
> +	const unsigned int expected[] = {
> +		2 * GSO_TEST_SIZE, GSO_TEST_SIZE + 3,
> +	};
> +	const unsigned int max_segs = 2;
> +	int i = 0;
> +
> +	skb = gso_tcp_skb_new(payload_len);
> +	KUNIT_ASSERT_NOT_NULL(test, skb);
> +
> +	segs = __skb_gso_segment(skb, features, true, max_segs);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, segs);

[Severity: Medium]
Does this test add an undeclared CONFIG_INET dependency to the NET_TEST
suite?  The skb carries skb->protocol = htons(ETH_P_IP) and gso_type
SKB_GSO_TCPV4, and __skb_gso_segment() dispatches through
skb_mac_gso_segment():

	struct sk_buff *segs = ERR_PTR(-EPROTONOSUPPORT);
	...
	list_for_each_entry_rcu(ptype, &net_hotdata.offload_base, list) {
		if (ptype->type == type && ptype->callbacks.gso_segment) {

The only registrar of the ETH_P_IP offload is ipv4_offload_init(), which is
built only for CONFIG_INET.  net/Kconfig has:

	config NET_TEST
		tristate "KUnit tests for networking" if !KUNIT_ALL_TESTS
		depends on KUNIT
		default KUNIT_ALL_TESTS

so CONFIG_NET=y with CONFIG_INET=n is still a valid configuration, and there
the assertion above fires with -EPROTONOSUPPORT on every run.  Note that
KUNIT_ASSERT_NOT_ERR_OR_NULL() aborts the case as a failure rather than
skipping it.  Would "depends on INET" (or a kunit_skip() guard) be
appropriate here?  The existing cases in this file deliberately use a
protocol with no gso_segment callback and call skb_segment() directly.

[Severity: Low]
Does the input skb leak when this assertion fires?  skb is freed only by the
consume_skb(skb) at the end of the function, and KUNIT_ASSERT_* unwinds the
test-case thread, so nothing reaches that call.  Beyond the CONFIG_INET=n
case above, skb_segment() allocates its output skbs with GFP_ATOMIC and can
return ERR_PTR(-ENOMEM).

The in-loop KUNIT_ASSERT_LT() below has the same property: it runs before
consume_skb(cur), so an over-producing GSO engine would leave the current
segment, the rest of the segs list, and the input skb unfreed.

gso_test_func() in the same file avoids this with KUNIT_FAIL() plus
"goto free_gso_skb;".  Would the same pattern (or kunit_add_action()) work
here?

> +
> +	for (cur = segs; cur; cur = next, i++) {
> +		next = cur->next;
> +
> +		KUNIT_ASSERT_LT(test, i, ARRAY_SIZE(expected));
> +		KUNIT_EXPECT_EQ(test, cur->len,
> +				GSO_TCP_HDR_LEN + expected[i]);
> +		KUNIT_EXPECT_TRUE(test, skb_is_gso(cur));
> +		KUNIT_EXPECT_EQ(test, skb_shinfo(cur)->gso_size,
> +				GSO_TEST_SIZE);
> +		KUNIT_EXPECT_LE(test, skb_shinfo(cur)->gso_segs, max_segs);
> +
> +		consume_skb(cur);
> +	}
> +
> +	KUNIT_EXPECT_EQ(test, i, ARRAY_SIZE(expected));
> +	consume_skb(skb);
> +}
> +
> +#define GSO_TCP6_HDR_LEN \
> +	(ETH_HLEN + sizeof(struct ipv6hdr) + sizeof(struct tcphdr))
> +
> +static struct sk_buff *gso_tcp6_skb_new(unsigned int payload_len)
> +{
> +	struct ipv6hdr *ip6h;
> +	struct sk_buff *skb;
> +	struct ethhdr *eth;
> +	struct tcphdr *th;
> +
> +	skb = alloc_skb(GSO_TCP6_HDR_LEN + payload_len, GFP_KERNEL);
> +	if (!skb)
> +		return NULL;
> +	skb_put_zero(skb, GSO_TCP6_HDR_LEN + payload_len);

[Severity: Low]
Should this reserve some headroom?  There is no skb_reserve() here, so
skb_headroom() is 0 on the ~102 KB linear skb, and the later
vlan_insert_tag_set_proto() in gso_test_tcp_limit_l3_proto() goes
vlan_insert_tag() -> __vlan_insert_inner_tag() -> skb_cow_head(skb,
VLAN_HLEN), which with zero headroom does:

	pskb_expand_head(skb, ALIGN(VLAN_HLEN, NET_SKB_PAD), 0, GFP_ATOMIC);

That is a fresh order-5 GFP_ATOMIC allocation plus a full copy.  GFP_ATOMIC
cannot direct-reclaim or compact, so under fragmentation it fails,
vlan_insert_tag() frees the skb and returns NULL, and the test reports a
failure unrelated to what it is checking.  Would skb_reserve(skb, VLAN_HLEN)
(or NET_SKB_PAD) in this constructor exercise the same path without the
atomic reallocation?

[ ... ]

> +static void gso_test_tcp_limit_l3_proto(struct kunit *test)
> +{
> +	static const struct net_device_ops dummy_netdev_ops = { };
> +	const unsigned int payload_len = 100 * 1024;
> +	netdev_features_t features;
> +	struct net_device *dev;
> +	struct sk_buff *skb;
> +
> +	dev = alloc_etherdev(0);
> +	KUNIT_ASSERT_NOT_NULL(test, dev);
> +	dev->netdev_ops = &dummy_netdev_ops;
> +	dev->hw_features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_TSO6;
> +	dev->features = dev->hw_features;
> +	dev->vlan_features = dev->hw_features;
> +
> +	skb = gso_tcp6_skb_new(payload_len);
> +	KUNIT_ASSERT_NOT_NULL(test, skb);
> +	skb->dev = dev;

[Severity: Low]
Does the net_device leak here?  dev is released only by the free_netdev(dev)
at the end of the function, and three fatal assertions sit between the
alloc_etherdev(0) and that call: this KUNIT_ASSERT_NOT_NULL() on the ~102 KB
skb, and the KUNIT_ASSERT_NOT_NULL()/KUNIT_ASSERT_TRUE() pair after
vlan_insert_tag_set_proto() below, which also leaks the skb.  No
kunit_add_action() or managed allocation is registered for either object.

> +
> +	/* The skb fits the IPv6 limit but not the IPv4 one. */
> +	dev->gso_max_size = GSO_MAX_SIZE;
> +	dev->gso_ipv4_max_size = GSO_LEGACY_MAX_SIZE;
> +	features = netif_skb_features(skb);
> +	KUNIT_EXPECT_TRUE(test, features & NETIF_F_GSO_MASK);
> +
> +	/* ...and the other way around. */
> +	dev->gso_max_size = GSO_LEGACY_MAX_SIZE;
> +	dev->gso_ipv4_max_size = GSO_MAX_SIZE;
> +	features = netif_skb_features(skb);
> +	KUNIT_EXPECT_FALSE(test, features & NETIF_F_GSO_MASK);

[Severity: Low]
All four checks in this test operate on the IPv6 skb from
gso_tcp6_skb_new(), so is the IPv4 half of the contract covered?  The
selector is:

	return protocol == htons(ETH_P_IPV6) ?
	       READ_ONCE(dev->gso_max_size) :
	       READ_ONCE(dev->gso_ipv4_max_size);

An implementation of gso_within_device_limits() that always passed
ETH_P_IPV6, or simply always used dev->gso_max_size, would satisfy every
assertion here while breaking IPv4.  Adding an IPv4 skb (tagged and
untagged, with the limits skewed the other way) would need NETIF_F_TSO in
dev->hw_features as well, since only NETIF_F_TSO6 is set above.

[ ... ]

> +	/* Pushing the tag inside must not change either answer. */
> +	skb = vlan_insert_tag_set_proto(skb, htons(ETH_P_8021Q), 0);
> +	KUNIT_ASSERT_NOT_NULL(test, skb);
> +	KUNIT_ASSERT_TRUE(test, skb->protocol == htons(ETH_P_8021Q));

[ ... ]

> +	consume_skb(skb);
> +	free_netdev(dev);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918084651.3022878-1-wang.zhan%40smartx.com
