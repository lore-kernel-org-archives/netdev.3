Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A463546E4
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981661; cv=none; b=awNVfVXjEzrvrxe4QvrWTVrw/GCt7lo12ycC25TOukUkCb1zca2KFOREaYgPsSytbSBqdYFG/lrz27Aoacb+mZChv0nv0/N7wL9QZ0oLF6dIPLs0TKPNGaqh5m9l3ZkFFMAQ9BaDx27VnbCcVtASnPcnGvFpGGZSnDTSYOzzO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981661; c=relaxed/simple;
	bh=xz5pggjjq1veE9NlAkCV8Chw4rKP1Msm9Fqu54kxLfE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mzVBP4h3SfSLQFsbnmVbrhJ8AaWKRTegFK+L4W1ZC/F3Amqtb1tWGjRAUpYgx2IRDcOlXtTikmXQaVYgP0SigKnEDztf/lNro1vKeW8zktE7XwOkNukgdqZnxkhR6nL63SgKjgoQzpP4WWTV/O9I7ayIc4MFoxm/wTTvamXiR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erLP9qVF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erLP9qVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D390B1F00A3A;
	Thu,  2 Jul 2026 08:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782981659;
	bh=rlECEzGVBnRQcX1PJHlOlcimtBsMPxut6cTFhxNIhiU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=erLP9qVFeoBKHxbL5S7+0GXPVVPi5R49WQM/bQe7BGucsZeYJHSIwc775V9xTS0R+
	 7XJBgRHKLvByjqT5507N6HqkIjNazNm7Kvf2DUIjuuW0uHWVvmi8o6xOw4Ms6r2i9A
	 JkipjPf2QxfmpN7YZExKSQ0MPYVL46OG/WvkQdKxsI3E9a68Sk4SxwB/e3vlxREcPy
	 3bQK3G/E4e/bzUADxS+xEiZNO/v9evCWmajFbbunWQjVyboDAizqr9LMZE1fE/zdPD
	 dnBh6a9eZGWsvNAThX8HmB0pS3DMLgEtGZ00O7KyZn524+suXM4pqtDLqAI8T0RVSj
	 1FXzKgKN0QEGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1983C3926664;
	Thu,  2 Jul 2026 08:40:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/15] batman-adv: create hardif only for netdevs
 that are part of a mesh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178298164263.1523446.6187059831704914179.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 08:40:42 +0000
References: <20260630140623.88431-2-sw@simonwunderlich.de>
In-Reply-To: <20260630140623.88431-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, neocturne@universe-factory.net,
 sven@narfation.org

Hello:

This series was applied to netdev/net-next.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Tue, 30 Jun 2026 16:06:09 +0200 you wrote:
> From: Nora Schiffer <neocturne@universe-factory.net>
> 
> batman-adv is using netdev notifiers to create a hard_iface struct for
> every Ethernet-like netdev in the system. These hardifs are tracked in a
> global linked list, which results in a few performance issues:
> 
> Lookups in this list are O(n) in the total number of netdevs. As a
> hardif is looked up when a netdev is removed, this also takes O(n) in
> the number of netdevs, and removing n netdevs may take O(n^2). This
> slowdown will always happen when the batman-adv module is loaded, no
> mesh needs to be active.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] batman-adv: create hardif only for netdevs that are part of a mesh
    https://git.kernel.org/netdev/net-next/c/fcba102e0e4a
  - [net-next,02/15] batman-adv: remove global hardif list
    https://git.kernel.org/netdev/net-next/c/49e9de6e124f
  - [net-next,03/15] batman-adv: make hard_iface->mesh_iface immutable
    https://git.kernel.org/netdev/net-next/c/f846e779532e
  - [net-next,04/15] batman-adv: remove BATADV_IF_NOT_IN_USE hardif state
    https://git.kernel.org/netdev/net-next/c/48ea7b6b7b94
  - [net-next,05/15] batman-adv: move hardif generation counter into batadv_priv
    https://git.kernel.org/netdev/net-next/c/cbda6a6cf2a5
  - [net-next,06/15] batman-adv: drop unneeded goto and initialization from batadv_hardif_disable_interface()
    https://git.kernel.org/netdev/net-next/c/2b429dbc50b4
  - [net-next,07/15] batman-adv: drop NULL check for immutable hardif->mesh_iface
    https://git.kernel.org/netdev/net-next/c/b58c36b804f4
  - [net-next,08/15] Revert "batman-adv: v: stop OGMv2 on disabled interface"
    https://git.kernel.org/netdev/net-next/c/5fa5f64fc018
  - [net-next,09/15] batman-adv: iv: drop migration check for batadv_hard_iface
    https://git.kernel.org/netdev/net-next/c/ba2d97e8736e
  - [net-next,10/15] batman-adv: tvlv: extract tvlv header iterator
    https://git.kernel.org/netdev/net-next/c/278e5890704c
  - [net-next,11/15] batman-adv: tp_meter: simplify unordered ack calculation
    https://git.kernel.org/netdev/net-next/c/71b7987ec001
  - [net-next,12/15] batman-adv: tp_meter: combine adjacent/overlapping unacked entries
    https://git.kernel.org/netdev/net-next/c/936a1c10cece
  - [net-next,13/15] batman-adv: tp_meter: keep unacked list for receivers
    https://git.kernel.org/netdev/net-next/c/3bbb8b94217a
  - [net-next,14/15] batman-adv: tp_meter: adjust name of receiver lock
    https://git.kernel.org/netdev/net-next/c/6cd45ef4dfa5
  - [net-next,15/15] batman-adv: tp_meter: delay allocation of unacked entry
    https://git.kernel.org/netdev/net-next/c/247691642fd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


