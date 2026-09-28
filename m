Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA4C19B5A3
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 02:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790560978; cv=none; b=Dh8XY0fStLbvz3nuLlscayECe1LNxaIIPlQnnQOav3DxCD8EHCd86KGm9Yvw28D9hEOW+14SCkIB3NJ7zZBp2zL52dAr8BSU253XOYONQJtuuW7zcn3xnHSpRVpPUpyW0Pq2jq8LDCU8/6v1fqeF8LWNlh2smXTPTM+ZEssHhDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790560978; c=relaxed/simple;
	bh=5GbDkcW9kJg6D1sIxUw1f1u+t5UxsZTMWb7SU7KHdHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIK85MdvkbBCZbw+v77NetuWHd6z7SmV/Kwg/u2R3uzIRCqnrKJdt8TiZ6KUZipGWxUudywBA4etrMUuumjcZxUcC2Rq5C4iaec1HXHmwYkFJ/kWWq0xMb8E4d/c14rZVrjiHubZQxLnlrxwd87rOLyD6Y5PEDrT3FVaNrSN4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QRl860/A; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QRl860/A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=1NS/NiGsU69BuwXigG/vr0mjpU1XKCRQ008g0M+kyDs=;
	b=QRl860/ACon7LHd4/c5JPVSaFzlkpeKuzhtZOWU9WW1cahv3qhmTGMJxIo8Z20
	zftl99Z7bjToBox3ELUR+88dHlLSAby8F17fe8nSPFMTnOWZ4tz7ZWeZg5vjmsqa
	rWYSTZ+4eiiSX130VJshlim9f9XZi/0HHJkW3DasQPNZM=
Message-ID: <96df20dd-1009-4fec-b2ea-b41335e26d37@163.com>
Date: Mon, 28 Sep 2026 10:02:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] tun: fix inverted error check when re-attaching
 the filter
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jasowangio@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, weirongguang@kylinos.cn, kuba@kernel.org
References: <20260923025653.59348-1-clementwei90@163.com>
 <179027275318.2160803.4185895144088175048@kernel.org>
 <willemdebruijn.kernel.e57431dca72e@gmail.com>
Content-Language: en-US
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <willemdebruijn.kernel.e57431dca72e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H1CYyrlqSVDwBA--.44504S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtFy3AryxXrW5urWUKrW8Xrb_yoWxGw1kpF
	WrW3W5KrWDXa40v3sFka1UXF1Fv347JF1Uurn5J3s8uF98Wr12v3y3GFW5u3ZrAr4rC3W0
	vr4UK3srZw1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsvttUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4hvhTWq5ypuOUAAA3J



