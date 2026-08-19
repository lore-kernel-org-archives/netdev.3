Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5598C4908DF
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160112; cv=none; b=rX+7zzLzVxjJrKYncm/cu8K/oxbyl30oXcuTfjAxKuB9tCabjSuUs9b984QfcsWCjCEUJ6PyhUVhT2T/ta2oq/6srBztAFEfORF5NhYWwFiSSxVLIhdISyyJksfFeaROcz1L/eyGerrjJpjcSq0mVV3Fjn0qe8p4F9GKKSrBY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160112; c=relaxed/simple;
	bh=bRO2wf8uxrlNerO74sU0UHAIUkBZsoNmIxzPuOgpmW8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SZMz6aCnxLJ9nyOQeW0WKbWujnh4JOKxYjDXS3Tf1wJwKHIg0iS+i6eP0B3DwgxeKvcBAKvbYqciGWHM+KPMhhrUwzXLcAMa140WbvXd9j6l0LHu4eogY7OLTOWm6gFRsN2y3kxZB5+L9llJyJVAx2i9U3MTZC2ZU6hqskPcU3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=pOEHfqJf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AMV9jjc8; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="pOEHfqJf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AMV9jjc8"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3D051400023;
	Wed, 19 Aug 2026 13:21:32 -0400 (EDT)
Received: from ams-imap-19 ([10.64.2.39])
  by ams-compute-01.internal (MEProxy); Wed, 19 Aug 2026 13:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787160092;
	 x=1787246492; bh=NWuWrL27Ujnb4PlaJ3Zg2i1p2RPqVQIf3bxkuMZPVEI=; b=
	pOEHfqJfhdcXW7QC4t8/4aUgR9DSahqJyEgzSsEjZucbrZ7I6cVOQAOXRWF7Gh8o
	W+/S2wQw71yFimU9yjo77Gnk3LGcNpYEusLeoDr6YMX7Yqh82nO/6P1qIksCkC4n
	H3TxLHlo5Idetj6WPMIH+8DqP9yzexrcf4oi8qSdinGNK9HYkR6W0oyJl5ua+cqu
	MUTcC7geyNoJFsgGmRF/mq6UNQ+YpiwYGZ5OyhdVKYZ+GSFpMLD/ywgIr6QJRFO1
	Tdu5hx2F5pdrejOonroqErdqAHPkOYOJSEU/mXUML1AB3qGx14f3obGLJdOaJ8m3
	fhXt7xjXLka8z3NL3+98Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787160092; x=
	1787246492; bh=NWuWrL27Ujnb4PlaJ3Zg2i1p2RPqVQIf3bxkuMZPVEI=; b=A
	MV9jjc8lKKRv2evCrguEF1mmq60JQBhndSw0hGXtkNLqNO5qR55ZvZTaq7uuP5Ei
	navitHcEZsu1VWKEdkW5+teuaXYjrYJ7SwipGSlcjNC2MJ91RdkiYhtVEI/vAAQH
	ljY2VwwY9jB4xJt2CFuVBv78mWkx26ryAbkXz57Jgn3g9w1OaA6JEkjnMCF0Ql4Y
	kkzW1mPhRrz3SWEr7XTKuKcTwxta73cE37Vl+/55AkwVVftsbfvGa2ryIeVXFwFB
	ho05sDhL5omsj4HqE3RGXG5dIwaB/mJq8A5zd3uy9+kQOsvsqInSh9d1wArbRtxZ
	L3HvWmZn6Q8vQI61/90oA==
X-ME-Sender: <xms:GeaFamsX6qGXHqSb365Us-T39cJUMqiKRYhQwehmDFaGwnntIdaFaA>
    <xme:GeaFamTu6H3WUt48EHKCSKJkBK11CnXojgS2OqqNWORUBdVPi_CXByYMRO8WYjmqk
    GjRUtzEEgto2odxMLCzK7cA58EAkAEHfrvUNS8X3T7tRR0FWjHfTKCr>
X-ME-Proxy-Cause: dmFkZTEx4OOh6X74KAFSWA0bcX6tdJgX893NipoCnDN03Gho1i/V95rfPifnUr/ki9ObML
    hM4bYwHEYR0DgUKidwJX+0tJ2eViKr5YbCqkUshBehlOlIXkbk8Z5F9NSI8/8vzMlwjUH+
    m4kCvjsS8trLHL89Niu7OHFWXKrQUQUM7eo1hXv/T4Iqbe4JtgSiZa8e28dvjXEOiPCtdg
    YL1mWN01t6+RxqTfrfwGZwlogNpG11IYEqWWj3EN8zcTSRTjABRMkEnRNrdAE4tcQlCI1a
    qYEWnEn8B6fplLdrGLZ8VMQ8lqPK77REDO5z0MZnmcpRf2XGZxkbfuYlKHk6HXE22lD1Gc
    wxT/0HOBhgiPNfLvkd62UbYdYdBAgNoBQgn3iY2KQiWMA25DVOY1HhS0ib1OmjAStn2rR0
    uFrHAiAAvNatxv/knRQPa+qlTa3YHwcgC1H9+zcIqJxRUJGGuLKGu8FglWC5MOROlXEBvv
    nsVOBSokk6vTtS7rQC+7+EafLGfWEEco4A9nFvwQZCZs8xUltfWQrLhGD3e9+FCGiQRWx9
    paWzKQ798pKy/DxWV/H/o9lDwFZHvi04WxZ5AxyDRWTG0SLNLVIL6Pyai9rWtR8ZqgFwab
    A66bxmquh6ZnOcjetHC7zOHv3s7ohvOqo1BUpQp2T1LHF4aIHks9wRj6AHxQ
