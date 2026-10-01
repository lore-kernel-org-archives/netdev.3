Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52047547059
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863844; cv=none; b=TP1biAAiB8u7aVPwV0LMJqYJdQot1OlYbCiLKa/0zQXJK4SOHI8krzdCpoqBMHQnuy7C4c8FebO17HXVta1XUcUgfJjd6T8lTWvlII5Gf00akz/04ck0vMQc2fVKt0rMRpFsTPltVPF7PuLR31saw+HfufVQwjrrqAVdEUsvDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863844; c=relaxed/simple;
	bh=1TG17jYD5GW5VobdYeadcQg5ooV04bDVq/KMK35dl+Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MAr6bzXQM3g787O3gHd7eozNmNCpodyXR/QeSbD6RGlSgZWVF6Bc4qxzmdgMbUmbQq9nmaxNdRteP/bbc5bKJSMq7QmLUsi+F8xMjf4WLkNXIDDDiG+GQO7Hf3XlAp0XcwRoPQBSzKLqaKFRxW71p1prOSe/ixCeQ0AJWLq+KdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAFxBI7e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAFxBI7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE811F00899;
	Thu,  1 Oct 2026 14:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790863841;
	bh=8vzHb41mZEdAp5DbWbkvSwnbwctZrCDRcfCLG60sy1E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XAFxBI7eDX8COYd5HwKB9dfDw7cuWS4bnghl1auAc588HVMV16e9dAfdorS38NlCC
	 MbJJX3CbgfRiZRTfVcsSi3vqFwvmyMAPQt5QGLaTa5yMzXHeIN0f+jymbsfqFxYRas
	 6DwR4eszLeXb9KyZDSjvmmElzuWvw7SspeiLW3J+8cywPDXK7W+BvGTfEQqoEaJT9z
	 UaYlcD5aCsFE7aYOhObRDJMlcLrxjKOenFsJRympBu029pM9xnLZ/okpV8rVa15WHW
	 GmcJJYbyz7UWeEiSJkjUacAogYB6iWuffHngcJObB85y9nzdFPq3klOzEzbzwQ/Bmu
	 rckKf4ExnEosw==
Subject:
 Re: [PATCH net v3 3/3] selftests: net: add TAP socket filter attach tests
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
Date: Thu, 01 Oct 2026 14:10:41 +0000
Message-ID: <179086384103.434549.12914986963641941177@kernel.org>
In-Reply-To: <20260930080746.135017-4-clementwei90@163.com>
References: <20260930080746.135017-4-clementwei90@163.com>
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

- [Low] reattach_filter_without_user_buffer()
  (tools/testing/selftests/net/tun.c:603-631) never checks that…
- [Low] In attach_filter_bad_len_keeps_program()
  (tools/testing/selftests/net/tun.c:695-697), the final TUNGETIFF…
- [Low] In reattach_filter_without_user_buffer()
  (tools/testing/selftests/net/tun.c:614-627), only `ret == 0` actually…
- [Low] tun_copy_filter() (drivers/net/tun.c:730-752), added in commit
  "tun: keep a kernel copy of the socket filter program" within the…

--

selftests: net: add TAP socket filter attach tests

This adds four TAP selftests for TUNATTACHFILTER. They cover re-attaching
a queue after the user buffer holding the filter has been made unreadable,
attaching with IFF_NOFILTER, and re-attaching after TUNDETACHFILTER. They
also check that a TUNATTACHFILTER with a bad length leaves the saved
program alone.

> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index abe488bac50bb..6f6023b16d1cc 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c

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
> +
> +	ret = tun_attach(self->fd, self->ifname);
> +	EXPECT_EQ(ret, 0);
> +
> +	flags = tun_get_iff_flags(self->fd);
> +	EXPECT_GE(flags, 0);
> +	EXPECT_EQ(flags & IFF_NOFILTER, 0);

[Severity: Low]
Would this test catch the bug fixed earlier in this series by "tun: fix
inverted error check when re-attaching the filter"?

Take a kernel that has the kernel copy patch but still has the old check
in tun_attach():

	err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
	...
	if (!err)
		goto out;

There, sk_attach_filter_kern() succeeds and tun_attach() returns 0 through
goto out. tun_enable_queue() never runs, tun->tfiles[] is not published,
numqueues is not incremented, and tfile->detached stays set.

Every assertion here still passes in that case:

- ret is 0.
- TUNGETIFF works because the non-clean __tun_detach() leaves tfile->tun
  set.
- IFF_NOFILTER is clear because sk_filter is still installed.
- gf.len reads the unchanged tun->fprog.

TUNGETIFF already reports the detached state:

	if (tfile->detached)
		ifr.ifr_flags |= IFF_DETACH_QUEUE;

