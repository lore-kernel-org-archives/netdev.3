Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CAD34CCE
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776678; cv=none; b=asrKTux6CIA3gbW09f71lP/OaTqAEusGT8cF6qeRV6czi3JKOezx4SAXlKxsus7lGo/SnbgkHRMp/zilTkg6gs85i1r2lwb0CB8qvC9QQW5seHxAxq4+bpFRNa6J457ReLO4/o8IdkIqIXA8v6HDnkX2soths9O2sYecDxpwH3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776678; c=relaxed/simple;
	bh=VTERgfpPTBdX1Wxk35hSGdOxifhUzdxvTcH/HPmhmbQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OyBxa4ZCWOT5Put+xzB0DBDXklnvOlmnSRtghc10zRXMscZlthvVdSEQYzGD/BBdK/1ayyD1JJKc7KD/LffD11L5rOe+C9ViI4wi881bRXs+Px53sPhySDxpXqarteP6qnTYTSRUD5o32CTmGLS1rpLRTbUW2OsiuUdsNpieSTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQJT6Ksa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQJT6Ksa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C09F1F00898;
	Sat, 19 Sep 2026 00:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776677;
	bh=WYSmmvWran4eH7ol8sXXvahMVK9O7Yrxoafa3gM6OhQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IQJT6KsaXDUc5DOZBLdOWgPe8bLJuv3XVZdhjjQqI/scvRbT367VLYKLE7uLlSlJw
	 kE3qGw0GxWH7C5yB4GLGVfPsBEIUSAEpEFI/YcgTI1lguIBQojLGiUDJektS32Syyk
	 bGyoYjnJ5ehrzEvmJ3DbKfaYY8cFCPYfQmOs7yDFQGLKfppL3mCjNywaWJO4w8q5aA
	 ZdJ8EPqz9Yd971mshIo4IVmSzSK71Q2RrPv4jO8hXR9AeIaacN0ulkN163GlPlDBKa
	 7Yz3ZcxcEn4M87zg1lOMcvja4tK0Ar1BTrBEVDW7+weoleSW5vq3yDwgLmBmt6beEG
	 sqEVl7Rikaozw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A8A3811977;
	Sat, 19 Sep 2026 00:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] ip6_gre: Call ip6erspan_tunnel_unlink_md() in
 ip6erspan_changelink().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977660989.1197442.5379934704610078750.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 00:10:09 +0000
References: <20260916230927.378957-1-kuniyu@google.com>
In-Reply-To: <20260916230927.378957-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 u9012063@gmail.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 23:09:24 +0000 you wrote:
> The cited commit accidentally added ip6gre_tunnel_unlink_md()
> in ip6erspan_changelink().
> 
> Let's correct it to ip6erspan_tunnel_unlink_md().
> 
> Fixes: b80d0b93b991 ("net: ip6_gre: fix tunnel metadata device sharing.")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> 
> [...]

Here is the summary with links:
  - [v1,net] ip6_gre: Call ip6erspan_tunnel_unlink_md() in ip6erspan_changelink().
    https://git.kernel.org/netdev/net/c/dd47bcf279f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


