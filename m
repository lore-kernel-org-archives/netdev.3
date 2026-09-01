Received: from mta1.migadu.com (out-59.mta1.migadu.com [95.215.58.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F9239D6FA
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 01:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225854; cv=none; b=TFfRjFaP0a6tjiQi4AcNlN7EuyX/5323T18ALgX+Lsz6QJSlMqzRdtxDiwLh31xWzA+bk6PbHt9xNsJvNWSe9Pf1e14nf6prFI4j43zRddIKf+MxSqygcwH1cdKJed8LCscV0upO8zs4eh4lkSVHcZsCi1/SG2PtafzmBNcM8cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225854; c=relaxed/simple;
	bh=iWpoK28RPhpEG9h6a+SpBJXlvuFmjpQg8gVKJEmgDEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGAG3GUFx+zvPUymjob0hFq9bbdBRdAm52Qn20YXWWx/US0aD7+SN+TdznI+1Q4EJcSzZnsg0i2G3sHhXHKCqfD1ZigvNKCmMKPgpxipSDPdxQsorXTNj2fDkbGJklD+yMkml5HFmLfNaU+1B5o5GDoWAcI9RGuThtiV6YkvYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PwNl/2Ky; arc=none smtp.client-ip=95.215.58.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PwNl/2Ky"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=iWpoK28RPhpEG9h6a+SpBJXlvuFmjpQg8gVKJEmgDEo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788225847; v=1; x=1788830647;
 b=PwNl/2Ky3QV24DhiE6mTQcp5v+etDUp2jMJRFGzvx6BEO3cWf+kDmxyrMH36zcBBwdzGePlZ
 t11wrV/qduYj/eGTP7zfbIup6IQJTt2abQYgjozDW8NjF4eEzA5jMXOphYqUWuNX97/2mGe6R+8
 JfYFuem0e+5+BtYDM58I+BY4=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5176e71f97516690;
	Tue, 01 Sep 2026 01:24:07 +0000
X-Mizu-Trace-ID: 5176e71f97516690
X-Migadu-Flow: FLOW_OUT
Message-ID: <1a07addd-6d7f-4c5b-a1da-7f97e1e15376@linux.dev>
Date: Tue, 1 Sep 2026 09:24:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] mac802154: drain mac_wq before unregistering
 interfaces
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex.aring@gmail.com,
 stefan@datenfreihafen.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260828101905.26865-1-xuanqiang.luo@linux.dev>
 <87jyp6btia.fsf@bootlin.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <87jyp6btia.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/31 16:10, Miquel Raynal 写道:
> On 28/08/2026 at 18:19:05 +08, Xuanqiang Luo <xuanqiang.luo@linux.dev> wrote:
>
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> ieee802154_unregister_hw() unregisters the wpan netdevs before
>> destroying mac_wq. The RX path stores the receiving sub-interface
>> (sdata) in the queued MAC command descriptor without taking a
>> reference to the netdev.
>>
>> If mac802154_rx_mac_cmd_worker() runs after the netdev has been freed,
>> it dereferences the stale pointer and triggers a KASAN
>> slab-use-after-free:
>>
>>    BUG: KASAN: slab-use-after-free in mac802154_rx_mac_cmd_worker+0xc0/0x498 [mac802154]
>>    Read of size 8 at addr ffff0000c6db0ba8 by task kworker/u16:3/61
>>    ...
>>    Call trace:
>>     show_stack+0x20/0x38 (C)
>>     dump_stack_lvl+0x78/0x90
>>     print_address_description.constprop.0+0x88/0x398
>>     print_report+0xa8/0x278
>>     kasan_report+0xa8/0xf8
>>     __asan_load8+0x9c/0xc0
>>     mac802154_rx_mac_cmd_worker+0xc0/0x498 [mac802154]
>>     process_one_work+0x334/0x8b8
>>    ...
>>    Allocated by task 630:
>>     kasan_save_stack+0x2c/0x58
>>     kasan_save_track+0x20/0x40
>>     kasan_save_alloc_info+0x40/0x58
>>     __kasan_kmalloc+0xa0/0xb8
>>     __kvmalloc_node_noprof+0x1e8/0x588
>>     alloc_netdev_mqs+0x74/0x7f0
>>     ieee802154_if_add+0xac/0x630 [mac802154]
>>     ieee802154_register_hw+0x31c/0x3d0 [mac802154]
>>     fakelb_add_one+0x250/0x318 [fakelb]
>>    ...
>>    Freed by task 652:
>>     kasan_save_stack+0x2c/0x58
>>     kasan_save_track+0x20/0x40
>>     kasan_save_free_info+0x4c/0x78
>>     __kasan_slab_free+0x60/0x90
>>     kfree+0x194/0x478
>>     kvfree+0x44/0x60
>>     netdev_release+0x4c/0x68
>>     device_release+0xac/0x130
>>     kobject_cleanup+0x84/0x248
>>     kobject_put+0x98/0xf8
>>     netdev_run_todo+0x3a0/0x5e0
>>     rtnl_unlock+0x18/0x30
>>     ieee802154_unregister_hw+0x48/0x90 [mac802154]
>>     fakelb_remove+0xe8/0x148 [fakelb]
>>
>> After killing local->tasklet, drain mac_wq before calling
>> ieee802154_remove_interfaces() so pending work completes before the
>> interfaces are unregistered. Do this without holding rtnl because scan
>> and beacon workers acquire it themselves.
>>
>> Fixes: d021d218f6d9 ("mac802154: Handle received BEACON_REQ")
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> Missing Cc: stable.
>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> Thanks,
> Miquèl

Thanks.

I see Sashiko has also found a few new issues, which look valid.
I'll address them as well in the next revision.

pw-bot: cr

