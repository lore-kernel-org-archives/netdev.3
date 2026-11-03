Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793686880;
	b=R43OX5eR5Kuw6clI9sTXqKF/zAJwM4bLJHdlIqu1SG/Q7wj/JpnexBy9gCdw71HdXor2
	 F8g5OmiHV8NG7TrS/jQfgev97IOiFDqwn0Yfv8iSfwttqOYPKxCGglveeEz+y2VXwIDlf
	 TsdRFKBBj58KmFahpeAJMTnHVyTP83Fu3LsfTQyMyLDc3mpSwl9TfbV9GkoLcC3xORGcu
	 EGFzfGM+Rsi8jwWoRitWhiIwFsDAFNIFPeKhafmsQmhyBnAsc/rIiMCXmmR23wiRMN5jR
	 Ma8n1FtNjOXtclLk/mP22Em/0nWe5a1hUfCJtZJo7TWpWe6+YlBWd86fcE+oHpo/kKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793686880;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Dog9q4g48AkCNCojwOcEK7M9FOfotE2But6QLcgKBhI=;
	b=i42V0b4LrtUtycEepUlKKUPa/tU8qBB19Jj1TeADF3gMeG9YGVvp00bYMkB2zSwgiIJl
	 pvhtymuwcrMcv8ObQVqacU6KPiz9hTl+JL7Rdqc5WxZfpkZAziraVtzN1+npn2tT/m9wm
	 J0T0HXvH+kVRHZiM6yOHf1qxDdyqMZ43gfgZ9yhAEiV35wuqFHqx50SIOEhRYcLRkOf14
	 v+A574q/c5FegFPkliZDQUZqtqgC2795wbIN9K5TcSXMM5MttFqX3a/DFJG56T0oSO8cz
	 tx6pQyGOGFjMkl/f0Cw1Ekad1NRrWSFt9ljtVYJSAARULd4HZR5WKsoQbhFibWf5XMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuCuGf9W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC36606D80D
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuCuGf9W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BEE1F0093A;
	Tue,  3 Nov 2026 06:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793686879;
	bh=Dog9q4g48AkCNCojwOcEK7M9FOfotE2But6QLcgKBhI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kuCuGf9W1JEB54WQ9mtYhQSA/xdN2KviWW36qgomn26UZ4pJHKqLeyEpQaDcm/JB1
	 +Tc8YvfHRyGau53amzJhnZLZE77si+HYpl/C7IMCCYCDNcKPnp/tplTB6tHMrnrB3Y
	 hmdq3XzeMUmF6ZPqdbUVzwbo9ANyY3x/LtBFHR0uNTUtK4CTxnqyUagkib8trZXcPL
	 R4GaLkDMGzfBV61S42u71aA60ugpZ84gH2kw9lT+yzKzbBjGz+gjRKV9cXUFJC1hGY
	 RfvC7ER0azBufFZbBfyLDMXofBePDfUINZOfTI/Evlq7OGj8BRhYjSTA7+nnvZE/4/
	 XSb+dfVgmKwUQ==
Subject:
 Re: [PATCH net v9 2/2] selftests: net: add TAP socket filter attach tests
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
Date: Tue, 03 Nov 2026 06:21:18 +0000
Message-ID: <179368687880.488856.3347749710559988882@kernel.org>
In-Reply-To: <20261030060043.94719-3-clementwei90@163.com>
References: <20261030060043.94719-3-clementwei90@163.com>
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

- [Low] The two new negative tests, attach_filter_bad_len_keeps_program()
  and attach_filter_bad_prog_keeps_program() in…
- [Low] The header comment of reattach_filter_without_user_buffer() in
  tools/testing/selftests/net/tun.c says 'a second queue is then…

--

selftests: net: add TAP socket filter attach tests

This adds TUNATTACHFILTER selftests to tools/testing/selftests/net/tun.c.
One reattaches a queue after the user buffer holding the program has been
made unreadable. Others check that IFF_NOFILTER and TUNDETACHFILTER keep a
filter off later queues, and that a bad length or bad instructions are
refused without touching the installed program.

> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index 34de2580e32ec..3730fba859a46 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c

[ ... ]

> @@ -548,6 +550,253 @@ TEST_F(tun, reattach_close_delete)

[ ... ]

> +/*
> + * A queue can be attached long after the filter was configured, from a
> + * process that does not necessarily map the buffer the program was copied
> + * from, so the kernel has to keep its own copy of the program.  Here the
> + * mapping is made unreadable before the queue is attached again, and a
> + * second queue is then attached from a fresh socket, which starts without a
> + * filter of its own.
> + */

[Severity: Low]
This isn't a bug, but is this really the second queue? FIXTURE_SETUP(tun)
has already attached self->fd and self->fd2:

    self->fd = tun_alloc(self->ifname);
    ...
    self->fd2 = tun_alloc(self->ifname);

That makes the fd that this test opens and attaches with TUNSETIFF the third
queue. The commit message uses the same wording:

  "It then attaches a second queue from a fresh socket, which starts
  without a filter of its own"

> +TEST_F(tun, reattach_filter_without_user_buffer)
> +{

[ ... ]

> +/* A TUNATTACHFILTER with instructions that bpf_check_classic() rejects must
> + * be refused, and must leave the program installed already in place.
> + */
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
This test and attach_filter_bad_len_keeps_program() both send the bad
ioctl while the two queues from FIXTURE_SETUP(tun) are still attached, so
numqueues is 2.

Would both tests still pass if the early checks in tun_copy_filter() were
removed?

drivers/net/tun.c:tun_copy_filter() {
    ...
	if (!fp.len || fp.len > BPF_MAXINSNS)
		return -EINVAL;
    ...
	err = bpf_prog_validate_classic(insns, fp.len);
    ...
}

Without those checks, tun_attach_filter() would call
sk_attach_filter_kern() on queue 0. bpf_prog_create() rejects len 0 in
bpf_check_basics_ok(). It rejects the bad jump program in
bpf_check_classic(), called from bpf_prepare_filter().

Both paths return -EINVAL before queue 0's sk_filter is changed. The
while (i--) rollback does nothing, and the saved program is not replaced.
So the tests would still see EINVAL, gf.len == 3, a clear IFF_NOFILTER, and
the new queue still getting the filter.

The early check only changes the result when tun->numqueues == 0. A queue
detached with TUNSETQUEUE/IFF_DETACH_QUEUE keeps tfile->tun, because
__tun_detach() only clears it when clean is true. TUNATTACHFILTER therefore
still reaches tun_attach_filter(), where the loop never runs:

	for (i = 0; i < tun->numqueues; i++) {
		...
	}

	tun->filter_attached = true;
	return 0;

Without the early check, the bad program would be saved there. The next
queue attach would then fail in sk_attach_filter_kern().

Could a variant be added that detaches both self->fd and self->fd2 first?
It would expect the bad TUNATTACHFILTER to fail with EINVAL, then reattach
and check that the old filter is installed again. That would test the
"refused before it is saved and before any queue is touched" behaviour that
the tun_copy_filter() comment describes.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030060043.94719-1-clementwei90%40163.com
