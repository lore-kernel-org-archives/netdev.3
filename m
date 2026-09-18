Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCB73368A2;
	Fri, 18 Sep 2026 00:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690879; cv=none; b=cbV4xVgLi59kfiZC1aTurh+4jxrUvrXpxZUE+GEGPObHmpQ0ou+55M1q+qd770AlSfWaQseYRgVeRK6o9IxbggK90J9hgXeKsFdk4iNsOKd/Ssu3MwmdlwaeiN5J18wutUSfCzOqun9+KS1tGgs2vi5oymydpiiXFOOwWMeTIyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690879; c=relaxed/simple;
	bh=ogxIgiu+re9qjFRWo3Zk95wjf958Rx/4GDF4MsgOMhI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ds3SljiJ+eD+0VOexqERtb8OFW282yK4hPcMZWIL3pVWCWh+GfvtQDgOXGUzkeQuZl4fNLQTNWOKlEKrvDLH8wLAEl4YfJi4bihxyB6qWLipYljhk/YJTZ9UCwUFAmdJjzjIVskuW6AuRUZbj5KKtUwaKlkSKfvaLAw6rLLxtzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFm/pet7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFm/pet7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2D51F00893;
	Fri, 18 Sep 2026 00:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789690876;
	bh=zG2gTwCsuwbIA/IuvMtPEJatS7OpfRzJIZ1SCCCdBMI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QFm/pet7gC9Xb9EqPHHfUFD+7AxLSM6Q7sGUOhIWcKyirSGOXUTxYdfldmE5v8aMu
	 3K/CxmoXzt4rUcmQzmq8x4EQbQkmd9HbA6QDA6NQilZNnNHLg/E6Lnjg+bZ1ALcK6G
	 qmXowDNW822Qv5lT0aMhhqHRQF+2Zs4TdcqE5RJ24EnO3LOYaiKXWVsg71x9WzgKb3
	 vox1ThAdvn8ZhRi40+Sk4sqitIQ7WrC4A5ILuzFqo5Fzc2e1eymrpvYPnA6KCn8Rxr
	 6NIFY2tmIwx8+Rbf+89VBTYiXpUgZjyxAH6hKFFcRVEDw7BXOMSpBMCPW60qGF8ZOR
	 VfBDDof9dITog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568AC380820D;
	Fri, 18 Sep 2026 00:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] docs: ethtool: Fix bracket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178969080988.193949.15966401895613459061.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 00:20:09 +0000
References: <20260916123458.314458-5-manuelebnerli@mailbox.org>
In-Reply-To: <20260916123458.314458-5-manuelebnerli@mailbox.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 14:34:55 +0200 you wrote:
> Add missing ')' to sentence.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
>  Documentation/networking/ethtool-netlink.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - docs: ethtool: Fix bracket
    https://git.kernel.org/netdev/net-next/c/35a4b983c511

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


