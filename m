Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B12225788
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 01:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790645412; cv=none; b=Tr1bYwgr1PlJ4mWo4mJq3Iiwv6d5gPR4vwJC9WCwrn/RAtrKy1c11GlHaXDp6BVbRLWwe3D7I1Q/4S6Htlzbz1O6oI911rgyK65TsBswJrpH4m4x2F+Ldw5+lPBnsPmYK63eKAarcOjB1A5zjvirOHDR+ZsC2Q7TcvdgSCzQeVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790645412; c=relaxed/simple;
	bh=mMscyOMm6MSP/kYeT1nr9NuLti+Fslnn9YoadJxp4tc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gd6p7RpJHZjYCwD0p6s3iVt/kEPHivkQEJXxp79C7tL2ZCJ+vzTllxlO9akOiyInksKkU56NjUoGieAVToyD8YUL4MumJc8esmqZqY29eZm3rh0hjPuNmdxGNZPBIjKxAF0vBM5fVLxnHmFqQ5T0k6y9D8Vb9VPcnQPqdld+B60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoLXYCYz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoLXYCYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF2F1F000FF;
	Tue, 29 Sep 2026 01:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790645410;
	bh=x6ZAD+MbR3ivS/hFW5FO3d6cy7ssNb3Mekh6/7/HhBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PoLXYCYzDxSM8PCbJgw24S0f8vrJw2HZRU97SFlH+RCN2XEpGFC5IxnX+hZLC12ff
	 yFQ8oV6HVnK1QQ54s4mCEtaC7FGdNpefjmKJMYotqldHiESPrqXLzpr4rIzC/y+ODu
	 DrvFRNSx7BWwzJKMgz7Vnao+3/O9p/Y3Cn9vFCHJ/Quj43WQEpTKCd5qOg69Pm+bDZ
	 4rB4Tti39SstLA0CLDx94ObsOk3PE6xBlipDzpa1YHxtEbCNoI/kp+43GZwX7ehGac
	 F2evxY5lGaHXpd8XAF/8S9UWjedFmQhqAfcW3ZPabiwLEygOqQ7By+UEm1AHY6ZMYh
	 1ENhSP5t4omig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44703924FED;
	Tue, 29 Sep 2026 01:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl-gen-c: keep the type values of a nest
 in
 spec order
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179064540953.207932.6619783602064306487.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 01:30:09 +0000
References: <20260924223245.530132-1-kuba@kernel.org>
In-Reply-To: <20260924223245.530132-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 15:32:45 -0700 you wrote:
> Family._load_nested_set_nest() collects the type-value names of a
> nest-type-value attribute into a set and Struct.set_inherited() renders
> them sorted, while TypeNestTypeValue._attr_get() passes them to the
> parse helper in the order the spec lists them.  For nlctrl's
> 
>   type-value: [policy-id, attr-id]
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl-gen-c: keep the type values of a nest in spec order
    https://git.kernel.org/netdev/net-next/c/c20d84c6dec8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


