Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750D84334BF;
	Wed, 22 Jul 2026 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741443; cv=none; b=ndCnvyw9slZ23Q1v/hCqVgeVVcvdxHgX/YEyrABYRJ39OBVb3260cOtxVhRv1fGXSIkOM+IYEWmiEi5YaDbl270Fqlic8g1lQU9L/VQgIGm+A39QZ0oKzX6S4zgEGYJijmGjrj2EopThFCV8i0gFsMhaCnw/a8YmlN6ETM2s08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741443; c=relaxed/simple;
	bh=V0U1udCgF08QKxpHmrYiHAtd18fGF/wjOtwPPV5foLY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=upJT6FehP/u3GZ3XN6kbyMsiW9M1sbk7scC47FU6cuszRP8/KsaA2bgQL6yn0WdoTq4OlguJKMYPYP4HCiqPfy4jOXRovC8OCSSnVDA+7XetHNkh3Y7Tm83WWDBkW9MhmQ6oyEpjb8ePii1k5Hoq1o4X0zxrzemH/9PhlUH1f5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ23Ym4r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ23Ym4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEAA1F000E9;
	Wed, 22 Jul 2026 17:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784741442;
	bh=agEVGi4X6su1xJvDvWend9rgUm3zZpt/5Eb4ATX0Lxg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fQ23Ym4rFelizatHqv/nDSt/HRZhNPAGYSuwPWjXh1nH+GEpCIoTdzPTRpek47L6/
	 ejoB1q+cUEzS981Om1ATMBlj2+UPLUGSVdcs+/cdeA9TYUXSPEV3W9L1RRCyLzdQBH
	 5u1WDnIWRgZkJGL4rV9INeNAVC08c22TsR9deQa3CGNTDMiKSGFe/L+InfepJoWoWx
	 Cz2QSJM266cvud2k/sbE9p15bbOVLiT7WYjKnnr6WQpVeunOXIXYCLYMLoTi+hlkYv
	 csC9en90fP0JmgmcHXEa0R9MQzWmNGviVUa/nKuizfrBHanZmyUF7dHPNBxO0ULs9I
	 2lvsL32Sd8Ehg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D7380CEC5;
	Wed, 22 Jul 2026 17:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/2] net: dsa: realtek: rtl8365mb: add
 SGMII/HSGMII support for RTL8367S
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178474141114.1956205.8619185274240286741.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 17:30:11 +0000
References: <20260711-rtl8367s-sgmii-v6-0-88f7944ddca7@c127.dev>
In-Reply-To: <20260711-rtl8367s-sgmii-v6-0-88f7944ddca7@c127.dev>
To: Johan Alvarado <contact@c127.dev>
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, namiltd@yahoo.com,
 maxime.chevallier@bootlin.com, luizluca@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 11 Jul 2026 23:31:57 -0500 you wrote:
> The RTL8367S is a 5+2 port switch from the same family as the
> RTL8365MB-VC already supported by this driver. Its chip info table
> entry declares SGMII and HSGMII on external interface 1, but the
> driver so far only implements RGMII, leaving boards that wire the
> switch to the CPU over the SerDes without a working CPU port.
> 
> This series implements both modes. The configuration sequence and the
> SerDes tuning parameters are derived from the GPL-licensed Realtek
> rtl8367c vendor driver, as distributed in the Mercusys MR80X GPL code
> drop, and cross-checked against the real register sequence captured at
> runtime by chainloading a custom U-Boot ahead of the stock firmware
> and logging the live SerDes accesses on hardware.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/2] net: dsa: realtek: rtl8365mb: add SGMII support for RTL8367S
    https://git.kernel.org/netdev/net-next/c/0b577e2fe06c
  - [net-next,v6,2/2] net: dsa: realtek: rtl8365mb: add HSGMII support for RTL8367S
    https://git.kernel.org/netdev/net-next/c/987137345f33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


