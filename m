Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3E4657F2;
	Sat, 28 Feb 2026 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292930; cv=none; b=HiCl4fJc6jMf9SmO4AOno0nDUPAGYbHiHh9+5D1oEIYRAwBTobwQNe5Xvu9hch2anaYSCU6iRYpVGXfa4sIhFBxh70L0j3gbN9w6LQo8ImZxV9XV3gYyQ0vhnGOTn3zREYVEVfsxSmJauujZEF1D4vdg6XzezlXJAkja/oLJ/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292930; c=relaxed/simple;
	bh=zvZy3Px9p33IPr0eJ5otl8cAQIfEfXRvV36zcwUHZW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCleDZgkb0J0OU8//ImhhxYhDds/QnU4gBgzgWQ6TkbpOMgpuJO1pzMhmI8DGdOcr5mYQ4RCh/qdqfndeHMnUC9E/c2eOsXQU7ZcRn3gCGG6Ixvw457OdxrrPpdz1N2ebZYx2b9Qv/v02nmCuT7MV4P55diX85TQEKAOREac8Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrD5ERAU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrD5ERAU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598D2C116D0;
	Sat, 28 Feb 2026 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772292929;
	bh=zvZy3Px9p33IPr0eJ5otl8cAQIfEfXRvV36zcwUHZW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OrD5ERAUR1a+decV2HSptDosENl4ePOeTtQKpVFU7MAvYbAbduymDstW4o2B5tI7J
	 0kJmgPXiVdmrWb9PnsJ9hKEiko4yEaTykl97USWWaXOCuHH+ZkCZL9YlAcBfvZBpMA
	 HVf1MSyoOIwgoyGL9S6AQCLcp2nW6zvZTOCc8P3xzVEJq31asYUaL6dE08oRmZKXBX
	 UHL6Xwp141fSUaud6uiyo15mz5+lqCx2UtvmlzTfdugRsTVzRQ1hoj7FRz/Oqe9/vU
	 eC/do57DOAy42AHHE9zD1POlsy+vC43PTkU4LKq2vb82pMHrnDo8iKjp213Ob/GLwh
	 x1PNzxtMM3/eA==
Date: Sat, 28 Feb 2026 07:35:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Bauer <mail@david-bauer.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] l2tp: account for IP version in SKB
 headroom
Message-ID: <20260228073528.6e445fb8@kernel.org>
In-Reply-To: <20260227220740.11928-1-mail@david-bauer.net>
References: <20260227220740.11928-1-mail@david-bauer.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 23:07:37 +0100 David Bauer wrote:
> Account for the IP version of the tunnel when accounting skb headroom on
> xmit. This avoids having to potentially copy the skb a second time down
> the stack due to allocating not enough space for IPv6 headers in case
> the tunnel uses IPv6.

This appears to crash immediately in the net/l2tp.sh selftest:

# selftests: net: l2tp.sh
# 0.27 [+0.27] ./l2tp.sh: line 138: 22310 Killed                     ip -netns $host_1 l2tp add session name l2tp4 tunnel_id 1041 session_id 1041 peer_session_id 1042
not ok 1 selftests: net: l2tp.sh # exit=137

[ 1585.224860] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[ 1585.224891] RIP: 0010:l2tp_eth_create+0xf2/0x300 [l2tp_eth]
[ 1585.225362]  <TASK>
[ 1585.225377]  l2tp_nl_cmd_session_create+0x204/0x470 [l2tp_netlink]
-- 
pw-bot: cr
