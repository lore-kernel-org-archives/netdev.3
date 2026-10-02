Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4537848D873
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939807; cv=none; b=l2I/2LGfPFk1CUYeCcXqtmuVoI47k6isSFPCmmKjeU10ss2o112nV61sTX/kZHUcwPU3xyzB5MlP3IJoHAS8gfP/Fw03Yow3/shWmOofbZU9IemUl1DlAjBbbxuchicY1RnIYzEx0XqUi1ttmjJQukNOi2X99JZHiYU9+zA/nwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939807; c=relaxed/simple;
	bh=U6XUGlEDlZzhMWkYCAHSiVoXIHWv2yg8KYfDn3BCfTM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FpmNkHI0sidxVifQd1yS1cFrov7VMl62gf0MW2JKXm70/EGxJ/pV5t96mnK+3vtmiqvuiTYvnuSsEc07qvB0n2pN9cdU6PVP3oWYE47nOHI9d2/yY/JJeu4sivYGVyt9TKL2shKad0reJ74BEonBmYgG4IGRc3dS33neBnYqBjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSKWOfb/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSKWOfb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54251F000FF;
	Fri,  2 Oct 2026 11:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939805;
	bh=dxq9QdfYRj60Ipn8OQC51czgDwILKgUxqv3nCb6U8WU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bSKWOfb/ORJ8+HhJ22MaE8nMzaHjA+mOieRkj+8FrXP+BhZltqk6jgh3C13wuPCjF
	 2o/l8YmGMKihuKIKqcbXJ85sMkzWBPBmm2+D2W92pmRb1jMGbaVibIgLYNES/JkfDe
	 EyyBoqIPDma1vAP0eZ/NPqDosCzUe2xxdl/5APK0vjZQJ8Djy0M/dsVklTbEh6nPGv
	 YXf+OZ1W+gWhs7bLCM1oAiURDhrIpxWHdNTfzXGOJj8grXtTIx/v47ZQDsiFcn+on9
	 sdwr+QxSwelKvVhUcgY8xKdzEbPMfd2HJMV1Kk4e6Qtr55rHqGi3MfsqeU4EXEWqRP
	 OsrMSy8pTQ30A==
Subject:
 Re: [PATCH net-next v4 5/5] net: net_test: add tests for TCP re-segmentation
From: netdev-bot+sashiko@kernel.org
To: wang.zhan@smartx.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com,
 willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, andrew+netdev@lunn.ch,
 aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 dev@openvswitch.org, daniel@iogearbox.net, ncardwell@google.com,
 kuniyu@google.com, alice@isovalent.com, david.laight.linux@gmail.com
Date: Fri, 02 Oct 2026 11:16:44 +0000
Message-ID: <179093980428.434549.13447790156266224000@kernel.org>
In-Reply-To: <20260930111526.2183107-6-wang.zhan@smartx.com>
References: <20260930111526.2183107-6-wang.zhan@smartx.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says the parameterized GSO test gains "two
  limits which cut the input into two and three output skbs".
- [Low] The new exact gso_segs checks cannot catch a broken gso_segs
  value on the last re-segmented output.
- [Low] In gso_test_func(), the new `KUNIT_ASSERT_LT(test, i,
  tcase->nr_segs);` inside the segment-freeing loop…

--

net: net_test: add tests for TCP re-segmentation

This commit adds KUnit coverage for the max_segs parameter of the GSO
engine. It adds three re-segmentation cases to the parameterized
skb_segment() test. It also adds TCP tests that drive __skb_gso_segment()
and validate_xmit_skb_list(), and a test that checks that
netif_skb_features() applies the GSO size limit of the packet's L3
protocol.

> The parameterized GSO test gains a max_segs input and three cases: two
> limits which cut the input into two and three output skbs, and a max_segs
> of one MSS, which must leave the output unchanged.

[Severity: Low]
Is "two limits" accurate here? GSO_TEST_RESEGMENT and
GSO_TEST_RESEGMENT_MULTI both use the same limit:

    .max_segs = 2,

