Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B527A36920F
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 04:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769745630; cv=none; b=NOmSeERLUyk2LkBgHzHPZyhdSZqeZHmpY2M5k5gOltjswy3Cj6CV41prBpB9et0MGpP9aBBGbv0KB4b0uI58iIzBjm3i29TZFxwGCHd1R+d8aC7F1/cuU7xtztT4kB66iqaIdiAe+iNc2rW/Nu/eCZVZSpqqhow50xNNWqqUXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769745630; c=relaxed/simple;
	bh=UYRkCV/YoTTJYVQUSb1FQeBL9jQSsiFm0lWs+A6DAz0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sQYcN93xFoLU5z6V1QfL/DQoPJ1LQ4MCleKvSIyTZIC55b/2sx/1DRH44ypnvHIeO+LnbenYeDCP/uKm31LpWSkYXg98NzRFpn2WUkuEQMkYgObV2LUNFro/dGbDQEvHIG6qVZYL+YtLQ4YyD1jngBqmAZ7nYyUGrB2r/erm7ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOTQP3G1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOTQP3G1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620BAC4CEF7;
	Fri, 30 Jan 2026 04:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769745630;
	bh=UYRkCV/YoTTJYVQUSb1FQeBL9jQSsiFm0lWs+A6DAz0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZOTQP3G1PcU4v9TKah0zF/6Y0dTDX993h61Ybu6n3g8JrkYJSp0TiOQWMF+RPxQb2
	 W/00yebuxGZmvNZL/XVzDTOyi6NVBxmydDQmwRX3WDbUef58zQweuCpgk3OAI9xNTz
	 oOLcX6OwJc1Xh1BWdUj7genZx8ggfMA7lKvycGr4iXrbNKBJE1vYrVrQ3/Qz8vA/6a
	 Cwe46nzHJApU9Net6s4rPBOX2tBSnNmkLPufugCm8BJpYlOHlXcfenhrogMK48pLyR
	 F26sIrWpU37xSb82Gpw+u0g4Oe2wYo8E3+sCZgXQ1QVkkA16Wps1QFE77ES3h3jA5w
	 G4+Tjy5lhbghA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EC5D380CEE0;
	Fri, 30 Jan 2026 04:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sfp: add quirk for Lantech 8330-265D
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974562285.3166473.8868213324194420298.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 04:00:22 +0000
References: <20260128170044.15576-1-kabel@kernel.org>
In-Reply-To: <20260128170044.15576-1-kabel@kernel.org>
To: =?utf-8?q?Marek_Beh=C3=BAn_=3Ckabel=40kernel=2Eorg=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 hkallweit1@gmail.com, andrew@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Jan 2026 18:00:44 +0100 you wrote:
> Similar to Lantech 8330-262D-E, the Lantech 8330-265D also reports
> 2500MBd instead of 3125MBd.
> 
> Also, all 8330-265D report normal RX_LOS in EEPROM, but some signal
> inverted RX_LOS. We therefore need to ignore RX_LOS on these modules.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: sfp: add quirk for Lantech 8330-265D
    https://git.kernel.org/netdev/net-next/c/86a8e8e0ddbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