Could EXPECT_EQ(flags & IFF_DETACH_QUEUE, 0) be added here? That would
give the inverted check fix some regression coverage.

> +
> +	EXPECT_EQ(filter_get(self->fd, &gf), 0);
> +	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));

[Severity: Low]
Do the IFF_NOFILTER and gf.len checks actually see whether the kernel copy
was installed again?

tun_detach() here uses IFF_DETACH_QUEUE, which goes through
__tun_detach(tfile, false). That path only does this:

	} else {
		tun_disable_queue(tun, tfile);
		tun_napi_disable(tfile);
	}

It never calls sk_detach_filter(), so the socket keeps the sk_filter from
the first TUNATTACHFILTER. That means IFF_NOFILTER stays clear whether or
not this block in tun_attach() ran again:

	if (!skip_filter && (tun->filter_attached == true)) {
		lock_sock(tfile->socket.sk);
		err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);

TUNGETFILTER copies tun->fprog, and only tun_copy_filter() writes that. So
gf.len doesn't depend on the re-attach either.

If filter_attached were ignored, or the re-install block were dropped, the
ret == 0 check would be the only one still testing anything. The comment
above the test talks about a queue from a process that "does not
necessarily map the buffer", but the test never exercises that path.

Would it be more convincing to open a new queue after the
mprotect(PROT_NONE)? For example, open /dev/net/tun and call TUNSETIFF
without IFF_NOFILTER. That socket starts with no sk_filter, so a clear
IFF_NOFILTER would show that the kernel copy was installed.

> +
> +	ASSERT_EQ(mprotect(prog, getpagesize(), PROT_READ | PROT_WRITE), 0);
> +	ASSERT_EQ(munmap(prog, getpagesize()), 0);
> +}

[ ... ]

> +TEST_F(tun, attach_filter_bad_len_keeps_program)
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
> +	flags = tun_get_iff_flags(self->fd);
> +	EXPECT_GE(flags, 0);
> +	EXPECT_EQ(flags & IFF_NOFILTER, 0);

[Severity: Low]
Can this IFF_NOFILTER check detect the state this test is meant to
protect?

TUNGETIFF derives IFF_NOFILTER only from the per-socket filter:

	if (!tfile->socket.sk->sk_filter)
		ifr.ifr_flags |= IFF_NOFILTER;

self->fd is tfiles[0]. Some rejections happen before any socket is
touched: the len check in tun_copy_filter(), or a failure of the first
sk_attach_filter_kern() in tun_attach_filter() followed by
tun_detach_filter(tun, 0). Neither removes the sk_filter of self->fd.

With n == 0, tun_detach_filter() touches no socket, but it still does
this:

	kfree(tun->fprog_kern.filter);
	tun->fprog_kern.filter = NULL;
	tun->fprog_kern.len = 0;
	tun->filter_attached = false;

That state only matters for a queue attached later, and the test never
attaches another queue. TUNGETFILTER reads tun->fprog, not
tun->fprog_kern, so gf.len doesn't cover it either.

On the pre-series baseline, len == 0 overwrote tun->fprog and cleared
filter_attached, and this IFF_NOFILTER assertion still passed there. Only
the gf.len check caught it.

A failure on a later queue does detach tfiles[0] and the queues before it.
The rejections this test exercises can't reach that case, though.

Would re-attaching a queue, or opening a new one, after the failed ioctl
and then checking IFF_NOFILTER show that filter_attached and fprog_kern
were preserved?

> +}

[ ... ]

[Severity: Low]
One more question about the series. This one is about tun_copy_filter(),
added by "tun: keep a kernel copy of the socket filter program" rather
than by this patch:

drivers/net/tun.c:tun_copy_filter() {
	...
	insns = memdup_array_user(fprog.filter, fprog.len,
				  sizeof(struct sock_filter));
	...
}

Should this copy be charged to the caller's memory cgroup?

memdup_array_user() goes through memdup_user(), which allocates with
GFP_USER | __GFP_NOWARN and no __GFP_ACCOUNT. The buffer can be up to
BPF_MAXINSNS * sizeof(struct sock_filter), which is 32 KiB. It is freed
only by tun_detach_filter() or tun_free_netdev(), so it can live as long
as the device.

The netdev and bpf_prog allocations are memcg accounted, but this one is
not. A user with CAP_NET_ADMIN in a user namespace could create many
persistent TAP devices, and each one could pin up to 32 KiB of unaccounted
slab.

Would kmalloc_array(..., GFP_KERNEL_ACCOUNT) plus copy_from_user() close
the gap? There is precedent for unaccounted classic filter copies in
net/core, since bpf_prog_store_orig_filter() uses GFP_KERNEL, so this is
only a minor inconsistency.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930080746.135017-1-clementwei90%40163.com
