Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397609;
	b=g5TCdaL9URHSp9fgueCsHgTb/zQGss0u0PJ4Myg8mbyLgvTCZMeXE4sP+qUKK0GyRbC1
	 NYbyAjb829LnYK6aKK3jcj0Sh7BSWx6vxzM9dd9XdjM1t1mOdlL6lxRDpfj79rpePF3D5
	 6vpJPmmYeHV7OXKhworIFdL/QScP3PYr2Zv24GtUlwT/jmwKNrgP9ypVjNJcyHyhEGOR3
	 lyPWQoU/hA0W43wiOHEbEyg9l5IW15j6w/p63cP5cLgbLp+rsc33Q0G8SZTp/CN7AMCJq
	 akl9cshHji+iiCWGE+Fif+eohN5+5cjIbwCf3EL5o5DgBemCP9Qw8Rd/ANs5SfScSsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397609;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=U2kaPQCEoqKi8S6vGTnuzQOL+3u+NmMeqZfbb6IoDwc=;
	b=CsZRAVBxbnYMB4nVwjvFdOE/E53DyXk/0PytXmObVIg7jt9yLhs8MtLypkZp0QJ/ybYp
	 HN97X5LqIW6LQOyRsfoAyT6nlq13iErdiwTbSid5sy5q/nGj3vlZZl2zs2cZzjDxEPcQ2
	 7l9aQP172s0dOs3FHvZ4/cvzRjyktWrSc6BD/N7kuup+15p+S4q/ufzjcoKPfPisxjXtx
	 LZlvk+l6AiOqiVXUBFh8grCxQtv2ve2s7TJYHSudTtj0IclSbP0GUJe5j20uqbo5PbwLT
	 SWX9Ny/gt0MCBxnjFa2zcWq0EY4zHXVvBMKeT3QfSoF51AmV0lvjVIBmyYvBu/BRlSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P+/36Xbm";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7D606A31F
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+/36Xbm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8803A1F00A17;
	Fri, 30 Oct 2026 22:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793397608;
	bh=U2kaPQCEoqKi8S6vGTnuzQOL+3u+NmMeqZfbb6IoDwc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P+/36XbmjnR6ILLz5KyJwRfviGAJtf1P/u4eq7VOj52Pz3dLHHrd9qin44eKD8NSm
	 LBDHyFUs1exy8tvZgCyzmz81ErWTeHRLH5GfbAuTP7RdHXp04XpRaT4Z52+kPhgWsT
	 laqmdS5f9z6v0u4X5AEwJMZwuE6nYtQaJOI8g1o2TOyRPigYKE0pcscZi8pgqPhuQD
	 9ohEoqQqBhZR+cIS55c9Q1qCJwO7a+LGkHpWKEBSGGT+oTSyOo31PYK7t/FqhWS7lT
	 iOWaA/pAqSsrK1qOIw71l+x6OMsF5NO4/x673feTYx3lyw5akmgWdVSwzaPcxCN5FQ
	 jEARb/sCeScSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D2F63800478;
	Fri, 30 Oct 2026 22:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/14] batman-adv: avoid WARN_ON for orig_ifinfo
 allocation failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179339760704.1793924.4372470360549262374.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 22:00:07 +0000
References: <20261030135105.2555887-2-sw@simonwunderlich.de>
In-Reply-To: <20261030135105.2555887-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, kartikey406@gmail.com,
 syzbot+a079f084653164a652d1@syzkaller.appspotmail.com, sven@narfation.org

Hello:

This series was applied to netdev/net.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Fri, 30 Oct 2026 14:50:52 +0100 you wrote:
> From: Deepanshu Kartikey <kartikey406@gmail.com>
> 
> batadv_orig_ifinfo_new() returns NULL only when its GFP_ATOMIC
> allocation fails, which is a normal runtime condition and not a bug.
> batadv_v_ogm_forward() already handles this the same way, simply
> checking for NULL without a WARN_ON.
> 
> [...]

Here is the summary with links:
  - [net,01/14] batman-adv: avoid WARN_ON for orig_ifinfo allocation failure
    https://git.kernel.org/netdev/net/c/dfa953ba5366
  - [net,v2,02/14] batman-adv: Close OGM aggregation before transmission
    https://git.kernel.org/netdev/net/c/f91f64a91682
  - [net,03/14] batman-adv: mcast: validate tracker padding before forwarding
    https://git.kernel.org/netdev/net/c/ea01fff30f63
  - [net,04/14] batman-adv: tpmeter: fix u32 truncation of reported bytes
    https://git.kernel.org/netdev/net/c/1025b76d1328
  - [net,05/14] batman-adv: dat: initialize orig_node of unfilled candidate slots
    https://git.kernel.org/netdev/net/c/4eb19a389d74
  - [net,06/14] batman-adv: fix skb leak when hard_iface is being released
    https://git.kernel.org/netdev/net/c/522e4aece2e9
  - [net,07/14] batman-adv: stop originator purge worker before freeing TT
    https://git.kernel.org/netdev/net/c/f89eda5a9ccf
  - [net,v2,08/14] batman-adv: tt: only transmit local ROAM flag together with DEL
    https://git.kernel.org/netdev/net/c/10f24f058417
  - [net,09/14] batman-adv: tt: clear ROAM flag when re-adding a pending local client
    https://git.kernel.org/netdev/net/c/cc2186d78547
  - [net,10/14] batman-adv: tt: send ROAM_ADV on each roamed back client
    https://git.kernel.org/netdev/net/c/aff4d5d10f2d
  - [net,11/14] batman-adv: tt: ignore ROAM flag of received ADD changes
    https://git.kernel.org/netdev/net/c/c5d68abe6e7f
  - [net,v2,12/14] batman-adv: tt: only update flags for TT events
    https://git.kernel.org/netdev/net/c/ad1fd828aa39
  - [net,v2,13/14] batman-adv: tt: don't drop local events queued during TVLV update
    https://git.kernel.org/netdev/net/c/ed7a0dfdd370
  - [net,v2,14/14] batman-adv: tt: limit local table to single TVLV response size
    https://git.kernel.org/netdev/net/c/a137095419b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


