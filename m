Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBAA3DE429
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216334; cv=none; b=rrg6HSmxNNnEMCsSBgGEq8Tga1324MwrMIZv7W7qs63fKs4bt9uEgjWomH55ktTQxmkVGr8fgWAJ/Vq2qbVM+GKKTUbixDq3/FcTn9G9I5PcYDLDjiQWoq4LdT3EfJs/ZJCW2IycrEjJh4EOMYahkP4Che+ssjWFX/EJ4vDczmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216334; c=relaxed/simple;
	bh=PSEE1ZHrpIrOGqhtKVFTLlJfsbxfnJmnD7XLbDtuRVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gaf5KHKRRtvqOWzSIAikxFLzCdIrcyUeWqQ40F+mdKrVAyqssw4+Z0pIPYrwXBVv1dHdvxb1PjzdAe6y4M2bOs/TWx9w3FvP9DilyZ4IHU4+f6hUPkEgFtPwag+SFlO+RT0WTabYU4wFuzMUVCGKhAC/bN4tqbkapsJZLkmwS0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FukmzVEd; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FukmzVEd"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HjlpB81NplEGM8TmYOQ3yWrAodWhSKbszGQgPWMnYx8=;
	b=FukmzVEdGFs1NiSxH2WplLUQZedeebD5vtAS/y3UrHsLbOPdmvKvJrLDWfiZEI702R8buha4G
	seytvtgbA8lgvvhbtLFUlDJIkaRQfiY4JDRHtAZ7aSMgWXhCCqUKntZ7q71VDwoH6UdDIA8bX6e
	gFbsLWn8Eq64VnucH46I+q8=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hQcXH0tB1zLlTg;
	Thu, 20 Aug 2026 16:47:59 +0800 (CST)
Received: from whupemk200012.china.huawei.com (unknown [7.152.185.169])
	by mail.maildlp.com (Postfix) with ESMTPS id EDD5140578;
	Thu, 20 Aug 2026 16:58:40 +0800 (CST)
Received: from [10.174.177.223] (10.174.177.223) by
 whupemk200012.china.huawei.com (7.152.185.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 16:58:39 +0800
Message-ID: <53e86f6f-43b9-4e06-b185-1344f69cd650@huawei.com>
Date: Thu, 20 Aug 2026 16:58:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: iptunnel: fix stale transport header during
 tunnel decapsulation
To: Eric Dumazet <edumazet@google.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<horms@kernel.org>, <herbert@gondor.apana.org.au>, <kuniyu@google.com>,
	<idosch@nvidia.com>, <andrew+netdev@lunn.ch>, <ap420073@gmail.com>,
	<steffen.klassert@secunet.com>, <laforge@gnumonks.org>,
	<jiayuan.chen@linux.dev>, <jhs@mojatatu.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>,
	<syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com>
References: <20260813033855.3372172-1-dongchenchen2@huawei.com>
 <CANn89iLCrzmOfUVwa0yeROpkZxWmVsAkbH7=SBA3XuVxkmTfKA@mail.gmail.com>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <CANn89iLCrzmOfUVwa0yeROpkZxWmVsAkbH7=SBA3XuVxkmTfKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemk200012.china.huawei.com (7.152.185.169)


> On Thu, Aug 13, 2026 at 5:30 AM Dong Chenchen <dongchenchen2@huawei.com> wrote:
>>
>> Syzbot reported a crash in qdisc_pkt_len_segs_init() caused by a stale
>> transport_header offset after tunnel decapsulation.
>>
>> BUG: unable to handle page fault for address: ffffed102091a42e
>> Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>> CPU: 0 UID: 0 PID: 340 Comm: qdisc_uaf_repro Not tainted 7.2.0-rc4-00061-g248951ddc14d #256 PREEMPT(full)
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> RIP: 0010:__asan_load2
>> <IRQ>
>> qdisc_pkt_len_segs_init (net/core/dev.c:4145)
>> __dev_queue_xmit (net/core/dev.c:4787)
>> br_dev_queue_push_xmit (net/bridge/br_forward.c:53)
>> br_handle_frame_finish (net/bridge/br_input.c:229)
>> br_handle_frame (net/bridge/br_input.c:315)
>> __netif_receive_skb_core.constprop.0 (net/core/dev.c:6099)
>> __netif_receive_skb_list_core (net/core/dev.c:6287)
>> netif_receive_skb_list_internal (net/core/dev.c:6445)
>> napi_complete_done (net/core/dev.c:6813)
>> gro_cell_poll (net/core/gro_cells.c:74)
>> __napi_poll (net/core/dev.c:7735)
>> net_rx_action (net/core/dev.c:7798 net/core/dev.c:7955)
>> handle_softirqs (kernel/softirq.c:622)
>> do_softirq (kernel/softirq.c:523  kernel/softirq.c:510 )
>> __local_bh_enable_ip (kernel/softirq.c:450)
>> tun_get_user (drivers/net/tun.c:1986 (discriminator 1))
>> tun_chr_write_iter (drivers/net/tun.c:2032)
>>
>> The crash requires four conditions to line up:
>>
>> 1. The incoming packet is encapsulated and carries GSO metadata.  The outer
>>     transport header offset is stored in skb->transport_header while the
>>     packet is still in the outer tunnel context.
>> 2. The tunnel receiver strips the outer headers.  skb->data is advanced to
>>     the inner frame, but skb->transport_header is left pointing to the
>>     now-removed outer L4 header, so it becomes a negative offset relative to
>>     the new data.
>> 3. The inner frame is not delivered to the local IP stack.  Instead, it
>>     is forwarded at L2 by a bridge or HSR, so ip_rcv_core() never runs and
>>     the transport header is not reset to the inner L4 offset.
>> 4. The forwarding path calls __dev_queue_xmit(), which enters
>>     qdisc_pkt_len_segs_init().  That function computes the GSO header length
>>     from skb_transport_offset(skb).  Because the offset is negative, the
>>     unsigned cast overflows and pskb_may_pull(skb, hdr_len +
>>     sizeof(struct tcphdr)) reads past the end of the skb, triggering a
>>     KASAN fault or page fault.
>>
>> Fix this by clearing skb->transport_header to the ~0U sentinel at the
>> tunnel decapsulation boundary, after each tunnel receive function has
>> finished all processing that needs the outer L4 header and before the skb
>> is handed to GRO or the stack. The IP/GRO receive paths then set the
>> transport header correctly when they parse the inner packet.
>>
>> Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
> 
> This Fixes: tag seems pretty random to me. Issue was present long
> before that commit.
> Next time, please be precise with the `Fixes:` tag; it's not decoration.
> 
Thanks for your review. Sorry for the late reply.
The stale transport header has been present since 1da177e4c3f4 
("Linux-2.6.12-rc2"), which is completely latent until
7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()"
was merged.

 From the perspective of the root cause introduced by the issue,
we can use 1da177e4c3f4 ("Linux-2.6.12-rc2") as fixtag.

> Also, calling skb_unset_transport_header(skb) directly from
> gro_cells_receive() would make more sense and
> your patch would be less intrusive.
> 

gtp，sit use netif_rx to receive pkt. so modifying only gro_cells_receive 
cannot solve all the problems. netif_rx is widely
used and is not only invoked by the tunnel driver, and serval path
(such as genve encap) will reset transport header before netif_rx.
Therefore, should we retain unset in the GTP/SIT tunnel?

Best Regards
Dong Chenchen

> pw-bot: cr

