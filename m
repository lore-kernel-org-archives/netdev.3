Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793095786;
	b=po9j01HP1gmil1pdxykeQdN724c3IbtOTpDSrOvKI3k17pwVALSL4tWHUzv9tNaMi9sX
	 VT6bxWH3cNP85Bg6V9cRfk6SJdvJ4dHEsLJB1lCIB+minTtOtQ7S+Hn98LC2dMY6Vgoio
	 ge6liKAr5UCbuDFgQuFjGC2HTUWt+PXK+YNNeM8X+dMqQLNiKgiVVX8qaFQ3GlXHYaOka
	 C14czppSXQ/v5ThEb0UiyneYCobCraQjQAlOLwdGV5+ZIlLl1XoWKiWmn8DMDcDsQpeAp
	 KKa7lIeFfohUd1XbTWP+qsRJXqmwg61ATBR33WDFsY0Z6Oj4IgUyvwgjnPElBbFazYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095786;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=b26OYap8wcpZedHehtZhYc4BtQG61HKsHDgo/OqkQeo=;
	b=EtsugwuPpyy0C4kNAeOzzjJKOrNyc2l1zr+BbC9Xg6TW4y/dh3VKX6fvN0sUe7r45GlN
	 0oX7n9bpKWWGb3QjSvBlVeTAJIVBCb69bgwAh5MMOaQUKv3q+xsDZc6sFKfoD8u1/BAi6
	 ny3MJIHXtjmA4HftYI1si2soRkBoTDG8gWr6BrR10Zcuq8Ge6hw9LY0Uu0diiGZxpuhiH
	 qKRM9fxbvtq3OM3+F7GgLfKwEINYPhvbpo5OEtaQESAj/O0rbTeT4iF8XcfDWY0pKRuof
	 FWCK9wM9+bLu/I4qpJJX4FJveS5X+Iv1ShEj9DKjGmw7UwWvgwHuqBqlpt+wSJtpLhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARVbcb9U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF8C606A322
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARVbcb9U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904AF1F01828;
	Tue, 27 Oct 2026 10:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793095786;
	bh=b26OYap8wcpZedHehtZhYc4BtQG61HKsHDgo/OqkQeo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ARVbcb9UjhkseDnNbdpIq8AxcLZiTLFNXtgfEPIcOV442hZa9zb38TuopZxZP9z/M
	 3nJi4qN1ww7Jry3cW0XL6ChjyOglvvvCGNp62NL4J2InPSWrdtwZtKSmavtBA4D3A0
	 xghkQPctjIUXoW9qNb3tWMEKI/6jhLcZbAIgSIl0WjKBD8UecrRa30MVo7GE/lnSS2
	 Eey0H/h98hF6evQTcvbB/mGMq7sLXwvuGCLhmw1LWmOcx0HJ7hCuvMLITWcq9mvbsN
	 VMmtd3ZjRUCe2CrQkHR4xpOeDar/J2r/6d0IHBEmKPdQwgqZEkb5TfFpbeRCvpOESv
	 gxkQMp/5ELz9A==
Subject:
 Re: [PATCH net v7 2/2] selftests: net: add TAP socket filter attach tests
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
Date: Tue, 27 Oct 2026 10:09:45 +0000
Message-ID: <179309578517.3134.15519175332486935982@kernel.org>
In-Reply-To: <20261023092239.186665-3-clementwei90@163.com>
References: <20261023092239.186665-3-clementwei90@163.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] attach_filter_bad_prog_keeps_program() in
  tools/testing/selftests/net/tun.c says a refused program "must leave…

--

selftests: net: add TAP socket filter attach tests

This commit adds five TAP socket filter tests to
tools/testing/selftests/net/tun.c. They cover reinstalling the filter
from the kernel copy after the user buffer is made unreadable, attaching
queues with IFF_NOFILTER or after TUNDETACHFILTER, and TUNATTACHFILTER
calls rejected for a bad length or for bad instructions.

> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index afaa81c9bac53..1efff537dbae9 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c

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
> +
> +	ASSERT_EQ(filter_attach(self->fd, filter_accept,
> +				ARRAY_SIZE(filter_accept)), 0);
> +
> +	errno = 0;
> +	EXPECT_EQ(filter_attach(self->fd, bad, ARRAY_SIZE(bad)), -1);
> +	EXPECT_EQ(errno, EINVAL);
> +
> +	/* the program attached before is untouched */
> +	EXPECT_EQ(filter_get(self->fd, &gf), 0);
> +	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));

[Severity: Medium]
Can this check tell whether the earlier program is still installed?

TUNGETFILTER in __tun_chr_ioctl() only copies out the saved header:

drivers/net/tun.c:__tun_chr_ioctl() {
    ...
	case TUNGETFILTER:
		...
		if (copy_to_user(argp, &tun->fprog, sizeof(tun->fprog)))
    ...
}

tun_detach_filter() is also the failure path of tun_attach_filter(). It
drops every queue's sk_filter, frees fprog_kern and clears
filter_attached, but it never touches tun->fprog:

drivers/net/tun.c:tun_detach_filter() {
	for (i = 0; i < n; i++) {
		...
		sk_detach_filter(tfile->socket.sk);
		...
	}

	kfree(tun->fprog_kern.filter);
	tun->fprog_kern.filter = NULL;
	tun->fprog_kern.len = 0;
	tun->filter_attached = false;
}

Suppose a later change made the bad program path go through
tun_detach_filter(), for example by validating after the attach and
rolling back with tun_detach_filter(tun, tun->numqueues). gf.len would
still be 3 and this test would pass. Meanwhile the queues would have lost
their filter, and queues attached later would come up without one.

The current kernel passes for the right reason. tun_copy_filter() calls
bpf_prog_validate_classic() before it changes any tun state. The test
just can't catch a regression in the behaviour it says it covers.

attach_filter_bad_len_keeps_program() handles this by checking
IFF_NOFILTER through TUNGETIFF on self->fd. It also attaches a fresh
TUNSETIFF queue and checks that the new queue gets the filter. Could the
same checks be added here, so that the test verifies what the commit
message describes?

  "checks that the program installed before is left in place"

The comment in reattach_filter_without_user_buffer() makes the same point
about this ioctl: "TUNGETFILTER only returns the header".

> +}
> +
>  FIXTURE(tun_vnet_gso)
>  {
>  	char ifname[IFNAMSIZ];

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023092239.186665-1-clementwei90%40163.com
