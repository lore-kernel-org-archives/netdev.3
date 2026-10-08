Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D7D3B14B2
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791484813; cv=none; b=CV/3MYYuF4zLIWh04y3LrOMrxQhhi7w0dVIXKKVmhHO2jfJiqtLIsig0Zbrm2MTQJuRTtjjlw3XVYoKG7j+E5HD/Q8gaGnTASSX7yZDbkpxV7pXwHQpSkFtwPK/fwh8cU5HzwTHh83JUZ/Wt3e4+Dx0AF2T1eF5/URVQFdiQ7s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791484813; c=relaxed/simple;
	bh=lKhyscfF7u8LhiX2xwOq8rudwh6flGB70TJVE0ts6Ag=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ehbva+n1HQkrt91ZX/IZ+5eZxpYKlWcOxr+lZa/tG4eUgDW+Me2W1Hw/GYUYNiJ02xKRT81JhTiSXcgecQiOD3NQfucguKoV1SaWYoX3A9aY1X4z+lIpaZX1w++hb/PV2p+filkqeTc2rPnMkBK2FtP67hPIZSVALUlT1D1ngCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+47op18; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+47op18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8153E1F00898;
	Thu,  8 Oct 2026 18:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791484809;
	bh=VBvWF+7xtKXBHkKM0+0bjHT1/gQPSfNsxCBHralfSOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q+47op18ZUe++ozmpxWA2/4rdP+33lbirN1BBLnEGdqkbBh1ijGzHB2vNtYzXqzia
	 gFy9Ju7TrdxEcVvA7/87iSlbODxDb7JkmOVaahE7rO/UhdFLP2C31dtuYRdD9WYq3r
	 TMW4Yc9nR6gcCVKFM50GOGGr+atl9M4+fn4UmwuW0024GAvdhpjsO3EQ+dj2wkmk+e
	 gF/jhevpUMQzd5Fg6OE+zHKoqdzR//YTfAA34cMcjCSugqOM3hIouU1u1pmsHXH6Xn
	 8R0mDrAlsq+Q/3iNRqVr4YHkQCQR/CxW0g5dZTpbteoIn9I6rKHRhEsvu3/rnk1+Nk
	 Vqmv2atRY4UrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77933380CEC8;
	Thu,  8 Oct 2026 18:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ptp: ocp: fix PCIe delay estimation calculation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148480802.386807.16244290742530706791.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:40:08 +0000
References: <20261007203359.417270-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20261007203359.417270-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Oct 2026 20:33:59 +0000 you wrote:
> The commit in fixes introduced a high cap for delayas U64_MAX value
> while ktime_t is actually s64. This is wrong cap as it becomes negative
> value and any comparison to a real delay will fail to update delay
> value. Use KTIME_MAX constant as correct max cap for PCIe delay.
> 
> Fixes: aa05fe67bcd64 ("ptp: ocp: Improve PCIe delay estimation")
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net] ptp: ocp: fix PCIe delay estimation calculation
    https://git.kernel.org/netdev/net/c/f8c8bd159a9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


