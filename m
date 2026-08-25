Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9673019D8
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 04:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787631068; cv=none; b=XyMmdtc+KqnFmMHW18Dd2gGPZIQHOuOhmEyeTvpn/MNt4iKkAwnte2DaYr5ATJs0uWNxiT7aAyKUYsowNDGrr4oVt3SLj1u42eS7J5fXJhSjHSGXPtm0ZYL/v6wdBSO5MIazCRb2PDCsOQefd6rBbdXx4kc2FHta32R6Rhu9E7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787631068; c=relaxed/simple;
	bh=kuoAV96VTmxbFvYzknlCweTeI+ALZZFEwcgrpDoxh+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TVnfc8Rzqvw9M6yL3z6tszLboia0pslRdHjdQg3TzmLK1XQto44D4ulVYwAQf9ZZcCDozGOAbdn8V/x6wi/Z3UhgiKoNGm30HEQ6omxV2/4KVRzT8nSUTfk6HLiBD+nkd6SW4QX5RWoiEtquVsbTCPYoIkBmDAqHEvSd4XywN8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhCwqgW9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhCwqgW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265031F000E9;
	Tue, 25 Aug 2026 04:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787631067;
	bh=yWuDCoUlIunOyju5rhnBqNZERHQ5R8jkpu8ccu0lqDE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UhCwqgW9aIdIQsNSOVQv6YJHHpwJz8Mt7FIUuomTpiQNEU7A1uJ13+w9kig8FnWxs
	 DXaV8l5KbO/9iehcrbAcGgcCFqB9+IOCwyjAPat7INiANdcwOgFakv8DCaVjsGTNMr
	 RImnhVX1fuAVcp83am+PRRR4AT+gHPjKfJ1l53btrjawefqOq5GazK8coZiR7X7gXL
	 DY15Eip+47lMhKicykmHGrzNDAOoQt58/VPzZCGofjP+7U55LfP++ELL0TDro62nbZ
	 /McLZoxBWhYu3+5JoeYUzkGiOu5FXMQeTIBhZCozV6eA+3D5tiW0mwX3XDFWC55aU2
	 fIskQCfSWeU2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938C13924A47;
	Tue, 25 Aug 2026 04:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] iplink/can: fix format string warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178763101443.3232246.1856628471912212566.git-patchwork-notify@kernel.org>
Date: Tue, 25 Aug 2026 04:10:14 +0000
References: <20260824164922.575038-1-stephen@networkplumber.org>
In-Reply-To: <20260824164922.575038-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 24 Aug 2026 09:49:22 -0700 you wrote:
> Clang complains about non-literal format string
> 
>   iplink_can.c:531:36: warning: format string is not a string literal
>         [-Wformat-nonliteral]
>     531 |                 can_print_timing_min_max("tdcv", tdcv, *tdcv_min, *...
>         |                                                  ^~~~
> 
> [...]

Here is the summary with links:
  - [iproute2] iplink/can: fix format string warnings
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=4766edf1462e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


