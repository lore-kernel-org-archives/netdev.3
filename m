Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DEB1CFA2;
	Sat, 19 Sep 2026 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776674; cv=none; b=j0xTaES78zkIk5x1dGk1oZoBVY66Kejy9cISMQr1lnHjAfpRx0rR1BBGttDntH+ksLL4BEArQH1diiAMZsB9HGr0K+tXvuiQ/9ECBB8z3SiElfF9ca16kpjredUL8mVxBq9QTAessgkTuO2CcdZHRZgBfxLJK/GwaiETYCyinvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776674; c=relaxed/simple;
	bh=GqJC12ePMsdfqrsaUwEoqJNdJTuH8oEBdAN4MS5/Khg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QLyXlzF0qIdPTCzHlB7Kxh2RiTksFoaMOA4TvfL6JdjJRV5vMZS8YMoruFqC0w3oWl6aJG3LHOjr9jxCnEFKfXkn/oM9l2SOm+fqwSNVr+02rqI+cGpfdy6kldyPxcwGafSAHwZNlNyDHKdwrU/5GbQrc1EnnhQqHVeQ+hoG0Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9NhQUlY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9NhQUlY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A605A1F000FF;
	Sat, 19 Sep 2026 00:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776672;
	bh=tkDu9Uo/AU2uwzm28usz30zQ0fcywqUXhusN2fxLOrA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n9NhQUlYWqBn6ZcpFHRSvph7N3ipGhmZH+HBwU2eCdukjMF0PeCTufRk0jcFNHeXs
	 aoZeSQBfT9c/lEDbeVQBcXpJEoURfSq6NYGccSiaUAXt3ThE51KCbfKa2PumNEA7V+
	 Ot2RLHeg3C3JKzs/2D8vdR46v2t84gatVQYqkcpoho6I0I3YmP9zpTp2w1F/jBCpkr
	 2i+6BSDttRe5yz4gxzUCRE8luL6dBDDWdc8OHIMvMqo76wenTcySfBfHSfWNW49vH2
	 edNDzFC5HiVEHiuHquFN7xeKYgneEnbXkl7nKhmvPccPEZJl5HDdYIiwmhtKPrR/FU
	 8InJcXTgWLO6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AD13811977;
	Sat, 19 Sep 2026 00:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6: do not let ipv6_find_hdr() return an offset
 past
 the packet end
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977660565.1197442.13371805244391689666.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 00:10:05 +0000
References: <8F80BA1A-DDFD-432D-9075-242A3435FEB5@doyensec.com>
In-Reply-To: <8F80BA1A-DDFD-432D-9075-242A3435FEB5@doyensec.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, i.maximets@ovn.org, aconole@redhat.com,
 echaudro@redhat.com, dev@openvswitch.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 21:57:53 +0200 you wrote:
> ipv6_find_hdr() walks the extension header chain, skipping each header by
> the length that header itself declares.  ipv6_optlen() returns up to 2048,
> and the skip is never checked against skb->len, so the offset stored in
> *offset can point past the end of the packet.
> 
> openvswitch installs that offset as the transport header, and
> update_ipv6_checksum() then reads and writes the transport checksum field
> out of bounds:
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: do not let ipv6_find_hdr() return an offset past the packet end
    https://git.kernel.org/netdev/net/c/ee319bd3a0e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


