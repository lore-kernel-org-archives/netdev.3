Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BD434AB19;
	Wed,  8 Apr 2026 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775611859; cv=none; b=V0ILkM8WOZ4plT3hIS4pwH+1P2YwkVN8XrKix1uN7cYH0RENh4QmopSuYj7LXeMjcuJ+Zmc6zf4FwFh7wonE+ME8B/Qw07SgXDXkeyi1TVYGk225z0AmbUERB5neibMjrrfKdkJGgyUexHGfZLMrO2epiF4CjukVNRaPfEfm2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775611859; c=relaxed/simple;
	bh=CmZPb7vFxIrmMQ/rUIO3y2Ha+q/NS6f746SXTbXVlFs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JjrTm/O0/5yBHq9tXt6qPqhNE2WUb74tlhNWjoJQnrgEurWWPke+ILCuUTxErDpjDA6Ig7i0MHdFbP67ir3C7d7xawq0oZQ5ydKC+icaOsrgdE/Yvd+mP9fUMs5eHpWvCJO9kEE7UCsOMe8nQ6pbaayuT1gnoKYmP/pi6mKKIsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZaYCp/S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZaYCp/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41950C19421;
	Wed,  8 Apr 2026 01:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775611859;
	bh=CmZPb7vFxIrmMQ/rUIO3y2Ha+q/NS6f746SXTbXVlFs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WZaYCp/SaKSSHZ0xnG0oqW3CJKj9BvYXeNGVd80zqrrulZDthHbA3l2MOK/36M+XI
	 /ElafttOhrEHbutQfEFOzOhuiH0jPoqoBzlkqjbbA17qFZb51seD4Oib3Jr3/pf0rc
	 njg/vpOQcUuUbfsBJuy2uh3TT/pcrWk9scuzY0FeB5F+6SIhwYX/sRFn3sCiCkcKRn
	 0waWfUkjGLlm6MRiJSd0Hz7+y2IJvKgMqknBdcmbI/UNJPn9g5hITQPtZpt+PcynNP
	 54BitS6dXF3+Le1JXOQ/ajO2SBRRVABLQZUlA83pp0r8BS+oTpVecirI0mVYBQq0xR
	 /6iqtLamKgifg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA00D3809A3D;
	Wed,  8 Apr 2026 01:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: sfp: add quirks for Hisense and HSGQ GPON ONT SFP
 modules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177561183629.28494.6162682994883134425.git-patchwork-notify@kernel.org>
Date: Wed, 08 Apr 2026 01:30:36 +0000
References: <20260406132321.72563-1-jspavlick@posteo.net>
In-Reply-To: <20260406132321.72563-1-jspavlick@posteo.net>
To: John Pavlick <jspavlick@posteo.net>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, marcin.nita@leolabs.pl

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 06 Apr 2026 13:23:33 +0000 you wrote:
> Several GPON ONT SFP sticks based on Realtek RTL960x report
> 1000BASE-LX at 1300MBd in their EEPROM but can operate at 2500base-X.
> On hosts capable of 2500base-X (e.g. Banana Pi R3 / MT7986), the
> kernel negotiates only 1G because it trusts the incorrect EEPROM data.
> 
> Add quirks for:
> - Hisense-Leox LXT-010S-H
> - Hisense ZNID-GPON-2311NA
> - HSGQ HSGQ-XPON-Stick
> 
> [...]

Here is the summary with links:
  - [v3] net: sfp: add quirks for Hisense and HSGQ GPON ONT SFP modules
    https://git.kernel.org/netdev/net/c/95aca8602ef7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


