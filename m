Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9E43ACA5F
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461563; cv=none; b=oMbnT65bGXDkhjLrIuMUfLOkBAXwVI4BVwyPOx9v1h4nWnDB+ZvYZH2pKe00O3YJbuCf3vYrvmU413WK2r25qaVJuvbBeLSyuzbasfj+t3CbanKAEwRVfefwnggxNRjki7xxqin/KnvQot4viXIeP+UmMo17e/jBQXqlEg02tNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461563; c=relaxed/simple;
	bh=C2DuI7vd75gj+cirIw/GdxuAObWVd6H6HUj93eCsNCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WU60oh6ADR1+/VDpiazAntq4pyv3kVs9OBI/dwUERV2awdJg4aOgyCAd6vm11K990AXLSemyy1SHjh8vJUczly63k9EmsbGHGz7H11RD658OHl7bhbZ/BRUNI2IMyjM6KI/zRnPu980FkSS2gwRu61X+uYEqclr8+hZNcWq5+bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOeCMcXn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOeCMcXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FFE1F000E9;
	Tue, 11 Aug 2026 15:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786461562;
	bh=XBelmvkDnC3ZQy48IKuTOvjOzB3moCI+qQmXbruVN+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eOeCMcXn9wPZd6AmhvfmMu7XOeEfd9ON0ibt7jIMghJthzlghpWBWWWY5/4ojgt9o
	 +p+kkl1e0DkaVYiUnKMppV1us4PMTjDyDje23yzkZezK6o60mICvFbcx/T484rxf2t
	 j1xplMNtKj5Kqk87ussh6aT7xjOT/Yp9oaXkmAUsV6YOrHgxkrnlf6M8Ve0apD3srU
	 tP3abqM5O9zIYhtoVHfmTb6Qtbl9r26AMHUiBsuTgk9I/HXCx/vWE9yQXqdJjtaygG
	 FSfonz0VqeeFdfFF+EQL66ly4gWM6gIPws7xHpJdgHK6v8P/jICiMh4dgHFknC2ZoY
	 CO7t6Lxps+rCw==
Message-ID: <c90385b9-28f6-49ea-b4cf-9eb90604af10@kernel.org>
Date: Tue, 11 Aug 2026 09:19:21 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 06/15] neighbour: Store arp_tbl and nd_tbl in
 net->neigh_tables[].
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260811022448.116235-1-kuniyu@google.com>
 <20260811022448.116235-7-kuniyu@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260811022448.116235-7-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/26 8:23 PM, Kuniyuki Iwashima wrote:
> diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> index d409f606aec0..bad17d5aeafc 100644
> --- a/net/ipv4/arp.c
> +++ b/net/ipv4/arp.c
> @@ -1495,15 +1495,34 @@ static const struct seq_operations arp_seq_ops = {
>  
>  static int __net_init arp_net_init(struct net *net)
>  {
> +	int err;
> +
> +	err = neigh_table_register(net, &arp_tbl, NEIGH_ARP_TABLE);
> +	if (err)
> +		goto err;
> +
> +#ifdef CONFIG_PROC_FS
>  	if (!proc_create_net("arp", 0444, net->proc_net, &arp_seq_ops,
> -			sizeof(struct neigh_seq_state)))

proc_create_net already handles CONFIG_PROC_FS. It is not clear to me
why you need to add the check here and below.

> -		return -ENOMEM;
> +			     sizeof(struct neigh_seq_state))) {
> +		err = -ENOMEM;
> +		goto err_proc_create;
> +	}
> +#endif
> +
>  	return 0;
> +
> +#ifdef CONFIG_PROC_FS
> +err_proc_create:
> +	neigh_table_unregister(net, NEIGH_ARP_TABLE);
> +#endif
> +err:
> +	return err;
>  }
>  
>  static void __net_exit arp_net_exit(struct net *net)
>  {
>  	remove_proc_entry("arp", net->proc_net);
> +	neigh_table_unregister(net, NEIGH_ARP_TABLE);
>  }
>  
>  static struct pernet_operations arp_net_ops = {

