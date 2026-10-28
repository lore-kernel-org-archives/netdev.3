Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793170150;
	b=aBCx/3Ul42ORT8aubALhQUzH755MB+N/b0ahnGuzMUP3pzz/4SaKOX7baufdUE25zT2b
	 Aq5L+qa8uPWeeeAxkULwRmInQ4qVrHxnCvJmVe8TOOoE/jmLJic7IkRCbtXX0DA+ZsW5b
	 oUogoTUQuIjR9/lyKTEE9BEhtw3sebJKcyrYlO15GaCDaVfVXuGgnssHURoqalFnEdPji
	 31Eqte2bjMWoBmM5IcSCIRz6n5Zp9KZzdydkbMtbXbDWSBxYljM3igJqPvgg6LihBhtUs
	 h3EbX0DFCo1lhcqmhE8cWQW2KOgaavlkruwaGN/sJjNQGWSpcIxaT5HvrtRqDk0i1lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793170150;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=LLbPG2usd0qbwQ4hO+AgmOgJRcy+RI4oQWi93X1+FLE=;
	b=5HJ0qdSn4TvIwBqeNZAXHZqZNdw330NXlLKFoOVkb/+6YcFIarLaaPBt4dk9gjRV4zI9
	 xMpeILwIWYb0HeCPnAXXBR+2SJI3qzQFRGVo5GCWg46KBh0nWcjITt7KisP+Eca77drbI
	 4/ziQ6VnARuRorExpgdbtvLEvLiFMBaCMeUycC/YQb+Af23gZLwS2wZQYkQP7YxYGTdVy
	 17TdLqMFFe2oaD8Zu07uzFyoRV2Qcy/7qnUIivcmaj4FprhWhfl/lKSOf6kcOTk5TiSf6
	 T5vFfPNNbeW/Pac5vZWjT0T/LIgR8RaJfWNpMMS9WMCmMxxpCJcdQM/r5srOA9lCn+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=a3YPGqOw;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C98606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 06:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06C98606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=a3YPGqOw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=LLbPG2usd0qbwQ4hO+AgmOgJRcy+RI4oQWi93X1+FLE=;
	b=a3YPGqOwr+umV+b6QAXPr7c0PbfoYooCI76ZH/DQ+tufl04FT5ooyw+wus7O5R
	Oep5C1at267coBCdLSlaF+HRpKCxfCpdxVCTIBARc/8d7LKoACgv+pqHRpnLrvfo
	DdVOxKr0Rz23aSK4QVfK3BFHD/q3gc39GrdjJ0E0IpgYo=
Message-ID: <9708bebe-2e54-46bc-b9a8-97ad59b37793@163.com>
Date: Wed, 28 Oct 2026 14:48:37 +0800
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
Subject: Re: [PATCH net v7 1/2] tun: keep a kernel copy of the socket filter
 program
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jasowangio@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org, weirongguang@kylinos.cn
References: <20261023092239.186665-2-clementwei90@163.com>
 <179309578401.3134.11519975030981154705@kernel.org>
 <willemdebruijn.kernel.39836b1948cab@gmail.com>
Content-Language: en-US
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <willemdebruijn.kernel.39836b1948cab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBXWG_FmuFqNe8yCg--.56742S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtFyfJw1kCrW7Jw1fArykGrg_yoW7trWxpF
	WfWa4jvr1DWr40qwn2yryUZFyftwsrWF47Xrn8J348uFsIgryxu3y3Ca909asxArWrGw1F
	qa1jvasFgwn8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsvttUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4gnrV2rhmsktowAA3B

