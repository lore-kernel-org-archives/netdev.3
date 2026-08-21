Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50AF44065C
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787278902; cv=none; b=hzBiGDLEgIbXx4oSr0ikQQgPfdjsQ1awToxxyyB0RQB50Z5DG9uPKpshk0ZyRUsyTMEcNn7J84ZSv4lhi0lWpEz8U8dFXilZSZAueSA9kx8LCS6hPFbCCHN/81UlJJQf/U4guhwOwAZ5NPxJ03b9mSE3AkNWOlwIRAPB5CdaQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787278902; c=relaxed/simple;
	bh=j1hXs3ZVHBjxwLY5WBqTkFWue+rjsehyoH19yxcMtiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AwX/2mNbMwm/JNqzZryTHpidNYK5Wgf32/Vlo+SI/3xrAX7LUxQaBlFLizogtpwHDvZymzJkKUDmmDWzi+aAPBtnl6hXuRuYi8/VAwhXIHvjNtBw3vmobBR698qKBJBidLyMLJpFxsPXxIi5r6W2f3spLP6TCt3P58ko2AHsLjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZUzY65yN; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZUzY65yN"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hRNQbnPAUWQyauVgGvkb2MKbs0bvUP7K8gccbkLqIDM=;
	b=ZUzY65yN/JMUKSxdKPRGPkgxcz1JfR73mZ5i/+xa093EeUhLoZXSYcPDEFHYG+VSO5MQPSFW+
	Fht368qya8Hf1e7BKLlsS2xGgXvvCrSIhbGj/lCL8Cr+DFQE+truYT68XTcq9iqrCg7f1NBoJ+a
	xlnDukzOKMTjZSi3PrQx42Q=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hR3gf2NwwzRhQt;
	Fri, 21 Aug 2026 10:10:54 +0800 (CST)
Received: from whupemk200012.china.huawei.com (unknown [7.152.185.169])
	by mail.maildlp.com (Postfix) with ESMTPS id CA72D203D1;
	Fri, 21 Aug 2026 10:21:34 +0800 (CST)
