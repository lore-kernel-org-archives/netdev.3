Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF521284B4F
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426907; cv=none; b=KXa94ZDnMtC3M2/LKRTzNudFIJBRrsRCX48SslEyJ3C368yIjAp0Wr7ZimUzl4XOm0hUed3hGwP9nr2aLHG5l1ReunFv3IGUX7wxIhQs+K5E4dd7WgiSY1Z30DRuqn6apISgrIytLxuXgOJJArI7KPRS1zyCkS+NNm2Isvrg1RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426907; c=relaxed/simple;
	bh=RqpgGZVtfB2J+h75TJKDrZC9zVQSgT4b2v2Xy0Jprh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IASHF30S+JWj/9+YWKa6cBJbYdUyl1bttDpqlWsyej9gXFyWT8ZbHn+lZ2JskX3Ye75fVZhk7ZoW8uKrUTfUt3BB2xwktmkxSeQ3OIahujRlNTc2q0KN4cNkKNTQezEzSLBtN5ub5SdU8GvDN5cu/Nx1mcbf+JkFMtobNj84U+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=droCPgDT; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="droCPgDT"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4843e397f74so1095050f8f.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 02:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788426904; x=1789031704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wU9Z4QgDQQ63Lq/IIsJ44QGDy5mL0TGHF3RUnidQY+Q=;
        b=droCPgDT33xpDX3OA9xtdid5UoEIDmzH77/L1njyoiESE8i5mpl9GwZjmxlws6ypv7
         jnnPhkUy4M/cCt/T/SbgvfOSb+FeqxsKV4weqadmPfVcvIyzonoI+fk8fx1/f/OfoL6z
         ssbr3i8aRB3DIvrQRftzm78XnWuRa7EKk/jOy2bw+8wEo+BrBC4O7oeMiJ8SP2Rdn+rB
         YVEZkE4NvENrRwr8dCEKDRT9Y+ejjlcFQizP+LCYjw9YmB/oqMQIPo7HRRfGcVdqVmpj
         YITQ+zh40yrnjtNzV40zSufqNXRHDQRzTQXLIUbQ8aAEGiBXb2QkqVk2+SqYlf9xAGOR
         /9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788426904; x=1789031704;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wU9Z4QgDQQ63Lq/IIsJ44QGDy5mL0TGHF3RUnidQY+Q=;
        b=SGr8EpOvwxz1gCbWoMs4MoqxbA/T24Xt1/ps6dGFH/aeWh/2NI6PbHBPOZ2VMAmc5i
         LZj4SgqKh66UXdC/sIwklvtWqUqKZJ9MZUsDhQgSunngTPb7hLZ5j/imoTolzkTHm/pI
         xUDgX+6XWnlF8/MUJdlhXK8TChj0jj52l1U3R2G0vQe3K2O781hQOdIsZALN+qb27I/C
         yFeMRXm8HWTM9U/Vin4DT64VPgEjDjavFXHJarBlDLjGnwHBUGn8S4WLpoKkysbX/yNd
         De1VS6TI2KyESMRy5lGdp22cZB0Tf3yBmhycsMk0AnakAWkxTuBi6CgwzpucWejI6MAi
         ohBw==
X-Gm-Message-State: AFuF++kwzdKYOTUMT5W8lYc0odDP09i/Jj+AIf7rEA6MPahlviENdmKI
	L2EYKxkET8+668H/qC8FHH8U6dLVLu584bxLwaZg7GcPe6RNAE66nu6rJex28KFC5Vs=
X-Gm-Gg: AYBFou0La6yoEvdk8kCReEzdJczIUB5aMV8g2ixH+AgmSo/y35q8yVF74zUTe2XVwwW
	gI2UylMX0SMGPtWY/ZzamSJ9sdgjmfgrZL8Nayj2hSV57lw/IV+J+K1kUgQFEQA24kluO2Ke72k
	leCia11av6J3s59gHoFC7eBGN9DJFxgXYxVRDVaNzkceAxa57sbb1Yi1iY9pJWjoFGXadxd81xl
	ctY34c0J9C+ojPYP/hOa3UlkE/yP33kA/0pcg8DR3h+fl1cZYLpas7FZQjBNhk5aYBBGT9vcBdj
	OpU1D7M5uVP16HrPHlbKHhWySi3IpXCNt83E0qQKe04pabJtx0o1wim/AyA5y8DdLKX7BP/oL8q
	jcN8QCmHSt3DVO3nSduHewjI3e3olsez9+DsazvQPTfkWAKnpg7t+c6HH1KwvKMTJlkBbMQW8Fh
	FDh9RHILIIVoaSsWOFGWB/Fgcmno34jeFEhiJZXzH8vUOyV33LODp2gFVaVHBNEi//p2iad8ddA
	Tr6ByNbGSAj/p9EC3A=
X-Received: by 2002:a05:600c:6303:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-49cf1581370mr23239015e9.4.1788426903342;
        Thu, 03 Sep 2026 02:15:03 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d2019sm54930775e9.2.2026.09.03.02.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 02:15:02 -0700 (PDT)
Message-ID: <4adcf116-66a5-4895-9b87-bbad9cba3a4c@blackwall.org>
Date: Thu, 3 Sep 2026 12:15:01 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,v2] net: bridge: mcast: fix br_multicast_list_adjacent rcu
 walk of mglist
