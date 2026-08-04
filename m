Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925FE3EC835
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857713; cv=none; b=LPSq3uF5FQxPZgc54A5Q4O/FHwyP57MBSNg3NdmstowKMn3fqdFoJMVpORvv27G17qyOv6SJdbp1GwFyLdokSPcE7vO6x/G+gfpD/7FfQU3jkW08Q7liOcDiHR/3Xvh+N+PzzcElwCSfEucUktR/UvY287IWPA5Lw6PP6xrEG4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857713; c=relaxed/simple;
	bh=Jh749yhs58CCP2iw/Ld/j3P1zXx7Y7po5NaLk3z+OKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ko7rOcP9Ez2K1v5UgBr8LFFjQib6RIkhRSpLUAgt+Q+UfhCKjv3vloxE9SLbA+kejWBGR656w2wTliHTAQkHarrgd0bU/TKw9Vj/DgHzC08ZzPis7sEvWClMGIlsAxMskvne0zciuwDMXv+/qreyK2j3lZwBNAa2IRdJRmeAKpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso10000195e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 08:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785857710; x=1786462510;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bxCaWGm4XHxMj3tFKOsTIE7WTNZmB8APAiExwRW5hyQ=;
        b=BpCkbn5PqkHnT+DE9O3DYnECJQUYYjGkoJT0tWwYdZXQ++A0RMmw4mF+//ZXhu+jUc
         keGOYnSE18EMAeY0RF7+bRUWP1E8THHa2buNFyd7Y8OXbfrSZl3KFka/rJPEke9qJ2fz
         AcWW2B70JDSi8AxciXDBjBdG+iqyJ82LGCbPLUgtIZnLJPxj2kj64UaCImQKjeEvKSqd
         g5olonlgvOUOvTxVzmQuFtSEwdgvFAKeotzUmapwL46qAtTgofZbAgxUjQAUHRz+dft5
         FRQezLncB+F2pzdA0a7VMxOc/+FmkSofHsQ1FXyDly9zFN5vBHzk+Jkohd+1LOx6jeSs
         /71A==
X-Forwarded-Encrypted: i=1; AHgh+RpNoXUIkI0gyBS6zuZJQiJpl86t7sGqhyfbyRp+JwYffpaMIlS68jz/0KyVuuyqiErpAuIt6cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF9dpL0DterqEAfh9aMus5YvMPOHeWRGLwuZ9YKePnpbPH5re4
	9N83cUVVS1lQoamwW6+AYrD8U0pMLFUAFq3qghPyp1KzjojPsm8h5q7p
X-Gm-Gg: AR+sD11wkXxuHXNWGqhgjWp6gzwdySkStpJ1RXhQrFu2D1+xExHKvMM7rMiD2pqj19h
	WzWfzUmmRfMsKBY8KknQKP3srjaD0PZwDOg3CHzP4mjRxA/rOTM7cxk6d8z4nO/AldqMijgXxiW
	RLEiEV26DOtSvrj6ApytUKUfUSBqZ7fNvfmrfa7Br+wd3DXFPilWd/t+GziVqTpI/9FisutfOl4
	NSz49hLIzKRlFX3NA/IDw8qYqAqZu7Hi5OjPPmtaCrfwJWVgGF/fLfouqD4lddjRNjCKQLaqqJe
	dzHQHHwb06cWCqak2o/sxvvt9jiO3TZ11FXBSLk16wit2Kng+b8faerReRRyKn96bTw1Vo5tjZe
	G6jmchVVVtzv8MeeVbjaLJXw/rLj8P3Ae2BqxokM2HQW+m0lvRYNMJDu0nsjhV7KCZMby7Wjeqc
	i43BvcQ9mEUAdBo9ixLHfanMOsQoPQ+YfVWFl2aAgEnbsfsO+GYiDO0LBAVyO0ltm0PEIVshq49
	9coopUlbnucJ30h/nNmCxpSig==
X-Received: by 2002:a05:600c:19cf:b0:493:bb29:af40 with SMTP id 5b1f17b1804b1-4980c674808mr324891165e9.14.1785857707704;
        Tue, 04 Aug 2026 08:35:07 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b8d04fsm475356495e9.3.2026.08.04.08.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 08:35:07 -0700 (PDT)
Message-ID: <cf908cea-5518-4dec-bf47-73b4e6b5568b@ovn.org>
Date: Tue, 4 Aug 2026 17:35:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 3/3] geneve: Support per-netns netdev
 unregistration.
