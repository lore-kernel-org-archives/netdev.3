Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC263033E6
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089070; cv=none; b=K8BgkdgrC+RAAHfYIFFoa5lmbfeAfsRxVMRcFlsdQqKGkfy4cwgAzrIhJKTUxczcmhoZd0NmjkUKybaeqr5VG6HreHN3NNPtHU4x0rpV4eF7/3RIiQ5eCrpPee5KBvNr3Tz0GVa1VjGGTvY+Jwv4rEECGyMZ3SttLxZWs9j4WZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089070; c=relaxed/simple;
	bh=dMiHHnhH5tdqbVSlV8s5kU3wi/VpcRrgKP5/8RDniIU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rogCou6bvy6a3l1jmBrT8KMhyL+JrMOMGpNBlJg3IXp6jY7XHGFJ+sPYrS++vnz6fMIk9jm+VsQV9qI25UnBrCFBsAWP/Jn9zj+3H7XLUbj7MTitgyGms8fGdaPM0S+SSbnEJ8j5WzWlOv/w0agvg1TnMs5pZ2CCXhDNmxcHEWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwN8c5ET; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwN8c5ET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52E01F000FF;
	Fri, 11 Sep 2026 01:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089068;
	bh=COxM5nheeIAIoGcpHWTk9qgNvX6jI95QcrY9v89jb3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NwN8c5ETX9cq1NHWLjnO6y1kq42+C295a7irzS5quv9amHr2Ca7QOLCNFUfP/1siH
	 v3OPQmSbm14Hr6IOQeFM9eSMCoyEtdGLZW6MzkH85DNdrqYUP+Ofau2h4G+66u+s2k
	 Fpt6+DvDVAzXAUgBmEir/8WLTbOcrQJgJzSN5x+1BnGfR+RyzLY4NoPQ3Kp5Xi5YQU
	 kJsGmZ4SX7Z7dVYVODBd2+vGk5Ur8C5meI31UgOOw/sr4n891hDq6Ue0GFKCIQg56Z
	 9NZUxQL/Kp5kPF5pnLFxwZBtX5HFbvFmH9yeSlUnoRPTA7PBBGS4sJNC9aC/WByY7Y
	 4lqq1AtVySAbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A063810901;
	Fri, 11 Sep 2026 01:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/15] batman-adv: tt: look up wifi state of
 incoming
 interface in helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178908900614.2170035.18425688675148363165.git-patchwork-notify@kernel.org>
Date: Fri, 11 Sep 2026 01:10:06 +0000
References: <20260907081824.2474040-2-sw@simonwunderlich.de>
In-Reply-To: <20260907081824.2474040-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org

Hello:

This series was applied to netdev/net-next.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Mon,  7 Sep 2026 10:18:10 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> batadv_tt_local_add() only needs to know whether the client was seen on a
> wifi interface. But it kept the net_device reference of the incoming
> interface alive until its own cleanup section, together with a "net" and an
> "in_dev" variable which are of no interest to the rest of the function.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] batman-adv: tt: look up wifi state of incoming interface in helper
    https://git.kernel.org/netdev/net-next/c/3273a5cd2d74
  - [net-next,02/15] batman-adv: tt: extract allocation of new local entries
    https://git.kernel.org/netdev/net-next/c/defa87f5ce75
  - [net-next,03/15] batman-adv: tt: replace forward gotos in batadv_tt_local_add()
    https://git.kernel.org/netdev/net-next/c/a5e5d2709d10
  - [net-next,04/15] batman-adv: tt: extract refresh of existing local entries
    https://git.kernel.org/netdev/net-next/c/ec6edeb755ec
  - [net-next,05/15] batman-adv: tt: extract update of dynamic client flags
    https://git.kernel.org/netdev/net-next/c/d72e16b1c5d5
  - [net-next,06/15] batman-adv: tt: extract allocation of new global entries
    https://git.kernel.org/netdev/net-next/c/d9017aeb40c1
  - [net-next,07/15] batman-adv: tt: extract merging of flags into existing global entries
    https://git.kernel.org/netdev/net-next/c/b535e61347ba
  - [net-next,08/15] batman-adv: tt: replace add_orig_entry goto in batadv_tt_global_add()
    https://git.kernel.org/netdev/net-next/c/3f8e8b42f639
  - [net-next,09/15] batman-adv: tt: extract removal of the superseded local entry
    https://git.kernel.org/netdev/net-next/c/228c70d51b10
  - [net-next,10/15] batman-adv: tt: extract marking of a removed local entry
    https://git.kernel.org/netdev/net-next/c/5e02403a4c2e
  - [net-next,11/15] batman-adv: tt: extract immediate purge of a local entry
    https://git.kernel.org/netdev/net-next/c/931de98d3960
  - [net-next,12/15] batman-adv: tt: drop the cleanup label from batadv_tt_local_remove()
    https://git.kernel.org/netdev/net-next/c/926013fd40f6
  - [net-next,13/15] batman-adv: tt: clarify kernel doc for batadv_tt_local_set_pending_event()
    https://git.kernel.org/netdev/net-next/c/857fbd765c65
  - [net-next,14/15] batman-adv: bat_iv: fix ogm_neigh_is_sob parameters references
    https://git.kernel.org/netdev/net-next/c/271f3730fc87
  - [net-next,15/15] batman-adv: correct batadv_hash_remove kdoc return type
    https://git.kernel.org/netdev/net-next/c/6d7f71ae4cdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


