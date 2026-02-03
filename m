Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028333D6EC
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120672; cv=none; b=FplFeEti/8JiMxF8zz2LEceZyPDWJlljSDIbW98oVmsq6WHD3oNCxEO2DAFBnMSLWKlFQl2/HSkIPuIK/M+iuR9ND7OTrbfvv9UNKB0i+SaIa1Gqcx45obvGuCUyfXJTmPbA+v0QWdVHfX+2m2FSvb4/1Ln6tM+CFe1F+6XK3hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120672; c=relaxed/simple;
	bh=btxg6cj1MpBBv6o4ZJYl1baCFxxuZ4c10nHxlIhqYoo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cCgF6rYUcoj1HM2dCP4LmLokdfks0E/CkTOEYDYyxnZr9P6hLDmB0x8fvhBjrBUrbW8NzgmMplZrW34V//KmRmZRVuH/HRr+aQSrf8KmOKl/uH+ZSRuU9zZUeUNfrmFHupDgr45h02rHtpZGjrzKMqF7fNLlm02umyoGgLIGCp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGZ2/SRA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGZ2/SRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE15C116D0;
	Tue,  3 Feb 2026 12:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770120672;
	bh=btxg6cj1MpBBv6o4ZJYl1baCFxxuZ4c10nHxlIhqYoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SGZ2/SRAXajDZdpqulGGDjLUpDDrzD7n9EtIxq+pSFqGBLPLSS7YLf3QRYb6EqtEV
	 NpSSDMN00B9K+YDXljuZIYzCFmFnWWH35PO6aexsqW1TsGMKj8SCyIBTBAXRCMlulQ
	 SEIvuObqc6g4l7Z8jY7FghpWJyapY/wruw8vEQn5rBQPPO1hRRxwO6mUI4b07Zs3f8
	 eVenCxqYv5n4XkNtDEjT4Q/AgmxXdCXXl9+DpajknQXLpQVf6ZW6zAoIAc6Rhn7L9h
	 j+fWquTuRoiAyG5gOiScllfVbrKlPLh1y8Fq7ZrJRdseeUm2cG636YAVxeG+rpsbeR
	 HNEKTUl3urhrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16EDE3808200;
	Tue,  3 Feb 2026 12:11:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: phy: remove modalias-based MDIO device
 bus
 matching
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177012066888.1451422.8966131592859053735.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 12:11:08 +0000
References: <d9543e7d-23e1-4dba-a6b3-35dcd6a35dec@gmail.com>
In-Reply-To: <d9543e7d-23e1-4dba-a6b3-35dcd6a35dec@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 pabeni@redhat.com, edumazet@google.com, kuba@kernel.org, davem@davemloft.net,
 horms@kernel.org, michael.hennerich@analog.com, alexandru.tachici@analog.com,
 olteanv@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 31 Jan 2026 18:36:07 +0100 you wrote:
> modalias-based MDIO device bus matching has only one user (dsa-loop),
> where we can replace modalias-based matching with a simple custom
> match function. This, and first patch of the series, lay the foundation
> for removing modalias-based matching.
> 
> Heiner Kallweit (3):
>   net: ethernet: adi: make name member of struct adin1110_cfg a pointer
>   net: dsa: loop: remove MDIO device modalias
>   net: phy: remove modalias-based mdio bus matching
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: ethernet: adi: make name member of struct adin1110_cfg a pointer
    https://git.kernel.org/netdev/net-next/c/f7aa2ef10c0e
  - [net-next,2/3] net: dsa: loop: remove MDIO device modalias
    https://git.kernel.org/netdev/net-next/c/5fddafbb92e0
  - [net-next,3/3] net: phy: remove modalias-based mdio bus matching
    https://git.kernel.org/netdev/net-next/c/3051419f3d1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


