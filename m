Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1061E231A32;
	Tue, 28 Oct 2025 01:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615039; cv=none; b=Py2o1lXAG+SEsrrpgQhRK/1dEyoLLxiyOnRjtgOvGWFZwwRJvBKz22c6K789ZdMyKPr1laM6MiI7nLVqxmotbfvxmphvrKlNAQyDo3ROrSsTWzCUrfB6U8HdLPRRVuCQNrysplAgw2eaF3UsbUrOYhaZRjKKyIRXgilGXlUK8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615039; c=relaxed/simple;
	bh=z/68Xn4iCXvzgo2hyC9o2OtUSV4NiDx8flvonDyRqsE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eyTQPpCxmpZlzgSGgthkdFmWYv1X6BFPj10fS1gLCGDqPdmKy5NhMDLFfn3PZT+wQtMH4wjpplB7UOaMamAfiuNEGYZy9hv3dSIOg0+553P2mAHUXMh90CwQTyqCFjX43YR/22Xy9LiI3H3KhORbCG1fN3/pfqjb7e47frQU7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IspBHoCx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IspBHoCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A9FC113D0;
	Tue, 28 Oct 2025 01:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761615038;
	bh=z/68Xn4iCXvzgo2hyC9o2OtUSV4NiDx8flvonDyRqsE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IspBHoCxdwvEZva5fnJ45TqA9VJYKrQ85tMI20MSvCehkqnR2CXDnrqXx7W4F7hMV
	 jg5R8XnTDmk25QcjlbrUM2NyLRlOmfZtOtkWm/xjtkIT8JyvJKQVnNnHFFrChIKJ5S
	 Qu7VgBlCcOp1pKOa4FPZDzJ8TzcEts2WRrkR7fWNmdD/1DM1VQO7GfTtPmtBtczGft
	 Yw78KBB2ajZEr32D/Vm3DR5+dxBbxAZddUcLEUEdPCSqZCOVa0juWznMpPYhwz80uM
	 N+Zl3xmm7rLCTdGNq8LwmrLY9wzWZm78IAAb3GUizs/YvsLzMBZtIqKKY4dtwhPGox
	 pj4kpdB+aCwhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADBB39D60B9;
	Tue, 28 Oct 2025 01:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] dt-bindings: net: phy: vsc8531: Convert to DT
 schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176161501674.1653952.15277465151671744173.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 01:30:16 +0000
References: <20251025064850.393797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251025064850.393797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Lad@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Prabhakar <prabhakar.csengg@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, neil.armstrong@linaro.org, heiko@sntech.de,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 25 Oct 2025 07:48:50 +0100 you wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Convert VSC8531 Gigabit ethernet phy binding to DT schema format. While
> at it add compatible string for VSC8541 PHY which is very much similar
> to the VSC8531 PHY and is already supported in the kernel. VSC8541 PHY
> is present on the Renesas RZ/T2H EVK.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] dt-bindings: net: phy: vsc8531: Convert to DT schema
    https://git.kernel.org/netdev/net-next/c/19ab0a22efbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


