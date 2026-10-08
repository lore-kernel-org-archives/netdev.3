Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99441370AE7
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791441984; cv=none; b=HCf8vuSXLarndGba5/VmC/0KhQ/himo/rxBMB7JA9DX/megalHOl2i953D8NipOBWtIPZwpzb4WRGKvxNu+PUOwEKieMNFurWIRB6+n15IenlBL17d3oH612qv7pzRhEdzRqlEZXbkX0IYzZw8XU2NzNbYg3Klm4rOQauFxyGPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791441984; c=relaxed/simple;
	bh=EVNHrrYALiaFZR5oEtXF5FrlzGYSq8U1QoS2suSrVeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJ40izVsqDWQ0m3KDfQz5aGTc+xsOi7uVSQrF21OP0L0EQnAFuE1tomWUE7ggslW0zK+EK/ct9ZT6xkgDgKRzJ6tOBNnJYEzFAVOF+Rt7QVODDC4unnQEZ82KPE4+ajfiCqfc8v+7SQOm+ILhARoyg7pQQbMyubjOfFkVkAfep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ebbmiB0z; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ebbmiB0z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=GzaQE9qS64ympPHp6Q8aNfpTZ+PAfIrLJ/nPHzndWaM=;
	b=ebbmiB0z0NatCr/QVmcK3uppzcn9xqn5PNDi846UP8HU7B0g+/m1SRl7HEAv2o
	y52+cd/MEVIowT8nJ1qlhVp1Hd3sKnLn2eDGo0A9zP2NUSj9QvKRXf7qQzJURDZm
	+/NhiGPayxYpW8w/FSjkxLLdBHqowNZD5tOEZgZGmiXUI=
Message-ID: <00212619-8b3b-48a6-afa5-e2ad70c91fa1@163.com>
Date: Thu, 8 Oct 2026 14:45:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/2] tun: keep a kernel copy of the socket filter
 program
Content-Language: en-US
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
References: <20261003063859.136895-2-clementwei90@163.com>
 <179109599504.434549.16794375515097963280@kernel.org>
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <179109599504.434549.16794375515097963280@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBXkUofPMdqAzi2DQ--.18063S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Aw4rJr4kKw43Zw18Ar4xZwb_yoWDZryUpF
	W5Wa4Utr1DWFW0qw1vvw4kAFySvw1kWF1Uurn5G345uF1q9r1fu3y3KrWY93sxAr4rCw4v
	vF4jgwnru3WDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsvttUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4gGjD2rHPCHG5gAA3f



