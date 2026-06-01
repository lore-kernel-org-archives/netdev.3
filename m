Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EBD35DD1C;
	Mon,  1 Jun 2026 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321804; cv=none; b=P+bd6FyN/cLrJk451/3B8v69puLvFi2N5ibs7j250X4H82BPsU1ZuVwD+8eVSdRVWxXGLyH4LKF+Iwhjdw/lBDhvfNZ8nHvPWQNxajQKLtEg9woG89Hm/qoZB7B7driXgQVKKM9oo9nDZM4i0Ke9BejxkNJSdZq6x9gNb20maf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321804; c=relaxed/simple;
	bh=aibuByHf8qRDGR3RWczGu9wUpXkwv/XzH0qX2scuoko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ae00UHr9WqIieCgZpX/UDvBXh6tBnEAgjHCL6w3e8bjuGIeWectDSDZ/Srp3BbJqXlt5dqeJtLWzI9jiyAuG4ccICJ44ITWpwOVkRYwcbqs8NRD046NIrWnl5Xzgl9Xce6qFfYRtNfh6ywM40ytLuGVjhsiYZgTOaPFtv8DHA/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYONUreP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYONUreP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AD71F00893;
	Mon,  1 Jun 2026 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780321803;
	bh=u7M/UMMShomoyiLwJ8rDZDuYNqd/j3nRdYj5RlobyyI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AYONUrePbn6h8O+jl3n14FOuErv+DdtnQYmgCsFN5yy2hGN7UUUTTVCtWpRCgKQ/b
	 k608Td6bcHY9wJ2KxN22oMLSEIdOA0PHrSU2tTfiC/GviuVJE8YoFwJfPWrfjVkkZQ
	 TYuiTQcTzD9gX4gnJp49eJtCmac33VMinyAYDzftwDb6IxCK9onsjYRc0HbyB9S8Qi
	 KxboalZwVP6UQGWtIK0VnWSaVH6DqT7yvme9IgfPFGkv3n2XeA0hj8e41f+2xl3uV9
	 wf0KjmHhjSj6zwYuhq97e4eqBUq2yxIXQCeJfuZfZyScMTrUOZuRLWWaHkrRMJ5bn1
	 AX5tmaZrxke0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 133D238119D5;
	Mon,  1 Jun 2026 13:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ibm: emac: Reserve VLAN header in MJS limit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178032180590.3687626.10937538146710497492.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jun 2026 13:50:05 +0000
References: <20260526202247.13823-1-rosenp@gmail.com>
In-Reply-To: <20260526202247.13823-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 26 May 2026 13:22:47 -0700 you wrote:
> The IBM EMAC programs its Maximum Jumbo Size (MJS) drop
> threshold from ndev->mtu directly. The hardware sizes the threshold
> against the L2 frame minus the ethernet header, but does not
> discount the 802.1Q tag, so a frame carrying a VLAN tag and a full
> 1500-byte payload exceeds MJS by exactly 4 bytes and is dropped.
> 
> This is normally hidden because JPSM (and therefore the MJS check)
> only engages when the MTU is raised above ETH_DATA_LEN.  With the
> qca8k DSA tagger the conduit MTU is bumped by QCA_HDR_LEN to 1502
> during dsa_conduit_setup(), which is enough to enable JPSM and
> expose the off-by-VLAN-tag in the limit.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ibm: emac: Reserve VLAN header in MJS limit
    https://git.kernel.org/netdev/net-next/c/0906c117f81c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


