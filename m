Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0524582FF;
	Thu,  3 Sep 2026 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426461; cv=none; b=hE4o972dznpYEWrsHCbtzF22zHjo6TLh5qNmRVm8K6b6jjRUwNXwz8y4C93w1la9zmxd+fYggVZ7nuySsI99ZzKLV859LuC4BhpAgHV4yTyIztlKQXmEkHXcRiXyoqtl8aGuCz45Xe/NFxqKbe60PP0WB6xnGJkYhmoGvhOMdsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426461; c=relaxed/simple;
	bh=3dwYzcgVcyLhozbhcCXFd5se9NiCuhek7VbT4ZzS0Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNY8mpa80vk3eJGet347+AvLrTOM9r2sfZOmRDQE6IBWkqBPwuNRItb20zghPxejhWylZ7L6qNqH+g+a0LMcGelGmkPdEkasoM1LGRM1dRpwX/31lUUZB9gzpJGlVKSt+JjIrCxoOdz/NYa+xDpJoqWOB0gH1gBzTP7/dEOiO6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkBXs1Pn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkBXs1Pn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6451F00A3A;
	Thu,  3 Sep 2026 09:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788426459;
	bh=q0ymZwGYNAORdsdliGKs5sb+mau7cLV/ZRWBqmg1GfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TkBXs1Pn+2Ckqm2Ac7ukqHSgKi/WKEvl+2vAQ6BellmRabbu9pAjUf9/+IkoQsYF8
	 bmsvwu4YvnqPzjzXrO5jXBCE5SeApoe+bfnjnLJQ3XnDjnXcQCEjcni0ImdNwP10MD
	 JnuC0CjRhbi8FeODJLBF64h8rB65hmuX5Zm+ogGkIP2FofQF+DO3/hYMW1BwMSJKli
	 F0cpJA+gQpCegscyjoMRJgsMV9/WTxkDNgbNkEO9J3Lmzj7369Zap8fn6y8Qw4cDbQ
	 gqAdZAinfF56FQBLb7ngCK27vh0nSXjdpc67LsG2mjUCpYn59m35hvJ2vnBsHSrvkR
	 HOpQCZv2N+f7Q==
Date: Thu, 3 Sep 2026 10:07:35 +0100
From: Simon Horman <horms@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Take write lock when publishing the initial
 RxGK key
Message-ID: <20260903090735.GJ396647@horms.kernel.org>
References: <20260824150220.216067-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824150220.216067-1-nicoyip.dev@gmail.com>

On Mon, Aug 24, 2026 at 11:02:20PM +0800, Chengfeng Ye wrote:
> rxgk_rekey() updates the transport-key ring under security_use_lock,
> and rxgk_get_key() takes a reference under the corresponding read
> lock.  The initial publication in rxgk_init_connection_security()
> writes conn->rxgk.enctype and conn->rxgk.keys[] without the write
> lock.
> 
> On a client connection, a second sendmsg can observe
> RXRPC_CONN_CLIENT through a lockless load of conn->state, skip
> rxrpc_init_client_conn_security(), and call rxgk_get_key() without
> ever acquiring security_lock.  Because the initializer never took
> the write lock, the reader's read lock provides neither exclusion
> nor a matching acquire-release pair.
> 
> Concurrent RxGK key consumers were observed in a two-sender
> workload.  KCSAN reported:
> 
>   BUG: KCSAN: data-race in rxgk_get_key / rxgk_secure_packet
> 
>   write to 0xffff8aef4023c318 of 8 bytes by task 1968 on cpu 0:
>    rxgk_secure_packet+0x46c/0x820
>    rxrpc_send_data+0x562/0x1a20
>    rxrpc_do_sendmsg+0x976/0xa80
>    rxrpc_sendmsg+0x20f/0x2a0
> 
>   read to 0xffff8aef4023c318 of 8 bytes by task 1969 on cpu 1:
>    rxgk_get_key+0x209/0x5e0
>    rxgk_alloc_txbuf+0xa4/0x2a0
>    rxrpc_send_data+0x8e2/0x1a20
>    rxrpc_do_sendmsg+0x976/0xa80
>    rxrpc_sendmsg+0x20f/0x2a0
> 
>   value changed: 0x7fffffffffffffff -> 0x7fffffffffffffee
> 
> That report is on the key context's byte counter rather than the
> initial publication, but it shows that lookup and secured transmit
> already overlap on the same connection.
> 
> Take security_use_lock for writing while publishing the initial
> enctype and transport key, matching the locking used when rekeying.
> 

I think a Fixes tag is needed here, citing the patch where
this problem first manifested.

You can simply post it in response to this email.
But if you do re-post for some other reason note that
there should not be a blank line between the Fixes and
Signed-off-by tags (or between any other tags).

> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

...
