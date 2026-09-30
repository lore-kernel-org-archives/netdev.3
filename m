Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F354CCDEB
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776252; cv=none; b=m3NayLkdMAKpVy+7J1a2co594GhbBryVV8d7HyYjSnlHTFDnG4U7cbLXlAboJH1F2yc6Enr6XQXKvNK8UUDMAzeKgXd2FG+ZHyNiRjuvgW5aUxc4BpwYFD3oksF+iMd5O8EMm706CPAA0yFkn/S7XtF4nGAjtPkoPdFhO/w8z5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776252; c=relaxed/simple;
	bh=0EUSX+ziol7csngDV3y0PTG7YQiaDbEjmp8He8nG/ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tp5VA3fsgDqiv35Do/qQTnCD66foTVKWwABMLcPNMdpuYHXTcuSGMpF48SZLS6oblFOizXaEzk4kGfghQJ8v+HlQT2nBV8quiZjihL85/ixr1T0XGqvqozaoW789MdXWUqyp0K1IzcGFY6eC9dJJozzypLra5+1CErw7jhyaKuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+ty7jri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+ty7jri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF1B1F000FF;
	Wed, 30 Sep 2026 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790776230;
	bh=dU/XDKG10LV8ewA9yJraf9DgWPH9zHX66m1WdRcexoU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V+ty7jriAnyNmrTZyJl07qnZHbgftTukannZrNL9hdBn2MMFXEnHD0e1iGCNzB5IU
	 P5UhuKMZDatOnPGCPCEo+Bmnu3tORlMrL07Cz7ace9OjAkwtHAeisuLkPzu25IvXW0
	 fi0flE7ZeHleH9daeJ17sHjUa6YtLTAUTPytwN2b6t7o2OcsMQYG0jCb768TEx+/tW
	 wc1RJNSwdKMYbhjdmJ0UafLxHpIEiDQkIM/b1fB6at6WSI2LfcwGXcu6nm10Bq6hdS
	 jbZfxtQxQBJv1QIMRNpIbxyua0OL/O15RCCSvta7GqarYrV+acLWYEkVMnalOv0Jqf
	 +tDUtYJa5cOhA==
Message-ID: <16cb8491-c7d9-422a-b3cc-c0225f12b7ba@kernel.org>
Date: Wed, 30 Sep 2026 07:50:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] ipv4: reserve one IP ID per segment for UDP GSO
 packets
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org
References: <20260929131247.401104-1-edumazet@kernel.org>
 <20260929131247.401104-3-edumazet@kernel.org>
 <a6f0e657-8674-4216-a1aa-88045c19643b@kernel.org>
 <CANn89iJ3KgVOYKD-dT0M=ZOpCJzuOcrG8BWvSKrX0eO1VN7Tpw@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iJ3KgVOYKD-dT0M=ZOpCJzuOcrG8BWvSKrX0eO1VN7Tpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/30/26 7:58 AM, Eric Dumazet wrote:
> On Wed, Sep 30, 2026 at 2:29 PM David Ahern <dsahern@kernel.org> wrote:
>>
>> On 9/29/26 8:12 AM, Eric Dumazet wrote:
>>> @@ -1464,7 +1465,19 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
>>>       iph->ttl = ttl;
>>>       iph->protocol = sk->sk_protocol;
>>>       ip_copy_addrs(iph, fl4);
>>> -     ip_select_ident(net, skb, sk);
>>> +
>>> +     /* UDP GSO packets are segmented later (see udp_send_skb()):
>>> +      * reserve one IP ID per segment.
>>> +      */
>>> +     segs = 1;
>>> +     if (cork->gso_size) {
>>> +             int datalen = skb->len - skb_transport_offset(skb) -
>>> +                           sizeof(struct udphdr);
>>
>> hard coding a specific transport header in L3 code is crossing layers.
>>
> 
> Only UDP sets cork->gso_size, so this is UDP specific code in
> __ip_make_skb(), like the existing sk_is_tcp() case in the same
> function.

I went looking for other transport references in L3 code and missed this
one.

> 
> I can make this explicit in v2 with:
> 
> if (cork->gso_size && sk_is_udp(sk)) {
> 
> Selecting the IP ID from udp_send_skb() instead would either burn
> one extra IP ID per packet (50 % more for 2-segment GSO packets,
> making wraparound faster), or require __ip_make_skb() to leave
> iph->id unset for UDP GSO packets, with a simlar kayer violation concern.
> 
> Would this be acceptable, or do you have another suggestion?

sure. I went down the path of adding an input arg to __ip_make_skb, but
this is simpler.
