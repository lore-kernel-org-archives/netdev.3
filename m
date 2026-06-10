Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22ED1459FA;
	Wed, 10 Jun 2026 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054410; cv=none; b=HTlbs5CzRq6aqClsAG/HdKToLMvEyU0fkhJon7yhMrMkRgkOWch/HU4gemUmA5FBVeM/r70XaVlABXKRhH/80Ai2oh9va+cJ3QzFl9L1ul9ErWC6mpioSqxcZKxqMJw0gQqEdWlxxNRWps6f0DMxiKK0zO+gV97GuSVyASOYdn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054410; c=relaxed/simple;
	bh=k60GvGJzSgkzg0qiu+plSyBgeaIYproqRQQ4ehQmcx4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JAVH5KWAFQArg22ck4zUzQ/VFFsoPybJvuHeS06C0c1bibuT1/yJah8Q+/nYZpB8+Zx21/mlrtNRHvk110L48Oa9gkD+mk1ZpJYty5t6YV1mWqFHGCqoKh5wMb+4vXTRpVUTgCC1iwy6vCeUpViScdmqdRpniSpkPgAlGiwD8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrmxHQPi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrmxHQPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752A31F00893;
	Wed, 10 Jun 2026 01:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781054409;
	bh=VI5ut/0YzSS8jfsx8GHvOnz5wnkTkOv8+IYHbb1PgU4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PrmxHQPiagZOfCPCBj5qcJcr4aYBZ38dOvOhoA4B7z486U8vkTg8heP1Oylcpm482
	 0FjHOhZyUNhpjSQPdmHQGFL3YtRmu+QSlivzleRYyt3DNTzrHvOG4LwdevCKX7rz8I
	 zw0XShnb4uEryHAngRI/5PUbWjDcYFUstUb7gp9pI54k/Q4z4fT+ZEHz56+RKlt+fY
	 7I1S9WOsvwbg3pLwS3xreGDlw+R+l5Hjz68W+czCu62nICxqG+dS9k9l87+74+2ssm
	 KrPdZueGY1iC2p6AK8lgkdZ+JEb/9liYn7TBIjmQgozMTpcCAtiEdzh8lyEfTV/Mtt
	 Me0D3nYCHOjQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09883930A12;
	Wed, 10 Jun 2026 01:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bnxt_en: Fix NULL pointer dereference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105440739.2779729.6594340451035463681.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:20:07 +0000
References: <aiNM1CY2-StPilxW@hpe.com>
In-Reply-To: <aiNM1CY2-StPilxW@hpe.com>
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 5 Jun 2026 17:25:24 -0500 you wrote:
> PCIe errors detected by a Root Port or Downstream Port cause error
> recovery services to run on all subordinate devices regardless of
> administrative state.
> 
> The .error_detected() callback, bnxt_io_error_detected(), disables
> and synchronizes IRQs via bnxt_disable_int_sync(), which calls
> bnxt_cp_num_to_irq_num() to map completion rings to IRQs using
> bp->bnapi.
> 
> [...]

Here is the summary with links:
  - bnxt_en: Fix NULL pointer dereference
    https://git.kernel.org/netdev/net/c/d930276f2cdd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


