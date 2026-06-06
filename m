Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05D25F98A;
	Sat,  6 Jun 2026 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780711829; cv=none; b=f7sLnvteqE3j2B7D2BfhxFX6d26nCK2YOiG6y6Y4BTlLrlbIPATjkd74BUEUD2Jyg7/S4/f3Vy4Zhw3ZWAmRWmdLFoKidqEqSO+CdJB5dOB5+azPspIfY3gVclFHkMIisrbg59kIur1hr74tWVpB4P7IQ4TTO2JOU+OOVKJ7phM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780711829; c=relaxed/simple;
	bh=U5lQfFk4/Ae5lsGnjjZ9E9iayu5QOrPaJ4iRYH/LfS4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RuY1ikqHXqO6LFt9k7NSzXCnUc7NpWitzuEJsn2rpHhce+miMgxsrrjIXUULo6HPrsoyf1fi+a+qdCjSNzm0MzLBjIIk6bI4EAOOd0Xfh6FEOfONmMopVIa39YoKTjGlrZi2sBiV8TdVAkSvje5NbLHrVGFpsSzchGpZzMOaJRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEZ2zJL0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEZ2zJL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FCF1F00898;
	Sat,  6 Jun 2026 02:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780711827;
	bh=IJ4dvH1AwTrkcpbGD0pqq9b3zvNc2O1tgQiFh615F/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NEZ2zJL0FHiZnWoXcoL3deD35EaC+m68Vw79F8khU5o7rtOTWMmd/UwILCHmMWOj2
	 oCblPP8M06oMtpMdE3vxLhAryFjbfUHrRChAT1coloYCjSgWBaBXuWFmZ6pIFvXrWX
	 D5RREs4qZfT0/JZu/g9enIZ/H3VtMpSQ+C97Ies3c6c58bQd8z3ExwUGSplh1PYRby
	 nDpppBF5ImVpOPSV6uBLF/b3DcJGHLnT3eO4TmJIw0wXRBlw1umveZdmWN4ZFRQNr/
	 WOEv4qIe++HFRa2JRzbRa+Gp8EEJ6zy93J5UFD4qZcxtMtR40PcDgC3QsILFCWpyYY
	 vYrPU/bXHUd+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939CB3930A9C;
	Sat,  6 Jun 2026 02:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: microchip: sparx5: clean up PSFP
 resources
 on flower setup failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178071182714.3993660.9574307915751571601.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 02:10:27 +0000
References: <20260603061716.747282-1-lihaoxiang@isrc.iscas.ac.cn>
In-Reply-To: <20260603061716.747282-1-lihaoxiang@isrc.iscas.ac.cn>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, kees@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 14:17:16 +0800 you wrote:
> sparx5_tc_flower_psfp_setup() allocates PSFP stream gate, flow meter and
> stream filter resources before adding VCAP actions. If a later step
> fails, the resources allocated earlier in the function are not unwound.
> 
> Add error paths to release the stream filter, flow meter and stream gate
> when setup fails after they have been acquired.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: microchip: sparx5: clean up PSFP resources on flower setup failure
    https://git.kernel.org/netdev/net-next/c/46e503673387

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


