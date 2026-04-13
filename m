Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B4536073E
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 21:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776115872; cv=none; b=D9wUCkzOUq7LRC4oEDYsCucL3/zmx/K2yRX592c4n3xSaBcVABq0rNphCc+pVFRiL0m50Ho9wFl+Y6ymS6yurXpoQ8tcm0/iVQl6h8cMO3I9zi0jDRvU4KLuPH+hud+0io0RyiRjor2br3X37RTLiUYOFMfNAq6FNrqvHhqs7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776115872; c=relaxed/simple;
	bh=kvamV9f6a8KhcBfJtdmljJQT/xbjsSiOp8rZvkxmH/4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pjOlhz7Wl6shjLlRVKwEZhjjTTrqsEIZ13bHPk9aNood2pRx05F+7XF4bwTqbix5Yw0AO2eirIvS7OYQ7Z3Wnx3mySy4RoQEURuTXMf5dSpocndnEgRMwmJqxppLJm8c1ccriQY9WO/bXfrOOG/ue27lqIpa4n+I1LNp9H81Tac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5RWv3Pj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5RWv3Pj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F348DC2BCAF;
	Mon, 13 Apr 2026 21:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776115872;
	bh=kvamV9f6a8KhcBfJtdmljJQT/xbjsSiOp8rZvkxmH/4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q5RWv3PjGps7XqtxQ3crppVF6L1sFQooA1GAuAGu8b0zp2ogPlH/ZWzcT8cuBbfC3
	 zfEfujAB2rE7J5a88aML4+gt5YonP7T0QsJd6fUGcIgxyVsp1d3ukBVKBse55iPjFK
	 a33FBFMLMEs9+DQ/9t2jh0ndbUAGSCujo7VpHA/wmcywF001PK3miFjK8XyQdKMWrp
	 OFI8Sl+N1dMVbD4gH4Hyz9rtlyTuyp9g80nc9fQ0CYRJcI3w6TQXETkJhBm+/PC8gh
	 INy2rJofzJZKyzxwWawkioSf7U2qUINdPp93K0m1v3VCiopB2ddK3/g3wc5OF9H2JD
	 XZjQ68aBwyqPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD423809A0C;
	Mon, 13 Apr 2026 21:30:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlx4: correct error reporting in
 mlx4_master_process_vhcr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177611584330.554657.9335261228353567936.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 21:30:43 +0000
References: <20260409092754.508880-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260409092754.508880-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: tariqt@nvidia.com, andrew+netdev@lunn.ch, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Apr 2026 02:27:47 -0700 you wrote:
> mlx4_master_process_vhcr() logs vhcr->errno on failures, but this field
> is never populated by the PF path. As a result, all failures are reported
> with errno 0 and err print in status case which is misleading.
> 
> Use the actual return value (err) instead, translate it to FW status
> before logging, and report both values.
> 
> [...]

Here is the summary with links:
  - [net-next] mlx4: correct error reporting in mlx4_master_process_vhcr()
    https://git.kernel.org/netdev/net-next/c/bc174d054986

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


