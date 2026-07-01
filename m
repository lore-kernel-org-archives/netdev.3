Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C9227B35F
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939312; cv=none; b=F6JTCpvdquCN+MC2JVc+cs7B5DJyGtJnSHyVEoVL8WiW/NIafieSnk4AJQgY3iDpJdPeLe9jSXkz05tKl+LS6lhSL/cw2D/E4SF+mxDwMeWvIc22bDKT/PwggNZ6hQi5vwtmGjjOkynPKjaEgIPmYFx9cYGLLRcxB5H9GarRRkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939312; c=relaxed/simple;
	bh=LB6UO3uezZpO6it+CrKAe8HgcrZ0JiGiz98PKAPxh4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbKugRbfAddxEUQuBU/ZqQzn5qqRe3FKcC3sEcCfnvUk3jfjUG0qjazbCvQj5aIVCWqebq49MDdEDoF0+eDGt5DJJV+KDHDh+GiZTzB8qKYLsKz1xJtZpZvkR3sttTmTWYtizSl83RHg5UeR41ENOz6V8Mvxp+OZCL67bSqXES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BYxWeL6n; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BYxWeL6n"
Message-ID: <045799ad-5e9f-4053-97b9-be78e8dfa8f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782939309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKuLmZ2IJLArE5GjcIWFvuYskuJbGafICyJK3gU7OZQ=;
	b=BYxWeL6n9DykFUvm+8RXBJvEC7f40rgCWc0a/kXSseB0ngCNOw9Zu9ZreZyoFmKn+H00mA
	Ni9NczkR0+Y6EJnQtzsDRJycH3L2qMtaPObviRr0tQ/NF/dMgVPAmRH7X5sguztIRedCgB
	UaO5+Vqbuh5PapeT3NOV2OCYoTqNZKo=
Date: Wed, 1 Jul 2026 21:55:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/3] net: ipv6: report multicast group user count
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20260630110207.37841-1-sigefriedhyy@gmail.com>
 <20260630110207.37841-3-sigefriedhyy@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260630110207.37841-3-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/06/2026 12:02, Yuyang Huang wrote:
> The previous patch added IFA_MC_USERS and emits it for IPv4 multicast
> groups. Add the same snapshot attribute to IPv6 RTM_GETMULTICAST
> replies and entry-lifecycle notifications, carrying
> ifmcaddr6::mca_users.
> 
> This makes the multicast rtnetlink ABI symmetric across IPv4 and IPv6
> and gives userspace the same user count that /proc/net/igmp6 exposes.
> 
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
