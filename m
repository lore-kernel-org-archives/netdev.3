Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288223B8D77
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061685; cv=none; b=kQ6/c/sqyxUBZwiHDaEvg9DbyH5lLz7+fsvh5oqQ3uMXCaYxxIcqUsgIKIWRk2a6IzGaZOI3m6K5YXrSxPE82v/A6XMvajsgw5/AGQ9hDaOYBaTb+OUAuHGEvQ64j8wUct0ewuI4KpH+TdLT3h73fIfP1vIa4Qrm2UbuxboqxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061685; c=relaxed/simple;
	bh=VmtQMizc3J7dUfCn3/AItybu61OpLCH4tZu4e1DabLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWROJkCPIVdEKP6laOA0iqlapjjBVzxJtQ8cjC1j19yQ1FKWsKjyuBXe6BkiukfoTEFr4bCRUDHv0ikU0qtCT+mRYfs35LfiqGD6FIki8Ge4fn8O7DMeq7yEOqWooeE1oqEzFK839G4oWFuI35H6G0kg3prJOLmI5hI/7yJkTRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rNwMOjtf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FEzM9As/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rNwMOjtf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FEzM9As/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rNwMOjtf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FEzM9As/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rNwMOjtf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FEzM9As/"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B94B5BDC1;
	Mon,  9 Mar 2026 13:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773061679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s8Gbb+QyvkymgKzYqTMRAYUwowRbogok9A3auqid1ng=;
	b=rNwMOjtfjgDcwDa1efHPhSyvNLv8yMw2i7hhdv5D9EGNjlmPIGTbrmeh81UB03BCW5Nu5e
	MKjP/TjnjwKFpHXgZtnGTJVurNz7JXoS1SGqb0OkuSO1pu4XJEm05Gsyhu4tSw51EQUYLr
	FdynHuKnFWZfIJag84bA+29+UpreJTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773061679;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s8Gbb+QyvkymgKzYqTMRAYUwowRbogok9A3auqid1ng=;
	b=FEzM9As/oC08PhzOQcLwTvHdXh4eqMcZkb0hgc9fhe6WxMFLvauZ3ITnXOIuxjmcbA1tlm
	GO+6eD5iyE9yahBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773061679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s8Gbb+QyvkymgKzYqTMRAYUwowRbogok9A3auqid1ng=;
	b=rNwMOjtfjgDcwDa1efHPhSyvNLv8yMw2i7hhdv5D9EGNjlmPIGTbrmeh81UB03BCW5Nu5e
	MKjP/TjnjwKFpHXgZtnGTJVurNz7JXoS1SGqb0OkuSO1pu4XJEm05Gsyhu4tSw51EQUYLr
	FdynHuKnFWZfIJag84bA+29+UpreJTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773061679;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s8Gbb+QyvkymgKzYqTMRAYUwowRbogok9A3auqid1ng=;
	b=FEzM9As/oC08PhzOQcLwTvHdXh4eqMcZkb0hgc9fhe6WxMFLvauZ3ITnXOIuxjmcbA1tlm
	GO+6eD5iyE9yahBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B042A3EEF3;
	Mon,  9 Mar 2026 13:07:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bgkPKC7GrmnscAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 09 Mar 2026 13:07:58 +0000
Message-ID: <532259b4-f488-49ad-9d7e-29fed10d8092@suse.de>
Date: Mon, 9 Mar 2026 14:07:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10 net-next] Convert CONFIG_IPV6 to built-in and remove
 stubs
To: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org
References: <20260309022013.5199-1-fmancera@suse.de>
 <48ccec3f-dbc8-45c8-afda-e4f7e8f150d6@kernel.org>
 <cd87ed46-b774-4896-b25e-4806eec9e0b3@suse.de>
 <6c005900-3461-4e3c-a396-b2984735af9b@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <6c005900-3461-4e3c-a396-b2984735af9b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wikipedia.org:url,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO



