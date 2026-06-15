Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E06C282F01;
	Mon, 15 Jun 2026 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553015; cv=none; b=jRFnTg2I0P1153XLOXmkUspXWszTgr4Vf24oexCQbJIsU93wqv2QAVfk+GX6maDZU9qHAlVc53KmbvywibbFt1+5/xm5yJPAuH6zks5WTPIeSlePz9+3zTPb2e1OZGNEeXXOnRpUhryL8wE6sAVqdUmfZ5rmkCv8KNQY+MerB+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553015; c=relaxed/simple;
	bh=SExn4EaZer1k3XF0mf11hKwKp5EhbxAxrIAM335aDTQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QZ1d3QYmoi1zZnfFFCEEtOA8YJonf5Ir0GFc7KneQSEItFPMNycE41J23nJyoZ5sksiBZ1XAyYbNqQsVafzSvEglqPDAw5LbjBz+k9FitavZnjXipZPePos6POBa4XnT4aqsbhTNUnd0rqK+7UXhVkqJWT6DrhcNr00p6WJMS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgMQ1POT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgMQ1POT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CC61F000E9;
	Mon, 15 Jun 2026 19:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553014;
	bh=yEe8kt08WvWXSp2RmIgx61ILSWIZUrmCJaKZ1TVV7Hc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PgMQ1POT2QItBiDMnTUY6Ty/KZEPZsw1l5V2OKvQm7k1NKg4NsxVidgOeNZ4kMUbD
	 MJWRSTbMrgO/KQZw15RKnrZ9oZgZd3i6IEPlt0GC0/X2eTxfmVZknioJ1YjMrVw4X/
	 EeZK6P85D8csbLDg6pt42twHY1+gQIEw2Q9YGcXazaftxajDWNTiCGeZD5x67EDyNG
	 rFAuRoqmCS678fOBIRKbXWos28tZt8Xodo3nGqiiAkq+H7g4ufzlP66h857ONiLfdl
	 DQzdg0bpt8dIU7EejJ+uxTb5f0oziEI6FTqwKER2onJDuAHuWZkU3LxKpHQP/fwA+x
	 BmoUmCqGxOCBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569033839A06;
	Mon, 15 Jun 2026 19:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] octeontx2: quiesce stale mailbox IRQ state before
 request_irq()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155300889.269508.15289919192491633679.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 19:50:08 +0000
References: <20260611160014.3202224-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260611160014.3202224-1-runyu.xiao@seu.edu.cn>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: netdev@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, amakarov@marvell.com,
 tduszynski@marvell.com, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 00:00:12 +0800 you wrote:
> Both OTX2 mailbox registration paths currently install their IRQ
> handlers before clearing stale local mailbox interrupt state, even
> though the code comments already say that the clear is needed first to
> avoid spurious interrupts.
> 
> This issue was found by our static analysis tool and manually audited on
> Linux v6.18.21. Directed QEMU no-device validation further showed that
> the real PF and VF mailbox handlers are already reachable in that
> pre-clear window and can touch the same mailbox and workqueue carrier
> before local quiesce has completed.
> 
> [...]

Here is the summary with links:
  - [net,1/2] octeontx2-pf: clear stale mailbox IRQ state before request_irq()
    https://git.kernel.org/netdev/net/c/f918554fb724
  - [net,2/2] octeontx2-vf: clear stale mailbox IRQ state before request_irq()
    https://git.kernel.org/netdev/net/c/0b352f04b9be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


