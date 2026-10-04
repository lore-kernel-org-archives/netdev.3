Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9C53F65EF
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791095998; cv=none; b=K2kI+EYh8P/LvjRk+2SYvdt26aLn37mN+vlaq6AkD6wUt0LK5lz+kGe4hnWbUEX4KGa8olobVw7ruHkVK/tpoaOcPzVk6dlw5YsS9BTCSUA6AJ6giepazC5VxP05y69mFbALLQix4HpPbjZ/sVkbN0j87AcvvMRbfocxGHJ5hR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791095998; c=relaxed/simple;
	bh=89seAgpZGq3CoXrmLbTkzUSUlFw7beOUCor7oWNedPQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uLb+0Ibaj9HJkqhzXl5EMspSkmwydSaUrm2ZyveRMAdICH5r3AqV13LGZZM5mnN5hX0b30g15ENJ2z3tGvqqN6ZYQ2OHudTvSL509jtFRsa6MEWRVzqm6tHg2kMDG6G6oi00IlE9999HGP4zBhBNcDHKIHUzKNiMctK/IFjdpyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/+WFG6E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/+WFG6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC9E1F00893;
	Sun,  4 Oct 2026 06:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791095997;
	bh=es+0fmsAs0xn762Bl5tsGmBwGKAMO52blVRcPMW/UmQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O/+WFG6EpvMzEtrUH6DUrjX3jzf1YcwB7jeekX/cGF1LRxNCa/JkuDMvPPfrqJFky
	 VaydJRKmE5AapBGUuKkaLqiGOtJpLzDXQspvkcHdYCE9zhHcRS/s11aBwiA35UXQWV
	 BZtgwiPn+eP7EXiQxd6TTxTXBtHCHFh49ICbMA5Pc8CbMUwCCLcVylGG2X2r0i/jlP
	 88fHwGsjaseOtVWAtscR90yJwU66eTVus5btGTT5okm6Y5EqHMHTc7qAvZwrWPO+lK
	 UJQu42QZpQGFMYyF61Y0OVujJSp8N87laT/hJZvMugiSIC9aidqAUIvITT6f/nnDzW
	 D7tvshj9Zy1ww==
Subject:
 Re: [PATCH net v4 2/2] selftests: net: add TAP socket filter attach tests
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
Date: Sun, 04 Oct 2026 06:39:56 +0000
Message-ID: <179109599615.434549.7482300990879750382@kernel.org>
In-Reply-To: <20261003063859.136895-3-clementwei90@163.com>
References: <20261003063859.136895-3-clementwei90@163.com>
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

- [Low] In reattach_filter_without_user_buffer()
  (tools/testing/selftests/net/tun.c), the inline comment "The process…

--

selftests: net: add TAP socket filter attach tests

This adds four TAP selftests in tools/testing/selftests/net/tun.c for
socket filter attach. They check that a filter is reattached from the
kernel copy after the user buffer becomes unreadable, that a rejected
TUNATTACHFILTER leaves the existing program in place, and that
IFF_NOFILTER and TUNDETACHFILTER both result in a queue without a filter.

> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index abe488bac50bb..cfaba57274025 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c

[ ... ]

> +TEST_F(tun, reattach_filter_without_user_buffer)
> +{
> +	struct sock_fprog gf = { 0 };
> +	struct ifreq ifr = { 0 };
> +	short flags = 0;
> +	void *prog;
> +	int fd, ret;
> +
> +	prog = filter_alloc(filter_accept, ARRAY_SIZE(filter_accept));
> +	ASSERT_NE(prog, NULL);
> +	ASSERT_EQ(filter_attach(self->fd, prog, ARRAY_SIZE(filter_accept)), 0);
> +
> +	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
> +
> +	/* The process that called TUNATTACHFILTER no longer maps this memory */
> +	ASSERT_EQ(mprotect(prog, getpagesize(), PROT_NONE), 0);
> +
> +	ret = tun_attach(self->fd, self->ifname);
> +	EXPECT_EQ(ret, 0);
> +
> +	flags = tun_get_iff_flags(self->fd);
> +	EXPECT_GE(flags, 0);
> +	/* The queue is attached again, not left disabled */
> +	EXPECT_EQ(flags & IFF_DETACH_QUEUE, 0);
> +	EXPECT_EQ(flags & IFF_NOFILTER, 0);
> +
> +	EXPECT_EQ(filter_get(self->fd, &gf), 0);
> +	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));

[Severity: Low]
Is the comment above the mprotect() call accurate? mprotect(PROT_NONE)
leaves the page mapped and only makes it inaccessible. Later in the same
test the protection is put back and the page is unmapped:

	ASSERT_EQ(mprotect(prog, getpagesize(), PROT_READ | PROT_WRITE), 0);
	ASSERT_EQ(munmap(prog, getpagesize()), 0);

Would something like "this memory is no longer readable" describe it
better?

Also, do the IFF_NOFILTER and gf.len checks on self->fd test the reattach
at all?

__tun_detach() with clean=false does not remove the socket filter from the
detached queue. So IFF_NOFILTER would still be clear on self->fd even if
tun_attach() installed nothing.

TUNGETFILTER returns the tun->fprog header, and the reattach path does not
change it. So gf.len matches no matter what happened during reattach.

The checks that do test something are ret == 0, IFF_DETACH_QUEUE == 0, and
the IFF_NOFILTER check on the fresh socket below. Could the two redundant
checks be dropped, or replaced with ones that can tell a reinstalled filter
from no filter?

On the patched kernel, sk_attach_filter_kern() succeeds from the kernel
copy. So this test does run the detached-queue success path, and the
IFF_DETACH_QUEUE check would catch the earlier "success, goto out without
publishing" bug if it came back.

> +
> +	/* A new queue starts without a filter, so a clear IFF_NOFILTER shows
> +	 * that the filter was installed again from the kernel copy.
> +	 */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261003063859.136895-1-clementwei90%40163.com
