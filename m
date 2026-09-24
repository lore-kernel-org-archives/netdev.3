Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3970B3B9933
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215879; cv=none; b=VuToAa6hrJ+fhUMTT5BxFynAT7MbEG+QrHBUm1Aw1i/iRBHkZg34F56zR5vvHcFymtAq16q5hGN99w91LuyqyIygnw0Nv2NJUlD2318laNOoqrjm3kcWFGw8HsxWn9Vp6+j4AQVGKWJqCLIpT8PVl9dT8FuJnBvcLd4UbrX9ItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215879; c=relaxed/simple;
	bh=k5LNbfwnaoT/o6FwkDxkJtze8u3E5PPc7jEFcWHbtVE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nwILqtv2hHCmgRn7QT+rhI07l78lvZm9215WZfTF1AbZgYgQt94q68FMQRzhBAEOg5auHSc0pCw3TsAz/gayWN1ymEMG9tpWm1siRxfv+WXORVGoSJ0Je7bh3Xu0RNhvdhG25JNOjR3bHGY2vPqCA/LTjF2KYWdTx2k7RPbm0iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpfK5o/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpfK5o/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68071F00893;
	Thu, 24 Sep 2026 02:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790215877;
	bh=DA8BzAnXBt2iY/JTRdbyE2pmE7i/lIC3UK28AmHcIW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IpfK5o/bQOl2qmbK4jCi0AtQe1+TJ1Nl4EQvpc87ONrFS8yq5LprBySyUXQZNmnkV
	 ZoYaU7maGer/W50XwviZ/wdcUZcHg1oWVDEUQnjFBWifNDxr8u9+G9hfciIim8ttbW
	 qQbwAo+3C0GLsy48EaX8Z7hqQHwnNtmAUwiSRljCNCp33h4K54nQ5tCACrXWuJpBoJ
	 apNANU3P2Dxwnf9BI5jAQrT2kMjuIkCC04hAm36XxXFnIOiZ3Ja813GkwnSJ8SFW1F
	 4XhfMbVi6SADDYia7r4YIUFhh8GCLi5EsBelABh2t0Zs3ojrVTiC/fbPyvKhKq6c/j
	 +jrVjSVy2w+5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9386639E9611;
	Thu, 24 Sep 2026 02:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] tg3: use random MAC address when
 tg3_get_device_address fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021580715.1277764.2013199275415241729.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 02:10:07 +0000
References: <20260918224715.GA654128@visor>
In-Reply-To: <20260918224715.GA654128@visor>
To: Ivan Delalande <colona@arista.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 netdev@vger.kernel.org, paul.sage@42.fr, vinc@42.fr,
 atharvatiwarilinuxdev@gmail.com, michael.chan@broadcom.com,
 mchan@broadcom.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Sep 2026 15:47:15 -0700 you wrote:
> Some of the tg3 NICs we use (BCM57762) reset the SRAM MAC address to the
> placeholder address on link flaps, tg3_chip_reset, etc. We've typically
> fixed it from userspace, but since e4c00ba7274b ("tg3: replace
> placeholder MAC address with device property") was merged, tg3 just
> fails probe as we don't have a way to get it through the generic
> device_get_mac_address infrastructure as fallback on our systems.
> 
> [...]

Here is the summary with links:
  - [net,v4] tg3: use random MAC address when tg3_get_device_address fails
    https://git.kernel.org/netdev/net/c/4eb3f195ef08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


