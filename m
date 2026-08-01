Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BA53A1A23;
	Sat,  1 Aug 2026 01:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548465; cv=none; b=tL8cndh4eEsvXVwuRwOHwhujZ8yRd1ss89bP02XFHqPGry8XDmWIjB+0w1SPgfA47ZcxwgdIXBEsZYkvM39Xlh0X1/EOPM0sIH4lOHhQx8z7xgcfC+lBOvRfqJPSXIYjocO/IORUzPXug9TeCv+0gpNYzBJIu0r0SJP8kLo9F+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548465; c=relaxed/simple;
	bh=mR04vcU/AYODoLZxVXBJztmmJm3usulaB2ZWOlRjA/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LP+PCT8SsmS/0J8XUaTQxD0BR3uio0a9d8dPRCDO5BS+MLN/JVs+1E//z2FBskbsob0A1xa15oh8IMZVLja/vlHnGwVm5VrEFVrEFaoYKnTwts+CLg0Y/2Bbq4YgD0OEgEZxas1UwW4XqsMsOWILqw0gcAwf3tpqi59xH62yx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRCLbXFz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRCLbXFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F6B1F00ACA;
	Sat,  1 Aug 2026 01:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548463;
	bh=tcMvt8EH6BzUG1dntU81VOxvOp5ggX4ZS5jVsjK9Gn4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jRCLbXFzVCAAMyQLwz/aOFaFAOmdqeJkIX/LExclVhvzd7uj8XKw3irgplQ4cXmuq
	 vORgyOqPOcLfnOyqWxKwbBOt2s2ERVRYwYpdLa/7u0Agy3bpZ1uUylJcamfp5BQuSs
	 G4NRkyZMYWNWaOBeH69NXDGQrVZtDraIa/lPjD7tPexl7PxmtLoKV16c4/7aEzvhoQ
	 VZEvTCkoY1pw2hs4uqUNZ2anXOePTTSivtKVELqzlNmY9HKbWimwr7xUkB1DfwJ855
	 2fxq95hJb0D9iunnChLXYOPpj5BgxUzec0Kp/oA7z1lZFfrR/s7CeHP1ICUk2odd7A
	 EAxlL1TxiXWnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93986392665F;
	Sat,  1 Aug 2026 01:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] octeontx2-af: add new mbox to support sync
 cycle
 on rx path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178554842613.979996.2820818539307566270.git-patchwork-notify@kernel.org>
Date: Sat, 01 Aug 2026 01:40:26 +0000
References: <20260727101608.300290-1-rkannoth@marvell.com>
In-Reply-To: <20260727101608.300290-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
 skoteshwar@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 15:46:08 +0530 you wrote:
> From: Satha Rao <skoteshwar@marvell.com>
> 
> sync ensures that all packets that were in flight are flushed out to
> memory. This can be used to assist in the tearing down of an active RQ.
> 
> To complete disabling RQs or disabling SMQ and its SQs, LF software
> send mbox to AF to complete RX_SW_SYNC.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] octeontx2-af: add new mbox to support sync cycle on rx path
    https://git.kernel.org/netdev/net-next/c/1327e30657d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


