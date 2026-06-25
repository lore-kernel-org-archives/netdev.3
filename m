Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683AF36EA84
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 01:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782349752; cv=none; b=Y4vDRc63jOC0nPU5/plZ3roWTP8aRT8wtsHc+c9YfEspT/LH2x6bZ77dX0oWYLXDb+DTyb/DAPeU0fPnkdkVazAyO6aEKVkEBFfYrxn9xd9CnmieA1hPKMu8ukwVaQBxmwqkqZ2F0plm+R+hAsdXPmGBvVOfr/f3792jRTsPbko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782349752; c=relaxed/simple;
	bh=ZkpXOYZCCbniGiULM2JcZKLGb8v4UvA8NQhL2Gquzy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e7+/LlmNdhlG9eoPAsEMMNBhl/wXJOgjpW5SAIfaSf2ex5GlERM5aKAd7LN20y9zF5uXwUrzLPwrBqGrgZ4pWdRct0OibSDMhhuuJu3DSv3VzpuHJFdYF3O9coZTkdfdyPFzXk6DD7kvwbOaPrWBvvK9igrbI7tAEu6gmjYJvI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA4fsZWB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA4fsZWB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175611F000E9;
	Thu, 25 Jun 2026 01:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782349751;
	bh=SR00w6A5zWYfAEbQPEd3oeGOwxQRYDWbhdXlng9kzSA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RA4fsZWBhKQH+pZEDRRvOwuEaEU1/nCJImq0Nc5swcASjXbxlET8hsMugm9oPGc/o
	 h7DmlD+wjHPH6RdI4KJtCbjibTw5l66awjIkIMF6+g1zcFXn8K41eb/4est/xTGnId
	 KUdXMy/CZuSuuot3TBJZ43f61Ku0sDlgOWqgMJeG3H48ebvejO5bik4QkKLsIWS4fZ
	 9mIuKUTBwhRXvKcZPBNcMguYOuPW9Mldzcu0w9y56fns4B23j6Umy8T6r8oTHS519b
	 2TO902i6fFmui35Z7CXv+HP5FAZ4yYox1qbdp1nnfGvfhdhQspf1LAMgJh3+aO3taX
	 TALqNqVzaumZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9398F3AAA0F5;
	Thu, 25 Jun 2026 01:09:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] airoha: fixes for sched HTB offload support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178234973905.3045401.18000176756611441601.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 01:08:59 +0000
References: <20260619-airoha-qos-fixes-v2-0-5c43485038f9@kernel.org>
In-Reply-To: <20260619-airoha-qos-fixes-v2-0-5c43485038f9@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, win847@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Jun 2026 13:37:12 +0200 you wrote:
> ---
> Changes in v2:
> - cosmetics
> - Link to v1: https://lore.kernel.org/r/20260618-airoha-qos-fixes-v1-0-37192652157f@kernel.org
> 
> ---
> Lorenzo Bianconi (2):
>       net: airoha: Fix off-by-one in airoha_tc_remove_htb_queue()
>       net: airoha: fix netif_set_real_num_tx_queues for sparse QoS channels
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: airoha: Fix off-by-one in airoha_tc_remove_htb_queue()
    https://git.kernel.org/netdev/net/c/bfcce49c4aaa
  - [net,v2,2/2] net: airoha: fix netif_set_real_num_tx_queues for sparse QoS channels
    https://git.kernel.org/netdev/net/c/788663dd28e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