That limit is applied to a 3003 byte payload and to a 5003 byte payload.
The only other value tested is max_segs = 1 in GSO_TEST_RESEGMENT_ONE_MSS.

Could the message say that one limit is applied to two inputs?

> diff --git a/net/core/net_test.c b/net/core/net_test.c
> index 9c3a590865d26..6a91db83e5301 100644
> --- a/net/core/net_test.c
> +++ b/net/core/net_test.c

[ ... ]

> @@ -239,6 +297,7 @@ static void gso_test_func(struct kunit *test)
>  	for (cur = segs, i = 0; cur; cur = next, i++) {
>  		next = cur->next;
>  
> +		KUNIT_ASSERT_LT(test, i, tcase->nr_segs);
>  		KUNIT_ASSERT_EQ(test, cur->len, sizeof(hdr) + tcase->segs[i]);

[Severity: Low]
If skb_segment() returns more outputs than tcase->nr_segs, this assertion
aborts the test through kunit_try_catch_throw(). Does that leak cur and
every later skb on the ->next chain, along with their page frag
references? It would also skip freeing the input skb at free_gso_skb.

The v4 changelog says "free the segments when a bounded case does not
match". gso_test_tcp_resegment() does this: it uses EXPECT checks and
consumes every segment, but gso_test_func() still aborts here.

The other ASSERTs in this loop already abort the same way. This one does
stop the read past the end of tcase->segs[] on the next line.

Would an EXPECT here, with the per-index checks skipped once i reaches
tcase->nr_segs, keep both the bounds protection and the cleanup?

>  
>  		/* segs have skb->data pointing to the mac header */
> @@ -247,6 +306,18 @@ static void gso_test_func(struct kunit *test)
>  
>  		/* header was copied to all segs */
>  		KUNIT_ASSERT_EQ(test, memcmp(skb_mac_header(cur), hdr, sizeof(hdr)), 0);
> +		if (tcase->segs_are_gso) {
> +			KUNIT_EXPECT_TRUE(test, skb_is_gso(cur));
> +			KUNIT_EXPECT_EQ(test, skb_shinfo(cur)->gso_size,
> +					GSO_TEST_SIZE);
> +			KUNIT_EXPECT_EQ(test, skb_shinfo(cur)->gso_segs,
> +					DIV_ROUND_UP(tcase->segs[i],
> +						     GSO_TEST_SIZE));

[Severity: Low]
Can this check detect a wrong gso_segs on the last output? skb_segment()
first gives every output partial_segs and then fixes up the tail:

net/core/skbuff.c:skb_segment() {
    ...
		for (iter = segs; iter; iter = iter->next) {
			skb_shinfo(iter)->gso_size = gso_size;
			skb_shinfo(iter)->gso_segs = partial_segs;
    ...
		if (tail->len - doffset <= gso_size)
			skb_shinfo(tail)->gso_size = 0;
		else if (tail != segs)
			skb_shinfo(tail)->gso_segs = DIV_ROUND_UP(tail->len - doffset, gso_size);
    ...
}

GSO_TEST_RESEGMENT, GSO_TEST_RESEGMENT_MULTI and gso_test_tcp_resegment()
all use max_segs = 2 and end with a 1003 byte tail. DIV_ROUND_UP(1003,
1000) is 2, the same as partial_segs, so these checks would still pass if
the tail fix-up were dropped.

The one test whose tail count differs is gso_test_tcp_resegment_l3_len().
Its outputs are 65000, 65000, 65000 and 9800 bytes, so the tail should have
gso_segs of 10 rather than 65. That test does not check gso_segs.

The v4 changelog says "check the exact gso_segs of each output". Could one
of the vectors use a tail that gives a different count? For example,
max_segs = 3 with a 4003 byte payload should give gso_segs of 3 and 2.

> +			KUNIT_EXPECT_FALSE(test, skb_shinfo(cur)->gso_type &
> +					 SKB_GSO_PARTIAL);
> +		} else if (tcase->max_segs) {
> +			KUNIT_EXPECT_FALSE(test, skb_is_gso(cur));
> +		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930111526.2183107-1-wang.zhan%40smartx.com
