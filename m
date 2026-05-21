Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA17F356A38
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360830; cv=none; b=A7MfwxnEwN1C8DbXWo+a488L9gqR21Rk5vwBrLSxzq/+mZ9/InlIY9eVrVnida3xEeTX1kBYX5I3LNiIRyqQBa3bbj9W57a/GalAL/NgyNjnmfHsYkjUgJrQMLEd66CziAk0ZfArQcbUdjASjh5eaGwWsConVn9YrX8FKOiOd3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360830; c=relaxed/simple;
	bh=b1D1sbVpVj9tsY8/y681O8mY0yENSBozDZCoQLbvao0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yy85O5lqkPb6N15x8HnHHtyt0VpvOrxfaz/FrG6gXAAA9KlZ1mGxCGAZh3HV5yeJw7QB3Drr0MLrkimVSJrJY38YsuiU3N16H/KOlhG6VI1x3Sd1GH2RHHKyt5iThGSIfCWYJHJweAFcsH+AJcBFVrL5q5hnoyN3g3NjAgtF2ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AttkTPCQ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AttkTPCQ"
Message-ID: <a6e9081a-b2d9-4a51-a7eb-aaf27a50fe1f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779360815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOXD72Rti67i5G3maLPI/XbykJHTdPayh8Ols8Zr+nk=;
	b=AttkTPCQGJ4ae8pQsNTPV3NloWTk+ith+CUSrYKcWQ+MTJiyqWF+uGHhCov5OWjl7wzZe6
	6axChq6U2JsSc+O9MtKr4VnitDfWeAbyVMldJfrsiux3a8ul4kHLm5qblry36DXDG70YGd
	M6nb8F08Szk63eH7Q+4iX3Vm+wZxaOE=
Date: Thu, 21 May 2026 18:53:27 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] ipv4: igmp: annotate data-races around im->users
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260521093612.207475-1-sigefriedhyy@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260521093612.207475-1-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/21/26 5:36 PM, Yuyang Huang wrote:
> /proc/net/igmp walks IPv4 multicast memberships under RCU and
> prints im->users without holding RTNL, while multicast join and leave
> paths update the field while holding RTNL. Annotate this intentional
> lockless snapshot with READ_ONCE() and the matching writers with
> WRITE_ONCE().
>
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
> ---
>   net/ipv4/igmp.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index 27d120183779..f2aca659b29c 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -1541,7 +1541,7 @@ static void ____ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
>   	}
>   
>   	if  (im) {
> -		im->users++;
> +		WRITE_ONCE(im->users, im->users + 1);
>   		ip_mc_add_src(in_dev, &addr, mode, 0, NULL, 0);
>   		goto out;
>   	}
> @@ -1550,7 +1550,7 @@ static void ____ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
>   	if (!im)
>   		goto out;
>   
> -	im->users = 1;
> +	WRITE_ONCE(im->users, 1);
>   	im->interface = in_dev;
>   	in_dev_hold(in_dev);
>   	im->multiaddr = addr;
> @@ -1784,7 +1784,10 @@ void __ip_mc_dec_group(struct in_device *in_dev, __be32 addr, gfp_t gfp)
>   	     (i = rtnl_dereference(*ip)) != NULL;
>   	     ip = &i->next_rcu) {
>   		if (i->multiaddr == addr) {
> -			if (--i->users == 0) {
> +			int new_users = i->users - 1;
> +
> +			WRITE_ONCE(i->users, new_users);
> +			if (new_users == 0) {

Using a local variable here feels slightly awkward, but it does save one 
extra load compared

to re-reading i->users after the WRITE_ONCE(), so it's acceptable.


One suggestion: please add a Fixes: tag, like other data-race fixes 
annotated with READ_ONCE()/WRITE_ONCE().
