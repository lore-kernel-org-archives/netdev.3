Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9C5312825;
	Tue, 21 Jul 2026 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640175; cv=none; b=BIIU3rmUzcoEGBeJ6yql1RUIAgBLDoT354mJVaVyeJsMh0A43WK/g1Bk03M8HPnx7f/P1IoDP7k8essQva+wUm+edICcj8R4N42TP3haSri2Is8N4s2fspNzuiWc+PhU9pHDu+NEZbFcFmvQlYxLOYCTWZIh9G3cnGbSMVLAljA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640175; c=relaxed/simple;
	bh=5YOzWK+khTkGJQ3jDlGpfQh7feWylJ2ODmdgu/ugXzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNXj2x3C7zTPPqcoZd7tp1RKQhtxV+op9wtGRqEnPgK0nEr76ynsouOu+5CFws9X7zR9qkiaRLUFDT5DPvakFFiW5ldtEHacdfASuQQtgQXsgArDBozjPLN+HnOTVKjcD+G2hIGOUzJVfluF9QfQguMBOTmFfVeRaILGT2ld/FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIRR2YO8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIRR2YO8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A371F000E9;
	Tue, 21 Jul 2026 13:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784640173;
	bh=e04GOQXBNvml6utMGMyZDe57hLBIsWZEIxIS0FG7u50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cIRR2YO8LNjM8k10MPGMbwGpiTTEnSwGUf7VxKv0gpyMQyB9rW5O4InJArsW/MPjz
	 1tqe7Qm2WrRCOM8CVBNOWt8HmtYkZvItlBA7ktns+ZiNNZrgycHxERwdklCL8IyifG
	 dlji+J7czrkfC7Od//7cxvKiYr8732PMa5OOGpRdwrXpw3IuJTCKUMFBS1KJhCywCV
	 UpZSj5wdBBj7Kb1QLa6tXb0Hdxd/hH41C4/icucb+FWbiDRUrHstJd5Y2GbnSjjsAw
	 /pzEbnbTJ5zbBhYq5G/bV2qUY/m3qbGvYCZeN/dJiKe1WB0VScZn3eBLeoaUoRtj9R
	 bU43MX5g3n3Dg==
Date: Tue, 21 Jul 2026 14:22:48 +0100
From: Simon Horman <horms@kernel.org>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev,
	tung.quang.nguyen@est.tech, AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net v5] tipc: fix u16 MTU truncation in media and bearer
 MTU  validation
Message-ID: <20260721132248.GI19108@horms.kernel.org>
References: <20260714041541.307702-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714041541.307702-1-blbllhy@gmail.com>

On Tue, Jul 14, 2026 at 12:15:41AM -0400, Cen Zhang (Microsoft) wrote:
> Both TIPC_NL_MEDIA_SET and TIPC_NL_BEARER_SET accept user-supplied
> MTU values but only enforce a minimum bound, not a maximum. When a user
> sets the MTU to a value exceeding U16_MAX (65535), it passes validation
> but is silently truncated when assigned to u16 fields l->mtu and
> l->advertised_mtu in tipc_link_create(). Values like 65536 (0x10000)
> truncate to 0, causing a division by zero in tipc_link_set_queue_limits()
> which computes TIPC_MAX_PUBL / (l->mtu / ITEM_SIZE). Other overflowing
> values (e.g. 65537-131071) produce small incorrect MTU values, resulting
> in link malfunction behaviors.
> 
> Crash stack (triggered as unprivileged user via user namespace):
> 
>   tipc_link_set_queue_limits  net/tipc/link.c:2531
>   tipc_link_create            net/tipc/link.c:520
>   tipc_node_check_dest        net/tipc/node.c:1279
>   tipc_disc_rcv               net/tipc/discover.c:252
>   tipc_rcv                    net/tipc/node.c:2129
>   tipc_udp_recv               net/tipc/udp_media.c:392
> 
> Two independent paths lack the upper bound check:
> 1. tipc_udp_mtu_bad() -- called from __tipc_nl_media_set() (MEDIA_SET)
> 2. inline check in __tipc_nl_bearer_set() at bearer.c:1160 (BEARER_SET)
> 
> Fix both by rejecting MTU values above U16_MAX.
> 
> Fixes: 901271e0403a ("tipc: implement configuration of UDP media MTU")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Closes: https://lore.kernel.org/all/CAB8m9WgETt0AjmFwE=F-CKjGXsK6_WDv0=kbYRcC8-noo+amnA@mail.gmail.com
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
> v5: Drop .min from range struct (min check already in handler)
> v4: Add .min check value
> v3: Use nla_policy check to limit MTU max value as suggested by Vadim
> v2: Solved format issue
> Link: https://lore.kernel.org/all/CAB8m9WgETt0AjmFwE=F-CKjGXsK6_WDv0=kbYRcC8-noo+amnA@mail.gmail.com

Thanks,

I believe that v5 covers all the bases wrt review of earlier versions.

Reviewed-by: Simon Horman <horms@kernel.org>

