Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA8371072
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808247; cv=none; b=KC5eU08Dspzdic5yf+IdWjfCWKQzQHOeLkmcieVmRmhfokYsYwlDkdMy0EL0I/BEDTdP/uK2OakchVAHOcwBUjY6ZKJUQbUzu2IZIyPyyQWZx7u4IJbp1R5vR2vJvQ8ywONUWaARrX8vXf7tUdrrseiVvPpjTpjKbvJWg2DiPOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808247; c=relaxed/simple;
	bh=/kEKmpPuvD5KyQCYh2aEPQtiwreAMUf2ZbKlhxKe2Og=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q1lJjKKOiviVqF637M50P/1NQlZsQYZY3mMEHsqhIjbtqt+965hA1X0W80bsAqiQB8jWCbwYc7/qTuKwHh7hnaTVuGb81uPB/Ef+Nbm9QwohSzjM2FMRrSxB4oq0IGmdu2mlXc/VOyjHAaNs4iEPNh4Q5sHjnhvm4fuHFn2j9H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZ/H5Qxx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZ/H5Qxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4063C1F000E9;
	Tue,  4 Aug 2026 01:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785808246;
	bh=lwQHFXQhl3bgwoMRNhjAwGgHTtX1rDKsgWhyZSN2ZAI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MZ/H5QxxLFXSNVJn3ZA5ZIrT3B9GD+eyovhWr2dnQEqguaZa7E9LLJ4ZwSU1CGs1W
	 WSuUKNOTkAtcnrmZIGwOQ5/ZY8vnel+ojnu9tf2Q1DjwJv/5Uou0QU7zl9e86krBi2
	 Ke0Cd3zj/Pk2jqWaZxPnC4H/pHNXLSqy3rqQzv+RC4yZ0zXKjxsjoHzefHyVR9SL7p
	 GqZCw72fhOw+L7QsGKK5504fveeP14ZjmsbffWfZK8UrkdTyo4rIXfKKLXyBf2VKW4
	 Ao6HFTSJqY+GD8lBg1BRZ91RlbbXihKOA92+cT95NFRhB5ExmQKl8VcjT5rqxMGBiK
	 RS1kM0gQmhhdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5697E3924467;
	Tue,  4 Aug 2026 01:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_cake: drop WARN_ON(1) for malformed
 packets in ACK filter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178580820690.2913307.15981227334988638380.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 01:50:06 +0000
References: <20260729191417.45665-1-toke@toke.dk>
In-Reply-To: <20260729191417.45665-1-toke@toke.dk>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHRva2UuZGs+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 zhilinz@nebusec.ai, enjou1224z@gmail.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Jul 2026 21:14:16 +0200 you wrote:
> The sch_cake ACK filter parses packets to find the TCP header and filter
> duplicated ACKs if the flow is backlogged. The parsing code contains a
> WARN_ON(1) which can be triggered by a malformed IP header in certain
> cases. Depending on the system configuration, this leads either to
> either spamming dmesg with warnings, or a panic if panic_on_warn is set.
> 
> The code already correctly skips the offending packet in the branch that
> triggers the warning, so the WARN_ON itself doesn't really serve any
> purpose. So just drop it altogether to avoid the inconvenient side
> effects.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: sch_cake: drop WARN_ON(1) for malformed packets in ACK filter
    https://git.kernel.org/netdev/net/c/2a33516f9ef5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


