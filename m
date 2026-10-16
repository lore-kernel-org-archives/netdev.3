Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672EA396597;
	Fri, 16 Oct 2026 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116615; cv=none; b=E+WcER47IN7aMp8clQl9hSAZR5iOXJNnbZjx9WTbSNNBz4YGSxAFkZJiGBvUoql9afpoE/QdI8fXav6JYQqt3VJI6xRvrOK7iAi0Em66JMygKw6rJI/XeKR1T7KwFd64ycB5Qi5F8qr51JCzhaoby0Yq/OzzKWnVM08eAbg9af4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116615; c=relaxed/simple;
	bh=HDcNXLX0ebqLfIIIZAyYCmZu2RHW/htp+k/tD/VkSug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WHb/R62NOO5hv4pzCEpG8Ob8h8eeXiIdfiAIrZfwWFR+dy3Njy9S7Q9x/wDexj7FOKp3350LAt0ArbWvBgdkrCu3g89PRpHYejMjxn3VwMluS0hoCVlEJGS8Ta6GfWfQVGuz7AbhNW/Mbt2gDFnJj1+L6yygOnpapXVJjTSkeAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5arWOq6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5arWOq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C881F000C4;
	Fri, 16 Oct 2026 02:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792116614;
	bh=/8G0i+JZS8AjFlkfyzHRi4ZZaTJKWSRbfygBayHjiU8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n5arWOq6fi1EMOskQrRWtoOCgoZrgdaRpH+eNgXD8hTTPhFWeWf8WHqjVSXvFOc32
	 MpVtO/oXRM+YnRmQmxNo0EKTSmrW68MyLrhJfPdymR6eA5yeXwHmTZtdGpK1VwF3Ps
	 KN1i3u/b2JDkcyfrhx1mj3zeJUM35O/9WhbCMUMzQP9h6QPljJZo9OHRiookL07W5d
	 VVYlA3qh+YP8NzygkU2jbM/D6Z0FryV9rREL9IS6HZ0v0yrrqKi0k1NzmTkQ60DKqo
	 QSVtHFAdk8y6rkWtGa5X+lnDOGfkW70KQ3OMEtMQrGlqdPJvoPy8gnuVs/gZLf4ud0
	 yoVXxcNNiTdHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A4AF3808209;
	Fri, 16 Oct 2026 02:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] macsec: check for duplicate SCIs before
 registering the device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211661277.15365.8704541160200567615.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 02:10:12 +0000
References: <20261011-macsec-early-sci-check-2b1f06af193f@gmail.com>
In-Reply-To: <20261011-macsec-early-sci-check-2b1f06af193f@gmail.com>
To: Haseeb Malik <haseebulhaq55@gmail.com>
Cc: sd@queasysnail.net, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 Oct 2026 21:57:11 +0000 you wrote:
> From: Haseeb Malik <haseebulhaq55@gmail.com>
> 
> macsec_newlink() registers and links the device before rejecting a
> duplicate SCI. Registration can emit link notifications for a device
> whose creation ultimately fails with -EBUSY.
> 
> The SCI is already resolved before SecY initialization, so check for a
> duplicate there and return -EBUSY directly. Remove the now-unused unlink
> label while preserving cleanup for failures after registration.
> 
> [...]

Here is the summary with links:
  - [net-next] macsec: check for duplicate SCIs before registering the device
    https://git.kernel.org/netdev/net-next/c/de3ef6921c00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


