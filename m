Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015188;
	b=0yYQCNdRmHBZ6lP4Cv8qaZtQCxTfxv9GaspwZWT6d6qAx2osKvro5X4BAxEOtWNPkq07
	 fyANmKbtenj/aJwepBHfkdWSIsOVoRDp4Ppj8TOyC5JDj8nE7nmABxcsQJFQb9mCYlKPe
	 8jDAnbp6rvp9w1PaymLBrGj+W3jE6JSbZgXx1P1YYqsT8Y9XdNq2aYZiKE7Zz4lFwM6OM
	 YDjhYNdub5VOIEU4uvfx/Y7fi/BMNCvs3A9vlDtUjkzxVeZj9lB12QP7AZBKjtQ66zqt6
	 fZhSNnBnjgAJ4gGjO0JMCnHtZpXQInG6ls6t5LwRDNzNEhOm4NVv/3DnkVw4m9yywQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015188;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=eteIyHggK7fdejTj9DTqqw4UqXgLh7y8GQE8hS71QVo=;
	b=QtH/csm2aTZrWyzpQfl2y8Hx/yH8BTWui+JYAmOMM6o7ORF9S9YDHZ1Mn2eKGFDfIErg
	 tgI8BbyojiMGs3U6PdjsKs2jANpXTzLxV+2LWNyCwSqrHXkrh+Lu7PVdulFKxGSBoZmOY
	 4OUvbBMaQPW2YgAY5nGtsRicBs0k98IwS0huQydH2UBaL52YE+Oo1ZO8mwZrzCpI4oXq4
	 GIkhjyyDMG/XAaeUh0utp4i+j83Zx62myZAty134kkQuFipCSXQ9r1bh+A8gIQ/uvwXA0
	 hO5tSincxVNy05ax1uHlNb4aOBc9pRfBIkkZ4KrFAfDilUSsWG4UKouVI6z5yiez7rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=VMOi4Av7;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B929606A31F;
	Mon, 26 Oct 2026 11:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B929606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=VMOi4Av7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eteIyHggK7fdejTj9DTqqw4UqXgLh7y8GQE8hS71QVo=; b=VMOi4Av7zlpWWJ263lhlaJLcQ6
	kAcTiECM907TE5mh2/TQVDQM9deyF4miUtXbM6A/10XVfoEwWgdO/vYFw66EDsD5JOoBjgRz8IsWy
	d9ZkjWjD/8lmjZDWSOCjJNdK5aLLP5Vkw85sI79e34Vl1z2VawnL/93nBv7EZyd64sL3DVMcgiP8Q
	D9RpAg6jdXEwTKPtu8h4zCqTKb12UT/2XOlGNQ/TfWefxbtqz3WLZzS6qJhYMdLy0i7LunGS2hGqP
	goRO+sN1l0b3bHVATXcDrjeXUd9t1tkUb7KViF46nmMvpMj8RDeEfqhMWeYg8FEZgyWFf0wcEDhG4
	EjoZgBWQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xLJ9i-000eaW-28;
	Mon, 26 Oct 2026 11:46:22 +0000
Date: Mon, 26 Oct 2026 04:46:18 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 1/3] netconsole: finish enabling the target before
 releasing RTNL
Message-ID: <at89fwMimRz6FU8K@gmail.com>
References: <20261021-netcons-fixes-v4-0-3857120c6340@gmail.com>
 <20261021-netcons-fixes-v4-1-3857120c6340@gmail.com>
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
In-Reply-To: <20261021-netcons-fixes-v4-1-3857120c6340@gmail.com>
X-Debian-User: leitao

On Wed, Oct 21, 2026 at 03:19:05PM +0100, Gustavo Luiz Duarte wrote:
> netcons_netpoll_setup() publishes nt->np.dev inside __netpoll_setup(),
> then releases the RTNL and waits for an RCU grace period before
> returning. Only after that does its caller store STATE_ENABLED.
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
> 
> Store STATE_ENABLED before dropping the RTNL lock to avoid racing with
> netconsole_netdev_event().
> 
> Fixes: 2382b15bcc39 ("netconsole: take care of NETDEV_UNREGISTER event")
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
