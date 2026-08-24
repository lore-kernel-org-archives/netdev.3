Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D10387596;
	Mon, 24 Aug 2026 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787599259; cv=none; b=WZ7GuSW/oTn+RPjy1Wtf/w0noCjl5bAtsGdzhb25BEI9APmPSSuGF+wcnuBcQndXxUpy/S4KS972T6ev1hDa8FwP/Eep22X2TPnazzInQd9Bg06rc/8UydpZKDrnbmrXIlOJ5+PsmQOawqMC4nCQPTaztHEgwSERj94bioCG+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787599259; c=relaxed/simple;
	bh=1PjsluTv6mKMb4/7zYND9KdxBUBAiGChWPo+kWBzS+c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tZHSk/kxPdUwKy/0CZ6fOILsag5Kn6yJzTGUkqTz+2E+oKxQ+dr0OLVBzTanJ6EYgDOyEU8TpQqPxPaVEETRHB00+8xfjQbFC0BzGe8RB02sylYB//6J8BFRK0Q7O138uenpeFevC8VYr1CzKs/SGP9XIn6ZQnuhK5jOcrJPqXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzQeXKUK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzQeXKUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB331F000E9;
	Mon, 24 Aug 2026 19:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787599258;
	bh=keVcmcAYbmoueBbiaK4xjEu9FNqNtYGctNOe0gQPVz8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GzQeXKUKlc3IpcQw8jpxi+YmKGKUeQ3vWdVpc3Qx0V8GdRasVtPlPqw/hsiHwQo0a
	 A1MJucxFP3KLGtB5fHrJNa1aflZ0sqME18GJXE1ua3U5ZSaUv3okQLBjTU6pAVecy4
	 B5pwirdtfAmmvBi68qQom3tvWGSPvUuxkWUNn2uKFX26RPftYQ3uH5h3nmsdgcJxvW
	 6k30YiCOulRpC3tJJpJIu2hzy9oGq69g+b2zr9dQ7VyzN9FAkmTV99ti//W3W3bVUY
	 IveMhKfaaaZHKZ5doLyF9N1xj3tWQvP+FdAyUUCPRkyJS8q3xUZ2NwRcEU71u0ebjj
	 ynBy/s+7diV9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A363924A4D;
	Mon, 24 Aug 2026 19:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] octeontx2-af: fix cn20k mailbox lifetime on
 repeated
 rvu_mbox_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178759920565.3076765.14078009170699079002.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 19:20:05 +0000
References: <20260821102337.2989169-1-rkannoth@marvell.com>
In-Reply-To: <20260821102337.2989169-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 saikrishnag@marvell.com, sbhatta@marvell.com, sgoutham@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Aug 2026 15:53:37 +0530 you wrote:
> From: Sai Krishna <saikrishnag@marvell.com>
> 
> rvu_mbox_init() is called separately for AF-PF mailboxes during probe
> and for AF-VF mailboxes when SR-IOV is enabled.  Each call used to
> allocate a new ng_rvu object, leaking the first allocation when the
> pointer was overwritten on the second call.
> 
> [...]

Here is the summary with links:
  - [v2,net] octeontx2-af: fix cn20k mailbox lifetime on repeated rvu_mbox_init()
    https://git.kernel.org/netdev/net/c/3b11a77f6998

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


