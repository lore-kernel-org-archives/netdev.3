Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481919;
	b=XA2EiLG8WoYBtL5UhYRv5O60XX2fAvB2wzxVRHf70w+qpJI9JfwlHp9iFp9Zu2t+vhzY
	 /Q3cpzpfiphriU+Uzbw3JQ/Gk9OkxnrbNyGhXymnQsto9dbKMVQH+pLJ3o+r2qRtNpRHU
	 R8hvvG0JL8jKH99tFC6fF2hvUnz+32IeW/lWac2uoM+hpKQS42VmTIMrnKdzLlsFK7Etu
	 PpIb65WLnIVZy0QBEIow2fU+s5GASW8cs5dtifjfZ46VtzCNZnhneotClc2sndGUwR+66
	 5kunLMrCwsSnNwjgPuFWLf/L265mKiWwi3rEgcEQdqf0lDqxQ5EUzg5HUkYeoGE6JXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481919;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LA5QNdOZLm3M8jVKLT4PzzX5K3Qa6HSIv6fGYEAHLFk=;
	b=alt0GCm/hcmG+5AshYYwod0qFn/reWZqXVho3+vFB0id1eimzFq9kAlJQhCBM0cl2Qkh
	 6t8n74ef1+3F7cwIBYa5awkgBZ4gLhap4/BkXB+vy+sdw8VrBs7C5YoqErupfUtj1zNwg
	 bmZ6Vr5/VKURjzeOTMO6qv2VO6G83zked3cCnr8lfNtn6Mbj5kAezJLg8Y5lvQVkIp8ge
	 Ft6dF+Ua1TCx/X1OxSR416Uda4NXcMwJ5Wyy0KI2SDaNsbk4ynnjFx36iFS6fWsqSbhBt
	 0P32GlImDFqsSjXY7jA+fL4cyLrnYknIF+30e8FuR5THIjSst1jpzZMBjV2N7SuU5MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dhFEfizv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5EA606A328
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dhFEfizv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685E41F000C6;
	Tue, 20 Oct 2026 07:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792481918;
	bh=LA5QNdOZLm3M8jVKLT4PzzX5K3Qa6HSIv6fGYEAHLFk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dhFEfizvT47XVK8fF7ENPUHYwKvGVVECyybUFC5g3kZ9yu8mbZusokp+YKzePNS2g
	 EaBVXC5HskgZJJ4XGiYNj9Q05llI7VIxUgvNVJ7l4j4cas1SgnbN6wqK60u8ZMMpxf
	 9lvUZRX+KvBrj7dgA1W6+9XmktiH9F4I3rIz+8aGLqwT8kxLDEXr7WI7RAoggHUkTt
	 6iXxNvfUvz5yy8A28k26GG+ocNr3h9ED8JimyqUNPS1BYJ075IamAPnCNea6Q8+gKU
	 XKzBjLMW/aDRqkFHGYcHr/ZbklfFtOpRjXjgkZFcRVK9hcgG2r+QHx7K9nMr2dQYDg
	 DUNbmYUCBGJBw==
Subject:
 Re: [PATCH net v6 2/2] selftests: net: add TAP socket filter attach tests
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn, willemb@google.com
Date: Tue, 20 Oct 2026 07:38:37 +0000
Message-ID: <179248191797.3135.12870508731761536700@kernel.org>
In-Reply-To: <20261016070654.170932-3-clementwei90@163.com>
References: <20261016070654.170932-3-clementwei90@163.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says attach_filter_bad_len_keeps_program()
  checks that "a rejected TUNATTACHFILTER leaves the installed program…

--

selftests: net: add TAP socket filter attach tests

This adds four TAP socket filter tests to the tun selftest. The first
re-attaches a queue after the user buffer holding the program is made
unreadable. The others cover attaching with IFF_NOFILTER, re-attaching
after TUNDETACHFILTER, and a TUNATTACHFILTER rejected for a bad length.

> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index afaa81c9bac53..a4993a6319572 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c

[ ... ]

> +/* A TUNATTACHFILTER with a bad length must leave the installed program and the
> + * filter state that TUNGETIFF reports alone.
> + */
> +TEST_F(tun, attach_filter_bad_len_keeps_program)
> +{
> +	struct sock_fprog gf = { 0 };
> +	struct ifreq ifr = { 0 };
> +	short flags = 0;
> +	int fd;
> +
> +	ASSERT_EQ(filter_attach(self->fd, filter_accept, ARRAY_SIZE(filter_accept)), 0);
> +
> +	errno = 0;
> +	EXPECT_EQ(filter_attach(self->fd, filter_accept, 0), -1);
> +	EXPECT_EQ(errno, EINVAL);

[Severity: Low]

The commit message says:

  attach_filter_bad_len_keeps_program() checks that a rejected
  TUNATTACHFILTER leaves the installed program and the filter state that
  TUNGETIFF reports alone, and that a queue attached afterwards still gets
  the filter.

Does the test cover that much? The only rejection it exercises is
len == 0. tun_copy_filter() rejects that case before it changes any state:

drivers/net/tun.c:tun_copy_filter() {
    ...
	if (!fprog.len || fprog.len > BPF_MAXINSNS)
		return -EINVAL;
    ...
}

Now take a valid length with instructions that are not a valid classic BPF
program. In that case tun_copy_filter() replaces the saved program before
anything validates it:

	kfree(tun->fprog_kern.filter);
	tun->fprog_kern.len = fprog.len;
	tun->fprog_kern.filter = insns;
	tun->fprog = fprog;

sk_attach_filter_kern() then fails on queue 0, so tun_attach_filter()
calls tun_detach_filter(tun, 0). That call detaches no sockets, but it
does:

	kfree(tun->fprog_kern.filter);
	tun->fprog_kern.filter = NULL;
	tun->fprog_kern.len = 0;
	tun->filter_attached = false;

So after this kind of rejection:

  - the existing queues keep the old sk_filter, so TUNGETIFF still shows
    IFF_NOFILTER clear
  - TUNGETFILTER copies tun->fprog, so it returns the rejected program's
    length, not ARRAY_SIZE(filter_accept)
  - a queue attached later with TUNSETIFF gets no filter, because
    filter_attached is false

Two of the three properties in the commit message don't hold on this
path, and no test covers it.

A related path is also untested. Suppose TUNATTACHFILTER with an invalid
program is issued while numqueues == 0. The loop in tun_attach_filter()
never runs, so the program is never validated, and filter_attached is set
to true. Every later drivers/net/tun.c:tun_attach() then fails with
-EINVAL from sk_attach_filter_kern().

This kernel behaviour was already there before this series, and the
companion kernel patch only claims to fix the bad header case. The test
name and its in-code comment are scoped to a bad length.

Could the changelog say "a TUNATTACHFILTER with a bad length" instead of
"a rejected TUNATTACHFILTER"? Alternatively, a case with a valid length and
invalid instructions could be added.

> +
> +	EXPECT_EQ(filter_get(self->fd, &gf), 0);
> +	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016070654.170932-1-clementwei90%40163.com
