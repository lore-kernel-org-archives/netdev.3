Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5322DB7B8
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538415; cv=none; b=Z0oRdX+MZLe+wnTnmDw5NR7yDxCnGvxF6W/3uo1Pkz4SWUOQi9QMemRcbii4wzocG+xfFNpFWA31umYb2n1zJ+0FYjD++iD5/LDLQdl+LnYGA32atR2h+554rJzZDEnL+SjKoIlPpxLC64dXbrlrw1mInv6KGEojWYcxcUL86TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538415; c=relaxed/simple;
	bh=98ruJFnz+wyuTFJ406aniv8fxsculHb0zEAXx1rTrk0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZImVWzqUSnFLjmjwa2FmiTrF/fF1qhMe1vjUnOW0Oyh2U4+kBswHmqchynceu8WWL9ZSXW0Z5p4Ld5dJ9bq9EwOBQVAWh9oDS+Ii3/zcYQZBZXGeHEsKeq2KRI0Nn2vARHdnnkKECIODtH1ZahaiAcUNIxFgoyOKHjMksi5sHKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UA3Tes90; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA3Tes90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67A41F00898;
	Thu,  4 Jun 2026 02:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780538414;
	bh=FZl92fMRpwoogmOzcoi7thHJq7C5QvnwYlHsLaGc3go=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UA3Tes90bB35Auhef6/O825mT24SpNYq6rxMCGzaAEopHlxedoPZz0eZpE0p7B6b6
	 6QjvAR15Inj3MXU5/SGKm1KjVlbZRc0qSW/p4leIcJ6a4x7gNcyrHZ342AU19hkmlu
	 aOj/0nE2EFvipND6ker5XVIQjSWBoTQFUwiqdNd2vkHwagxzGJHrgY6GZnFm1nbKM8
	 hWFyZGJ/bMdGMXd9Pvjlni9h8QsyrZWp2E/tKghJpNADWaS9l+LXgTteitBh1ejZkB
	 YqUsiY1A3mjpmk5iz8c92fO6U2s2esq7hd43lpkzZpuTm2ynMFxRSb3ZgFNpwwEF4E
	 mjdqTr6movN2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5685D39308E0;
	Thu,  4 Jun 2026 02:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053841489.2201066.15034562668462590122.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:00:14 +0000
References: <20260602161547.2642155-1-edumazet@google.com>
In-Reply-To: <20260602161547.2642155-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, tamirthesis@gmail.com, aksecurity@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 16:15:47 +0000 you wrote:
> This patch restricts setting Loose Source and Record Route (LSRR)
> and Strict Source and Record Route (SSRR) IP options to users
> with CAP_NET_RAW capability.
> 
> This prevents unprivileged applications from forcing packets to route
> through attacker-controlled nodes to leak TCP ISN and possibly other
> protocol information.
> 
> [...]

Here is the summary with links:
  - [v2,net] ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
    https://git.kernel.org/netdev/net/c/d3915a1f5a4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


