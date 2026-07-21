Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF0047010B
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662253; cv=none; b=ZCpDpAD3V53xNIDx7NOLziGHSWda2ZizV0sg4cHeB3hV1Wh6vdJePuykGFcw2dcqATsYckanr6IhAomSkmkahPGjv5kWYgDMLS2SGFX5NUv6mtmS3e/dwO3aCda69jAqQKE3YfNpyyBskSanBrDyiQ0PejzZ/Jb+uq7A30dfQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662253; c=relaxed/simple;
	bh=EbpFO1EQ6f7lqQE4dKdLZQNfk6LjVCWroTjwcytWz+Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K9FeNnUfHc8V/Nr54Mi4slhssdoGnVBpibRQvV6IzutM03xiuzxMrgPnB867Npvs878OhYO+K/lZgT/o16QdKIJVE1V9H7cWdK6aauRxRflpEbqa8X3i4ATbdAG98kHttzO0/8EOTnHIq+csUWMGnYThZDpFcyCPI9Y8SOCngF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqZWIN0T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqZWIN0T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D650D1F000E9;
	Tue, 21 Jul 2026 19:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662251;
	bh=0xvaMJ0ELDA5AjVRdeYV2DGrCyamLpVjH7Fug7b96YI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HqZWIN0TNFl1TFXKSEi2Vr7jcHzl7cq72G+m/1J2VQ4iLq2m+TldmJIoOgGor6W/r
	 hBZmoYkVhxGGtbajnZ1kghLEa8XQDDiBlewaOM4PHRE+bSHCjYwWomLi5uXWU9+MbV
	 QBs+Fep4OTR+fyNm+UT8BfXz0N1hiP7sCn3CtXjCUNHyLzlKNj8yKTptSfxJfM5y6/
	 DFQPxr8FJ8qr5nUkVhEFs4TFyfbrmdnDPEXsDHAd5fG+avyAdcCP8NPBa+bH2WpacA
	 4qaFRn61BJ5dTgsKbdxQOwN/yGCOTYYmyUWTs2hgHtoIgu0WiPB2v1fbdWZ/bi3XVK
	 kTOrnu/oEsgPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939C139253FB;
	Tue, 21 Jul 2026 19:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: txgbe: fix heap overflow when reading module
 EEPROM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466222113.987340.15917390639117400781.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 19:30:21 +0000
References: <20260713085111.1481884-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260713085111.1481884-1-chenguang.zhao@linux.dev>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 zhaochenguang@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jul 2026 16:51:11 +0800 you wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> txgbe_read_eeprom_hostif() always copies round_up(length, 4) bytes
> into the caller buffer, which ethtool allocates with exactly 'length'
> bytes. A non-4-aligned length therefore causes an out-of-bounds write.
> Copy only the remaining bytes on the final dword instead.
> 
> [...]

Here is the summary with links:
  - [net] net: txgbe: fix heap overflow when reading module EEPROM
    https://git.kernel.org/netdev/net/c/6a905a71fd43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


