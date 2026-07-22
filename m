Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D48F4399F2;
	Wed, 22 Jul 2026 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743849; cv=none; b=jcimXpOb9zOPfo1u+/bkljiitajesd9OdGK26d1WlfPZYahxzbXzCLCgRaH0jAi+0o65XraFKb9SiGHNVQA5kqkkA1FdO/RdDOYjOZcR+oAoxFc8oHpch5ZnI6Lq59ELo9LnQTSPtFHgmCja+BHPgYJLBEN5Hlm1/ir4oYvvx7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743849; c=relaxed/simple;
	bh=k2N/rUj8HmNt60UQps8oP0EWzT2kTkB7FdVLzUF2KG8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fcg82LoR1WoxTMOF8qZFbg7MwM52utTZLsD+HIZIXpyZWyll2rlwiei+gogMf6QP4i2H6t+njpNA4D4LtW9u3z8DpbdCGXVuLTY/bodAMawbUNcB6WL02LgnVYwbcU4d4nxXE43HT0tumpbbPu7t/90rZBEwDgHubi6D833Af6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjx7WrVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjx7WrVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A801F000E9;
	Wed, 22 Jul 2026 18:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784743847;
	bh=9gmwbfdN1XxOCMG9+CyJlaLkJl7tbV6S7Wv2xFdJp3E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jjx7WrVl4Tc+T27QvzMbFdMdpYmbKAUx+Xa7ZIzDe+eg7ZX3n9G1PVSdaZNTOnQR+
	 1xJENVqgVzG3psGkte6028T55f1g6ettR4PxF7mKZmQAF+CKDiPI0rM35GD+iwlUYP
	 RlEXrLhk9qz3B2w8li4Gv+kkR95Uf8IqXhinNbRzwSb2BiyU3Nw3UWilicjvJf3NVf
	 WO6tYffmhf/1oOFyGj9p+2ug4axnAN0MpfGiWfE3jRR53cZSYgAT4vUpppbBattoSj
	 tTF1+dHRn8krdUwB1n2ELJ/1v2GJ0H1d/Tdkh/qSg2ib8LLNcqg11q64wuHtmEQOf3
	 Y4amw07Ipy3EQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197B3380CECD;
	Wed, 22 Jul 2026 18:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add nci tests to nfc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178474381563.1967992.1709720639386325689.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 18:10:15 +0000
References: <20260721205555.1020513-1-kuba@kernel.org>
In-Reply-To: <20260721205555.1020513-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, david@ixit.cz,
 oe-linux-nfc@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Jul 2026 13:55:55 -0700 you wrote:
> NCI is part of NFC, so include its selftests under the NFC entry.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: david@ixit.cz
> CC: oe-linux-nfc@lists.linux.dev
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: add nci tests to nfc
    https://git.kernel.org/netdev/net/c/9545fef46d36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


