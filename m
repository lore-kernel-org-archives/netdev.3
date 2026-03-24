Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4970012E1DC
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774317626; cv=none; b=s5WmYxvy40LbdBNBYv18IA5a+o5JOewYP0yOGdilblJqv4EjBCSWX9ZIHK/dTcaP94sjs9LP6W9+I5d3HPj/lrmgZQBYs6lWNbsVhy7EOaoKkhZdJvboHyxKEpi5Qj7pt//Xlj9qtmtrd0V+HHqpbuxZvOkKCp7yGNB91S5ateM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774317626; c=relaxed/simple;
	bh=k7FDPLFeCJPeTBWKM4Ky0XB8ZEYFUvmuo5g9y0FWhdU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s+jG9OI6KZAdde6fWxJAXunQ0S+W4h0Uv5EbS+2L5zCHGTudI4M97+XFxGhQDTmC3wLB4wcMr4phTMLTZz5ECvFcuCRGYvBHbwvUA0sZQCY3HaC/A41e0aR7rVplWzpmZTpdJ6Px1gKumep8CLGyEkrynlLRpQyfvztgYh6j/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHt7Q1pq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHt7Q1pq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D320BC4CEF7;
	Tue, 24 Mar 2026 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774317625;
	bh=k7FDPLFeCJPeTBWKM4Ky0XB8ZEYFUvmuo5g9y0FWhdU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CHt7Q1pqbEXwzwILhRqMMFAO25qMAFPNXkavJKDxTfjz3PYQ9q2I/gUMMOOb3Ph/n
	 hqCfOScD06mJad7pBzw4TMwr9OYX8IXujckDKaAvZWJmcpZb8V3mPSLJfvI+JCRNCy
	 VuFoFvs5KeWLAFXhOg26oWOnY8tAyR5NBx9BoU1eUmSjfhtMzDrmWFtdbiEztIy5OK
	 PL/ylP6rDKTtZgNAXz1JtmeWLUhdd+3qhOnu/RlVSidmLwiKQrEwG0dud68HbKCF1T
	 NWUn0ozqmWampB4HsGn7pHCecOBZFCKETVKFBbhpUAd9a4ccqms8xrF7pJJ66Tzx2F
	 d2et/G8qY+QAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD8A3808200;
	Tue, 24 Mar 2026 02:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] udp: Fix wildcard bind conflict check when using
 hash2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177431761378.416781.8516935452069450224.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 02:00:13 +0000
References: <20260319181817.1901357-1-martin.lau@linux.dev>
In-Reply-To: <20260319181817.1901357-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, kuniyu@google.com, oandrew@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Mar 2026 11:18:17 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> When binding a udp_sock to a local address and port, UDP uses
> two hashes (udptable->hash and udptable->hash2) for collision
> detection. The current code switches to "hash2" when
> hslot->count > 10.
> 
> [...]

Here is the summary with links:
  - [net] udp: Fix wildcard bind conflict check when using hash2
    https://git.kernel.org/netdev/net/c/e537dd15d0d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


