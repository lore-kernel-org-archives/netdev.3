Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339662628D;
	Wed,  7 Oct 2026 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791332408; cv=none; b=XAlO6EOf5/Kgn0bDZ9QJicK+RBvybibO32eLY8dRx1zt5imQocYguQLkIE+yGI5LJTpmNYopSQK3ojDyzmwN+/Tkqzrzh/NEbzz4Y6c7F/TLHjjac0tPDjBgFt1GoOvcvo/9I9smesl7fQsm0Ue7Td8p2jYHRzNqboxSHJUu2ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791332408; c=relaxed/simple;
	bh=NQKd1wvKbVP6aIVtJMZ90fDwme5qyx5r4zjESenfZKQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a5I0hg8T7/bokZ9yiJO5fyYTGPXjjiKAAtMGvmfs6MHoe8XodtWRenPOiVQY9+nz4Qk0r4/Hx8p94wWEnp1UsDp+ET0EWDnBgUK9tzsP3A0MaqIZBTAGbgfRLE2HqlICjdvoVMAZmcW2tIW+3LbSrZVLsjqwjsRttgm/+770DuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebjVResm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebjVResm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0C51F0089B;
	Wed,  7 Oct 2026 00:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791332406;
	bh=QhUOil8dnWtvo6lhVC5HkqrPpvAWi5RA/1fXEAaUm5c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ebjVResmZaVfDON+5ItgOvwUFFGhZxCqcMczsvHr4q7NKVNqWMXOsuv7eJf2ZRNS9
	 TUUmTenDvo++tiRf/xQ9BzD2KHJlPRVxcdoPxLnoU00x88v7/opRQsC7KabeIk3tSx
	 MORF+RTlmKewYRqzvLTDr9Ogcz5GIqPYc4pGZVdPHlgRfXRx3/AqKIQD2oIbQDXoa+
	 WgGM2JHHy+wuRwIPsCZb9bnBa4BNloQmphmK7KcADqz1ghk5m4ES0nqQu+SbtnBUJG
	 ObN6f3gbKSsXwPwq827o64jHDj+3F69Q2jaYJrQUA7dmsQ2aCi9LddZ983ilpRehk7
	 R6UlPNNBhn4Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B45123806541;
	Wed,  7 Oct 2026 00:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: sparx5: start the TOD counters on non-PTP
 lan969x
 variants
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133240553.2839723.16210131859682317407.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 00:20:05 +0000
References: <20261005052826.14251-1-quentin@q-lab.dev>
In-Reply-To: <20261005052826.14251-1-quentin@q-lab.dev>
To: Quentin Freimanis <quentin@q-lab.dev>
Cc: netdev@vger.kernel.org, daniel.machon@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, richardcochran@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  4 Oct 2026 22:28:26 -0700 you wrote:
> Currently the base non-PTP-capable lan969x variants don't forward any
> Ethernet frames:
> 
>   $ ip link set eth10 up
> 
>   $ ip addr add 10.0.0.54/24 dev eth10
> 
> [...]

Here is the summary with links:
  - [net,v2] net: sparx5: start the TOD counters on non-PTP lan969x variants
    https://git.kernel.org/netdev/net/c/ca5012757bf0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


