Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF383A7198
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 04:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743304; cv=none; b=euVSYatJM5G1rsO6g3yg/RRD0WsGcDvzqiVU8dDoE2/JAFYOzjakeM83+f/O+hlFfsani3RD1v7LIaJnmzvkT+I+TlqbrUAHdRcgvs+xUjPSY5PNMZW02WEifsn5gcR1/eM9bArzBeECIe4EA2Uy5tjT2zqu4/fDWwyyMPLl7tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743304; c=relaxed/simple;
	bh=v4wsYnWh5Ysj4u+SBnb5cj/UiqGCiKMXoXDo86DUdvQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lqWg4k3e2tA/aBNHkHtAAM1s+NBxRTE9FU913LZ1zkuO+bre+doQAn+0X/EkJDG6dfMuQQO3vM1ZmliDu2PmHeRl64vbCAJ4Rmuzy5LILZBMiKccMgR5IAkfhyBzOeGPEWK1bUV62Zknw4fQlzCsjtBz82B91cMKod8DvqBqj8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLflV/c5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLflV/c5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8C61F00898;
	Wed, 30 Sep 2026 04:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743302;
	bh=7GmtqPuLJ4eR3C6PkTq7wJ/2an+/yiQ5GecpD80JMS8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NLflV/c5XOaWIigt6qgmvpfCOgrt8lEbGGxUS42P8R1pWRbOXwuGj2+04i9rDiuFt
	 79UjUUrtu9XxFkvcM4DsePx2qZrWmk6KK6bQ4MA+012GaTfFSNDT26EMen3pkSDB/G
	 tsqPEBgCCVxAAEaAdOLrkaaRDxahOLvVRM7Sh+q6Mq2vdTzpO50GzZ6Uh6V7+M3XK1
	 unCL7jNE/RhZmTU+hfqBEr6CJUTLpdbrXh02LQLHnZ2w5HAaDqI7KIXvXq3XNS4SSR
	 PuMDHmNcrTO8o6mbUx+DR9wFgfEyqYKswoU7hw9b+ZfNUpO29iZmgLvMfGRg1XUFx7
	 mAjsCof95a22g==
Subject: Re: [PATCH net-next v3 5/5] net: net_test: add tests for bounded GSO
 segmentation
From: netdev-bot+sashiko@kernel.org
To: wang.zhan@smartx.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com,
 willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, andrew+netdev@lunn.ch,
 aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 dev@openvswitch.org, daniel@iogearbox.net, ncardwell@google.com,
 kuniyu@google.com, alice@isovalent.com, david.laight.linux@gmail.com
Date: Wed, 30 Sep 2026 04:41:41 +0000
Message-ID: <179074330121.434549.10483964015302541350@kernel.org>
In-Reply-To: <20260928044102.1004310-6-wang.zhan@smartx.com>
References: <20260928044102.1004310-6-wang.zhan@smartx.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The v3 changelog says headroom is now reserved "so the VLAN
  step needs no atomic allocation".
