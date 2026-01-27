Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81827262B
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769476210; cv=none; b=M25w6veYCc1zY4XvhCrRkOBfRfKKqRucCXnMQxocYCB+N0H0/70UzOJv8LdR/zIPF5nA+BOIF9Nrebt+o/UihBLMOjcB8So2XpjOR2/BF1wNeLNiSuKB/Fsb60Pg9JMslmPizbo6e1zbRNjkvSkE/JBHWxc5kBdnCaVoYxcmkyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769476210; c=relaxed/simple;
	bh=YP9ZETOVBBxYh1mu3HBMxkMd5Bw7x/D+FpThQoDMht4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UTo0XQQALFtQEf6/BOjsMZHFgxaS2kgGfCXM2/r3EnwVM65oeuZNd5t1qPkjCf/xUD3nyDIrnmmxwy6aNwU486cbs1VMbcUzuojWnWVVXXLXPEeAOfBDXrVHaITEro77yHdInYR9yk1MQACO4c6XD7E9dBHvItYrsnvjniqHZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rn6YsqSz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn6YsqSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53400C116C6;
	Tue, 27 Jan 2026 01:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769476210;
	bh=YP9ZETOVBBxYh1mu3HBMxkMd5Bw7x/D+FpThQoDMht4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rn6YsqSz6xAiHu1wCHc6RkKEDPlB4o5I+p4j8Uawy/auACOYwxlw9V5pdTAdgrbTX
	 dv8MiByAovf24MUlZoyqpYfMzcrvC+WzMRA+xoWYbK++fqbBB13gPfIKq9K9tfWi20
	 Vbs6wQCyEibgaSfehmoPgVrJ2m6gQnsi0DjeHwZ6ay6mxRMqdrFw3fsur9lwDl0I+G
	 iRhAMgz8F7/nrw12MqlgB6LrilxNFKpJa5VQr/Sz28ZPkuU9uZfcEm2fsTP3Lnc7l+
	 T9bry7EoTaZhW3KStTIxyOhgSrhkianW8MojorcWu4GTjvppdiTacPrYs3cfr0mb/y
	 egcpPlhu6KVmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8B70380A95F;
	Tue, 27 Jan 2026 01:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: include <linux/hex.h> from
 sysctl_net_core.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176947620461.632917.4021685598067861318.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 01:10:04 +0000
References: <20260126174731.2767372-1-edumazet@google.com>
In-Reply-To: <20260126174731.2767372-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 broonie@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Jan 2026 17:47:31 +0000 you wrote:
> Needed for hex_byte_pack().
> 
> x86_64 was already including it, but some arches were not.
> 
> Fixes: 37b0ea8fef56 ("net: expand NETDEV_RSS_KEY_LEN to 256 bytes")
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/netdev/aXeka0KYBnrkwUcF@sirena.org.uk/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: include <linux/hex.h> from sysctl_net_core.c
    https://git.kernel.org/netdev/net-next/c/3da35aa8af34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


