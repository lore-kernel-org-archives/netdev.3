Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1279A37F01D;
	Fri,  5 Jun 2026 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622418; cv=none; b=oIYXrP6ZDZG/zItVTJ1qljkcl5zoVCUMKunxV8ZF5z6+MjTB/DLfmXGIkm/CI1dGV5OvO28xApXlor6Y6wvwlgQuHMnCzMoz07yflJvFzHhq9vNTJBwkCy9eN4efsrz7oJ74FMH7xWvGtmXM8xl0y5fFuVunj6SEKyRQ2O4f4fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622418; c=relaxed/simple;
	bh=wgeL6N30aqp3zg58queOOBPIFVvApd+fuUMotuwatBc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C/wIJNWo4iWZBcQvbfjZVWHvCr0TbrXuKc1E+lNjqRVzuiMyo10JKO/mlDVF6o+nIEQ4pL1ihcT31pweWWroXvddSH2nxHR1fPPFVmBvjwsDFA/HRlKYkZHC4lToaVOLp5WiiC6QoydgNwkamnUdw0LB0vbMx+sUUGtQf3WpM0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIk4yk3e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIk4yk3e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728471F00898;
	Fri,  5 Jun 2026 01:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622412;
	bh=C14zNPeB9pcCuzhIAG02oq/Y2iKdXBs1TI/eaNKG/PY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hIk4yk3eOKjsZICW1ttEmm9XrDJ1f9dRz9wATZmMQo7poF/MBFZTxDfIHWEfYobok
	 ZrU6uWzwhbceIYPzL0ZZ1541N/Ni/++CWHxqx/XAMNoEPLCEmgvU6zH8W9P9S5TUty
	 r3Q4QtKAubFE4UFrY6ZXRhhgBJ6HdXv/nkjFzyLZCg0yB2izhe191K+Oa8NCYatuuF
	 CzEocS25Ouqlub5hk3N7kw1mWjIegAr52RFyYI6QejHBY2Q+sQSvB8FOjhu9+lq52i
	 ytYAwB1aHQM4iNk+DTCEptWLauN+tDPXQBMNd3uEo0Qwb8CtDbzmeicBcevrzGGzid
	 OHyzHnZRuiF+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569663930A8A;
	Fri,  5 Jun 2026 01:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] rndis_host: add LE310X1 ID and enable
 low-power handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062241289.3090676.11112897312784678410.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:20:12 +0000
References: <tencent_29CB862D5756CBCBAFD2EE436EBAC98A7E05@qq.com>
In-Reply-To: <tencent_29CB862D5756CBCBAFD2EE436EBAC98A7E05@qq.com>
To: Shaoxu Liu <shaoxul@foxmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 17:05:26 +0800 you wrote:
> This series adds RNDIS support for Telit Cinterion LE310X1 and then enables
> USB power management for that specific ID.
> 
> v2:
> - split v1 single patch into two patches, per review
> - patch 1: add LE310X1 USB ID only
> - patch 2: enable power management only for LE310X1
> - improve commit messages to separate enumeration from behavior change
> - Link to v1: https://lore.kernel.org/netdev/<replace-with-v1-message-id>/
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] rndis_host: add Telit LE310X1 RNDIS USB ID
    https://git.kernel.org/netdev/net-next/c/c847ff789f01
  - [net-next,v2,2/2] rndis_host: enable power management for Telit LE310X1
    https://git.kernel.org/netdev/net-next/c/3dfc7fe1d553

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


