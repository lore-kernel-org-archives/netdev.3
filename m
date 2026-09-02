Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0AC3EE1D3
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339765; cv=none; b=jdi4ujjvfAlFh5sDbSf9KdcdQ+7yWGHy4YoufCZBYPWRKnPigqZuJtpZ481XW8LFzzAezydOkl94+daaIlhEdfOKwR1tPgOTvyapnLozff9uwJKR5jx2q6u0E9ALIZy9rmGf2lO1BcTvtbx47dTVAXcsEtaZ81maRwOiP+wV6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339765; c=relaxed/simple;
	bh=Z/va16cu+egduO3AYI0px0onFqB6KTABtuCKPGwdNWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AD+0bdNPRpBdXjpvqnUgXEHoFCfkkOlLOndoQ/cC5bCbNu0DkVQvBOPXcgQcFsmg2XExEsXwz+Ysk3fp7/O0ZLm0CpjI38IUYaS7ft7U9ASn94UxsuNZ57NdpAberztGruuJMYaCafUTllf9Vx4H70WW+1WbnnKAsLrzJRxYYQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4OxPC8q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PY0bfdbb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4OxPC8q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PY0bfdbb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788339762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36tw4ZvUCtSAzteuJdk87/uA5lZajpTUxbb/BHmZKtU=;
	b=a4OxPC8qUqMsjvbH3bWdcwAsoYK0OUJzLf3yD08FQ4pXR8/h/sRIMWuBDbKvVL+ZQ3bTTn
	Y3SzS0i2aakhzN077upG11HaXPftpZl6GPOvCALqJ08IXmhjLbw3UW5OSAnBfuQxq4nT87
	SYW6B6O14MqM5GnBsXufSIeJ6ABFiFs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-5pAEXJskMXeBQNgD8WA7hw-1; Wed, 02 Sept 2026 05:02:41 -0400
X-MC-Unique: 5pAEXJskMXeBQNgD8WA7hw-1
X-Mimecast-MFC-AGG-ID: 5pAEXJskMXeBQNgD8WA7hw_1788339760
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c25501f4aa2so103994566b.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 02:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788339760; x=1788944560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=36tw4ZvUCtSAzteuJdk87/uA5lZajpTUxbb/BHmZKtU=;
        b=PY0bfdbbkf7D3r7wpq0fprUeiJxYYzR7jxafnUUEcj25Ge8/RP6xbq6zNRjzX5EIrf
         F96oMTomhJKnsFvLY2U6bDCX5exZDNgqJHiWDZFHOfMSAj96BA+PzW/7a+B/7EJvv6Bv
         uWkemFjg2YemqH919glFoLdaZv5hMYeNgbkKGV3mZbXccVQzt+rDnm6vO9vYrb/TOEhh
         DpPihhm7L2KVcint+rLZEjLvabzWtvSy2712/yDrTISHY8YRVBpYnEtzVvm0Z80aQxgL
         BTyEVEBQZ5+yZXJsbTTY8Wd9N4sFzJkkLSKJePE7xvqukIgwWMk3wSkHyNWdwci3jhaB
         OW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788339760; x=1788944560;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=36tw4ZvUCtSAzteuJdk87/uA5lZajpTUxbb/BHmZKtU=;
        b=AmlO4uHPXpc2LvYuyMsQGE9G3P8wfG5nZrYCYKZ2qCTOuPekG6bYE3MImmwLdAzJBb
         gN8bt4Qqdk5k6C5JyGzvJCRFWvwu+W1Xj/CTfs+QrxUyAnoQSv/sMwma2EsdgGBq0LE7
         6qB9PMDt63DOUsJaMAAIjfdEXUqcR/yufNjLFHsRzD5nuSWW94t1Me/zWPvHcgkJ2tX5
         yabLpnoovHu8V0S6M1GrsYtCvUu/lId30Bnt3YF1AzjGwlkqSSSeYuThCngum7vzfzF3
         CooXrbOuBe4isI5p6A8hi1tZV14QGJwzbbwkqD5ZfyZAEjuNo6g7XS1LtATJx+JxqbEg
         0mBg==
X-Forwarded-Encrypted: i=1; AKwUvByjOeSQh1UH5E7Zfj0R2a/Wjj+kliNRcfnWzjc33aabK4hE/8Q8VOTMyclB+UopreXH3XuiSkg=@vger.kernel.org
X-Gm-Message-State: AFuF++nXztpNtyRkQUDj5eWjbVYtOLYpz4IxrZWyppSBJXJUNv3qR/bw
	RIg5wQJCarT24OeaKYABMFk7AuuX/nN+K3uY25jqJyyT2Ksc1MS2V4OHR2mwhd/wZxKmcCu13n6
	6S/JYWBiFUjZy/q+5l6kfERj9dVx7PwmHQX8cIiJGZSKVd+8q0BjBMm83pMlzk84Iqw==
