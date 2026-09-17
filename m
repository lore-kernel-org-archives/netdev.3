Received: from mta0.migadu.com (out-104.mta0.migadu.com [91.218.175.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F081137BE6B
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 03:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789615531; cv=none; b=fgunQurlZNIXLQEFh0Y8JYbmmFJ+ZmuWgTLhTe6xN0tMuZ0M+8KbdG1uQ90EMBm43sJ26IfkAqgyKHqsKcQoauFtlLzjPYG4CG4N5vq3qsuVwjV8y1NRQA/1kzUPuwQgh6kykdkswmyn0kQswPudPYKO95t1jdjd/bvlcDCu/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789615531; c=relaxed/simple;
	bh=ri0ay7XYAc/xk9X50gAx6F4h4D9ONn3WRDSnDJItBdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkLEUIbqk0nkGWN0Dhavyq96E55LHAmcMJBZpwNFMsbJse4GN4qKr/Kq8AvGAq0/z5zD0ZpuXBMwcQ8UhftqgfPTJ+Ri2Q6zH4tLX7USDkSfJJqARSsVyTZiFqdKxuWtAnBGdpX9OgZ5bEmO+/yJc7kj1xoFHHAVd3eObkIrSuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PNMQJB67; arc=none smtp.client-ip=91.218.175.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PNMQJB67"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ri0ay7XYAc/xk9X50gAx6F4h4D9ONn3WRDSnDJItBdI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789615527; v=1; x=1790220327;
 b=PNMQJB67WZJifLTvhzETk7cE79paYlJNV8EjYyiZV+4Wlkp6blmKmjt/zKRK7i1ziXmE745p
 zUk677tNxKMOl59qgZAqs3KXzXeUJo76fblH2XWv47ZC2VZjrEgZ5ZamCA0pC+TMSuQxGry8rmg
 Kzgne3W/+EYyHnwTQ6K2DrXk=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 112836c3a7c083cd;
	Thu, 17 Sep 2026 03:25:27 +0000
X-Mizu-Trace-ID: 112836c3a7c083cd
X-Migadu-Flow: FLOW_OUT
Message-ID: <179a4875-7000-4a89-8ac0-7818593a961f@linux.dev>
Date: Thu, 17 Sep 2026 11:25:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] ip6_gre: Call ip6erspan_tunnel_unlink_md() in
 ip6erspan_changelink().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Simon Horman <horms@kernel.org>, William Tu <u9012063@gmail.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
References: <20260916230927.378957-1-kuniyu@google.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260916230927.378957-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/9/17 07:09, Kuniyuki Iwashima 写道:
> The cited commit accidentally added ip6gre_tunnel_unlink_md()
> in ip6erspan_changelink().
> 
> Let's correct it to ip6erspan_tunnel_unlink_md().
> 
> Fixes: b80d0b93b991 ("net: ip6_gre: fix tunnel metadata device sharing.")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks!
