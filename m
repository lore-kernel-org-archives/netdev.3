Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0E0175A9F
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780710623; cv=none; b=JSKre1yEYytu0jfrC4I4zozNzjHXLhYEtRJAOoccSLtMOuDD1rq7kG1wfNpieD3oRQoGDnBqCQqN3zeTnxAbJGXArIQ5NXHSPDcpfvdrWeeQ4AQ9WDBuSTSdUARVPz7g0cjkcKT6NMA3uz/9v7SoUNsLt0L4rvEwmPMJvRfR3QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780710623; c=relaxed/simple;
	bh=9A//HkLxns69/2gKLXZ9LH8noEMQ5mwmhMtBaVTwDvI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=scsq6ObYeepg2WSDCg3PkpG1fFP+KPFXLbj4kRPwlSxHor+QMIKUXqFUDKE75OZFCmJla+7k/sTFIG6uapSBhsNdVzRMT18+eL7FdJyYqY8LGgwdWUxEl8h+33js+4GgDbHbUsFABQNfLK1dkqTlIw3F+peDm/G5NLgNVdwf5XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A95t89yX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A95t89yX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BDD1F00893;
	Sat,  6 Jun 2026 01:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780710622;
	bh=5LW6S2oBmnPZd9KzEU51RzmswJSF4t6mCUZGNBLu2C8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A95t89yXuDbE6NzKHFPTm19OUDM1zm2CNxLsGQe7PCqfEuftLtMtGaXJY3ra7ndac
	 F5P0AE6iB8DBHUcspikE1dd8qOYlNGGBb2Ko4k6C4jJZIlPQnScdclARKZ3P8GGBWD
	 kyqbpLNV52b2kWFxurJ+3itZPmnAGA6mNxpLl6w3R5U6tHwgxF5BtW3OeigkWbtvsB
	 nEhu0QwXPxNfPR6BZ0UejLtR7vHAH8XYZQrj5LvwiXr5tbBqKCQqHxzcWAOpEj1NT3
	 nwJpUK9kbWlMGTIHx6t/8RAUbNzHvo6E0Uag8URHoinTNOsANT3NeV1BFLIJLmXRpa
	 iDoO8grISjgGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A293930A9C;
	Sat,  6 Jun 2026 01:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] net: mdio: realtek-rtl9300: Refactor
 initialization and port lookup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178071062213.3989414.7977440712530638857.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 01:50:22 +0000
References: <20260603175924.123019-1-markus.stockhausen@gmx.de>
In-Reply-To: <20260603175924.123019-1-markus.stockhausen@gmx.de>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, mensi@mensi.ch

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 19:59:17 +0200 you wrote:
> The Realtek Otto switch platform consists of four different series
> 
> - RTL838x aka maple   : 28 port 1G Switches
> - RTL839x aka cypress : 52 port 1G Switches
> - RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
> - RTL931x aka mango   : 56 port 1G/2.5G/10G Switches
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] net: mdio: realtek-rtl9300: Refactor otto_emdio_map_ports()
    https://git.kernel.org/netdev/net-next/c/f369dd8ccf2d
  - [net-next,v2,2/7] net: mdio: realtek-rtl9300: harden otto_emdio_map_ports()
    https://git.kernel.org/netdev/net-next/c/829ee0f8bc39
  - [net-next,v2,3/7] net: mdio: realtek-rtl9300: harden otto_emdio_probe_one()
    https://git.kernel.org/netdev/net-next/c/67885c0e3919
  - [net-next,v2,4/7] net: mdio: realtek-rtl9300: relocate topology setup
    https://git.kernel.org/netdev/net-next/c/94f05740ad16
  - [net-next,v2,5/7] net: mdio: realtek-rtl9300: relocate c22/c45 device tree readout
    https://git.kernel.org/netdev/net-next/c/439aba443a80
  - [net-next,v2,6/7] net: mdio: realtek-rtl9300: reorder controller setup
    https://git.kernel.org/netdev/net-next/c/56b486415097
  - [net-next,v2,7/7] net: mdio: realtek-rtl9300: Correctly handle ethernet-phy-package
    https://git.kernel.org/netdev/net-next/c/50b682a5aed7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


