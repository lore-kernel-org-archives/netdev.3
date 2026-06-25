Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90353EB109;
	Thu, 25 Jun 2026 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404464; cv=none; b=f+qNGLPxSjLX17zUOmsPycCC9G8l1ZsCOhGSrsck+zI5FUjGPU6IdMBoNVPSuKK0+8AL93llJp9D/YCxd/GiG5G4DHVfnxBxkPjVNwhPlzu8WEhCyXjlFo9UXK/3HyJ96cF72MUESzZz0xx55crgawpKvzm6gAOotyyNplyiaZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404464; c=relaxed/simple;
	bh=xrLwSyXmtmsChkV0naETQN9onqnVo6oYYeqKKEOxBKQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fk9Ltts3Ti11HeYloeL5vgBlX2mCuy9xT9S6HHzq0niz9uOMFPoVN94W1mztYSNmdBueq5JRyhN6dlf8p9zkP/W/Z00SnCKIQ6pxLwvn1AoWWDUTC1Doq4xPA+HbadfjH382RGtQ6EhpEl6I46KoPT/9HWr0Ut7YaRE8RK2QqmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJSGwDNT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJSGwDNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0221F000E9;
	Thu, 25 Jun 2026 16:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404463;
	bh=P59ValBkQNzuvvptIgrf+qBNmqFCKZvDwNjf8Im7x5M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cJSGwDNT21U5KBgpUWXr42TaygGJ+W3tS2NkIfoe5FTfNAPykkYzY84HhmE1t7xn4
	 2HwvkkUPu6Ipg/UOYqVjO8jQzs99aUlqGYtVR1YdOy267hhY2Uh4U4puJTG/V4x8G5
	 wOBbqRVvaLUXrjI1m+sAPZJgvJJ/Xvlxwv5LXOO683kMqDHeRa+eyUGihz5GpkyA2R
	 IGKzifnCEdDzhUrFT+/rLYNQvL2tDOZQyMKtexkrClDFEFdCENQaVveVxALDrKMAR4
	 LVToPRDG7Mq3tcMgahQQZ3b/m2Reonqk3qmIVSNIFeuX/SVBcNl96iu4QagzyPQC4G
	 Pcm7eYo+I1J3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568F43AD449A;
	Thu, 25 Jun 2026 16:20:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: qualcomm: ppe: Demote from supported
 and
 fix maintainer addresses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178240445086.3803792.5981466761897195144.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 16:20:50 +0000
References: <20260623073307.36483-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260623073307.36483-2-krzysztof.kozlowski@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 bmasney@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jie.luo@oss.qualcomm.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 quic_leiwei@quicinc.com, quic_suruchia@quicinc.com, quic_pavir@quicinc.com,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jun 2026 09:33:08 +0200 you wrote:
> Emails to the maintainer of Qualcomm PPE Ethernet driver (Luo Jie
> <quic_luoj@quicinc.com>) bounce permanently (full mailbox), because the
> "quicinc.com" addresses were deprecated for public work.  All Qualcomm
> contributors are aware of that and were asked to fix their addresses.
> 
> Driver is not supported - in terms of how netdev understands supported
> commitment - if maintainer does not care to receive the patches for its
> code, so demote it to "maintained" to reflect true status.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: qualcomm: ppe: Demote from supported and fix maintainer addresses
    https://git.kernel.org/netdev/net/c/efd7fb21bad8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


