Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BBF3E00A3;
	Fri, 14 Aug 2026 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677912; cv=none; b=CJH1nOBQLvoud+MF6N63OEPEZtmxaM5FwfYmbIjqO9SjQ6ixdJ2P1l/mxDMOtWs1cO8eWORZGaIK8pPm+fK5fR4ky83V1MTlBZk/FLrM8/XbUkUsD7Bj8pPscQQ8DDkEokDjCp66AHakaOfBAVsLaeXbxRaHaxiXbeJC9yWRB7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677912; c=relaxed/simple;
	bh=gjXHiZO79AqmaRBLUcaXulHu8QzkvZAZpqmXCS9xfuw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sIsJyKMSoQnp/XMDE4OuqE0VbrJq34PI65taIr3LL0yT02CWASqWKB2bbxM9HjnjQyornW/J0N1u/8g+Vz9yyKlFqKoCMOmCpSVxPDVCrXXmrH/4ZH/MbknwxnLNsJqVw4XCRL1KHFE6Cd4LG9gpzzmSCNtRSD3/DGBVCAHe0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXzmWN4c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXzmWN4c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293BD1F00A3A;
	Fri, 14 Aug 2026 03:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786677911;
	bh=jY8HIg5Y+OJALU1uxX82iUBD4oxEfdFx3WwSAa7lkv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oXzmWN4cNaRmeFMRVtds8tbZ/gkf7x71GUhUabdCVNigOVpmdrTrKgMlznIZvaOJ0
	 o+/yJZrLC2TaSrLJDtdsrNMq0IlY5wLQmwgvBbMSxG3zbZsBP7lWLooHfogPQawm97
	 rFMW5kK2L8Cnm7JYfI5gGd6MSVgCM9//yEFLjJwFxjqFvIeo+RxAKYE6BRHV7CtNu4
	 /JJ2fLkSeW2+5uCqcY84RuL1w3+2CgoU6wDweeOn6LTHDAjFLO5Y0LD2S/PaG54EGV
	 3/zLe/+OcKwBbih7DtFBFwd40c+NwiPV4mqkbP9UwDOPAeg9hcFfGEVVu4kW0yBQfp
	 TSvChUVq8WV9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D098C3810900;
	Fri, 14 Aug 2026 03:24:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: lg-vl600: fix Ethernet header on fragmented RX
 packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178667786539.3150297.3988097374825496565.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 03:24:25 +0000
References: <30CC616506DE5BC4+20260810084435.2099229-1-raoxu@uniontech.com>
In-Reply-To: <30CC616506DE5BC4+20260810084435.2099229-1-raoxu@uniontech.com>
To: raoxu <raoxu@uniontech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kees@kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Aug 2026 16:44:35 +0800 you wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> The LG VL600 RX path can assemble one device frame from multiple USB RX
> URBs.  In the single-URB case, the input skb passed by usbnet is also the
> buffer being parsed, so @skb and @buf point to the same skb.
> 
> When a frame is completed from current_rx_buf, however, @buf points to
> the assembled skb while @skb still points to the last URB fragment.
> vl600_rx_fixup() returns @buf to the network stack in that path, but it
> currently obtains the Ethernet header from @skb.
> 
> [...]

Here is the summary with links:
  - net: usb: lg-vl600: fix Ethernet header on fragmented RX packets
    https://git.kernel.org/netdev/net-next/c/4f93b12cf7b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


