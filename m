Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722533F8EB9;
	Tue, 28 Jul 2026 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277143; cv=none; b=m9812oCRv4z/8OAnjFyPC08tk0XYHjk88LSGnBuGJaI+YMEZErlEwa9aE1MCTc/Wv9RBAlTeW5LC/uvvbN5ipzurw4zK5u81IpERz4N/C13YWeYN54SzsH+epOvKZ2JXa4ZOC9LpKSqDWlePp2Ns38l2w+WbDvEA9efVbDq0wKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277143; c=relaxed/simple;
	bh=jezS/bMgBiH4s52NCdvsL0IUtKP/n1SqOxQ1sNg6Hk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aN5NTLHam7po+MNesZL3sRXV1UC5pw8/0rX+z7Y8Rs0t6dlJ+Wt9XN2pEjSczQXp2144l6JnFnQvsfMdY7qzaH0lFAoCCUF4PmscfjAFLZmfFhguHEbogo4zCMXHxLNUKSe+VCq35t9+tBr6LlpmV2rrAHOYpz3tz/4g5STFsHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNdnOkP/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNdnOkP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1C41F000E9;
	Tue, 28 Jul 2026 22:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277142;
	bh=IR9kFmYGhq6HqxqtgGmsnN/2dcYVrh2jhYCVW+jLxaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZNdnOkP/OtAZakm5fuQHbOb2A9ljrwLspyhBATc83lqzdccaXX/Z3E6JmCi9Af5U/
	 iIQ0IQjfynk70wqbnlqNVARLh8htnJCY+6veQobWUVmcUJI5/N9WCF4+dxYrx9jmVl
	 +MtDS+/nXtHppgiPag62XZFVPG5yzzTzq8Y4yVrP58KPN2o8x5L/iu7Km/zR0yBmFf
	 gZGBq/F5YEB641E0yiEtnJ48xclrEundE5+Iz4XVswVkyy6MGOpwY0eNRqkdDVJZS8
	 KPSDbnVo42s+/rumF11ZwyIl2dKp2kxFr8elXiRIb7J9yD+Lx9I9ioGmrrdBmimG7r
	 4vcIbfUs2aYjg==
Date: Tue, 28 Jul 2026 15:19:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zxyan Zhu <zxyan0222@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: dwxgmac2: configure INTM for
 per-channel interrupt routing
Message-ID: <20260728151901.637b8a11@kernel.org>
In-Reply-To: <20260728034303.1432292-1-zxyan0222@gmail.com>
References: <20260727181617.19604f9c@kernel.org>
	<20260728034303.1432292-1-zxyan0222@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 11:43:03 +0800 Zxyan Zhu wrote:
> The commit message does a poor job of explaining the actual impact,
> so let me clarify.
> 
> I've verified on hardware with XGMAC and multi-MSI enabled. The
> results are definitive:
> 
>   INTM=00 (default):
>     - 5.4 million interrupts on the common IRQ line in 3 seconds
>     - ~1.8 million IRQ_NONE returns per second
> 
>   INTM=01:
>     - 0 interrupts on the common IRQ line
>     - Per-channel IRQs work normally
>     - 10G line rate works correctly
> 
> The behavior is that with INTM=00, sbd_intr_o is also asserted for
> each DMA completion event. The common IRQ handler
> stmmac_mac_interrupt() only processes MAC-layer events (LPI, PMT,
> timestamps) and returns IRQ_NONE for DMA completion events, causing
> the interrupt storm. With INTM=01, sbd_intr_o is not asserted for
> DMA transfer completion events, which is the correct mode for
> per-channel interrupt routing.

Got it, could you respin with this clarification in the commit message?

> Regarding net vs net-next: XGMAC multi-MSI has never worked correctly
> since it was introduced, so this is not a regression. The same
> INTM=1 configuration for GMAC4 was merged via net-next (6ccf12ae111e
> "net: stmmac: use interrupt mode INTM=1 for multi-MSI"). I'm leaning
> toward net-next for consistency, but since this makes multi-MSI
> completely non-functional without it, I'd appreciate your opinion on
> whether net is more appropriate.

Makes sense, we can stick to net-next. Please also add a note to the
commit msg that "XGMAC multi-MSI has never worked correctly."
It will help backporting. Thanks!
