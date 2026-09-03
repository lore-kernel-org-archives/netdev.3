Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9541543F087
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426767; cv=none; b=GyV8fkmGxb7A9nk9srHHDef/nKvgLCmRAP5hABqIX1SOdSC0od/KNKwD/jhVJsqu7MdELBecweaEvBTLlSs84d6MWE20+3dKnLwjBlbfwW924saQxDI7z44iEaQzhUq2VVGaSt9Qvy6F1EVHJgS6S6TfunOiRJkiuerUknE2XQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426767; c=relaxed/simple;
	bh=8yRwhYp4T46Ioc2NqTAm466w7YfIjzlx6TzRz3cC4QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2EmIHcWyVMrt+E37ppKmtC0aoodWC03miktOtLla7cqLrKaJYsaPMawd19gdh8qZCloZ66FMNdOPkezAZwdd816SkbJgErCQgi54jD23AwWUxRgFQli1YOB7W0C8nNtKegaL7FwicLDpwBT2CCcvMsFlfAqTNU+KLJ6RfrLUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAOwcYVY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b52+jnQy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAOwcYVY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b52+jnQy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788426764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1lmLINHHaQaNFXVLN7hTt2q7wBOhBTt6Ut2+Ns4748E=;
	b=LAOwcYVYsFP0fAaOrI+DftyloBi50Rg7uOGDIA+jjLjvybHj8hPJdTqXdHm08mcr7F7qiv
	jYxCTryRnq42d07uKAL9F432Wr0XHutntZe3KDKD4qEISRw7tIA9uyzqJoFiio3FpgBolx
	+GohgkVVvGIv/JwfUcIgx1oKsKeTM1g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-O-aEN9ADN36i4x1yQM4CcA-1; Thu, 03 Sep 2026 05:12:43 -0400
X-MC-Unique: O-aEN9ADN36i4x1yQM4CcA-1
X-Mimecast-MFC-AGG-ID: O-aEN9ADN36i4x1yQM4CcA_1788426762
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so18474965e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 02:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788426762; x=1789031562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1lmLINHHaQaNFXVLN7hTt2q7wBOhBTt6Ut2+Ns4748E=;
        b=b52+jnQy8+MqE5WT6BlZhZKZWSQZtlC8iqku5GE4nTPQC0bfPJwLYK/o2nLsRQtWIC
         8RW/bkZN6lyL7zrkMAI4nAtHEGO/zEHOgPyZyv3zoFhEdHtrYJqB6rSKC/qOm/Fkt6Gb
         HqOPuGXo+JfoqGDmUkM+VqVPGsOz/4oOfcebCpZhdIJ62z7g1FNHm0CB6UqQMl1pLjRN
         bsuRd5TEDRdbbon4Fn54hf0VhyBzDbPqXcUXcmfCq03izm5VkRJu6MSzYUH5/AHrrn/z
         LOBZyy8besHkcS1+5J5CsevAGWob3EBWEFdg+ZCmSP81fDnXcXGtVH0jWJiUVrTc2zEb
         LvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788426762; x=1789031562;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1lmLINHHaQaNFXVLN7hTt2q7wBOhBTt6Ut2+Ns4748E=;
        b=W2pSyFXyp9Z0h5r0uax7aj8U5/PlHhe/Xe5wRU4lwup68GK8zvoB3ti8zpdFkRTOzW
         OHZrzLTXD5AwyTnIVnn+krXPvPXJ36U3e49kwJDbtLX+LWd/UukfjdDA5Mx/tpnBFwu8
         Pl+ORo8PDIlc0T9iIoyS0+bfLuhtw2owrAQFx1b3osCto79UuntsXM4obUD7wGnCJ2fR
         gXZf3XNkW/7MwaiOFIVjrCjnzC375IDDa2Pmj3w+KtugQICfbCMDR0rCVtpyG7CWSsMf
         21pkBZHxOrmBUI0LXhi3P/SRWazEV0EJtqBnNEvQQS7uENtaS9fC2jp3H6RtLdeQH5XA
         jizQ==