Content-Language: en-US, bg
To: Paolo Abeni <pabeni@redhat.com>, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 linus.luessing@c0d3.blue, bridge@lists.linux.dev
References: <20260901074046.316190-1-razor@blackwall.org>
 <178835300671.3394541.1735736223580358438@kernel.org>
 <1df834f1-cdf8-4b1a-aae6-a86c74278509@blackwall.org>
 <30c1e3c4-71cb-426b-9949-d336b8824f95@blackwall.org>
 <b7ca242f-e381-4cf4-993f-a151dcc0cc8f@redhat.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <b7ca242f-e381-4cf4-993f-a151dcc0cc8f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/09/2026 12:12, Paolo Abeni wrote:
> On 9/2/26 2:54 PM, Nikolay Aleksandrov wrote:
>> On 02/09/2026 15:51, Nikolay Aleksandrov wrote:
>>> On 02/09/2026 15:43, netdev-bot+sashiko@kernel.org wrote:
>>>> Thank you for your contribution! Sashiko AI review found 1 potential
>>>> issue(s) to consider:
>>>>
>>>> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>>>>
>>>> - [Medium] net/bridge/br_multicast.c:br_multicast_list_adjacent() now
>>>>     performs the entire per-port mglist walk, including one…
>>>>
>>>> -- 
>>>>
>>>> net: bridge: mcast: fix br_multicast_list_adjacent rcu walk of mglist
>>>>
>>>> The patch converts the mglist walk in br_multicast_list_adjacent() from an
>>>> RCU walk to one done under the bridge's multicast_lock, since mglist was
>>>> never converted to RCU.  It also makes the function return -ENOMEM on
>>>> allocation failure and documents that in the kdoc.
>>>>
>>>> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com
>>>>
>>>>> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
>>>>> index 3ef5d8bbf552e..97686984de6d5 100644
>>>>> --- a/net/bridge/br_multicast.c
>>>>> +++ b/net/bridge/br_multicast.c
>>>>
>>>> [ ... ]
>>>>
>>>>> @@ -4967,15 +4969,20 @@ int br_multicast_list_adjacent(struct net_device *dev,
>>>>>            if (!port->dev || port->dev == dev)
>>>>>                continue;
>>>>> -        hlist_for_each_entry_rcu(group, &port->mglist, mglist) {
>>>>> +        spin_lock_bh(&br->multicast_lock);
>>>>> +        hlist_for_each_entry(group, &port->mglist, mglist) {
>>>>>                entry = kmalloc_obj(*entry, GFP_ATOMIC);
>>>>> -            if (!entry)
>>>>> +            if (!entry) {
>>>>> +                spin_unlock_bh(&br->multicast_lock);
>>>>> +                count = -ENOMEM;
>>>>>                    goto unlock;
>>>>> +            }
>>>>>                entry->addr = group->key.addr;
>>>>>                list_add(&entry->list, br_ip_list);
>>>>>                count++;
>>>>>            }
>>>>> +        spin_unlock_bh(&br->multicast_lock);
>>>>>        }
>>>>
>>>> [Severity: Medium]
>>>> How long can this critical section get?  The whole per-port mglist walk,
>>>> including one kmalloc_obj(*entry, GFP_ATOMIC) per port group, now runs with
>>>> br->multicast_lock held and bottom halves disabled.
>>>>
>>>> The number of allocations inside the section equals the length of
>>>> port->mglist, which is only bounded by br->hash_max in
>>>> br_multicast_new_group():
>>>>
>>>> net/bridge/br_multicast.c:br_multicast_new_group() {
>>>>      ...
>>>>      if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
>>>>      ...
>>>> }
>>>>
>>>> hash_max defaults to BR_MULTICAST_DEFAULT_HASH_MAX (4096) and can be set to
>>>> any u32 without validation via netlink
>>>> (br->hash_max = nla_get_u32(data[IFLA_BR_MCAST_HASH_MAX]) in br_netlink.c)
>>>> or via set_hash_max() in br_sysfs_br.c.  The list contents themselves are
>>>> populated by IGMP/MLD reports from hosts on the bridged L2 domain.
>>>>
>>>> While the lock is held, every other CPU that needs br->multicast_lock spins
>>>> for it, including the br_multicast_rcv() receive path, the group and query
>>>> expiry timers and br_multicast_port_group_rexmit().  Before this change the
>>>> loop only held rcu_read_lock(), so a long mglist slowed the caller but did
>>>> not block bridge multicast processing.
>>>>
>>>> The caller is periodic, so this is not a one-off:
>>>>
>>>> batadv_mcast_mla_update()
>>>>     __batadv_mcast_mla_update()
>>>>       batadv_mcast_mla_bridge_get()
>>>>         br_multicast_list_adjacent()
>>>>
>>>> which runs every BATADV_MCAST_WORK_PERIOD (500 ms) from the batman-adv
>>>> workqueue.
>>>>
>>>> Would it be preferable to bound the section, for example by pre-allocating
>>>> the entries outside the lock, or by dropping and re-taking the lock in
>>>> batches, rather than holding a bh-disabling spinlock across up to hash_max
>>>> slab allocations?
>>>>
>>>
>>> Oh please, enough with this shit. This is taking way too much time for a function
>>> that is largely useless.
>>>
>>> I will just convert it properly to RCU in -net and be done with this.
>>>
>>
>> and just to be clear - IMO only bots and llm "security" researchers would be trying
>> to do what is suggested above, I doubt there is any real-world case where it would
>> actually happen.
> I understand your frustration. Unfortunately ignoring this kind of
> reports will lead to at least one security report, possibly with
> unbelievably high impact due to unexpected chaining. That is, we can't
> ignore them.
> 
> /P
> 

Sure, I know. :) Sorry about the noise, I guess frustration got the best of me. I've
already prepared the proper fix that converts mglist to use RCU and we don't need
the spinlock at all. I'll send it out after running a few tests.

Cheers,
  Nik


