Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A49455198;
	Mon,  5 Oct 2026 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791243018; cv=none; b=k+A6MT/lDDuRvqSLchro2TNJgwr3t0Eje548Q3JEJTDlR7TIo/pbYokAps+dQoB1VYFxFAjk8aiwUpoFgdGtx1kBLd4f/reRnRU2zzMxCg8S/MfL6tPO3wTB/qiCqVhUr5Eq7F2MFIh3+/qOezCA5kpUHof6sJUag/IQMZWwAaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791243018; c=relaxed/simple;
	bh=QIwvPXcQxa7+G/vFqdW4jA7UWDGyGfxK3EAoSLTHVO8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cAIwD1iGQsRrxv6qZe5J5cFz9VQRhPKoU2JcECOOUIj6ln9RL/WmX3nF7YBgatbGzO8DSPREjuiX7cAfPDY8DJjXZ7g3iic9aHZjbAhTFidIV9oITWlK6slbMZSgw6/bQo6Ylc42YCyzL8eaVoN6y/Dh0Qkhl1gmskwYyzx9Peg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5/nvrDK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5/nvrDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E5C1F00893;
	Mon,  5 Oct 2026 23:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791243015;
	bh=/NMHzcTrsi/FxdyvcZG+G4XA9kpbkZrKF1IZwYI5o0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z5/nvrDKkRuCzLJ3A6uBTtupg97b1rhTpw2ubVYsUSmxeKUP2nYxG6Wply6oEXqIO
	 e63NoTdgNuMpS9uQTQcUPKERBvEgV8pjHX0/xW6w1F0T7RQMHsRLr/w4qiIQSx5NS6
	 LLQFNEl+eQUBEt6oPa0U1+jinFcOxYkkSpUKzhF9N9Iwwbz0LRQOJBZ9Ogyn8SAeTg
	 4knDau1/SFz3pkZpM5Va0cAb7d8gwjVviO/pAagkZ1fjLEnjmlBuwre5v0sucpDuzE
	 otd0fJp2XWv/vDOvG7gatwmVg3ybHtRfISGHAHC1NFl55KuoD5J+mbHpXgVRbob+nj
	 iDBcsoLG0tc9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1423392667F;
	Mon,  5 Oct 2026 23:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: dsa: motorcomm: Fix register rollback in
 LED
 setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124301369.1937173.18327578726103515612.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 23:30:13 +0000
References: <20260930141151.3973221-1-mmyangfl@gmail.com>
In-Reply-To: <20260930141151.3973221-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 22:11:48 +0800 you wrote:
> The LED error path writes back a stale snapshot of the whole words taken
> before the class device registration, silently reverting LED2 state of
> sibling LED groups already registered and reachable from sysfs. Although
> the odds are very small, fix it by reverting this group's fields only
> for correctness.
> 
> Fixes: 9af9a8168213 ("net: dsa: motorcomm: Add LED support")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: dsa: motorcomm: Fix register rollback in LED setup
    https://git.kernel.org/netdev/net-next/c/1a2dbdb6602a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


