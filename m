Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE86A3B3C01
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786401659; cv=none; b=lBsz6Ntbb4fFFk5Tiso1mXUliHeUIKY5R074lALafwi3jb9uATzVDvB8vY8qCZbHAzQP+VNM1hNxVmwSv7d1+7caXQ/yUduHYlwxuxvwUxv7u3crR1zW5JlHkyAU39CpC0vXvaR5bPnQ7VLBKTgUAOiebJJM53aBqq3Mua4T6Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786401659; c=relaxed/simple;
	bh=tn0LCEOXlmq0NtwLm5PUAuiPzR2cCLoxPZW5E6vQkSM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=br9wa7dH+Bxo0NC1GcKk6teaeF94BwajyBFoSQXkyQPDOPSNInCAbfieJtrXQKtj0O0clSVIurSZ0nLK6e+6V15SW7n44CEds0WtIgj2y1nZH4JyClZ3r7T3wK7/uKFvulYU1d1Bday/WAWtGFdLA4SLnCBgjdoAD5We7OxcSHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVIUSFkG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVIUSFkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A4A1F000E9;
	Mon, 10 Aug 2026 22:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786401658;
	bh=vDT6lH0Ud6l0jYOI8SX+rTOav8SwXVbN901wxtTlzBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YVIUSFkG4Dhblp6l3DqIzrCcZvI/S3ZnNbNycOOUJbGZtuAhzSK0ifhRD0L2MsZhV
	 F2hkdlxBENK9gFPEUjw/EPq3oY6hn2WsZ71nN+XcEHloGQAYfIag4b4PKnLmb2rFAy
	 KsPyTcLFg6nk2VqKCXX7+lqx0sBi0zM9Qm1snDZuyQX+HgqKAVIo9Wl8qy+Whs0yvD
	 vttntNsLO88OazDwV6sNjjvs1hg4ecB9cOUPzidT6efnJV2USICZTDewVxEU95e+Wl
	 4RIxcO4tj/6vsMwunZxn1WhcyhBZeCFR7S07iV7hZe//N5djv2aHvfIgoSP8nCkPIT
	 XDtMHOd7dV2vA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 40E983926265;
	Mon, 10 Aug 2026 22:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] macvlan: inherit needed_headroom and needed_tailroom
 from
 lowerdev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640161489.238814.16305919638200526309.git-patchwork-notify@kernel.org>
Date: Mon, 10 Aug 2026 22:40:14 +0000
References: <20260806141938.287660-1-edumazet@google.com>
In-Reply-To: <20260806141938.287660-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, xietangxin@h-partners.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Aug 2026 14:19:38 +0000 you wrote:
> macvlan devices inherit hard_header_len from lowerdev during macvlan_init(),
> but leave needed_headroom and needed_tailroom set to 0.
> 
> When the underlying lowerdev requires extra headroom or tailroom for
> headers/trailers (e.g. macsec, ipsec, wireguard, tunnels, or veth with rx
> headroom), upper layers calculating packet headroom and tailroom fail to
> reserve sufficient space.
> 
> [...]

Here is the summary with links:
  - [net] macvlan: inherit needed_headroom and needed_tailroom from lowerdev
    https://git.kernel.org/netdev/net/c/cef51860becd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


