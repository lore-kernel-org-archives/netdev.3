Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FCB32AADA;
	Wed, 11 Mar 2026 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190809; cv=none; b=H9B5pMgOp+aGRJrb6UeVLv+ApN3pQ+wRq2N6onnWXaJl1QLRxkODGk+8pjtICSZ1euKDI/5rKUgx2v0UugTQfrnSziifdmipoc/5M+LfQdyWfWhMzb7EmGQuDAR6Jw2i66A4ogDK2R/VnSN7Ky+OZlghiSSQDGTV6pZWCQILJNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190809; c=relaxed/simple;
	bh=Z5B6QH233c7ShAwjJAPSRORyRHDnV4ce6JphQ9I4cIM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FyEYVXdXKEJWVAEyIA7ZIIgcUoqJJYuRFeTFI1VILTFYYVl2vA+3/dPwHEslanPyMz3gwzKE+c8kBY3kHKSnWxfrPKYNcC8KwsB0bNq+dkFFPF0JNjls2tLHt+9CLdnAUo8VMyozKFbDL7j/tGWA1FDUj98IDuWUGLdxUbGQk0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+RfXlz9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+RfXlz9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B208C19423;
	Wed, 11 Mar 2026 01:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773190809;
	bh=Z5B6QH233c7ShAwjJAPSRORyRHDnV4ce6JphQ9I4cIM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X+RfXlz99bu2x2rIEapFCdCp7VVucqDZ5lHG8HcrHY4vHtEYKHN6YSK1WKNBaA0kI
	 v0wgymfOhfgqZ9C9gqr/YEa/1Nc59jBGPBuT2IMUTEme77+/pdJaC1qbVDCz7re3i7
	 Wlu4kgoarWhWLSB5IS6MMOg3j4/o8PriOiKIjh4seuUlDpdjM5mFvA9ufb8wf6fj6D
	 dIdeeHDybZEl2iJUTV7gToMlfXBrBU648iXtLzqNYKG49Z+ZRA20igImqVCNNp61qp
	 BzaAojXPGqbNlaCITxUj3iO6KmviD2oOIY2JtVRVW0GgVhTP8zfIU/NQEUs6wgyFGf
	 5a0Yzu2Lb9j0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDF13808200;
	Wed, 11 Mar 2026 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: macb: Shuffle the tx ring before enabling tx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319080579.2986475.15435780023283245328.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 01:00:05 +0000
References: <20260307-zynqmp-v2-1-6ef98a70e1d0@gmail.com>
In-Reply-To: <20260307-zynqmp-v2-1-6ef98a70e1d0@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, quanyang.wang@windriver.com,
 stable@vger.kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 07 Mar 2026 15:08:54 +0800 you wrote:
> Quanyang observed that when using an NFS rootfs on an AMD ZynqMp board,
> the rootfs may take an extended time to recover after a suspend.
> Upon investigation, it was determined that the issue originates from a
> problem in the macb driver.
> 
> According to the Zynq UltraScale TRM [1], when transmit is disabled,
> the transmit buffer queue pointer resets to point to the address
> specified by the transmit buffer queue base address register.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: macb: Shuffle the tx ring before enabling tx
    https://git.kernel.org/netdev/net/c/881a0263d502

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