X-Gm-Message-State: AFuF++lSNUgJUYW/mfVOnoz4cqfknahYsRvWxhBPL6/ZnN5ngkj7CS1u
	KRrM8Y1yyBmN4HkXZyeaxtUKaxW1oMzKWE/L9fxoZK/FZYkvO4EI1Jqg7pXeWFdLpCD0VPIMh0H
	zLw2zaHg/3jisIxtxhSl6FhI1inj2tQonAaEM20QTdpcjMxS8ESs25oA/LQ==
X-Gm-Gg: AYBFou3PjYiZwTatP4XD0nqywcSqPCxgaWbsi2SZp4ioV057sbpq7gWNVr0/ub5nTs8
	jgTDP7kY8JS9CkzGV6qCXyNcAgvP+L9uI5v7LqCMtQsJuccRtMCi+st8XInnapcpEjBKcDZdkUd
	14r0Ug4uyZIflJz3FaatWFnmQ1B7GUnLaWpnHY1BgP3DEVeuIjuDX91SJOokE8EJ/3Uh0Di4ts3
	fpKB41E+Zfu9xqyN5kj6OaAmIxnbBiakoSKVNspi9T4Scyk4Y9atZWWSEsQB20m5o4FMj96WqDW
	KufIln15kXOfpZ4uuw0h1CEMm7eCKUI0SvQiKN50cBeISUCORBYlF1A9rrZfxR5QGxrtkFZqYVG
	IYwP+tKmKFWkMg9f/qpzvEpwSNhsSvp906xiUN/FaPGWG6r2DVzi9Evj/r13/QDkjmHKpwpPGIw
	==
X-Received: by 2002:a05:600c:5653:b0:49c:eb17:cf3b with SMTP id 5b1f17b1804b1-49ceb17cff4mr103012745e9.8.1788426761582;
        Thu, 03 Sep 2026 02:12:41 -0700 (PDT)
X-Received: by 2002:a05:600c:5653:b0:49c:eb17:cf3b with SMTP id 5b1f17b1804b1-49ceb17cff4mr103011865e9.8.1788426761041;
        Thu, 03 Sep 2026 02:12:41 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm54720075e9.6.2026.09.03.02.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 02:12:40 -0700 (PDT)
Message-ID: <b7ca242f-e381-4cf4-993f-a151dcc0cc8f@redhat.com>
Date: Thu, 3 Sep 2026 11:12:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,v2] net: bridge: mcast: fix br_multicast_list_adjacent rcu
 walk of mglist
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 linus.luessing@c0d3.blue, bridge@lists.linux.dev
References: <20260901074046.316190-1-razor@blackwall.org>
 <178835300671.3394541.1735736223580358438@kernel.org>
 <1df834f1-cdf8-4b1a-aae6-a86c74278509@blackwall.org>
 <30c1e3c4-71cb-426b-9949-d336b8824f95@blackwall.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <30c1e3c4-71cb-426b-9949-d336b8824f95@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/2/26 2:54 PM, Nikolay Aleksandrov wrote:
