Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497046;
	b=wXgCGLZXhgmC9LqBTU5MwDR0zytC6/PEHybBGQ5EMTVhO/uCPz8+lBfn9Sqw0C1smlFy
	 2MURHSyMHot8J40HRiBVO+kAasn1aP45SGpfE68ObLH03G3wo+PAF6fmJSHEXkeaOg0lO
	 8EEn/B3bbZT/q5BtCrYNPIyV4DtqvoI9TIhhAIuAVcNdoYuvn7Pg8sTJq16ile8HaN6ZZ
	 12/iTtRnQMtpaT3jNKIYvopfWkJik6V0bbGzt8tLd30yGTVSxhqHUKfj0NZoW/fdKlH/+
	 nuLF+iWHgCYNwdUKrJBlmgtHa7CvbxdGv+3jYWTZkLiMgW8PWAj4/42AYejLqw3xzkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497046;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=xvfrWCxfOyR/vJIJdKHQXu2Obo4wRGA/ULuGNtYBy8M=;
	b=VzEMSq5+a2K70rJR7Wo6Vkc+MBDsdC0FfGqIS/0n6uG4Vx8FnBlQn3ufOflsv3/UGo+x
	 osgTqsgXUVTU+mbq/XIwD+NLwN9B34fDkHA+WkHwlGli1djuCqJFEIvCtfGg4XaSvdPJd
	 0DxfOnveVbtwWnvBN0wWaxPi+cVXd9F3mOG08qp/n+CU1RMCOSV90BosstAYTsvCf66SF
	 kS+i5lJ0pmwneNrkM2ekKye8sZEbKWLs2ARX1OKAQyMZPWJMHyUe/Lxg7zGS4fVTL2Ioo
	 hRowxROU2fAQ6ZSv5CinfLPY6AcuUnensPgfmRUjnkQ4bl2ifrdvsNwoShzDFCIPW7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=miRI68MW;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23922606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23922606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=miRI68MW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=xvfrWCxfOyR/vJIJdKHQXu2Obo4wRGA/ULuGNtYBy8M=;
	b=miRI68MWdZ673j/UIpg8FFgyP9+gRH0Y2IDlHmmLarPEVfHUFTXbVKBhO1e3jc
	t7PzZjtW5ueXFrakiBtbpxIkWhQ4CkjVPtU9NuwPDN7QLVOaQ6E7cmxSn8zmgzxA
	x1FQrm/rT00xuze/sV4P4ieqGldJHcmKPdz/eVwnO4VjM=
Message-ID: <aa6f8ef9-56d8-4edb-9ae2-d3f3b7dc1721@163.com>
Date: Tue, 20 Oct 2026 19:49:48 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6 1/2] tun: keep a kernel copy of the socket filter
 program
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn, willemb@google.com
References: <20261016070654.170932-2-clementwei90@163.com>
 <179248191680.3135.11424433248985216090@kernel.org>
Content-Language: en-US
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <179248191680.3135.11424433248985216090@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P1BcVddqX64pBg--.5785S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF4Dtr4xGr1Uur17XFWrKrg_yoWfKw4UpF
	WrW34jkryDWF4vqw1DXa10yF1Svw1DWF1Uur1rG345uFn0gr1fu3y2gFW5u3ZxArW8ua10
	va1jgr9ruw1DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U53kNUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-R78aGrXVV7hnQAA39



