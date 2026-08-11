Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082C3296BBC;
	Tue, 11 Aug 2026 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457458; cv=none; b=cZgd410EmJdNB+zsH36WamMR7mt27wcK39/NWdR6nKzvMaQyDvA/gLIbW09aW5RsYymLKDZ1wqsS35yNjYgISJ4R6osQ8Ygk1/o4/KvQ0slm+BwtInTKK+X7GnCqw6RsDfA3sS8QYETGYFbYArbNIy0IxAlLTwL9Ekqh2wPyB8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457458; c=relaxed/simple;
	bh=aySLczZrbdnTv84vLhd0Ijnl1WYoO+REctPDwF7an7g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UE5WN8DAd9Ii8/pF6DiBOQn7OarqqzJp2THm/6u0NGN64hW8sBRioMouFFWhjkaDsmEHdpmFkFHFCdwSxFnakEycnKPtKBYeRBnsEQfCsTh76Ba6kjDJvkvX+XYOrOuf/q4Rmjqk1ZRuhgm/HUsi0xHjxrm1TblcL/tbqKCAh78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELfImg6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELfImg6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783041F00A3A;
	Tue, 11 Aug 2026 14:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786457456;
	bh=nasjEMSyoBLElEEnQnZKW1mNwe8Dww6p7Q/pQmaC3nI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ELfImg6HlEQORdpoJu4RFAOqldKsU8a/Nf61CQrhWbK63+eCrb/HZo8dffTYs9oA9
	 K+4FUyUbVazucFM9RKKvjYioAdFbcxFdPr4/do/vEAaHzk+FNCgYAAJMvhUTMWWvIe
	 oDG+4MukZ2Xz6bfbrekjDwrMgloIxRQ9IRoaRIDHhA0R/JX9xUJGLq4rjg1cskYeus
	 gyxTCySIVriKKdVnwGglIFvpYQRnmydk5yd72gkSxK013cnra7Aaunhgoxy0YNcAyK
	 W+mZAtCusCri31dAFsrIIEksr/UPqIGihrX7hSjv1h4IfjuhLjLJPrNzZe7S0m8v3J
	 HrtI6QltLYmTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09C83810900;
	Tue, 11 Aug 2026 14:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] net: hns3: some cleanups for hns3 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178645741239.541422.2419238515063843223.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 14:10:12 +0000
References: <20260807095435.2959246-1-shaojijie@huawei.com>
In-Reply-To: <20260807095435.2959246-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 yangshuaisong@h-partners.com, ningwei15@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 7 Aug 2026 17:54:32 +0800 you wrote:
> Patch 1 sets msg->desc to NULL after kfree to avoid leaving a
> dangling pointer in a struct that is reused across loop iterations.
> 
> Patch 2 adds the missing const qualifier to the reg parameter of
> hclge_log_error(), which is never modified within the function.
> 
> Patch 3 uses the txqueue parameter passed by the ndo_tx_timeout
> callback directly, instead of iterating all tx queues to find the
> timed out one.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] net: hns3: set msg->desc to NULL after kfree in hclge_query_reg_info()
    https://git.kernel.org/netdev/net-next/c/4f20c628b62e
  - [v2,net-next,2/3] net: hns3: add missing const qualifier to hclge_log_error() reg parameter
    https://git.kernel.org/netdev/net-next/c/b8f554e13899
  - [v2,net-next,3/3] net: hns3: use txqueue parameter directly in ndo_tx_timeout
    https://git.kernel.org/netdev/net-next/c/f57b277e8b6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


