Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC0731E84F;
	Thu, 23 Jul 2026 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815874; cv=none; b=FrO8iI7AXGTMHVG2AadPvDHR4vCOEHWmxVcLgLWT6Omk84lkQNlC3YfAiuczjwvOCYfz4+VP/CI4ol3eO/3xnWqtYun8s3rzrQbTKuNNmRqfKSOkWeZi5CYoPnrKIQPfpT5bqVlmWfgPI6jSsvtl7zlUqJqAFi9qhWmCQwVmJYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815874; c=relaxed/simple;
	bh=kkUaG4OFaUNA299yNPxExiBz3WfDvNfkwclMbXs/w5g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QgDvqhgc3TpHNJRG8uhDPU940rlhehgOteIyPpMbbPG1fX7cSAPZDHvlKF7l6AbjESsyEAK8DHuO8LeM6xrLnxJhGrodiXKnuy5ZcZjV7ef90lXw7BnpIoK9sCawggXUAmSdIWoN3pk0wX9FQLIsWOYMvNCMvMLRk/zDLZJefhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYAfUYKn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYAfUYKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32D11F00AC4;
	Thu, 23 Jul 2026 14:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784815857;
	bh=e+PZO5MkosxONDiakds6k+hycWBv6dw3oVvlvWJ9PxU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BYAfUYKnB9zZMQiniXXveziNH9msnKl5+9uwI2FszSUut+ElyBtMAyLM8AzqH2s0n
	 eMNoEQc4jDZOC54Sk4GmdDBJjcLTyMesf42dG1sA8YiMI9g06rkxNkaWTYlqIIsl4z
	 4iUkgquUqOCpF7oWVq/jLPq35vN8Qqg5rpSrVayKcQwn2bdPj4m2A+LbLuNrI/dTkN
	 gNiKOmEamPi8uocRKl91WeuPe0TtYRA5aiKsgxW5bloJZSdo6sDkQEHVs50RahDJ4r
	 Jll8ci/SOCKKJKkPrnRuBzI8vmSCujWd980i9Up8WA/Uftel1vXjIgnb3Zv3UxExwx
	 JQVB9A1W332Fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B45380CFD4;
	Thu, 23 Jul 2026 14:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: Add myself for stmmac ethernet driver
 maintainance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178481582490.2248593.7494746739447898895.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 14:10:24 +0000
References: <20260722142125.1767689-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260722142125.1767689-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, alexis.lothore@bootlin.com, jan.petrous@oss.nxp.com,
 heiko@sntech.de, nobuhiro.iwamatsu.x90@mail.toshiba, keguang.zhang@gmail.com,
 me@ziyao.cc, mohd.anwar@oss.qualcomm.com, romain.gantois@bootlin.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, fustini@kernel.org,
 guoren@kernel.org, wefu@redhat.com, inochiama@gmail.com, kernel@esmil.dk,
 minda.chen@starfivetech.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-rockchip@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-riscv@lists.infradead.org, s32@nxp.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jul 2026 16:21:24 +0200 you wrote:
> The stmmac driver based on Synopsys' dwmac IP is used in a very wide
> variety of SoCs and is currently very actively used and contributed to.
> 
> It has been orphaned in January 2025 after the previous maintainers
> became inactive, but Russell King was providing very valuable reviews
> and fixes for the driver at that point.
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: Add myself for stmmac ethernet driver maintainance
    https://git.kernel.org/netdev/net/c/4a05269bb723

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


