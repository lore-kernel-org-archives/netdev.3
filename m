Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6883F446BF2
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627438; cv=none; b=ESGIkCxTM2FeDytRjzR0x69D4fKH9UXNfgRiqkOM5LBjw7rsR6aPGpCFnGuTjjC7NYkpZRWYhB4KDYehpEilIXRqjHwU/3gRplpww3nk2WFvcy3cIkyio6dSeK1CQlZbq3RPkmaaQHEQO5GqYzmGIwqMLYQA5taopazpZqeuiQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627438; c=relaxed/simple;
	bh=64wVYSusFqyoxioPaVKonxUPyisLtaTz0pS3JPiNKAM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JtScxLn7F0Et4gUIrHn+QYJzOTP6UMn60KzKQV9T0BCrfIkphXT5xvA+xAixQBDq7mQbtdPUd8RxcbLP8rzM4dD8A06XciT61hNnL1VphEENHNTxWBPaDo0jnZwquhcmwPwsQbmOeL6CmbBkY1UKTc+uZjxceRt9vx9l9X3JlNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzH9ItDW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzH9ItDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179B01F00A3A;
	Tue, 21 Jul 2026 09:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784627436;
	bh=hGT5xoWrmiQ44gdhFXz3CwNKFTxADBc7Pi2WILPjmWc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YzH9ItDWCVM91Ge7zuWSoJyULu3a2mBPyXJMFxjSHn94XoNj97txJkkkEBieRspXT
	 pRCF5iED29l22HFZagY/lzZA4/mtTpwDFQkNYYGfgEtZghNyzNaBdFuNNDQtOcMnMP
	 WCOgxIXFLcwpUHPoS30Zr8wnPUDrh//s2RRcrk0RCrOFmKtybOcrfyn20A+2lRQe4P
	 CytNCnCR+K5obx/Rb3DL4ez5bhuGKMbPSLRZwGTDYjI5lNmXGhZfN2yxMHN0pA37C3
	 vjJmfq5OFDh0YDKG7tJ4peRF9gUFqim978SnnttcM5MmMb9ydZKozB8B+8IOr4DyiQ
	 Fn5W+nlC/vEZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199F93924A4C;
	Tue, 21 Jul 2026 09:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: skbuff: optimization of net_zcopy_get()
 call
 in pskb_carve helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178462740565.192123.6703104179588475034.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 09:50:05 +0000
References: <20260708055454.9167-1-luyun_611@163.com>
In-Reply-To: <20260708055454.9167-1-luyun_611@163.com>
To: Yun Lu <luyun_611@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
 kuniyu@google.com, willemdebruijn.kernel@gmail.com, mhal@rbox.co,
 bjorn@kernel.org, jiayuan.chen@linux.dev, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  8 Jul 2026 13:54:54 +0800 you wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> Commit 98d0912e9f84 ("net: skbuff: fix missing zerocopy reference in
> pskb_carve helpers") introduced two calls of net_zcopy_get(skb_zcopy(skb)).
> In fact, skb_zcopy() has already been executed once before. When calling
> net_zcopy_get(), skb_zcopy() always returns skb_uarg(skb), which results
> in adding some unnecessary instructions in skb_zcopy. So, change these
> two calls to directly use skb_uarg(skb) instead of skb_zcopy.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: skbuff: optimization of net_zcopy_get() call in pskb_carve helpers
    https://git.kernel.org/netdev/net-next/c/b9ecdfda4d48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


