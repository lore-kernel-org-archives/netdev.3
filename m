Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA472F8EB3;
	Fri, 10 Jul 2026 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692030; cv=none; b=hK45Nus9NCkthRZsOp/k6Xj2MtVbIlSW3fyTDZtcjm7BC/fPrQwrTSpv/H/lFaUzILXH7xmHLRe7mcHhP6rKe0B0MvBP58L3zRXaBqo4jVBK8pyaDtTZ6LdUtoyDdwHXek1gBShcyeOuVIS3NvNa2yra0bBCPkuTe/5WE73Z6EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692030; c=relaxed/simple;
	bh=5xl278SyMIeXe5hjqQOVoSesKHXlOLanCZzGWAf2Le8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kNGXfr8bvNkbW8NobSJvG4VifZbwba3DultO5/ZQA7wHJxlWuINdRXX7nuXa/o3+yrxx/fsQ7Z3mCLvjL4zEluA13rQOfYBOhoF1HmSSj6MbX6UlbQrdvC7ztYNTffu1aEg+nv1kgXmlGuYvGiqmPyWysqSlC2rK5q0WIKffsR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/RN9mgk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/RN9mgk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CC01F00ACA;
	Fri, 10 Jul 2026 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692029;
	bh=hfTSfVuhgjiaz3JRn5CsmJKebZiPr5216oywMdpMHXw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g/RN9mgkA0lZelzmXPeo+3dJPVUCv93XRvdZTyuQ/fnGvPkh8KsnZ/jPcDeMg1KqE
	 ytoW0fYdXl2WBSa8/WRPXTdZItR/Y/KDdfmhAIfe2fXe6yiyxKb7kPdj4riz7g5AVe
	 bXNcTxKSwJk0n28MvnLmcz1/ntTsMNO7cN1eCHS280vjTVeW2jdL4QOK4V2OSo4Lk8
	 Rw3PzGsycb9CXgZug4Fr/7wCT4aMQcNHHmnpqsnR5UZGOMcDMlcuqzUDizUhq7LOGB
	 qfUdXWwxMyXQPCbaV/iY928Q2PB/kUgYM3bPEAiUuASZ6QhuTWOzJkGNnt8tB4VTec
	 09EnUV+UKxLOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938513924F95;
	Fri, 10 Jul 2026 14:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: chelsio: cxgb4: Use str_plural() in
 mem_intr_handler()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178369200704.698057.2108068559084153307.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 14:00:07 +0000
References: <20260704121010.201016-3-thorsten.blum@linux.dev>
In-Reply-To: <20260704121010.201016-3-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: bharat@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  4 Jul 2026 14:10:11 +0200 you wrote:
> Replace the manual ternary "s" pluralization with str_plural() to
> simplify the code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: chelsio: cxgb4: Use str_plural() in mem_intr_handler()
    https://git.kernel.org/netdev/net-next/c/d5d7554052f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