- [Low] The new bounded tests only check `gso_segs <= max_segs`
  (KUNIT_EXPECT_LE in gso_test_func() and…
- [Low] gso_tcp6_skb_new() allocates exactly GSO_TCP6_HDR_LEN +
  payload_len bytes, calls skb_reserve(skb, NET_SKB_PAD), and then calls…
- [Low] gso_test_tcp_bounded_segment() calls KUNIT_ASSERT_LT(test, i,
  ARRAY_SIZE(expected)) inside the loop that walks the segment list it…

--

net: net_test: add tests for bounded GSO segmentation

This commit adds KUnit coverage for GSO segmentation with a bound on the
number of MSS segments per output skb. It adds three parameterized
skb_segment() cases with max_segs and a TCP __skb_gso_segment() test with a
bound of two MSS. It also adds a test that pushes a 200 KiB TCP skb through
validate_xmit_skb_list(), and a test for the per-L3 GSO size limit that
netif_skb_features() applies.

> diff --git a/net/core/net_test.c b/net/core/net_test.c
> index 9c3a590865d26..a4f61398a90ab 100644
> --- a/net/core/net_test.c
> +++ b/net/core/net_test.c

[ ... ]

> @@ -247,6 +309,17 @@ static void gso_test_func(struct kunit *test)
>  
>  		/* header was copied to all segs */
>  		KUNIT_ASSERT_EQ(test, memcmp(skb_mac_header(cur), hdr, sizeof(hdr)), 0);
> +		if (tcase->segs_are_gso) {
> +			KUNIT_EXPECT_TRUE(test, skb_is_gso(cur));
> +			KUNIT_EXPECT_EQ(test, skb_shinfo(cur)->gso_size,
> +					GSO_TEST_SIZE);
> +			KUNIT_EXPECT_LE(test, skb_shinfo(cur)->gso_segs,
> +					tcase->max_segs);

[Severity: Low]
This isn't a bug, but would it be worth checking the exact gso_segs of each
output here instead of only an upper bound?

skb_segment() sets gso_segs on the grouped outputs:

	skb_shinfo(iter)->gso_segs = partial_segs;

and tcp_gso_segment() uses that value as the per-output sequence stride:

	if (skb_is_gso(segs))
		mss *= skb_shinfo(segs)->gso_segs;

If that accounting regressed and left gso_segs at 0 or 1, these checks would
still pass even though the outputs carried the wrong sequence numbers.
gso_test_tcp_bounded_segment() has the same KUNIT_EXPECT_LE() check, and it
doesn't check th->seq either.

With the current skb_segment() the grouped outputs get 2, and the tail gets
DIV_ROUND_UP(1003, 1000) = 2, so the tests pass today for the right reason.

> +			KUNIT_EXPECT_FALSE(test, skb_shinfo(cur)->gso_type &
> +					 SKB_GSO_PARTIAL);
> +		} else if (tcase->max_segs) {
> +			KUNIT_EXPECT_FALSE(test, skb_is_gso(cur));
> +		}

[ ... ]

> +static struct sk_buff *gso_tcp_skb_new(unsigned int payload_len)
> +{
> +	struct sk_buff *skb;
> +	struct ethhdr *eth;
> +	struct tcphdr *th;
> +	struct iphdr *iph;
> +
> +	skb = alloc_skb(GSO_TCP_HDR_LEN + payload_len, GFP_KERNEL);
> +	if (!skb)
> +		return NULL;
> +	skb_put_zero(skb, GSO_TCP_HDR_LEN + payload_len);

[Severity: Medium]
The v3 changelog says:

  reserve headroom so the VLAN step needs no atomic allocation

Only gso_tcp6_skb_new() calls skb_reserve(skb, NET_SKB_PAD). This IPv4
builder has no reserve, so skb_headroom() is 0.

gso_test_tcp_limit_l3_proto() still passes the 100 KiB IPv4 skb into
gso_test_tcp_l3_limit(), which inserts the tag:

gso_test_tcp_l3_limit()
  vlan_insert_tag_set_proto()
    vlan_insert_tag()
      vlan_insert_inner_tag()
        __vlan_insert_inner_tag()
          skb_cow_head(skb, meta_len + VLAN_HLEN)
            __skb_cow()
              pskb_expand_head(skb, ALIGN(delta, NET_SKB_PAD), 0, GFP_ATOMIC)

The head from alloc_skb(54 + 100 KiB) is already rounded up to 128 KiB.
Adding the new headroom and the shinfo pushes the reallocation past that, so
it becomes a 256 KiB (order-6) GFP_ATOMIC allocation.

If that allocation fails, vlan_insert_inner_tag() frees the skb and returns
NULL, and the test reports "no tagged skb".

Can the IPv4 half of the limit test fail this way for reasons unrelated to
GSO? Should gso_tcp_skb_new() reserve headroom the same way the IPv6 builder
does?

> +
> +	skb_reset_mac_header(skb);

[ ... ]

> +	segs = __skb_gso_segment(skb, features, true, max_segs);
> +	if (IS_ERR_OR_NULL(segs)) {
> +		KUNIT_FAIL(test, "segs error %pe", segs);
> +		consume_skb(skb);
> +		return;
> +	}
> +
> +	for (cur = segs; cur; cur = next, i++) {
> +		next = cur->next;
> +
> +		KUNIT_ASSERT_LT(test, i, ARRAY_SIZE(expected));

[Severity: Low]
Does this assertion leak cur, the rest of the segment list and the original
skb when it fires?

If __skb_gso_segment() returns more outputs than expected, which is the
regression this test exists to catch, KUNIT_ASSERT_LT() aborts the case
through kunit_try_catch_throw(). That skips consume_skb() for cur and every
later segment, and it also skips the final consume_skb(skb). None of these
are registered as KUnit resources.

The v3 changelog says it now frees "the skb and the device on the failure
paths". Could this use KUNIT_EXPECT_LT() and free the rest of the list
before bailing out?

> +		KUNIT_EXPECT_EQ(test, cur->len,
> +				GSO_TCP_HDR_LEN + expected[i]);

[ ... ]

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
> +	skb_reserve(skb, NET_SKB_PAD);
> +	skb_put_zero(skb, GSO_TCP6_HDR_LEN + payload_len);

[Severity: Low]
Is the NET_SKB_PAD reserved here missing from the alloc_skb() size?

skb_reserve() takes its bytes out of the tailroom. The full-length
skb_put_zero() only fits because kmalloc_reserve() rounds the head up with
kmalloc_size_roundup().

With today's only caller (payload_len = 100 KiB) the head rounds up to
128 KiB, which leaves plenty of slack. Some other payload_len could put the
aligned head size within NET_SKB_PAD of a kmalloc bucket or page-order
boundary. skb_put_zero() would then hit skb_over_panic().

Should this be alloc_skb(NET_SKB_PAD + GSO_TCP6_HDR_LEN + payload_len,
GFP_KERNEL)?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928044102.1004310-1-wang.zhan%40smartx.com