X-Gm-Gg: AYBFou2l1u6TsdmFELGHkpWHyAo+KKLlxr/bF9aX3i/HoFmvODSVtJZ3tGp9hjZS6N0
	IELrccuBCQx1m+ji7SYk7vi4xKfl/TLtXHq8pckIvk5bC2qzXqdIZxRlYwfcWshuE+PsJo5r4cN
	QWivGvhWJrAzmE9u//FYJ11cojCU0h7xZ656AKJGoNxqwuOeIGga9U5C6kaXf4l+AbkGzmrLslp
	LDnfb8gipxVNAgz4U4lH5gaprQmJfP+bHa3M5Aopa0EzTtcEsLos44EIN6GaR0BxN3AU5FO62Ay
	TKh3numjMZlkSKXjkBS6ruL6TpkCQ4iNijYDsaHhrXoB2V1WsXqqHLKjnGMqzils3oXCawYXFW1
	8dEzNsTjZkAYQcGru2eT+T3vz3tckdNYlPaWOikuUeHrTYvdBmJjKIZUFQsXjSl7LUHQmZW6Svg
	==
X-Received: by 2002:a17:906:730e:b0:c25:c678:ff80 with SMTP id a640c23a62f3a-c25dc9c1306mr121965966b.2.1788339760146;
        Wed, 02 Sep 2026 02:02:40 -0700 (PDT)
X-Received: by 2002:a17:906:730e:b0:c25:c678:ff80 with SMTP id a640c23a62f3a-c25dc9c1306mr121954966b.2.1788339758784;
        Wed, 02 Sep 2026 02:02:38 -0700 (PDT)
