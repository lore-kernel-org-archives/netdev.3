Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794190035;
	b=SkIKKQXbWSAJtwMrmnD9mu102DIQk9dlQ1GolZQXTz5osI/aLdTujAFpSbC7cnCanR2B
	 XIYMkJ04HR1IfzeJ715uGsF7KK/Z59hBQGFLZ1G+l7u119PDHtsZjZy7APr0jWz6vQn7g
	 MmZNNk888YatwdPrEHtv67dzvHxenV26v7ZXF0fdsjHDry2L7ETP/1Lo+Z6TGy2hENY4S
	 SyiqlmfHzU8gdXbLYNbRsMtIoLsG77iCgyeIKyWwD6EZPfj1BqJJMnKbKiSbXhnvll4qt
	 lWX/7ZBRl7cNwynXzTKdKTC7Bob0Ts8IpJz6UY7Bz1CEvHWTQMJmg45PGpA4bKrluqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794190035;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hSD1rqMgCoWRPXFQG8QntSET/e/Z84tLm0kx9QEwTr8=;
	b=banveFrD56CaO9+qiolxvSEBqkqa7R2HIj2VxVARn8dEeVjwyZYtVbw0Zj03oguSf9P7
	 +8stGYcpKuMQ+OGu3Z1NvMqHw9eF3VDDtf+4MDuaEW4W7APNtJCZYiLEKwQ/csHKYaZrq
	 ChTgfy5MSIaWrtlmDvo5h1bzHC/EobC/GX0Kn96PqHDsUCtarJLAmIomoCVyhuqlfYIVI
	 ConiijlIO9+pjneEK6/zYokYjdq1aGkDmrrCWnriTkz8DfhnkieFDKlaxTclFk0kAZkU3
	 VPTAMb5oQto0pYa6DL/me9DfDkISSkf4wEYMVFl9XeQ6VlZ9oPnoqg055ec4PlpLCog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IjVGOibM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C057606A321;
	Mon,  9 Nov 2026 02:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IjVGOibM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4F11F008BE;
	Mon,  9 Nov 2026 02:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794190034;
	bh=hSD1rqMgCoWRPXFQG8QntSET/e/Z84tLm0kx9QEwTr8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IjVGOibMtzYXYpKu23OdG8QDAOr0lz353c/bR+q4pMalpy45TdzL42Zn2rwHmmxRi
	 cM878p4aWhtpVghoDkwax4QfO4YyvnJzjQ2G0Edyr+NO7ZSOD+wXs2bzeHBOuXfENB
	 Xcl9GnC8hwR/pugfwbe/IQbW3Bscd/9WTh8tahz+GIWrRkd5D759XQE4mc+PBZ3qqO
	 ry2Kgcj2jcfI2r3issXGzwonM1CDuBKhn76TvSJL8qmJZeqrNl7MEvSH6vXiJKLLYE
	 EbBrlhAq0aLEedDMLMdWknDAlLobkhVWFRkEhV05gWRrAgF9yclQAY76XL1HQUD4CQ
	 Q/I5Qtt0C6qMQ==
Subject: Re: [PATCH net 2/2] net: add a KUnit test for the
 alloc_skb_with_frags() tail split
From: netdev-bot+sashiko@kernel.org
To: yanhaishuang@cmss.chinamobile.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com,
 willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 02:07:13 +0000
Message-ID: <179419003377.994134.4899199888022081447@kernel.org>
In-Reply-To: <20261108100617.23840-3-yanhaishuang@cmss.chinamobile.com>
References: <20261108100617.23840-3-yanhaishuang@cmss.chinamobile.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new test alloc_skb_with_frags_test_tail() in
  net/core/net_test.c only passes if every full-size high-order…
- [Low] The commit message of "net: add a KUnit test for the
  alloc_skb_with_frags() tail split" says the allocation failed with…

--

net: add a KUnit test for the alloc_skb_with_frags() tail split

This commit adds a KUnit case, alloc_skb_with_frags_test_tail(), to
net/core/net_test.c. The test asks alloc_skb_with_frags() for
MAX_SKB_FRAGS - 2 full PAGE_ALLOC_COSTLY_ORDER chunks plus a 7 page tail.
It then asserts that the allocation succeeds and that the frag sizes add
up to the requested length.