To: Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, i.maximets@ovn.org
References: <20260731164612.2148830-1-kuniyu@google.com>
 <20260731164612.2148830-4-kuniyu@google.com>
 <bfa765c2-a3e7-42b7-90c5-9757d8392687@redhat.com>
 <CAAVpQUDmZEaQNDSySLayqexgTrUbhBaL7XPCt9XNQzh+NGQ=UQ@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmfB9JAFCQyI7q0ACgkQuffsd8gpv5YQ
 og/8DXt1UOznvjdXRHVydbU6Ws+1iUrxlwnFH4WckoFgH4jAabt25yTa1Z4YX8Vz0mbRhTPX
 M/j1uORyObLem3of4YCd4ymh7nSu++KdKnNsZVHxMcoiic9ILPIaWYa8kTvyIDT2AEVfn9M+
 vskM0yDbKa6TAHgr/0jCxbS+mvN0ZzDuR/LHTgy3e58097SWJohj0h3Dpu+XfuNiZCLCZ1/G
 AbBCPMw+r7baH/0evkX33RCBZwvh6tKu+rCatVGk72qRYNLCwF0YcGuNBsJiN9Aa/7ipkrA7
 Xp7YvY3Y1OrKnQfdjp3mSXmknqPtwqnWzXvdfkWkZKShu0xSk+AjdFWCV3NOzQaH3CJ67NXm
 aPjJCIykoTOoQ7eEP6+m3WcgpRVkn9bGK9ng03MLSymTPmdINhC5pjOqBP7hLqYi89GN0MIT
 Ly2zD4m/8T8wPV9yo7GRk4kkwD0yN05PV2IzJECdOXSSStsf5JWObTwzhKyXJxQE+Kb67Wwa
 LYJgltFjpByF5GEO4Xe7iYTjwEoSSOfaR0kokUVM9pxIkZlzG1mwiytPadBt+VcmPQWcO5pi
 WxUI7biRYt4aLriuKeRpk94ai9+52KAk7Lz3KUWoyRwdZINqkI/aDZL6meWmcrOJWCUMW73e
 4cMqK5XFnGqolhK4RQu+8IHkSXtmWui7LUeEvO/OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Z8H0qQUJDIjuxgAKCRC59+x3yCm/loAdD/wJCOhPp9711J18B9c4f+eNAk5vrC9Cj3RyOusH
 Hebb9HtSFm155Zz3xiizw70MSyOVikjbTocFAJo5VhkyuN0QJIP678SWzriwym+EG0B5P97h
 FSLBlRsTi4KD8f1Ll3OT03lD3o/5Qt37zFgD4mCD6OxAShPxhI3gkVHBuA0GxF01MadJEjMu
 jWgZoj75rCLG9sC6L4r28GEGqUFlTKjseYehLw0s3iR53LxS7HfJVHcFBX3rUcKFJBhuO6Ha
 /GggRvTbn3PXxR5UIgiBMjUlqxzYH4fe7pYR7z1m4nQcaFWW+JhY/BYHJyMGLfnqTn1FsIwP
 dbhEjYbFnJE9Vzvf+RJcRQVyLDn/TfWbETf0bLGHeF2GUPvNXYEu7oKddvnUvJK5U/BuwQXy
 TRFbae4Ie96QMcPBL9ZLX8M2K4XUydZBeHw+9lP1J6NJrQiX7MzexpkKNy4ukDzPrRE/ruui
 yWOKeCw9bCZX4a/uFw77TZMEq3upjeq21oi6NMTwvvWWMYuEKNi0340yZRrBdcDhbXkl9x/o
 skB2IbnvSB8iikbPng1ihCTXpA2yxioUQ96Akb+WEGopPWzlxTTK+T03G2ljOtspjZXKuywV
 Wu/eHyqHMyTu8UVcMRR44ki8wam0LMs+fH4dRxw5ck69AkV+JsYQVfI7tdOu7+r465LUfg==