on 2026/10/4 14:39, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 (3) · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] TUNATTACHFILTER can store an invalid classic BPF program and
>   still return 0.
> - [Low] The new exported helper sk_attach_filter_kern()
>   (net/core/filter.c:1570-1590) attaches a program built by…
> 
> Pre-existing issues:
> - [Medium] TUNDETACHFILTER does not remove the filter from detached
>   (disabled) queues, so a re-enabled queue keeps filtering with an old…
> - [Medium] TUNATTACHFILTER and TUNGETFILTER do not work for 32-bit user
>   space on a 64-bit CONFIG_COMPAT kernel.
> - [Medium] Replacing an attached filter leaves the device in an
>   inconsistent state if attaching the new one fails partway.
> 
> --
> 
> tun: keep a kernel copy of the socket filter program
> 
> This patch makes tun keep the classic BPF filter for TUNATTACHFILTER in
> kernel memory (tun->fprog_kern), so it no longer re-reads it from the user
> pointer every time a queue is attached. Each queue gets its own program
> from a new helper, sk_attach_filter_kern(). The patch also fixes the
> inverted error check in tun_attach().
> 
> Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
> 
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 5a302709a68aa..b58ad67b77ad1 100644
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
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does TUNATTACHFILTER work
> for 32-bit user space on a 64-bit CONFIG_COMPAT kernel?
> 
> TUNATTACHFILTER and TUNGETFILTER are defined with the size of struct
> sock_fprog in include/uapi/linux/if_tun.h:
> 
> #define TUNATTACHFILTER _IOW('T', 213, struct sock_fprog)
> 
> sock_fprog contains a pointer, so it is 8 bytes on 32-bit and 16 bytes on
> 64-bit, and the encoded command numbers differ. tun_chr_compat_ioctl()
> passes cmd through unchanged:
> 
> 	return __tun_chr_ioctl(file, cmd, arg, sizeof(struct compat_ifreq));
> 
> So the 32-bit numbers match no case in __tun_chr_ioctl() and fall through
> to the default tun_vnet_ioctl() branch.
> 
> Even if the numbers were normalised, this copy_from_user() reads the
> native sock_fprog layout, and TUNGETFILTER writes the native layout back.
> Nothing on this path converts to or from compat_sock_fprog.
> 
>> +
>> +	if (!fprog.len || fprog.len > BPF_MAXINSNS)
>> +		return -EINVAL;
> 
> [Severity: Medium]
> Can TUNATTACHFILTER now store an invalid classic BPF program and still
> return 0?
> 
The issue itself is pre-existing.  Before this series tun_attach_filter()
walked the same numqueues and set filter_attached = true either way, so an
invalid program was stored without ever being checked. And fix it where the
program is stored, but bpf_check_classic() is static in net/core/filter.c, 
so it needs either a new exported wrapper or a throwaway bpf_prog_create().  
Either way it changes what TUNATTACHFILTER accepts, so I would rather send 
that as its own patch than fold it into a series that is otherwise about 
re-attaching.
> This check covers only the length. The instructions are checked only by
> bpf_check_classic(), via
> sk_attach_filter_kern()->bpf_prog_create()->bpf_prepare_filter(). That
> runs once per attached queue in tun_attach_filter():
> 
> 	for (i = 0; i < tun->numqueues; i++) {
> 		...
> 	}
> 
> 	tun->filter_attached = true;
> 	return ret;
> 
> If tun->numqueues is 0, the loop never runs and the program is never
> checked. filter_attached is still set to true and the ioctl returns
> success.
> 
> This state can be reached on a multiqueue TAP. TUNSETQUEUE with
> IFF_DETACH_QUEUE goes through __tun_detach(tfile, false), which leaves
> tfile->tun set. The same fd can then issue TUNATTACHFILTER while no
> queues are attached.
> 
> With the corrected check in tun_attach():
> 
> 		err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
> 		release_sock(tfile->socket.sk);
> 		if (err)
> 			goto out;
> 
> every later TUNSETQUEUE(IFF_ATTACH_QUEUE) through tun_set_queue(), and
> every TUNSETIFF without IFF_NOFILTER through tun_set_iff(), would then
> fail with -EINVAL from bpf_prepare_filter(). This lasts until someone
> issues TUNDETACHFILTER.
> 
> Could the instructions be checked once in the TUNATTACHFILTER path,
> whatever numqueues is? One option is to build and destroy a throwaway
> prog with bpf_prog_create(). Another is to run bpf_check_classic() on
> the copy.
> 
> There is also a smaller behaviour change. A bad header now makes the
> ioctl fail early and leaves the previous filter in place. Before, it
> failed on queue 0 and cleared filter_attached. Should the commit message
> mention this?
> 
I will add in the commit message: the length check in tun_copy_filter()
runs before anything is replaced, so a bad header now leaves the previously
attached filter in place, while before the failed attach on queue 0 cleared
filter_attached.
>> +
>> +	insns = kmalloc_array(fprog.len, sizeof(struct sock_filter),
>> +			      GFP_KERNEL_ACCOUNT);
> 
> [ ... ]
> 
>> @@ -3059,6 +3102,9 @@ static void tun_detach_filter(struct tun_struct *tun, int n)
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
> This is a pre-existing issue, but does TUNDETACHFILTER leave the old
> filter on queues that are currently detached?
> 
> tun_detach_filter(tun, tun->numqueues) walks only tun->tfiles[0..n). A
> queue detached with IFF_DETACH_QUEUE sits on tun->disabled instead, and
> __tun_detach(tfile, false) does not touch its sk->sk_filter.
> 
> When that queue is attached again while filter_attached is false,
> tun_attach() skips the filter block:
> 
> 	if (!skip_filter && (tun->filter_attached == true)) {
> 
> Take this sequence: attach a filter, IFF_DETACH_QUEUE on queue Q,
> TUNDETACHFILTER, IFF_ATTACH_QUEUE on Q. Q keeps filtering packets with
> the removed program, while the device reports no filter.
> 
>>  
>> @@ -3070,7 +3116,7 @@ static int tun_attach_filter(struct tun_struct *tun)
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
> This isn't a bug introduced by this patch, but what happens to queues
> i..numqueues-1 when replacing an attached filter fails on queue i?
> 
> tun_detach_filter(tun, i) detaches only queues 0..i-1. It then frees
> fprog_kern and clears filter_attached (see tun_detach_filter() above).
> Queues i..numqueues-1 keep the old sk_filter.
> 
> Failure at i > 0 can happen through -ENOMEM from __sk_filter_charge() or
> the allocations. Failure at i == 0 can happen with an invalid program.
> 
> By this point tun_copy_filter() has already freed the old fprog_kern and
> set tun->fprog to the new program. After the failure:
> 
> - the device reports no filter
> - new queues attach without a filter
> - some existing queues still run the old program
> - TUNGETFILTER returns a program that is not attached anywhere
> 
> Memory safety is not affected, because bpf_prog_create() copies the
> instructions. The unwind logic is the same as before the patch.
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
> 
> [Severity: Low]
> This isn't a bug, but bpf_prog_create() assumes its result is never
> attached to a socket:
> 
> 	/* Since unattached filters are not copied back to user
> 	 * space through sk_get_filter(), we do not need to hold
> 	 * a copy here, and can spare us the work.
> 	 */
> 	fp->orig_prog = NULL;
> 
> sk_attach_filter_kern() now attaches exactly such a program to
> sk->sk_filter. When orig_prog is NULL, sk_get_filter() returns -EACCES
> and sock_diag_put_filterinfo() silently leaves the filter out.
> 
> The commit message notes that tun sockets do not expose this. Even so,
> the comment in bpf_prog_create() is now inaccurate. Unlike
> sk_attach_filter(), the new exported helper also has no kernel-doc to
> warn future callers.
> 
> Could sk_attach_filter_kern() save the original program, the way
> bpf_prog_create_from_user() does with save_orig set? If not, could it
> get kernel-doc that describes the limitation, along with an updated
> comment in bpf_prog_create()?
> 
No tun socket is ever exposed as a file descriptor, so SO_GET_FILTER and
sock_diag cannot observe the difference, while it would add an allocation
and a copy to every queue attach.
I will add kernel-doc for it in the respin.
> [ ... ]
> 
pw-bot: cr

