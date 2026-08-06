Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AA7391832;
	Thu,  6 Aug 2026 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035097; cv=none; b=bG1n5yA9mfZQmEP8Fj1tFuFVm/GeW51Xdf+GMyTmhgoizyycMXvDC2NqS6VSloW3ZKjucdq0VPUbOgMfAbGI+n50VOMFEhMVNfm0pvTjeLsTIPRjON5bycVgb+4e1fJEvHsh48HJTq3QGDUN3h3GA4cV8fml8Bf9dNN9gCcwgrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035097; c=relaxed/simple;
	bh=MWJeOH8vn2KUAhcp1V4PWJltlmO1q2P6283shRBFunk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XT7BSNfrrQdjzZEoeox6oLKqQIbd0m7r5PD/ZUGYMRovwAVbBfJslRjH1Qb0kl9d+AiIla3uiog1EbXQoEnqms0SV42YzmPIdXjgGM8spWqvqkqd393itbLP7uWlErhGaTtyQKBOlN7xHmRwJ+lW8lapbUDEVn+MAOTVj0xexIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InzMADQ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InzMADQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159C51F01559;
	Thu,  6 Aug 2026 16:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786035072;
	bh=Ge6vW+VAKBkluuh8ppKhoxLT4wPyxl94uMY2J/QsASU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=InzMADQ6RMRZeULReddHdqhgzATCTSYOwBeUyyf6eAZNwzJZimukPDfa8RxBiEjw5
	 Zso+ODFh/pJ9EKlHCEd5i1Ib/kCsf1fqcw5z8vEpYrTVKt3E8YzdrSjCKOIwRK4F1Z
	 6CLNa2qEZ1ZOhU/XGQqUt3Jyc0DdbRJo5fWNAP2TCq9Qd4iOss5fpPezf/RLU+swk3
	 hZTe+z5I1IZHDaMjxKHR6eAlL03WTGsdVM85OyMHtX0vbE4KPwyTNtGIw4qACe59mF
	 XJyy8lk2BCW3+dw4BvQ4esleHIWaORwHoD1y2IluC31QT33nCA4frVzriWr249wgb3
	 1zIX9qm+VGcNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939B6380820D;
	Thu,  6 Aug 2026 16:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnge: Fix resource leak in bnge_init_nic() error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603503113.1375455.14546971587248050913.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 16:50:31 +0000
References: <20260805094022.15487-1-bhargava.marreddy@broadcom.com>
In-Reply-To: <20260805094022.15487-1-bhargava.marreddy@broadcom.com>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
 dharmender.garg@broadcom.com, rajashekar.hudumula@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Aug 2026 15:10:22 +0530 you wrote:
> If bnge_init_chip() fails, bnge_init_nic() jumps to err_free_ring_grps
> and returns immediately, skipping cleanup for RX ring pair buffers.
> 
> Remove the early return so execution falls through to
> err_free_rx_ring_pair_bufs to properly free resources on error.
> 
> Fixes: 23df6aebf803 ("bng_en: Allocate stat contexts")
> Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
> Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net] bnge: Fix resource leak in bnge_init_nic() error path
    https://git.kernel.org/netdev/net/c/bfec39ff1484

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


