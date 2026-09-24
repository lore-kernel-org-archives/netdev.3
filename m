Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC802389106
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269281; cv=none; b=L8ocoT91CGc6RqSBG46055r5J4LABM9FRBJDlqPz6gRAGR22guieznHpHq6nAcQfJ9vmy+RjJzR0/xmO+e/IRQL1GrPmkvQzwr41oVzgdgjgQnV7/o7CdE3Iyrt7QgSHvF61FGuTF8XF0WSyalSpQ2Yo/uLL9SomgaZvxbtIqPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269281; c=relaxed/simple;
	bh=R40UIEDGfE1AikQ5g9Z5grNbQXJ6ZraCZkmp5WnAqgU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k/Ah6nVT+1AMacFJL1jSL4jqInL0OzX6QRY9Ir3PFNSBJ5nx9DbOprL8bKkj2TRRHlzcRk5U2IZarKWJG7A/V0ElJc/ADH2xHX14xMYYxJzIq6b0MKaYko4X2cNBI6NoYbjUbe1KN0Xkf9nr/No3pBnazJTBMJuDqFIfXbUTFGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWII1u9D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWII1u9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F561F000FF;
	Thu, 24 Sep 2026 17:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269279;
	bh=lV0fzY7/a2lJskFPb6Ug8/Co8NFxzxzz4tZOchhfQCs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kWII1u9D0Tz3g/5UHiztSWAm6JAhNeG6ElIs9Bo9oUy3mYyN83+zmZ96WYuLy/RUg
	 1nduRRUn1/I9FYoeBpqH7F4ApEkn4LectCW92rmSq35IHJBGq5fyuoDtdWCjYAZMUZ
	 ufHJ7BGa4YrWnpbRsJHYdHyKdkCbBHd/Qa9GG4UfXRP2S4X7bE5qAlkWOJrZa7tW+y
	 JE3CWq34SAVOP5j8ix+Dj634bH9gInxoLVr9qdJHBOAN1iAn3UV5wpzHXj9Z40ZQzF
	 SqkItfdQG8ymr1/eIaLQose0RgwsdOcH7pQ2XSlOQwc2uoPRxp6W1HClc931ceYrjs
	 Vi7u6cLzAg13g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938D93A566D8;
	Thu, 24 Sep 2026 17:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/11] ovpn: preserve IPv6 scope id for netlink peer
 endpoints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179026920840.1655167.8738035825375143200.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 17:00:08 +0000
References: <20260921102215.3599702-2-antonio@openvpn.net>
In-Reply-To: <20260921102215.3599702-2-antonio@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com

Hello:

This series was applied to netdev/net.git (main)
by Antonio Quartulli <antonio@openvpn.net>:

On Mon, 21 Sep 2026 12:22:02 +0200 you wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> ovpn accepts OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID and reports
> bind->remote.in6.sin6_scope_id in peer dumps, but the netlink endpoint
> parser never copied the attribute into the sockaddr_in6 used to create or
> update the peer bind.
> 
> [...]

Here is the summary with links:
  - [net,01/11] ovpn: preserve IPv6 scope id for netlink peer endpoints
    https://git.kernel.org/netdev/net/c/7a6d08ee0f0e
  - [net,02/11] ovpn: skip UDP source validation for unspecified addresses
    https://git.kernel.org/netdev/net/c/77393b4d72df
  - [net,03/11] ovpn: track UDP socket route key for peer dst cache
    https://git.kernel.org/netdev/net/c/7c66b7a4ae80
  - [net,04/11] ovpn: validate peer state before caching UDP dst
    https://git.kernel.org/netdev/net/c/fa603710bdb9
  - [net,05/11] ovpn: replace bind when learning local endpoint
    https://git.kernel.org/netdev/net/c/aea934a221ec
  - [net,06/11] ovpn: replace bind when clearing stale local source
    https://git.kernel.org/netdev/net/c/7d8104988f42
  - [net,07/11] ovpn: always unhash old VPN addresses before rehashing
    https://git.kernel.org/netdev/net/c/b43beccb3713
  - [net,08/11] ovpn: reject duplicate peer VPN addresses
    https://git.kernel.org/netdev/net/c/d25e885b31a0
  - [net,09/11] ovpn: reject multipeer peers without VPN addresses
    https://git.kernel.org/netdev/net/c/025af3a0a892
  - [net,10/11] ovpn: reject invalid peer VPN addresses
    https://git.kernel.org/netdev/net/c/5940f3407b78
  - [net,11/11] selftests: ovpn: validate peer VPN addresses
    https://git.kernel.org/netdev/net/c/006208026819

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


