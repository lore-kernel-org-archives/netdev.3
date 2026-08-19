Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C4D42B327
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134453; cv=none; b=jjmeui7pRxWOM6OB4INpGXebSwZHpaY5IG9dbVLxxPomqcn3sUkh8SxYjt1sesOT/SCr2qRrH6fe+1857KgpUbvCQeJIVrbujUivEFLONolA5GL8ukNNdYsqCRnbEb+IAXFBlz1t5FAYaVB/RnbPOWSXnz+Vx/eZUW9Jj6BDCiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134453; c=relaxed/simple;
	bh=mJ4TkWkCmsmvOVV58OS1T7y6PlXzGj1rJS8dfNbodo8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RW3tkrrAexD4hNCLaEB1cvi4xeqaePYOcODKExm/pQs/7tbAwV5uS0Ws6aMYs4njGKUlNTlb/9Z38FUMPRZjTLBp61AtwRrQDCTFbhGv4zCWTZJEVP5DjeAapIIfV8ag9p3c/a+mFtPyTriKiKJATPfQNIxMh17f187CiF6bTVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=dNkxR8E2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="dNkxR8E2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so8732065e9.2
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 03:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787134450; x=1787739250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UAK1rtPDpHr45I7pYyTZ7WdNt1ScKed4iT4J+fZ9Gyg=;
        b=dNkxR8E2lCV+ovzSTiP0UNBiOmov909t9fmmh9m6M9pBMiQpi8T73vWQittlmGxwWv
         ts8XlYRMI8MucqDv5FUPL1Lghx14DvDYkkcARap7mC1e7MkHDydJLrGtS4NJDBBzaZCg
         ETWuNjdwdD1zV7nEk6FynCmymgJUV12Ck1/uUSvjWkDTyNJ7+5C9xi1gVtw8SoqYmAVu
         ZpIli+bXuNDzGCZNXcqCtb6zN6dcyiYAkK7CyNn7GUtodVr2tKiXxv5gmnCYzqJ0L0IG
         RA6feuCWjchY7c2eEXppAZRKFVs/iIY+/EgmepEAF/IFPgms77X7mEA/29djkdEHMZna
         FV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787134450; x=1787739250;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UAK1rtPDpHr45I7pYyTZ7WdNt1ScKed4iT4J+fZ9Gyg=;
        b=KHwHTv3msym36M/7HnB5QSR4jqL2EV1ZBcpmqWrXbMY2nerG/4KrowFtfUFTR3wL7T
         9bnbvaFIDJ+wgxFoXQ1YDjet1MCpwyck3NwdnujTVa6zxqMJ//AwWZ2yZyAadDgryylE
         vsM1uZigFMKqM4d6WENgjfrV8tINUf3wb1c08rTJupr6tRF5lkuRx0patQ1it1MaTsU5
         lv3TN4tVgx+TNjz/TzEkQYBm77Qin+Zkp2J0eaVfSLrOSoqqJ8zs6xz8PNm+gadaaVli
         A+CLMhv0DpbGz/VNt5CW2QAbXR6Yr82KwnVQ+Espwdc2qOvOb1lgt6AL6kVd29joglqJ
         6yxw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/AQz9KRJdluX7EwyQAdNlOnxclpOKctt+oZU5c5RsFKvJOUeMNwoW2w8EC1rv1aORN6nUJVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXHcgHL15CwAXEGWAjA7qqH+/X4DrYwcNb1Pv902B9AytT4lLa
	TFsjgNdSXitzVBJjC5RC6PC9N9HYn2q7d6n8GahdP78m9OOcLM0rLtDq1t4DXBP7CJQ=
X-Gm-Gg: AR+sD13JQUgtQwhnRDiAYOrsYLU8qT9htcd14h1ytp0lyoltR57cGt3hgTeNvVg/8j/
	nXiYgOeC0WUBSpwlnu2otyspitSjo69WundZTkyUti+2XLoQdNjGAle7zBoA302T4bM9ijYzSr5
	YDEYleZoVTg+FV6EdgIZmFn1mh55b/YNjzlYxdrez4hSjNz5Iq0l/zBu5kB2llgPwQ7d+eI4ZPq
	l8Q/5Nfgud/jTMfrfGV4UYthxXE4h75DzPxL6TOFZtWyV32ABUD7UAQdyS0FNipHNLHo86ucLu/
	16/Zf9vvz+5/470mBdCwYBhDvFqXiPotE2kw4DlljwXErzQ4JTwyrFsWC+M7HFGn+eV7UYzBJJB
	MA2j39UFB0mtWUMALE+/OS19lwaIXp71XQTP++EH7lsIsh/tOIBb1ZY+mwxXlwkazeU3e4K0EaR
	TyXi6ysWfrIvdS4wqCZTVooHONjqDxXGScobiWWMdEJMVpPjLt+XRp1Nk8g+nAnsJ75eATBB7xv
	pE/Ojxwcyyd9omudTc=
X-Received: by 2002:a05:600c:34ca:b0:499:858e:de42 with SMTP id 5b1f17b1804b1-499aa172300mr70859005e9.6.1787134450214;
        Wed, 19 Aug 2026 03:14:10 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0dd620sm46012225e9.13.2026.08.19.03.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 03:14:09 -0700 (PDT)
