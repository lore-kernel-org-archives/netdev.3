Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6EB4052CD
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829553; cv=none; b=k9V4zgQFBqQEBJECOBb5qL6NGbBQB1nhm9Yo2a6v1F+P9VDky9pXNnRXYE1bYw8BhAKlK/dwtZzsjRiqdTudYET5NNkmEZbKYA2C3BJa9vtFcmGzxmlQVGs1KzX1U1MhOqHcQtfxFBLVUOmCXbBLetH01lC/HEHGI0PQTDaKs/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829553; c=relaxed/simple;
	bh=jKgrBxH6DXcu2jfCOW9aTNEICOAfUJeHF6laxuNsPFc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dSf0qgypant/+jb1dYz+Tj9FCiQxATUaamO73am8Pnxi5Pfv/Y8a9bUNN1I677vI6IKLAv4DX59rnUvWHRpoKWkLzTdCy0GYfpoRT9TJSpA0sByaHpyAeFZEv1jovmTmW7CcawzvyoKDzaeyu3qACvMZx/LnnYcsjhJ8+UputTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haUOrmEr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haUOrmEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D394E1F00899;
	Thu,  1 Oct 2026 04:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790829551;
	bh=wPrlepsxyYJdmyq52bBxMikkJCo8QXmt26rjFP0HtXk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=haUOrmErW296dKQ7NvZkWICcic29l1P2mnDLPrL64J9wdXtAPmlffoSQccP23V3nw
	 /D5GYAJJBa6Iby2xYkbwQGdmk8J/bYIPARrzmIDWsb3VwiBzehWQYVb3GllmBnB2BP
	 nDrYPyabl205/Jd5IXscViftVR5ERvZOd9UWy2fHNM9P3JFWNnaKfTjDneBBzlfnDY
	 dMeXaNsnbbdns8e23pWQmQSbbBUT60fBng0EJ0rJkiHjxD80F+1CTZR48co+HnKZOU
	 mQ+6TA2g4YvG5fsv5nccE3xuka0w7bUJta+XTsZ3FmwohVGtXMQiIFRicgGgCkp46h
	 pYRxJSOBo5Ntw==
Subject:
 Re: [PATCH v2 3/4] tun: keep a kernel copy of the socket filter program
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
Date: Thu, 01 Oct 2026 04:39:10 +0000
Message-ID: <179082955043.434549.13216236090430920832@kernel.org>
In-Reply-To: <20260929093712.131096-4-clementwei90@163.com>
References: <20260929093712.131096-4-clementwei90@163.com>
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

- [Low] This commit carries `Fixes: 54f968d6efdb`, so it will be picked
  for stable.
- [Low] For TUNATTACHFILTER, tun_copy_filter() replaces the core
  bpf_check_basics_ok() validation with its own checks, and the two…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but a failed
  filter replacement leaves the queues in mixed states.
- [Medium] This problem wasn't introduced by this patch, but
  TUNDETACHFILTER only detaches the filter from the tun->numqueues…
- [Low] This problem wasn't introduced by this patch, but when every
  queue of a multiqueue TAP is disabled with IFF_DETACH_QUEUE,…

--

tun: keep a kernel copy of the socket filter program

With this commit, TUNATTACHFILTER copies the classic BPF instructions
into tun->fprog_kern instead of keeping only the user pointer in
tun->fprog. tun_attach() and tun_attach_filter() then build each queue's
filter from that kernel copy through sk_attach_filter_kern(). The copy
is freed on detach, when it is replaced, and in tun_free_netdev().

Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index a2fffef3735fe..c796048742f9b 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -722,6 +723,34 @@ static void tun_force_wake_queue(struct tun_struct *tun,
>  	spin_unlock_bh(&tfile->tx_ring.consumer_lock);
>  }
>  
> +/* Copy the filter that @argp points at into the kernel, so that it can be
> + * installed again later, from any context. tun->fprog and tun->fprog_kern
> + * are updated only once the copy succeeded.
> + */
> +static int tun_copy_filter(struct tun_struct *tun, struct sock_fprog __user *argp)
> +{
> +	struct sock_fprog fprog;
> +	struct sock_filter *insns;
> +
> +	if (copy_from_user(&fprog, argp, sizeof(fprog)))
> +		return -EFAULT;
> +
> +	if (!fprog.len || fprog.len > BPF_MAXINSNS)
> +		return -EINVAL;
> +
> +	insns = memdup_array_user(fprog.filter, fprog.len,
> +				  sizeof(struct sock_filter));

[Severity: Low]
Does this change the errno TUNATTACHFILTER returns when fprog.filter is
NULL and fprog.len is nonzero?

Before this patch, sk_attach_filter()->__get_filter()->bpf_check_basics_ok()
rejected a NULL filter with -EINVAL, the same errno SO_ATTACH_FILTER
returns. Here only the length is checked. memdup_array_user(NULL, ...)
then fails in copy_from_user(), and the ioctl returns -EFAULT.

The bpf_check_basics_ok() call inside bpf_prog_create() only sees the
kernel copy, which is never NULL, so it can't catch this case.

Would adding a !fprog.filter test to the length check keep the old
-EINVAL?

> +	if (IS_ERR(insns))
> +		return PTR_ERR(insns);
> +
> +	kfree(tun->fprog_kern.filter);
> +	tun->fprog_kern.len = fprog.len;
> +	tun->fprog_kern.filter = insns;
> +	tun->fprog = fprog;
> +
> +	return 0;
> +}
> +
>  static int tun_attach(struct tun_struct *tun, struct file *file,
>  		      bool skip_filter, bool napi, bool napi_frags,
>  		      bool publish_tun)
> @@ -753,7 +782,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  	/* Re-attach the filter to persist device */
>  	if (!skip_filter && (tun->filter_attached == true)) {
>  		lock_sock(tfile->socket.sk);
> -		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
> +		err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);

