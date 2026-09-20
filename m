Received: from mta1.migadu.com (out-247.mta1.migadu.com [95.215.58.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EA334D3B2
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890011; cv=none; b=CZU8MjNHOHeNDNQhiy0nPjbICdDsuLNLVz9SCH2YWuhq+KUeLC8yxZ2FfitvcCeocfppt+qG4YUqyj5xlWCONwW5WPpoiRYDfZdjxN7aDGeq9I9aYjtWAAmc9ES975W1CLPuSlXPdSIPwGMUKc0qXQbAJ2eKpZwNI0wM82bAWdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890011; c=relaxed/simple;
	bh=+mwo1lLralubcPriQordmkmkr0DO+tN/QSyWIJ38380=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=j8jMkMHMjUAA/bkCo/1NmT9Ktj/p5FAtH4orbV5GZW+W6IeRjnCXG5DeniJSu4WTKWrURNMIKF1xIpA48TomhB1Xj0Mu9IRO810nS2Hg3Y/7eUP9NMaoMKRMLh+MqtYMZ/f6V1oRNMIcV7zaVKSvPTWYbi0cBXqu6t2j+Zo4Cpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R0QXDTWf; arc=none smtp.client-ip=95.215.58.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R0QXDTWf"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+mwo1lLralubcPriQordmkmkr0DO+tN/QSyWIJ38380=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789890006; v=1; x=1790494806;
 b=R0QXDTWfMKZcVor3mTSfXKHMEBjTvLS5YdcbjWrh+ysNmoZu694HRYPKg2whNl4B1tb57YQx
 2ERByI8M6Ol2WW4aMFPNG/k05rvaApOBIKrnYJGGnu1dNWqCTT2uSs3ig2H9he6hvx3yous61uH
 mm82NUF804baTU9fYGG/jKS8=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 32a348c164f13f67;
	Sun, 20 Sep 2026 07:40:04 +0000
X-Mizu-Trace-ID: 32a348c164f13f67
X-Migadu-Flow: FLOW_OUT
Message-ID: <332d9841-e5b3-4273-85da-27816948e79d@linux.dev>
Date: Sun, 20 Sep 2026 15:39:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Subject: Re: [PATCH v1 net] ipv6: Fix dst leak for uncached routes.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Simon Horman <horms@kernel.org>, Wei Wang <weiwan@google.com>,
 Marc Harvey <marcharvey@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260918041439.2575935-1-kuniyu@google.com>
In-Reply-To: <20260918041439.2575935-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/9/18 12:14, Kuniyuki Iwashima 写道:
> ip6_route_output_flags(), ip6_rt_put_flags(), and ip6_dst_check()
> detect an uncached route by list_empty(&rt->dst.rt_uncached),
> which replaced the static DST_NOCACHE flag check in commit
> a4c2fd7f7891 ("net: remove DST_NOCACHE flag").
> 
> When a device is unregistered, rt6_uncached_list_flush_dev()
> unlinks uncached routes tied to the device from rt6_uncached_list.
> 
> Previously, they were moved to another list with list_move()
> (__list_del_entry() + list_add()), and since commit 98aa546af5e4
> ("inet: remove (struct uncached_list)->quarantine"), the routes
> are just unlinked with list_del_init().
> 
> If list_del_init() runs concurrently, list_empty() evaluates to
> true; ip6_route_output_flags() calls dst_hold_safe() incorrectly
> and ip6_rt_put_flags() skips ip6_rt_put(), leaking dst, and thus
> dev tied via rt->from as well.
> 
> The same race is partially fixed by commit 9a6f0c4d5796 ("dst:
> fix races in rt6_uncached_list_del() and rt_del_uncached_list()").
> 
> Let's check rt6->dst.rt_uncached_list instead.
> 
> Note that IPv4 does not have the same issue.
> 
> Fixes: 7d9e5f422150 ("ipv6: convert major tx path to use RT6_LOOKUP_F_DST_NOREF")
> Fixes: d64a1f574a29 ("ipv6: honor RT6_LOOKUP_F_DST_NOREF in rule lookup logic")
> Fixes: a4c2fd7f7891 ("net: remove DST_NOCACHE flag")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks,
Xuanqiang
