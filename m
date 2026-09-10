Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7632325483;
	Thu, 10 Sep 2026 01:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002077; cv=none; b=rCGtB3Ri/mf9+5zNAtDJdWZXcCjiaZ3BFw7iDF+79EadT1jDlOm6NcwJfee8v/1T8/50VTI33aMo3kObr7l4z+0o9CViznmC2Uo5OtVBVM6V6XuVFW7XA8+Q0tQoeDUjfLIVlNunSv+1wf0JAhS09hu9eSeF/dCk/BohmPK1lbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002077; c=relaxed/simple;
	bh=W1J66sSzRZ6mpb192EcVnlTAzPWZYt6NFxWxayqlqR4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rMUd+n1Dzr2F63cJTp4Q+8xiHK/MiL8m1oQqo/GEgZAcUarnk2gvTRPE/BE/wtjbL+BoBfSiugWmnfz20rG5cF6ZOU1hQU56dXmVR7TgDJ5Xuw1G3Ec7L9fFPN37HPnufggqHtLPfHpdPQFs2XCewP7nZyQaE4Sr0LbanVBf6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzkUEok9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzkUEok9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCEC1F00893;
	Thu, 10 Sep 2026 01:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002074;
	bh=M4dD3B/tWNuAF0fQ3wPI7IRujH8Qt2qZwSA9+67I0AQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MzkUEok9sdukJy4AyNqVbzBg3auQIdn0mB5fQmAMWoqQkmq8mEdG5CgFquHGjcm4y
	 fPZW7NH/YBcrvlic6X1ZDf+vP7qTw4noLaSeVZYdW1p2pFekaDOX53VT7wWVcBR5ZP
	 1SRBvhEmkGlNDSPl0lP87oWwQWZQSJKrE6y3KvqL7FpUtyDY10LuKyiD5rNxF1yErm
	 nkeoV/STf0SDWVJdV6+vaEWX7WzNdbO7dvVH5PfIgyTE8Z7q2Ob0+TCHf+8eymL/go
	 F0pJLKNGfB7JYX7FTT78De7Xs60ZxvWynNRXWthZOvnteAMsbg5k3qt4N5boe0eWro
	 M0TgIUHzYoprg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93995380CEC5;
	Thu, 10 Sep 2026 01:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] net: dsa: lantiq_gswip: SGMII/2500BASE-X and
 flow-control fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900201212.1131357.10042616756213166682.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:00:12 +0000
References: <20260907134818.16670-1-havran.jan@email.cz>
In-Reply-To: <20260907134818.16670-1-havran.jan@email.cz>
To: Jan Havran <havran.jan@email.cz>
Cc: hauke@hauke-m.de, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 daniel@makrotopia.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Sep 2026 15:48:15 +0200 you wrote:
> This series fixes three issues in the lantiq_gswip / mxl-gsw1xx DSA driver
> found while bringing up a MaxLinear GSW145 over SGMII on a Marvell
> Armada 7040 board, with the switch CPU port running 2500BASE-X and the
> user ports at 1000BASE-T.
> 
> Patch 1 reorders the SerDes NCO clock-rate setup ahead of the SGMII shell
> reset. Without it, only the rate the switch was left at by the straps or
> the boot loader links up; the other rate comes up but forwards no traffic.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net: dsa: mxl-gsw1xx: set SerDes NCO rate before SGMII reset
    https://git.kernel.org/netdev/net-next/c/40c578ceaeec
  - [net,2/3] net: dsa: lantiq_gswip: handle SPEED_2500 in gswip_port_set_speed()
    https://git.kernel.org/netdev/net-next/c/6b597ba4c2f6
  - [net,3/3] net: dsa: lantiq_gswip: fix GSWIP_MDIO_PHY_FCONTX_EN value
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


