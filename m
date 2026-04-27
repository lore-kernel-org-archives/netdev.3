Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819493A759D
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327308; cv=none; b=bhrV0X9PStXQuCxSEpZzsL2E1vkyniMQ9wcIsJ82WGrRsO9ARr78PZiF0nxwyTwhnUGlglxVxhFVChh7W3U7ryEgRX/BNA1eCmMa1yLu5lla1lZxSqXOw0W43TIBX02b/5T/5Ncx0Mtm5TJa+ADDOXmh4ONkQz76CSHadxUir4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327308; c=relaxed/simple;
	bh=an6MIwIWyyA/S9DORr55uwAp+W6WJyeL0HcFcwkk1sg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hzzkr2BceBngldqCU5FGtv7mNmvBfFN5MmMqfxappNfKW3RYvgdiOY9Kqm8YcwWW4MabEGaSmPNJX8vkkrmoXaR5oP4F+b0Ls11WB3KPag8/qZB3pkXOrY3bpF7n0B5JtBZESQ9qA3s60acNT6wsCY/EEByRApTTQnCROfEnbZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDYT49j3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDYT49j3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DE7C19425;
	Mon, 27 Apr 2026 22:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777327308;
	bh=an6MIwIWyyA/S9DORr55uwAp+W6WJyeL0HcFcwkk1sg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KDYT49j3tOSIUM3FSY1Out7tpuRw1O3B0WCTpTxhKLm4IweG/9bcuibykBMJUNOx3
	 SWUgH273WvJQM+4Vgg09bua5Fn6IzCiP/PV96pfhqWBgMzShYTEm3zBU2ief0qxm/g
	 vfkQ9w5ZyiVm2psk/FSr2bUxBFWqQA2JgBAxrb+vRHsUn27jr39ALIxY4K0rE3+W/y
	 /aBDn2uNu4NAozNvDy+KHVlkEWb/KSaByecbkAcXKFcCaolu1ezGgYBmHgoTaokq5X
	 r7UUVrck50XYErvUbIZBX9m6Zp7fhZF4+wbrnHmfAh7giE8sTBEKvjDc0KR4l18I+v
	 aW8DlrZi6rf2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FAE392FFCA;
	Mon, 27 Apr 2026 22:01:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] remove hamradio protocols
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177732726555.3977441.3975683153525543333.git-patchwork-notify@kernel.org>
Date: Mon, 27 Apr 2026 22:01:05 +0000
References: <20260424232427.792249-1-stephen@networkplumber.org>
In-Reply-To: <20260424232427.792249-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 24 Apr 2026 16:24:27 -0700 you wrote:
> The ax25, rose, and netrom have been removed upstream.
> Drop support for those protocols from iproute2.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  Makefile                  |   9 ---
>  include/uapi/linux/ax25.h | 117 --------------------------------------
>  include/uapi/linux/rose.h |  91 -----------------------------
>  include/utils.h           |   6 --
>  lib/ax25_ntop.c           |  82 --------------------------
>  lib/ll_addr.c             |   6 --
>  lib/netrom_ntop.c         |  23 --------
>  lib/rose_ntop.c           |  56 ------------------
>  8 files changed, 390 deletions(-)
>  delete mode 100644 include/uapi/linux/ax25.h
>  delete mode 100644 include/uapi/linux/rose.h
>  delete mode 100644 lib/ax25_ntop.c
>  delete mode 100644 lib/netrom_ntop.c
>  delete mode 100644 lib/rose_ntop.c

Here is the summary with links:
  - [iproute2] remove hamradio protocols
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=f46186fd0332

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