Received: from [192.168.188.103] (ip245-45-231-195.pool-bba.aruba.it. [195.231.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc5a84sm97530666b.13.2026.09.02.02.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 02:02:38 -0700 (PDT)
Message-ID: <41c4b8b6-30ad-4ce9-916e-ad348d7850c7@redhat.com>
Date: Wed, 2 Sep 2026 11:02:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fix use-after-free in pskb_expand_head()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+22c4f9a7026c86bcc3b8@syzkaller.appspotmail.com,
 syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
References: <20260831095952.3385596-1-edumazet@google.com>
 <55aad0c8-6409-4c4a-846a-141ba12add4d@redhat.com>
 <CANn89iK+RvAVvARfJChV-AgKtF2KVTd-MRGBfRCy24N3GBCAzw@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CANn89iK+RvAVvARfJChV-AgKtF2KVTd-MRGBfRCy24N3GBCAzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/1/26 7:00 PM, Eric Dumazet wrote:
> On Tue, Sep 1, 2026 at 3:55 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 8/31/26 11:59 AM, Eric Dumazet wrote:
>>> pskb_expand_head() and pskb_carve_inside_header() decide whether to drop
>>> the old head gracefully via skb_release_data() or directly free it via
>>> skb_free_head().
>>>
>>> Blamed commit replaced the check against dataref == delta with skb_cloned(skb).
>>>
>>> However, skb_cloned(skb) masks out the upper 16 bits (SKB_DATAREF_SHIFT)
>>> of dataref using SKB_DATAREF_MASK. For an skb with nohdr == 1 or a clone
>>> referencing a shared buffer where only one regular reference exists,
>>> skb_cloned(skb) evaluates to false even when dataref is shared with other
>>> skbs.
>>>
>>> When pskb_expand_head() is called on such a buffer (e.g. during bridge
>>> flooding, generic XDP, or VLAN tag insertion), it falsely assumes the head
>>> is unshared and calls skb_free_head(skb) directly. This drops the underlying
>>> head/frag reference immediately, while other clones or references still
>>> point to it, causing a use-after-free in subsequent packet processing.
>>>
>>> Introduce skb_dataref_bias() and skb_data_is_shared() to accurately test
>>> if dataref is shared by checking atomic_read(&skb_shinfo(skb)->dataref) != bias.
>>>
>>> Use skb_dataref_bias() in skb_data_unref() and skb_data_is_shared() in
>>> pskb_expand_head() and pskb_carve_inside_header().
>>>
>>> Fixes: 3e24591a19bb ("skb: Drop "fastpath" variable for skb_cloned check in pskb_expand_head")
>>> Reported-by: syzbot+22c4f9a7026c86bcc3b8@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/netdev/6a954e27.4d659fcc.734b4.0046.GAE@google.com/
>>> Reported-by: syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=128e9f5a0f85a51215b1
>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>> ---
>>>  include/linux/skbuff.h | 13 ++++++++++++-
>>>  net/core/skbuff.c      |  4 ++--
>>>  2 files changed, 14 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>>> index 421f6fc454511ea6c7b83d5227481840a7c4bcc0..efeef148e1ba50cbb0d480975dc6c3c59acb98c7 100644
>>> --- a/include/linux/skbuff.h
>>> +++ b/include/linux/skbuff.h
>>> @@ -1295,6 +1295,11 @@ static inline bool skb_unref(struct sk_buff *skb)
>>>       return true;
>>>  }
>>>
>>> +static inline int skb_dataref_bias(const struct sk_buff *skb)
>>> +{
>>> +     return skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1;
>>> +}
>>> +
>>>  static inline bool skb_data_unref(const struct sk_buff *skb,
>>>                                 struct skb_shared_info *shinfo)
>>>  {
>>> @@ -1303,7 +1308,7 @@ static inline bool skb_data_unref(const struct sk_buff *skb,
>>>       if (!skb->cloned)
>>>               return true;
>>>
>>> -     bias = skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1;
>>> +     bias = skb_dataref_bias(skb);
>>>
>>>       if (atomic_read(&shinfo->dataref) == bias)
>>>               smp_rmb();
>>> @@ -2019,6 +2024,12 @@ static inline struct sk_buff *skb_get(struct sk_buff *skb)
>>>   * If users == 1, we are the only owner and can avoid redundant atomic changes.
>>>   */
>>>
>>> +static inline bool skb_data_is_shared(const struct sk_buff *skb)
>>> +{
>>> +     return skb->cloned &&
>>> +            atomic_read(&skb_shinfo(skb)->dataref) != skb_dataref_bias(skb);
>>> +}
>>> +
>>>  /**
>>>   *   skb_cloned - is the buffer a clone
>>>   *   @skb: buffer to check
>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>>> index 966af3beed94d0a9f0387cec70b5297eccfcf19f..f4c0645f98d3f2f0c8765403e0184769e928d7b0 100644
>>> --- a/net/core/skbuff.c
>>> +++ b/net/core/skbuff.c
>>> @@ -2331,7 +2331,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
>>>        * is not we can just drop the old head and let the existing refcount
>>>        * be since all we did is relocate the values
>>>        */
>>> -     if (skb_cloned(skb)) {
>>> +     if (skb_data_is_shared(skb)) {
>>
>> I'm sorry, I can't wrap my head around the above change; I have similar doubt WRT
>> the sashiko reported one:
>>
>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831095952.3385596-1-edumazet%40google.com
>>
>> that is: I can't see when the new condition yield different results from the
>> old one. Could you please describe exactly the bad layout and were/how it is
>> obtained?
> 
> Hi Paolo,
> 
> Here is the exact state layout and sequence where the old and new
> conditions differ:
> 
> 1. The Layout and Values
> 
> Suppose an sk_buff is marked with __skb_header_release(skb) (e.g. in TCP
> or skb_gro_receive()):
> - skb->nohdr = 1
> - dataref is set to 1 + (1 << 16) = 0x00010001
> 
> Now a clone is created (e.g. in br_flood() via deliver_clone(), packet
> socket tap, or veth):
> - __skb_clone(clone, skb) sets:
>   - clone->nohdr = 0 (clones always have nohdr = 0)
>   - clone->cloned = 1
>   - skb->cloned = 1
>   - dataref becomes 0x00010002 (or remains 0x00010001 if
>     __skb_header_release() was called during GRO on an already-referenced
>     buffer).
> 
> If a clone or sibling drops a reference via skb_data_unref() (subtracting
> bias = 1), dataref returns to 0x00010001.

This is the part that I can't follow: skb_data_unref() subtracts 1 if
and only if nohdr == 0. dataref should stay 0x00010001 only on the
"original" skb with nohdr == 1.

I feel the issue could be caused by __skb_header_release() being called
on a cloned skb, which is AFAIK illegal. I *think* veth in bridge with
GRO enabled could do that.

Perhaps adding a DEBUG_NET warning in __skb_header_release() would make
sense?

/P