on 2026/9/26 01:15, Willem de Bruijn wrote:
> netdev-bot+sashiko@ wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 0 · Medium: 1 · Low: 1
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [Medium] The re-attach path that this patch enables rebuilds the queue
>>   filter from a stale userspace pointer, and reads it in the wrong…
>> - [Low] With the check inverted, a successful sk_attach_filter() in
>>   tun_attach() (drivers/net/tun.c:755) no longer returns early.
>>
>> --
>>
>> tun: fix inverted error check when re-attaching the filter
>>
>> This patch inverts the error check after sk_attach_filter() in
>> tun_attach(). A successful filter re-attach now continues on to publish
>> the queue, and a failed one aborts the attach.
>>
>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>>> index 5a302709a68aa..09720883b9a10 100644
>>> --- a/drivers/net/tun.c
>>> +++ b/drivers/net/tun.c
>>> @@ -754,7 +754,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>>>  		lock_sock(tfile->socket.sk);
>>>  		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
>>>  		release_sock(tfile->socket.sk);
>>> -		if (!err)
>>> +		if (err)
>>>  			goto out;
>>>  	}
>>>  
>>
>> [Severity: Low]
>> A successful sk_attach_filter() now falls through. If a later step in
>> tun_attach() fails, can the filter stay attached to a socket that was
>> never published?
>>
>> After this point, tun_attach() can still fail here:
>>
>> 	if (!tfile->detached &&
>> 	    ptr_ring_resize(&tfile->tx_ring, dev->tx_queue_len,
>> 			    GFP_KERNEL, tun_ptr_free)) {
>> 		err = -ENOMEM;
>> 		goto out;
>> 	}
>>
>> It can also fail in xdp_rxq_info_reg() or xdp_rxq_info_reg_mem_model().
>> None of these error paths call sk_detach_filter(tfile->socket.sk).
> 
> This is a real point.
> 
> This patch fixes the intent of the original patch by inverting the
> check.
> 
> But the state change should also be reverted if tun_attach fails later
> on. The only similar example is xdp_rxq_info_reg further down, which
> does get reverted if xdp_rxq_info_reg_mem_model fails.
>  
>> By comparison, tun_attach_filter() rolls back when it fails:
>>
>> 		if (ret) {
>> 			tun_detach_filter(tun, i);
>> 			return ret;
>> 		}
>>
>> The fd can then be reused. One way is to retry TUNSETIFF with
>> IFF_NOFILTER, which sets skip_filter and skips the re-attach block.
>> Another is to attach to a different device that has no filter. Neither
>> clears sk_filter, since only tun_detach_filter() calls sk_detach_filter().
>>
>> tun_net_xmit() would then apply the leftover filter to packets:
>>
>> 	if (tfile->socket.sk->sk_filter) {
>> 		drop_reason = sk_filter_reason(tfile->socket.sk, skb);
>>
>> TUNGETIFF would also leave IFF_NOFILTER unset, even though it was
>> requested.
Thank you, v2 will add the missing rollback and detach the filter again if a
later step of tun_attach() fails.
>>
>> The commit message says "nothing is published at that point, so the
>> attach can be aborted cleanly". Is that only true when sk_attach_filter()
>> itself is the step that fails?
You are right and I will drop that sentence and describe the rollback instead.
>>
>> [Severity: Medium]
>> This path now installs the rebuilt filter on a live queue. Is
>> tun->fprog still safe to reuse at this point?
>>
>> TUNATTACHFILTER in __tun_chr_ioctl() copies only the sock_fprog header:
>>
>> 		if (copy_from_user(&tun->fprog, argp, sizeof(tun->fprog)))
>> 			break;
>>
>> That leaves tun->fprog.filter as a __user pointer from the process that
>> issued the ioctl. On a persistent device, tun->filter_attached stays true
>> after all queues are closed.
>>
>> Later calls reach the re-attach through this path. That includes
>> TUNSETIFF without IFF_NOFILTER, and TUNSETQUEUE with IFF_ATTACH_QUEUE,
>> which always passes skip_filter = false:
>>
>> tun_set_iff() / tun_set_queue()
>>   tun_attach()
>>     sk_attach_filter(&tun->fprog, sk)
>>       __get_filter()
>>         copy_from_user(prog->insns, fprog->filter, fsize)
>>
>> That read goes through current->mm. The caller may be a different process
>> from the one that set the filter. It may also be the same process after
>> the instruction buffer was freed or remapped.
> 
> This is a very good point.
> 
> It is a separate bug from this one, and should be a separate fix.
> 
> The BPF program should be copied into the kernel immediately if it
> can be attached again later.
> 
> But, as the below text explains, flipping the test may now fail
> TUNSETIFF because sk_filter_attach fails, where previously it would
> continue since sk_attach_filter error is expected (even if it did
> complete without the filter installed as intended). Ideally, both
> fixes are sent together, but I won't hold anyone to that.
>I intend to send it as a second patch in the series.
>>
>> Before this patch, the rebuilt filter never ended up on a working queue.
>> When the re-attach succeeded, the queue was not published. When it failed,
>> the queue was published without a filter and TUNSETIFF returned 0.
>>
>> With the check inverted, there are two cases.
>>
>> If the address is not mapped in the caller, TUNSETIFF and TUNSETQUEUE
>> now fail with -EFAULT. If the bytes there are not valid classic BPF, they
>> fail with -EINVAL. Does this mean a new opener of a persistent TAP with a
>> filter can no longer attach unless it passes IFF_NOFILTER?
>>
>> If the address happens to be mapped, whatever bytes it holds become the
>> queue's filter, not the program the administrator installed. On a
>> multiqueue TAP, could different queues end up with different filters?
>>
>> For this re-attach to work correctly, would it need a kernel-owned copy?
>> That could be a saved copy of the instructions, or a refcounted struct
>> bpf_prog or sk_filter.>> -- 
>> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923025653.59348-1-clementwei90%40163.com
> 
pw-bot: cr

