Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793527960;
	b=MhdT2EMpcZBw3SCJ/Y5g7eORlDRjwcA0ZK1DLfdsoOuoQdT8l5RvWyINEM5rm100sF6O
	 jb/AzUhfRvbr1uYir3U6nmQ0y6ZvrVGRCyMFpaASPaNoGwK5ZWcHbEIgaB8/AESXudG0d
	 ffbUc9RImQkJ6x8uCntO9obb6N28AcMPlBi+V/eH5UHi0wCqK+HlVLXh/FGj/5wY4Tx81
	 kODHQjxyTPUqEvc2p5notylLHuchq5uEluISDJTXaImbVMwH+d90tQUSoePfQzoCBPN8y
	 MeqQkZyVE28fbRETImydSLX0vE7dGIzp50y2a24hhP59RAh+bzediWws0ZShI3RatQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793527960;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CC43DLmPptX8Oq9Kv9/UnuC+1jnQ74dPMLE+WQWW8u0=;
	b=2nfYJUEbaACDVg4NnMZN90ChUQzvY26iJh3olh1AstFLC2Gh7NPoNCpqjSz4ef3oXVSg
	 uaZL6mk4SvInH3v43VV2/55p4RbTpkqcPA29dFIfa4MEkT8oC++Syz5jjnZ/T1iChC5Wb
	 n0fBJZJM1Q+zfBR2VjeZfvMKql1yPnIXFH4Kiy/elGj2YFoGfV2we5suTB+dayUIYVWAD
	 9ZtlpwAjD22I6zKEpakUITBcIZLf0tbKKAhPhiB/MvkPkT3NX7T2RZ6fIeuawr/qZDUNy
	 0X7ayFbrmWJHfeL7lkr8tM3hzra8eoDsO7/DFFuUTIJkNpRf8YOM2K0U+XsA2iZXGgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJQYAGRB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18AD606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJQYAGRB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EFC1F000C1;
	Sun,  1 Nov 2026 10:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793527959;
	bh=CC43DLmPptX8Oq9Kv9/UnuC+1jnQ74dPMLE+WQWW8u0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EJQYAGRBZDNgFScmqN/y3D2o7Mi7JMi24kkSzdapYGcf0cLx/K6szN3W2qO7tnmsP
	 3+87H18nZ0KcI2oFDBYEM2afLptyxIjLf11WyiclLMyA5u+6VVN18CWCON3mlVSUni
	 p5pg9hsMajox+QbdRUUvJLYWj5nXe4XbbGVeNaj1EJaMbmIBSuUiDnjhtR+dFUdhdm
	 3R7nLkfyve8GxsSXKKnkMdzP5GfLgQ/1RZ/UkjceSwhIs0MYDVJKA2brEcfttNDbPQ
	 sMiYWTsHzP9KABpKrrhB8BqfAOOFrXtsBXFVrKkiiPK+W8Dl7qMK8JWkblu7MBwW4s
	 1pHeKdioGSCaw==
Subject:
 Re: [PATCH net v8 1/2] tun: keep a kernel copy of the socket filter program
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
Date: Sun, 01 Nov 2026 10:12:38 +0000
Message-ID: <179352795853.3131.17682057808307044265@kernel.org>
In-Reply-To: <20261028093235.148649-2-clementwei90@163.com>
References: <20261028093235.148649-2-clementwei90@163.com>
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

Critical: 0 · High: 0 · Medium: 3 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] If the device has no active queues, TUNATTACHFILTER saves a
  program that has never been built.
- [Medium] If TUNATTACHFILTER fails part-way, the device's filter record
  no longer matches what its queues enforce.
- [Medium] TUNATTACHFILTER now fills tun->fprog from an uninitialized
  stack variable.

Pre-existing issues:
- [Medium] Disabled (detached) queues keep their own sk_filter when
  TUNDETACHFILTER runs.

--

tun: keep a kernel copy of the socket filter program

This commit makes TUNATTACHFILTER keep a kernel copy of the classic BPF
program in tun->fprog_kern. Each queue now gets its program from that copy
through a new sk_attach_filter_kern() helper, and the user pointer is no
longer read again. It also fixes the inverted error check in tun_attach()
and checks the program early with a new bpf_prog_validate_classic() helper.

Link: https://lore.kernel.org/netdev/179309578401.3134.11519975030981154705@kernel.org/

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 439565a264ee7..ea6743e8ae600 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -726,12 +727,67 @@ static void tun_force_wake_queue(struct tun_struct *tun,

[ ... ]

> +	err = bpf_prog_validate_classic(insns, fp.len);
> +	if (err) {
> +		kfree(insns);
> +		return err;
> +	}
> +
> +	fprog->len = fp.len;
> +	fprog->filter = fp.filter;

[Severity: Medium]
Can this leak kernel stack bytes through TUNGETFILTER?

In __tun_chr_ioctl(), the caller's struct sock_fprog is a stack variable
with no initializer:

	case TUNATTACHFILTER: {
		struct sock_fprog_kern fprog_kern;
		struct sock_fprog fprog;

Only len and filter are written here. The padding between the unsigned
short len and the filter pointer (6 bytes on 64-bit) is never set.

The ioctl then copies the whole struct into device state with
tun->fprog = fprog, and TUNGETFILTER copies all of it back to user space:

	if (copy_to_user(argp, &tun->fprog, sizeof(tun->fprog)))

Before this patch, copy_from_user() filled every byte of tun->fprog.

Would using *fprog = fp; here, or initializing fprog with {} in the ioctl,
avoid this?

> +	fprog_kern->len = fp.len;
> +	fprog_kern->filter = insns;
> +
> +	return 0;
> +}

[ ... ]

> @@ -3070,10 +3139,14 @@ static void tun_detach_filter(struct tun_struct *tun, int n)
>  		release_sock(tfile->socket.sk);
>  	}
>  
> +	kfree(tun->fprog_kern.filter);
> +	tun->fprog_kern.filter = NULL;
> +	tun->fprog_kern.len = 0;
>  	tun->filter_attached = false;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but what happens to queues that
are disabled when TUNDETACHFILTER runs?

