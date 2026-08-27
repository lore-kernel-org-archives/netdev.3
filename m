Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F92538A726;
	Thu, 27 Aug 2026 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787860267; cv=none; b=PrZ2pubiIyFF2O0lEzCE7FR72GLGhyAxP6H+Ls79Zh799aS6jS+oo2U8VDaoLDZD9CoFT11eNf/AvRAjPOeUp2tvxl8Hv2BTGgHnJ5aJFG+mze7fCPFvz8QCyGPi4EDRNMgj86jJlyT6GpdcNNfMoFpnH9X3OpPies9H6ysXlvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787860267; c=relaxed/simple;
	bh=U0vS9y9rYpDsXJdpzQgA2ERAXfs5iW0CgcX/qlA58E8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g2zYOCSJGlS3Stx6Zb/Y6Etq55ep+9capclfIfsoMHwwnld66ngV6HvTZ7J7dNbLCVCeBwclrAjtukHwe5LA6x3jMV/E6mqo0tKleObv4aNQzZLR8GSADGAqvtC3i5Qj8RhOrNFimj3ukOkuaEfHHeB19wsAi3MfenPqdauoWyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1MwMAj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1MwMAj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24971F00A3A;
	Thu, 27 Aug 2026 19:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787860263;
	bh=Tn9QMi/hweYiCUvl4eBEEL1T9FilteftOpESYRWreV0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O1MwMAj1oU0YTnKFkqPPess812pUGoSTWXs2sesAKhGwbzBgBxbVq9i94JRE81GAf
	 ZGsa67SINh5dBI5xy7rRwgm1Y+eyOrSIiz8ew8a3TrVZusL8Nr/DsZCWVMlZyuVgfg
	 OprllDucF/t2fBcq1jfJGo8sxDqP2yD0Mpc7vhHbykR+VgRoC1YV2KXA7qVIGcKitT
	 4SOZrmMm8FoVUpg0aX/HTdc4e5PkB9lEm+OEvqYZ20cnQ3Tacu/kk4YVfIoOJEiHLY
	 +EIFCP51KKoKltKWJFcJRK2X/k3q7ojAMJwyo6xZA6gdiR0aYWiXS2Reqy62OoxAkT
	 DPhkFYzwdl2zA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9397D3809A8D;
	Thu, 27 Aug 2026 19:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: fec: only stop PTP if it was initialized
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178786020914.1820029.11361737404305374031.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 19:50:09 +0000
References: <20260826103428.32807-1-phucduc.bui@gmail.com>
In-Reply-To: <20260826103428.32807-1-phucduc.bui@gmail.com>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Frank.Li@nxp.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Aug 2026 17:34:28 +0700 you wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> fec_ptp_init() is only called when fep->bufdesc_ex is available.
> However, fec_probe() unconditionally calls fec_ptp_stop() on the
> failed_init path, and fec_drv_remove() unconditionally calls
> fec_ptp_stop() during device removal.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: fec: only stop PTP if it was initialized
    https://git.kernel.org/netdev/net/c/dd890ae29299

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


