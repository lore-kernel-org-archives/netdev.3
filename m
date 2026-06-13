Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8CF266B46
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312433; cv=none; b=UF89kSZSr/CHoteT2cptDN01nJ+/me+05QtKgo75c3YoZBryhqTIrUnALAJ7hfE0f9Os9x4om2bAMO64W7c7sqbIJXjiA7r6rwbUXPL6M5i0Cdo9E4z0gQU8RScZ3ZOu5cNB/sZ2qwF0EXOqs/KVW+uv18URE4t7EJr0isvHlxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312433; c=relaxed/simple;
	bh=7yLtn/sHt+SRrikGiRqCkR9L97ZRwqdmB4AJdsmaPyk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NqspiA112dIaZ4LhcXA9cCM6huHtasWr/gYpno/VUkIxBFsO2GK9Qvw2NqCwvnlHtvg1SdWpLBizxcuTxS5mGDNXtvQ87Uex06lpNJN7ZU3jsc7Et+lfMuUCQEJT2kKpRS9jX6KQdU0AJBcHUWQZDUVxIDLH3eUBEHTiMDc5dBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Euke2X+S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Euke2X+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4647E1F000E9;
	Sat, 13 Jun 2026 01:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781312431;
	bh=vDC3gdx1kG07b3DzyK33N8EzugMHq7voHog/GHFVPmQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Euke2X+S8lVL1Zj8C73eOPQVTRpC4LIC7JeBp4/LLIX1H0Yd9lgBGKV4TDsYP/2LO
	 mc7vuU3/m/cApRv9QpoxGJcMeBR7bv+ggBz1lTO/XeC7NQ//lPg1SewERUKYTsdXn1
	 5JiDvLxD7rKKu7cdppbUXKs4UiaMaCCRjPlBlkJQAkiHkqtI61CeTV0tQ56p2O1kpf
	 RPY0HifWbc04wV6swI17lPNmGN4DlvATcmgd5cEuRwXItImhxGErwypF1k6GISItbH
	 DqFuxiEDUK+4TAUlUSHKn0njcHYFtFRwkqFS51wMpExKjMutF6GiQmybXm3T2SfilU
	 TRkzac15vU0Cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19C4F39E9607;
	Sat, 13 Jun 2026 01:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ptp: ocp: add shutdown callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131242763.1315131.2792194546022295371.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:00:27 +0000
References: <20260611190333.787132-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20260611190333.787132-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 pabeni@redhat.com, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 19:03:33 +0000 you wrote:
> The shutdown callback was never implemented for this driver, but it's
> needed because .remove() callback is never called during kexec/reboot
> process. That leaves HW with some interrupts enabled and may cause
> spurious interrupt while booting into a new kernel during with kexec.
> If it happens that I2C interrupt fires during kexec, the whole I2C bus
> is disabled leaving TimeCard with no devlink communication. The same
> happens if timestampers were enabled, leaving the card without
> timestamper interrupts until full reboot cycle.
> 
> [...]

Here is the summary with links:
  - [net-next] ptp: ocp: add shutdown callback
    https://git.kernel.org/netdev/net-next/c/f6f955cbf9d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


