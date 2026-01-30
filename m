Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7931B284665;
	Fri, 30 Jan 2026 03:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769744416; cv=none; b=A5hlJdTctAJn+mqirDTfCG8NMooGZQ37Q66VX1T1VcCcnQLa+xdRAZJDKefar9Kkgx+C5U27JIB8HY7HSVd6/Oj2zcqy1p/NF0gzoewNxaciGHtE9ET3twL1yzcjgSqNnID7DmXj2padYnvbADQkWLMo0NtvMOepr1MhPwzXZpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769744416; c=relaxed/simple;
	bh=/q61X7K5Ao1+PSggzDE0UDQBFk/GTp7Q2YX80NNH6Ec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pj/nNORGcRGGV+wxeWa5usNZzVL7MOIwbaUeVi4Q7/ccdv09yJHQEpYpEfg4Js3nf1SDNikhJJYhrdyYva4wr8kbRunK6/1jZgVx22IEI1dXJF90VPzdjkO15XvXxlmrK3YtEaeyMEKmCzwxKpO+JmjJcxGYdzbp3zvn3vcNVE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0IwKNwg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0IwKNwg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F125C4CEF7;
	Fri, 30 Jan 2026 03:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769744416;
	bh=/q61X7K5Ao1+PSggzDE0UDQBFk/GTp7Q2YX80NNH6Ec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y0IwKNwgmwuWNL/q9C6bZTPiJEPCsNwAbzWYVu+IgRNs5B2PquVClRJJVX+GI1og3
	 ZrlScpgV8RnMJZpI+l0fzGBqd8v2F6nJp/ezBioqsqSNGXi0/KJlFLm46bqHRMwHxj
	 srtrfusY86Aibms6T2xskamnrhK8mr0P6LknPVHU577e5/R0wD/BAO67zIg+TjM9wx
	 xLls3F///RnP8fiRlt39umEN6bYFrw/WAJrRKyqY5tRzo2AwwaBapWcwhlX6mrlMpY
	 vJHQ9UpfApeYPmrLxoxoG+H2GCR7GqAtJVmnWVQy393dRohMBpvm70HJmvYSPR1V30
	 3dpum1gJFhl3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11AE4380CEE0;
	Fri, 30 Jan 2026 03:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/3] net: liquidio: Fix memory leaks in
 setup_nic_devices()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974440885.3161630.1867982366440159638.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 03:40:08 +0000
References: <20260128154440.278369-1-zilin@seu.edu.cn>
In-Reply-To: <20260128154440.278369-1-zilin@seu.edu.cn>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kory.maincent@bootlin.com, horms@kernel.org,
 jianhao.xu@seu.edu.cn, marco.crivellari@suse.com, vadim.fedorenko@linux.dev

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Jan 2026 15:44:37 +0000 you wrote:
> This series fixes memory leaks in the initialization paths of the
> NIC devices.
> 
> Patch 1 moves the initialization of oct->props[i].netdev before queue
> setup calls. This ensures that if queue setup fails, the cleanup function
> can find and free the allocated netdev. It also initializes lio->oct_dev
> early to prevent a crash in the cleanup path.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/3] net: liquidio: Initialize netdev pointer before queue setup
    https://git.kernel.org/netdev/net/c/926ede0c85e1
  - [net,v4,2/3] net: liquidio: Fix off-by-one error in PF setup_nic_devices() cleanup
    https://git.kernel.org/netdev/net/c/8558aef4e8a1
  - [net,v4,3/3] net: liquidio: Fix off-by-one error in VF setup_nic_devices() cleanup
    https://git.kernel.org/netdev/net/c/6cbba46934ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


