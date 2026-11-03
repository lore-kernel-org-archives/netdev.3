Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793691949;
	b=whlG5Y2gsoLjHagY/r4btuvSnTm7xSGxFoUIIzVLDXPHZAEcOk/uYqj+EOOMhIpovzsC
	 pRapbVuYsMhfiDr1bvxmq8EO1x96aHIwn166q/ojPcRjZkGMyH9t1l96zWmQjPKz9Endy
	 qM4ZWJQLmOXZb4Y5FUITdBDvneo/JU7puCC9KA6E0IKZ1YWcVjiOud3PEAmoJGBJ2pwWY
	 2RJOCfSFNC6YwcqaOtWRglz/984BoTKeZrKw/OPbAaIyW2gfr3xdgrjO2awhwItnORBVg
	 3Ot/K3Oo1bvEIkrx67pjdT0OD9dKJ+AFgs1MtY+vUdtn2ePiRXW0EZJkP7Ro9okJtNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793691949;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=JxkEOeSPNGi/7G+tIqc5DD4WU73TjSU+4ZhSqiHqtFk=;
	b=qIq/b8SmkTMfMDFnomUHevHxljs4Vs3HoGDfdNqUNg91bvAdp6fDMniSuK3trPP/NbAW
	 cyFSsmbGU2TR2Tn/Oh4o5JxOtvisE0vw7kjJGjhA/QlDjrnNjeAUSzHbfNdqaZrK3JZE8
	 GW5XwOn8BwcNUmaJ7lEkl937CGCA9tIxDXN66ml2l8VLfZ+y1EAg9cQxmvZIRzYeEJEW+
	 QdJJYhE4Et04aIpn0iS4ndP/rvwN66MDjV+wwInkL5smHha1DzGwsNemlfNJnycXtmE7w
	 JUSfQzoFPu1rZw3Ax+j2WNgkDapXsIPiyimGRgFRxbuA/F61O++M/i0MthrrrhrCLVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Tn4mFcHT;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15F8606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 07:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A15F8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Tn4mFcHT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=JxkEOeSPNGi/7G+tIqc5DD4WU73TjSU+4ZhSqiHqtFk=;
	b=Tn4mFcHTOdxEJNXlN8oNgS7lQRXi6d+q0I/gNx/rO4ZWaNFCd2aA+ltAxhP5sn
	c6t7IZ/mQSyRaRlfw43a0DBUWRWyQzHRDCPJRhiHhXkE9KlCVlfLBbzDUqZ/l6qV
	FcvFvvbew9yPPkWJUwx20Hz8Y3LyOgMkAfOY88PwDc5mM=
Message-ID: <16205bbf-9856-4958-9908-3c4fc811c6af@163.com>
Date: Tue, 3 Nov 2026 15:44:51 +0800
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
Subject: Re: [PATCH net v9 1/2] tun: keep a kernel copy of the socket filter
 program
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
References: <20261030060043.94719-2-clementwei90@163.com>
 <179368687768.488856.11634976425449992532@kernel.org>
Content-Language: en-US
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <179368687768.488856.11634976425449992532@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t3_zkOlqs5XnEg--.32250S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF1xAryUtw43Gr18tr4Dtwb_yoWfWryfpF
	W5W34UKry8WF40qw1DAw40vF1Svw1kWr4UZrn5G3s8uFn0gryfu3y3W3yYvanrZFW8Ca10
	vr4jqasrWrn8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsvttUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-RZ24WrpkPYxIAAA3I



netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 0 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
Thanks for the review. 
> - [Medium] A TUNATTACHFILTER that fails partway through leaves queues
>   0..i-1 with no filter, while the device state still says the old…
> - [Medium] With zero active queues, TUNATTACHFILTER saves a program that
>   has never been built, so a program that bpf_prog_create() rejects is…
> 
> Pre-existing issues:
> - [Low] TUNDETACHFILTER does not remove the filter from queues detached
>   with IFF_DETACH_QUEUE.
> 
> --
> 
> tun: keep a kernel copy of the socket filter program
> 
> This keeps a kernel copy of the classic BPF program attached with
> TUNATTACHFILTER in tun->fprog_kern, so that each queue builds its own
> program with the new sk_attach_filter_kern(). It also fixes the inverted
> error check in tun_attach(). Programs are now validated up front with the
> new bpf_prog_validate_classic(), and the saved program is replaced only
> after every queue has accepted the new one.
> 
> Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
> 
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 439565a264ee7..c121ad50f31bb 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
> 
> [ ... ]
> 
>> @@ -3070,10 +3141,14 @@ static void tun_detach_filter(struct tun_struct *tun, int n)
>>  		release_sock(tfile->socket.sk);
>>  	}
>>  
>> +	kfree(tun->fprog_kern.filter);
>> +	tun->fprog_kern.filter = NULL;
>> +	tun->fprog_kern.len = 0;
>>  	tun->filter_attached = false;
>>  }
> 
> [Severity: Low]
> This isn't a bug introduced by this patch, but does TUNDETACHFILTER miss
> queues that were detached with IFF_DETACH_QUEUE?
> 
> tun_detach_filter() only walks tun->tfiles[0..n-1], which are the active
> queues, and then clears filter_attached. Queues on tun->disabled keep
> their sk_filter, because __tun_detach(tfile, false) only calls
> tun_disable_queue().
> 
> When such a queue comes back with IFF_ATTACH_QUEUE, tun_attach() only
> touches the filter when filter_attached is true:
> 
> 	if (!skip_filter && (tun->filter_attached == true)) {
> 
> Wouldn't the re-attached queue then keep running the program that was
> removed? TUNGETIFF would also not report IFF_NOFILTER for that queue.
> 
>>  
>> -static int tun_attach_filter(struct tun_struct *tun)
>> +static int tun_attach_filter(struct tun_struct *tun,
>> +			     struct sock_fprog_kern *fprog_kern)
>>  {
>>  	int i, ret = 0;
>>  	struct tun_file *tfile;
>> @@ -3081,15 +3156,29 @@ static int tun_attach_filter(struct tun_struct *tun)
>>  	for (i = 0; i < tun->numqueues; i++) {
>>  		tfile = rtnl_dereference(tun->tfiles[i]);
>>  		lock_sock(tfile->socket.sk);
>> -		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
>> +		ret = sk_attach_filter_kern(fprog_kern, tfile->socket.sk);
>>  		release_sock(tfile->socket.sk);
>> -		if (ret) {
>> -			tun_detach_filter(tun, i);
>> -			return ret;
>> -		}
>> +		if (ret)
>> +			goto out_detach;
>>  	}
>>  
>>  	tun->filter_attached = true;
>> +	return 0;
> 
> [Severity: Medium]
> What happens here when tun->numqueues is 0?
> 
> You can detach every queue of a multiqueue TAP with TUNSETQUEUE and
> IFF_DETACH_QUEUE. __tun_detach(tfile, false) leaves tfile->tun set, so
> TUNATTACHFILTER can still be issued on a disabled queue's fd.
> 
> In that case the loop never calls sk_attach_filter_kern(), so
> bpf_prog_create() never sees the program. tun_copy_filter() only ran
> bpf_prog_validate_classic(). That skips the s16 jump offset check in
> bpf_convert_filter() and the runtime selection.
> 
> tun_attach_filter() still sets filter_attached and returns 0. The ioctl
> then frees the previously saved program and commits the unbuilt one:
> 
> 	kfree(tun->fprog_kern.filter);
> 	tun->fprog_kern = fprog_kern;
> 	tun->fprog = fprog;
> 
> Here is an example. Take a 4096 instruction program made of JA k=4094,
> then 4094 x LDX|B|MSH k=0, then RET|K. It passes bpf_check_classic(). Each
> LDX|B|MSH expands to roughly 18 eBPF instructions, so the converted JA
> offset is far above S16_MAX, and bpf_convert_filter() returns -EINVAL.
> 
> Now that the inverted check in tun_attach() is fixed, wouldn't every
> later IFF_ATTACH_QUEUE fail in sk_attach_filter_kern(&tun->fprog_kern,
> ...) until TUNDETACHFILTER is issued? The same goes for every TUNSETIFF
> without IFF_NOFILTER.
> 
> The commit message says:
> 
>   Such a late failure does not replace the saved program: the copy is
>   committed to tun->fprog and tun->fprog_kern only after
>   tun_attach_filter() installed it on every queue.
> 
> That guarantee doesn't seem to hold when there are no active queues.
> 
This is the late discovery Willem accepted in his review of the previous
version. The program is stored after passing the classic verifier, the
first attach that builds it returns -EINVAL, and TUNATTACHFILTER can be
reissued.

You are right that the commit message sentence is vacuously true when
there are no queues. The intent is that a failed attach does not replace
the saved program, not that the program has necessarily been built.
>> +
>> +out_detach:
>> +	/* Drop the copies already installed on queues 0..i-1, which leaves
>> +	 * them without a filter: their previous sk_filter, if any, was
>> +	 * already replaced and released. The caller does not replace the
>> +	 * saved program when this fails, so tun->fprog, tun->fprog_kern and
>> +	 * filter_attached keep their previous values.
>> +	 */
>> +	while (i--) {
>> +		tfile = rtnl_dereference(tun->tfiles[i]);
>> +		lock_sock(tfile->socket.sk);
>> +		sk_detach_filter(tfile->socket.sk);
>> +		release_sock(tfile->socket.sk);
>> +	}
> 
> [Severity: Medium]
> Can this rollback leave the device in a self-contradictory state?
> 
> Suppose sk_attach_filter_kern() succeeds on queues 0..i-1 and then fails
> on queue i. Each successful call already went through __sk_attach_prog(),
> which released the old filter F through sk_filter_uncharge(). This loop
> then clears sk_filter on queues 0..i-1, while queues i..n-1 keep F.
> 
> Before this patch, tun_detach_filter() ran here and cleared
> filter_attached. Now filter_attached stays true, and the ioctl leaves
> tun->fprog and tun->fprog_kern set to F. TUNGETFILTER reports F, and
> tun_attach() installs F on queues attached later.
> 
> Queues 0..i-1, however, run no filter at all. tun_net_xmit() only filters
> when sk_filter is set:
> 
> 	if (tfile->socket.sk->sk_filter) {
> 		drop_reason = sk_filter_reason(tfile->socket.sk, skb);
> 
> TUNGETIFF also reports IFF_NOFILTER for those queues.
> 
> A bad program isn't needed to get here. Once validation has passed, queue
> i can still fail with -ENOMEM from bpf_prog_alloc() (memcg charged) or
> from kmalloc_obj() in __sk_attach_prog(). It can also fail when
> __sk_filter_charge() would exceed optmem_max.
> 
> The comment here and the commit message say restoring the previous
> program "would need an extra reference per queue". Since F's
> instructions are still in tun->fprog_kern, couldn't the rollback rebuild
> F with sk_attach_filter_kern(&tun->fprog_kern, sk) instead?
> 
> Another option is to build and charge all the new programs before
> swapping any of them in, which would avoid this fail-open window.
> 
This is not a new state. Before this series the same failure went through
tun_detach_filter(tun, i), which also dropped the filter from queues
0..i-1, left queues i..n-1 on the old program, and cleared filter_attached
while tun->fprog already held the new header. This series keeps
tun->fprog, tun->fprog_kern and filter_attached describing the program
that queues i..n-1 still run, so later attaches retry it.

The rebuild suggestion does not remove the failure: __sk_attach_prog()
uncharges the old sk_filter as soon as the replacement is installed, so
queues 0..i-1 no longer hold it, and rebuilding from tun->fprog_kern is a
new bpf_prog_create() on the path where that allocation just failed. It
can fail for the same reason and would need its own fallback. Building and
charging every program before swapping would require splitting
__sk_attach_prog(), which is a filter core change and not something I
would mix into this fix. I am leaving this as a known limitation of the
error path.
>> +
>>  	return ret;
>>  }
> 
> [ ... ]
> The two selftest nits are valid; I can fold them in if another version is
needed.

