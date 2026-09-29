Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6239E331202;
	Tue, 29 Sep 2026 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689207; cv=none; b=PPAnBUQkKikGvbVmW4i5fY0GH4c4mnkqu51QEbdeorGH7XGERUmTz/zohnxXVETvbS0igXPWch64Z9iCna0CQU1SvVkrGi4TF6ERlSzAGokj1OFy2KB7mI80f5Y8G2aE8/bmyyWH9CWa6jm2w/phr7HIB39yB7fTJFNTct9m+Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689207; c=relaxed/simple;
	bh=AuBWi32tkEMNVzYDplDlTjW14uCdZcuRyR1eScXAIhs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cOKnIfu2jQt1AZ/QCtSTdyXq6OVF0WW1MsOAnpR4Q/Fk/pnpufc+edTM/BQsE4r2sBK3opErLNh1UvqF+UKcf3rzsgRFQxS3eu8ZedApIwNptZPAY2orEGwoFK1EFoV7XdGnkLpjxRUpW1TQkT6RXhNY/5skitHBSyxD2Cc67S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bY54g9ZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bY54g9ZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428851F000FF;
	Tue, 29 Sep 2026 13:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790689206;
	bh=E1oWpGlnWZrrnOKSIBK5kkFjE6SVUqRRWUCgnGSeA4Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bY54g9ZE0mn7qMHwXKXzh6F70Bi4fO3HphGHwcZ86fZZVEWVrZkgDCihdT+fr7iFe
	 t+6OCBV9KV0njtCt2q/SDRF3p76An7fRdX9l2iGrbWSqW4oUYQKKN2Ps3dfbREwTh9
	 By6ROYQBO8ejG4lNvDa/Wxrtv1ehhpvahXWBxHFsbwxfzVpA3uTuWrLFw2loSX/vcc
	 kOqCSZpvMxWoP1bTQhNUfgE/wHSTRMHeo1vTmATXsmUYlgKORgpCboFqy9j8Z1Vthc
	 hnt5OSLQmbOeNZX/L67Z016s9lUtiN/SouA3M9jH6qdVup1LsuPpUQhEapYqZQhZio
	 LSF1e75TWRa6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2AB3926662;
	Tue, 29 Sep 2026 13:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] dt-bindings: net: Document Marvell PHY
 "marvell,reg-init"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179068920477.499886.7765098308090780427.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 13:40:04 +0000
References: <20260925140410.1157036-2-robh@kernel.org>
In-Reply-To: <20260925140410.1157036-2-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, f.fainelli@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 25 Sep 2026 09:04:10 -0500 you wrote:
> The Marvell PHY driver consumes marvell,reg-init as one or more
> <page register mask value> tuples. Define the property so dtbs_check
> validates the existing board descriptions.
> 
> Existing users have no compatible or just "ethernet-phy-ieee802.3-c22"
> so this has to go into the generic ethernet-phy.yaml schema. Marking it
> deprecated both for that reason and because opaque register
> initialization values are discouraged in DT.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] dt-bindings: net: Document Marvell PHY "marvell,reg-init"
    https://git.kernel.org/netdev/net-next/c/63f028c4dd73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


