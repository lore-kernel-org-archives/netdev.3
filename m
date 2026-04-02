Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050BF21773D;
	Thu,  2 Apr 2026 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100623; cv=none; b=KiV74bSB1UYZvFDWXU0M7+IIzGwz8OeH/bfQhdCG2Dy4/Fd+Zq9dnQj4Ce9fJWYtP3sZUbHxkd3KsXULjI0M1CFclI0iCaaZkoNi00VAU+B/Yhq23/NtpSPSaoTZ6+oPQZ6Cw6w+s/R/R+Lb76dmP5iP2SI0vO4+o1El/tpsLaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100623; c=relaxed/simple;
	bh=9fgfxHGvBZIq07MRUZR8GJsU2l1aH5ay0pKgQs/ybow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VeDmfKGKfQPTYdMO++R7lcTLUGAd2O1RTUZBWJdaQ/GPnHCI7tNgi6Qww2YIAXZUbfTuRgSC4BkcGkUcYk2kdXucMkv4QO1oLiR68tktgo0hyXMk+kzxylP06dXOZLHP4QgaL8zoW4m7O/B7lemIhM8YHXUSg+OKjUw32DPi9Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ezlf/nFN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ezlf/nFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E770C4CEF7;
	Thu,  2 Apr 2026 03:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775100622;
	bh=9fgfxHGvBZIq07MRUZR8GJsU2l1aH5ay0pKgQs/ybow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ezlf/nFNW1xBkwlS/tOKV8648orliI9baU+us/DOBiraA7RNIkmlRYnGWp0wFEKA6
	 jZ0SbMDwGJSHTeKODFwjR7a51tTwFVgbxOt/+Jas7rOHZaWCzq3FoULLipBJWXRFhc
	 hOrMOTCEVuIIRbFSXmpUKQwYdugXzmW/kti0L3Ec5Uq4XUx1g4V9u9O8edDR/h9D4F
	 ChMBxsn2brac/6lmbw4rdoOPkiazJDgILs5L2JNEDdHUufGHOMlBxhiWz2ny3cd4Ev
	 pFaECSDjb45k6B119UGa07ATSRy6bID3IZH8t5YEKl3ZqkkMyfff3Fbl68UqxwMb5f
	 hLpoMOTLbBBrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE193808203;
	Thu,  2 Apr 2026 03:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: macb: fix use of at91_default_usrio
 without
 CONFIG_OF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177510060529.3975901.11122963939632572331.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 03:30:05 +0000
References: <20260331-enroll-sensation-50901318a419@spud>
In-Reply-To: <20260331-enroll-sensation-50901318a419@spud>
To: Conor Dooley <conor@kernel.org>
Cc: netdev@vger.kernel.org, conor.dooley@microchip.com, lkp@intel.com,
 jiawenwu@trustnetic.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 31 Mar 2026 14:10:21 +0100 you wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> If CONFIG_OF is not enabled, at91_default_usrio is used undeclared in
> gem_default_config. Move at91_default_usrio back above the CONFIG_OF
> section where macb_default_usrio used to be, so that it is unconditionally
> defined and defined prior to any of the users.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: macb: fix use of at91_default_usrio without CONFIG_OF
    https://git.kernel.org/netdev/net-next/c/cee10a01e286

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


