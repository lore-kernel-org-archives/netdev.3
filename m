Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B9C1B142D
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 03:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790910841; cv=none; b=tHIzVQvs8dqJLJINokMJonBR7nJJMewdPe1JL6etP0i7z58iuF9ODMnAx5pe0NhwFUQk9fzheGhjMvBW1hABCEL2kR01uCJiVziQR5CAkatPACdic7oIcH2iitTjsaZBWlB+01YwJJF7oJWAWbKSmm92NUsa8mvTyG6iUtI2s+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790910841; c=relaxed/simple;
	bh=Y0htw6YNvVHWb43BfQ6VX1I7U+F/8o70bpscG908mtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vF4Cv4RSeTtwUctPUnxZJuMAhVTuBKytRjLP/4p0zNuLKRFEicYRZ2kRVw+k7YpZlErKMtjZvhjS8K7gZpJgUrdx1HHahXthTU3M+KM5aMScEvX8cwoIrfWYvRrKDoCdAVvKwapwQy28ySA433Ssnl0OVboYyMl2MDVBA51Ngwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RQhzlYtV; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RQhzlYtV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=02eG+voo7vZU+dMYkskTJmdmvoMiseYAUMgdAJhgQlk=;
	b=RQhzlYtVQ4PKnkIT3FtvWov4nYV4NRrYisCT//fcAXZkHQiXBWGPD7nfGoSTDa
	OSJaUYwXcWHUk8BWkUHS6yWSAJDSvpk6kox+SgG5rrq4WDPDfL2YLaOCBSm3RAvl
	djjyuohEZElRCSt/Is2DJiqkwDd6gtnWOZrASB/OQmZCM=
Message-ID: <d726539c-1919-41b3-b74e-3f40693b1f32@163.com>
Date: Fri, 2 Oct 2026 11:13:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] tun: keep a kernel copy of the socket filter
 program
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
References: <20260930080746.135017-2-clementwei90@163.com>
 <179086383901.434549.6742700086527768803@kernel.org>
Content-Language: en-US
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <179086383901.434549.6742700086527768803@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXvfNWIb9qXb_1Bw--.64513S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3CF1kCF18uFy5JFWxZF15twb_yoW8Jr13Ko
	WfX39xA3WUtrWfG34qkas7G3W3WryDKr47JFWjgws8XFW2q3yUWFZ5ZrWrXayqyF15GF4D
	Gas7J3yqyrWDtF93n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0mhwUUUUU
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4hroVGq-IVpLUwAA3y



