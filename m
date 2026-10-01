Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7E4390CB2;
	Thu,  1 Oct 2026 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867008; cv=none; b=nBZjyNlMN8vPI2IAp090bzTA9FIqGisQd7UXsMV8z99o6kVt3yplUjWTGk2NZvbtdNzEzkF5epcRcBuj8h4I+ASGDT7gFAdIA+mLPoM8Pf6WqlU7aItMVwLpeJsS6FJdeMipp0fDGVMXc/pKMZsjCTurGuM4WIg08qJAlwLeq7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867008; c=relaxed/simple;
	bh=1EqSiLx5dSjBa66Tqq/wYdWWTzDQ/alZTbfqUq/odxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCRSu70axFpGvtqG3WaHCBeqzlgLAvY37zLzGZ11xtgy9aIZ9GoV3nbn24VaL7SBtEOVd9lDCWIzx4stCWIsWJaVDSZXlkaQVYBgjMu+PtXujUa7kewk5qPaDQlgZvNmXaAMf81RlDjA1alceT8G9ASEPUP+9qlhX5dAzw+agdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=O4h9FMpL; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="O4h9FMpL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G8nZSzlpByEXSixSPWBp/SZ71oCw5T7BXwZXVJgREQc=; b=O4h9FMpLc1mXe7O18OKZCozpPC
	sRtkNSv9SU+gopY3PWqva1UBf0t6VtFZTENwOZ/l7Z6rERwCqLvp3PDQ89+hycxk/BeI/BmZUwcAw
	EfF1AkzRiYjLkHVp+GQ117URRtbu5EsV1GglxiuzS1hOZdHafvnlT1CGDF6Zbcr580mevYeFJQaR6
	8n9jlEfeVClFOawNSN3BHVTtFY5zkeq8AMXQhVHu4ZbPHcn/THq0z7j10RD4Qym2gwtrKrtvi/3UZ
	Vc1OQ9pYhDWcsIrRGJ39w37WYnXEQquKXeAkGb5DShztQB1JNDNkC9ZicnZqbaJfBpjYZsgSuGyzl
	6q0nsvMA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xCIJO-000AhN-1c;
	Thu, 01 Oct 2026 15:03:06 +0000
Date: Thu, 1 Oct 2026 08:03:01 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matt Mackall <mpm@selenic.com>, 
	Bruno =?utf-8?Q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] netconsole: finish enabling the target
 before releasing RTNL
Message-ID: <ar51wR0vG6QL2egY@gmail.com>
References: <20260928-netcons-fixes-v1-0-bb5ffe5e698a@gmail.com>
 <20260928-netcons-fixes-v1-1-bb5ffe5e698a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-netcons-fixes-v1-1-bb5ffe5e698a@gmail.com>
X-Debian-User: leitao

On Mon, Sep 28, 2026 at 07:00:03PM +0100, Gustavo Luiz Duarte wrote:
> netcons_netpoll_setup() publishes nt->np.dev inside __netpoll_setup(),
> then releases the RTNL and waits for an RCU grace period before
> returning. Only after that does its caller store STATE_ENABLED:
> 
> A NETDEV_UNREGISTER event landing in that window tears the target down
> and we end up storing STATE_ENABLED with a NULL np->dev, leading to a
> null-ptr-deref in netconsole_write():
> 
>   BUG: KASAN: null-ptr-deref in netconsole_write+0xb9/0x7f0
>   Read of size 8 at addr 00000000000000a8 by task pr/netcon_ext0/135
>    netconsole_write+0xb9/0x7f0
>    nbcon_emit_next_record+0x501/0x550
>    nbcon_emit_one+0x10e/0x170
>    nbcon_kthread_func+0x2ff/0x3b0
>    kthread+0x199/0x1e0

Oh gosh. Thanks for hte fix.

> Store STATE_ENABLED before dropping the RTNL lock to avoid racing with
> netconsole_netdev_event().
> 
> Fixes: 2382b15bcc39 ("netconsole: take care of NETDEV_UNREGISTER event")

This should go to `net` instead of netdev.
>
> @@ -552,13 +552,16 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
>  	err = __netpoll_setup(np, ndev);
>  	if (err)
>  		goto put;
> -	rtnl_unlock();
>  
>  	/* Make sure all NAPI polls which started before dev->npinfo
>  	 * was visible have exited before we start calling NAPI poll.
>  	 * NAPI skips locking if dev->npinfo is NULL.
> +	 * Hold RTNL until enable is finished so we don't race with
> +	 * netconsole_netdev_event()
>  	 */
> -	synchronize_rcu();
> +	synchronize_net();
> +	nt->state = STATE_ENABLED;
> +	rtnl_unlock();

Why do you need to synchornize-rcu with the RTNL held? Why not enabling
nt->state, releasing the lock and than synchronizing RCU?

--breno
