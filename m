Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B331B3EE1F8;
	Mon, 27 Jul 2026 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192044; cv=none; b=qesJ60UFMFfLXC3O29FlODx/q+EBNEiXfDHFyJJeuX/DWcW6k3BjGqlAWWamiER0XqZgeMqsRb54F/Lw2REIuEDq2tbgNu23eOO6/uJwNSbJ+iiihdfrFv2/wuaYpHTNf7+TWwjDDt+GZA+ByAqFf3vxI/qj9rAG33QkH0UDeb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192044; c=relaxed/simple;
	bh=wHxk9+3mVjXUsQGeKWKLwcGfT+SfuqwGHf3DiMG54rk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cEbz0FckddEFBoqJmXgqDfTdI5lRjbvGUubXpeJp/JDHFh+Tx+gQbYAvn/OZb0wHA6swgYuqYng0kKhWSxAI8sXPzsxnilwrcbUmAGDdIh/Yold+2CpyyxUUb+REX2jbG4KQGMl7TK63OCq+behaRJDYB5bw6adn0/NPvTyruRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbqRtiFr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbqRtiFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589EF1F000E9;
	Mon, 27 Jul 2026 22:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192043;
	bh=SchebKOkKO65O4I6Bs5M1xrcEz7y9QbfXV31y7ljMcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CbqRtiFr/ig6zhlRCfD9lf+Uuhogz+3ATZ3gyPK5DmCswCMDVZ2il2O7k9REhIcYr
	 xAxQmKljJKmfMP6a1DZpbm2T0yXqVtU105atw8tHLrURMeV1cRBre035W797alzwyo
	 eM+fuiBxzSFM9m8vAg25/kBftffl3xz81p1uIuxJCmRX+XMqPzbpm05O1B3M8+wwKP
	 Xonlgl61Qmst4ESLhmFqZ4eSxV3l8nLGo+DdoBtr4b+tjhCDfkFUwWo3+BVM/MaBNf
	 IiLKDxnps3ThNHUK+V5AVhFm6h96HTOrhoDoCA+bm0CA67I3lfuPuECoAJQbJeSZjY
	 KiEAYnaXpyJwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D089C380CECF;
	Mon, 27 Jul 2026 22:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tcp: use kvmalloc_array() for BPF iterator batches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178519200839.1443317.15594197813514802308.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 22:40:08 +0000
References: <20260716025102.118174-1-xiongwm2026@163.com>
In-Reply-To: <20260716025102.118174-1-xiongwm2026@163.com>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 16 Jul 2026 10:51:02 +0800 you wrote:
> Use kvmalloc_array() instead of open-coding the element-size
> multiplication when allocating the TCP BPF iterator batch.
> 
> Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
> ---

Here is the summary with links:
  - tcp: use kvmalloc_array() for BPF iterator batches
    https://git.kernel.org/bpf/bpf-next/c/fcf741584a56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


