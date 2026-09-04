Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5FB3B841D
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560481; cv=none; b=SWRE110zNF+1qJy/8mLHfupFIP+CsD/U/uPNjwuImc7bzIf1WgmKawG4ScLXITVLVVGmA7DHK7U8kiO46umGo/b6NULHm+k2H0epvXFiUHqcQ4K2A8R8xfJAjt0Vf4RoKXRzSKmpfdvnGuqKvTOyPdRhbTlvwYA1USS7vYxzvuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560481; c=relaxed/simple;
	bh=wZMcFHF46J97UCHI8NoO0bigJPyaY5WXU/C0vvBhJ3o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cWrg6omgg9kvF47/uSr8mx4FTkAfsLFX4o9FL1Jh/51PUY5X36qflxJtpWL37/d2iBBRY+JktkG6Hfy+v+mI1je3Ripz/o9QJGc/ECtR8L72RAsCfEHYOqIHrKfEHbQmeX1sDldRVZpFF9fqO27Moc8nUEOonWgu7uB0822S0YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNeTYEAO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNeTYEAO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B791F00A3E;
	Fri,  4 Sep 2026 22:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560474;
	bh=Svd5DblrtjkzEhJaLdl9wxQATbFa35FES2priIoto1s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SNeTYEAO9ZVjhHtmpAPiYk0TZPoRRP/e0wu/IfrRXiwzJ5zQVCV8WrZ20+lSHBihi
	 mBxy1O3cXBPMYmV7OTP2zKkmfTTNRtfrNsFUq/UR70YhwfkEdt92XaKf+B9u1Z5uJV
	 ICp7qzf/9V15ZxP7t6tVkCqUZZV0aVrBH/imswqkB5SaEW/Ts4i3emOz4Pmt4k7682
	 EsUmh2ojaFbEjX3Cr0Avvlw97klooXCIshc2fzo3kLWg+W6lVSlevovGguAMOsfxpB
	 AvDuo8CLRVRRK0dW/XFI7wCjizvMItBKt1scksv9UI1ZaDXf0quZbdr/azg2+8qu8/
	 7BoUsEm8259vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AF73924A7E;
	Fri,  4 Sep 2026 22:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] bonding: use skb_cow_head() in bond_do_alb_xmit()
 and
 rlb_arp_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856041514.992241.12057937084609376909.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 22:20:15 +0000
References: <20260903143940.1180513-1-edumazet@google.com>
In-Reply-To: <20260903143940.1180513-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 liuhangbin@kylinos.cn, jv@jvosburgh.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Sep 2026 14:39:40 +0000 you wrote:
> In bond_do_alb_xmit() and rlb_arp_xmit(), make sure to unclone
> skb head via skb_cow_head() before modifying the source MAC address
> (Ethernet header and ARP payload) to avoid silent corruption if
> the skb is shared or cloned. Avoid caching the header pointers
> across skb_cow_head().
> 
> In rlb_arp_xmit(), only modify arp->mac_src if it differs from
> tx_slave->dev->dev_addr to avoid an unnecessary copy and head
> reallocation.
> 
> [...]

Here is the summary with links:
  - [v2,net] bonding: use skb_cow_head() in bond_do_alb_xmit() and rlb_arp_xmit()
    https://git.kernel.org/netdev/net/c/1746ef2e2df2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


