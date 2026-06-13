Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289B23A7F61
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781391612; cv=none; b=ab8I6S/jX5n6F9XxECfbrx8NhX2YQsDWqo5cjkPFBcCdFomJ6YXqHs7B1yQmpDlCcaIju4TjcXDyvVvsU7l1LUhL3VLUCUuDJCohi7d1WWnBj04pXjuhIdr2MU8oTKQ99K4y7XqrsSJqVJaSZZc1+GUIceMbUwaol3KrpEje2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781391612; c=relaxed/simple;
	bh=vN6Lra52DSdkOd/V3iRXgsHWUMdOe9u40A6KbsxV+IU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zo8/EEj3kTvUzvFY/GKrj1+pI0LtJsJKBQlC172WFRsZ/jWskrY7kR+xAUyFt+WYpfqqeOud/P1mViFVEXiKtEWrcsVSZ8SLasvVnfqS64Lh9R2/lE4nLcYH6kHx8UOvsJlm+wTI/XmwTE00q5fLwqPYhFesD7tQ93l1bcPbf8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5wl2PhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5wl2PhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCE51F000E9;
	Sat, 13 Jun 2026 23:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781391611;
	bh=P8WasD/vQDuJyqo+FqFAI74xFhoNUNnfAZPGSwZVYz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f5wl2PhVE+t5FIGOYZcIed7M/JTvwEGVMDs5i8fGdfle8E/VvnBXFqpZwL9iC5QYy
	 LjtKcUWzZ8bumn3BtDnA0icJwIfgjxfxf5wjKJ4HgvBusG78xfctu+6VDXHpf9Jncy
	 AfSugPVbsC1ue0DLWgc4KgtvGChggITXQGJtUdNwwvD6rHh2F9DiTr9o3MlyXsddqe
	 +45jo2IKFkKjYian9v48u9T4fu2JqS9mK3cVTB7bwXV4cP7CK9X8fg8RYChdYpIRMg
	 kowTV98iskwMS/aNqHmFsK5b2R0Pjzx/3hSd0yYgd2lVcLtiml2IFpd+nwSrQas7Q4
	 x75d60fEaAl1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AE23A54A32;
	Sat, 13 Jun 2026 23:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: airoha: Fix register index for Tx-fwd counter
 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178139160689.1619194.9003446949920537731.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 23:00:06 +0000
References: <6a2b40e7.4dd82583.3a5c46.e566@mx.google.com>
In-Reply-To: <6a2b40e7.4dd82583.3a5c46.e566@mx.google.com>
To: Wayen.Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 07:09:13 +0800 you wrote:
> In airoha_qdma_init_qos_stats(), the Tx-fwd counter configuration
> register uses the same index (i << 1) as the Tx-cpu counter, which
> overwrites the Tx-cpu configuration. The Tx-fwd counter value register
> correctly uses (i << 1) + 1, so the configuration register should use
> the same index.
> 
> Fix the REG_CNTR_CFG index from (i << 1) to ((i << 1) + 1) so that
> the Tx-fwd counter is properly configured instead of clobbering the
> Tx-cpu counter config.
> 
> [...]

Here is the summary with links:
  - net: airoha: Fix register index for Tx-fwd counter configuration
    https://git.kernel.org/netdev/net/c/1402ecccf563

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


