Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DA6476CDB
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864898; cv=none; b=EFIa2LH43lcgoHtHD6KDwhSeS2k+D0XbHeDRlSW1X9G76h2ZFyegh5gniRb6Jv68Y/uw9TOfT8AtPVGdnF+DAUo6sY5DUcFCBVmsG9SdN4TVUNWMK0jyi8Qx2Ng4vYuiJAg6A6Q5bOvavDZqLpfjA3DsTVCDKIy77TAGVScFdVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864898; c=relaxed/simple;
	bh=WEJbkA4NVp34ndRVamv+M7qqX0YbqfRrQ5HXGOWsGYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1WikId68wQz7RSRzcBymtRvU+vytovCYoVP99nF8Si6wdo1v8Ql4BRGpRSG3VZ372FkVJYYQzRN4EhHX4pW668+DyU+UCE2gF4ePEAYv2cwxtshE51YZDS0s66SnfYk6Pj/bx9WgMMSLPMDGO3ghmdZGTxVV51saF36pTeyiLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJnqNgnt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPFLnHvY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJnqNgnt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPFLnHvY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785864896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=875xjetkT5UuOybTTeZ61TUYqirr87m2MjPaJA71Q+c=;
	b=MJnqNgntxAymlBlHUQA9wfZmGdNKXtXk2NhuNlIo2gLV33H9c8UsAUTr5TkdsucDTu+VEA
	RwYYA0cNHBb3mtmJiIDZJ7HW5IogsLCRiduk+BIeubov9LLPg/YO/+TRtRnIwqP7QfV0+H
	aASjLd5ZFdY+HWfcOFUAY5E5fOfpAts=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-WNgJD0hRMz-e17GY_KlfAA-1; Tue, 04 Aug 2026 13:34:54 -0400
X-MC-Unique: WNgJD0hRMz-e17GY_KlfAA-1
X-Mimecast-MFC-AGG-ID: WNgJD0hRMz-e17GY_KlfAA_1785864893
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6d70223dso36192f8f.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785864893; x=1786469693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=875xjetkT5UuOybTTeZ61TUYqirr87m2MjPaJA71Q+c=;
        b=cPFLnHvYdhnmiy/bDa/R3FpE9v3vS6PxlLXIF72fNpzJYVVwuXEvMOWd4mVsTpEh5c
         FB2AV9E4WRgfcR8dNougCjLVTetad5fJr9P/UfpH0AbbxGbldXmFPMLTUaWug3Cms24C
         qZkA/xr99/j70Jmmyfcu43SFu+ngkaINVVi4k0O02SmdidPa1JqYI5fJ8zEliuZEHfRr
         ahtPZzcIQbiuP/nZakygq5vyTFpS9NojcWS33FFS3Gt7Rha6HXm27rrqisuqpl66cA6V
         f53g7BI1p9m0W+Vr7vmq0utx8nuhvHtCr4rvr6BuEcyrqxSMzO5uMN8Ja95JcBy/qfS0
         6B/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785864893; x=1786469693;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=875xjetkT5UuOybTTeZ61TUYqirr87m2MjPaJA71Q+c=;
        b=FmfqlXHgpLQBHRGI26bV3bcafo7fWd6kgscyn39k/6sIfq4Vln+7xaRn4eHQ57qfWd
         WLaouyC0RTGTrNP5Lj04fDAfQtjYKpZenaH/r1vItPP2FNbOpf3WcX9gME2GhR3G99Il
         CPQ7302tH7b+ALAWnEZ6hF+92L0psZSwjdrKbQdBzlOyK/17d/JhDST11uzefpYylgEJ
         IS2Rhcup56IsyYcJJirNZqz5DNsv43/i/1dGXASc49qHEG/7FVltQNA2WnNKtdxuo2Nq
         bE8rY/0VdYP4zFIioYkSlb8CNuYhnqFtRULi4yqWBbo3e1cziLtcHricck0GpVd5YUw0
         UIew==
X-Forwarded-Encrypted: i=1; AHgh+RrcknWNjwBqFQdf0zfXoLq/M69Fn5Wy2jH0/nTajv5j9tjGmFSIYRY7vDnP8QyK6kCoocwHCXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG+nNZtUm5nXIMIgKsSexKPwUEzLtxi4mIV7+1mxS9Y7vBuZLI
	8uGnCvT7+cm7LiBrPrMFLZ6tK65T7cgxn7jXv0KdAGWbpZyloLgb9PxuvR5Y+sQvaZDxTNKzDBL
	7nqrLwrzMy5+YCAzGTDsfhWHmh51WrCnAUcR+bh0Z8SPCfxWqFjhOl5YFpA==
X-Gm-Gg: AR+sD10rm/XPRGsvHOdWMc4gWHQ06YjTOvUkvQ+KAKjT/S2Vl7tn3tmb6q575gPt/k9
	i0oR00/3QphQIXSq25fbbv8pSbqbyRIILSLOJLMR4EbgihVdEgI8Q4oSPqKy+t1EpaHul4r+tU3
	qju+QGOjjNrZ7pErEu5J0ZSTihnXGElVTQshzg8NOcMN/q9lAcNhNMlo5LWt6OLJ3XeEhtn5M4j
	SzhUNe5nDMx3TFJYy6ucOnPmTZO2SkTIPD07Z8kxzfuQyswpaIjEAVIUE5CtaEPja9OOMjNSRJf
	PczTKJjmSYFQCSaGVXTj6MpMzkOG0Y03MmV0dKo6fVyC3JNtOYNOLnwkc0FnohOqapeekHZADjz
	tHseXZan5YDmjiCHi9bPDp4En3CDrwqt4MU0vhKnbuLvq9u39zAiJ8y+MeKw5PDUG2EDfTzafKT
	s=
X-Received: by 2002:a05:6000:2403:b0:47f:4650:e45c with SMTP id ffacd0b85a97d-47fec50e0ffmr1440968f8f.12.1785864893230;
        Tue, 04 Aug 2026 10:34:53 -0700 (PDT)
X-Received: by 2002:a05:6000:2403:b0:47f:4650:e45c with SMTP id ffacd0b85a97d-47fec50e0ffmr1440894f8f.12.1785864892762;
        Tue, 04 Aug 2026 10:34:52 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232333sm1776679f8f.18.2026.08.04.10.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 10:34:52 -0700 (PDT)
Message-ID: <922e3cc9-8621-4b4a-af0c-4b8b7c660027@redhat.com>
Date: Tue, 4 Aug 2026 19:34:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 3/3] geneve: Support per-netns netdev
 unregistration.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, i.maximets@ovn.org
References: <20260731164612.2148830-1-kuniyu@google.com>
 <20260731164612.2148830-4-kuniyu@google.com>
 <bfa765c2-a3e7-42b7-90c5-9757d8392687@redhat.com>
 <CAAVpQUDmZEaQNDSySLayqexgTrUbhBaL7XPCt9XNQzh+NGQ=UQ@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAAVpQUDmZEaQNDSySLayqexgTrUbhBaL7XPCt9XNQzh+NGQ=UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/4/26 5:24 PM, Kuniyuki Iwashima wrote:
> On Tue, Aug 4, 2026 at 6:47 AM Paolo Abeni <pabeni@redhat.com> wrote:
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

Yes, sorry I should have included the link:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731164612.2148830-1-kuniyu%40google.com

sometimes PW reports a timeout, but the report is still available via
the sashiko nipa UI. You can search for the patch title in:

https://netdev-ai.bots.linux.dev/sashiko/

alike the gemini instance.

/P

