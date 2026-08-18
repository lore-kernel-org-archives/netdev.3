Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB65224AF9;
	Tue, 18 Aug 2026 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787014271; cv=none; b=QSwkIwmWgKQcyoXuLHQGWACLLbSgzDkNd08L3GIElt4LRQcor8bksVthiIGKfAPQgFyiHoztf6xtsDOKpAPOotdeiRbF7thi5vNlYDNb3EIawoO8ZBjyzDID2LdicakjEheKne99QG1WQHowKB6Zgm2jRecKaymXaNPw6nc8XSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787014271; c=relaxed/simple;
	bh=+y3dTlNG4kYLvFNbddiBAdgoPHdsN1OpAlWDudnoQ3U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dXYve0WM4+SxqtRAIVTfs7K2p/ipFOAWSS+tgUAWskw23aoKXvIXphLxmuqzGS28qpkqcl7HS12CBUAI2Pnj3TgLfK86Ew7VxQeUuR9Uxvq0BK2ehEdCZwNy71CNHJUyVJW2YNMn5CZfIbneaZABwCDZH8DoWz4vf6D52/F9Xdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMR93SiL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMR93SiL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D556C1F000E9;
	Tue, 18 Aug 2026 00:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787014269;
	bh=fp6WkfiSnGv3purJXOt/8yMK6d/eVQIuMad7Oi8aBzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JMR93SiLmj1t7LBS0mg1haOT8e+RX8HRVXDcu2Tfhag+v/Sk4ELLfiCdXt3mrgU7K
	 J9Zb/gMyQxHHlVChs7I7LUj95N6sUX4h19cvejC2vu0JUJDSb1EJSnjFruA0vOhAmO
	 FlppjtlLcdKepLy0bxpPHYA4ER2cr3W6Cx2yT3EDH64Z2ZMfF/sKbSTu/o+1BxW62Z
	 0wYQmnMzRKAz3NuieIjiWyaxq9DqkBhBvLc9JQ456VvQ1slKUrUD6miX1EZdML2O0L
	 GLXnxmAWf3lzuNGbztX2IJowenionu5mD70DhdDAESE1rU+zKtHsvtK7/awp06Vg3w
	 XAuVNVVQPp/pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198313926278;
	Tue, 18 Aug 2026 00:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v13 00/11] enic: SR-IOV V2 admin channel and MBOX
 protocol
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178701422164.1808735.9583213568071804672.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 00:50:21 +0000
References: 
 <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
In-Reply-To: 
 <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
To: Satish Kharat <satishkh@cisco.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, leitao@debian.org, sebaddel@cisco.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 05:48:00 -0700 you wrote:
> This series adds the admin channel infrastructure and mailbox (MBOX)
> protocol needed for V2 SR-IOV support in the enic driver.
> 
> The V2 SR-IOV design uses a direct PF-VF communication channel built on
> dedicated WQ/RQ/CQ hardware resources and an MSI-X interrupt.
> 
> This series touches enic_remove(), which is also modified by a fix
> already applied to net:
> 
> [...]

Here is the summary with links:
  - [net-next,v13,01/11] enic: verify firmware supports V2 SR-IOV at probe time
    https://git.kernel.org/netdev/net-next/c/a16975e2231b
  - [net-next,v13,02/11] enic: add admin channel open and close for SR-IOV
    https://git.kernel.org/netdev/net-next/c/3258931d4052
  - [net-next,v13,03/11] enic: add admin RQ buffer management
    https://git.kernel.org/netdev/net-next/c/a0da4ea750a2
  - [net-next,v13,04/11] enic: add admin CQ service with MSI-X interrupt and workqueue polling
    https://git.kernel.org/netdev/net-next/c/cb1dba54c723
  - [net-next,v13,05/11] enic: define MBOX message types and header structures
    https://git.kernel.org/netdev/net-next/c/1584793311ce
  - [net-next,v13,06/11] enic: add MBOX core send and receive for admin channel
    https://git.kernel.org/netdev/net-next/c/1f0c856b5963
  - [net-next,v13,07/11] enic: add MBOX PF handlers for VF register and capability
    https://git.kernel.org/netdev/net-next/c/06bdfb16216b
  - [net-next,v13,08/11] enic: add MBOX VF handlers for capability, register and link state
    https://git.kernel.org/netdev/net-next/c/72b65c94058e
  - [net-next,v13,09/11] enic: wire V2 SR-IOV enable with admin channel and MBOX
    https://git.kernel.org/netdev/net-next/c/4ff204cef01e
  - [net-next,v13,10/11] enic: add V2 VF probe with admin channel and PF registration
    https://git.kernel.org/netdev/net-next/c/b2dfdc966b65
  - [net-next,v13,11/11] enic: re-establish V2 VF admin channel and PF registration after reset
    https://git.kernel.org/netdev/net-next/c/885f462fe90e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


