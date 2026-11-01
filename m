Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793527961;
	b=B6SJgAhUDzmqREkakl89mtxnYxU3/rWqG8EDPQKWiErUh2YMNXfSeBxOI704ph6VvGTT
	 d2YhUoG8bJJH3mat4n/qQIXcshju/pgZ1oTfx1/gPbCTS+1kmPum61AGjYkA2sMK/RgAs
	 4/fwi9Bv+wDOxmsqHFo6MUwja1wBoRKjx03zrUpwMnY2sGzKU82EGy5P6NbIVDuEP8eVu
	 FFYvcJ50iTYc9beZAU1tcf5Kpmwvomxy1rRJJ9ka/pb89PWAkBqXDkGx2l7LOy8r7YWce
	 /U0VGnRRlv3LVtPcX0HIa53mmUDeyrKPrVHHUG9z5ox7X3jlkTRxvBGI8RsG8jI7I8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793527961;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HTLW8tmj5A5HFZX7dnGAygAmenFRCAi7MgeqYEGC+/Q=;
	b=vXg1Q5Cno480l/y6BxolJ5uBJa/E56ypH+NYtY9a/W532w2FZYh+O66JzSt4YcMfXNKX
	 iKC9s7ygHe3J7SCwxjNxSOqIvHfvXZJ/99jMVKIfkkXky0v/cIzt/eGfkCyeIQCr8m7B0
	 1UnI8uZsyM43hBppc/q/FUtLTVpgFDHMpnWCAbq70zWQRx/KkB5Tb87TEePzUEhC9sRoa
	 9ontDz7/Y5WLy0Ot+iaQi2VvqVEKyK9qUQk6cbmPDA3glhOY+dO4PzMmMj0UtBrKnDb11
	 zilSsgI7bVT6xqaZPLVgQpAQ4xD/YqmuEqIqgaeCZe7h4hE4PkpzsEXnawPT3dgypYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhyH8u8j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE60B606A32C
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhyH8u8j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BE31F00919;
	Sun,  1 Nov 2026 10:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793527960;
	bh=HTLW8tmj5A5HFZX7dnGAygAmenFRCAi7MgeqYEGC+/Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FhyH8u8jYBPVmhuOKX95IMPLda/F7CzbE79W+fbT0cDgmp4SYdeeW0hTWInrEDYJv
	 Q7xxDUVsUkwxYdWZArto4IwfdN8CBQnBxEZHedtgE6gvzudGbWWKV9UAOsOsUq8iOX
	 0jAc5t7pGMMdRboeEw72Hw0hTYQIswiiIG05yt1cyJYGMWey90pAWWugG6vCp0AP/Z
	 FE2CgiyISRrQz+qJaRaW79A67WH3AcG+lkelKgHmC1KfEP9chkuu7u9EoXw4ajMCiF
	 NYZHWsiyvrVMmrVCf3aymTDIR9pybSdXtj5zxBVdY6HQr8xzqefQgk/xHifEX9tIyc
	 yyZSh1t9cSlQw==
Subject:
 Re: [PATCH net v8 2/2] selftests: net: add TAP socket filter attach tests
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
Date: Sun, 01 Nov 2026 10:12:39 +0000
Message-ID: <179352795955.3131.2557505317650636828@kernel.org>
In-Reply-To: <20261028093235.148649-3-clementwei90@163.com>
References: <20261028093235.148649-3-clementwei90@163.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In the kernel commit "tun: keep a kernel copy of the socket
  filter program" (part of this series), the TUNATTACHFILTER case in…
- [Low] attach_filter_bad_prog_keeps_program() and
  attach_filter_bad_len_keeps_program() pass whether or not…
- [Low] In reattach_filter_without_user_buffer(), the comment says "The
  two checks below ... cannot tell a reinstalled filter from no filter:…

--

selftests: net: add TAP socket filter attach tests

This adds TAP selftests for TUNATTACHFILTER. One test reattaches a queue
after the user buffer holding the program has been made unreadable. Two
others check that a rejected program (bad length or bad instructions)
leaves the installed filter in place. The last two cover attaching a
queue without a filter, via IFF_NOFILTER or after TUNDETACHFILTER.

> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index 34de2580e32ec..3730fba859a46 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c

[ ... ]

> @@ -548,6 +550,253 @@ TEST_F(tun, reattach_close_delete)

[ ... ]

> +static int filter_get(int fd, struct sock_fprog *fp)
> +{
> +	return ioctl(fd, TUNGETFILTER, (void *)fp);
> +}

