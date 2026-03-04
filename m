Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C967B313E3F;
	Wed,  4 Mar 2026 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587834; cv=none; b=SctRdWkViu+aZ+3fB/l1BGi/MDchoAwBkreBUoDVhpzhd91sjnjPv/ewKDku+4AHaD/bpZG0/fU4oBA3XdBp5uJ9ykgPED8FWTg+uUJcgkt7T6B/0KTWvCfwD+VQscKWJRWd/H527Wl1a+U3T2I1GtRhxetZcOES1M5XtjigfZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587834; c=relaxed/simple;
	bh=zOiFfrg4DAb76yyAikCn7kXUvF81ROcdPtpojXr7afc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G0jXVTsxiVC3POS1AFJnXmxWEaqSK0HZHAdpHtxKTXUDwcatExEOzKq1zlIJd7+syLPQqDhSafYsxiF/26g9GmFCB/QZzcRshkWJxRdqpdb8jGZx89gXRPW1Jpm/h1R6lxhfTnwVf7HCAcMnSKgBMmVkPai9S6n7gHNcF2jB6Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYdSktFq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYdSktFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB892C116C6;
	Wed,  4 Mar 2026 01:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772587834;
	bh=zOiFfrg4DAb76yyAikCn7kXUvF81ROcdPtpojXr7afc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aYdSktFqIzS1PwCvS8Hp/CS1DdkYqqDEIQz4kXfg+LEtiroCPfhpA7CcQ1rfteCzs
	 Jk7fOrlwCBIOq7O+MsI/LmGdHlCE/ybdDA3KwonVt4t2iod2hGssePXCBpoTwxl8YD
	 ff/RY9rKs1S02c4U8zAwUrJQAacpVy87JH1DfeipOQjLms/tmEEt54F4SQ+ObLdkz7
	 p4UAUqUgR69TRu6POU4KlpFJ1Syl6x0Ii79AGoXREc+NasAOruzIC5kHxIFZRUlvJ1
	 nIgnQvGSYS/6qw+DezORXx2FfGMhN3a5HJsX1Mj2BwdshrWamtqDRoAMRCYggKJgIH
	 o71Gncvp7vCKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DD23808200;
	Wed,  4 Mar 2026 01:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: macb: use ethtool_sprintf to fill ethtool stats
 strings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177258783570.1546050.3870301624145396706.git-patchwork-notify@kernel.org>
Date: Wed, 04 Mar 2026 01:30:35 +0000
References: <20260302142931.49108-1-seanwascoding@gmail.com>
In-Reply-To: <20260302142931.49108-1-seanwascoding@gmail.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: andriy.shevchenko@intel.com, andrew@lunn.ch, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Mar 2026 22:29:31 +0800 you wrote:
> The RISC-V toolchain triggers a stringop-truncation warning when using
> snprintf() with a fixed ETH_GSTRING_LEN (32 bytes) buffer.
> 
> Convert the driver to use the modern ethtool_sprintf() API from
> linux/ethtool.h. This removes the need for manual snprintf() and
> memcpy() calls, handles the 32-byte padding automatically, and
> simplifies the logic by removing manual pointer arithmetic.
> 
> [...]

Here is the summary with links:
  - net: macb: use ethtool_sprintf to fill ethtool stats strings
    https://git.kernel.org/netdev/net-next/c/acd338ba2f3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