[Severity: Low]
Should this commit record that it depends on the helper commit? It
carries Fixes: 54f968d6efdb, so it will be picked for stable.

sk_attach_filter_kern() is only added by the previous commit in the
series, "net: filter: add sk_attach_filter_kern() function". That commit
has no Fixes: tag, no Cc: stable and no stable dependency annotation.

This commit's message doesn't say it depends on that commit, or on "tun:
fix inverted error check when re-attaching the filter".

If it is backported by itself, tun_attach() and tun_attach_filter() won't
build. sk_attach_filter_kern is implicitly declared, and the symbol is
undefined when tun is built as a module.

Would a Cc: stable tag with a dependency note on the helper commit
prevent that?

>  		release_sock(tfile->socket.sk);
>  		if (err)
>  			goto out;

[ ... ]

> @@ -3066,6 +3096,9 @@ static void tun_detach_filter(struct tun_struct *tun, int n)
>  		release_sock(tfile->socket.sk);
>  	}
>  
> +	kfree(tun->fprog_kern.filter);
> +	tun->fprog_kern.filter = NULL;
> +	tun->fprog_kern.len = 0;
>  	tun->filter_attached = false;

[Severity: Medium]
This isn't a bug introduced by this patch, but does TUNDETACHFILTER leave
the filter on queues that are disabled at that point?

tun_detach_filter() only walks the first n == tun->numqueues entries:

	for (i = 0; i < n; i++) {
		tfile = rtnl_dereference(tun->tfiles[i]);
		lock_sock(tfile->socket.sk);
		sk_detach_filter(tfile->socket.sk);
		...

A queue disabled through TUNSETQUEUE with IFF_DETACH_QUEUE
(tun_set_queue()->__tun_detach(tfile, false)) keeps its sk_filter.

When that queue is re-enabled with IFF_ATTACH_QUEUE, tun_attach() skips
the filter block because filter_attached is false. It doesn't clear the
leftover filter either.

tun_net_xmit() checks tfile->socket.sk->sk_filter directly. So after
TUNDETACHFILTER succeeds, the re-enabled queue still applies the old
filter.

>  }
>  
> @@ -3077,7 +3110,7 @@ static int tun_attach_filter(struct tun_struct *tun)
>  	for (i = 0; i < tun->numqueues; i++) {
>  		tfile = rtnl_dereference(tun->tfiles[i]);
>  		lock_sock(tfile->socket.sk);
> -		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
> +		ret = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
>  		release_sock(tfile->socket.sk);
>  		if (ret) {
>  			tun_detach_filter(tun, i);

[Severity: Medium]
This is a pre-existing issue, but can a failed filter replacement leave
the queues in mixed states?

Say filter A is attached and TUNATTACHFILTER is issued with program B.
tun_copy_filter() frees A's kernel copy and stores B. tun_attach_filter()
then fails on queue i. That happens if bpf_check_classic() rejects B
(i == 0), or if bpf_prog_alloc() or __sk_filter_charge() fails at any i.

tun_detach_filter(tun, i) detaches only queues [0, i). It also frees B's
copy and sets filter_attached = false.

Queues [i, numqueues) keep running filter A, but the device-level state
says no filter is attached. Queues attached later through tun_attach()
get no filter at all.

The code behaved the same way before this patch.

> @@ -3425,8 +3458,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  		ret = -EINVAL;
>  		if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
>  			break;
> -		ret = -EFAULT;
> -		if (copy_from_user(&tun->fprog, argp, sizeof(tun->fprog)))
> +		ret = tun_copy_filter(tun, argp);
> +		if (ret)
>  			break;
>  
>  		ret = tun_attach_filter(tun);

[Severity: Low]
This isn't a bug introduced by this patch, but what happens when every
queue of a multiqueue TAP has been disabled with IFF_DETACH_QUEUE?

tun->numqueues is 0 then, but tfile->tun is still set, so tun_get() still
reaches TUNATTACHFILTER.

tun_copy_filter() checks only the length and copies the instructions.
The loop in tun_attach_filter() runs zero times, so filter_attached is
set to true and 0 is returned. bpf_check_classic() never runs.

A later IFF_ATTACH_QUEUE calls sk_attach_filter_kern() from tun_attach().
bpf_prepare_filter() then rejects the saved program with -EINVAL. The
queue can't be re-enabled until the owner issues TUNDETACHFILTER or a
valid TUNATTACHFILTER.

This patch narrows the problem a little: before its length check, this
path accepted even len == 0.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929093712.131096-1-clementwei90%40163.com
