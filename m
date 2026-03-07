Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F052F7478;
	Sat,  7 Mar 2026 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772853013; cv=none; b=l+hXiVoWusWBcBHClVJSltfBXO4QcErGqQoBrWpXlkut4mINiRL+0z+7iovVNUtY4esXt2BykP6ed9/tFh7by0iTJ7y5vomxjdPh81fSaqLMr45wFMvVrVBq21yPl6GYjft2ply/JRp8EimrOrU415uqNMVTYxFxAJ+aWyOCnaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772853013; c=relaxed/simple;
	bh=LGnvdT1aKqYb2Uio1qV5MJ3C5YO/gKg/GDx5YXLRzy0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W6yGLHWHOswdw28p4gQqYWbRq2hmUYP/bGZOthBIsxhL06JsWSPNWilOYbhOrhaYkHSdtDSNZ+FthU9hTJJyo7r+I2ACKHFhNqgclyFZmzvaFh51bUt+5ew079NUxbVfwVN9HQcRv4c0iTqGaPo94ZMwgXvifj0jf7GNiOWM5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi6mLDZ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi6mLDZ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783FCC4CEF7;
	Sat,  7 Mar 2026 03:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772853013;
	bh=LGnvdT1aKqYb2Uio1qV5MJ3C5YO/gKg/GDx5YXLRzy0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pi6mLDZ3OKhmafA1CxPaLPBTbJqaj2d/JLhSaK0cAUzHS/5DQSZtmSAswMa+5ZoP0
	 oSWJEdxuotYjqTtIFoAW73whqbIAVAg1aAoJumSQUYbZw30wCjH8x21gOl3hEqDtT1
	 UnNiZWOxBsgN71IMP+Q5zF7oOYeLMnW9n+g/hta335qAVwRjlNSpMO1oXblW0YHlCn
	 sc3bFjlU1WGxERZwXxYoB6zuGrCwiDXOq29PhO7o7C5CtEpzP4VGXhtG2/PcFlbR2d
	 3jj3ISq3G+n+bb/y7SEcNN8yMRk6U15dAq4PsYq9+7lxFnM4Xx0SK+vEiqPellYyxH
	 irZOmfRbjieLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EEB3808200;
	Sat,  7 Mar 2026 03:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: spacemit: A few error handling fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177285301226.135595.13840950042647803809.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 03:10:12 +0000
References: <20260305-k1-ethernet-more-fixes-v2-0-e4e434d65055@iscas.ac.cn>
In-Reply-To: <20260305-k1-ethernet-more-fixes-v2-0-e4e434d65055@iscas.ac.cn>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dlan@kernel.org,
 maxime.chevallier@bootlin.com, vadim.fedorenko@linux.dev,
 troy.mitchell@linux.spacemit.com, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Mar 2026 14:39:37 +0800 you wrote:
> Recently a user reported a supposed UAF/double-free in this driver. It
> turned out to be a false positive (ugh) from a bug with riscv's
> kfence_protect_page() [1], but it did also prompt me to review the
> driver code yet again. These are some fixes for error handling problems
> that I've found.
> 
> [1]: https://lore.kernel.org/r/20260303-handle-kfence-protect-spurious-fault-v2-0-f80d8354d79d@iscas.ac.cn/
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: spacemit: Fix error handling in emac_alloc_rx_desc_buffers()
    https://git.kernel.org/netdev/net/c/3aa1417803c1
  - [net,v2,2/2] net: spacemit: Fix error handling in emac_tx_mem_map()
    https://git.kernel.org/netdev/net/c/86292155bea5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