on 2026/10/1 22:10, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 (2) · Low: 3 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] After this patch alone, tun_attach() in drivers/net/tun.c still
>   has the inverted check `if (!err) goto out;` right after `err =
Make the check first is not an option either (it would turn an attach 
that used to succeed without a filter into a failure). It seems the only
way is that the fix be folded into this patch, so no step of the series
takes goto out with err == 0.
> - [Low] The commit message gets both the old failure mode and the new
>   helper's semantics wrong.
> - [Low] The new exported helper sk_attach_filter_kern()
>   (net/core/filter.c) builds the program with bpf_prog_create() and then…
> - [Low] The new comment above tun_copy_filter()
>   (drivers/net/tun.c:726-729) says the kernel copy lets the filter "be…
I will reword it.
> 
> Pre-existing issues:
> - [Medium] tun has no compat translation for the classic filter ioctls.
I can send the compat translation as a separate patch.
> - [Medium] If TUNATTACHFILTER replaces an attached filter and
>   sk_attach_filter_kern() fails on queue i (for example -ENOMEM from…
The old code also overwrote tun->fprog before attaching, and the prefix-only
rollback is unchanged. A proper fix is to install the new copy on every queue 
and only then replace the saved one. Separate patch.
> - [Low] When TUNATTACHFILTER is issued while tun->numqueues == 0, the
>   classic BPF program is stored without ever being validated.The old code stored an unvalidated header in the same situation. 
Validating the program at copy time can be a separate change.
> 
> --
> 
> tun: keep a kernel copy of the socket filter program
> 
> This patch changes TUNATTACHFILTER to copy the classic BPF instructions
> into tun->fprog_kern. Before, only the sock_fprog header was stored, and
> it pointed into the ioctl caller's address space. It also adds a new
> exported helper, sk_attach_filter_kern(), which builds and attaches a
> program from a kernel sock_fprog_kern, and tun_attach() and
> tun_attach_filter() now use it.
> 
> Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
> 
>> tun_attach() reads it again whenever a queue is attached to the
>> persistent device later on: unmapped there, the attach fails with -EFAULT;
>> mapped, whatever bytes it holds become the filter of the new queue.
> 
> [Severity: Low]
> Is this an accurate description of the old behaviour? tun_attach() has an
> inverted "if (!err) goto out;", so an -EFAULT, or an -EINVAL caused by
> garbage bytes, falls through instead of failing the attach.
> 
> For a new tfile, xdp_rxq_info_reg() and "err = 0" then overwrite err. So
> TUNSETIFF succeeds, the queue is attached, and no filter is installed.
> 
> A successful read of mapped, valid bytes returns 0 without attaching the
> queue at all.
> 
> The follow-up patch's message talks about "a re-attach that used to
> succeed without installing any filter". That seems to contradict this
> one.
> 
>> sk_attach_filter_kern() reads no user buffer and attaches the program like
>> sk_attach_filter() does.
> 
> Do the two really behave the same way? sk_attach_filter_kern() builds the
> program with bpf_prog_create(), which sets fp->orig_prog = NULL.
> sk_attach_filter() goes through __get_filter()->bpf_prog_store_orig_filter()
> instead. As a result, SO_GET_FILTER and sock_diag readback give different
> results depending on which helper attached the filter.
> 
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 5a302709a68aa..22fb34e745bd9 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
> 
> [ ... ]
> 
>> @@ -722,6 +723,34 @@ static void tun_force_wake_queue(struct tun_struct *tun,
>>  	spin_unlock_bh(&tfile->tx_ring.consumer_lock);
>>  }
>>  
>> +/* Copy the filter that @argp points at into the kernel, so that it can be
>> + * installed again later, from any context. tun->fprog and tun->fprog_kern
>> + * are updated only once the copy succeeded.
>> + */
> 
> [Severity: Low]
> Is "from any context" accurate here? The only consumer,
> sk_attach_filter_kern(), needs sleepable process context and the socket
> lock:
> 
> sk_attach_filter_kern()
>   bpf_prog_create()
>     bpf_prog_alloc()          <- GFP_KERNEL based allocation
>   __sk_attach_prog()
>     kmalloc_obj()             <- GFP_KERNEL
>     rcu_dereference_protected(..., lockdep_sock_is_held(sk))
> 
> Was the intended meaning "from any process", or "independent of the ioctl
> caller's address space"?
> 
>> +static int tun_copy_filter(struct tun_struct *tun, struct sock_fprog __user *argp)
>> +{
>> +	struct sock_fprog fprog;
>> +	struct sock_filter *insns;
>> +
>> +	if (copy_from_user(&fprog, argp, sizeof(fprog)))
>> +		return -EFAULT;
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but tun has no compat handling
> for the classic filter ioctls. TUNATTACHFILTER, TUNDETACHFILTER and
> TUNGETFILTER encode sizeof(struct sock_fprog) in the command number. That
> size is 8 bytes for 32-bit userspace and 16 bytes natively, so the command
> numbers differ.
> 
> tun_chr_compat_ioctl() only converts these:
> 
> 	case TUNSETIFF:
> 	case TUNGETIFF:
> 	case TUNSETTXFILTER:
> 	case TUNGETSNDBUF:
> 	case TUNSETSNDBUF:
> 	case SIOCGIFHWADDR:
> 	case SIOCSIFHWADDR:
> 		arg = (unsigned long)compat_ptr(arg);
> 		break;
> 
> The compat filter commands therefore miss the native cases in
> __tun_chr_ioctl() and end up in tun_vnet_ioctl(), which returns -EINVAL.
> tun_copy_filter() is never reached with a compat layout. The result is
> that 32-bit userspace on a 64-bit kernel cannot use these ioctls.
> 
> This copy is being rewritten anyway. Would it be worth adding compat
> command translation here, perhaps together with the compat-aware
> copy_bpf_fprog_from_user() that SO_ATTACH_FILTER uses?
> 
>> +
>> +	if (!fprog.len || fprog.len > BPF_MAXINSNS)
>> +		return -EINVAL;
> 
> [Severity: Low]
> This is a pre-existing issue, but only the length is checked before the
> program is committed to tun->fprog_kern. If TUNATTACHFILTER is issued
> while tun->numqueues == 0, does the program ever get validated?
> 
> A multiqueue TAP reaches that state after TUNSETQUEUE(IFF_DETACH_QUEUE) on
> every queue. __tun_detach(tfile, false) lowers numqueues but keeps
> tfile->tun, so tun_get() still succeeds in __tun_chr_ioctl().
> 
> In that case the loop in tun_attach_filter() runs zero times, and
> bpf_check_classic() (via bpf_prog_create()->bpf_prepare_filter()) never
> runs. filter_attached is still set to true and 0 is returned.
> 
> After that, every tun_attach() fails in sk_attach_filter_kern() with
> -EINVAL until TUNDETACHFILTER. The old code had the same gap: it stored an
> unvalidated header when numqueues == 0.
> 
>> +
>> +	insns = memdup_array_user(fprog.filter, fprog.len,
>> +				  sizeof(struct sock_filter));
> 
> [ ... ]
> 
>> @@ -752,7 +781,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>>  	/* Re-attach the filter to persist device */
>>  	if (!skip_filter && (tun->filter_attached == true)) {
>>  		lock_sock(tfile->socket.sk);
>> -		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
>> +		err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
>>  		release_sock(tfile->socket.sk);
>>  		if (!err)
>>  			goto out;
> 
> [Severity: High]
> With only this patch applied, is the check after sk_attach_filter_kern()
> still inverted?
> 
> The program is now built from a kernel copy, so the build succeeds for
> any valid program. On a persistent TAP with filter_attached set, TUNSETIFF
> without IFF_NOFILTER and TUNSETQUEUE(IFF_ATTACH_QUEUE) would then jump
> straight to out and return 0.
> 
> That jump skips all of the following:
> 
>   - ptr_ring_resize()
>   - the queue_index setup
>   - xdp_rxq registration
>   - sock_hold()/tun_napi_init() or tun_enable_queue()
>   - publishing tfile->tun and tun->tfiles[]
>   - the numqueues increment
> 
> tun_set_iff() and tun_set_queue() report success, but the fd stays
> unattached, and later reads and writes fail with -EBADFD.
> 
> The reverse also happens: when the build fails, the code falls through and
> attaches the queue with no filter.
> 
> The next patch in the series, "tun: fix inverted error check when
> re-attaching the filter", changes this to "if (err) goto out;". It also
> adds a rollback_filter sk_detach_filter() on the later failure paths, so
> the code is correct at the end of the series.
> 
> Could that fix be folded into this patch, or ordered before it? Otherwise
> a bisect can land on a kernel where re-attaching to a filtered persistent
> TAP silently does nothing.
> > [ ... ]
> 
>> @@ -3070,7 +3103,7 @@ static int tun_attach_filter(struct tun_struct *tun)
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
> This isn't a bug introduced by this patch, but what happens to the
> remaining queues in this case? TUNATTACHFILTER replaces an attached
> filter, and sk_attach_filter_kern() fails on queue i, for example with
> -ENOMEM from __sk_filter_charge() at the optmem limit.
> 
> tun_detach_filter(tun, i) only detaches queues 0..i-1, then frees the new
> kernel copy and clears filter_attached. Queues i..numqueues-1 keep the
> previous sk_filter.
> 
> The previous copy has already been freed in tun_copy_filter():
> 
> 	kfree(tun->fprog_kern.filter);
> 	tun->fprog_kern.len = fprog.len;
> 	tun->fprog_kern.filter = insns;
> 	tun->fprog = fprog;
> 
> So the old state can't be restored, and queues attached later get no
> filter. The device ends up with some queues unfiltered and others still
> using the old filter.
> 
> The old code had the same prefix-only rollback, since it overwrote
> tun->fprog in place before attaching.
> 
> [ ... ]
> 
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 70dc621672f2e..64d6505a4ef23 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -1567,6 +1567,28 @@ int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk)
>>  }
>>  EXPORT_SYMBOL_GPL(sk_attach_filter);
>>  
>> +int sk_attach_filter_kern(struct sock_fprog_kern *fprog, struct sock *sk)
>> +{
>> +	struct bpf_prog *prog;
>> +	int err;
>> +
>> +	if (sock_flag(sk, SOCK_FILTER_LOCKED))
>> +		return -EPERM;
>> +
>> +	err = bpf_prog_create(&prog, fprog);
>> +	if (err)
>> +		return err;
>> +
>> +	err = __sk_attach_prog(prog, sk);
> 
> [Severity: Low]
> bpf_prog_create() is documented as creating an unattached filter, and it
> deliberately skips orig_prog:
> 
> net/core/filter.c:bpf_prog_create() {
> 	...
> 	/* Since unattached filters are not copied back to user
> 	 * space through sk_get_filter(), we do not need to hold
> 	 * a copy here, and can spare us the work.
> 	 */
> 	fp->orig_prog = NULL;
> 	...
> }
> 
> This helper now attaches such a program to sk->sk_filter. Does
> sk_get_filter() then return -EACCES for these sockets?
> 
> net/core/filter.c:sk_get_filter() {
> 	...
> 	ret = -EACCES;
> 	fprog = filter->prog->orig_prog;
> 	if (!fprog)
> 		goto out;
> 	...
> }
> 
> sock_diag would also leave the filter out. sk_attach_filter() keeps
> orig_prog through bpf_prog_store_orig_filter().
> 
> tun sockets can't reach SO_GET_FILTER today. However, this helper is
> exported and declared next to sk_attach_filter() in include/linux/filter.h.
> Should the difference be documented, or should orig_prog be stored here as
> well?
> 
pw-bot: cr