> Allocate MAX_SKB_FRAGS - 2 full chunks of PAGE_ALLOC_COSTLY_ORDER plus
> a 7 page tail. Rounding the tail down to 4 + 2 + 1 pages would need
> one frag more than MAX_SKB_FRAGS, which made the allocation fail with
> -ENOBUFS before the previous patch.

[Severity: Low]
This isn't a bug, but could the commit message name the fix this test
depends on, instead of saying "the previous patch"?

Once the series is merged, "the previous patch" no longer points to
anything in git history or in stable trees. The test fails on any tree
that lacks "net: do not run out of frags in alloc_skb_with_frags()".
Nothing in this commit tells a backporter or AUTOSEL about that
dependency.

Would it help to reference that commit by its subject (or sha once it
is merged)?

> diff --git a/net/core/net_test.c b/net/core/net_test.c
> index 2b5080c226636..5a451aaf37c9b 100644
> --- a/net/core/net_test.c
> +++ b/net/core/net_test.c
> @@ -1721,7 +1721,31 @@ static void netmem_ref_test_tcp_devmem_recv(struct kunit *test)
>  #endif
>  #endif
>  
> +static void alloc_skb_with_frags_test_tail(struct kunit *test)
> +{
> +	/* MAX_SKB_FRAGS - 2 full chunks plus a 7 page tail: rounding the
> +	 * tail down to 4 + 2 + 1 pages would need one frag too many.
> +	 */
> +	unsigned long len = (MAX_SKB_FRAGS - 2) *
> +			    (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER) +
> +			    7 * PAGE_SIZE;
> +	unsigned long frags_len = 0;
> +	struct sk_buff *skb;
> +	int err, i;
> +
> +	skb = alloc_skb_with_frags(0, len, PAGE_ALLOC_COSTLY_ORDER, &err,
> +				   GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL_MSG(test, skb, "err %d", err);

[Severity: Medium]
Can this assertion fail on a system with fragmented memory, even with
the fix applied?

For order > 0, alloc_skb_with_frags() in net/core/skbuff.c clears
__GFP_DIRECT_RECLAIM. A failed order-3 allocation then drops the order
for good:

net/core/skbuff.c:alloc_skb_with_frags() {
    ...
		if (nr_frags == MAX_SKB_FRAGS)
			goto failure;
    ...
		if (order) {
			page = alloc_pages((gfp_mask & ~__GFP_DIRECT_RECLAIM) |
					   __GFP_COMP |
					   __GFP_NOWARN,
					   order);
			if (!page) {
				order--;
				continue;
			}
    ...
}

The tail branch never raises the order again, because order_base_2(pages)
and ilog2(pages) are never above the current order.

This length needs MAX_SKB_FRAGS - 1 frags at order 3, which leaves one
frag spare. Take MAX_SKB_FRAGS = 17 with 4K pages:

  len = 15 * 32K + 28K
  14 order-3 chunks succeed, then the 15th fails -> order 2
  60K left, three 16K frags -> nr_frags == 17, 12K still left
  goto failure -> NULL, err = -ENOBUFS

So a failure of any of the full-size order-3 chunks leaves too few frags
for the rest of the data. Only a failure of the final tail allocation
can recover, through the hweight_long()/order_base_2() branch.

When this happens, the assertion prints "err -105". That is the same
symptom the commit message gives for the unfixed kernel, so a failure
caused by fragmentation looks like the regression the test is meant to
catch.

NET_TEST is tristate, so the test can be loaded with modprobe on a
long-running host. With 64K pages, each full chunk is 512K of
contiguous memory.

Would it be more reliable to call kunit_skip() when the order-3
allocations cannot be satisfied? Another option is to build the skb so
the page sizes are fixed, rather than asserting that the allocation
always succeeds.

> +
> +	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
> +		frags_len += skb_frag_size(&skb_shinfo(skb)->frags[i]);
> +	KUNIT_EXPECT_EQ(test, frags_len, len);
> +
> +	kfree_skb(skb);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108100617.23840-1-yanhaishuang%40cmss.chinamobile.com