on 2026/10/20 15:38, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 (2) · Low: 2
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] TUNATTACHFILTER can save a classic BPF program that does not
>   pass validation, and every later queue attach then fails.
> - [Low] The new kernel-doc for sk_attach_filter_kern()
>   (net/core/filter.c:1582) justifies not keeping orig_prog with "A…
> - [Low] The kernel-doc 'Return:' section of sk_attach_filter_kern()
>   (net/core/filter.c:1585-1588) lists 0, -EPERM, -EINVAL and -ENOMEM as…
> 
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but a
>   TUNATTACHFILTER that fails during the per-queue attach leaves the…
> - [Medium] This problem wasn't introduced by this patch, but
>   TUNDETACHFILTER calls tun_detach_filter(tun, tun->numqueues).
> 
> --
> 
> tun: keep a kernel copy of the socket filter program
> 
> This patch keeps a kernel copy, in tun->fprog_kern, of the classic BPF
> program passed to TUNATTACHFILTER. It adds sk_attach_filter_kern(), which
> builds a per-queue program from that copy. It also fixes the inverted error
> check in tun_attach() that runs when the filter is re-attached on a
> persistent device.
> 
> Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
> 
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 242899f7fd071..e493c4554d5df 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
> 
> [ ... ]
> 
>> @@ -722,12 +723,47 @@ static void tun_force_wake_queue(struct tun_struct *tun,
>>  	spin_unlock_bh(&tfile->tx_ring.consumer_lock);
>>  }
>>  
>> +/* Copy the filter that @argp points at into the kernel, so that it can be
>> + * installed again later, independent of the ioctl caller's address space.
>> + * tun->fprog and tun->fprog_kern are updated only once the copy succeeded.
>> + */
>> +static int tun_copy_filter(struct tun_struct *tun, struct sock_fprog __user *argp)
>> +{
>> +	struct sock_fprog fprog;
>> +	struct sock_filter *insns;
>> +
>> +	if (copy_from_user(&fprog, argp, sizeof(fprog)))
>> +		return -EFAULT;
>> +
>> +	if (!fprog.len || fprog.len > BPF_MAXINSNS)
>> +		return -EINVAL;
> 
> [ ... ]
> 
>> +	kfree(tun->fprog_kern.filter);
>> +	tun->fprog_kern.len = fprog.len;
>> +	tun->fprog_kern.filter = insns;
>> +	tun->fprog = fprog;
> 
> [Severity: Medium]
> Only the header is checked here. The instructions go into tun->fprog_kern
> without being validated. Can TUNATTACHFILTER store a program that
> bpf_check_classic() would reject, and still return 0?
> 
> The instructions are only checked in the per-queue loop in
> tun_attach_filter():
> 
> 	for (i = 0; i < tun->numqueues; i++) {
> 		...
> 		ret = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
> 		...
> 	}
> 
> 	tun->filter_attached = true;
> 
> If numqueues is 0, the loop never runs, and filter_attached is set to true
> for the invalid program.
> 
> numqueues == 0 seems reachable on a multiqueue TAP device. Disable every
> queue with TUNSETQUEUE/IFF_DETACH_QUEUE. __tun_detach(tfile, false) lowers
> numqueues but leaves tfile->tun set, so TUNATTACHFILTER can still be issued
> from the fd of a disabled queue.
> 
> With the inverted check now fixed, tun_attach() then does:
> 
> 		err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
> 		release_sock(tfile->socket.sk);
> 		if (err)
> 			goto out;
> 
> Wouldn't every IFF_ATTACH_QUEUE then fail with -EINVAL? tun_set_queue()
> always passes skip_filter=false. The same applies to every TUNSETIFF on the
> persistent device without IFF_NOFILTER. Before this patch, a TUNSETIFF
> attach of a new tfile in this state succeeded, just without a filter.
> 
> The commit message says:
> 
>   Neither change works on its own: with only the kernel copy, every re-attach
>   returns 0 without publishing the queue; with only the check fixed, a
>   re-attach that used to succeed without installing a filter would start to
>   fail.
> 
> The early-failure note in the commit message only covers bad headers. Since
> the program is now a fixed kernel copy, could it be validated once in
> tun_copy_filter() before the old copy is replaced? For example, call
> bpf_prog_create() and then bpf_prog_destroy().
> 
OK. I folded the fix into v7. Add a new bpf_prog_validate_classic(), 
which runs the checks of bpf_check_classic() on the copy without allocating 
a struct bpf_prog.
> [ ... ]
> 
>> @@ -3064,6 +3107,9 @@ static void tun_detach_filter(struct tun_struct *tun, int n)
>>  		release_sock(tfile->socket.sk);
>>  	}
>>  
>> +	kfree(tun->fprog_kern.filter);
>> +	tun->fprog_kern.filter = NULL;
>> +	tun->fprog_kern.len = 0;
>>  	tun->filter_attached = false;
>>  }
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but TUNDETACHFILTER calls
> tun_detach_filter(tun, tun->numqueues). That only walks the active
> tun->tfiles[] entries, not the queues on tun->disabled.
> 
> So a queue disabled with IFF_DETACH_QUEUE (__tun_detach(tfile, false))
> keeps its socket filter. Once filter_attached is cleared, re-enabling that
> queue with IFF_ATTACH_QUEUE goes through tun_attach(), which skips the
> filter block:
> 
> 	if (!skip_filter && (tun->filter_attached == true)) {
> 
> Nothing removes the existing sk_filter on that path. Does tun_net_xmit()
> then keep applying the old filter even though TUNDETACHFILTER succeeded? If
> the old program was a drop-all filter, it would keep dropping packets.
> 
>>  
>> @@ -3075,7 +3121,7 @@ static int tun_attach_filter(struct tun_struct *tun)
>>  	for (i = 0; i < tun->numqueues; i++) {
>>  		tfile = rtnl_dereference(tun->tfiles[i]);
>>  		lock_sock(tfile->socket.sk);
>> -		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
>> +		ret = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
>>  		release_sock(tfile->socket.sk);
>>  		if (ret) {
>>  			tun_detach_filter(tun, i);
> 
> [Severity: Medium]
> This is a pre-existing issue, but a TUNATTACHFILTER that fails here leaves
> the device in an inconsistent state.
> 
> By this point tun_copy_filter() has already freed the old fprog_kern and
> overwritten tun->fprog and tun->fprog_kern. Suppose sk_attach_filter_kern()
> fails at queue i. Invalid instructions always fail at i == 0, and -ENOMEM
> can happen at any i. tun_detach_filter(tun, i) then detaches only queues
> 0..i-1 and clears fprog_kern and filter_attached.
> 
> Do queues i..numqueues-1 keep the previous socket filter? tun_net_xmit()
> would keep running it:
> 
> 	if (tfile->socket.sk->sk_filter) {
> 		drop_reason = sk_filter_reason(tfile->socket.sk, skb);
> 
> Queues attached afterwards would get no filter. TUNGETFILTER would return
> the header of the program that failed.
> 
> The patch only moves the length check earlier, so this can still happen
> with bad instructions or allocation failures. Validating the instructions
> in tun_copy_filter(), as asked above, would remove the bad-instruction
> case.
> 
> [ ... ]
> 
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 70dc621672f2e..57bef64b72bcc 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -1567,6 +1567,47 @@ int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk)
>>  }
>>  EXPORT_SYMBOL_GPL(sk_attach_filter);
>>  
>> +/**
>> + * sk_attach_filter_kern - attach a classic BPF filter held in kernel memory
>> + * @fprog: program to attach, with @fprog->filter pointing at kernel memory
>> + * @sk: socket to attach the filter to
>> + *
>> + * Attach a copy of a classic BPF program that the kernel already holds, the
>> + * way sk_attach_filter() does for one that still lives in user space. The
>> + * caller must hold the socket lock; SOCK_FILTER_LOCKED is checked here.
>> + *
>> + * The program is built by bpf_prog_create(), which does not keep an original
>> + * copy of the instructions. sk_get_filter() therefore returns -EACCES and
>> + * sock_diag leaves the filter out for a socket that uses this helper. A
>> + * classic BPF program cannot be duplicated with bpf_prog_copy(), so keeping
> 
> [Severity: Low]
> This isn't a bug, but is bpf_prog_copy() the intended name here? No
> function by that name seems to exist in the tree. This comment is the only
> place it appears.
> 
>> + * the original would cost another allocation and a copy per attach.
>> + *
>> + * Return: 0 on success, -EPERM if @sk has SOCK_FILTER_LOCKED set, -EINVAL if
>> + * the instructions are not a valid classic BPF program, and -ENOMEM on an
>> + * allocation failure.
>> + */
> 
> [Severity: Low]
> Is this list of return values complete? Any error from bpf_prog_create() is
> passed through unchanged, including errors from runtime selection:
> 
> sk_attach_filter_kern()
>   bpf_prog_create()
>     bpf_prepare_filter()
>       bpf_migrate_filter()
>         bpf_prog_select_runtime()
> 
> __bpf_prog_select_runtime() sets -ENOTSUPP when a JIT is required but no
> JIT image was produced, for example with CONFIG_BPF_JIT_ALWAYS_ON:
> 
> 		if (!fp->jited && jit_needed) {
> 			*err = -ENOTSUPP;
> 			return fp;
> 
> It also passes through whatever bpf_prog_lock_ro() returns. Userspace can
> see these codes through TUNATTACHFILTER and the tun_attach() re-attach
> paths.
> 
> [ ... ]
> 
pw-bot: cr

