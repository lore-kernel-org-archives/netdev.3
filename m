Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FCC1DEFE8
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780655; cv=none; b=LiT2FFzu8/lDdOzYMLSoaJ80DAWvnCqO3MvL+7CjXa/7msJ47YEcB2AWvDXmETiN/WDF0mhdNzNyeCWD+lZUTg3tFIj0c1ebjQiyGykAbRc7EjWx+X0Hud/JAKXUrAYNnj9eTUwNkOeCTJzdNgCudBFw8c4cOpJ5MdtXiuwLhLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780655; c=relaxed/simple;
	bh=SZ2yqFoTwVnuM3mIXr1gPDzDNGb3r5Ted5G7n/A4/Do=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AJEeNhQZkscQzVrwG5sf4vEo+f+m3n+b6/0Z9auaJ6Jc1sQVngKPxHe6+9v36F9kgyX6HSZU1Oihpo7lu5DSOK3hbz0ys0MTjB53QchKM2TN60YjoqJB7rohlrSmUg5cVeI577ELKHLjZ/LTvuGFGIxP0jCHq8YxOMc2YhRC3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfcabhNj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfcabhNj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA531F000E9;
	Mon,  3 Aug 2026 18:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785780654;
	bh=HFjBiWzDB2h2RJLthZ2Q7NxNHuao4ePfj9qbeNsq+f8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OfcabhNj8jxTylN86XIxfHKl7sKlK4q+YQ6fe75raED7fwubCS9venjQtc6syU8oJ
	 Fyj2JgqCZoEing3zFCLmvvZwMtIQEDM6R8kYeONjtjF5ExHNEI6kilKIp4YZq4dPPt
	 QSKxK8McPKjARZRCm3i2bLtwGANDA9geZEHNHYEEA67FyDlYPUKqMeIcin+meMxTLb
	 KQeKPymTcBqyWVvGH/w6vS1+eDf9wVTNwRztMyiXo7zcNZ+OCiyS3/0hDulZoGXB5Y
	 KfDZ8h38KkGpT0Yb3JYBt7qIXOx2cYR5kRFp2eFdPz57iluw/DvZzQa9cZtv/Eb7Qq
	 pFAK7Ndzx+K1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569D5380A963;
	Mon,  3 Aug 2026 18:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2 0/2] ip nexthop: support fdb destination
 port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178578061514.2763391.9165782985549600808.git-patchwork-notify@kernel.org>
Date: Mon, 03 Aug 2026 18:10:15 +0000
References: <20260723-b4-vxlan-fdb-port-iproute2-v2-0-9012ac01b49e@gmail.com>
In-Reply-To: <20260723-b4-vxlan-fdb-port-iproute2-v2-0-9012ac01b49e@gmail.com>
To: Jack Ma <jack4it@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
 kuba@kernel.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 23 Jul 2026 01:25:06 +0000 you wrote:
> Kernel side (net-next), which adds NHA_DST_PORT and is the reason for
> this change:
> 
>   net: nexthop: per-nexthop UDP dst port for fdb (VXLAN) nexthops
>   https://lore.kernel.org/netdev/20260723-b4-vxlan-fdb-port-v4-0-46e3a2dd88a3@gmail.com/
> 
> Signed-off-by: Jack Ma <jack4it@gmail.com>
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2,1/2] uapi: add NHA_DST_PORT
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=68f2b2cc05d3
  - [iproute2-next,v2,2/2] ip nexthop: support fdb destination port
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=ad2b2d95fd11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


