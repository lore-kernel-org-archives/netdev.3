Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEFB3DCDBC
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859684; cv=none; b=NEHfnYUZCAr6Hkk8UX4KpJqm2Iw0iYGXWUzmg4p8CtU0LAXbCFrqYdO/Yk+zd5gk+eg2Pig8XweEbrt1Ro0oCs044lidcTVZWPLtWj+P0nQ8fU9w+E0Xbj6TsB5OZubjBop7hB5z6eLPuWettjCcUR9AXlW8/ly9HDwYyn8R3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859684; c=relaxed/simple;
	bh=WGbAyeJffOnggdrIRI6e3K4GmVP0YSR+mBhj4yu3LN0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YZz5SSQzC/705C1wHVlYBSCA4W3cPeR47F57l2AA3lEnR4HevTtKnc/eH082i8G46cVE5S7YIUSaSxKDoaGv5F+c9Z0zCEglNiQxs9DSBRqZFUgsi+GQvrqZozAZKBc0Ouvs9oZFti5HFDEYFsLlT5hDZ272Zv9KruwOwE280/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awZImayC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awZImayC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58F11F00AC4;
	Thu, 27 Aug 2026 19:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787859682;
	bh=EOqJmzUNO+f2y4OAgKkkbT2cQuHfWvxShZyP6BvuX4A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=awZImayChP5j7f2Fi6tQXUsTAXyPZnM0jre5t1OiS2Z7Saz2QKC6dK2WN54/bBWS8
	 PXS+nkccjrqd6K255NZslwt8g2xfmh0U5Q9rdP1Uye3yqTJe7rQ8AGzh6xkraWC43O
	 IM/czwCBFsrdaUq9Hsbo9QXjfRukckqBbd6fsxrBhUD/DSFls4nYH8OG+p19KtcCuW
	 dmChCeH6nhkCCkwHe8yCBjJqfGhByg3XQTrcn/VvkAPA7pzEXb0pNEp4ARVXAkKZaW
	 VyWCJj/xheL7XmyM7gMrHvAvIMH/A6gS4UQOjCSklJXJBbHF1s85iqQ9KEGGL6fJzt
	 FHEELXmYKtnjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5689A3809A8D;
	Thu, 27 Aug 2026 19:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dsa: mxl862xx: enable assisted learning on
 CPU
 port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178785962789.1816627.5162200270683256068.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 19:40:27 +0000
References: 
 <DU0P251MB069949C6DEB4D1D51F31FE87C4A02@DU0P251MB0699.EURP251.PROD.OUTLOOK.COM>
In-Reply-To: 
 <DU0P251MB069949C6DEB4D1D51F31FE87C4A02@DU0P251MB0699.EURP251.PROD.OUTLOOK.COM>
To: Edoardo Pinci <epinci@outlook.com>
Cc: netdev@vger.kernel.org, daniel@makrotopia.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Aug 2026 15:11:43 +0200 you wrote:
> The MxL862xx driver enables FDB isolation but does not enable assisted
> learning on the CPU port. Consequently, MAC addresses learned through a
> physical switch port are not updated in hardware when the corresponding
> station moves to a foreign bridge port, such as a Wi-Fi interface.
> 
> The stale hardware FDB entry continues directing return traffic toward
> the original physical port. Traffic entering that same port is then
> filtered instead of being forwarded to the CPU and software bridge. This
> causes downstream unicast traffic, including DHCP OFFER and ACK packets,
> to disappear after a client roams to a local wireless interface. The
> client eventually considers the connection unusable and disconnects.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dsa: mxl862xx: enable assisted learning on CPU port
    https://git.kernel.org/netdev/net/c/88c71cc0ad98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


