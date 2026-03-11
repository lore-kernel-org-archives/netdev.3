Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080A365A1D;
	Wed, 11 Mar 2026 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773196828; cv=none; b=MwuNx1KHyeJkYroUIQ8zlXOEW8qJZpCYmDl4BFlEZGT1YOpixQ30sqXKHJi1C0CzBluAzdzXwJ0AYmTunEfv6lgEREEoY6exqprEUxlku/794CBcBXU68xeE99v9sa/5g+itzWDj0fWenrbCNHD6Idwww2tz2XKWvwWvnqXxkpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773196828; c=relaxed/simple;
	bh=0W1/uqeN7s+y4BrnCTgH2t3SrW+mHp4U/yK6807QK9o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XF1TZfd7fE8sLGZiv/iHVWfwgWJ0uflUFPC+kQtgfndceUnMOlyIqCvw6MhMiW7IpDIAyvNmQdv+TmXnwWArpqbkr3HBKN3XQpCzhFtaP+G8qpHtDr+4hoy7Jf8d7vL18i2+aejAY1xmqvHqMMTCdRU59vMS7gCTv/fEHBLyFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubgT5aG/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubgT5aG/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA31C2BCB1;
	Wed, 11 Mar 2026 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773196827;
	bh=0W1/uqeN7s+y4BrnCTgH2t3SrW+mHp4U/yK6807QK9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ubgT5aG/he785w1wUzxTeTMduoldInc4R/nlPXMRvVg3tDdMQd7UWN7K8Jq5pUurr
	 pNCU6lNeH0Axb6K2iY40YKnfzoKAIHY9k34STmLiVMFlGobD51xJOe8OEBeKrw0W7Q
	 7Baw1FJlQyby8K0CeGeCq6CF+ps/ObfvA5KuGp6ZHJSoLZOMxFK+rkJX0AkvylctMz
	 i/sAjCcN4pankl8Nzb7JGlzkvOXjRAP7rL2XkaSMnGVMEr0Vji4CcKFjKZRAoJZKNU
	 pnB+k48KSGVNth18zgfOFhC3oduGEhBI9vPcjgM8WVw5BwZrCqfpzg71SHmz+ZPdwG
	 hxKvEmHXi9EDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE953808200;
	Wed, 11 Mar 2026 02:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next,v2] net: ethernet: ravb: Disable interrupts when
 closing
 device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319682429.3014711.13529379862945821912.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 02:40:24 +0000
References: <20260307095532.2118495-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20260307095532.2118495-1-niklas.soderlund+renesas@ragnatech.se>
To: =?utf-8?q?Niklas_S=C3=B6derlund_=3Cniklas=2Esoderlund+renesas=40ragnatech=2E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?se=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: yoshihiro.shimoda.uh@renesas.com, paul@pbarker.dev, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  7 Mar 2026 10:55:32 +0100 you wrote:
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Disable E-MAC interrupts when closing the device.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> [Niklas: Rebase from BSP and reword commit message]
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ethernet: ravb: Disable interrupts when closing device
    https://git.kernel.org/netdev/net-next/c/9278b888920e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


