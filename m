Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E6241D104
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829554; cv=none; b=J2Vbw0nsUvT8luPHd0UvKCm++Wr66G71kMKjNoRYHqz37FmcN7/Ts4ngRFFK2g9ehHM8AD3zRwHYQWAu6hYRgoMsfVv/YE9Gs+DW2pxzo5ViTH12NbtE9EWWrzIJQ2HhEEUXtWp/5HWrKQyyRO4/IqS2FazTZ52eupvx53d+OaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829554; c=relaxed/simple;
	bh=hpHNjBrAqkX22wdQinvM8DxgwcUcdoy7Sy9fQMrzGjk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E/Tq5NfqySx4kDVpf8JiVtzT0a4hl0Et9ihWMPyCrwqiRCr3+Xqmap3bCnXoYd4YVYodezvewQy9PoOgJevAkaqA7RNYNY/JTzozk4CVmHo+1yalsPHnppctvdQTXX1Jof7zbnXGpcglNGzhQNWpIVlKuTkaiTqBoLsEea0V9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFN+f+Q2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFN+f+Q2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89401F000FF;
	Thu,  1 Oct 2026 04:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790829552;
	bh=uJJq6bJzJhtNafeYK+CkhJ6HffmO4GluoeRIzK7g87c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JFN+f+Q2YkMaCuFjaZjT2w+5/iK4lSQq1Mn+cE5UE0fJr3i2NCPFAboh8L6O/upa8
	 Q11vOBf6zuUMnHmsmJs4bgxPsy/TbNAyCXeQACYd0wSkKxQGwLbQC9NOJQjcexmUzw
	 6zenfgRNTOG5Dee0NQAn7GKh5WOl+U81N7bak1VUbF432SpVpNHIwTb5Zew3et5BI7
	 XlqV6TZENXlJWMgzmWSDWyiIUEQQ9lAM+DToE5GEfnm8Ah0/iT24dIrIgx1sENT4xB
	 5VzBd5//8rRuf4DxADrczQWEE4KUteLhtudMFt1nX6FWS2ivW5D9eTqe2oInfV+13y
	 NQ+pFlTofxWLg==
Subject: Re: [PATCH v2 4/4] selftests: net: add TAP socket filter attach tests
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
Date: Thu, 01 Oct 2026 04:39:11 +0000
Message-ID: <179082955141.434549.14113436592858907489@kernel.org>
In-Reply-To: <20260929093712.131096-5-clementwei90@163.com>
References: <20260929093712.131096-5-clementwei90@163.com>
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
  (tools/testing/selftests/net/tun.c:614-641), only the tun_attach()…
- [Low] attach_filter_bad_len_keeps_descriptor() only checks "the
  installed filter" through IFF_NOFILTER on self->fd…
- [Low] attach_filter_nofilter_flag()
  (tools/testing/selftests/net/tun.c:646-665) only checks that a queue…
- [Low] In reattach_filter_without_user_buffer() the inline comment at
  tools/testing/selftests/net/tun.c:627 says "The process that called…

--

selftests: net: add TAP socket filter attach tests

This adds four TAP selftests to tools/testing/selftests/net/tun.c for
TUNATTACHFILTER handling. They cover four cases:

- re-attaching a queue after the user buffer that held the filter is
  made unreadable
- attaching a queue with IFF_NOFILTER
- attaching a queue after TUNDETACHFILTER
- rejecting a zero-length filter

> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index abe488bac50bb..bf8d4d6f21f77 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c

[ ... ]

> @@ -542,6 +548,159 @@ TEST_F(tun, reattach_close_delete)

[ ... ]

> +TEST_F(tun, reattach_filter_without_user_buffer)
> +{
> +	struct sock_fprog gf = { 0 };
> +	short flags = 0;
> +	void *prog;
> +	int ret;
> +
> +	prog = filter_alloc(filter_accept, ARRAY_SIZE(filter_accept));
> +	ASSERT_NE(prog, NULL);
> +	ASSERT_EQ(filter_attach(self->fd, prog, ARRAY_SIZE(filter_accept)), 0);
> +
> +	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
> +
> +	/* The process that called TUNATTACHFILTER no longer maps this memory */
> +	ASSERT_EQ(mprotect(prog, getpagesize(), PROT_NONE), 0);

[Severity: Low]
This isn't a bug, but is this comment accurate? mprotect(PROT_NONE) makes
the page unreadable, but it stays mapped. It is only unmapped at the end of
the test by munmap().

The header comment above the test says the mapping is "made unreadable",
which matches the code.

copy_from_user() faults the same way in both cases, so the test still works.

> +
> +	ret = tun_attach(self->fd, self->ifname);
> +	EXPECT_EQ(ret, 0);
> +
> +	EXPECT_EQ(tap_get_iff(self->fd, &flags), 0);
> +	EXPECT_EQ(flags & IFF_NOFILTER, 0);
> +
> +	EXPECT_EQ(filter_get(self->fd, &gf), 0);
> +	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));

[Severity: Low]
Can these last two checks tell whether tun_attach() actually re-installed
the filter?

The tun_detach() helper uses TUNSETQUEUE with IFF_DETACH_QUEUE, which ends
up in __tun_detach(tfile, false). That path disables the queue but never
calls sk_detach_filter(). The socket therefore keeps the filter from the
first TUNATTACHFILTER:

drivers/net/tun.c:__tun_detach() {
    ...
		} else {
			tun_disable_queue(tun, tfile);
			tun_napi_disable(tfile);
		}
    ...
}

TUNGETIFF reports IFF_NOFILTER only when sk_filter is NULL:

