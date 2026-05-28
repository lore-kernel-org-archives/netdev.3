Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD11035E1CB
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780006252; cv=none; b=pRtPOLKTg9ozXC43G1DYHOO5UGGed9MRg9hmmuPHjBd9LB0fI5ynqx2xIrHGnRA6DEsCBLFIyw8+uhfmTSYgap7EuuwCe1FTohzDX93O9bO5N5pKzu9px5Hfk37v5di1bA8rabdnPEEzUrI1QUGJIQNPy/F1cyRGVyddOVLBuCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780006252; c=relaxed/simple;
	bh=VlwXYSbBOjap7pfXujq9POMstIKZCt5SH9oORlolc1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uTWNBwhIYGO9Rot3Uvp2EsnMKNDLxPisFmLHvjRONZEnhb68r2IczD4kTIFjqljzYQ7Fqnqrjv6J+1p4sQVUgtJKzXCTyqjDsOYXWDbYEbITfMfTVrmzbF9z2QoiqjD+zgNfboV7A5AU+wRWFV2cpfq1CVli4PLJX4Jv+DODUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL8LZlXX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NL8LZlXX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16AA1F00A3A;
	Thu, 28 May 2026 22:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780006251;
	bh=gl9g8sNVyMvoK8sITHHtySAMgoXtShYvm8nHnbpiik8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NL8LZlXXc7/5/a2ign7c6NSmPB1qcJ0UQQ9DUS2Ad9Bd4Ax4ZPTfVpM2Xt9l3Ti4a
	 ceq/JeDEOfN3ymvdKzaYbgFU5jME2CKFIpCdh6h2PYYP88GlDseHpvUKvFTw13SvO3
	 WfKEPAlKW08Sj7koZ+fqdyZhavvSc5fuT3l1SDpAMJ7rxafxeKrq3dK89GPcg+161V
	 p+dG0eED7RTOR2Z/r7D3vNVJfdBkBHQBSYFwZ2tmFwGpoMbfnIOrD0/Gm/t/9uBKBE
	 dWGGmpCN5Qu9QUwxOZpfv/gUsmrK4IjGMkg1Iuvu8Pj+uVkMh9LVx6RJOqxw/M12ci
	 ZCNt3nEOUHmnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199593811977;
	Thu, 28 May 2026 22:10:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethtool: don't take rtnl_lock for global
 string
 dump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178000625569.1533055.2177941213160569865.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 22:10:55 +0000
References: <20260527162522.3344231-1-kuba@kernel.org>
In-Reply-To: <20260527162522.3344231-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 maxime.chevallier@bootlin.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 09:25:22 -0700 you wrote:
> ETHTOOL_MSG_STRSET_GET is the only op which sets allow_nodev_do.
> When no device is provided it dumps static tables, there's no
> need to hold rtnl_lock for this.
> 
> Not taking rtnl_lock is a minor win in itself so I think this
> patch stands on its own merits. Later on it will be useful
> to do locking only in paths which have access to a netdev,
> so that we can decide which locks to take per-netdev.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethtool: don't take rtnl_lock for global string dump
    https://git.kernel.org/netdev/net-next/c/f635b0c91275

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


