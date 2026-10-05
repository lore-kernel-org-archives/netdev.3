Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC17F2E11C7
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791238219; cv=none; b=SHUanFD05I2l7Cp9CHxUmnyDDZjDGAxBaVYA70AfvmmOQcyUPmyvlNkESR3iVfjS2McTAd9jyo+/T0Wf4GS0s8RXXVXQERN9dacC9rV2m8UvspXEFE9WHDGsNFXJlWCnW0PFtrUprUljEAXeIcxbGF5MsoWYGULe+rEbb2KEi08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791238219; c=relaxed/simple;
	bh=MCyx9y9c0Nz8NohVj6giwKoM5SvaKgsZxHE4NzTQ6ME=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y2vHBC+zpdLNGnl4JBSjqkpgSjmkXvZVmREQKKcGlhiLgO3uZ2otAluP1hTFrqhMjr79UYWFDUvA94zo6P+H0NwWXarH5BB0eGgQz+rkejRD55ahlbx0XsdrvOsxsD7xb2tP9GsaobN9QTLF7hydLk+ZEgQd03ZoY/xEqjSeAIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXUvw9m7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXUvw9m7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A391F000FF;
	Mon,  5 Oct 2026 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791238218;
	bh=oL1OP8LxT/XuZM9yJoLe1r30bUiIJZt9BDknlG7wlMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kXUvw9m7v4OtqsjnddW/HyIl6wamCH5ah9UBc7TPpCDTaNYi8dZwZ81WYwNgILi6n
	 J3CKtOkjVkLwUWOd9ChAVuTeWtiNVFJTqCBYuQfnAm+FESCSq8suF22LwMjcqKOYNk
	 9UN65/2FCfUjmlBz3hKGByU2PFfgr3ZzMkMZqi1y87jH7iRzITsMsNFUTtZc/ErCip
	 iNjbmLtfLVy7GA+XThQlFg/OG0DUhnmcrUmm1GH3mzyqnV8xQqhOMy8JeBzfQcQ5hA
	 v2M5v4Up2oEDKwjUZegjRhmipWcWmMgR+mL0atZlpAS0oqbfNIEfbhAZWZJ2Wdz0+A
	 6pfKRlcSFLeYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A1F93926672;
	Mon,  5 Oct 2026 22:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] ipv4: fix IP ID reuse for GSO packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179123821677.1914306.18110720981322113793.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 22:10:16 +0000
References: <20260930144018.1174068-1-edumazet@kernel.org>
In-Reply-To: <20260930144018.1174068-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 edumazet@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 14:40:16 +0000 you wrote:
> This series fixes two cases where IPv4 GSO packets can reuse the IP IDs
> of previous packets:
> 
> - Patch 1 fixes ip_select_ident_segs() for non-TCP sockets, which uses
>   the first IP ID of the next packet since commit f866fbc842de
>   ("ipv4: fix data-races around inet->inet_id"). SCTP GSO is affected.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] ipv4: fix IP ID reuse in ip_select_ident_segs()
    https://git.kernel.org/netdev/net-next/c/fe7ca0c13f7d
  - [v2,net,2/2] ipv4: reserve one IP ID per segment for UDP GSO packets
    https://git.kernel.org/netdev/net-next/c/852c08d6a991

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


