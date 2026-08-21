Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91148357D0A
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787279433; cv=none; b=gb/IQjtTCJQIftJdgSqWGk5w/dj2fJRzLPv6mMiIdG+3OQReMdpNaP/knBY1YxD5R0qSoR7rsRFMBKNWcwqUZuvSolPtTM73t0gczbua3aUI+qNZ9FaU1V9z+r2BZxSYj7kBDGULINzdq3AjqgsMwHe41zOQxIHiQmkHl5wYLSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787279433; c=relaxed/simple;
	bh=9bts2gSD/9vCbFmF0P8Sr645uwzTU+FEmbvkRtrUfMk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=slBhpK9E8jm8CbSIr2IOPuM25bjE6cNPZhy+a6G/pYqlWLkgPTfcunEEUF83pFPYj9c9nxdTN65TtaR3JvqU8DeC6XnOK7KpPY1kWay38aixyXQ7oy0z9G8o6waPFuwSuVC1nTRcQm3Q1yVItEU7tP4+EiTey5czLDlskDkQbfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=W9Jkw5J1; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="W9Jkw5J1"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CWUdCYyqOhZ6U0KJkHeJhUwTe00lWEHylagvld5QGRg=;
	b=W9Jkw5J1MUgXxc00AzRFn37tQ9gDcHmRpazcz3ffctdy0Iy2zRbHrdnGtC9gwnSqlCJTsPBfW
	R0OxruBoxkxe/W/NdJOa56FXOTW1bWa2Eit+4zlIAqAVEIKEZMkbujvSAKxxUWFPeqykSc/KT40
	TMuJRXfA9YJD2RSXip0rP8o=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hR3sm1BbMzKmB5;
	Fri, 21 Aug 2026 10:19:40 +0800 (CST)
Received: from whupemk200012.china.huawei.com (unknown [7.152.185.169])
	by mail.maildlp.com (Postfix) with ESMTPS id 2004A402AB;
	Fri, 21 Aug 2026 10:30:26 +0800 (CST)
Received: from [10.174.177.223] (10.174.177.223) by
 whupemk200012.china.huawei.com (7.152.185.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 10:30:24 +0800
Message-ID: <a0d6de47-ec35-4f30-93d5-969a208b7be0@huawei.com>
Date: Fri, 21 Aug 2026 10:30:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: iptunnel: fix stale transport header during
 tunnel decapsulation
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
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
 <f8549a27-8052-4d74-a505-9c0b42c73687@huawei.com>
In-Reply-To: <f8549a27-8052-4d74-a505-9c0b42c73687@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk200012.china.huawei.com (7.152.185.169)


> 
> 
>>>>
>>> Hi, Eric. Thanks for the review!
>>>
>>> I missed the rcv path in the commit message.
>>> With an ingress qdisc attached to gtp, the stale transport header
>>> will been consumed in sch_handle_ingress() and its not covered by
>>> gro_cells_receive() either. So maybe gtp is not safe by
>>> construction.
>>>
>>> gtp_encap_rcv
>>>     gtp_rx //stale transport header
>>>       __netif_rx
>>>         __netif_receive_skb_core
>>>           sch_handle_ingress
>>>             qdisc_pkt_len_segs_init
>>>
>>
>> Let's step back a bit :)
>>
>> For non-GSO packets, qdisc_pkt_len_segs_init() returns immediately:
>>
>> qdisc_skb_cb(skb)->pkt_len = skb->len;
>> if (!shinfo->gso_size) {
>>      qdisc_skb_cb(skb)->pkt_segs = 1;
>>      return SKB_NOT_DROPPED_YET;
>> }
>>
>> It does not inspect skb->transport_header at all. It will be set
>> eventually later if needed,
>>
>> GTP does not implement GRO on RX and does not use gro_cells, so incoming
>> packets in gtp_rx() have gso_size == 0.
>>
> 
> Hi, Eric. Thanks for your patient explanation.
> 
> Normal GTP traffic indeed cannot trigger this issue and pkt without 
> SKB_GSO_UDP_TUNNEL will be caught by udp_unexpected_gso.
> The only way to reproduce this for gtp is by constructing and injecting 
> packets, such as TAP device injects a GSO UDP-tunnel packet (with 
> GSO_TCPV4 and GSO_UDP_TUNNEL flag, Ethernet/IPv4/UDP/GTP-U/IPV4/TCP).
> Should we add interception for such illegal pkts?
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index af260ff5462a..8620428b950f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4138,6 +4138,10 @@ static enum skb_drop_reason 
> qdisc_pkt_len_segs_init(struct sk_buff *skb)
>          if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
>                  const struct tcphdr *th;
> 
> +               /* Defensive: stale offsets from buggy tunnel decap can 
> underflow. */
> +               if (unlikely(hdr_len > INT_MAX))
> +                       return 0;
> +

Sorry, there is a typo here.
It should be SKB_DROP_REASON_SKB_BAD_GSO.

>                  if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
>                          return SKB_DROP_REASON_SKB_BAD_GSO;
> 
> -------------
> Best Regards
> Dong Chenchen
> 
>> The issue specifically requires GSO packets (shinfo->gso_size != 0), 
>> which are
>> processed/aggregated through gro_cells. Fixing this in
>> gro_cells_receive() covers
>> all the relevant tunnel drivers in one place.
>>
>> Thanks.
> 

