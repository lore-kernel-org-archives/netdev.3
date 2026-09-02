Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255E6490C17
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353692; cv=none; b=flOeDReLiVW3htgQbp2EEDR5ftNxdmYUoLhq9wuRYc0P+dl2AeU8/Fvr6q+IqB46A9Sll3T4jXeeQPJIZBkcA24M136vsjnU2V93I80pXwNpCRxLRD7Auu7Fqqv08T/pqXiP01LFdX2XA3cjv84XrMaCOEKxGbc0QiDirexPyf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353692; c=relaxed/simple;
	bh=o3f7EjLmAoeGMx7zQB99T6qT5He6SvTMRTAJ/kicI/s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AqWzy6sgL6ufW5TMLBergvneCE/qC9NZ8pvBEqcTDerOOEQoyZj2beqlv5fRedjrGGN799GkbU94Ipea8vVDXjd2tFhXjEW9IlItQEI7LpAipGujGgBCENvAqfG68a4YGqU+s2rjmyoWoiSr8cPjpiCNqn8B4lAKtTilcLpWL1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=oNf/+nno; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="oNf/+nno"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c252c7270faso142561166b.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 05:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788353689; x=1788958489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DITijZ9Q92bPLBWXCNAyjT0FbcCXC7ezg5VUf3ZnRkQ=;
        b=oNf/+nnotPdPjEiMLIk1euVAEIL58DHi7Gvkvcqn5zr8Ic6OBqGwVRevPWuWKQTtk1
         TAznBn0k8/j03EEoitnfNGW9FnS8ioUMft85DtTUei4ptCvzKkldLVe/cv0203BdnOsJ
         NRKOQTShwUzS5wWL6HDhDtipPPikQEiR92KaldR2RvNZifJxVilERZHRdy+y/DhZmIEj
         NYUpGwo/rmNUEFRIsVa//1zkNaiM9hpZQ1+WOyO8Az2Rm1S+UBlJUsECZxtXUuDRqtsg
         bSYPd3z5f3uP1eThD/bRu9gNFHv5dso85V2Nr+PPH4EJRH4gH/s3e635tw0fnVpGjNe2
         FGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788353689; x=1788958489;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DITijZ9Q92bPLBWXCNAyjT0FbcCXC7ezg5VUf3ZnRkQ=;
        b=Gtz6XOE/mjSMIPPWQ1FfIqS/uSpM8b/xg+1FpsiqsqvopehVYAJJN6Kx9ZFtwomzGb
         9E3ES3hDsPTrezWUvkY3oTYPW9ErSRJTOIggylSL5vYCKB1r4dveotBTcJLRYYNG3UKj
         m4NnCpGAkdvMim8QtcvrdBMCwM/mLFxZo1v5LPQ1d8KiSUC1kw6vCAND+UV3+yzS2y0J
         lNo0Re+tDhVIILCfE1xOkN4y5UtWPp2J3i46/PT6qSH99Gmgso+7lIwlEjIfhbZzyKnp
         +kz4Ri5eJrV1bQ+x5se40+ITfWhBcRJrtpzLqYDNEmiruXF/ai4TlopKrpK91bzfbX0B
         +Z5g==
X-Gm-Message-State: AFuF++l9aKgJ19gtglD38i3iaiidHgNABBtUod89seEe+5bIc40g5kin
	Bi/Oev8SXkVlftTWlyXpNazvbCGct+XV4g1xfNHpH3Jf1gnuUZYnzxFQSxUHwqRSYxo=
X-Gm-Gg: AYBFou3+DdqwLBiC+U5pItBK26QHlAAlJXpKdcCf+xIpxXt7tbhcT/ucqjSShXK83PO
	SEBvoUxryJuJg6aO1HuE45++LJn94jGIB4F91gfHdfHQ8+3GDUgRbFjQVDwWKtmiqX+TpL1qGIJ
	TkS2GDmYyUTwn+EkTkvHKHPqyWqLzaN0ve8x05gYpAQGY2h0aOLEDKc4dSsZXvM6GPUX+CwZgEv
	YidXJkI4FYDXRUZdUrJFR1Zh7JOvVo9yZH2+9B7EO5DxY//r1Lj+bl23eu81gf47gUkOSGp3pSo
	ElvK71ORDlWcG2wnvp+82gCuk2EOkP2Zqxrfz5nycrIY5U4Vxlk82RBSPbmZWfihQFSC1VeChYE
	RD8VLLhdOskpaAF6v0qzdixSseoa9zldSBle4dlE3xHH3okOwoAKm+YjFSeMljbeYiaIWTfndrJ
	NWWBofZvWTwVHfkwC8mAmOCFSq582SEHD4Kch1shWQBakZdom07FMutKoy9TYEaVA1PGc5/ePqj
	RBRO6IZFn4hN5v7RJLuNN1lk4bJ4A==