> On 02/09/2026 15:51, Nikolay Aleksandrov wrote:
>> On 02/09/2026 15:43, netdev-bot+sashiko@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential
>>> issue(s) to consider:
>>>
>>> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>>>
>>> - [Medium] net/bridge/br_multicast.c:br_multicast_list_adjacent() now
>>>    performs the entire per-port mglist walk, including one…
>>>
>>> -- 
>>>
>>> net: bridge: mcast: fix br_multicast_list_adjacent rcu walk of mglist
>>>
>>> The patch converts the mglist walk in br_multicast_list_adjacent() from an
>>> RCU walk to one done under the bridge's multicast_lock, since mglist was
>>> never converted to RCU.  It also makes the function return -ENOMEM on
>>> allocation failure and documents that in the kdoc.
>>>
>>> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com
>>>
>>>> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
>>>> index 3ef5d8bbf552e..97686984de6d5 100644
>>>> --- a/net/bridge/br_multicast.c
>>>> +++ b/net/bridge/br_multicast.c
>>>
>>> [ ... ]
>>>
>>>> @@ -4967,15 +4969,20 @@ int br_multicast_list_adjacent(struct net_device *dev,
>>>>           if (!port->dev || port->dev == dev)
>>>>               continue;
>>>> -        hlist_for_each_entry_rcu(group, &port->mglist, mglist) {
>>>> +        spin_lock_bh(&br->multicast_lock);
>>>> +        hlist_for_each_entry(group, &port->mglist, mglist) {
>>>>               entry = kmalloc_obj(*entry, GFP_ATOMIC);
>>>> -            if (!entry)
>>>> +            if (!entry) {
>>>> +                spin_unlock_bh(&br->multicast_lock);
>>>> +                count = -ENOMEM;
>>>>                   goto unlock;
>>>> +            }
>>>>               entry->addr = group->key.addr;
>>>>               list_add(&entry->list, br_ip_list);
>>>>               count++;
>>>>           }
>>>> +        spin_unlock_bh(&br->multicast_lock);
>>>>       }
>>>
>>> [Severity: Medium]
>>> How long can this critical section get?  The whole per-port mglist walk,
>>> including one kmalloc_obj(*entry, GFP_ATOMIC) per port group, now runs with
>>> br->multicast_lock held and bottom halves disabled.
>>>
>>> The number of allocations inside the section equals the length of
>>> port->mglist, which is only bounded by br->hash_max in
>>> br_multicast_new_group():
>>>
>>> net/bridge/br_multicast.c:br_multicast_new_group() {
>>>     ...
>>>     if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
>>>     ...
>>> }
>>>
>>> hash_max defaults to BR_MULTICAST_DEFAULT_HASH_MAX (4096) and can be set to
>>> any u32 without validation via netlink
>>> (br->hash_max = nla_get_u32(data[IFLA_BR_MCAST_HASH_MAX]) in br_netlink.c)
>>> or via set_hash_max() in br_sysfs_br.c.  The list contents themselves are
>>> populated by IGMP/MLD reports from hosts on the bridged L2 domain.
>>>
>>> While the lock is held, every other CPU that needs br->multicast_lock spins
>>> for it, including the br_multicast_rcv() receive path, the group and query
>>> expiry timers and br_multicast_port_group_rexmit().  Before this change the
>>> loop only held rcu_read_lock(), so a long mglist slowed the caller but did
>>> not block bridge multicast processing.
>>>
>>> The caller is periodic, so this is not a one-off:
>>>
>>> batadv_mcast_mla_update()
>>>    __batadv_mcast_mla_update()
>>>      batadv_mcast_mla_bridge_get()
>>>        br_multicast_list_adjacent()
>>>
>>> which runs every BATADV_MCAST_WORK_PERIOD (500 ms) from the batman-adv
>>> workqueue.
>>>
>>> Would it be preferable to bound the section, for example by pre-allocating
>>> the entries outside the lock, or by dropping and re-taking the lock in
>>> batches, rather than holding a bh-disabling spinlock across up to hash_max
>>> slab allocations?
>>>
>>
>> Oh please, enough with this shit. This is taking way too much time for a function
>> that is largely useless.
>>
>> I will just convert it properly to RCU in -net and be done with this.
>>
> 
> and just to be clear - IMO only bots and llm "security" researchers would be trying
> to do what is suggested above, I doubt there is any real-world case where it would
> actually happen.
I understand your frustration. Unfortunately ignoring this kind of
reports will lead to at least one security report, possibly with
unbelievably high impact due to unexpected chaining. That is, we can't
ignore them.

/P