drivers/net/tun.c:__tun_chr_ioctl() {
    ...
		if (!tfile->socket.sk->sk_filter)
			ifr.ifr_flags |= IFF_NOFILTER;
    ...
}

So the IFF_NOFILTER check passes whether or not this block in tun_attach()
ran:

drivers/net/tun.c:tun_attach() {
    ...
	if (!skip_filter && (tun->filter_attached == true)) {
		lock_sock(tfile->socket.sk);
		err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
    ...
}

TUNGETFILTER returns tun->fprog, which is the saved user descriptor, not
fprog_kern:

drivers/net/tun.c:__tun_chr_ioctl() {
    ...
	case TUNGETFILTER:
    ...
		if (copy_to_user(argp, &tun->fprog, sizeof(tun->fprog)))
    ...
}

So gf.len == 3 doesn't show which instructions the queue is running.

Only the ret == 0 check can tell a fixed kernel from a broken one. If the
re-install block were skipped, or filter_attached were wrongly false, the
rest of the test would still pass.

The comment describes a queue "attached long after the filter was
configured". The test, however, reuses a queue that already has a filter.

Could the test also attach a new queue with TUNSETIFF and without
IFF_NOFILTER? On that queue, fprog_kern is the only source of the filter.

It could also overwrite the still-readable buffer, for example with
filter_drop. That would cover the other hazard described in "tun: keep a
kernel copy of the socket filter program".

> +
> +	ASSERT_EQ(mprotect(prog, getpagesize(), PROT_READ | PROT_WRITE), 0);
> +	ASSERT_EQ(munmap(prog, getpagesize()), 0);
> +}
> +
> +/* A new queue attached with IFF_NOFILTER must not get the filter that is
> + * configured on the device.
> + */
> +TEST_F(tun, attach_filter_nofilter_flag)
> +{
> +	struct ifreq ifr = { 0 };
> +	short flags = 0;
> +	int fd;
> +
> +	ASSERT_EQ(filter_attach(self->fd, filter_drop, ARRAY_SIZE(filter_drop)), 0);
> +
> +	fd = open("/dev/net/tun", O_RDWR);
> +	ASSERT_GE(fd, 0);
> +
> +	strcpy(ifr.ifr_name, self->ifname);
> +	ifr.ifr_flags = IFF_TAP | IFF_MULTI_QUEUE | IFF_NOFILTER;
> +	EXPECT_GE(ioctl(fd, TUNSETIFF, (void *)&ifr), 0);
> +
> +	EXPECT_EQ(tap_get_iff(fd, &flags), 0);
> +	EXPECT_NE(flags & IFF_NOFILTER, 0);

[Severity: Low]
Is there a positive control for this test? tun_set_iff() passes the
IFF_NOFILTER bit to tun_attach() as skip_filter:

drivers/net/tun.c:tun_set_iff() {
    ...
		err = tun_attach(tun, file, ifr->ifr_flags & IFF_NOFILTER,
    ...
}

None of the new tests opens a new queue with TUNSETIFF and without
IFF_NOFILTER after TUNATTACHFILTER, then checks that the device filter is
installed on it. Both fixture queues are created in FIXTURE_SETUP, before
any filter exists.

Suppose filter_attached were never set, or the re-install branch in
tun_attach() never ran. The new socket here would have no filter, and this
check would still pass.

Would it help to also open a queue without IFF_NOFILTER and check that
IFF_NOFILTER is clear on it?

> +
> +	close(fd);
> +}

[ ... ]

> +/* A TUNATTACHFILTER with a bad length must not clobber the saved descriptor */
> +TEST_F(tun, attach_filter_bad_len_keeps_descriptor)
> +{
> +	struct sock_fprog gf = { 0 };
> +	short flags = 0;
> +
> +	ASSERT_EQ(filter_attach(self->fd, filter_accept, ARRAY_SIZE(filter_accept)), 0);
> +
> +	errno = 0;
> +	EXPECT_EQ(filter_attach(self->fd, filter_accept, 0), -1);
> +	EXPECT_EQ(errno, EINVAL);
> +
> +	EXPECT_EQ(filter_get(self->fd, &gf), 0);
> +	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));
> +
> +	EXPECT_EQ(tap_get_iff(self->fd, &flags), 0);
> +	EXPECT_EQ(flags & IFF_NOFILTER, 0);

[Severity: Low]
The commit message says this test checks that a rejected TUNATTACHFILTER
"leaves both the saved descriptor and the installed filter alone". Can this
IFF_NOFILTER check detect a lost filter?

The check reads sk_filter on self->fd. A failed attach on queue 0 never
touches sk_filter, even on the kernel before this series.

In the old code, len=0 was copied into tun->fprog. tun_attach_filter() then
failed at i=0. tun_detach_filter(tun, 0) detached no sockets, but it still
cleared the device state:

drivers/net/tun.c:tun_detach_filter() {
    ...
	tun->filter_attached = false;
}

The socket kept its filter, so this check passed even though the device had
silently lost its re-attach state. On the old kernel, only the gf.len check
fails.

tun_attach() reads tun->filter_attached and tun->fprog_kern on later
attaches. The test never attaches a queue again after the failed ioctl.

A regression could clear filter_attached or free fprog_kern before the
length check while keeping tun->fprog. That regression would pass this test.

Could the test detach and re-attach the queue (or add a new one) after the
failed TUNATTACHFILTER, then check IFF_NOFILTER? That would show the
installed filter is really kept.

> +}
> +
>  FIXTURE(tun_vnet_udptnl)
>  {
>  	char ifname[IFNAMSIZ];

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929093712.131096-1-clementwei90%40163.com