X-Received: by 2002:a17:906:478a:b0:c25:938a:754c with SMTP id a640c23a62f3a-c25d54f6ddamr285434866b.20.1788353688997;
        Wed, 02 Sep 2026 05:54:48 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d043e6bcsm129669266b.61.2026.09.02.05.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 05:54:48 -0700 (PDT)
Message-ID: <30c1e3c4-71cb-426b-9949-d336b8824f95@blackwall.org>
Date: Wed, 2 Sep 2026 15:54:47 +0300
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
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linus.luessing@c0d3.blue, bridge@lists.linux.dev
References: <20260901074046.316190-1-razor@blackwall.org>
 <178835300671.3394541.1735736223580358438@kernel.org>
 <1df834f1-cdf8-4b1a-aae6-a86c74278509@blackwall.org>
In-Reply-To: <1df834f1-cdf8-4b1a-aae6-a86c74278509@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/09/2026 15:51, Nikolay Aleksandrov wrote:
> On 02/09/2026 15:43, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue(s) to consider:
>>
>> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>>
>> - [Medium] net/bridge/br_multicast.c:br_multicast_list_adjacent() now
>>    performs the entire per-port mglist walk, including one…
>>
>> -- 
>>
>> net: bridge: mcast: fix br_multicast_list_adjacent rcu walk of mglist
>>
>> The patch converts the mglist walk in br_multicast_list_adjacent() from an
>> RCU walk to one done under the bridge's multicast_lock, since mglist was
>> never converted to RCU.  It also makes the function return -ENOMEM on
>> allocation failure and documents that in the kdoc.
>>
>> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com
>>
>>> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
>>> index 3ef5d8bbf552e..97686984de6d5 100644
>>> --- a/net/bridge/br_multicast.c
>>> +++ b/net/bridge/br_multicast.c
>>
>> [ ... ]
>>
>>> @@ -4967,15 +4969,20 @@ int br_multicast_list_adjacent(struct net_device *dev,
>>>           if (!port->dev || port->dev == dev)
>>>               continue;
>>> -        hlist_for_each_entry_rcu(group, &port->mglist, mglist) {
>>> +        spin_lock_bh(&br->multicast_lock);
>>> +        hlist_for_each_entry(group, &port->mglist, mglist) {
>>>               entry = kmalloc_obj(*entry, GFP_ATOMIC);
>>> -            if (!entry)
>>> +            if (!entry) {
>>> +                spin_unlock_bh(&br->multicast_lock);
>>> +                count = -ENOMEM;
>>>                   goto unlock;
>>> +            }
>>>               entry->addr = group->key.addr;
>>>               list_add(&entry->list, br_ip_list);
>>>               count++;
>>>           }
>>> +        spin_unlock_bh(&br->multicast_lock);
>>>       }
>>
>> [Severity: Medium]
>> How long can this critical section get?  The whole per-port mglist walk,
>> including one kmalloc_obj(*entry, GFP_ATOMIC) per port group, now runs with
>> br->multicast_lock held and bottom halves disabled.
>>
>> The number of allocations inside the section equals the length of
>> port->mglist, which is only bounded by br->hash_max in
>> br_multicast_new_group():
>>
>> net/bridge/br_multicast.c:br_multicast_new_group() {
>>     ...
>>     if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
>>     ...
>> }
>>
>> hash_max defaults to BR_MULTICAST_DEFAULT_HASH_MAX (4096) and can be set to
>> any u32 without validation via netlink
>> (br->hash_max = nla_get_u32(data[IFLA_BR_MCAST_HASH_MAX]) in br_netlink.c)
>> or via set_hash_max() in br_sysfs_br.c.  The list contents themselves are
>> populated by IGMP/MLD reports from hosts on the bridged L2 domain.
>>
>> While the lock is held, every other CPU that needs br->multicast_lock spins
>> for it, including the br_multicast_rcv() receive path, the group and query
>> expiry timers and br_multicast_port_group_rexmit().  Before this change the
>> loop only held rcu_read_lock(), so a long mglist slowed the caller but did
>> not block bridge multicast processing.
>>
>> The caller is periodic, so this is not a one-off:
>>
>> batadv_mcast_mla_update()
>>    __batadv_mcast_mla_update()
>>      batadv_mcast_mla_bridge_get()
>>        br_multicast_list_adjacent()
>>
>> which runs every BATADV_MCAST_WORK_PERIOD (500 ms) from the batman-adv
>> workqueue.
>>
>> Would it be preferable to bound the section, for example by pre-allocating
>> the entries outside the lock, or by dropping and re-taking the lock in
>> batches, rather than holding a bh-disabling spinlock across up to hash_max
>> slab allocations?
>>
> 
> Oh please, enough with this shit. This is taking way too much time for a function
> that is largely useless.
> 
> I will just convert it properly to RCU in -net and be done with this.
> 

and just to be clear - IMO only bots and llm "security" researchers would be trying
to do what is suggested above, I doubt there is any real-world case where it would
actually happen.


