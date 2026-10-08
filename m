Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A524748CD52;
	Thu,  8 Oct 2026 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791503408; cv=none; b=jCwTmqL9DrDIkEeplxoM2TiPUZYzYs8zBjgQIdbGxiqCyurjrFuwFgsfjRTKHFlMErInbWSinAytN43rDkjZuDe1iv652/M7sM7Dz9prbZpAv/Of28rkSmImbCbqWX9e1dTGxvE7M9Ywt5n8SYXvBEVap2QeEmbL0vglXA5AZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791503408; c=relaxed/simple;
	bh=CnrXVg3EKADT4ycuqQuXgz7bcIvhSWUcgtfEX418vMU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uPMcRzqns+oOiontQfI0A1ZInvpoX3UeqeuXmhAVRCw/AVsmcC0cJBwUPV/cQsIzkG2tq5JbKeHjtZuo5E5ZQJnkS5Vm/COEBDnlfOo9rSMVD29hJbr0IOonK3jNlzLF6ZGaieqC5zPZbIDC0C9K41qtAPbe4xx+Qrrmobu7r/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1C9Edmw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1C9Edmw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ACE1F000FF;
	Thu,  8 Oct 2026 23:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791503407;
	bh=tUC9Uhzl88Cor6FtCU9pZgUiLA2y9P/X2OsD8tMHB5A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B1C9Edmwa7VxGV33JFSqUmD1GK5YiwF13XN9mZ5JrXI5gifBuR2NpqtP5zTjbRQga
	 UtEsFIpvgxN3wh74pmrmFnM37tQ+6qUlzNmbdAdkvwHTvIcIW02AyMK0Y2LLYu1jF2
	 ieKw7IFkbbQwZVbuUmP7WZ0HDGtNlPdFSoUN8oLZSFrlK4xhLmApIw/N38qErxxlmg
	 16T4+jffnSVTSB207zvzJ+Rkdolm9bsS9yjCm05ws1uZtFxiZPhiWyNSJQrlQWYpBy
	 vZlaSj8wygXAd8PnMNjhBGIGFUcOSTJY0kdR3t5nLuJoalD371OG4U0/Iq+Zk4SqV5
	 rrxW5EesiABfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A49A380AA60;
	Thu,  8 Oct 2026 23:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net RESEND v2] net: macb: configure ENST registers for all
 queues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179150340577.483817.8454314628714309427.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 23:50:05 +0000
References: <20261005110855.1669249-1-vineeth.karumanchi@amd.com>
In-Reply-To: <20261005110855.1669249-1-vineeth.karumanchi@amd.com>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: git@amd.com, theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 5 Oct 2026 16:38:55 +0530 you wrote:
> When a taprio config only covered a subset of queues, the driver
> programmed the ENST registers only for the queues named in the config
> and left the remaining queues holding stale register values. This
> produced an inconsistent hardware setup that affected the scheduling
> of the configured queues.
> 
> This was observed on a GEM instance with four hardware queues, all
> enabled:
> 
> [...]

Here is the summary with links:
  - [net,RESEND,v2] net: macb: configure ENST registers for all queues
    https://git.kernel.org/netdev/net-next/c/04a943067baa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


