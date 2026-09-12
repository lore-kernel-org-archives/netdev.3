Received: from mta0.migadu.com (out-237.mta0.migadu.com [91.218.175.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F129230BDB
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226963; cv=none; b=kJEIQSyxQLhwwioj64benxAiMBuX0s6ti1WUhGSlOmq8e7W7FFUqbRtqNJuJLoKRIWkf8dr35xbhxvRa7dLp9YYxqj/Csn/UTuWiF043ZJKxxXxBWMB8VFOZR43W1PRwsSVl/SC03UQsxOYHlber0xacnzKd0pUbe4cGQ2qQ87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226963; c=relaxed/simple;
	bh=VLTV4yhURmrrYdpeMYGN1I9/xOig2B5O0huJzXmR8oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhXjADsxxO4GryK/2s1sJG0ht888Wz8V3IX11cd62Sq5L/ZoL+wuhHV7lDgxJXUTZGSK/ivP7t8TSWd87fkTqKsbwFOd9BJVk3azbZzfqmDyDHPUlHsoz5NBpG9q73kBKTBQtTxP1C9M8luaex5B8fbzfbYFXV5vLcH2PLnYqg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JM6id/of; arc=none smtp.client-ip=91.218.175.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JM6id/of"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VLTV4yhURmrrYdpeMYGN1I9/xOig2B5O0huJzXmR8oQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789226956; v=1; x=1789831756;
 b=JM6id/ofN6zAcmCT7KetVPQbLZAOUXsIAUXvWzLxlAdRDOEkkIquJUbXunzJN/SOIHVO70NG
 XIYJVd+1RNx1EiZ7n+h0YG8oh9A8y/VsJvVox88kNnDObhCoHWv1DICwd6PY4AM77GXoFpiO4H2
 vkzvcFaIaOU4i6e8XuREVd9A=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 747f465cc1ed9945;
	Sat, 12 Sep 2026 15:29:06 +0000
X-Mizu-Trace-ID: 747f465cc1ed9945
X-Migadu-Flow: FLOW_OUT
Message-ID: <8a331d2f-526d-4aad-bad5-af84073c183d@linux.dev>
Date: Sat, 12 Sep 2026 23:29:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: skbuff: do not leave stale header offsets after
 pskb_carve()
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+586af68eb819833c2d91@syzkaller.appspotmail.com,
 Allison Henderson <achender@kernel.org>, rds-devel@oss.oracle.com,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260911114922.621937-1-edumazet@google.com>
 <a53a81cd-88b6-4db2-a0e6-ee3dccfeef42@linux.dev>
 <CANn89iJw5P-wARumRgxdPaHXBJ3qF0zu6FNaNOFKonyww9AJpg@mail.gmail.com>
 <d9cb00fe-85fe-466f-b6ee-c5694d134ed4@linux.dev>
 <CANn89iJYEGDBcFxC3kh1KPbvxs3Qh0aU8YrgH=h6xdHMJm0iyQ@mail.gmail.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <CANn89iJYEGDBcFxC3kh1KPbvxs3Qh0aU8YrgH=h6xdHMJm0iyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/9/12 21:44, Eric Dumazet 写道:
> On Sat, Sep 12, 2026 at 6:39 AM Xuanqiang Luo <xuanqiang.luo@linux.dev> wrote:
>>
>> 在 2026/9/12 16:57, Eric Dumazet 写道:
>>> On Fri, Sep 11, 2026 at 11:38 PM luoxuanqiang <xuanqiang.luo@linux.dev> wrote:
>>>>
>>>> 在 2026/9/11 19:49, Eric Dumazet 写道:
>>>>> pskb_carve_inside_header() and pskb_carve_inside_nonlinear() remove
>>>>> the first bytes of a packet and reallocate skb->head.
>>>>>
>>>>> All the headers that were present before the operation are gone,
>>>>> but both functions call skb_headers_offset_update(skb, 0), which
>>>>> is a no-op : skb->mac_header, skb->network_header,
>>>>> skb->transport_header and skb->csum_start are left with their old
>>>>> values, now pointing into the freshly allocated (and possibly much
>>>>> smaller) skb->head.
>>>>>
>>>>> For pskb_carve_inside_nonlinear() the result is a zombie skb with
>>>>> an empty linear part (skb->data == skb_tail_pointer(skb),
>>>>> skb_headlen(skb) == 0) but skb_mac_header_was_set() still true and
>>>>> skb->mac_header pointing far beyond skb_end_pointer(skb).
>>>>>
>>>> Could you please clarify how the MAC pointer ends up beyond
>>>> skb_end_pointer() here? The carve helpers allocate based on the old
>>>> skb_end_offset(), and kmalloc_reserve() adds room for skb_shared_info,
>>>> so the new capacity shouldn't be smaller.
>>>>
>>>> The dump shows mac=234 and end=384. I understand how the stale offset
>>>> causes skb_pull() on an empty linear area and triggers the BUG, but I
>>>> don't see how it ends up beyond the new end. Am I missing another
>>>> condition?
>>>
>>> skb_headers_offset_update(skb, 0) is a no-op, so mac=234, net=248,
>>> trans=288 and csum_start=288 survive and now describe bytes that are not
>>> there anymore. skb_mac_header_was_set() still returns true, so drop_monitor
>>> does skb_pull(skb, 234) on an empty linear part and hits the BUG in
>>> __skb_pull().
>>>
>>> pskb_carve_inside_header() has the same issue, the remaining linear data is
>>> shifted by off bytes while the offsets are left untouched.
>>>
>> Thanks for the explanation. The fix itself looks correct to me, and I
>> understand why the stale MAC offset causes the BUG.
>>
>> Could I check my understanding of "far beyond skb_end_pointer()"?
>> The dump shows headroom=0 and headlen=0, so head=data=tail. With
>> end-tail=384 and mac=234, the MAC pointer is head+234, still before
>> end at head+384. For this nonlinear skb, did you mean beyond
>> skb_tail_pointer() rather than skb_end_pointer()?
> 
> Is it an LLM which triggers your replies?
> 
> Do you have an issue with the code?

Yes, I use an LLM to help analyze patches on the mailing list and polish
my replies. I only reply once I understand the relevant code.

I haven't found an issue with the code. My follow-up questions were only
about the commit message wording.

Sorry for repeatedly asking about that point.

Thanks,
