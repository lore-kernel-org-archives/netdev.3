Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9893911D3;
	Fri,  4 Sep 2026 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788564075; cv=none; b=OrMf+tltxo7BGLwlMkXCPHN2wQUVHZtEBAOMqLl3+hYhOSNOtfmvi/STaRNHw3fboQo+iaWzBoJ7KixKqv7+sj0rtJ5IH9hFsBzdJyq0XjPohj+m0DBCuglRhgzXScC4ZkJnLwi2b1LMOhdoQ7/V1kL5GznaAU0cIqmSo6Nl53k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788564075; c=relaxed/simple;
	bh=o5d88zNKPunw8C6yKGngd4Oe7Q8mluFNm5TPRzfWi5U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q7pJ5Kbmmmw0HNKSRoSxoBV6Ji2VWLjBw5D1SkTIZmx8okFTln/+gOOqsGwYaSU30UQMuHt6k2ZO4eqA3+f35SD/DgjY73kZRTDOFMwVLrZVskRpuqDDNSeShngrQYctrgavv/eHMQXpA0rOauETrD0h6FsFlqwgKBPZoHu/rA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aP6JzP1J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aP6JzP1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F98E1F00A3D;
	Fri,  4 Sep 2026 23:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788564074;
	bh=nUQ6ALPNiRV5lGPGYWI9OTwNEqgwdbKqwmFaKP/4Yk0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aP6JzP1JBPh5IwoWpWuayCnT5nqtaWs8tleipdpWNAER4AFcNVmIHBsI0HfCBouR4
	 A9CZj5S2Xrqhbz+oehYwpKpuDY49jHkFEBxmEAS26zPSG2pKRYGJFamU+ljh7ChQIW
	 mHqkFTY+XpubL6vXcEWQFKuSyTL/h1QcJGH1eXmVvOaYzjDb4ww5uuKKysgWG0AlOi
	 Lowx+APzOgleNdziclH9LKi/1UbfvCMUlYUdXdJuowml9enUjYXpObzytvUD/gN3iD
	 Wu6GImlF9oQZWtr1knJV73+FipYiWjNTVKlBSWT4F7kHSuo2bguYgLMCsUF+Y///GS
	 ZaMOqHzybwRvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198F83924A7F;
	Fri,  4 Sep 2026 23:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: air_en8811h: refuse a firmware blob
 that is not a multiple of 4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856401464.1013351.9095804526644095350.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 23:20:14 +0000
References: <20260903123650.23855-1-f@lex.la>
In-Reply-To: <20260903123650.23855-1-f@lex.la>
To: Aleksei Sviridkin <f@lex.la>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ericwouds@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Sep 2026 12:36:50 +0000 you wrote:
> The download loop streams the blob into the MCU as 32-bit words and
> reads the last word past the end of a blob whose size is not a multiple
> of four. The shipped blobs happen to be aligned, so the overread never
> showed; a truncated or foreign file would carry up to three bytes of
> whatever follows it into the MCU. Reject it before the first write
> instead.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: air_en8811h: refuse a firmware blob that is not a multiple of 4
    https://git.kernel.org/netdev/net-next/c/daf0972d38e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