On 3/9/26 1:43 PM, Krzysztof Kozlowski wrote:
> On 09/03/2026 12:38, Fernando Fernandez Mancera wrote:
>> On 3/9/26 11:22 AM, Krzysztof Kozlowski wrote:
>>> On 09/03/2026 03:19, Fernando Fernandez Mancera wrote:
>>>> Historically, the Linux kernel has supported compiling the IPv6 stack as
>>>> a loadable module. While this made sense in the early days of IPv6
>>>> adoption, modern deployments and distributions overwhelmingly either
>>>> build IPv6 directly into the kernel (CONFIG_IPV6=y) or disable it
>>>> entirely (CONFIG_IPV6=n). The modular IPv6 use-case provides little to
>>>> no practical benefit today.
>>>
>>> It does. We all use generic kernels, thus it is one configuration for
>>> all boards and some setups have IPv6 and some not. The ones without IPv6
>>> just don't use that module.
>>>
>>
>> While I understand this, I would like to clarify that IMHO IPv6 isn't a
>> secondary protocol and it is fundamental to modern networking. This is
> 
> Not for end user devices. None of my devices - neither routers, nor
> embedded boards, nor mobile phone from 5G provider - receive IPv6
> address, thus for them it is not fundamental.
> 

I am not so sure about this. Many if not most modern routers provide 
IPv6 support and as I said it is enabled as built-in in openWRT since 
[1]. For mobile phones they probably use IPv6 when connected to routers 
but even 5G providers are using IPv6. They are working on IPv6-only 
deployments with NAT64 too [2].

[1] 
https://github.com/openwrt/openwrt/commit/0c8f0186d58468024db96a5ab0ca36a4d400d408

[2] https://www.ietf.org/archive/id/draft-ma-v6ops-5g-ipv6only-01.html

> I agree it is fundamental for your cloud machines and network backbone
> which you are targeting, but this patchset completely ignores other
> users calling their use-cases "little practical benefit"! Try running
> Amiga machine...
> 
> There is no even bloatometer stats for these defconfigs so we can see
> the impact.
> 

Sure. I can provide them.

>> why I believe it should be built-in by default. Currently OpenWRT,
>> Debian ARM and others already ships the kernel with CONFIG_IPV6=y. I
>> know that Alpine and Yocto doesn't do that for arm64.
> 
> Maybe there are other reasons why distro should not choose it as module
> (like module load calls on ipv6 packets) but that was not explained here.
> 
> Arch Linux Rpi kernel on arm64 has IPV6=6 and the module itself is 650
> kB. That's noticeable for smaller arm64 boards.
> 
> For arm it would be even more noticeable as some have 256 MB RAM like
> first Rpi.
> 
>>
>> I guess the most critical one here is Yocto but if the developer of the
>> embedded device is sure they won't use IPv6 at all, they should turn it off.
>>
>> At the same time, Alpine ships software that enable IPV6 and is
>> frequently loaded as a module. So the only remaining concern would be
>> the boot partition size. I don't really have a solution for that problem.
>>
>> I think that the infrastructure for allowing IPV6=m is bug-prone and it
>> impacts performance. Forcing the use of indirect function calls in core
>> networking, Netfilter or BPF datapaths seems like a heavy tax to me.
>>
>>> Also, with these generic kernels (so again all machines are using same
>>> ones, e.g. distro) users can easily blacklist the module.
>>>
>>
>> FWIW; users can still boot with kernel command line parameter
>> ipv6.disable=1 and then IPV6 will be administratively disabled.
> 
> It's not the same. You enabled it on amiga_defconfig and do you
> understand what sort of machine is that? The newest have 16 MB RAM, many
> much less like 2 MB, and ipv6 module on m68k is 400 kB, so pretty
> significant change.
> 

Fair enough. Of course I am not familiar with all the architectures 
affected. This feedback is more than welcome and it might make a lot of 
sense to disable IPv6 on Amiga and probably different architectures. By 
the way if by Amiga you mean [3] then I believe it should be disabled.

[3] https://en.wikipedia.org/wiki/Amiga

Thanks,
Fernando.

