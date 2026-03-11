Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A64E342530;
	Wed, 11 Mar 2026 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195610; cv=none; b=E+LYRWUXs3GxTT4J82oc1sBiV/w2dkllhuW4L1vN/c3EhDShG1cW8K5QNxUuXGDX394PhnQ7sUEoyQLY52eJPC+g6aMC50ESCYvr0auM9MHBRwOutT7anWp4DD5BH5uq1MBVdfCrBSU+gt8KnGKN3FU3whsHNDJIYuVNzxHnclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195610; c=relaxed/simple;
	bh=Iimmj9XHp7xTZhtz4FMjqfdgV3OL+64EL64CL4WWt3w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sLg1KOwhsXhKyoaepe39J4XFa9M0swpO2n67L4Ok9iggQ8zbvF3NCAbjcnUleYbnFTCRYO1qRsjAf6hdp13IYbKPAod6jKsCGl2SbGhYHWNrA/M8Ya756MgaOmcUgI+BNxEZOQ4lf9SwmCFfDyDKQAGi5RwR0ljudJdyo+Pwr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImYsyXdq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImYsyXdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0776FC19423;
	Wed, 11 Mar 2026 02:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773195610;
	bh=Iimmj9XHp7xTZhtz4FMjqfdgV3OL+64EL64CL4WWt3w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ImYsyXdqfrH6ALcPPsykzOFftUJTkO42s3Vlo2ZuMjwdb9gBQI3FYL0RCUFDJaRoe
	 cSn+EDXAwx8npBxrAduklMxay11DliE6xEDBlS5e2RpKHuG4mH+P6H2r39mbzYdeRx
	 8ZwZ1MODa8BAegwYIL4CpZhIKk4E7uLu3eNxe/PA/387uA0MppBA2AjLUF1EAaFWq0
	 OJgCI9/OOTvmqAT9QNBCYFFqw1E6J36lxI6OUk+mLcBFLMeQAVTyD/DrmVOncvqjov
	 JoVWSKZN3jsd9HNaEG5LvyGQUEPW3dpueTioZtyTEmr6fjSEqpM5JpJtOSIG75rhlf
	 D3WVBnihrg4iQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0793808200;
	Wed, 11 Mar 2026 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: ethernet: arc: emac: quiesce interrupts
 before
 requesting IRQ
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319560655.3008927.17970986810014027433.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 02:20:06 +0000
References: <20260309132409.584966-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260309132409.584966-1-fanwu01@zju.edu.cn>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Mar 2026 13:24:09 +0000 you wrote:
> Normal RX/TX interrupts are enabled later, in arc_emac_open(), so probe
> should not see interrupt delivery in the usual case. However, hardware may
> still present stale or latched interrupt status left by firmware or the
> bootloader.
> 
> If probe later unwinds after devm_request_irq() has installed the handler,
> such a stale interrupt can still reach arc_emac_intr() during teardown and
> race with release of the associated net_device.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: ethernet: arc: emac: quiesce interrupts before requesting IRQ
    https://git.kernel.org/netdev/net/c/2503d08f8a2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


