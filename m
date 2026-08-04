Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05B0468C32
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851261; cv=none; b=VwdCI4c8wm/zYBp/8BoRkl0VspsOK70Mg3paK+QExaOzpyiwVe1gbiEqdWXRbvEmLP8RGYwaWRWlmkQGbc9HX1K9QKH84GzoiVOVSFIMfV1V8nYBdOr9gb6oN/Lh9oQgiGSL/nA8UWAEL8kZaodpeJ+yFr6iCKQlvrwmzb03Wvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851261; c=relaxed/simple;
	bh=+UjXpoSkPCJ3H3YYtH/8v2t5djdHLVlM326DbTnbVCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8ys9R+Q1DfUwjGf5JrNmAN/YIDAgoGfCHtWWqS5AJKnf/qY4IjA4AiVJmVyklBi8Xgf7ZIYXqfaiaE2pLZsUC+dgRdsLaziUs3XhzmFGIJso2ea6DKyV72zHQJEXF/v6Zb9lL4ff9XsDlst2ajyepD1n0JIK74aK50zupGATCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6Z633Nu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXGWGESM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6Z633Nu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXGWGESM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785851258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zaL/1JHVuONmYFhHxcP8bgazkeWVUzyYecLMTZNi7E=;
	b=B6Z633NuRxslOmrx6RX5QqU8DO5/tx0gD2gjSs/ZbVNn+3qz6zYhWeTYbAVf1PMwtU+wFD
	QSW2ptHx0qAaGu39jZRaMhtbzRp52PdMCLGjQTZqvnaK/HipAz0AGYbU5pj8mPt3LLHTQm
	GNc/LRklzTUql9Jh24V1UbMI8oz7P28=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-duxpG-l0NzqUIFIMwmboGA-1; Tue, 04 Aug 2026 09:47:25 -0400
X-MC-Unique: duxpG-l0NzqUIFIMwmboGA-1
X-Mimecast-MFC-AGG-ID: duxpG-l0NzqUIFIMwmboGA_1785851244
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4955ce558d8so33811445e9.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 06:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785851244; x=1786456044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5zaL/1JHVuONmYFhHxcP8bgazkeWVUzyYecLMTZNi7E=;
        b=KXGWGESMEk7gsto/ryCQyAFsYLf+X9OLIcLF6Rfj3PEUf7g6C9aX0zGV79/vLo9XvG
         V/uP1VIa70vF3KTAS29qY1IGikxZrhnTJTHerK3EQf+p3ZQDSw8HsZERBU8KQfIv3Fe9
         NEBvE5WQdW3mHkDDCQzSoqLNORV1XLk92rlfsxdLGupYAOM9SJ2hHJcC735GVnVyq0wO
         nsWRnUbHrS3FsBABbTNZUuOvsUwycNe0ro/5f9gkNPJQc1BPSFht7Woou1bKCIPEwhr6
         V4KS0W65X9G2MsznXT8s9tgiMMbQsmcSc9CTqJi2pKDkDNy4Rbm4GOZLERUVuPFI9vJ4
         TwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785851244; x=1786456044;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5zaL/1JHVuONmYFhHxcP8bgazkeWVUzyYecLMTZNi7E=;
        b=geB+LqrkCqmMekTK87rNkHK+VJOiWyqzQJDe3cZTaNyTli1kPykeGR5r86LhCsjTJX
         szMhxpd3kSwst09JtZcRM2S/7HrTIyNLq+n84Uw7cbAn+R16UhB1Sek9FByWHNz1MzDw
         uMvTER0N5T51ElQ+MlMCJc0hW1D5CH38EAk1TtSMzmAsTFq5t7SYJ3rJ8Um5XMatpKQJ
         EEp6ZnxDrcIvzclDk7B2+FqGmdzBNGVIk+QV8IL6JWctdk+Z8iZYhlrrekIxDyeVqAL3
         Pu4W9gackH+SjXqR3trY+dbUrmrJONa+GfE9mlK3onJzYj3kpv9yYzVzGi/+49md5ElX
         aPYg==
X-Forwarded-Encrypted: i=1; AHgh+RqvK0Rcg6poUCNASQG9bX0u+zB8gsATH3yACM/4tXTN9BgbT0WZVa3gBjf9eBAUOJshNbQILRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMoOeQ9ASFcjVQbzR5BnpJ5OlijAv2gk/iY3XlYeRDVMGVGUHi
	jBI/npPMcbmcUDXgGDooe5B9LXaV0wBuhtvrWXRzYWxd35+aRDLZGCDAqCWqegL1Fw4CyoL4g2Z
	Z74R8+8asW8KfAP6L8o1+pFrWWsUeZG6qY8vlrcrn/AxaawGMqN+aOmO9VA==
X-Gm-Gg: AR+sD13TEBY2C5uvZ9ZsCZ6phwg/+Y1/yfvp+ZNg4xtLYy4dijt+zJbLaxm/eYUuJlh
	ZZGaj4hSQSN9iYlLscADHk6NWofqvjTFz7qYj+4YwCxkfcWpeN9KL376wgVl3D8X3Ezo+pyfMfR
	ysubKYVNP0Ai4WbOiJ9kEAhTOUdkogwUCUeuyNncIDqiw94/ZexL9aBopiGMLJnHahGIbv/DDT4
	Hj8lHQurHVhsRrJ+/JWVS/ZFMSxNZ9HtuH+U6bF+OMD0SDC5qe3V23LWrbO7tggSOjydBINcHYO
	74+h4yi2IJMEcZbSw4dU2ItSS3faneCJRdeE81y6PjRUMHQJe7aicS7vpEog42TIEoLcM7t+3wU
	pagwXCUuPeU1aQaB7GfYb1JgZrSW/iaMoqaAo4xhQtWJOgapIMpwIOTVFbkdM7oWSoMUxF1cWdq
	I=