tun_detach_filter() only walks the active queues in tun->tfiles[0..n-1].
The non-clean path of __tun_detach() also leaves the socket filter in
place:

	} else {
		tun_disable_queue(tun, tfile);
		tun_napi_disable(tfile);
	}

After TUNDETACHFILTER, filter_attached is false. When that queue comes back
through TUNSETQUEUE IFF_ATTACH_QUEUE, tun_attach() skips the filter block:

	if (!skip_filter && (tun->filter_attached == true)) {

Will the re-attached queue keep filtering with a program that userspace has
already removed?

>  
> -static int tun_attach_filter(struct tun_struct *tun)
> +static int tun_attach_filter(struct tun_struct *tun,
> +			     struct sock_fprog_kern *fprog_kern)
>  {
>  	int i, ret = 0;
>  	struct tun_file *tfile;
> @@ -3081,15 +3154,29 @@ static int tun_attach_filter(struct tun_struct *tun)
>  	for (i = 0; i < tun->numqueues; i++) {
>  		tfile = rtnl_dereference(tun->tfiles[i]);
>  		lock_sock(tfile->socket.sk);
> -		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
> +		ret = sk_attach_filter_kern(fprog_kern, tfile->socket.sk);
>  		release_sock(tfile->socket.sk);
> -		if (ret) {
> -			tun_detach_filter(tun, i);
> -			return ret;
> -		}
> +		if (ret)
> +			goto out_detach;
>  	}
>  
>  	tun->filter_attached = true;
> +	return 0;

[Severity: Medium]
What happens here when tun->numqueues is 0?

The commit message says:

  Such a late failure does not replace the saved program: the copy is
  committed to tun->fprog and tun->fprog_kern only after
  tun_attach_filter() installed it on every queue.

Take a multiqueue TAP whose queues have all been detached with TUNSETQUEUE
IFF_DETACH_QUEUE. tun_set_queue()->__tun_detach(tfile, false) lowers
numqueues but keeps tfile->tun set, so the detached fd can still issue
TUNATTACHFILTER. Then:

  tun_copy_filter()
    bpf_prog_validate_classic()     <- classic checks only
  tun_attach_filter()
    for loop runs zero times
    tun->filter_attached = true; return 0;
  __tun_chr_ioctl()
    tun->fprog_kern = fprog_kern;
    tun->fprog = fprog;

The saved program has never been through bpf_prog_create().

The commit message notes that bpf_prog_create() can still refuse a program
that passes bpf_check_classic(). Examples are the s16 offset check in
bpf_convert_filter(), and bpf_prog_select_runtime() when a JIT is required.

tun_attach() now has the corrected check. After this, wouldn't every later
filtered attach fail with that error until TUNDETACHFILTER is issued? That
covers TUNSETQUEUE IFF_ATTACH_QUEUE and TUNSETIFF without IFF_NOFILTER.

Would a trial bpf_prog_create()/bpf_prog_destroy() in tun_copy_filter()
catch these failures before anything is committed? The new
bpf_prog_validate_classic() export would then not be needed. Its own
kernel-doc says it does not cover these cases.

> +
> +out_detach:
> +	/* Drop the copies already installed on queues 0..i-1, which leaves
> +	 * them without a filter: their previous sk_filter, if any, was
> +	 * already replaced and released. The caller does not replace the
> +	 * saved program when this fails, so tun->fprog, tun->fprog_kern and
> +	 * filter_attached keep their previous values.
> +	 */
> +	while (i--) {
> +		tfile = rtnl_dereference(tun->tfiles[i]);
> +		lock_sock(tfile->socket.sk);
> +		sk_detach_filter(tfile->socket.sk);
> +		release_sock(tfile->socket.sk);
> +	}

[Severity: Medium]
Does this leave the device filter state out of sync with what the queues
enforce?

__sk_attach_prog() releases each queue's old sk_filter as soon as it
installs the new one. Suppose sk_attach_filter_kern() fails on queue i > 0.
This loop then leaves queues 0..i-1 with no filter, while queues i..n-1
still run the old program.

tun->filter_attached, tun->fprog and tun->fprog_kern still describe the old
program. TUNGETFILTER reports it as attached and queues attached later get
it. Meanwhile, active queues 0..i-1 pass every packet unfiltered. Before
this patch, the failure path went through tun_detach_filter(tun, i), which
cleared filter_attached.

A failure at i > 0 looks reachable in two ways:

- -ENOMEM from bpf_prog_alloc() in bpf_prog_create(), or from
  kmalloc_obj() in __sk_attach_prog().
- __sk_filter_charge(). The new filter is charged before the old one is
  uncharged, so a queue that already holds a large filter needs optmem for
  both.

The commit message says restoring the previous program "would need an
extra reference per queue". When a filter was attached before, the old
instructions are still in tun->fprog_kern at this point. Could the rollback
rebuild them with sk_attach_filter_kern(&tun->fprog_kern, sk) instead of
calling sk_detach_filter()?

> +
> +	return ret;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028093235.148649-1-clementwei90%40163.com
