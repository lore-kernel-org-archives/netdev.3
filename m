Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2039C37F74C
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035076; cv=none; b=DLYDm2Nw3mcKaZsXO8NNldToYMjCr838EOY4FEbszypxrkWY42AZc44PEVwbpdBGc0zL17Nuscegh57uK8dqaHc1avd13hEzoO5RblhGyE0UjW/Z7HEONibiFDBI8umWIbxu9dVnC7yIYiYbGCu8sVR6nqySCmFZAAGcADbLtj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035076; c=relaxed/simple;
	bh=itOkh+wmr701nf8fr2L39CkoiSVm1wz9pCpPGdEW6jk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fFYVyMa+BGrNBLMdct4sXEkAQvzJ4J91YshpgUSnF8gwsbnKvRLf8WUKcnASk8vLLCAH3TFf5J4uxKgzyg/HCWdhxX4tu7QbRWCrj6OQfBmrQ4n3o7NX6yBMvj2POHlIYyoKcngOyUEDVjqa0SyJCo7k3MZyRlK5/JU8d4jDB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QREWnUZv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QREWnUZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B461F00A3D;
	Thu,  6 Aug 2026 16:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786035066;
	bh=XpAZOFrjB/8nwCcL0xPnoPHsPPfJCH2g5SYoXpP5IMA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QREWnUZvO1RSoGekwXLQtH2V4g+HEqH12VBoAvMVZf346mUxcA93M0IcCrmlPFn14
	 md2sgn0qvHkMXeVrDsu/BxJP6HPU+FM/5AppawieZUkJ/Hcm0xpVfWEefpI9y98e0S
	 WYVJ33TKMLmILpWW0NjdeKZMKsyH650RZwwK/U7rkmO51PXtVMaN0oBrs17mjNku7y
	 lxLE6y5TB2sr6l/aupb8dYl62WxxLc9dpAJ4v/xHGP+LaOuH7Ai0w/zHmL8rcImPVW
	 QimIA/sCe61Sivs2jH+hq6NrvHtV74SgiWa7MbXXj76EoYHkRuAdh7lmP0pzitZFvd
	 q9GvNmjBcQnBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93956380820D;
	Thu,  6 Aug 2026 16:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: avoid theoretical races with ref drain
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603502513.1375455.12453285964072800716.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 16:50:25 +0000
References: <20260806022821.2079945-1-kuba@kernel.org>
In-Reply-To: <20260806022821.2079945-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 yijiangshan@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Aug 2026 19:28:21 -0700 you wrote:
> Technically, it's illegal to take a ref on a netdev just because
> we have a pointer on which we already hold a ref, with no other
> protection. This is because our simple per-cpu refcount
> implementation cannot atomically read the count.
> 
> Let's make sure we cancel outstanding work and never queue more
> work for a device we know is dead. This way taking a ref on
> a dev we know is on the netdev_work_list is always going to be safe.
> 
> [...]

Here is the summary with links:
  - [net] net: avoid theoretical races with ref drain
    https://git.kernel.org/netdev/net/c/d31c14e56a4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


