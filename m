Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5155B36B05A;
	Tue, 10 Feb 2026 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770733211; cv=none; b=U1D9mn1wdATOuClrcCwmK6zgeznQ/3Fb3q3h4bq/VXOmhjh+UxpY9cCd3/1WRVGeJuRacIsPN+mB8enEdIJZJkL5QJreLCBb2S9OGBqMTKjk38sgpVXWQWbzFZjrH97RIB7n4r6BLziB3/Wel9KYL0je2CBSaKfPTgvrLdo8C4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770733211; c=relaxed/simple;
	bh=cd30L6yZMxmEM0CwCTn8lpRuIL2J6mXD+DngGpr9Irs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bfWRFvUYppExcuVhHoSfN2/CCSj2t8w9lPP485k2RmJZ5AXzte/cWGpFq0gJJDk5VCiaKz6/7wNxBTzGngLvWZ64k86/sGOQiktDu1YmMqIjmiGcBpWKYU4veXUYAzy2cmM8REq0swa5juPc0puGREhG0BoaJ1Pnqjs4zNraDPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hg6h2sf+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hg6h2sf+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C56C19424;
	Tue, 10 Feb 2026 14:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770733211;
	bh=cd30L6yZMxmEM0CwCTn8lpRuIL2J6mXD+DngGpr9Irs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hg6h2sf+XoE91fla2q50Tb1xAvCeITUwi8TbNcwxyGgfTJg2DQLNy6pJ/W2UWBF0y
	 FwOTXwNzwGN16QIa1ZgLGaHNuNri0PVoBxffKnugjx5jemmNYQqpG+ZY3Zk8lc8m4z
	 df5wx3KbTBICeoeDMSBKOIh8D0+GKCCRlwJMjk8ornM32Qv5jOAnYimjpzITUcqWPC
	 Q8aq4dlvtmqNQ0fyl2rHvHaSg3oanYO+ZBW9aU38PvACax4KsAqySk/hprMRrL/hbD
	 h+IgpSGdyhINkRONsqgf8bJzkUGtUyY+3XHFaRb4pTfGMDx+2IvAed6U4qcLWVz0QU
	 KhMgbk0pl1/fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 850BA39D267E;
	Tue, 10 Feb 2026 14:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] xfrm: fix ip_rt_bug race in icmp_route_lookup
 reverse
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177073320633.3529986.460622729645384413.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 14:20:06 +0000
References: <20260206050220.59642-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260206050220.59642-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, jiayuan.chen@shopee.com,
 syzbot+e738404dcd14b620923c@syzkaller.appspotmail.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Feb 2026 13:02:19 +0800 you wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> icmp_route_lookup() performs multiple route lookups to find a suitable
> route for sending ICMP error messages, with special handling for XFRM
> (IPsec) policies.
> 
> The lookup sequence is:
> 1. First, lookup output route for ICMP reply (dst = original src)
> 2. Pass through xfrm_lookup() for policy check
> 3. If blocked (-EPERM) or dst is not local, enter "reverse path"
> 4. In reverse path, call xfrm_decode_session_reverse() to get fl4_dec
>    which reverses the original packet's flow (saddr<->daddr swapped)
> 5. If fl4_dec.saddr is local (we are the original destination), use
>    __ip_route_output_key() for output route lookup
> 6. If fl4_dec.saddr is NOT local (we are a forwarding node), use
>    ip_route_input() to simulate the reverse packet's input path
> 7. Finally, pass rt2 through xfrm_lookup() with XFRM_LOOKUP_ICMP flag
> 
> [...]

Here is the summary with links:
  - [net,v4] xfrm: fix ip_rt_bug race in icmp_route_lookup reverse path
    https://git.kernel.org/netdev/net/c/81b84de32bb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


