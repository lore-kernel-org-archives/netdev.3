Received: from mta0.migadu.com (out-107.mta0.migadu.com [91.218.175.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F26411F88
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157446; cv=none; b=bVDqCW4ynYbsBTUolA8mnI5oaBtnXsBPs+XlfwsjWBuQneUtRT0VDQOn7moR4lIt4CLSTjNQ/mgw8l8UE/WMY/d7FtjrTxj4fGRXi0G3Ed/5GPdBkEcCG1na0H9w020wQyJLERpWREIRGn4FLJOH6l31/KLu+6KCLkdbGTKcRe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157446; c=relaxed/simple;
	bh=6d7CmGfi1oUosIcp8Gxd5YdKxwhrzKotaECyrpU929A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSH/7d5xNqEI6tyLupTQMRBPd++iXeFj3OqhXgcOQFd+Cd9dRNXNuP9kwFejWSdW01YftfYB94pXrB0MyEqET4RTVgS4wES1PFuKmLiErIr8O/PrlMKLIwwxF0fzm3u4uELxCgz0zXwB58/iN+Zq6Lz7VYZCyg44APN+hKswZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sLjJdQkh; arc=none smtp.client-ip=91.218.175.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sLjJdQkh"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6d7CmGfi1oUosIcp8Gxd5YdKxwhrzKotaECyrpU929A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790157442; v=1; x=1790762242;
 b=sLjJdQkhOgqwuJHRdvhKmL6TglD0VX+VhZsx7+TrQB81HkRf/xIQ9rUPCl6bZ3AOmqoil6ez
 dKo6lRcRWhEon+ArxBneXDaEWWhh0ozDGVu4D6rhaOAxGVv9qPGMwqVDkk009+arqd+aVoWn6/u
 lr72knvRKB1bu3jn/t7wfeE8=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id aef8c51cf6c77559;
	Wed, 23 Sep 2026 09:57:22 +0000
X-Mizu-Trace-ID: aef8c51cf6c77559
X-Migadu-Flow: FLOW_OUT
Message-ID: <fcd7d1ec-d2d1-4dac-ad8f-245392f92fcd@linux.dev>
Date: Wed, 23 Sep 2026 17:57:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] pfcp: fix socket lifetime on netdevice
 registration failure
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 aleksander.lobakin@intel.com, wojciech.drewek@intel.com,
 marcin.szycik@linux.intel.com, linux-kernel@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260918123158.5631-1-xuanqiang.luo@linux.dev>
 <20260923092638.GS13925@horms.kernel.org>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260923092638.GS13925@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/9/23 at 17:29 Simon Horman wrote:
> On Fri, Sep 18, 2026 at 08:31:58PM +0800, Xuanqiang Luo wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> pfcp_newlink() creates the UDP socket before register_netdevice().
>> If registration fails after pfcp_dev_init() succeeds, the core calls
>> pfcp_dev_uninit(), which releases the socket and clears pfcp->sk.
>> The newlink error path then releases it again, causing a NULL pointer
>> dereference. This was observed with failslab fault injection:
>>
>>    FAULT_INJECTION: forcing a failure.
>>    kobject: kobject_add_internal failed for pfcp0 (error: -12 parent: net)
>>    BUG: KASAN: null-ptr-deref in udp_tunnel_sock_release+0x1c/0x50
>>    Read of size 8 at addr 0000000000000120 by task ip/1037
>>    Call trace:
>>     show_stack+0x18/0x24 (C)
>>     dump_stack_lvl+0x78/0x90
>>     print_report+0x468/0x5cc
>>     kasan_report+0xa4/0xf0
>>     __asan_load8+0x7c/0xd0
>>     udp_tunnel_sock_release+0x1c/0x50
>>     pfcp_newlink+0x128/0x184
>>     rtnl_newlink+0x848/0xe44
>>     rtnetlink_rcv_msg+0x468/0x514
>>     netlink_rcv_skb+0xc0/0x1f0
>>     rtnetlink_rcv+0x18/0x24
>>     netlink_unicast+0x4b8/0x558
>>     netlink_sendmsg+0x2b8/0x584
>>     ...
>>
>> Create the socket in pfcp_dev_init() after initializing the GRO cells,
>> and let pfcp_dev_uninit() release it on registration failure or removal.
>>
>> Move the RCU wait into pfcp_dev_uninit(), using synchronize_net() after
>> socket release to drain receive callbacks before destroying the GRO cells.
>>
>> Fixes: 76c8764ef36a5 ("pfcp: add PFCP module")
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>> A NULL check would fix the crash. Moving socket creation into ndo_init
>> also removes the duplicate cleanup and ensures the receive state is
>> initialized before enabling the socket's receive callback.
> 
> Assuming the NULL check is significantly simpler than this patch,
> and that it resolves the bug, think that we should consider:
> 
> 1. A patch that minimal NULL check for net
> 2. Follow-up with the approach taken by this patch in net-next
> 
> I say this because this seems to be lower risk than skipping to applying
> 2 to net.
> 
> Also, please consider CCing stable on bug fixes.
> 
> Link: https://docs.kernel.org/process/maintainer-netdev.html#stable-tree

That makes sense. I left stable off Cc because the lifecycle changes
seemed too broad for a stable fix. Splitting the two makes sense now.

I'll send a v2 for net with just the NULL check and Cc stable, then
follow up with the lifecycle changes once the fix reaches net-next.

Thanks for the suggestion!!

Xuanqiang
