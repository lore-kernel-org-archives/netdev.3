Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FEB480974;
	Tue, 21 Jul 2026 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629844; cv=none; b=qHTGWikm/MqaT6INW5rBSbrjC0Da55ozUir6P73aSArP3Qlw5f6XEN3re7+3QQiCBfdKHIMsLt7i5t4ORLCLVlmSCKr86hDfrTDsqgS7t8A2ijG8o//qQfWz0PvbENzvVvVfxhCsZq4uGpKXgebKebeU3UlELAlpuKw3tX0xzXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629844; c=relaxed/simple;
	bh=Kp3sZWa7cncwR3PwDN2kJrzlJjT3+ruwHf4pKk1srHQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HxOUwzBM9q30WCsmezi2txjrQrEgPKjVe3RJcrc8eXlyvc9iJY4VU9RySAMZQf+Fd6b67muVdA5BGi2C9c7Xunn8c3ysNdOOm4ZBubpAuDc7X9oRfSdZi1B2gWZk1GXCzGLNzP845g3shKG/Sxd4uzLAb5n1yMHyLzw1j+ALr6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iERpubCk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iERpubCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF9B1F00A3E;
	Tue, 21 Jul 2026 10:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784629843;
	bh=8568EDCK/cdd1s6gzQoWulnraYmCuzu8OsyG+uagCIs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iERpubCk2cgEvQiUER5RzJU4kWVrC6WThwLZN9yUNzrFMnSQSnTpDWyVt/npWGu55
	 bfiloj8IwQvi1BRYg6c3Cq8pnU/WVrIfA9KBBlzu/P7VU8ZqjINj1ONPYj0NxFFq9A
	 AUsGWKQsKyEpyEmcvna3zk4G15Vg7tj3/J6z70cv0k1X36inEh74ds2nloo2Ovq8YS
	 Lh9hF8pqW7mKcGq+3EJyusmyD7sfSz1yruxdux4Swu0O8s7JB2k5k3W4uF6PTQsux6
	 dmaQ3FIG2dNpZGs4xItdrb6DBY8eGNW8F0Kov5k7lC1Wm7AjYZuds7bGWSYGj4CdQo
	 Ezs8MapAEUDVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A5F3924A64;
	Tue, 21 Jul 2026 10:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dpaa2-switch: put MAC endpoint device on disconnect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178462981264.215603.1388543545308107663.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 10:30:12 +0000
References: <20260708111025.749311-1-lgs201920130244@gmail.com>
In-Reply-To: <20260708111025.749311-1-lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: ioana.ciornei@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  8 Jul 2026 19:10:25 +0800 you wrote:
> fsl_mc_get_endpoint() returns the MAC endpoint device with a reference
> taken through device_find_child(). The switch port connect path stores
> that device in mac->mc_dev and keeps it for the lifetime of the connected
> MAC object.
> 
> However, the disconnect path only closes the MAC and frees the dpaa2_mac
> object. It does not drop the endpoint device reference stored in
> mac->mc_dev, so every successful connect leaks that device reference when
> the MAC is later disconnected.
> 
> [...]

Here is the summary with links:
  - dpaa2-switch: put MAC endpoint device on disconnect
    https://git.kernel.org/netdev/net/c/4c1eabbef7a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


