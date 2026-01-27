Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A563126D0;
	Tue, 27 Jan 2026 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769517615; cv=none; b=KfvuLbKALn3bMT2Tz+0ObPBghObiw2MHgl8+qtbfU2KMAJnAG8zP7DTYLbYMz+uZM2GmM2vky+wv3eBuMtnNpYMyxQgO/LS7Q8y3RtmlzvKH/UGt0Lg1aN2+9u6mmmXWi6Pzeg1zf9tEz0qWHWfkg/UXYKa7sIb11drrbSWdzd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769517615; c=relaxed/simple;
	bh=Hg+9FddLEEiU8/KdKxY9PLW/K8IEVHC4s019bmJwjIM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W6YIywdJW8XlccJlBELv/Wlz61w8lr0YUJjvLQ4qm470sxXy45InOfYbe68cK3OHD+tjFk5Gq2IfGkiZy0afi7rF53UTnFGx7R/xlL4zNbteWt0avCkA1ATIl+BZzk+iQqf832x+7fsNr9Z2VzRoQGVKqC/5HGziEBtijMoa1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hixQ40Po; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hixQ40Po"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831D5C116C6;
	Tue, 27 Jan 2026 12:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769517614;
	bh=Hg+9FddLEEiU8/KdKxY9PLW/K8IEVHC4s019bmJwjIM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hixQ40PoCRSQfQ/Jkc9r3q1NoIJLiuPIS6B4OnI9jo8EWOyffMzm/p9zaKCxe6u6e
	 WaIqhd3J3xYsNS7TU0sxMbpF+0r0OVrOxCXpkfYDqCm0BTE54pev5lF6X/l85TqKCj
	 KrfezeYhaORrFUfRI8Mzcb98Q7o6UtfSHySAgA3QBGuSaS2e83exAF4Ni0H9tv07M8
	 iZyH65z9gjIM4fiarM93n27tE43jMFULvZo4mWKhsMfpsH31gGjQE/65msfeS2gYng
	 qXG4QXuqn8/HfmLwLNbWtdvwekp9txHXt6wsZJ4P5tjYUuquOStqkVSAwmjvcWE8pS
	 xDTsUGZRuZ4oQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8C8D380A97D;
	Tue, 27 Jan 2026 12:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] extend bit width in the flow director of
 HNS3
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176951760860.828343.8668263609881786843.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 12:40:08 +0000
References: <20260123094756.3718516-1-shaojijie@huawei.com>
In-Reply-To: <20260123094756.3718516-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 lantao5@huawei.com, huangdonghua3@h-partners.com,
 yangshuaisong@h-partners.com, jonathan.cameron@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 23 Jan 2026 17:47:54 +0800 you wrote:
> The bit widths of HCLGE_FD_AD_QID and HCLGE_FD_AD_COUNTER_NUM are
> increased to support higher specifications.
> 
> Note: The hardware already supports the specifications.
> 
> Jijie Shao (2):
>   net: hns3: extend HCLGE_FD_AD_QID to 11 bits
>   net: hns3: extend HCLGE_FD_AD_COUNTER_NUM to 8 bits
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: hns3: extend HCLGE_FD_AD_QID to 11 bits
    https://git.kernel.org/netdev/net-next/c/878406d4d6ef
  - [net-next,2/2] net: hns3: extend HCLGE_FD_AD_COUNTER_NUM to 8 bits
    https://git.kernel.org/netdev/net-next/c/6a0fc0ea61bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