[Severity: Medium]
This is about the kernel side of this series ("tun: keep a kernel copy of
the socket filter program"), not this selftest. Can TUNGETFILTER now
return uninitialized kernel stack bytes to user space?

In __tun_chr_ioctl(), the TUNATTACHFILTER case declares fprog on the
stack without an initializer:

drivers/net/tun.c:__tun_chr_ioctl() {
    ...
	case TUNATTACHFILTER: {
		struct sock_fprog_kern fprog_kern;
		struct sock_fprog fprog;
    ...
		tun->fprog_kern = fprog_kern;
		tun->fprog = fprog;
    ...
}

tun_copy_filter() only writes the two named members:

	fprog->len = fp.len;
	fprog->filter = fp.filter;

struct sock_fprog is an unsigned short followed by a pointer. That leaves
6 bytes of padding on 64-bit (2 on 32-bit) that nothing writes.
TUNGETFILTER then copies the whole struct out:

		if (copy_to_user(argp, &tun->fprog, sizeof(tun->fprog)))

Before the series, tun->fprog was filled by copy_from_user() of the full
struct, so the padding came from user space.

Whether the padding really reaches tun->fprog depends on codegen, and
CONFIG_INIT_STACK_ALL_ZERO would hide it. Could fprog be zero-initialized,
or could tun_copy_filter() assign *fprog = fp instead?

The tests here zero gf before filter_get() and check only gf.len, so they
would not catch this.

[ ... ]

> +TEST_F(tun, reattach_filter_without_user_buffer)
> +{

[ ... ]

> +	ret = tun_attach(self->fd, self->ifname);
> +	EXPECT_EQ(ret, 0);
> +
> +	flags = tun_get_iff_flags(self->fd);
> +	EXPECT_GE(flags, 0);
> +	/* The queue is attached again, not left disabled */
> +	EXPECT_EQ(flags & IFF_DETACH_QUEUE, 0);
> +	EXPECT_EQ(flags & IFF_NOFILTER, 0);
> +
> +	/* The two checks below document the expected state, they cannot
> +	 * tell a reinstalled filter from no filter: tun_detach() leaves
> +	 * sk_filter alone, and TUNGETFILTER only returns the header.
> +	 */

[Severity: Low]
Is the first reason in this comment attached to the right check?

tun_detach() here uses TUNSETQUEUE with IFF_DETACH_QUEUE, which ends up
in __tun_detach(tfile, false). That path never calls sk_detach_filter(),
so the queue keeps its sk_filter while it is detached.

TUNGETIFF derives IFF_NOFILTER from the socket:

drivers/net/tun.c:__tun_chr_ioctl() {
    ...
		if (!tfile->socket.sk->sk_filter)
			ifr.ifr_flags |= IFF_NOFILTER;
    ...
}

So the IFF_NOFILTER check on self->fd just above this comment passes
whether or not tun_attach() reinstalled the program from fprog_kern.
"tun_detach() leaves sk_filter alone" explains that check, not the two
TUNGETFILTER checks below.

Could the comment be moved, or reworded, so that the IFF_NOFILTER check on
self->fd doesn't look like evidence of reinstallation? Only the
fresh-queue check later in the test actually shows that.

> +	EXPECT_EQ(filter_get(self->fd, &gf), 0);
> +	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));

[ ... ]

> +TEST_F(tun, attach_filter_bad_prog_keeps_program)
> +{
> +	struct sock_fprog gf = { 0 };
> +	struct sock_filter bad[] = {
> +		BPF_STMT(BPF_LD | BPF_W | BPF_LEN, 0),
> +		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0, 1, 0),
> +	};
> +	struct ifreq ifr = { 0 };
> +	short flags = 0;
> +	int fd;
> +
> +	ASSERT_EQ(filter_attach(self->fd, filter_accept,
> +				ARRAY_SIZE(filter_accept)), 0);
> +
> +	errno = 0;
> +	EXPECT_EQ(filter_attach(self->fd, bad, ARRAY_SIZE(bad)), -1);
> +	EXPECT_EQ(errno, EINVAL);

[Severity: Low]
Would this test, and attach_filter_bad_len_keeps_program() with len == 0,
still pass if the early validation in tun_copy_filter() were removed?

The fixture has two attached queues (self->fd and self->fd2). Without the
early !fp.len and bpf_prog_validate_classic() checks, tun_attach_filter()
would call sk_attach_filter_kern() on tfiles[0]. There bpf_prog_create()
rejects both len == 0 (bpf_check_basics_ok()) and this bad array
(bpf_check_classic()) with -EINVAL, before sk_filter is replaced.

With i == 0 the out_detach rollback does nothing, and the ioctl does not
update tun->fprog or tun->fprog_kern. So errno, gf.len and both
IFF_NOFILTER checks give the same result either way.

The early check only changes behaviour when tun->numqueues == 0, for
example after every queue has been detached with IFF_DETACH_QUEUE. In
that case the loop in tun_attach_filter() does not run. Without the
check, the bad program would be saved with filter_attached set, and
later attaches would fail.

Could a variant detach both queues before the bad TUNATTACHFILTER, so the
early rejection is actually covered? The partial-rollback path in
tun_attach_filter(), where a failure on queue k > 0 leaves queues 0..k-1
without a filter, is not exercised by any test either.

> +
> +	/* the program attached before is untouched */
> +	EXPECT_EQ(filter_get(self->fd, &gf), 0);
> +	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028093235.148649-1-clementwei90%40163.com
