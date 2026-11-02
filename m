Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632806;
	b=B5UQ343sJGBSNFHaVfKsFaaEFfOfq1Ad+HYXBgqmEfm5YkswB9+siOgHUKHDGIVgvoL8
	 4DQhO7HKRVm8kVAOnMGtSAMqxN7/+QCmxR+Y4j64fVFBXBjNjdErih0H7iXF8Fy8dUhNG
	 sY2c8ybZ2xqsVZfU2kZPcsTz5tXTW5Ecp8m+NIBkFmGRQYENbCAxLP8Mva6jT0dnbe+PM
	 m5yG9HRVx1+TILLSSsGBaci24rbmid00AAex4lGgVzPDKN+vf109wfuHDKUSN6VT/OJpM
	 4KvDgnsxA/HX1Ku06m705mHU5bDM0i9oa/+SHVAXS7xTx1F0MaXE5GJGmr0y+c43J3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=98BKo5w330jTx1Gy6YlkHbY1yuhdZVskGGPDYtobJq0=;
	b=rbbFZCdToCPGaQdZhrOr7jXaVu+awrxJ31ladcsRjP96meVLzxgT9hYPFF2oahABaDn2
	 i6l95ggVD361jWsclLG1v1pTLJawTzkvXo696nuosJeaXGECv6nYyHhPs6idzntLMUAAB
	 qpyDLXYjyZHtpbJfGoPUCpDP3XhWQEXQ5A4SXUABdzd/CFPVjrrg+4PQy7A17d5nmYvmT
	 hde2NHPfiuGMzu90GQgDosOx25NMuSNxvjvJZy7lHbe/YTUO46RrQKf4wFoS+cnKI9tq2
	 AzYyQJ6CRzfCm9RVU34v8oX7xsp29ywGT5WcpLsaK1NDHNSdmHTWI2wIcvoo3pKJYNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwWTSD5W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E166080A58;
	Mon,  2 Nov 2026 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwWTSD5W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E8C1F00A27;
	Mon,  2 Nov 2026 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632805;
	bh=98BKo5w330jTx1Gy6YlkHbY1yuhdZVskGGPDYtobJq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iwWTSD5WLWW4XSsvAVImoe5KOYqvc5JTJ8hl8HqRR7FhIBz9ufxFl8hnBdxktykIG
	 mBtZG/fsmS/quex5qei5snc1zSWuDTPMtptkZ4rCdKDhxw6Ga3YIAmGZiLncc6aaRZ
	 yyomUwdl4/vtid7EfjQ4P0V2GpwzJBY1VmOc13XsgtL7Y/Z676igrv8NiOnB8ertn8
	 pzoqSP9t3aa9f7bCTYU2B0uesjuamAn48OzihiwZfhRzv5zMgjlY2qqR7aC2EapEvd
	 wWTH1U9IXi3uzQXr7wlhnfrNdDVtvgUQ1WTIry36SfD2MUlxVKAcpbr6/MGiysP8aB
	 FDSW8M2pqpwag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D47A380821F;
	Mon,  2 Nov 2026 15:20:05 +0000 (UTC)
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
Subject: Re: [PATCH net] net: phy: don't require RTNL to detach a PHY from an
 unregistered netdev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179363280418.4162126.1315192404332122134.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 15:20:04 +0000
References: <20261029142423.93573-1-ngocthang2710.1999@gmail.com>
In-Reply-To: <20261029142423.93573-1-ngocthang2710.1999@gmail.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 kory.maincent@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+583f42a41879bb60de32@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Oct 2026 21:24:23 +0700 you wrote:
> phy_detach_internal() reads dev->hwprov with rtnl_dereference(), but
> MAC drivers commonly attach and detach PHYs while their net_device is
> not registered, without holding RTNL. Before register_netdev(), a failed
> phylink_connect_phy() or phy_attach_direct() unwinds through
> phy_detach_internal(). After unregister_netdev(), a driver's remove path
> may call phy_disconnect(). Both trip lockdep:
> 
> [...]

Here is the summary with links:
  - [net] net: phy: don't require RTNL to detach a PHY from an unregistered netdev
    https://git.kernel.org/netdev/net/c/d1cf56164dc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