Message-ID: <cce1b5dc-5f2d-4065-b171-e35e083d169d@blackwall.org>
Date: Wed, 19 Aug 2026 13:14:08 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] bonding: fix u32 overflow in compute_gap()
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260818-bond_overflow-v3-0-e05d4dbc2fd8@kylinos.cn>
 <20260818-bond_overflow-v3-2-e05d4dbc2fd8@kylinos.cn>
 <d75e0db1-e129-4a9f-a103-889827948de1@blackwall.org>
 <80d704a8-aca6-44f8-8933-eb0cf14ecf3b@blackwall.org>
 <bf56ea5d-a0d2-40f9-b8d5-73d8c54ca32b@blackwall.org>
 <aoUP0sLeEhCPxukB@fedora> <aoUQdublxcfZzqzE@fedora>
 <1ebd9c8a-5b7e-4ebb-9c7d-5b2b2fe4a675@blackwall.org>
 <aoV8hvRlyRrFQobA@fedora>
 <c89c5035-8c53-4104-9ca6-cbeff864c01a@blackwall.org>
In-Reply-To: <c89c5035-8c53-4104-9ca6-cbeff864c01a@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2026 13:02, Nikolay Aleksandrov wrote:
> On 19/08/2026 12:51, Hangbin Liu wrote:
>> On Wed, Aug 19, 2026 at 11:35:29AM +0300, Nikolay Aleksandrov wrote:
>>> hmm why don't you change the way the reset is done? *untested* but in theory
>>> you could just record the values at a reset "moment" in reset unbalanced and
>>> just use the delta, so it becomes a reader and there is only 1 writer left (tx).
>>> Keep the counters only increasing (important), only record a snapshot at a reset
>>> moment, count current total bytes (sum all per-cpu data), decrement the previous
>>> total from it and use that as the "interval bytes" to div.
>>
>> Oh, you mean add another variable to track the total unbalanced load? e.g.
>>
> 
> right, but without any locking because...
> 

one more minor nit below

>> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
>> index 659a77323444..a65be54049d3 100644
>> --- a/drivers/net/bonding/bond_alb.c
>> +++ b/drivers/net/bonding/bond_alb.c
>> @@ -1546,10 +1546,10 @@ netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
>>       return bond_do_alb_xmit(skb, bond, tx_slave);
>>   }
>> -static u64 reset_unbalanced_load(struct alb_bond_info *bond_info)
>> +static u64 reset_unbalanced_load(struct bonding *bond, struct alb_bond_info *bond_info)
>>   {
>>       struct unbalanced_load_stats *p;
>> -    u64 tx_bytes, total_bytes = 0;
>> +    u64 delta, tx_bytes, total_bytes = 0;
>>       unsigned int start;
>>       int i;
>> @@ -1560,14 +1560,15 @@ static u64 reset_unbalanced_load(struct alb_bond_info *bond_info)
>>               tx_bytes = u64_stats_read(&p->tx_bytes);
>>           } while (u64_stats_fetch_retry(&p->syncp, start));
>> -        u64_stats_update_begin(&p->syncp);
>> -        u64_stats_set(&p->tx_bytes, 0);
>> -        u64_stats_update_end(&p->syncp);
>> -
>>           total_bytes += tx_bytes;
>>       }
>> -    return div_u64(total_bytes, BOND_TLB_REBALANCE_INTERVAL);
>> +    spin_lock_bh(&bond->mode_lock);
>> +    delta = total_bytes - bond_info->total_unbalanced;
>> +    bond_info->total_unbalanced = total_bytes;
>> +    spin_unlock_bh(&bond->mode_lock);
>> +
> 
> ... there should be only 1 alb monitor running, no need to lock to keep it up-to-date
>      also this is its only user, so remove the spinlock
> 
>> +    return div_u64(delta, BOND_TLB_REBALANCE_INTERVAL);
>>   }
>>   void bond_alb_monitor(struct work_struct *work)
>> @@ -1612,7 +1613,7 @@ void bond_alb_monitor(struct work_struct *work)
>>           bond_for_each_slave_rcu(bond, slave, iter) {
>>               tlb_clear_slave(bond, slave, 1);
>>               if (slave == rcu_access_pointer(bond->curr_active_slave))
>> -                SLAVE_TLB_INFO(slave).load = reset_unbalanced_load(bond_info);
>> +                SLAVE_TLB_INFO(slave).load = reset_unbalanced_load(bond, bond_info);
>>           }
>>           atomic_set(&bond_info->tx_rebalance_counter, 0);
>>       }
>> diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
>> index 51c083c76115..9d3877644286 100644
>> --- a/include/net/bond_alb.h
>> +++ b/include/net/bond_alb.h
>> @@ -131,6 +131,7 @@ struct unbalanced_load_stats {
>>   struct alb_bond_info {
>>       struct tlb_client_info    *tx_hashtbl; /* Dynamically allocated */
>>       struct unbalanced_load_stats __percpu    *unbalanced_load;
>> +    u64            total_unbalanced;

I'd name this prev_total_unbalanced or something similar since it is
the previous recorded value

>>       atomic_t        tx_rebalance_counter;
>>       int            lp_counter;
>>       /* -------- rlb parameters -------- */
>>
>> This looks like an easy update :) Hope I didn't miss anything.
>>
>> Thanks
>> Hangbin
> 

