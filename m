Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DA034252B
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459322; cv=none; b=P89lMUjbcRDb6mmvT7iGCwtV9IpcktrEwQcNe8bNbgclLPMXcKIJW2wXZWZtQy7hBAxER+IuAtORKnAi76z8PLNk0jgpGx+Bi49eV9uQoqIEmCs5pXm9oo6uXH2v3pLBgHYEJTD6wMXKwUoIggDYCetfjIEsp7+ozYe3+Ihg9N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459322; c=relaxed/simple;
	bh=yi8WoyJisKf8GoMRJOU2seKT6aaHiG1jpyka13Ph6WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i74+rcdoI9M/OpGxzjtJx3s56eQU4lXQdtsQEQ2E/YNlapNEsx5IiWCYLM03JqZIl7S4nRrtQU/YiaBT96Im/o8knDk+vF/7JAfWVldKI5AEBiDsUIgoEbpQw9iM3lO5/uXSuUV8ZI0Q5MLBXchtCB9U9LLx+dAwAptYejHBvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AI1AMQ7K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AI1AMQ7K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEF31F000E9;
	Tue, 11 Aug 2026 14:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786459321;
	bh=eGxLH4Jml/vCMs2iDJw5O6n5M3DTTcgOkcvfuvs0iTg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AI1AMQ7KQ6a/AwmYE4NCOHsjoGPe+QUByXL4GUNTe34VKoViXwl10vi35oo18l2c5
	 bIgfPH+AH10lVvupu/GYw2+3kT3CGIfZiQr5XGBcnLPI+WCkFYNllTkDxXqZ0DmvG3
	 RjvGOnzoThcAwMJQTFrD9YUv1dA1LhHW9M02Y2vMbzGg4xCXJm85OhVf3cPE6Q3i/7
	 mm+gg3ktW5wkaWk3rE5UvPCBRHfBrukZbPCGGBHiKafrZqLnjID8DfTZzZPSXo3+FZ
	 x1H1D6AV/1MgitBM3nLJt+020fj2LTPsgXKrPeiwrBIBBEoEe8eSLjF7oFcMao+xoK
	 9FOsuxEyVI1HA==
Message-ID: <27ec0a14-67a7-49e8-9e4f-944f46c6d94d@kernel.org>
Date: Tue, 11 Aug 2026 08:42:00 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 05/15] neighbour: Remove __rcu from
 neigh_tables[].
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260811022448.116235-1-kuniyu@google.com>
 <20260811022448.116235-6-kuniyu@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260811022448.116235-6-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/26 8:23 PM, Kuniyuki Iwashima wrote:
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 6fda0052027b..caa52bf64a2d 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -3162,7 +3157,7 @@ int neigh_xmit(int index, struct net_device *dev,
>  		struct neighbour *neigh;
>  
>  		rcu_read_lock();

rcu_read_lock can be moved down after this check.


> -		tbl = rcu_dereference(neigh_tables[index]);
> +		tbl = neigh_tables[index];
>  		if (!tbl) {
>  			rcu_read_unlock();
>  			goto out_kfree_skb;

Reviewed-by: David Ahern <dsahern@kernel.org>

