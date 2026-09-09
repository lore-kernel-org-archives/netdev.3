Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C2D3D73
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914467; cv=none; b=Z2KDCk0a/rtJUaipOgEYCw0StjFNGlp7RuVxzYhpWQC4+8hEEmiDwnCx6/vfExJrHwWT/JEhXWmoukdoa+mP7DdCeCsG6cT/RDGsn8runLzjSeaJ+MeHQT+CsJoRzonrsmkT1oaCMKJc9qwEWm7KdT0Nc4ptAVYoo5Sk9Kg0H/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914467; c=relaxed/simple;
	bh=oUZwPjgz8KO21KEfLoXEqoItEDb3RqDkeC1tpBi1Yeg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LqO4j3SyTrotVO71F5Zm4279044PrbE/VH5VkdlBdLChHVWE4BtBx2KDXb/pD1FQwzBwIl5jk1cNTEWyqRWXdxBw976FhheYRzdtxAM7Qt+oJzaUOwrUr4tVz57iLytdTbj46dPmBUqOfzbGuks7heWnLPjWQ1k0FhvJhtk/5oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq/47Jt1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq/47Jt1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A3A1F00A3A;
	Wed,  9 Sep 2026 00:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914466;
	bh=xbzX0xNkpEWHY/V/XiUuAx9Gx2tsicurG8DyGn8UScY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Uq/47Jt1xFa1jiE8A1qHk9d07W8qaA0kOWeAzLtOtQnsskQD/o/JdL7z/zITqs+bF
	 c0E/sYUdy4skM1AxRQd/VFLPGdTUjZlEY5CB2cUx5uCjQC7LEr7S8n7Q5PmHXDUXEA
	 VKTb9BpEwbvUswrjvvAi3B2xzpEemL7SfPZVYrV2/Oab51jd29XHMtdeO9zlOzgLAh
	 CLrEtUsDOkvyNK9PQXuoggoSmYxunDLjCJODHzk8BORzLJRhP+YxAU1PX54UgRcLct
	 71X3r7PEIt9q7efrfVbedNQAFFnVpKchDBP/ToMsapYA/4Zf+XlbGUD9xgJoc2MgzG
	 nZ5oKSUoPpceQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19F6F380820D;
	Wed,  9 Sep 2026 00:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ipa: Drop the monitor_rx endpoint_id ABI
 entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178891440490.81609.14246453975165066243.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 00:40:04 +0000
References: <20260905092719.41497-1-kmehltretter@gmail.com>
In-Reply-To: <20260905092719.41497-1-kmehltretter@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: elder@kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  5 Sep 2026 11:27:19 +0200 you wrote:
> The ABI file documents .../endpoint_id/monitor_rx, but
> drivers/net/ipa/ipa_sysfs.c has only ever created modem_rx and modem_tx
> in the endpoint_id group. No monitor endpoint attribute exists.
> 
> Drop the entry.
> 
> Fixes: d79e4164d0d5 ("net: ipa: add an endpoint device attribute group")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ipa: Drop the monitor_rx endpoint_id ABI entry
    https://git.kernel.org/netdev/net-next/c/548b86839f7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


