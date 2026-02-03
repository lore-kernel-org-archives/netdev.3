Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E7E2F39A1;
	Tue,  3 Feb 2026 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770088817; cv=none; b=rL1BGOVHVjVpMvr7Gmb+wTY/zvZD5ZjjtYIs/DvPVcZkhS0f+3rh9TFH5E/U8bKdsRzzoBB2fxpl2qbLW3tnPr6h+0q+ctPwdmdSIwDSQSjRXMgovyY25UYyG1BZBLohjSJRG6S49IIe5NqFhsV30voW+CT7vW4jT8W9bI3Y/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770088817; c=relaxed/simple;
	bh=p+FiLRV+y9yrAkTwRKO1Fs+7DQQpdn3ZhTr9uVCv5u0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Om0Nlss7t0ruAm0LBdsmCLU2nkUaKNX41H6idhp2e827BzszrbNRr2vcc3Z7rmVJvnmDERy7NSB4zfpz2je5OQKBoZ/GbRv5MZJ3mkU3vZ8VqOBpcHJhLsuyFVJ0XxlkHoueShpIj+xSy8fC2asdlj7kg5uo0rMdHGWNDyQhhzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFr/7be7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFr/7be7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F46C116D0;
	Tue,  3 Feb 2026 03:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770088817;
	bh=p+FiLRV+y9yrAkTwRKO1Fs+7DQQpdn3ZhTr9uVCv5u0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WFr/7be7IU0hP9/394w9OwSBa7mSWQuGh/yeC0BaaQYaNsYilI+9C+oHWuoIYAIB0
	 /I2eAkeBKSArSS37VUo3nNgSYl1jdV0PtcGFsxxN6H2e41W8DzNeLSUixoGeQJYvds
	 EXDgBqVqpcWeybo7BszMNVngQr4EwhDTpqCTlWncvWWykU/tAGEkx2x/7gOFnSv41b
	 T6K4ogCY7Retz8xrCt9jlhMuHhyLiKhGWpbuIMt1iUoCpKB48ywvuqzsF7RWq/G3q8
	 rJtCyLwXMuEIE5LPdFjXhRwOrSXmdSoiI9qIxFvTFdjUmSeUaA3IRs8F4kf4NL3PNw
	 YWjL3ZWlVxJKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 541EE3808200;
	Tue,  3 Feb 2026 03:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] Add support for Renesas RZ/G3L GBETH
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008881412.1295553.10983924810242410033.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 03:20:14 +0000
References: <20260131161250.5047-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260131161250.5047-1-biju.das.jz@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, geert+renesas@glider.be,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, magnus.damm@gmail.com,
 biju.das.jz@bp.renesas.com, peppe.cavallaro@st.com, joabreu@synopsys.com,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 31 Jan 2026 16:12:41 +0000 you wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> The Renesas RZ/G3L GBETH IP uses Synopsys DesignWare MAC version 5.30
> compared to other Renesas SoC such as RZ/V2H that use MAC version 5.20.
> 
> The RZ/G3L GBETH requires an extra clock compared to RZ/G3E and has pps
> interrupts. Document the Renesas RZ/G3L GBETH IP in bindings and add
> support for the RZ/G3L GBETH in dwmac-renesas-gbeth glue driver.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L SoC
    https://git.kernel.org/netdev/net-next/c/3ac2aa31b489
  - [net-next,v3,2/2] net: stmmac: dwmac-renesas-gbeth: Add support for RZ/G3L SoC
    https://git.kernel.org/netdev/net-next/c/1ba377008420

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