In-Reply-To: <CAAVpQUDmZEaQNDSySLayqexgTrUbhBaL7XPCt9XNQzh+NGQ=UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/4/26 5:24 PM, Kuniyuki Iwashima wrote:
> On Tue, Aug 4, 2026 at 6:47 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 7/31/26 6:45 PM, Kuniyuki Iwashima wrote:
>>> geneve_exit_rtnl_net() iterates geneve devices whose sockets
>>> are in the dying netns and queues them for destruction.
>>>
>>> So the devices may reside in different netns.
>>>
>>> Let's use unregister_netdevice_queue_net() to support per-netns
>>> device unregistration.
>>>
>>> list_del() is changed to list_del_init() to avoid queueing the
>>> same device twice.
>>>
>>> Even after geneve_exit_rtnl_net() queues a cross-netns geneve
>>> device, geneve_dellink() can be called concurrently for it.
>>> In such a case, __rtnl_net_unlock() will perform the unregistration.
>>>
>>> Note that geneve uses register_pernet_subsys() instead of _device(),
>>> so default_device_exit_batch() guarantees that the async per-netns
>>> works are flushed before ->exit().
>>>
>>> Tested:
>>>
>>> 1. Create geneve device across two netns.
>>>
>>>   # ip netns add ns1
>>>   # ip netns add ns2
>>>   # ip -n ns1 link add geneve0 link-netns ns2 type geneve external
>>>
>>> 2. Run bpftrace to check that geneve_uninit() is called between
>>>    ->exit_rtnl() and ->exit().
>>>
>>>   # bpftrace -e '#include <linux/netdevice.h>
>>>   kprobe:geneve_uninit {
>>>       $dev = (struct net_device *)arg0;
>>>       printf("PID: %d | DEV: %s%s\n", pid, $dev->name, kstack());
>>>   }
>>>   kprobe:geneve_exit_rtnl_net,
>>>   kprobe:geneve_exit_net {
>>>       printf("PID: %d%s\n", pid, kstack());
>>>   }'
>>>
>>> 3. Remove the netns where the geneve socket resides
>>>
>>>   # ip netns del ns2
>>>
>>> Now, we can see geneve0 is unregistered by per-netns work
>>> instead of cleanup_net() and it finishes before ->exit() to
>>> avoid WARN_ON_ONCE(!list_empty(&gn->sock_list)) there.
>>>
>>>   PID: 571
>>>           geneve_exit_rtnl_net+5
>>>           ops_undo_list+702
>>>           cleanup_net+1122
>>>           process_scheduled_works+2538
>>>   ...
>>>   PID: 1047 | DEV: geneve0
>>>           geneve_uninit+5
>>>           unregister_netdevice_many_notify+7129
>>>           unregister_netdevice_many_net+1050
>>>           rtnl_net_work_func+136
>>>           process_scheduled_works+2538
>>>   ...
>>>   PID: 571
>>>           geneve_exit_net+5
>>>           ops_undo_list+1064
>>>           cleanup_net+1122
>>>           process_scheduled_works+2538
>>>   ...
>>>
>>> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>>> ---
>>>  drivers/net/geneve.c | 12 +++++++-----
>>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
>>> index f456a85dca77..a6a8978e3b81 100644
>>> --- a/drivers/net/geneve.c
>>> +++ b/drivers/net/geneve.c
>>> @@ -2502,12 +2502,13 @@ static int geneve_changelink(struct net_device *dev, struct nlattr *tb[],
>>>       return err;
>>>  }
>>>
>>> -static void __geneve_dellink(struct net_device *dev, struct list_head *head)
>>> +static void __geneve_dellink(struct net *net, struct net_device *dev,
>>> +                          struct list_head *head)
>>>  {
>>>       struct geneve_dev *geneve = netdev_priv(dev);
>>>
>>> -     list_del(&geneve->next);
>>> -     unregister_netdevice_queue(dev, head);
>>> +     list_del_init(&geneve->next);
>>> +     unregister_netdevice_queue_net(net, dev, head);
>>>  }
>>>
>>>  static void geneve_dellink(struct net_device *dev, struct list_head *head)
>>> @@ -2518,7 +2519,8 @@ static void geneve_dellink(struct net_device *dev, struct list_head *head)
>>>       gn = net_generic(geneve->net, geneve_net_id);
>>>
>>>       mutex_lock(&gn->lock);
>>> -     __geneve_dellink(dev, head);
>>> +     if (!list_empty(&geneve->next))
>>> +             __geneve_dellink(dev_net(dev), dev, head);
>>
>> Sashiko noted that the lockdep chain between dev->lock, utn->loc and
>> gn->lock is not trivial, possibly a documentation follow-up would be useful
>>
>>>       mutex_unlock(&gn->lock);
>>>  }
>>>
>>> @@ -2754,7 +2756,7 @@ static void __net_exit geneve_exit_rtnl_net(struct net *net,
>>>       mutex_lock(&gn->lock);
>>>
>>>       list_for_each_entry_safe(geneve, next, &gn->geneve_list, next)
>>> -             __geneve_dellink(geneve->dev, dev_to_kill);
>>> +             __geneve_dellink(net, geneve->dev, dev_to_kill);
>>
>> Here sashiko foresees some problem with CONFIG_DEBUG_NET_SMALL_RTNL
>> before full conversion to per netns lock even of ovs. Just more
>> follow-up, I guess.
> 
> Is it Sashiko-nipa output ?
> I can't find the comments from patchwork.
> https://patchwork.kernel.org/project/netdevbpf/patch/20260731164612.2148830-2-kuniyu@google.com/
> https://sashiko.dev/#/patchset/20260731164612.2148830-1-kuniyu@google.com
> 
> btw, I was hoping this series would land upstream so that
> I don't need to care about OVS :)
> https://lore.kernel.org/netdev/20260513183559.2141010-1-i.maximets@ovn.org/
FWIW, I have the non-RFC version of this set prepared.  I can post it,
if that helps.

Best regards, Ilya Maximets.
