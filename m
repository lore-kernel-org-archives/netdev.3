Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B928F23395F
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371990; cv=none; b=HWvgPpXGmxXKxfl/Ax71RmgQNPmgkLEngO1T4zWfNc/dLmpo89qtBpcqsCIBuAqrS9WyI3STElQaaxVDLur4ntOgJIc0B2oxsAOw0dlW4by3drIu2ZRUkTzc1WcYZJa/GLKwkD9ErDwMPsjEge5fnJ+wJyBAkly17gcFsQ/QHDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371990; c=relaxed/simple;
	bh=8c003hN7G0f21x5kR9OP9tcqEm1RKjMBRlZSQMJomQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Esf8kEvEWGKjQIF4alwYvjau7gccnWniSMVXlWBaAiYG8ELOmQyPPHaOhBtLJWkryzSfHYmlFNAX79boAQFEMBZkjHD/sLKULPD3kd278x6Z7bxoTyEQLEwPxuLSWZsm11aQ5AlAF4mtgyV0TAUkqUA6sU/mG+6Z8/lAABW9Dts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vjq4fVxL; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vjq4fVxL"
Message-ID: <0ef1f7da-c5b3-4c91-a656-4a3efecbbaf2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779371986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRj9005vgDhPgnpQ/dtcz4E8gCE9nIZniCZA9rHTQdo=;
	b=vjq4fVxLBX9uUH+YcTLL1N+CHTPaqjMSnKp/rL9NRqX/mQVhEFJ2C9a1JTEPJzSLopXjEg
	Nr3la8sU0pGHHKbySe7NXTEHgILNen/9iqQRRxstciS6IzvlAYcXxzyd5kEasnTaevqzRk
	HE7qpw6lGWHoOsToUUhGyVHF1RYC9lI=
Date: Thu, 21 May 2026 21:59:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ipv4: free net->ipv4.sysctl_local_reserved_ports
 after unregister_net_sysctl_table()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 eric.dumazet@gmail.com, Ji'an Zhou <eilaimemedsnaimel@gmail.com>,
 Cong Wang <xiyou.wangcong@gmail.com>
References: <20260521122147.3584624-1-edumazet@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260521122147.3584624-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/21/26 8:21 PM, Eric Dumazet wrote:
> ipv4_sysctl_exit_net() is currently freeing net->ipv4.sysctl_local_reserved_ports
> too soon.
>
> Only after unregister_net_sysctl_table() we can be sure no threads can possibly
> use the sysctls, including /proc/sys/net/ipv4/ip_local_reserved_ports.
>
> Fixes: 122ff243f5f1 ("ipv4: make ip_local_reserved_ports per netns")
> Reported-by: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>   net/ipv4/sysctl_net_ipv4.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index d8bdb1bdbff17ab52fe969b93ce13673e88c05a4..c0e85cc171aec099fd5d4897b1a623dd27eaee08 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -1705,10 +1705,10 @@ static __net_exit void ipv4_sysctl_exit_net(struct net *net)
>   {
>   	const struct ctl_table *table;
>   
> -	kfree(net->ipv4.sysctl_local_reserved_ports);
>   	table = net->ipv4.ipv4_hdr->ctl_table_arg;
>   	unregister_net_sysctl_table(net->ipv4.ipv4_hdr);
>   	kfree(table);
> +	kfree(net->ipv4.sysctl_local_reserved_ports);
>   }
>   
>   static __net_initdata struct pernet_operations ipv4_sysctl_ops = {


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


If there are still processes in the namespace, the netns refcnt cannot 
become 0,

so I think it should be: first open 
/proc/sys/net/ipv4/ip_local_reserved_ports, then pass

the fd to another process outside the netns? Maybe SCM_RIGHTS is used?


