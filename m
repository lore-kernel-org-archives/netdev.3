Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299317;
	b=wTXe9Va6lbjqPjKa4s5VK867CmBi4KOBSoZXPhPhq+Fisqd7c5waVSoTcyN0pQwNdzFo
	 g6KMSEgKAqV/b18D2IgDyg13eFJDuJ9hc8nEQRp6asO213O6EYcy7WNn9+fER6PbIuR3T
	 OtBwO/JLzwiXuCHJhkNtd7YR1L5b7Aw2yTo3zA3m3IDJU0sMsNCtlrtP2Ia4NbXdvBhTg
	 JwOVT2ezx0JqsIJqiwL2PVwcb6DYz4VxMOyz14cRr3b9C7DDIgYGVzFdZkT3sU1OXIqLo
	 9VDHhFGg/g+xxtNB0FixgZFgxzB87LWorYtS2sm2Es41FDuxhV8t2FGscTZDUNQzwXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299317;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UXWSddbnxoIoGsiCn3Ri/uMZNROiH7zZ5ZghjrWmXBQ=;
	b=YBpu9ulHod1jr30hOv1Huq9j9J+/Z1JiTSSMLDegk/1vJNdeFA7erOrnKepTiIoFbuoh
	 Vr4wXI18g/EReiqeK15MlUzrF28keOUbbKIVyQ7mUyS6XcOZmvTXAohUw5rKN8wJBRleU
	 lcAsft52TBnUBtTCq8wvLMEzT4qI1SdQnpcr4JsLwHgcQodOXxOA0WHyfJKqMVpa6hlBD
	 Zc0DQF3jEkYwRUJ33Z2+AbtPGIh3DsWH45YBkX+ArxSOJRft1Wi5o+52Gqanj6MVTyDw8
	 PCV7HnRrDL9pxXcWrCbJSlega7h/PHasu5iwovky1M6QBTFCKa+G0ImcGcWW4WP1ZLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=v3i+y+BP;
	arc=none smtp.remote-ip=91.218.175.210
Received: from mta0.migadu.com (out-210.mta0.migadu.com [91.218.175.210])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3B9606A339
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F3B9606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=v3i+y+BP
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=m8rf5DYN0i2d+usWteyvNzrEUNWAD6DpiRcNC6PhNxw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794299314; v=1; x=1794904114;
 b=v3i+y+BPQo3lEubyTKtmTu0ePONXZEWZYyqC8Nz7Y7UN/ZRRmpRd9lTG4+Hg/hDQkVhO0vJF
 vKUgx+LUJUKNF4bHgNhmwgTtnyTma4JSZ39mOMoX4t+df0ABAl6pEsm4luDCju/6Oye3Izm3xNr
 BJHmSA1ibELc2sVztzPyouMs=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 31d984c00931474b;
	Tue, 10 Nov 2026 08:28:34 +0000
X-Mizu-Trace-ID: 31d984c00931474b
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 16:28:25 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] ipv6: return EMSGSIZE when first route in dump does
 not fit
Message-ID: <avLVqWNqjN88WVRN@fedora>
References: <20261109012115.11898-1-stephen@networkplumber.org>
 <20261109012115.11898-3-stephen@networkplumber.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109012115.11898-3-stephen@networkplumber.org>

On Sun, Nov 08, 2026 at 05:13:13PM -0800, Stephen Hemminger wrote:
> If a route does not fit in an empty dump skb, fib6_dump_node()
> suspends the walker and inet6_dump_fib() returns 1. rtnl_dumpit()
> then returns skb->len, which is 0, and the dump ends with NLMSG_DONE
> and status 0, silently dropping the route and those after it.
> 
> This became reachable when multipath routes started being dumped as a
> single message with an RTA_MULTIPATH attribute; a wide enough route no
> longer fits.
> 
> Return -EMSGSIZE in this case, as IPv4 does. This depends on the
> rtnl_dumpit() fix in the previous patch.
> 
> Fixes: beb1afac518d ("net: ipv6: Add support to dump multipath routes via RTA_MULTIPATH attribute")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  net/ipv6/ip6_fib.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index e1d49897d6ab..1025267992f0 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -755,6 +755,12 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
>  
>  unlock:
>  	rcu_read_unlock();
> +	/* The walker stopped before adding anything, so the next route
> +	 * is too large for this skb. Report that instead of letting an
> +	 * empty skb look like the end of the dump.
> +	 */
> +	if (err > 0 && !skb->len)
> +		err = -EMSGSIZE;
>  	if (err <= 0)
>  		fib6_dump_end(cb);
>  	return err;
> -- 
> 2.53.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