X-ME-Proxy: <xmx:GuaFaqomA8zgOJ5Wd3ulg5Av8es5ZbBHIH-JgnKax08_JMijDquiBQ>
    <xmx:GuaFaoFWM94SfIES04QchDBCrVvwkoNTxP9hXxGWFHC_YbmsK0q9qA>
    <xmx:GuaFagTAquzC9umI_PZoYhRIXvV3EKu630bG1WngIRXl-wPYzpt9uA>
    <xmx:GuaFauPMkdyNXPbjLeO1djG3Cc-wMqyLKWYpc_X1BU8tnDyh90l-zw>
    <xmx:HOaFakXMHP_Fc9xMMgUrbOvlFF5vl9ibyc5rQj35bVqddqR5OThYFwyS>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 3C0B22F81644; Wed, 19 Aug 2026 13:21:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4bHHQqBWFxs
Date: Wed, 19 Aug 2026 20:18:48 +0300
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Paolo Abeni" <pabeni@redhat.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Eric Dumazet" <edumazet@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Jason Wang" <jasowangio@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 "Simon Horman" <horms@kernel.org>, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Jason Xing" <kerneljasonxing@gmail.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 "Alice Mikityanska" <alice@isovalent.com>
Message-Id: <d9005289-6997-4c0c-82e1-d13637645cf7@app.fastmail.com>
In-Reply-To: <3419e66f-4c67-498b-b42b-30f2ad7bfe6a@redhat.com>
References: <20260813174613.2920246-1-alice.kernel@fastmail.im>
 <20260813174613.2920246-2-alice.kernel@fastmail.im>
 <3419e66f-4c67-498b-b42b-30f2ad7bfe6a@redhat.com>
Subject: Re: [PATCH net-next v2 1/2] net: Guard for gso_segs overflow in skb_segment
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Aug 18, 2026, at 16:38, Paolo Abeni wrote:
> On 8/13/26 7:46 PM, Alice Mikityanska wrote:
>> From: Alice Mikityanska <alice@isovalent.com>
>> 
>> skb_segment calculates 32-bit partial_segs as len / gso_size, and then
>> assigns it to the 16-bit gso_segs field. The division might overflow in
>> some edge cases where the SKB is BIG TCP (65536 <= len <= 8*65535), and
>> gso_size < TCP_MIN_GSO_SIZE = 8. While normally this can't happen due to
>> TCP_MIN_GSO_SIZE, an AF_PACKET PACKET_VNET_HDR socket can generate such
>> a malformed packet.
>> 
>> Blocking malformed virtio_net packets is implemented in the next patch,
>> but this patch clamps partial_segs in skb_segment itself for more
>> generic robustness. Should len / gso_size happen to be bigger than
>> 65535 in partial GSO, skb_segment will now just produce more than two
>> output SKBs, all of which will be valid with gso_segs <= 65535.
>
> Minor nit: I think it would make sense to re-order the patches.
>
>> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
>> ---
>>  net/core/skbuff.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index c82a1472a5ea..439cbfeb02bd 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -4860,7 +4860,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>>  		 * doesn't fit into an MSS sized block, so take care of that
>>  		 * now.
>>  		 */
>> -		partial_segs = len / mss;
>> +		partial_segs = min(len / mss, GSO_MAX_SEGS);
>
> Since on top of patch 2/2 the min() should always be a no-op,

Not sure; it'll be a no-op in this specific virtio_net scenario, but
what if there are more?

> what about instead:
>
> 		if (WARN_ON_ONCE(len/mss > GSO_MAX_SEGS))
> 			return ERR_PTR(-EINVAL);

Yeah, it looks like a good idea to add a WARN to let syzbot uncover more
possible cases, but:

1. I'd keep it non-failing rather than return an error: partial GSO can
   deal with smaller segment size pretty well, no need to fail.

2. I'd make it DEBUG_NET_WARN_ON_ONCE to avoid the penalty in
   production.

I can do that if it passes Eric's filter for too much code in fastpath.

> ?
>
> /P
