Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643FD31AA87;
	Sat, 19 Sep 2026 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781476; cv=none; b=qq7zICMU0NZ7cXXPVHrzjk1ey2Tc5Y2HIuW0hE135tcHJ2q4XwY96/TG5jL+mHsBIqGJqX/oBpu2uOKULmrbtC8RwcNmNX6r5ltwJ4TzYrzxYFUx9wTiwklpkMDrz9N2u4thRQpTi9c32Oia+miluC7Pf+1M053pcvYYCaEFcEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781476; c=relaxed/simple;
	bh=CDncj8uZF8PBFF51V6NDl+GZr/esH28R6fPyz3lf7oI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cK9zIe1E7racJYXCQpmNIAX3Wt/bLMQYS7L3A1ta0NtZGcg16DmMgFSeTmRyHOvpLyYUDjHghcNtRjG4S6skFcGbkwk9FcrVeK6AEejtwgZ4LK/sHSDoPeKnSbCymDpV8qcoQ2acNELzdGxiOsars9RpP8een51sMBxsPfiiLTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5vKgxM0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5vKgxM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6A51F000FF;
	Sat, 19 Sep 2026 01:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789781475;
	bh=9dOm0uUee+AnD33owxqepXOHzUDyD8peZGqY4eHsNFw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O5vKgxM0TTVTufanlOxvQE9e0xxcC8JZUBZGOW6gw+Y5qyu7O950zboIn0a5l1CjA
	 kdZyhP+e085oHfMVW3JEZSDJNmDCB+GR+ZQcCJOn1Q7w2l248F6GypgGkKwJ4GqZx0
	 8n0TyYWhNegNh4j2vZcjTq8FwHSMVW86FyJQv4ioW6LN4q3MfedMx8ZrcChemRxdUd
	 XwcwFI8bYdhRVvtYkhVhz7I5D8g2+zAOsUTds4bb1kgCLbz3m5RK4ZXm1EFnxg/Ej7
	 CtOAvV/gdOy0wrD9RcB5Iz3MRYOndF9W/HHqkwqL+EPk8iRqdyvYcgOE9H9k4n71vt
	 R39ECR9uERVcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19721381197B;
	Sat, 19 Sep 2026 01:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: motorcomm: avoid unused variable warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178978140764.1221945.7332803348671426184.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 01:30:07 +0000
References: <20260915200148.3523045-1-arnd@kernel.org>
In-Reply-To: <20260915200148.3523045-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: mmyangfl@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 arnd@arndb.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 22:01:30 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The 'priv' variable is defined before an #ifdef block but used inside
> of it:
> 
> drivers/net/dsa/motorcomm/chip.c: In function 'yt921x_dsa_teardown':
> drivers/net/dsa/motorcomm/chip.c:4229:29: error: unused variable 'priv' [-Werror=unused-variable]
> 
> [...]

Here is the summary with links:
  - net: dsa: motorcomm: avoid unused variable warning
    https://git.kernel.org/netdev/net-next/c/e3bfd25626b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


