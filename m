Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307BC314D34
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 03:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790911095; cv=none; b=Z0g8JGnxo5wTlVatrxPjcRc5FGL21ltFqERODmuDEBms1KsDTPsV3y9ztMcB+Agdq6BGuTxjJPDRUESCu4JFzPAL3NApAqGZzvLPRdctG+R57ZdYWofukL0Mrd/qdqgwRgSILHh/AoPTmOqAiwuHSiDEuRBfpXBgFmCcv1KQBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790911095; c=relaxed/simple;
	bh=UAoZuHLSA4uBiXSmgU7WAQcZeb9l1YFi+JXe1HB8Km8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvcJ9iSWNJZ9fLXjXPxmVwWpw7ianIu6ssxiYgvlzHzVBtq2/8VOvgcw6bwj3rO6da+eoAPBFBMhsrPcmPW0BQZ+mThIt8lRcV4SaY2VPA+gl3kHmIkjktCxSrZTPl41Ym7uT+WxrBN8oLx6Lh/FAidV25V9ExbWcI+PhMBL4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IydRNaPx; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IydRNaPx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=rg5Rx70yyttcQSaaRmufJ2l9vc5xQhN9jEptkOyWfMA=;
	b=IydRNaPxu3xkScCEOajWHH5QbqoOKz5yxSdIVxvf2bq9WCoQi8fMdbIGTHq3DP
	CnDqvQTDdXO1QVGtz58Rc+Pis/Ees8IX8AAMDsmjbu3FEImS5Fi60Xjz7eNGc/oI
	NeRW/WqxrlQSXyNAS2bRKy+WdgSkEJoG0QPUuRE2XiK44=
Message-ID: <7f8b21c4-324e-4cc5-b5d5-1f70f9b2749a@163.com>
Date: Fri, 2 Oct 2026 11:17:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] tun: fix inverted error check when
 re-attaching the filter
Content-Language: en-US
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, weirongguang@kylinos.cn
References: <20260930080746.135017-3-clementwei90@163.com>
 <179086384006.434549.3211680680874111813@kernel.org>
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <179086384006.434549.3211680680874111813@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3dyFZIr9qsXkMCA--.53770S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr45Xr17Zw4fur15Ww1kuFg_yoW7GF4kpF
	W5Wa45trs8WFW0q3s7ZF4UZFy5Zw1IgFyUur1rC345uFn8urya93yfKrW5Za9rAr4rua1I
	yr4jg34UZw1kZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UV7K3UUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4RoplGq-IlqLsQAA3R



on 2026/10/1 22:10, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The series cannot be bisected, and the commit message only
>   states the ordering constraint in one direction.
This is the same point as the High in the review of patch 1.
Make the two patches are merged to fix.
> 
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but the TAP
>   filter lifecycle treats disabled queues differently on detach and on…
> 
I will send that as a separate change.
> --
> 
> tun: fix inverted error check when re-attaching the filter
> 
> This commit fixes the inverted error check after sk_attach_filter_kern()
> in tun_attach(). Before the fix, a successful re-attach returned early and
> the queue was never published in tun->tfiles[]. The patch also detaches
> the filter again if a later step of tun_attach() fails.
> 
> Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
> 
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 22fb34e745bd9..c796048742f9b 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
> 
> [ ... ]
> 
>> @@ -783,8 +784,9 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>>  		lock_sock(tfile->socket.sk);
>>  		err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
>>  		release_sock(tfile->socket.sk);
>> -		if (!err)
>> +		if (err)
>>  			goto out;
> 
> [Severity: Medium]
> The commit message says:
> 
>     This has to come after the patch that keeps a kernel copy of the
>     program: ...
> 
> Doesn't the dependency also run the other way?
> 
> At the baseline, tun_attach() called sk_attach_filter(&tun->fprog, ...),
> which reads a stale user pointer. The inverted "if (!err) goto out" only
> fired when that pointer was still mapped and held a valid program.
> 
> After "tun: keep a kernel copy of the socket filter program", the call is
> sk_attach_filter_kern(&tun->fprog_kern, ...). That function works on a copy
> that tun_attach_filter() has already validated. In practice it succeeds,
> unless it hits -ENOMEM or SOCK_FILTER_LOCKED.
> 
> In that intermediate commit, every re-attach with tun->filter_attached set
> would take goto out with err == 0. Both of these paths reach it:
> 
>   tun_set_iff()->tun_attach(tun, file, ifr->ifr_flags & IFF_NOFILTER, ...)
>   tun_set_queue()->tun_attach(tun, file, false, ...)
> 
> TUNSETIFF, or TUNSETQUEUE with IFF_ATTACH_QUEUE, would return 0. The queue
> would never show up in tun->tfiles[], and tfile->tun would not be
> published.
> 
> This patch, the next one in the series, fixes that. However, both patches
> carry the same Fixes: 54f968d6efdb tag, and neither one says it needs the
> other.
> 
> The first patch looks like the standalone fix because it stops reading the
> user pointer. If a backport takes only that patch, could re-attach break
> for every TAP that has a filter?
> 
> Would it make sense to squash the two patches, or to note the dependency in
> both commit messages?
> 
>> +		rollback_filter = true;
>>  	}
> 
> [Severity: Medium]
> This is a pre-existing issue and was not introduced by this patch. The TAP
> filter lifecycle seems to treat disabled queues differently on detach and
> on re-attach.
> 
> TUNDETACHFILTER only walks the active queues:
> 
> drivers/net/tun.c:__tun_chr_ioctl() {
>     ...
> 	case TUNDETACHFILTER:
> 		...
> 		tun_detach_filter(tun, tun->numqueues);
>     ...
> }
> 
> drivers/net/tun.c:tun_detach_filter() {
>     ...
> 	for (i = 0; i < n; i++) {
> 		tfile = rtnl_dereference(tun->tfiles[i]);
> 		lock_sock(tfile->socket.sk);
> 		sk_detach_filter(tfile->socket.sk);
> 		release_sock(tfile->socket.sk);
> 	}
>     ...
> }
> 
> For IFF_DETACH_QUEUE, __tun_detach() runs with clean == false. That path
> calls tun_disable_queue() and tun_napi_disable() but never
> sk_detach_filter(), so a tfile parked on tun->disabled keeps its
> sk_filter.
> 
> tun_attach() only touches the filter when tun->filter_attached is true. It
> never clears a leftover filter.
> 
> Consider this sequence on a multiqueue TAP:
> 
>   TUNATTACHFILTER           (queue Q is active and gets the filter)
>   IFF_DETACH_QUEUE on Q     (Q moves to tun->disabled, filter kept)
>   TUNDETACHFILTER           (Q skipped, filter_attached = false)
>   IFF_ATTACH_QUEUE on Q     (re-attach branch in tun_attach() skipped)
> 
> Would Q then be active with the old classic BPF filter still installed,
> even though the device no longer has a filter? If so, packets on Q would
> still be filtered or truncated.
> 
> The baseline behaves the same way here, so this patch does not change
> it.
> 

