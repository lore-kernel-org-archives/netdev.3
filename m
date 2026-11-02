Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793584072;
	b=aLDu4wVUUjfciHkGf7e3jyQWztWcmJXb11gei+w3WytlqWEM90oDJzAeQtRDuhtvvoxP
	 nalo2eysdS8EsCGK2y4KkcPrAA86ff/m51RXzDsFvwsmHYnCjP2q4LzOZkfSkhbUzpVSx
	 6hBpglGom0jLsNF6DClzJoxUL8NDSRAXcXw/BAymrz5Rvqbt7Vncq4iiS8DfWlBVGObbX
	 Z+hBYlLtU4Zu/dJ84KuOwTEr4hliAtOyGjtmbjWzOWoUxv2AAFTOyFI0rHNAfUPO+00gG
	 XjT0KvdLNgptxyFqEKwJt06htXEId7LvhIgCW1OUc3G4Tj7YK1CXvLE0DXTdoyoDgBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793584072;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=87QF473lhBwzXWvdfv47kBoHcSx1mFvdXjT1cxSjmpI=;
	b=LF3ICFNy7nAhW73mNAC7RsaDnWwsGF/geDlARsTxPLCB1bEn0Je23sbnbSU0vr7j3VJu
	 cTo7i171QdkcrLrX+20cAPBh1fJPPoDbKWkwiJxHjKcqmnJeOCSpILVFRDpjX0lPuVejx
	 1ReyCgwHj8Lw7fdufqnYAKA96ILE1YyLu8h1deBb9b1W97OnXFYinOJHk4Z5p89RhV8q0
	 EbeHMZVPn8sqc5VLgIC95ylAiOgq+0OtI65mAdb5UtCGMSfNgzn4KO1IlC+Nc7KfrA+3j
	 x9PoufZEwZKbnQyl8zJMRltlkFUsoIDHoSr/zzHPzkvjM2V4c9iqODDrnbOM7l+KyXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A0606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 01:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 208A0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6412b3f2d65f11f19a56ed5b684f684d-20261102
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:08471f35-2a6c-46eb-84cc-d1d3922243c0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:1bf71b2f91bac7e91ef1dd6ddae6e066,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6412b3f2d65f11f19a56ed5b684f684d-20261102
X-User: weirongguang@kylinos.cn
Received: from [10.42.124.137] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <weirongguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2014858137; Mon, 02 Nov 2026 09:47:41 +0800
Message-ID: <9c8efccd-8c6d-4251-9b0c-13a28b21b49a@kylinos.cn>
Date: Mon, 2 Nov 2026 09:47:38 +0800
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
Subject: Re: [PATCH net v8 1/2] tun: keep a kernel copy of the socket filter
 program
To: netdev-bot+sashiko@kernel.org, clementwei90@163.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org
References: <20261028093235.148649-2-clementwei90@163.com>
 <179352795853.3131.17682057808307044265@kernel.org>