Received: from [10.174.177.223] (10.174.177.223) by
 whupemk200012.china.huawei.com (7.152.185.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 10:21:32 +0800
Message-ID: <f8549a27-8052-4d74-a505-9c0b42c73687@huawei.com>
Date: Fri, 21 Aug 2026 10:21:31 +0800
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
 <9a80f88e-c8a6-44fb-a7b2-7cdbaa3bba24@huawei.com>
 <CANn89iKg5XhJQQQWaF0UMxs+Bwjthk=StBKVnKfh+VKBAywkpA@mail.gmail.com>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <CANn89iKg5XhJQQQWaF0UMxs+Bwjthk=StBKVnKfh+VKBAywkpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk200012.china.huawei.com (7.152.185.169)



在 2026/8/21 0:32, Eric Dumazet 写道:
> On Thu, Aug 20, 2026 at 12:04 PM dongchenchen (A)
> <dongchenchen2@huawei.com> wrote:
>>
>>
>>
>> 在 2026/8/20 17:16, Eric Dumazet 写道:
>>> On Thu, Aug 20, 2026 at 10:58 AM dongchenchen (A)
>>> <dongchenchen2@huawei.com> wrote:
>>>>
>>>>
>>>>> On Thu, Aug 13, 2026 at 5:30 AM Dong Chenchen <dongchenchen2@huawei.com> wrote:
>>>>>>
>>>>>> Syzbot reported a crash in qdisc_pkt_len_segs_init() caused by a stale
>>>>>> transport_header offset after tunnel decapsulation.
>>>>>>
>>>>>> BUG: unable to handle page fault for address: ffffed102091a42e
>>>>>> Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>>>>>> CPU: 0 UID: 0 PID: 340 Comm: qdisc_uaf_repro Not tainted 7.2.0-rc4-00061-g248951ddc14d #256 PREEMPT(full)
>>>>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>>>>>> RIP: 0010:__asan_load2
>>>>>> <IRQ>
>>>>>> qdisc_pkt_len_segs_init (net/core/dev.c:4145)
>>>>>> __dev_queue_xmit (net/core/dev.c:4787)
>>>>>> br_dev_queue_push_xmit (net/bridge/br_forward.c:53)
>>>>>> br_handle_frame_finish (net/bridge/br_input.c:229)
>>>>>> br_handle_frame (net/bridge/br_input.c:315)
>>>>>> __netif_receive_skb_core.constprop.0 (net/core/dev.c:6099)
>>>>>> __netif_receive_skb_list_core (net/core/dev.c:6287)
>>>>>> netif_receive_skb_list_internal (net/core/dev.c:6445)
>>>>>> napi_complete_done (net/core/dev.c:6813)
>>>>>> gro_cell_poll (net/core/gro_cells.c:74)
>>>>>> __napi_poll (net/core/dev.c:7735)
>>>>>> net_rx_action (net/core/dev.c:7798 net/core/dev.c:7955)
>>>>>> handle_softirqs (kernel/softirq.c:622)
>>>>>> do_softirq (kernel/softirq.c:523  kernel/softirq.c:510 )
>>>>>> __local_bh_enable_ip (kernel/softirq.c:450)
>>>>>> tun_get_user (drivers/net/tun.c:1986 (discriminator 1))
>>>>>> tun_chr_write_iter (drivers/net/tun.c:2032)
>>>>>>
>>>>>> The crash requires four conditions to line up:
>>>>>>
>>>>>> 1. The incoming packet is encapsulated and carries GSO metadata.  The outer
>>>>>>       transport header offset is stored in skb->transport_header while the
>>>>>>       packet is still in the outer tunnel context.
>>>>>> 2. The tunnel receiver strips the outer headers.  skb->data is advanced to
>>>>>>       the inner frame, but skb->transport_header is left pointing to the
>>>>>>       now-removed outer L4 header, so it becomes a negative offset relative to
>>>>>>       the new data.
>>>>>> 3. The inner frame is not delivered to the local IP stack.  Instead, it
>>>>>>       is forwarded at L2 by a bridge or HSR, so ip_rcv_core() never runs and
>>>>>>       the transport header is not reset to the inner L4 offset.
>>>>>> 4. The forwarding path calls __dev_queue_xmit(), which enters
>>>>>>       qdisc_pkt_len_segs_init().  That function computes the GSO header length
>>>>>>       from skb_transport_offset(skb).  Because the offset is negative, the
>>>>>>       unsigned cast overflows and pskb_may_pull(skb, hdr_len +
>>>>>>       sizeof(struct tcphdr)) reads past the end of the skb, triggering a
>>>>>>       KASAN fault or page fault.
>>>>>>
>>>>>> Fix this by clearing skb->transport_header to the ~0U sentinel at the
>>>>>> tunnel decapsulation boundary, after each tunnel receive function has
>>>>>> finished all processing that needs the outer L4 header and before the skb
>>>>>> is handed to GRO or the stack. The IP/GRO receive paths then set the
>>>>>> transport header correctly when they parse the inner packet.
>>>>>>
>>>>>> Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
>>>>>
>>>>> This Fixes: tag seems pretty random to me. Issue was present long
>>>>> before that commit.
>>>>> Next time, please be precise with the `Fixes:` tag; it's not decoration.
>>>>>
>>>> Thanks for your review. Sorry for the late reply.
>>>> The stale transport header has been present since 1da177e4c3f4
>>>> ("Linux-2.6.12-rc2"), which is completely latent until
>>>> 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()"
>>>> was merged.
>>>>
>>>>    From the perspective of the root cause introduced by the issue,
>>>> we can use 1da177e4c3f4 ("Linux-2.6.12-rc2") as fixtag.
>>>>
>>>>> Also, calling skb_unset_transport_header(skb) directly from
>>>>> gro_cells_receive() would make more sense and
>>>>> your patch would be less intrusive.
>>>>>
>>>>
>>>> gtp，sit use netif_rx to receive pkt. so modifying only gro_cells_receive
>>>> cannot solve all the problems. netif_rx is widely
>>>> used and is not only invoked by the tunnel driver, and serval path
>>>> (such as genve encap) will reset transport header before netif_rx.
>>>> Therefore, should we retain unset in the GTP/SIT tunnel?
>>>
>>> Hi Dong,
>>>
>>> 1) Regarding SIT:
>>>
>>> SIT decapsulates IPv6 over IPv4 (IPPROTO_IPV6). There is no outer L4 transport
>>> header (no UDP/TCP), so skb->transport_header is not pointing to an
>>> outer L4 header.
>>>
>>> 2) Regarding GTP:
>>>
>>> GTP is an L3-only point-to-point device (ARPHRD_NONE). It cannot be
>>> enslaved by a bridge
>>> or forwarded at L2; its packets always go through ip_rcv()/ip6_rcv()
>>> where the headers
>>> are properly parsed/reset,
>>>
>> Hi, Eric. Thanks for the review!
>>
>> I missed the rcv path in the commit message.
>> With an ingress qdisc attached to gtp, the stale transport header
>> will been consumed in sch_handle_ingress() and its not covered by
>> gro_cells_receive() either. So maybe gtp is not safe by
>> construction.
>>
>> gtp_encap_rcv
>>     gtp_rx //stale transport header
>>       __netif_rx
>>         __netif_receive_skb_core
>>           sch_handle_ingress
>>             qdisc_pkt_len_segs_init
>>
> 
> Let's step back a bit :)
> 
> For non-GSO packets, qdisc_pkt_len_segs_init() returns immediately:
> 
> qdisc_skb_cb(skb)->pkt_len = skb->len;
> if (!shinfo->gso_size) {
>      qdisc_skb_cb(skb)->pkt_segs = 1;
>      return SKB_NOT_DROPPED_YET;
> }
> 
> It does not inspect skb->transport_header at all. It will be set
> eventually later if needed,
> 
> GTP does not implement GRO on RX and does not use gro_cells, so incoming
> packets in gtp_rx() have gso_size == 0.
> 

Hi, Eric. Thanks for your patient explanation.

Normal GTP traffic indeed cannot trigger this issue and pkt without 
SKB_GSO_UDP_TUNNEL will be caught by udp_unexpected_gso.
The only way to reproduce this for gtp is by constructing and injecting 
packets, such as TAP device injects a GSO UDP-tunnel packet (with 
GSO_TCPV4 and GSO_UDP_TUNNEL flag, Ethernet/IPv4/UDP/GTP-U/IPV4/TCP).
Should we add interception for such illegal pkts?

diff --git a/net/core/dev.c b/net/core/dev.c
index af260ff5462a..8620428b950f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4138,6 +4138,10 @@ static enum skb_drop_reason 
qdisc_pkt_len_segs_init(struct sk_buff *skb)
         if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
                 const struct tcphdr *th;

+               /* Defensive: stale offsets from buggy tunnel decap can 
underflow. */
+               if (unlikely(hdr_len > INT_MAX))
+                       return 0;
+
                 if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
                         return SKB_DROP_REASON_SKB_BAD_GSO;

-------------
Best Regards
Dong Chenchen

> The issue specifically requires GSO packets (shinfo->gso_size != 0), which are
> processed/aggregated through gro_cells. Fixing this in
> gro_cells_receive() covers
> all the relevant tunnel drivers in one place.
> 
> Thanks.

