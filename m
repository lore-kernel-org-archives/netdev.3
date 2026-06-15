Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315403BAD99
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563848; cv=none; b=EKxL2sxkKzOmrW/yB3tYZ3NqQaENlwI0Gz+0PhDet34PI6OpPReSOIQZsKtuAMl70QCWvLZgXy0rsIVhAcI02kq/qNkHbBsVOB9Nz/qi46oEp/Wv5IDiYZYFxYtCPhOk2aEHpigFs6gzLXS8ooy6+Nc3OmiRff7wa7i+WEATTT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563848; c=relaxed/simple;
	bh=svCa1AfzE506H+txoFZSzserj2MqPHKdt51Kl4rgLUU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IKVxi5NL3mU+1EfHN55evzCwv6D57ZZMvrzMetidS4vLlFOYKsWzoSHzTct42mpBu2PCIuiM1iYDsTbyPyV9QHSYJba4bO04QGWnuhHLCdopPf1SDBi49XunTkp96uii3HynYxBKhYEuy7jhIaeQfZ4Em5Vaxx9JehNUpT3FrzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpFUzUpj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpFUzUpj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F171F00A3A;
	Mon, 15 Jun 2026 22:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563845;
	bh=iwMz3Qb6KBIZ52xe7qK98ZGfUwF79kBhrbQewBx7nyQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kpFUzUpjmsudEqj03T/RyCQyqW4CFcKL28HfgBZJou1WkNzHlCmzA6eQIItcdlCaV
	 aDtvH7S9Trp7NOqp/Ic/oeYk820jao2FTDNdML2qLHYO2KhT+xUUujd0TXC8Ngk0fk
	 HqTCpVYEAFyKWq0f3fvWgyqZHntzK8qZuq43W++whlJQr6d1pwu4xjCkMHGdJGqITB
	 Q0dSDVMAXOOBbem7Od+RCcWmoLOzI0zSR13t42H3L8UwvEX6V1ZjgzSx0rpINr+45y
	 BQAXjZbgyaZ1e7NrpC3whFUOwzdozLhwPD9uNncBs0ZYtz1Ht+RdS5nmJUtWCGfJKn
	 nqzhyOeShflIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 196EA3839A08;
	Mon, 15 Jun 2026 22:50:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: airoha: Fix non-standard return value in
 airoha_ppe_get_wdma_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156384063.325968.5097287869534609850.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 22:50:40 +0000
References: <6a2ca3d9.ad59c0a6.147df9.2a62@mx.google.com>
In-Reply-To: <6a2ca3d9.ad59c0a6.147df9.2a62@mx.google.com>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Jun 2026 08:22:31 +0800 you wrote:
> airoha_ppe_get_wdma_info() returns -1 when the last path in the
> forwarding path stack is not of type DEV_PATH_MTK_WDMA. This is not
> a standard kernel error code. Replace it with -EINVAL since the
> input path type is invalid from the caller's perspective.
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Wayen.Yan <win847@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: airoha: Fix non-standard return value in airoha_ppe_get_wdma_info()
    https://git.kernel.org/netdev/net-next/c/05173fa30add

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


