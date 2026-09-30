Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78523630A5
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790734212; cv=none; b=Xeo2pKdcS9vI5BkYgRM7n36G/yJdJXws6JNFjgHbEoqBIObMSPvcmqMKSAzU1gJgiFJyvJCRqeJ2PSPRSoCXdl6wjrxkP0b5oJjY6cJVrxv0SEe/BJt6XXL3WKCxHx+ubtxylwNES0DEtq17ZEY3iqPiWlzmACb6ehlxA3Hp63o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790734212; c=relaxed/simple;
	bh=13Pwn7CJ+Fh1oJZkw5t0tYYQB5AgiKnCXCvg/5P/eKM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O1vpfhTanNFVIY4STOTBkk6YLNTFLwYcp1ev1l12kYtcMZLtJ1RErnVZUZU2BM7gBxK//E2VfcPNAhV/k5RW5bjz0MAke42lEJv6Mp9BzXahJed+u9+1mCi8GE24mAZJ5LfFIRvedeW8Ac/q0lzeiufTIVLQ6v/8F9iVMLOPzGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRlXOifv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRlXOifv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825481F000FF;
	Wed, 30 Sep 2026 02:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790734211;
	bh=oFxvrrbUI0Htq1vIzuBtDOL56V3G3GmmgRLesVjXK3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BRlXOifvCO+RJhMIShkXR7pRCr8v0fhLxopTaZ50COf5x0tD0wW2L0e+hVnlg6vi/
	 PRDwuuLmzE95mQCVRirpNiB6engjCM1CJTrVy81B3lewPSgHvL+mO6C8kX34prNrJe
	 g4vaDnyrHqQL6MRO3wGnQWJp8jzsGORXm8NRM4qysjTerDFjcrLIBs37MONE5/dw8y
	 ruv5/Hl4m90sMk1UMnxqpmSSg5PV9ed18X3KRHLMYjrmYd8icQIdhPt2RZMPQTJuXZ
	 QpH4nQjnxHhKQewaaOcIG7x8c0ApQ5pnPtBx93loBVzAhnNSTebtREoTRKBOh9hxsG
	 ftRLk1p2m2iLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774CE3924FEA;
	Wed, 30 Sep 2026 02:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2: remove unneeded symbol exports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179073421002.1211220.909737522192697428.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 02:10:10 +0000
References: <20260925201042.1174488-1-kuba@kernel.org>
In-Reply-To: <20260925201042.1174488-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 hch@infradead.org, sgoutham@marvell.com, rkannoth@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, bbhushan2@marvell.com,
 lcherian@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 13:10:42 -0700 you wrote:
> octeontx2 has a bunch of symbols not used outside the module which
> defines them. Worse, still the macro which defines otx2_mbox_up_handler_*
> adds exports for all the functions. Remove all the explicit exports
> and the auto-export from that macro.
> 
> otx2_mbox_up_handler_cgx_link_event was exported by the macro and
> is genuienly called from the VF driver, so add an export.
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2: remove unneeded symbol exports
    https://git.kernel.org/netdev/net-next/c/3e6a0e83c913

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


