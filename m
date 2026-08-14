Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5053264D2;
	Fri, 14 Aug 2026 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786742455; cv=none; b=UYnU0CFv0Rd6eHop9wRSPh655AORLEOFl1YuTvVTaJEVQtyfq4wMK0/F3Is/C7syHa6OqGkRHsQlCEt/p5pugM6BBjWJqjjbmnagGzPWgxpBdr31FIKi/zAFzR/H13jkaHa63eCjKL9syUuU3dR3oP1fyNWDDrxJXshLJ9YynSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786742455; c=relaxed/simple;
	bh=jUWRh5T/e0WWQ9jSKVf/Dhs/1gQBMu8bHd1/ve+0A3E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HGQZcthbdPTR4x5IWI9jOzHoN/QTVZqSzof42GEN5/6M4jjFXc5Gy0kDqqQK00oc+5a5Z/qdPdcQgeUvo6GYEplbq6oAwnTKi6SmOhqvfPs3VXZOD3osbEyjk9cKWITemEZ4rkg6Iky2t3oKnZ6CDRYrmjKy75MOfrNGFbhaVV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwX57T60; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwX57T60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1301F000E9;
	Fri, 14 Aug 2026 21:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786742453;
	bh=lmomJrdN9GRsxsS5wir260bx95LadTs8uBneaUWXZdg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EwX57T60rCVeGeypd59fPIsJZG3bDNZqO5ExMKk7xAUbSc5Qi6opPPRU3Q6gEmZB/
	 716fD11cPXuuZuHUOgmXW8Znorof1xBVyjtfsgGtq0wSEly/4wiHnocuww/Z6OAMZx
	 zw9Ujqg0Hc/KfSYdGdMUjcRsszNZcaBU9Hq2rD5bL9BLk4z125XmOPllrPLOXZK5ck
	 /IqjsNnZF0vQU6+H8MTLYU5XEUxqZ/729u5okgAaWWmV43dEMWNXMPA8T1oZjkOpvQ
	 4hTm0zoQ6XpS0Z3kJ4UY4kmKXqgAhxxqozpblbjR5ETHvf1sCH10n95eixIOqFnC5Y
	 uri1tQ1zIe6Cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938C2392445C;
	Fri, 14 Aug 2026 21:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: drop explicit NULL comparisons
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178674240713.3963717.11667328689936932143.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 21:20:07 +0000
References: <20260812060644.210997-1-kuangkai@kylinos.cn>
In-Reply-To: <20260812060644.210997-1-kuangkai@kylinos.cn>
To: Kai Kuang <kuangkai@kylinos.cn>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 f.fainelli@gmail.com, linux-kernel@vger.kernel.org, kk47yx@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 14:06:44 +0800 you wrote:
> Replace explicit NULL comparisons with the boolean form to follow
> the kernel coding style:
> 
>   dev->class != NULL  -> dev->class
>   user_dev == NULL    -> !user_dev
> 
> No functional changes intended.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: drop explicit NULL comparisons
    https://git.kernel.org/netdev/net-next/c/e6a5d573d24c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


