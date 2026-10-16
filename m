Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A22D29C8;
	Fri, 16 Oct 2026 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110612; cv=none; b=GZF6Nb5ET1DW1R03xu9T3pTl+2ayXyjdxbwiY3jcxCCsUZzBkIghKndtgQsinLdu69ZHEU13ZazQo6QgKjo90WXv1bN7cohwCuU637SkbdTF6hWnDjZ3BG1z8nFozytwoMiyC+CzdkyI6r2TQs7lUl/+q5VrN5O2Yvvx2FmPLVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110612; c=relaxed/simple;
	bh=bARByNApv2qSYRvMZApvNsjaTS6YnxdAS15KW7TVQTI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X7XbPD+3eJbrqOVM9qfHZiiN7vjW8uiiZqPQtvGs/YPtBI4+h/AKRCXE087K7l39H2X1OSo+qdQkDUFEMw2umZfshhro9o1u8uCkQJkUOq1kLLOiDLYJAkUy1aQM8PQzRJu8oM7hRL0K3Irii4IFCOZXBqq2/Xe5N0CIedJ5KHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EId3jhZ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EId3jhZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FD21F000C4;
	Fri, 16 Oct 2026 00:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110610;
	bh=7Lq+Sse+et5IRJkDZ9c0elUVkXMe4tv8qt9iuxv7iS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EId3jhZ7GNOop/wPZHOc2akj9yHKAw+4xeETaq1/VSgOk29Jl6WYgI2GHklMK4iQF
	 8p40yd3q/Ptjub0Eg8u+qg5QkrwYulqVieZCN5w67MgZKx6VUdDU5nbaDvZc9R2fZh
	 KrT3+hUCCg9ObKyeAtQlgtFn7rBwfpbdsfJu7Y0+aO35WuWph+kvmZF0p6r7qUFdEz
	 D5T5JTrNHwxyCIdpWGPrtRibHbR7tcbkLcZS5AWFA8prGU/F6fU0eBh/TbwOCodtG0
	 9XSSnl8U1Zy7Lj/XiRG8NBJClkw53bBDSk/4dx/I70N6MX57eheh82zwOa5MiUC7AP
	 6KzBaHn1BxpRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43413808209;
	Fri, 16 Oct 2026 00:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net: erspan: set lltx to avoid sch_direct_xmit
 deadlock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211060926.4173731.112372523388867313.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 00:30:09 +0000
References: <20261008093824.119453-1-yun.zhou@windriver.com>
In-Reply-To: <20261008093824.119453-1-yun.zhou@windriver.com>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 8 Oct 2026 17:38:24 +0800 you wrote:
> The ERSPAN xmit path re-enters the network stack, causing nested
> acquisition of _xmit_lock on the underlay device while already holding
> the ERSPAN device's _xmit_lock, creating an ABBA deadlock. This happens
> for both IPv4 ERSPAN (erspan_xmit() -> ip_tunnel_xmit()) and IPv6 ERSPAN
> (ip6erspan_tunnel_xmit() -> ip6_tnl_xmit()):
> 
>   sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
>   ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]
> 
> [...]

Here is the summary with links:
  - [net,v5] net: erspan: set lltx to avoid sch_direct_xmit deadlock
    https://git.kernel.org/netdev/net/c/2d36ec73836e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


