Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FB640B0ED
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787220297; cv=none; b=UGPABUtWPeuHAx9AjMxKUrGkTNA7TKYw1BqAJii4+ivQMhV07rzFM0ONqq2OuepsxSJ0cdQ1MOxvXhH2ZsNB4XeQ8Y0Z7i4Lp8iA2WzrkkwBHoRPmwUugv+ly94z65ZjZDX1fRn/czTeli2yCCotMucKC5qjs0iU4t9fG9dM1zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787220297; c=relaxed/simple;
	bh=TXoqjQcJHjWxjeR2hRkig1J4Fjt9nnj13K7SCM9ShiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gqJyI7btiUoohcxeS/ifs1WWFVGgXvejMxpp6vq2+jxCvbSUYkW2HH0b8c9OxY+2dZVo3VY2mDOqBCl84uQV+TH3Sya/UzpW5bOgckKDqOYKlNOZDF9CGTplvCyELBeTTxsuWw7K2q/B71DbNxWTXkKl5NLXcodz+j7EyCIrjF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3F3mWKhl; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3F3mWKhl"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MtNLEajdnFZk77rmosl4teGaz+2YGNzPlWlT6lzjbLc=;
	b=3F3mWKhlNPlEXNHKzkpGXpNDOyaw8rdgx+JrAhhxrNBq5OqaEBShTmGLif6Hdc7yZGO46zqFr
	vbziZwooOHOkwaN90irMTDF51DCsh7VHeexh8gVGj7fcKEmmDQxcyp95P9Jej290j84K2RHG9Ka
	3FVfbWRiwZ9Z/d7dHIDUbTs=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hQf0T5kL1z1cyQ2;
	Thu, 20 Aug 2026 17:54:01 +0800 (CST)
Received: from whupemk200012.china.huawei.com (unknown [7.152.185.169])
	by mail.maildlp.com (Postfix) with ESMTPS id 05C214055B;
	Thu, 20 Aug 2026 18:04:43 +0800 (CST)
