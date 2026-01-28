Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E29628642D;
	Wed, 28 Jan 2026 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769566214; cv=none; b=bEmBtZnE3Bi+eNWLX6TB7kWNg/36HK+5kQQteRDadUFXE/xtkOU4RNsy9aSXpc7FeTbAXe7W2lM5/P+F9VEgzxkYfebCAyVsC3KMNZIkzO1XMxxKMAWFBNRvLtRjlkeeCyOb//AYea11B0myjVShFPQBHpfyaKOc8zF+3Q0qTZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769566214; c=relaxed/simple;
	bh=P9+x6ae69OocDC7tZgPAxRGE+4ZLrlqW2KGARYrkbZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RK42K8C8qs1W4T0kbgwGQOf1dZwlK/GFcWgJyx5ouO3TARDpHoSt0CKDZ+jGvz5LG0BjJjItxK2gk6sujyk68Jxv+h2K0BCxVr7J6KTlqE2arTCbQUEm8Llr60fOcvD5KTMyU4fIVqlNxkFMMSdZxbhwqDb4CJkNnhGU5aJyId4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDesnRYD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDesnRYD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FABC116C6;
	Wed, 28 Jan 2026 02:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769566213;
	bh=P9+x6ae69OocDC7tZgPAxRGE+4ZLrlqW2KGARYrkbZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KDesnRYD6C1Ag7mMpsVmqrIc073Gpw6Y3XrfSkgj+NqloSulS2xI26n5sRSwDJnCg
	 KpcWRI3D3NFBaTowji5dzeUsXYXH0kuUgmug6F0nuSP8LDqW0PN0Z8+lmklpUzoJ4s
	 SdWeIzXJgP+frzPDlDmCCUTl8Bq1hOBMO2xd9aNGDSTQteirhg+9gJM/FajqnSAE3y
	 X5yTwIgKZp/vYbuSLJHniyYKKqL/FpDutCuhY88zzrkMuUPZLQh7HUTXk/eO63JkLT
	 diCeoMCY3cNN+yQ9+KhH8QPyfTToG4xCIbWdPQvpHnU4UQxRCT3gqgHq1SxEboHVTk
	 ufQcK4S8EUh2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8B5C380AA76;
	Wed, 28 Jan 2026 02:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: int51x1: use usbnet_cdc_update_filter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176956620760.1477771.10672522272069541234.git-patchwork-notify@kernel.org>
Date: Wed, 28 Jan 2026 02:10:07 +0000
References: <20260126044049.40359-1-enelsonmoore@gmail.com>
In-Reply-To: <20260126044049.40359-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 o.rempel@pengutronix.de, rmk+kernel@armlinux.org.uk, ebiggers@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 25 Jan 2026 20:40:39 -0800 you wrote:
> The int51x1 driver uses the same requests as USB CDC to handle packet
> filtering, but provides its own definitions and function to handle it.
> The chip datasheet says the requests are CDC compliant. Replace this
> unnecessary code with a reference to usbnet_cdc_update_filter.
> 
> Also fix the broken datasheet link and remove an empty comment.
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: int51x1: use usbnet_cdc_update_filter
    https://git.kernel.org/netdev/net-next/c/15e9abc27055

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


