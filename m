Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ADC3FA5CD
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774623364; cv=none; b=laxthenAJh3jrJkIM5lCfAURVoNH7lNZ5laEwLlFrM1JMZtgzI+ft0KMimc4iUXS5sYnba/Doqn+GEYLs5A7FB5fzbBHQ4cLPlnTyWPndDEGtc4R2Y7ILrg1NISLWvhGOIZ0qe/hyGb+rRwwXDkUxPVU93rzaKMqCCRnKuIpdTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774623364; c=relaxed/simple;
	bh=jZCcR5j/UkZ+vWnh1spokvEW2kGZ26yt5slMyeiCYbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBFyVFWmEcOrCsbredQAYunLP11399WIx74JlIOQh7a810bLhaOjCWAY3x1JuPEJjxcWO7zQqIvAI922ruClN2zwGbelFkJwNag2oykP9koIvUGqSvA4BjJHI+ZXsTFsagkeFWnG6BX8FWCdO14IV9vpZeSXOCNOjudwT3lD0Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XthLW/It; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XthLW/It"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BF3C19423;
	Fri, 27 Mar 2026 14:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774623364;
	bh=jZCcR5j/UkZ+vWnh1spokvEW2kGZ26yt5slMyeiCYbM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XthLW/It58z0tOqNfHqcHuXs4U1EWfG+omU5jMnBgxLrCjggWH4v3kySpacfr2epK
	 nWwj5/eBGg2LdT+CGlu6OchbUZV30AU4Zo1t13mzXEVIJ7NP1oRTq6cVUINXMNOXPt
	 SVLitzbLV8Am33aaLeH59byPD4O/+JJ2lGBxjqBr4NR4FJex5tEs6/O//fCG7DX8s0
	 0X1ZhA24SQlAoV0ELsw/RvPfEP4Ou/0K9sZcyJJaUBvjYl1iuta6i5k/BRwyWD4XQB
	 qyJJlNGWprLamIKZPcB27Py5bM9vkefNCyfcAlpNCti06Y8Jbj1CLCrvJ9pwLr0ssJ
	 qcqLHvNfdTCXw==
Message-ID: <23856f10-6f3c-471c-b262-af117de1dbaa@kernel.org>
Date: Fri, 27 Mar 2026 08:56:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] vrf: Remove unnecessary RCU protection
 around dst entries
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, petrm@nvidia.com,
 lirongqing@baidu.com
References: <20260326203233.1128554-1-idosch@nvidia.com>
 <20260326203233.1128554-4-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260326203233.1128554-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/26 2:32 PM, Ido Schimmel wrote:
> During initialization of a VRF device, the VRF driver creates two dst
> entries (for IPv4 and IPv6). They are attached to locally generated
> packets that are transmitted out of the VRF ports (via the
> l3mdev_l3_out() hook). Their purpose is to redirect packets towards the
> VRF device instead of having the packets egress directly out of the VRF
> ports. This is useful, for example, when a queuing discipline is
> configured on the VRF device.
> 
> In order to avoid a NULL pointer dereference, commit b0e95ccdd775 ("net:
> vrf: protect changes to private data with rcu") made the pointers to the
> dst entries RCU protected. As far as I can tell, this was needed because
> back then the dst entries were released (and the pointers reset to NULL)
> before removing the VRF ports.
> 
> Later on, commit f630c38ef0d7 ("vrf: fix bug_on triggered by rx when
> destroying a vrf") moved the removal of the VRF ports to the VRF
> device's dellink() callback. As such, the tear down sequence of a VRF
> device looks as follows:
> 
> 1. VRF ports are removed.
> 2. VRF device is unregistered.
>     a. Device is closed.
>     b. An RCU grace period passes.
>     c. ndo_uninit() is called.
>         i. dst entries are released.
> 
> Given the above, the Tx path will always see the same fully initialized
> dst entries and will never race with the ndo_uninit() callback.
> 
> Therefore, there is no need to make the pointers to the dst entries RCU
> protected. Remove it as well as the unnecessary NULL checks in the Tx
> path.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vrf.c | 56 ++++++++++-------------------------------------
>  1 file changed, 12 insertions(+), 44 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


