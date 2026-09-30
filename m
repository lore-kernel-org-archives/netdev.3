Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DFB2D5436
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735004; cv=none; b=eI0D/oDoQRRJHTDTVR+baThyJyIFkFnUryoLRJHor+iW+Rf+TtnX28rAdy0ZkrIXQy1Hddj+GeMyWspejtMHyW3BKMxNob08sU0/UWgkFBBw4ry/N6oUkkXXZnyZRznMVy0SoPYwLjvZahybfsi06vgtg351aBDCjFU+LgEaYeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735004; c=relaxed/simple;
	bh=vWyNH9j23nzvJaETMr7OjRmjc97OuoI7lCAuDMBP1wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCKXBaXP3g7BBwA/YC58dxU7ssley33xaZ59xaGo7zVi01wBtkXkhhLOT5gFZ4y1MUbRQz9oYk8Mk2uBejPXRlbGmLkvN6dZ77N3A6wQDpAF52koNeyfp53oFPHxkLF6twYNUPEvrrJq/Fk+7qp7/il8OtQUEIlEa9qQs9Qnb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e45bc048bc7511f19a56ed5b684f684d-20260930
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0003a13d-6830-49f5-a6da-d48e2fb16e8f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:78f5e5b0af24b8e267b8e7e274b84f5f,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|136|865|898,TC:nil,Content:0|15|50
	|99,EDM:-3|-100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e45bc048bc7511f19a56ed5b684f684d-20260930
X-User: weirongguang@kylinos.cn
Received: from [10.42.124.137] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <weirongguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1957401688; Wed, 30 Sep 2026 10:23:15 +0800
Message-ID: <515454c7-9c85-44a9-9937-7944b2395246@kylinos.cn>
Date: Wed, 30 Sep 2026 10:23:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] tun: fix inverted error check when re-attaching
 the filter
To: bot+bpf-ci@kernel.org, clementwei90@163.com, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
References: <20260929093712.131096-2-clementwei90@163.com>
 <8edfca6d5f5f89f19158fb9b1595f565f550beee37dd874026baf17c936226a8@mail.kernel.org>
Content-Language: en-US
From: weirongguang <weirongguang@kylinos.cn>
In-Reply-To: <8edfca6d5f5f89f19158fb9b1595f565f550beee37dd874026baf17c936226a8@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



on 2026/9/29 18:34, bot+bpf-ci@kernel.org wrote:
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 5a302709a68a..a2fffef3735f 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -728,6 +728,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>>  {
>>  	struct tun_file *tfile = file->private_data;
>>  	struct net_device *dev = tun->dev;
>> +	bool rollback_filter = false;
>>  	int err;
>>
>>  	err = security_tun_dev_attach(tfile->socket.sk, tun->security);
>> @@ -754,8 +755,9 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>>  		lock_sock(tfile->socket.sk);
>>  		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
>>  		release_sock(tfile->socket.sk);
>> -		if (!err)
>> +		if (err)
>>  			goto out;
>> +		rollback_filter = true;
>>  	}
> 
> Does this change the behavior for cases where tun->fprog.filter holds a
> __user pointer from a different process?
> 
> When TUNATTACHFILTER runs, it copies only the sock_fprog header:
> 
>     case TUNATTACHFILTER:
>         ...
>         if (copy_from_user(&tun->fprog, argp, sizeof(tun->fprog)))
> 
> This means tun->fprog.filter still points into the address space of the
> process that issued that ioctl. When sk_attach_filter() runs here, it
> calls __get_filter() which does:
> 
>     copy_from_user(prog->insns, fprog->filter, fsize)
> 
> in the context of the current process.
> 
> For a persistent TAP, if process A creates it and runs TUNATTACHFILTER
> with a filter array on its stack or heap, then closes the fd, and process
> B later opens /dev/net/tun and runs TUNSETIFF on the same name without
> IFF_NOFILTER, the fprog.filter pointer may not be valid in process B's
> address space.
> 
> Before this patch, when sk_attach_filter() failed (which was actually the
> success case due to the inverted check), the err value was overwritten by
> later operations (xdp_rxq_info_reg() followed by 'err = 0'), so the queue
> was published and TUNSETIFF succeeded, just without a filter installed.
> 
> After this patch, if the pointer is unmapped, __get_filter() returns
> -EFAULT and TUNSETIFF now fails. If it happens to be mapped but holds
> other data, bpf_prepare_filter() usually returns -EINVAL and TUNSETIFF
> fails. When the bytes happen to pass validation, they become the filter of
> a queue that actually gets published.
> 
> This affects both the persistent TAP case described above and multi-queue
> setups where another queue is opened after the buffer holding the original
> filter has been freed or reused.
> 
> The next patch in the series, 508f529200c5 ("tun: keep a kernel copy of
> the socket filter program"), addresses this by storing a kernel copy of
> the filter program. That commit's changelog describes exactly this
> behavior: "unmapped there, the attach fails with -EFAULT; mapped,
> whatever bytes it holds become the filter of the new queue". It relies on
> 8c6a2cf8bd0a ("net: filter: add sk_attach_filter_kern() function").
> 
> Until that commit is applied, this patch changes the re-attach behavior
> from succeeding (without filter) to failing (with -EFAULT or -EINVAL).
> Both commits carry the same Fixes: tag, so a stable backport or bisect
> that includes only this commit would encounter the problem.
> 
> Would it make sense to reorder these commits, putting the kernel-copy
> change before the inverted-check fix, so every step of the series works?
> 
Yes, thank you.  

I have reordered the series as you suggest, it now is:

  1/4 net: filter: add sk_attach_filter_kern() function
  2/4 tun: keep a kernel copy of the socket filter program
  3/4 tun: fix inverted error check when re-attaching the filter
  4/4 selftests: net: add TAP socket filter attach tests

I will send it as v3.
>> @@ -817,6 +819,11 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>>  	WRITE_ONCE(tun->numqueues, tun->numqueues + 1);
>>  	tun_set_real_num_queues(tun);
>>  out:
>> +	if (err && rollback_filter) {
>> +		lock_sock(tfile->socket.sk);
>> +		sk_detach_filter(tfile->socket.sk);
>> +		release_sock(tfile->socket.sk);
>> +	}
>>  	return err;
>>  }
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36552651982
