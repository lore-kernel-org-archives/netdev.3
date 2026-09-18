Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A331F2D8762;
	Fri, 18 Sep 2026 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690877; cv=none; b=vAtwV2ad4rQje98QrtDk43gA0uFzkMhjBKHSWkwjVkPhxVAqlEKQl7vctZhi5l2lAAIbjaRu8uppZyStEinau5TclH4SRwXijumB7BY9K4e32x5L+I1KBgXqas2rBLumPbyJO5DafY42w26Ad1SrcvrYVgHv1pYYhCVqQ8kGLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690877; c=relaxed/simple;
	bh=c0hbHtRV6PT9WDuzlQ7yVsaUEl2uDbXt//PGGg+IsOA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GxBi20bSMh14Wl/dgD7s6dXAMhtBiWPu0toA65SaU7QCl1m3KjqEba4T0+nB29eiOVjslZyIp09+LEngDSDXZey5Wfc2ZUivcC9qkxzdA86STvLkWZrZ1LRX7OExeqmsSbLVt/tyz1lJsbjJ17C6sSBtHS7ae+BcirRSe9d1u38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFO7YPzD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFO7YPzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3317B1F000FF;
	Fri, 18 Sep 2026 00:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789690875;
	bh=giuuaSHLLdvbwVIzTGsYBZeI+5GUEQY4BWAyn1vnv7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UFO7YPzDpfV7O/FP767mO32YfQen7drLSRjyGNnyjw7trBtxBsjWQcVy7VR6xciCC
	 u51qyBWrCT6JnHa1k5GwiZlsWgHqu+QQJV62tUmWOY8QM/30AhPYT2va1HZtJDijOW
	 sJn8YvwfdM//DkM3FvY+qkfnsrtWbWp9oHXVqe+mHaEi+6urWR/4J5bwVgtHOsE8LW
	 QGs/h6Hx8agoYenTF/EASx/z+NCj6oV69eXcoN9gyCTBM9HW9Hb+lZ6bkghKkcXg1L
	 otuo0xIGsMtFyt2nlQaJqXbdRUj/+g8RYDTgq1ravPv/kJkmqjlj/IZYPQStP8FtMX
	 zTlMGdms7TC5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A2E380820D;
	Fri, 18 Sep 2026 00:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] docs: networking: radiotap: Fix bracket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178969080863.193949.6456202227248004597.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 00:20:08 +0000
References: <20260916123458.314458-8-manuelebnerli@mailbox.org>
In-Reply-To: <20260916123458.314458-8-manuelebnerli@mailbox.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 14:34:58 +0200 you wrote:
> Remove needless ')' from code.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
>  Documentation/networking/radiotap-headers.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - docs: networking: radiotap: Fix bracket
    https://git.kernel.org/netdev/net-next/c/49969c37035b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


