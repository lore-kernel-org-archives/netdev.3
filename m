Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43C633E346
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 03:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785987538; cv=none; b=QkLvwpAuNq4ntrwSdrS8M3q0+L+XXF6Z7hrNkfsHOteqPvwqc6o+oZUPSirnWegM6CA2ZTcbu06TuJVpMq3a8ZQxs5wLyOBflE+go1QuiOnkAvBucG+3tLee3rSDnFfJqQ2LfaiOLPTf/AEUc+ICPACnBhM0kizlsjO1rYHFo1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785987538; c=relaxed/simple;
	bh=nyAzQ+CSWj6zVcz2xJSFS4whuamk1Nj+lArdN/w6a78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruPnU6JShhBX+sJCoFoZENhyhFny8HLbwQ6ZVpFlGW8O6JmvpqEvJMHSvSi2WQWNrtzUOyFm2HpdGCScjT/nenmrASCtNgnK4d18JrJerOWJ1xbt5ibXNZBICYedz29IM4raVUfbkrvMemgwigQDhL9axVLmeGNxYpl7+mCdeBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0D7Jvia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0D7Jvia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A131F000E9;
	Thu,  6 Aug 2026 03:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785987537;
	bh=SzWKfzujfjvsyHkIPP4PQsCIxbc+awFgLmMkWnhkJUE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=G0D7JviayNo64B4hGAHncG7YbR5OyQZUJ+BU9T9XRnsGLmQ7vjtrWBKIIdOjf5Gez
	 ciDourzMOZZRQEuaqOz8sX+u4Jo6mIb7x8Gx7JRP0/whj16BbXkhe+nKvLcAu1RTHQ
	 W4rlgslXtTNS9OFuDHwHqWkgk6zR7oTq8BsuDG3/bpl+HJKhbZZpZWOTMCXvnuogR0
	 G+TmGm7e1hfIIonnfsqTKZjm8cVAFmLGTJmPEgg77UprKUXQsCAjSqcmidWbywkmwK
	 CE68yry/quB9aio6lyS1DRd8tdY+C4ofSY9ZAq56Fs2p00l8urKpUF5eGPTpKZ0k2e
	 QODhJVGhczdSA==
Message-ID: <ffb2b3f4-08a2-45da-b345-9ae7e1626526@kernel.org>
Date: Wed, 5 Aug 2026 21:38:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 00/11] neighbour: Namespacify arp_tbl and
 nd_tbl.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260806011152.1170012-1-kuniyu@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260806011152.1170012-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 7:11 PM, Kuniyuki Iwashima wrote:
> The neighbour subsystem is almost ready to drop RTNL.
> 
> However, the control paths are serialised by the global
> per-table lock.
> 
> This series converts arp_tbl and nd_tbl to per-netns table.

Another attempt at this. The last one as I recall:

https://lore.kernel.org/netdev/20180717120651.15748-1-dsahern@kernel.org/

I think it is past time to make this happen.

