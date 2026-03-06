Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4198535B639;
	Fri,  6 Mar 2026 03:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767978; cv=none; b=uuWzbNrQxBkNmKbS7FNlFwNvb1kBodWwquwP72EqB/gymZMPr2gXYhmX5qFU4aiyvAXpFbUwwv5q1ALheOP6PY0nMg4nqsU4zGRMMa4qYgTJM8EObF/RWQbD4waqoF14NbDPbUzTDo9MYMmKBayBY1ncD0lakC5EvEj+C+HAD+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767978; c=relaxed/simple;
	bh=hsY3bvZ4TCYzEW4tvQoXNtFrLnoXcnZYK1fC+6mPjZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VGDm4Vj/sWjFlzqDHzirKaRtpMDlmeXNta7lGhrlLVvqGxfG9+nSFSDMPaX0oLpC9eXee2W2hicgO5k+bbt8ieJiDNjpTQTRqjrwCcYB+UXHpowW7SXuZhPz8EBdaQXieg7t8ln9QWiahCCNWttC+mqBDWBkYjgb3Qg1CB7IEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL75Gy+4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL75Gy+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1355CC2BC9E;
	Fri,  6 Mar 2026 03:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772767978;
	bh=hsY3bvZ4TCYzEW4tvQoXNtFrLnoXcnZYK1fC+6mPjZA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JL75Gy+4jKfUcaeTgJ/wnXcNbEJ3WByiOAlwPs2Fb8P2NPqdDrGhSKgCs085mU3C7
	 LJSockVZ8BoXqdg80txkkPs64Oq6voj4JGgNm0lqIepH7Jl3Cwy3MxgIBTXv7rw3t4
	 fgGgMb/jzzqa3SL2JVTWGNzzegx1eqIw4ecx9UbFBHUiyC/dcs1uwQDrB9MF9jHJQk
	 p1wkliWHQHuKF435S3O90kiB+74169NL70nkfQGSKS0CgEqvnu8+Mh+8NKOWs3TAqF
	 ZTuogOK2LYy9yWLx+0CwANgna/M6jt4KuVjNoaTnA644LdRWEn8+XJ4K0I9s7wF3Rz
	 c0II9pgD0E0Kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E843808200;
	Fri,  6 Mar 2026 03:32:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: realtek: Add support for PHY LEDs
 on
 RTL8211F-VD
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177276797780.3348267.9197951940676429805.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 03:32:57 +0000
References: <20260304-rtl8211fvd-add-leds-v2-1-d50bd8a50f08@gmail.com>
In-Reply-To: <20260304-rtl8211fvd-add-leds-v2-1-d50bd8a50f08@gmail.com>
To: =?utf-8?b?S3J5xaF0b2YgxIxlcm7DvSA8Y2xldmVybGluZTFtY0BnbWFpbC5jb20+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@makrotopia.org, ondra@faster.cz, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 04 Mar 2026 13:03:10 +0100 you wrote:
> From: Kryštof Černý <cleverline1mc@gmail.com>
> 
> Realtek RTL8211F-VD has the same LED configuration
> and registers as RTL8211F.
> Use the existing LED related functions for this chip,
> so it is possible to also use the netdev trigger.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: realtek: Add support for PHY LEDs on RTL8211F-VD
    https://git.kernel.org/netdev/net-next/c/752941e3faf6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