on 2026/10/27 22:05, Willem de Bruijn wrote:
> netdev-bot+sashiko@ wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 1 · Medium: 0 (2) · Low: 1
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [High] bpf_prog_validate_classic() does not run "the same checks that
>>   bpf_prog_create() performs", although its kernel-doc and the commit…
>> - [Low] The kernel-doc for the new exported helper
>>   bpf_prog_validate_classic() (net/core/filter.c) says it returns "0 if…
>>
>> Pre-existing issues:
>> - [Medium] This problem wasn't introduced by this patch, but a filter
>>   replacement that passes tun_copy_filter() and then fails on some queue…
>> - [Medium] This problem wasn't introduced by this patch, but
>>   TUNDETACHFILTER leaves disabled queues with their old socket filter,…
>>
>> --
>>
>> tun: keep a kernel copy of the socket filter program
>>
>> This commit keeps a kernel copy of the classic BPF program passed to
>> TUNATTACHFILTER in tun->fprog_kern. Each queue's filter is now built from
>> that copy with a new sk_attach_filter_kern() helper. It also fixes the
>> inverted error check in tun_attach(), and it validates the program up
>> front in tun_copy_filter() with a new bpf_prog_validate_classic() helper.
>>
>> Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
>>
>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>>> index 242899f7fd071..e7d9f4480a89f 100644
>>> --- a/drivers/net/tun.c
>>> +++ b/drivers/net/tun.c
>>
>> [ ... ]
>>
>>> +	/* The instructions are only verified when a program is built from
>>> +	 * them, which tun_attach_filter() does once per attached queue.
>>> +	 * Check them here as well: with no queue attached that would not
>>> +	 * happen at all, and, now that tun_attach() treats that error as
>>> +	 * fatal, every later attach would fail with -EINVAL instead of
>>> +	 * rejecting the program now.
>>> +	 */
>>> +	err = bpf_prog_validate_classic(insns, fprog.len);
>>> +	if (err) {
>>> +		kfree(insns);
>>> +		return err;
>>> +	}
>>
>> [Severity: High]
>> Does bpf_prog_validate_classic() really reject everything that
>> bpf_prog_create() rejects? Its kernel-doc and the commit message both say
>> it does:
>>
>>   "The instructions are verified with the new bpf_prog_validate_classic(),
>>   which runs the same checks as bpf_prog_create() on the copied program."
>>
>> The helper only runs bpf_check_basics_ok() and bpf_check_classic().
>> bpf_prog_create() also goes through this path:
>>
>> bpf_prog_create()
>>   bpf_prepare_filter()
>>     bpf_migrate_filter()
>>       bpf_convert_filter()
>>     bpf_prog_select_runtime()
>>       __bpf_prog_select_runtime()
>>
>> bpf_convert_filter() rejects any jump whose converted offset does not fit
>> in s16:
>>
>> 	if (off < off_min || off > off_max)
>> 		goto err;
>>
>> __bpf_prog_select_runtime() can also return -ENOTSUPP when a JIT is
>> required but did not run.
>>
>> Take a 4096 instruction program: BPF_JMP|BPF_JA with k=4094 at pc 0, then
>> 4094 BPF_LD|BPF_B|BPF_ABS loads of offset 0, then BPF_RET|BPF_K.
>> bpf_check_classic() accepts it. convert_bpf_ld_abs() expands each load
>> into 12 eBPF instructions, so the JA offset grows to about 49128, and
>> bpf_convert_filter() fails with -EINVAL.
>>
>> Suppose every queue on a multiqueue TAP has been disabled with
>> IFF_DETACH_QUEUE. tun_copy_filter() stores this program, and
>> tun_attach_filter() loops over zero queues and then does:
>>
>> 	tun->filter_attached = true;
>>
>> >From then on, every IFF_ATTACH_QUEUE, and every TUNSETIFF without
>> IFF_NOFILTER, calls sk_attach_filter_kern() in tun_attach() and gets
>> -EINVAL. With the corrected check, tun_attach() then takes the goto out
>> path and the queue is never published.
>>
>> Isn't this the "every later attach would fail with -EINVAL" case that the
>> comment above says is avoided?
>>
>> When queues are active, the same program fails at queue 0, and
>> tun_attach_filter() calls tun_detach_filter(tun, 0). That frees fprog_kern
>> and clears filter_attached, which doesn't seem to match this part of the
>> commit message:
>>
>>   "a TUNATTACHFILTER that no verifier would accept now fails early and
>>   leaves the previously attached filter in place."
>>
>> The sk_attach_filter_kern() kernel-doc in this same patch lists -EINVAL
>> from bpf_prog_create() and -ENOTSUPP as possible results. That also
>> suggests the two checks are not equivalent.
>>
>> Would it be more reliable for tun_copy_filter() to build the program once
>> with bpf_prog_create() and then destroy it, instead of calling
>> bpf_prog_validate_classic()?
> 
> This sounds to me as the perfect being the enemy of the good.
> 
> Even the addition of calling bpf_prog_validate_classic is a nice to have.
> This series fixes a real issue.
> 
> Yes, some issues are still only discovered later when the BPF program is
> built. But as long that late discovery is also handled well, that is
> acceptable.
Thanks Willem.

Rather than building the program twice, v8 keeps the cheap check and
commits the copy only after every queue accepted it. A late failure
drops the copies already installed and leaves tun->fprog, fprog_kern and
filter_attached alone. With numqueues == 0 the program is stored and the
first attach fails with -EINVAL.
In selftest, attach_filter_bad_prog_keeps_program() now also checks 
IFF_NOFILTER and a newly attached queue.


pw-bot: cr

