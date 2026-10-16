Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDE4320A14;
	Fri, 16 Oct 2026 01:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113012; cv=none; b=co4LquQ8BqdX8RYHJHg/lEzfJMfGS5HfbGaXxTt9WS88c5oF0w8EwHr4u3DaODkskr5/AQrMXiZ2TjHzpHFrhBj8ftQ/U+cz1nQN2I6Jdqv6K7fuGLEXIcqVLY5ev1j1pA3K7SosFI9oOlhU7Soxf1nhN3N0eNXnyvZJRXPyOug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113012; c=relaxed/simple;
	bh=jJBwI57N8NxOtNqR/lw1rTxK+DKwr9DBAKHPdGAVqQA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=osHtIruFxzkPBCwAudIIXYTJ+KYZgXoOJEIDVWs2uh0vERCtgzMMCzdSB69AxD+Xuc1VrVDoLXfKGcbPVuiTp9PBD7pbYoMteFuIGSmoWDXIFGQtnbSX9ZHf274ZkpxqESi2FkwPoEge3Z5jp4jrcm2U6ck5W6r7bFfdP9+tDdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3AMCqLG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3AMCqLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067D51F000C4;
	Fri, 16 Oct 2026 01:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792113011;
	bh=3QKdo1CDvZjCcBHwv4n9MX+nM3umv5CEWvZzfgzuyUc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O3AMCqLG6ivZN/p0HbmyAfcRQir91OOXINWIySGfFmZcmlUDylPZgdNV65fvMlnlv
	 aSk2Kqc2K15XeSm9um7lSpXwcI5ehQ+Yq00+Wxzh4kHZ41Wh2imI7HtMpz424Hj945
	 yfbkQau+S5qfzfUw9ApMRHcFFk4DDIOWWNOgAYhtgJNGQus+AP2DINDAtg802jqHpD
	 Mwijn17tQDT1Is+iBOdxGhqOzYaZ1i04Xb+fuwzv30q8S/Ysc/rATh0lR6YSSVM1l8
	 rJRdWD9lOfGzSWZNJ0i39s1vg3285GQ+d4zZvoU48DKuvW/CDcmX23xY7jaqLaHZz0
	 UIzg7Ou7HTctw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15853808209;
	Fri, 16 Oct 2026 01:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] devlink: Fix accidental merge error in nested devlink
 docs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211300952.4187796.17115058563137504280.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 01:10:09 +0000
References: <20261011090739.746757-1-tariqt@nvidia.com>
In-Reply-To: <20261011090739.746757-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 cjubran@nvidia.com, cratiu@nvidia.com, gal@nvidia.com, jiri@resnulli.us,
 corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, skhan@linuxfoundation.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 Oct 2026 12:07:39 +0300 you wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> The referenced "Fixes" commit accidentally reverted a correction
> introduced in commit [1].
> Revert that mistake.
> 
> [1] commit e504cf18ef47 ("docs: net: fix minor issues with devlink
> docs")
> Fixes: 3bf4c5970ca8 ("devlink: Update nested instance locking comment")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net] devlink: Fix accidental merge error in nested devlink docs
    https://git.kernel.org/netdev/net-next/c/393acb51d048

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


