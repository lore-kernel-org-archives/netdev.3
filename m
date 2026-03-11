Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B993451A9;
	Wed, 11 Mar 2026 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773196826; cv=none; b=jgh3buujGDm8KSBhxQ4zCTQVu1KSr5lq2XZFs8eaW+53u/sksZCTdkogfpWE9rwpygihqFL/WuliOQCZviMw3nKh1ezuW9aybCpV4p2CSHT6b8yF9IuA5OuqNc0yp1id82HApbJnH3RUKlSkJ8I1M+OJ+1VqzTE5UgkJHOMDpVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773196826; c=relaxed/simple;
	bh=VPOiu8hKf5ZvMF69IMtZaLanpdl4Ux3RL9b/8kyblKU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=deg8bdoUJ8c3kT5V3WsAIgUnThqJS7QnoRlrQPGMCQV4PGtzkQBQeGR4WQM427dl9FRavLnD91hFtLg32CCC/gFzc6qrTXo82Ue+KpcNgDoI1b+zUhvO43qQqEFihKyAhX7S2LnbM770AVCwJKNIlryA/eOdzSmJV20hADX3HUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m030Pw7K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m030Pw7K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85298C19423;
	Wed, 11 Mar 2026 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773196826;
	bh=VPOiu8hKf5ZvMF69IMtZaLanpdl4Ux3RL9b/8kyblKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m030Pw7KJYM/SY21E964t4ufAFMEwecweLs0hmXl6U6FQzslZ4zdIdFgMdmqsgnyg
	 78p7hGBdealIiOuOqT9UVRfR/t2LaRrhITcDHz6EpEz7DIMcq59k0ohsbnGne9rF/r
	 aa+5eSl+bvCEPjapK2WFJyEj9YKHDpGFHb1IsQImfZ2Zrz7qqrG1VGzfISpqZyi+IS
	 2p4CIZqwvuJML4fgXnBDWOUuXx/poLs15Jq2gbzB0rPIRtNBz3eUK7aGYADAy8Htfq
	 X/q7Yy9Fdo4Q6SFGeLCorWuk+ru/tTSFI4hdSy3Y5w430MbwCA5+A5HHDC9wSHwZfq
	 bHSBRkSaz5HuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD8D3808200;
	Wed, 11 Mar 2026 02:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] inet: add ip_local_port_step_width sysctl to
 improve port usage distribution
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319682279.3014711.17279884467233370716.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 02:40:22 +0000
References: <20260309023946.5473-2-fmancera@suse.de>
In-Reply-To: <20260309023946.5473-2-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, ncardwell@google.com, kuniyu@google.com,
 dsahern@kernel.org, willemb@google.com, chia-yu.chang@nokia-bell-labs.com,
 idosch@nvidia.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Mar 2026 03:39:45 +0100 you wrote:
> With the current port selection algorithm, ports after a reserved port
> range or long time used port are used more often than others [1]. This
> causes an uneven port usage distribution. This combines with cloud
> environments blocking connections between the application server and the
> database server if there was a previous connection with the same source
> port, leading to connectivity problems between applications on cloud
> environments.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] inet: add ip_local_port_step_width sysctl to improve port usage distribution
    https://git.kernel.org/netdev/net-next/c/7da62262ec96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


