Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C39D331EBE;
	Wed,  7 Oct 2026 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791337209; cv=none; b=OmD0gqozeZ6M8Q3Hq9rT/cpUaTBCbDKqFcRCD9WD6OAmlhbTL9MB78c9pZ8ebE56wOHyLVETXFSmM37PW0jCZDgU/En/EeWwptBomxlcP6dTfC5YSuIv6h5I3gYG8ByGXDuYEmR9csXvLGpOS2Za72cdrdwMb2pUwIsiIKZFz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791337209; c=relaxed/simple;
	bh=gl3NLMhzG4ZJ2hpN5pvLu07cTdPxnTo5DVJcZ9eSCPo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OUtKFcFGQftgUxmlT0rTNAgMNSAucHIRnaCdLoir6fyXf9sNuN6P9hi8O/XSXJa2u3/Mzzyw2pun9DWMXJk8iuo0Xr3pSmmxeF/TK+sN16otTraonc0yBVQ8BYyl5Yb7wNjU38hgNt1sQGyIBJ1b8zl9Wi61NLPMpZuuJZpFrMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVrlaBls; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVrlaBls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083BE1F0089B;
	Wed,  7 Oct 2026 01:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791337208;
	bh=eOsZ/5li77NhFabxJui2AMQWzUGT8sRMZDrd4AqFGwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oVrlaBlspl9GeqdGJRq9DHBClW/s/h5Cj4TVT69yadC9mILrDYFf5owR8I1FT34xk
	 ViTblOcgWX8CYHaU035ugfTSXhyh2S0min1bp9hL+NZ+OX6L1B3OoUO7jdpZNJ9SD+
	 R2zwlFpK8famXFsDyebNMAqv/m2GaCotkp4vjzzlhZzH6XlGOVctmJ1A5Zz8wvsA90
	 vOiItPObk28ZmWBOH5Xu6CUgjgTA3scWq8p8/ecSxV3mBg+yhjdhdWXZiIlprJEIVm
	 rqGkRQ/cFSyFWiKMazwJy61ZnkuHQWr2SbTHqc2IPMaaRx4uquIwTLAT7/nKp6Lo2W
	 8WQ7qbax5srUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F153E3806541;
	Wed,  7 Oct 2026 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] bnge: Fix error-path and IRQ setup bugs in
 probe/open
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133720678.2864088.7645471729072398785.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 01:40:06 +0000
References: <20261005121704.227866-1-bhargava.marreddy@broadcom.com>
In-Reply-To: <20261005121704.227866-1-bhargava.marreddy@broadcom.com>
To: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Oct 2026 17:47:00 +0530 you wrote:
> Four independent fixes for existing bugs in the bnge driver's probe/open
> path:
> 
>  [1/4] Unwind bnge_alloc_core() incrementally to avoid a NULL deref when an
>        allocation fails.
>  [2/4] Require aux_msix + min vectors so nq_nr_rings cannot end up 0.
>  [3/4] Treat an irq_set_affinity_hint() failure as a warning, not an open
>        failure.
>  [4/4] Clear bd->netdev when bnge_netdev_alloc() fails so it does not
>        point at a freed net_device.
> 
> [...]

Here is the summary with links:
  - [net,1/4] bnge: fix NULL deref in bnge_alloc_core() on failure
    https://git.kernel.org/netdev/net-next/c/cc7a4a3138a4
  - [net,2/4] bnge: require NQ vectors beyond aux reservation
    https://git.kernel.org/netdev/net-next/c/f94521b9d407
  - [net,3/4] bnge: do not fail open if IRQ affinity hint fails
    https://git.kernel.org/netdev/net-next/c/dc9a69f4d853
  - [net,4/4] bnge: clear bd->netdev on allocation failure
    https://git.kernel.org/netdev/net-next/c/21162b65d468

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