X-Received: by 2002:a05:600c:354a:b0:495:4e89:3f30 with SMTP id 5b1f17b1804b1-4980c673874mr328895745e9.15.1785851244076;
        Tue, 04 Aug 2026 06:47:24 -0700 (PDT)
X-Received: by 2002:a05:600c:354a:b0:495:4e89:3f30 with SMTP id 5b1f17b1804b1-4980c673874mr328894735e9.15.1785851243565;
        Tue, 04 Aug 2026 06:47:23 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807bad893sm276636685e9.3.2026.08.04.06.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 06:47:23 -0700 (PDT)
Message-ID: <bfa765c2-a3e7-42b7-90c5-9757d8392687@redhat.com>
Date: Tue, 4 Aug 2026 15:47:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 3/3] geneve: Support per-netns netdev
 unregistration.
To: Kuniyuki Iwashima <kuniyu@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260731164612.2148830-1-kuniyu@google.com>
 <20260731164612.2148830-4-kuniyu@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260731164612.2148830-4-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/26 6:45 PM, Kuniyuki Iwashima wrote:
> geneve_exit_rtnl_net() iterates geneve devices whose sockets
> are in the dying netns and queues them for destruction.
> 
> So the devices may reside in different netns.
> 
> Let's use unregister_netdevice_queue_net() to support per-netns
> device unregistration.
> 
> list_del() is changed to list_del_init() to avoid queueing the
> same device twice.
> 
> Even after geneve_exit_rtnl_net() queues a cross-netns geneve
> device, geneve_dellink() can be called concurrently for it.
> In such a case, __rtnl_net_unlock() will perform the unregistration.
> 
> Note that geneve uses register_pernet_subsys() instead of _device(),
> so default_device_exit_batch() guarantees that the async per-netns
> works are flushed before ->exit().
> 
> Tested:
> 
> 1. Create geneve device across two netns.
> 
>   # ip netns add ns1
>   # ip netns add ns2
>   # ip -n ns1 link add geneve0 link-netns ns2 type geneve external
> 
> 2. Run bpftrace to check that geneve_uninit() is called between
>    ->exit_rtnl() and ->exit().
> 
>   # bpftrace -e '#include <linux/netdevice.h>
>   kprobe:geneve_uninit {
>       $dev = (struct net_device *)arg0;
>       printf("PID: %d | DEV: %s%s\n", pid, $dev->name, kstack());
>   }
>   kprobe:geneve_exit_rtnl_net,
>   kprobe:geneve_exit_net {
>       printf("PID: %d%s\n", pid, kstack());
>   }'
> 
> 3. Remove the netns where the geneve socket resides
> 
>   # ip netns del ns2
> 
> Now, we can see geneve0 is unregistered by per-netns work
> instead of cleanup_net() and it finishes before ->exit() to
> avoid WARN_ON_ONCE(!list_empty(&gn->sock_list)) there.
> 
>   PID: 571
>           geneve_exit_rtnl_net+5
>           ops_undo_list+702
>           cleanup_net+1122
>           process_scheduled_works+2538
>   ...
>   PID: 1047 | DEV: geneve0
>           geneve_uninit+5
>           unregister_netdevice_many_notify+7129
>           unregister_netdevice_many_net+1050
>           rtnl_net_work_func+136
>           process_scheduled_works+2538
>   ...
>   PID: 571
>           geneve_exit_net+5
>           ops_undo_list+1064
>           cleanup_net+1122
>           process_scheduled_works+2538
>   ...
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  drivers/net/geneve.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index f456a85dca77..a6a8978e3b81 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -2502,12 +2502,13 @@ static int geneve_changelink(struct net_device *dev, struct nlattr *tb[],
>  	return err;
>  }
>  
> -static void __geneve_dellink(struct net_device *dev, struct list_head *head)
> +static void __geneve_dellink(struct net *net, struct net_device *dev,
> +			     struct list_head *head)
>  {
>  	struct geneve_dev *geneve = netdev_priv(dev);
>  
> -	list_del(&geneve->next);
> -	unregister_netdevice_queue(dev, head);
> +	list_del_init(&geneve->next);
> +	unregister_netdevice_queue_net(net, dev, head);
>  }
>  
>  static void geneve_dellink(struct net_device *dev, struct list_head *head)
> @@ -2518,7 +2519,8 @@ static void geneve_dellink(struct net_device *dev, struct list_head *head)
>  	gn = net_generic(geneve->net, geneve_net_id);
>  
>  	mutex_lock(&gn->lock);
> -	__geneve_dellink(dev, head);
> +	if (!list_empty(&geneve->next))
> +		__geneve_dellink(dev_net(dev), dev, head);

Sashiko noted that the lockdep chain between dev->lock, utn->loc and
gn->lock is not trivial, possibly a documentation follow-up would be useful

>  	mutex_unlock(&gn->lock);
>  }
>  
> @@ -2754,7 +2756,7 @@ static void __net_exit geneve_exit_rtnl_net(struct net *net,
>  	mutex_lock(&gn->lock);
>  
>  	list_for_each_entry_safe(geneve, next, &gn->geneve_list, next)
> -		__geneve_dellink(geneve->dev, dev_to_kill);
> +		__geneve_dellink(net, geneve->dev, dev_to_kill);

Here sashiko foresees some problem with CONFIG_DEBUG_NET_SMALL_RTNL
before full conversion to per netns lock even of ovs. Just more
follow-up, I guess.

/P

>  
>  	mutex_unlock(&gn->lock);
>  }