Content-Language: en-US
From: weirongguang <weirongguang@kylinos.cn>
In-Reply-To: <179352795853.3131.17682057808307044265@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 3 (1) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] If the device has no active queues, TUNATTACHFILTER saves a
>   program that has never been built.
> - [Medium] If TUNATTACHFILTER fails part-way, the device's filter record
>   no longer matches what its queues enforce.
> - [Medium] TUNATTACHFILTER now fills tun->fprog from an uninitialized
>   stack variable.
> 
> Pre-existing issues:
> - [Medium] Disabled (detached) queues keep their own sk_filter when
>   TUNDETACHFILTER runs.
> 
> --
> 
> tun: keep a kernel copy of the socket filter program
> 
> This commit makes TUNATTACHFILTER keep a kernel copy of the classic BPF
> program in tun->fprog_kern. Each queue now gets its program from that copy
> through a new sk_attach_filter_kern() helper, and the user pointer is no
> longer read again. It also fixes the inverted error check in tun_attach()
> and checks the program early with a new bpf_prog_validate_classic() helper.
> 
> Link: https://lore.kernel.org/netdev/179309578401.3134.11519975030981154705@kernel.org/
> 
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 439565a264ee7..ea6743e8ae600 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
> 
> [ ... ]
> 
>> @@ -726,12 +727,67 @@ static void tun_force_wake_queue(struct tun_struct *tun,
> 
> [ ... ]
> 
>> +	err = bpf_prog_validate_classic(insns, fp.len);
>> +	if (err) {
>> +		kfree(insns);
>> +		return err;
>> +	}
>> +
>> +	fprog->len = fp.len;
>> +	fprog->filter = fp.filter;
> 
> [Severity: Medium]
> Can this leak kernel stack bytes through TUNGETFILTER?
> 
> In __tun_chr_ioctl(), the caller's struct sock_fprog is a stack variable
> with no initializer:
> 
> 	case TUNATTACHFILTER: {
> 		struct sock_fprog_kern fprog_kern;
> 		struct sock_fprog fprog;
> 
> Only len and filter are written here. The padding between the unsigned
> short len and the filter pointer (6 bytes on 64-bit) is never set.
> 
> The ioctl then copies the whole struct into device state with
> tun->fprog = fprog, and TUNGETFILTER copies all of it back to user space:
> 
> 	if (copy_to_user(argp, &tun->fprog, sizeof(tun->fprog)))
> 
> Before this patch, copy_from_user() filled every byte of tun->fprog.
> 
> Would using *fprog = fp; here, or initializing fprog with {} in the ioctl,
> avoid this?
> 
>> +	fprog_kern->len = fp.len;
>> +	fprog_kern->filter = insns;
>> +
>> +	return 0;
>> +}
> 
uninitialized padding in tun->fprog: fixed in v9. tun_copy_filter()
zeroes the header before filling it in, so TUNGETFILTER no longer copies
stack bytes. Willem reported the same issue separately and it is fixed by
the same change.
> [ ... ]
> 
>> @@ -3070,10 +3139,14 @@ static void tun_detach_filter(struct tun_struct *tun, int n)
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
> This isn't a bug introduced by this patch, but what happens to queues that
> are disabled when TUNDETACHFILTER runs?
> 
> tun_detach_filter() only walks the active queues in tun->tfiles[0..n-1].
> The non-clean path of __tun_detach() also leaves the socket filter in
> place:
> 
> 	} else {
> 		tun_disable_queue(tun, tfile);
> 		tun_napi_disable(tfile);
> 	}
> 
> After TUNDETACHFILTER, filter_attached is false. When that queue comes back
> through TUNSETQUEUE IFF_ATTACH_QUEUE, tun_attach() skips the filter block:
> 
> 	if (!skip_filter && (tun->filter_attached == true)) {
> 
> Will the re-attached queue keep filtering with a program that userspace has
> already removed?
> 
>>  
>> -static int tun_attach_filter(struct tun_struct *tun)
>> +static int tun_attach_filter(struct tun_struct *tun,
>> +			     struct sock_fprog_kern *fprog_kern)
>>  {
>>  	int i, ret = 0;
>>  	struct tun_file *tfile;
>> @@ -3081,15 +3154,29 @@ static int tun_attach_filter(struct tun_struct *tun)
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
> The commit message says:
> 
>   Such a late failure does not replace the saved program: the copy is
>   committed to tun->fprog and tun->fprog_kern only after
>   tun_attach_filter() installed it on every queue.
> 
> Take a multiqueue TAP whose queues have all been detached with TUNSETQUEUE
> IFF_DETACH_QUEUE. tun_set_queue()->__tun_detach(tfile, false) lowers
> numqueues but keeps tfile->tun set, so the detached fd can still issue
> TUNATTACHFILTER. Then:
> 
>   tun_copy_filter()
>     bpf_prog_validate_classic()     <- classic checks only
>   tun_attach_filter()
>     for loop runs zero times
>     tun->filter_attached = true; return 0;
>   __tun_chr_ioctl()
>     tun->fprog_kern = fprog_kern;
>     tun->fprog = fprog;
> 
> The saved program has never been through bpf_prog_create().
> 
> The commit message notes that bpf_prog_create() can still refuse a program
> that passes bpf_check_classic(). Examples are the s16 offset check in
> bpf_convert_filter(), and bpf_prog_select_runtime() when a JIT is required.
> 
> tun_attach() now has the corrected check. After this, wouldn't every later
> filtered attach fail with that error until TUNDETACHFILTER is issued? That
> covers TUNSETQUEUE IFF_ATTACH_QUEUE and TUNSETIFF without IFF_NOFILTER.
> 
> Would a trial bpf_prog_create()/bpf_prog_destroy() in tun_copy_filter()
> catch these failures before anything is committed? The new
> bpf_prog_validate_classic() export would then not be needed. Its own
> kernel-doc says it does not cover these cases.
> 
numqueues == 0: this is deliberate. As Willem noted, late
discovery is acceptable as long as the failure is handled. The program is
stored after passing the classic verifier, the first attach that builds it
returns -EINVAL, and TUNATTACHFILTER can be reissued to replace it. Building
a program on every configuration to catch this earlier is not worth it.
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
> Does this leave the device filter state out of sync with what the queues
> enforce?
> 
> __sk_attach_prog() releases each queue's old sk_filter as soon as it
> installs the new one. Suppose sk_attach_filter_kern() fails on queue i > 0.
> This loop then leaves queues 0..i-1 with no filter, while queues i..n-1
> still run the old program.
> 
> tun->filter_attached, tun->fprog and tun->fprog_kern still describe the old
> program. TUNGETFILTER reports it as attached and queues attached later get
> it. Meanwhile, active queues 0..i-1 pass every packet unfiltered. Before
> this patch, the failure path went through tun_detach_filter(tun, i), which
> cleared filter_attached.
> 
> A failure at i > 0 looks reachable in two ways:
> 
> - -ENOMEM from bpf_prog_alloc() in bpf_prog_create(), or from
>   kmalloc_obj() in __sk_attach_prog().
> - __sk_filter_charge(). The new filter is charged before the old one is
>   uncharged, so a queue that already holds a large filter needs optmem for
>   both.
> 
> The commit message says restoring the previous program "would need an
> extra reference per queue". When a filter was attached before, the old
> instructions are still in tun->fprog_kern at this point. Could the rollback
> rebuild them with sk_attach_filter_kern(&tun->fprog_kern, sk) instead of
> calling sk_detach_filter()?
> 
the rollback would rebuild the old program, not reuse it. __sk_attach_prog()
uncharges the previous sk_filter as soon as the replacement is installed, so 
queues 0..i-1 no longer hold it.

That rebuild runs on the failure path, and the failure is an allocation or
optmem charge failure, so the rebuild can fail for the same reason and
would need its own fallback. A restore that cannot fail would have to keep
the old sk_filter alive until every queue took the new one, which changes
__sk_attach_prog() and is outside this fix.

The series keeps tun->fprog, tun->fprog_kern and filter_attached
describing the program that queues i..n-1 still run, so later attaches
retry it and TUNATTACHFILTER can be reissued. I would rather handle the
stronger restore separately.
>> +
>> +	return ret;
>>  }
> 
> [ ... ]
> 
v9: https://lore.kernel.org/netdev/20261030060043.94719-1-clementwei90@163.com/
pw-bot: cr

