Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA24321F42;
	Tue, 17 Feb 2026 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326614; cv=none; b=Bjv9AhJvTEP6HNeNY2OPKWMrTvVcd63kGMFABKS7I5XRzLeSrieN/KiF0gdpE7HEfJhyPP5dh1ibQ0DThx1XiQVI/bD9sMw5xtYbw/iGt2B7Zw5PbveedNti7wql4vAPg8UT4bIFizcrnFAZsf3H454hq8QRZP2ToU6YfldhfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326614; c=relaxed/simple;
	bh=HYQmNgXbaSDujkNgDA1fNaE5PjxPfwLo/OS9lM7Yecw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p25EDQzknj8f9YukmWbZ2+AkYJoHcPv9Ja+W2x3pqKSE4SC0YxNvy6WVfOCwl2tOwZYKePmpUO78d/8NwUZ/pniqTG1br0krVCgjW8Pf+Fdl2R4fPFS/at9W6H+ipXulQyvXXaI8z78Lom3bQWSwGjgzVRS1UfZgZXPEKJobVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNWndunu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNWndunu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81010C4CEF7;
	Tue, 17 Feb 2026 11:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771326614;
	bh=HYQmNgXbaSDujkNgDA1fNaE5PjxPfwLo/OS9lM7Yecw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XNWndunu9rdO3xm0aWJNp9GJ46fJuu/ZKAlJXhb3G3FILuxuDgIN7Q/hW8uKEgSEK
	 CLYaM9Y8NqfkArvCnYq7rDbciZulwBUr0pWXdtYZR6SCtQBnaLeQkTFjqIsufK5Sb2
	 rvlCMBE/fzRRkoKeGyvlhl/gbB0aTxzmbTRomut4GoO6qYgT12LNORAAi8hSPM+XNZ
	 dwow6X4MrrGkC0ZP24hG9th/NUKCHVtC3N43lFYwKjVpaCdVpBS/lKWgtOxxxQmsQG
	 20Ru8Z9bMk9fFtIqlAxqcPVlLH+5w9Y4hrQBnVOlemWAVgQRGsHm/Or4gNDl4wfvGt
	 7gtfn2oV/47eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C22C6380AAD0;
	Tue, 17 Feb 2026 11:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] xen-netback: reject zero-queue configuration from
 guest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177132660658.24996.8282922634336932490.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 11:10:06 +0000
References: <20260212224040.86674-1-n7l8m4@u.northwestern.edu>
In-Reply-To: <20260212224040.86674-1-n7l8m4@u.northwestern.edu>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: wei.liu@kernel.org, paul@xen.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew.bennieston@citrix.com, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 12 Feb 2026 22:40:40 +0000 you wrote:
> A malicious or buggy Xen guest can write "0" to the xenbus key
> "multi-queue-num-queues". The connect() function in the backend only
> validates the upper bound (requested_num_queues > xenvif_max_queues)
> but not zero, allowing requested_num_queues=0 to reach
> vzalloc(array_size(0, sizeof(struct xenvif_queue))), which triggers
> WARN_ON_ONCE(!size) in __vmalloc_node_range().
> 
> [...]

Here is the summary with links:
  - [net] xen-netback: reject zero-queue configuration from guest
    https://git.kernel.org/netdev/net/c/6d1dc8014334

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