Received: from [10.174.177.223] (10.174.177.223) by
 whupemk200012.china.huawei.com (7.152.185.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 18:04:41 +0800
Message-ID: <9a80f88e-c8a6-44fb-a7b2-7cdbaa3bba24@huawei.com>
Date: Thu, 20 Aug 2026 18:04:40 +0800
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
 <53e86f6f-43b9-4e06-b185-1344f69cd650@huawei.com>
 <CANn89iJWTwiQJbjWz5jY6DE_TSA0EEMyJtQFbDSzMJfjV=MHQQ@mail.gmail.com>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <CANn89iJWTwiQJbjWz5jY6DE_TSA0EEMyJtQFbDSzMJfjV=MHQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemk200012.china.huawei.com (7.152.185.169)



在 2026/8/20 17:16, Eric Dumazet 写道:
> On Thu, Aug 20, 2026 at 10:58 AM dongchenchen (A)
> <dongchenchen2@huawei.com> wrote:
>>
>>
>>> On Thu, Aug 13, 2026 at 5:30 AM Dong Chenchen <dongchenchen2@huawei.com> wrote:
>>>>
>>>> Syzbot reported a crash in qdisc_pkt_len_segs_init() caused by a stale
>>>> transport_header offset after tunnel decapsulation.
>>>>
>>>> BUG: unable to handle page fault for address: ffffed102091a42e
>>>> Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>>>> CPU: 0 UID: 0 PID: 340 Comm: qdisc_uaf_repro Not tainted 7.2.0-rc4-00061-g248951ddc14d #256 PREEMPT(full)
>>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>>>> RIP: 0010:__asan_load2
>>>> <IRQ>
>>>> qdisc_pkt_len_segs_init (net/core/dev.c:4145)
>>>> __dev_queue_xmit (net/core/dev.c:4787)
>>>> br_dev_queue_push_xmit (net/bridge/br_forward.c:53)
>>>> br_handle_frame_finish (net/bridge/br_input.c:229)
>>>> br_handle_frame (net/bridge/br_input.c:315)
>>>> __netif_receive_skb_core.constprop.0 (net/core/dev.c:6099)
>>>> __netif_receive_skb_list_core (net/core/dev.c:6287)
>>>> netif_receive_skb_list_internal (net/core/dev.c:6445)
>>>> napi_complete_done (net/core/dev.c:6813)
>>>> gro_cell_poll (net/core/gro_cells.c:74)
>>>> __napi_poll (net/core/dev.c:7735)
>>>> net_rx_action (net/core/dev.c:7798 net/core/dev.c:7955)
>>>> handle_softirqs (kernel/softirq.c:622)
>>>> do_softirq (kernel/softirq.c:523  kernel/softirq.c:510 )
>>>> __local_bh_enable_ip (kernel/softirq.c:450)
>>>> tun_get_user (drivers/net/tun.c:1986 (discriminator 1))
>>>> tun_chr_write_iter (drivers/net/tun.c:2032)
>>>>
>>>> The crash requires four conditions to line up:
>>>>
>>>> 1. The incoming packet is encapsulated and carries GSO metadata.  The outer
>>>>      transport header offset is stored in skb->transport_header while the
>>>>      packet is still in the outer tunnel context.
>>>> 2. The tunnel receiver strips the outer headers.  skb->data is advanced to
>>>>      the inner frame, but skb->transport_header is left pointing to the
>>>>      now-removed outer L4 header, so it becomes a negative offset relative to
>>>>      the new data.
>>>> 3. The inner frame is not delivered to the local IP stack.  Instead, it
>>>>      is forwarded at L2 by a bridge or HSR, so ip_rcv_core() never runs and
>>>>      the transport header is not reset to the inner L4 offset.
>>>> 4. The forwarding path calls __dev_queue_xmit(), which enters
>>>>      qdisc_pkt_len_segs_init().  That function computes the GSO header length
>>>>      from skb_transport_offset(skb).  Because the offset is negative, the
>>>>      unsigned cast overflows and pskb_may_pull(skb, hdr_len +
>>>>      sizeof(struct tcphdr)) reads past the end of the skb, triggering a
>>>>      KASAN fault or page fault.
>>>>
>>>> Fix this by clearing skb->transport_header to the ~0U sentinel at the
>>>> tunnel decapsulation boundary, after each tunnel receive function has
>>>> finished all processing that needs the outer L4 header and before the skb
>>>> is handed to GRO or the stack. The IP/GRO receive paths then set the
>>>> transport header correctly when they parse the inner packet.
>>>>
>>>> Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
>>>
>>> This Fixes: tag seems pretty random to me. Issue was present long
>>> before that commit.
>>> Next time, please be precise with the `Fixes:` tag; it's not decoration.
>>>
>> Thanks for your review. Sorry for the late reply.
>> The stale transport header has been present since 1da177e4c3f4
>> ("Linux-2.6.12-rc2"), which is completely latent until
>> 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()"
>> was merged.
>>
>>   From the perspective of the root cause introduced by the issue,
>> we can use 1da177e4c3f4 ("Linux-2.6.12-rc2") as fixtag.
>>
>>> Also, calling skb_unset_transport_header(skb) directly from
>>> gro_cells_receive() would make more sense and
>>> your patch would be less intrusive.
>>>
>>
>> gtp，sit use netif_rx to receive pkt. so modifying only gro_cells_receive
>> cannot solve all the problems. netif_rx is widely
>> used and is not only invoked by the tunnel driver, and serval path
>> (such as genve encap) will reset transport header before netif_rx.
>> Therefore, should we retain unset in the GTP/SIT tunnel?
> 
> Hi Dong,
> 
> 1) Regarding SIT:
> 
> SIT decapsulates IPv6 over IPv4 (IPPROTO_IPV6). There is no outer L4 transport
> header (no UDP/TCP), so skb->transport_header is not pointing to an
> outer L4 header.
> 
> 2) Regarding GTP:
> 
> GTP is an L3-only point-to-point device (ARPHRD_NONE). It cannot be
> enslaved by a bridge
> or forwarded at L2; its packets always go through ip_rcv()/ip6_rcv()
> where the headers
> are properly parsed/reset,
> 
Hi, Eric. Thanks for the review!

I missed the rcv path in the commit message.
With an ingress qdisc attached to gtp, the stale transport header
will been consumed in sch_handle_ingress() and its not covered by
gro_cells_receive() either. So maybe gtp is not safe by
construction.

gtp_encap_rcv
   gtp_rx //stale transport header
     __netif_rx
       __netif_receive_skb_core
         sch_handle_ingress
           qdisc_pkt_len_segs_init
					
Best Regards
Dong Chenchen

> 3) Regarding Geneve:
> 
> When skb->encapsulation is set, inner headers are already parsed and
> qdisc_pkt_len_segs_init()
> uses skb_inner_transport_offset(skb), not skb_transport_offset(skb).
> 
> When skb->encapsulation is 0, it calls gro_cells_receive().
> 
> All L2 tunnel drivers that can be bridged/forwarded at L2 (vxlan,
> geneve, bareudp, amt, etc.)
> use gro_cells_receive().
> 
> IMO calling skb_unset_transport_header() directly in gro_cells_receive()
> is clean and fixes all of them in one place.
> 
> Thanks.

