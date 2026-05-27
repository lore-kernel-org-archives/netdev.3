Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF32DB7B4;
	Wed, 27 May 2026 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779841807; cv=none; b=gOnXd2HyQEfR/If7grJN8+5FC8vb6o37cYr0/qbNLuYfat30zD+hOv9KzDxL8YVVdss9DmfD1Q81ZDw+JEqurd/QFq53DdG0cfq93cChO6P0iPpA6fPabCuL5ekNUldKOhv6xqtsThoPsoScgfN/Zat9QqzP3rs+2VGWtTHY6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779841807; c=relaxed/simple;
	bh=wp3Tl5CZ+2Ak2nsfCtU4+boSUsUxsqPfF9/tXoZCZ9Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CqYKdn2/QuQVd/eSsef9f9gfhuxLbUNO40y2GSg7BmRPPmRanDTmHwYWifNFN6jTDZFSaLyvR+rrcCoHE1yEnmA0W9uy4Ec3gi5QKs5IVzSUvfqq7c5SlAwfe9ItBnWp0R6fIWrFyKu0bfHBlE8GMYTqtiDIQ8F798OPsnBQTmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NshWSS4r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NshWSS4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613481F000E9;
	Wed, 27 May 2026 00:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779841806;
	bh=1Z60F6cDVz3kodQ30SO9yMH87eRiv640ER6fhZmMojY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NshWSS4rinS2kuC7P2tPqV3mbRosme42bFKpCOjYrcCIqRwZp4CZijKvGc6J365ys
	 JuNmiteSLhoAc16OE71ttAuYcvh1rZHJ461dmPipvfl+fJ4fEcDLvuP2kDJbAU0V2P
	 En7qCh08cm/zvBg3usEtMaW+Cqqs4zeF7RtFZGDLdCOeycRb2ld6rpCLfRby8LAAUU
	 mL7d/U7CAr/s2H1PrdQItBXvXBlgL58BNaRfuJWnP58/loAVgLQunULHZbrYcEpWAb
	 cuRHuhac/TKrxI+rKV7aex2CgIbGiXWv8FX6ksD/J1YE6jHC8kZwev3pgEjXXD8Ff7
	 NRnpD7+1WuYHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B3F380CEED;
	Wed, 27 May 2026 00:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] Add OVS packet family YNL spec and
 unicast
 notification support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984181194.4027067.4872626990615141837.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 00:30:11 +0000
References: <20260522174154.720293-1-houminxi@gmail.com>
In-Reply-To: <20260522174154.720293-1-houminxi@gmail.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 aconole@redhat.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 23 May 2026 01:41:52 +0800 you wrote:
> This series adds a YAML netlink spec for the OVS_PACKET_FAMILY genetlink
> family and a bind-only ntf_bind() helper for receiving unicast
> notifications.
> 
> Changes in v5:
> - rebase on net-next to resolve conflict with Ilya Maximets'
>   ntf_listen_all_nsid() (requested by Jakub Kicinski)
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] netlink: specs: add OVS packet family specification
    https://git.kernel.org/netdev/net-next/c/b82bfddc46e2
  - [net-next,v5,2/2] tools: ynl: add unicast notification receive support
    https://git.kernel.org/netdev/net-next/c/b74e71b6a986

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


