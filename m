Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376D3FF8AD
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657415; cv=none; b=J0eKVEsndAktm8/oK00sPql2gHIbGYrATDlXL4H9jVXfyBlJ5HidK9vnqXtymQIwJWSeBo8FNYqBsulbGM001qsVGfQ/6rrK9fCwEOOITswQcSc8xtN0pIHIFcROpzYfDjRy2KAmo8tAyH0DbHLmqdqxZXDeUuL0rHNzKJNIk/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657415; c=relaxed/simple;
	bh=QlvaySY2GoI/FdOD/SneYP0Qp0OAO0++VjULPaYyl8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OPQ7/KiFKthpnu7LaZ6YsBV9u7XSTqcKoSj+oFV3UKAZuFJLlqf0gZ93Jnza0F0CyzY+5effgwHLqxknNMMNMUsd6VxZk1KmB55llMSf3OOm8cs50LUmbe9Q1W+85+j0i4NAHlqUHTqw6P2qvwNgkoBC8w72NleYO8L90Mknetk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XWumqaHH; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XWumqaHH"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gkg135uyP9eXnKMlYltWHFACdCcDSy7voqRlLzVWu8E=;
	b=XWumqaHHtCPpfGqdbJyxMu1JR0EK+zYC0T5A341Z3/5pRmgFIKGCqz31ro3MuuNorH2INp1HA
	36TEaZRb9PXqKqm/jOviAgpiWnn4X444fTHSAQKXkxRiFytfnBB8fXcwjoD/TnSte94JP5JJ+hq
	iPVZU2lb5pENnUo2htog/WU=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hTlfw2Rlyzcb0W;
	Tue, 25 Aug 2026 19:19:36 +0800 (CST)
Received: from whupemk200012.china.huawei.com (unknown [7.152.185.169])
	by mail.maildlp.com (Postfix) with ESMTPS id 7460D202E6;
	Tue, 25 Aug 2026 19:30:07 +0800 (CST)
Received: from [10.174.177.223] (10.174.177.223) by
 whupemk200012.china.huawei.com (7.152.185.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 19:30:05 +0800
Message-ID: <a4576449-7435-4d57-b350-3558de893730@huawei.com>
Date: Tue, 25 Aug 2026 19:30:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: iptunnel: fix stale transport header during
 tunnel decapsulation
To: Eric Dumazet <edumazet@google.com>
CC: <pablo@netfilter.org>, <laforge@gnumonks.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <dsahern@kernel.org>, <kees@kernel.org>,
	<netdev@vger.kernel.org>, <osmocom-net-gprs@lists.osmocom.org>,
	<zhangchangzhong@huawei.com>,
	<syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com>
References: <20260825095000.1461124-1-dongchenchen2@huawei.com>
 <CANn89iJwWL9NdC19XbSFq7sf_tsZS96PTXWgO3oUMGJRkA0g-w@mail.gmail.com>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <CANn89iJwWL9NdC19XbSFq7sf_tsZS96PTXWgO3oUMGJRkA0g-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk200012.china.huawei.com (7.152.185.169)



在 2026/8/25 17:59, Eric Dumazet 写道:
> On Tue, Aug 25, 2026 at 11:41 AM Dong Chenchen <dongchenchen2@huawei.com> wrote:
>>
>> Syzbot reported a crash in qdisc_pkt_len_segs_init() caused by a stale
>> transport_header offset after tunnel decapsulation.
>>
>>
>> The issue is completely latent until qdisc read transport header in
>> commit 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()").
>> The crash requires four conditions to line up:
>>
>> 1. The incoming packet is encapsulated and carries GSO metadata. The outer
>>     transport header offset is stored in skb->transport_header while the
>>     packet is still in the outer tunnel context.
>> 2. The tunnel receiver strips the outer headers. skb->data is advanced to
>>     the inner frame, but skb->transport_header is left pointing to the
>>     now-removed outer L4 header, so it becomes a negative offset relative to
>>     the new data.
>> 3. The inner frame is not delivered to the local IP stack. Instead, it
>>     is forwarded at L2 by a bridge or HSR, so ip_rcv_core() never runs and
>>     the transport header is not reset to the inner L4 offset.
>> 4. The forwarding path calls __dev_queue_xmit(), which enters
>>     qdisc_pkt_len_segs_init(). That function computes the GSO header length
>>     from skb_transport_offset(skb). Because the offset is negative, the
>>     unsigned cast overflows and pskb_may_pull(skb, hdr_len +
>>     sizeof(struct tcphdr)) reads past the end of the skb, triggering a
>>     KASAN fault or page fault.
>>
>> The issue specifically requires GSO packets (shinfo->gso_size != 0), which
>> are processed/aggregated through gro_cells. Fix this by clearing
>> transport_header to the ~0U sentinel in gro_cell for all tunnnel driver.
>> GTP does not support GRO/GSO, drop the evil GSO packets in GTP directly.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Reported-by: syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/69de2bee.a00a0220.475f0.0041.GAE@google.com/T/
>> Suggested-by: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
>> ---
>>   drivers/net/gtp.c      | 5 +++++
>>   include/linux/skbuff.h | 5 +++++
>>   net/core/gro_cells.c   | 2 ++
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
>> index 9a12cc53da00..fbf617b1acc9 100644
>> --- a/drivers/net/gtp.c
>> +++ b/drivers/net/gtp.c
>> @@ -312,6 +312,11 @@ static int gtp_inner_proto(struct sk_buff *skb, unsigned int hdrlen,
>>   static int gtp_rx(struct pdp_ctx *pctx, struct sk_buff *skb,
>>                    unsigned int hdrlen, unsigned int role, __u16 inner_proto)
>>   {
>> +       if (skb_is_gso(skb)) {
>> +               netdev_dbg(pctx->dev, "GSO is not support in GTP\n");
> 
> Patch looks good to me but there is a small typo here.
> 
>                      netdev_dbg(pctx->dev, "GSO is not supported in GTP\n");
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> Thanks.

Thanks for review!
v3 will be sent

