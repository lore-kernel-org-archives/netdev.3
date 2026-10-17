Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37338655E
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201220; cv=none; b=CyfPAmcalfbWV/c4OyTxse+hOEtZyzfoAf4M/FH7o7fM6ldfoX7ti0ArGEraA+/GbbMec+q9N+mOBPcxtSNBZmLUEUWVPJhNLS3I/rl4AS8K4ZP64VjChtaEyrPvz5JRjScvMFzgb5Ax9iH6wdgFPoDkwk10TC+2cgYOW1moeoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201220; c=relaxed/simple;
	bh=fPFZe1pwW4TF7xE2FHh8ISybeo0V9U1++KHXSfUxdeE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eLlnlQQ0En48/wPUje1IogtKt5nR6/1Hjtu/M63JtRwtgbMC+eRPSaHj9h9frzbuWl49Yxlb+drcroj4qTKMq7n7XGFO+BIIQzZ38H/zvOIAAv2RLiRwCxt/cfk37GbDk1n3S1d4LX7wDjvEimvrmJsNOaiqmseDdDpMQQm77hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY52bza2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY52bza2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8571F000C5;
	Sat, 17 Oct 2026 01:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792201218;
	bh=AkRCi37yn7skJmlVKBb3WB3jAN4MSGSE6tKoNIBATQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GY52bza2y4zvsm3dkWMJsWuKopW7kpUmWtP0cLzcSsCoCEpjShScFW8/xEZ23qnJa
	 UFjkkxDw010UUOWvf+5j7XNjQ5JLAofJ5ju7EbeWyIX7iZEXGnVT0kTupoKil6nGrh
	 wLZnp0CJEInuuZ2p2NR8VTq7c0IB0S+s1i0zxJ+n7b+jjbh39anBC9/lOUBk9UAgqw
	 g6//+WCIuu2AOprcrwhz+u1Gj31IuY+ltAqiZfSqb6tt6OsID3QOjeyN/GZ/h0vGHX
	 Q21Od4jq50dcO+MJPqYBCEHar3jUDMx0GP5kUArEbKRUdDAEcyRTEdsa09PpvulU0s
	 vaYzpziky431w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14A3380CED9;
	Sat, 17 Oct 2026 01:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] vlan: restore HW VLAN tag insertion with
 reorder_hdr
 off
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179220121651.1050340.733128849096807902.git-patchwork-notify@kernel.org>
Date: Sat, 17 Oct 2026 01:40:16 +0000
References: <20261013115022.1043024-1-edumazet@kernel.org>
In-Reply-To: <20261013115022.1043024-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, sairon@sairon.cz, stefan@agner.ch,
 hitchin999@users.noreply.github.com, hkallweit1@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Oct 2026 13:50:22 +0200 you wrote:
> Commit 447cbe95ebb9 ("vlan: fix skb_under_panic and races when toggling
> HW VLAN offload") replaced vlan_passthru_header_ops with vlan_header_ops
> unconditionally to avoid lockless data races when modifying
> hard_header_len dynamically under RTNL.
> 
> Prior to that commit, vlan devices on top of a real device capable of
> HW VLAN TX offload used vlan_passthru_header_ops, which never inserted
> the 802.1Q header in the frame.
> 
> [...]

Here is the summary with links:
  - [net,v4] vlan: restore HW VLAN tag insertion with reorder_hdr off
    https://git.kernel.org/netdev/net/c/c2124f80be4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


