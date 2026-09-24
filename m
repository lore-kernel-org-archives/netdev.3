Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEA53F929B;
	Thu, 24 Sep 2026 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268088; cv=none; b=S0Ca3tPyocdljxq9+NFQYsOWn4AGYEsF3SRcGMUBO3JfvTJggUTJoIzOGiw1w+E9v8rj7//3l5tFGIjkOFg4CUVYj/lGYMSSyZIZsTPKsGT4qho/z88valF+STPaoNKMnBIhBh3qeq7eLR8M+2ewndgo4djGoqPcnwKiNXJf32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268088; c=relaxed/simple;
	bh=hCK3S1nGycehD1h0LxDF7olD/zKboAi8qe4YwYGpF00=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JtL8iMc82e7YmMir1NyGtE9DexmgNgaYYNbdn5UZ9J9nuLc2IIoZdj5TZ+uOwz8ESTG5bxlp49hK+Bx4Ej1a0Q1PBDpMSiN/7ash+81rTvR5bYvn7ZDd0nMnTfxum8WLhXbNBQ9askh6IVKhoEgu/5/Zh9X3iPXk20v0CssMiJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPF/Rwa8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPF/Rwa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E701F000FF;
	Thu, 24 Sep 2026 16:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790268087;
	bh=7EZRmSyJFSvpjHRNdeogcewSTHxFc+R9PjSaKds5Q44=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aPF/Rwa8NG8htZsnaC00OWLTtAlFb4BevIYybfipUiLwU8GA0kqpFbdn+7EJrhEII
	 HzGjSIOlKl7QT1mxruErkt7QEBCfISxA+8guSY64zmuFi2cgsiqEEVO2fhr1B99RVJ
	 FMW4Qfyw/SvwK5hLAbr4/b9Pl+terdGFhRAZTKkTZn4mrafbQllTI43t40mU4Qa2j8
	 DJHRGCOnMSY6i6wb6AuihhYCJRw8oIKaXzhK6XLA65AZxAJmqfFfvCl6P6aIHXnx4l
	 hy2Q+C5VtGXJEC/qOW33SJj7KYvd3+LePMs4qXPDvrs6whzR/uSBrc5QrpbdA68zGM
	 4zmsKgyQkQQfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568063A566CE;
	Thu, 24 Sep 2026 16:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] net: ethernet: oa_tc6: add reset-gpios
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179026801588.1646186.7823364033020899549.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 16:40:15 +0000
References: <20260918231450.55966-1-alessandro.zini@siemens.com>
In-Reply-To: <20260918231450.55966-1-alessandro.zini@siemens.com>
To: Alessandro Zini <alessandro.zini@siemens.com>
Cc: parthiban.veerasooran@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ciprian.regus@analog.com, qingfang.deng@linux.dev, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 19 Sep 2026 01:14:47 +0200 you wrote:
> This series adds optional reset GPIO support for OPEN Alliance 10BASE-T1x
> MAC-PHY devices using the OA TC6 library, and documents the property for
> the Microchip LAN8650/1 MAC-PHY.
> 
> Patch 1 documents the optional reset-gpios property for the Microchip
> LAN8650/1.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] dt-bindings: net: microchip,lan8650: add reset-gpios property
    https://git.kernel.org/netdev/net-next/c/7afc23c9884d
  - [net-next,v4,2/3] net: ethernet: oa_tc6: return ERR_PTR from oa_tc6_init()
    https://git.kernel.org/netdev/net-next/c/15358c2c3dca
  - [net-next,v4,3/3] net: ethernet: oa_tc6: add reset-gpios support
    https://git.kernel.org/netdev/net-next/c/8d5dab574a95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


